def selects_the_titles_of_all_projects_and_their_pledge_amounts_alphabetized_by_title
  <<~SQL
    SELECT
      projects.title,
      SUM(pledges.amount)
    FROM 
      pledges
      INNER JOIN projects ON projects.id = pledges.project_id
    GROUP BY
      projects.title
    ORDER BY
      projects.title
  SQL
end

def selects_the_user_name_age_and_pledge_amount_for_all_pledges_alphabetized_by_name
  <<~SQL
    SELECT users.name, users.age, SUM(pledges.amount) FROM pledges 
    INNER JOIN users ON users.id = pledges.user_id 
    GROUP BY users.id
    ORDER BY users.name;
  SQL
end

def selects_the_titles_and_amount_over_goal_of_all_projects_that_have_met_their_funding_goal
  <<~SQL
    SELECT title, sum - goal AS overage FROM 
      (SELECT title, SUM(pledges.amount) AS sum, CAST(projects.funding_goal AS DECIMAL) AS goal
      FROM projects
      LEFT OUTER JOIN pledges
        ON pledges.project_id = projects.id
      GROUP BY projects.title) 
    WHERE sum >= goal;
  SQL
end

def selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_summed_amount
  <<~SQL
    SELECT users.name, SUM(pledges.amount)
    FROM users
    INNER JOIN pledges 
      ON users.id = pledges.user_id
    GROUP BY users.name 
    ORDER BY SUM(pledges.amount)
  SQL
end

def selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category
  <<~SQL
    SELECT projects.category, CAST(pledges.amount AS INT) as total
    FROM projects
    INNER JOIN pledges 
      ON projects.id = pledges.project_id
    WHERE projects.category = "music"
  SQL
end

def selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_books_category
  <<~SQL
    SELECT projects.category, SUM(CAST(pledges.amount AS INT)) as total
    FROM projects
    INNER JOIN pledges 
      ON projects.id = pledges.project_id
    WHERE projects.category = "books"
  SQL
end
