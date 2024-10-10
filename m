Return-Path: <linux-kernel+bounces-358322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2F997D28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6B1C21E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80971A072A;
	Thu, 10 Oct 2024 06:27:00 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EE63D5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541620; cv=none; b=Ifd4NUiCaEm0puHpVYwihz3QPwZT42VezlzskPr21uRKOWxtrbAS3Men7gjeHJpXEoAxPMkz0d54zv++nawPLNNXdldVlZ0yraTLuqshyax5BFIvyrhzxzwGjI/lYGKT7IUrmy+Kcgvdqx5Khz2k8/fBfGp+WbchHYCl+TvYrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541620; c=relaxed/simple;
	bh=pQdGKDEOj3rdEQsjz4akBzKgTlFN39RSscx++Z8hl8w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QiG/fXN+BmaIgTKxN+Q5MRvQktMJeany1tv8hhM0TfZTcU+5TdYFuO7FajDSJMcaKafjK03+CYnHFPJ81G6u0G2ccciFVfeLtBZR0aYH9g3I1gE3jT3yGwQx6hZEzXxeLpTv0IHIh8RYXK3oduJ2VXKq6ROTp1e31V3ReBP5B8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPKXx3Q1Xz2BdC3;
	Thu, 10 Oct 2024 14:26:57 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id D679D1400D2;
	Thu, 10 Oct 2024 14:26:52 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 14:26:52 +0800
Subject: Re: [patch 14/25] debugobjects: Move min/max count into pool struct
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.831908427@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <49a6cba8-d733-b3d1-26f4-3bc84d4212a2@huawei.com>
Date: Thu, 10 Oct 2024 14:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.831908427@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Having the accounting in the datastructure is better in terms of cache
> lines and allows more optimizations later on.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   55 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -46,9 +46,14 @@ struct debug_bucket {
>  struct obj_pool {
>  	struct hlist_head	objects;
>  	unsigned int		cnt;
> +	unsigned int		min_cnt;
> +	unsigned int		max_cnt;
>  } ____cacheline_aligned;
>  
> -static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
> +
> +static DEFINE_PER_CPU_ALIGNED(struct obj_pool, pool_pcpu)  = {
> +	.max_cnt	= ODEBUG_POOL_PERCPU_SIZE,
> +};
>  
>  static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
>  
> @@ -56,8 +61,14 @@ static struct debug_obj		obj_static_pool
>  
>  static DEFINE_RAW_SPINLOCK(pool_lock);
>  
> -static struct obj_pool		pool_global;
> -static struct obj_pool		pool_to_free;
> +static struct obj_pool pool_global = {
> +	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
> +	.max_cnt	= ODEBUG_POOL_SIZE,
> +};
> +
> +static struct obj_pool pool_to_free = {
> +	.max_cnt	= UINT_MAX,
> +};
>  
>  static HLIST_HEAD(pool_boot);
>  
> @@ -79,13 +90,9 @@ static int __data_racy			debug_objects_f
>  static int __data_racy			debug_objects_warnings __read_mostly;
>  static bool __data_racy			debug_objects_enabled __read_mostly
>  					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
> -static int				debug_objects_pool_size __ro_after_init
> -					= ODEBUG_POOL_SIZE;
> -static int				debug_objects_pool_min_level __ro_after_init
> -					= ODEBUG_POOL_MIN_LEVEL;
>  
> -static const struct debug_obj_descr *descr_test  __read_mostly;
> -static struct kmem_cache	*obj_cache __ro_after_init;
> +static const struct debug_obj_descr	*descr_test  __read_mostly;
> +static struct kmem_cache		*obj_cache __ro_after_init;
>  
>  /*
>   * Track numbers of kmem_cache_alloc()/free() calls done.
> @@ -124,14 +131,14 @@ static __always_inline unsigned int pool
>  	return READ_ONCE(pool->cnt);
>  }
>  
> -static inline bool pool_global_should_refill(void)
> +static __always_inline bool pool_should_refill(struct obj_pool *pool)
>  {
> -	return READ_ONCE(pool_global.cnt) < debug_objects_pool_min_level;
> +	return pool_count(pool) < pool->min_cnt;
>  }
>  
> -static inline bool pool_global_must_refill(void)
> +static __always_inline bool pool_must_refill(struct obj_pool *pool)
>  {
> -	return READ_ONCE(pool_global.cnt) < (debug_objects_pool_min_level / 2);
> +	return pool_count(pool) < pool->min_cnt / 2;
>  }
>  
>  static void free_object_list(struct hlist_head *head)
> @@ -178,7 +185,7 @@ static void fill_pool_from_freelist(void
>  	 * Recheck with the lock held as the worker thread might have
>  	 * won the race and freed the global free list already.
>  	 */
> -	while (pool_to_free.cnt && (pool_global.cnt < debug_objects_pool_min_level)) {
> +	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
>  		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
>  		hlist_del(&obj->node);
>  		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
> @@ -197,11 +204,11 @@ static void fill_pool(void)
>  	 *   - One other CPU is already allocating
>  	 *   - the global pool has not reached the critical level yet
>  	 */
> -	if (!pool_global_must_refill() && atomic_read(&cpus_allocating))
> +	if (!pool_must_refill(&pool_global) && atomic_read(&cpus_allocating))
>  		return;
>  
>  	atomic_inc(&cpus_allocating);
> -	while (pool_global_should_refill()) {
> +	while (pool_should_refill(&pool_global)) {
>  		struct debug_obj *new, *last = NULL;
>  		HLIST_HEAD(head);
>  		int cnt;
> @@ -337,7 +344,7 @@ static void free_obj_work(struct work_st
>  	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
>  		return;
>  
> -	if (pool_global.cnt >= debug_objects_pool_size)
> +	if (pool_global.cnt >= pool_global.max_cnt)
>  		goto free_objs;
>  
>  	/*
> @@ -347,7 +354,7 @@ static void free_obj_work(struct work_st
>  	 * may be gearing up to use more and more objects, don't free any
>  	 * of them until the next round.
>  	 */
> -	while (pool_to_free.cnt && pool_global.cnt < debug_objects_pool_size) {
> +	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
>  		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
>  		hlist_del(&obj->node);
>  		hlist_add_head(&obj->node, &pool_global.objects);
> @@ -408,7 +415,7 @@ static void __free_object(struct debug_o
>  	}
>  
>  	raw_spin_lock(&pool_lock);
> -	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
> +	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
>  	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
>  	obj_pool_used--;
>  
> @@ -424,7 +431,7 @@ static void __free_object(struct debug_o
>  			}
>  		}
>  
> -		if ((pool_global.cnt > debug_objects_pool_size) &&
> +		if ((pool_global.cnt > pool_global.max_cnt) &&
>  		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
>  			int i;
>  
> @@ -629,13 +636,13 @@ static void debug_objects_fill_pool(void
>  	if (unlikely(!obj_cache))
>  		return;
>  
> -	if (likely(!pool_global_should_refill()))
> +	if (likely(!pool_should_refill(&pool_global)))
>  		return;
>  
>  	/* Try reusing objects from obj_to_free_list */
>  	fill_pool_from_freelist();
>  
> -	if (likely(!pool_global_should_refill()))
> +	if (likely(!pool_should_refill(&pool_global)))
>  		return;
>  
>  	/*
> @@ -1427,8 +1434,8 @@ void __init debug_objects_mem_init(void)
>  	 * system.
>  	 */
>  	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
> -	debug_objects_pool_size += extras;
> -	debug_objects_pool_min_level += extras;
> +	pool_global.max_cnt += extras;
> +	pool_global.min_cnt += extras;
>  
>  	/* Everything worked. Expose the cache */
>  	obj_cache = cache;
> 
> .
> 

-- 
Regards,
  Zhen Lei

