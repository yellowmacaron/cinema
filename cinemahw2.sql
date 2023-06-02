-- 1. GET TOP 3 FILMS that HAVE THE MOST BOOKING

SELECT film.name ,count(*) as total_booking
from film join screening on film.id=screening.film_id
join booking on booking.id=screening.id
group by film.name
ORDER BY total_booking DESC
LIMIT 3;

-- 2. GET FILMS THAT ARE LONGER THAN AVG LENGTH
SELECT *
from film where film.length_min > (SELECT AVG(film.length_min) FROM film);

-- 3. ROOM THAT HAS HIGHEST AND LOWEST SCREENING

select room.name, count(*) as total_screening
from screening join room on screening.room_id=room.id
group by room_id
having total_screening=(
	SELECT count(*) as total_screening
	from screening
	group by room_id
	order by total_screening desc
	limit 1)

union all (select room.name,count(*) as total_screening
from screening join room on screening.room_id=room.id
group by room_id
having total_screening=(
	SELECT count(*) as total_screening
	from screening
	group by room_id
	order by total_screening asc
	limit 1)
    );


-- 4. GET NUMBER OF BOOKING OF EACH ROOM OF TOM JERRY
select room.id,room.name,film.name,count(*) as total_room_booking
from room 
join screening on room.id=screening.room_id
join booking on booking.screening_id=screening.id
join film on film.id=screening.film_id
where film.name='Tom&Jerry'
group by room_id;

-- 5. WHAT SEAT IS BEING BOOKED THE MOST
SELECT seat.*, COUNT(*) as total_seat_booked
FROM reserved_seat
JOIN seat ON reserved_seat.seat_id = seat.id
GROUP BY seat.id
HAVING total_seat_booked =
	(SELECT COUNT(*) total_seat_booked
	FROM reserved_seat JOIN seat ON reserved_seat.seat_id = seat.id
	GROUP BY seat.id
	ORDER BY total_seat_booked DESC
	LIMIT 1);

-- 6. WHAT SCREEN HAS THE MOST SCREENING SCHEDULE
SELECT film_id,film.name,count(*) as total_screening
FROM film 
JOIN screening ON screening.film_id=film.id 
group by film_id
having total_screening=
(select count(*) as total_screening
FROM film JOIN screening ON screening.film_id=film.id 
group by film_id
ORDER BY total_screening DESC
LIMIT 1);

-- 7. WHAT DATE has the most screening 

SELECT date(start_time),count(*) as total_sccreening
FROM screening group by date(start_time)
having total_sccreening=(SELECT count(*) as total_sccreening
FROM screening group by date(start_time)
ORDER BY total_sccreening DESC
LIMIT 1);

-- 8.Show film in May-2022
SELECT distinct film.*
FROM film JOIN screening on film.id=screening.film_id
WHERE YEAR(start_time)=2022 AND month(start_time)=5;

-- 9. SHOW FILM where name end with 'n'
SELECT * 
from film where name like '%n';

-- 10. Show customer name but just show first 3 characters AND last 3 characters in UPPERCASE
SELECT UPPER(substring(first_name,1,3)) ,UPPER(RIGHT(last_name,3))
from customer ;

-- 11.FILMS LONGER THAN 2 HRS
SELECT * 
from film where length_min>120;