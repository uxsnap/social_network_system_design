// Определяем ENUM типы
Enum entity_type {
  post
  comment
  place
}

Enum media_type {
  image
}

Table users {
  id uuid [primary key]
  username varchar
  email varchar
  created_at timestamp
  updated_at timestamp
  
  indexes {
    username
    email
  }
}

Table places {
  id uuid [primary key]
  name varchar
  description text
  location varchar
  popularity_score float
  lat decimal(9, 6)
  lng decimal(9, 6)
  created_at timestamp
  updated_at timestamp
  
  indexes {
    (lat, lng)
    name
    popularity_score
  }
}

Table posts {
  id uuid [primary key]
  user_id uuid [ref: > users.id]
  place_id uuid [ref: > places.id]
  description text
  created_at timestamp
  updated_at timestamp
  
  indexes {
    user_id
    place_id
    created_at
  }
}

Table comments {
  id uuid [primary key]
  post_id uuid [ref: > posts.id]
  user_id uuid [ref: > users.id]
  text text
  created_at timestamp
  updated_at timestamp
  
  indexes {
    post_id
    user_id
    created_at
  }
}

Table media {
  id uuid [primary key]
  entity_type entity_type
  entity_id uuid
  media_url varchar
  media_type media_type
  created_at timestamp
  
  indexes {
    (entity_type, entity_id)
    entity_id
  }
}

Table likes {
  id uuid [primary key]
  entity_type entity_type
  entity_id uuid
  user_id uuid [ref: > users.id]
  is_active boolean [default: true]
  created_at timestamp
  
  indexes {
    (entity_type, entity_id, is_active) // where is_active = true
    (user_id, entity_type, entity_id) [unique]
    (user_id, is_active)
  }
}

Table subscriptions {
  id uuid [primary key]
  subscriber_id uuid [ref: > users.id]
  target_user_id uuid [ref: > users.id]
  
  indexes {
    subscriber_id
    target_user_id
    (subscriber_id, target_user_id) [unique]
  }
}