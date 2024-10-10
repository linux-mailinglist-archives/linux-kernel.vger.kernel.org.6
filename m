Return-Path: <linux-kernel+bounces-358209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E59997B77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05421281AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFEF18BBA9;
	Thu, 10 Oct 2024 03:47:20 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC018C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532039; cv=none; b=MIac4ZYVNSpiOP6+NlCesSy/m6YQJCwzubkiK3hSmS1JoH+X9g6XtUFmNDOLX8YTSfzmHfYZaZIRjP09/TkaFLII010pOmdElkxQ27xo27vS9PPnyYcpXy3cvjlA9XPB1nhEr0Ije2vLiZP7/pKiF52dW5uuOBc53B6PCj3ZcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532039; c=relaxed/simple;
	bh=hZwBjM7skvQQPUzTYcFTFDBym4QKLVYgWtE+8HqR3Nk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FSawg0eUtzHDjH79mVKOZY4OI9G3JYG8NargQvlK1j/aSD0iaGMKcCCV/EbKcNz48wtmbs/iafYmTp9mBGjSHYgaVAFWFAmUyBJ6/lVehe6cVShMHtifYbdbSMMmThfRF/AiODd0xcGDcp4l0sboO9ObzUVvAUY4o4ZDH6d6mas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPG0d0VMJz28fRJ;
	Thu, 10 Oct 2024 11:47:13 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 779B11401E9;
	Thu, 10 Oct 2024 11:47:08 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:47:08 +0800
Subject: Re: [patch 11/25] debugobjects: Move pools into a datastructure
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.646171170@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5ecc499c-a07b-f4f2-fb81-f47e21217a54@huawei.com>
Date: Thu, 10 Oct 2024 11:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.646171170@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> The contention on the global pool lock can be reduced by strict batch
> processing where batches of objects are moved from one list head to another
> instead of moving them object by object. This also reduces the cache
> footprint because it avoids the list walk and dirties at maximum three
> cache lines instead of potentially up to eighteen.
> 
> To prepare for that, move the hlist head and related counters into a
> struct.
> 
> No functional change.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |  140 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 78 insertions(+), 62 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -52,6 +52,11 @@ struct debug_percpu_free {
>  	int			obj_free;
>  };
>  
> +struct obj_pool {
> +	struct hlist_head	objects;
> +	unsigned int		cnt;
> +} ____cacheline_aligned;
> +
>  static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
>  
>  static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
> @@ -60,8 +65,8 @@ static struct debug_obj		obj_static_pool
>  
>  static DEFINE_RAW_SPINLOCK(pool_lock);
>  
> -static HLIST_HEAD(obj_pool);
> -static HLIST_HEAD(obj_to_free);
> +static struct obj_pool		pool_global;
> +static struct obj_pool		pool_to_free;
>  
>  /*
>   * Because of the presence of percpu free pools, obj_pool_free will
> @@ -71,12 +76,9 @@ static HLIST_HEAD(obj_to_free);
>   * can be off.
>   */
>  static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
> -static int __data_racy		obj_pool_free = ODEBUG_POOL_SIZE;
>  static int			obj_pool_used;
>  static int __data_racy		obj_pool_max_used;
>  static bool			obj_freeing;
> -/* The number of objs on the global free list */
> -static int			obj_nr_tofree;
>  
>  static int __data_racy			debug_objects_maxchain __read_mostly;
>  static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
> @@ -124,6 +126,21 @@ static const char *obj_states[ODEBUG_STA
>  	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
>  };
>  
> +static __always_inline unsigned int pool_count(struct obj_pool *pool)
> +{
> +	return READ_ONCE(pool->cnt);
> +}
> +
> +static inline bool pool_global_should_refill(void)
> +{
> +	return READ_ONCE(pool_global.cnt) < debug_objects_pool_min_level;
> +}
> +
> +static inline bool pool_global_must_refill(void)
> +{
> +	return READ_ONCE(pool_global.cnt) < (debug_objects_pool_min_level / 2);
> +}
> +
>  static void free_object_list(struct hlist_head *head)
>  {
>  	struct hlist_node *tmp;
> @@ -146,11 +163,8 @@ static void fill_pool_from_freelist(void
>  	/*
>  	 * Reuse objs from the global obj_to_free list; they will be
>  	 * reinitialized when allocating.
> -	 *
> -	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
> -	 * the WRITE_ONCE() in pool_lock critical sections.
>  	 */
> -	if (!READ_ONCE(obj_nr_tofree))
> +	if (!pool_count(&pool_to_free))
>  		return;
>  
>  	/*
> @@ -171,12 +185,12 @@ static void fill_pool_from_freelist(void
>  	 * Recheck with the lock held as the worker thread might have
>  	 * won the race and freed the global free list already.
>  	 */
> -	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
> -		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> +	while (pool_to_free.cnt && (pool_global.cnt < debug_objects_pool_min_level)) {
> +		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
>  		hlist_del(&obj->node);
> -		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
> -		hlist_add_head(&obj->node, &obj_pool);
> -		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
> +		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
> +		hlist_add_head(&obj->node, &pool_global.objects);
> +		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
>  	}
>  	clear_bit(0, &state);
>  }
> @@ -190,12 +204,11 @@ static void fill_pool(void)
>  	 *   - One other CPU is already allocating
>  	 *   - the global pool has not reached the critical level yet
>  	 */
> -	if (READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2) &&
> -	    atomic_read(&cpus_allocating))
> +	if (!pool_global_must_refill() && atomic_read(&cpus_allocating))
>  		return;
>  
>  	atomic_inc(&cpus_allocating);
> -	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
> +	while (pool_global_should_refill()) {
>  		struct debug_obj *new, *last = NULL;
>  		HLIST_HEAD(head);
>  		int cnt;
> @@ -212,9 +225,9 @@ static void fill_pool(void)
>  			break;
>  
>  		guard(raw_spinlock_irqsave)(&pool_lock);
> -		hlist_splice_init(&head, &last->node, &obj_pool);
> +		hlist_splice_init(&head, &last->node, &pool_global.objects);
>  		debug_objects_allocated += cnt;
> -		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
> +		WRITE_ONCE(pool_global.cnt, pool_global.cnt + cnt);
>  	}
>  	atomic_dec(&cpus_allocating);
>  }
> @@ -268,10 +281,10 @@ alloc_object(void *addr, struct debug_bu
>  	}
>  
>  	raw_spin_lock(&pool_lock);
> -	obj = __alloc_object(&obj_pool);
> +	obj = __alloc_object(&pool_global.objects);
>  	if (obj) {
>  		obj_pool_used++;
> -		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
> +		WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
>  
>  		/*
>  		 * Looking ahead, allocate one batch of debug objects and
> @@ -283,22 +296,21 @@ alloc_object(void *addr, struct debug_bu
>  			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
>  				struct debug_obj *obj2;
>  
> -				obj2 = __alloc_object(&obj_pool);
> +				obj2 = __alloc_object(&pool_global.objects);
>  				if (!obj2)
>  					break;
> -				hlist_add_head(&obj2->node,
> -					       &percpu_pool->free_objs);
> +				hlist_add_head(&obj2->node, &percpu_pool->free_objs);
>  				percpu_pool->obj_free++;
>  				obj_pool_used++;
> -				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
> +				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
>  			}
>  		}
>  
>  		if (obj_pool_used > obj_pool_max_used)
>  			obj_pool_max_used = obj_pool_used;
>  
> -		if (obj_pool_free < obj_pool_min_free)
> -			obj_pool_min_free = obj_pool_free;
> +		if (pool_global.cnt < obj_pool_min_free)
> +			obj_pool_min_free = pool_global.cnt;
>  	}
>  	raw_spin_unlock(&pool_lock);
>  
> @@ -329,7 +341,7 @@ static void free_obj_work(struct work_st
>  	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
>  		return;
>  
> -	if (obj_pool_free >= debug_objects_pool_size)
> +	if (pool_global.cnt >= debug_objects_pool_size)
>  		goto free_objs;
>  
>  	/*
> @@ -339,12 +351,12 @@ static void free_obj_work(struct work_st
>  	 * may be gearing up to use more and more objects, don't free any
>  	 * of them until the next round.
>  	 */
> -	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
> -		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> +	while (pool_to_free.cnt && pool_global.cnt < debug_objects_pool_size) {
> +		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
>  		hlist_del(&obj->node);
> -		hlist_add_head(&obj->node, &obj_pool);
> -		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
> -		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
> +		hlist_add_head(&obj->node, &pool_global.objects);
> +		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
> +		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
>  	}
>  	raw_spin_unlock_irqrestore(&pool_lock, flags);
>  	return;
> @@ -355,9 +367,9 @@ static void free_obj_work(struct work_st
>  	 * list. Move remaining free objs to a temporary list to free the
>  	 * memory outside the pool_lock held region.
>  	 */
> -	if (obj_nr_tofree) {
> -		hlist_move_list(&obj_to_free, &tofree);
> -		WRITE_ONCE(obj_nr_tofree, 0);
> +	if (pool_to_free.cnt) {
> +		hlist_move_list(&pool_to_free.objects, &tofree);
> +		WRITE_ONCE(pool_to_free.cnt, 0);
>  	}
>  	raw_spin_unlock_irqrestore(&pool_lock, flags);
>  
> @@ -400,45 +412,45 @@ static void __free_object(struct debug_o
>  
>  free_to_obj_pool:
>  	raw_spin_lock(&pool_lock);
> -	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
> -	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
> +	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
> +	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
>  	obj_pool_used--;
>  
>  	if (work) {
> -		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
> -		hlist_add_head(&obj->node, &obj_to_free);
> +		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
> +		hlist_add_head(&obj->node, &pool_to_free.objects);
>  		if (lookahead_count) {
> -			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
> +			WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + lookahead_count);
>  			obj_pool_used -= lookahead_count;
>  			while (lookahead_count) {
>  				hlist_add_head(&objs[--lookahead_count]->node,
> -					       &obj_to_free);
> +					       &pool_to_free.objects);
>  			}
>  		}
>  
> -		if ((obj_pool_free > debug_objects_pool_size) &&
> -		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
> +		if ((pool_global.cnt > debug_objects_pool_size) &&
> +		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
>  			int i;
>  
>  			/*
>  			 * Free one more batch of objects from obj_pool.
>  			 */
>  			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
> -				obj = __alloc_object(&obj_pool);
> -				hlist_add_head(&obj->node, &obj_to_free);
> -				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
> -				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
> +				obj = __alloc_object(&pool_global.objects);
> +				hlist_add_head(&obj->node, &pool_to_free.objects);
> +				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
> +				WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
>  			}
>  		}
>  	} else {
> -		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
> -		hlist_add_head(&obj->node, &obj_pool);
> +		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
> +		hlist_add_head(&obj->node, &pool_global.objects);
>  		if (lookahead_count) {
> -			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
> +			WRITE_ONCE(pool_global.cnt, pool_global.cnt + lookahead_count);
>  			obj_pool_used -= lookahead_count;
>  			while (lookahead_count) {
>  				hlist_add_head(&objs[--lookahead_count]->node,
> -					       &obj_pool);
> +					       &pool_global.objects);
>  			}
>  		}
>  	}
> @@ -453,7 +465,7 @@ static void __free_object(struct debug_o
>  static void free_object(struct debug_obj *obj)
>  {
>  	__free_object(obj);
> -	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
> +	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
>  		WRITE_ONCE(obj_freeing, true);
>  		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
>  	}
> @@ -622,13 +634,13 @@ static void debug_objects_fill_pool(void
>  	if (unlikely(!obj_cache))
>  		return;
>  
> -	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
> +	if (likely(!pool_global_should_refill()))
>  		return;
>  
>  	/* Try reusing objects from obj_to_free_list */
>  	fill_pool_from_freelist();
>  
> -	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
> +	if (likely(!pool_global_should_refill()))
>  		return;
>  
>  	/*
> @@ -1040,7 +1052,7 @@ static void __debug_check_no_obj_freed(c
>  		debug_objects_maxchecked = objs_checked;
>  
>  	/* Schedule work to actually kmem_cache_free() objects */
> -	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
> +	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
>  		WRITE_ONCE(obj_freeing, true);
>  		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
>  	}
> @@ -1066,12 +1078,12 @@ static int debug_stats_show(struct seq_f
>  	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
>  	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
>  	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
> -	seq_printf(m, "pool_free     :%d\n", READ_ONCE(obj_pool_free) + obj_percpu_free);
> +	seq_printf(m, "pool_free     :%d\n", pool_count(&pool_global) + obj_percpu_free);
>  	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
>  	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
>  	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
>  	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
> -	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(obj_nr_tofree));
> +	seq_printf(m, "on_free_list  :%d\n", pool_count(&pool_to_free));
>  	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
>  	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
>  	return 0;
> @@ -1330,7 +1342,9 @@ void __init debug_objects_early_init(voi
>  		raw_spin_lock_init(&obj_hash[i].lock);
>  
>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
> -		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
> +		hlist_add_head(&obj_static_pool[i].node, &pool_global.objects);
> +
> +	pool_global.cnt = ODEBUG_POOL_SIZE;
>  }
>  
>  /*
> @@ -1354,21 +1368,23 @@ static bool __init debug_objects_replace
>  		hlist_add_head(&obj->node, &objects);
>  	}
>  
> -	debug_objects_allocated += i;
> +	debug_objects_allocated = ODEBUG_POOL_SIZE;
> +	pool_global.cnt = ODEBUG_POOL_SIZE;
>  
>  	/*
>  	 * Replace the statically allocated objects list with the allocated
>  	 * objects list.
>  	 */
> -	hlist_move_list(&objects, &obj_pool);
> +	hlist_move_list(&objects, &pool_global.objects);
>  
>  	/* Replace the active object references */
>  	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
>  		hlist_move_list(&db->list, &objects);
>  
>  		hlist_for_each_entry(obj, &objects, node) {
> -			new = hlist_entry(obj_pool.first, typeof(*obj), node);
> +			new = hlist_entry(pool_global.objects.first, typeof(*obj), node);
>  			hlist_del(&new->node);
> +			pool_global.cnt--;
>  			/* copy object data */
>  			*new = *obj;
>  			hlist_add_head(&new->node, &db->list);
> 
> .
> 

-- 
Regards,
  Zhen Lei

