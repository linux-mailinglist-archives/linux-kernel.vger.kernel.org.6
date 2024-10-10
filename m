Return-Path: <linux-kernel+bounces-359090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778C99874B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D32CB22CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA651C9B6D;
	Thu, 10 Oct 2024 13:13:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72941C6F45
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566010; cv=none; b=ET69uGFA2YVBgX37zCHiXMSGQ03ONv6SOc2YdI5ait6sYNQiKb4csjAV1c5IgF62yRb+7tZbTV9hzR76Ah58ymlTOGy0hkFjZ1Lf0vqe49T5YWfizNQv0aRYRr6YxX+Kn59drD5ZgkjWJli7+xH4JmKTzfkI60w7yFHhNq9WFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566010; c=relaxed/simple;
	bh=xySknGjOitiCXj8PN3FGUCdstsODWe3lb+upFXG1Zz4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OVjn0y0kphl4kF/1UVEpLhUHdmfZ2GB7PWyZfrjklb/2HANK0QRVamGHq88IIiDepYZgMVvVGGnsWutLL5Tr+L3zHzabUAWYNI4UOXedQPhPxZHLp5GnR+3vsUCDSQswB4B3Qkp7MmtsqS9o918BAWTiBjHfcstYH1Jb03ifbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPVW81PDvzfdCb;
	Thu, 10 Oct 2024 21:11:00 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7706A18010F;
	Thu, 10 Oct 2024 21:13:24 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 21:13:24 +0800
Subject: Re: [patch 25/25] debugobjects: Track object usage to avoid premature
 freeing of objects
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.499184215@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <33d4dca7-3a1b-c99d-7e76-160a5fca61c2@huawei.com>
Date: Thu, 10 Oct 2024 21:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.499184215@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> The freelist is freed at a constant rate independent of the actual usage
> requirements. That's bad in scenarios where usage comes in bursts. The end
> of a burst puts the object on the free list and freeing proceeds even when
> the next burst which requires objects started again.
> 
> Keep track of the usage with a exponentially wheighted moving average and
> take that into account in the worker function which frees objects from the
> free list.
> 
> This further reduces the kmem_cache allocation/free rate for a full kernel
> compile:
> 
>    	    kmem_cache_alloc()	kmem_cache_free()
> Baseline:   225k		245k
> Usage:	    170k		117k
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -13,6 +13,7 @@
>  #include <linux/hash.h>
>  #include <linux/kmemleak.h>
>  #include <linux/sched.h>
> +#include <linux/sched/loadavg.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -86,6 +87,7 @@ static struct obj_pool pool_to_free = {
>  
>  static HLIST_HEAD(pool_boot);
>  
> +static unsigned long		avg_usage;
>  static bool			obj_freeing;
>  
>  static int __data_racy			debug_objects_maxchain __read_mostly;
> @@ -382,11 +384,28 @@ static bool kmem_alloc_batch(struct hlis
>  	return true;
>  }
>  
> +static bool pool_can_fill(struct obj_pool *dst, struct obj_pool *src)
> +{
> +	unsigned int cnt = pool_count(dst);
> +
> +	if (cnt >= dst->min_cnt)
> +		return true;

There's already an interception in function debug_objects_fill_pool().
It's unlikely to be true.

debug_objects_fill_pool() --> fill_pool() --> pool_can_fill()
:
	if (likely(!pool_should_refill(&pool_global)))
		return;

> +
> +	return READ_ONCE(src->cnt) >= cnt - dst->min_cnt;

I don't understand. However, similar to above, fill_pool_from_freelist() has
been called before fill_pool() is called.

> +}
> +
>  static void fill_pool(void)
>  {
>  	static atomic_t cpus_allocating;
>  
>  	/*
> +	 * If the free pool has enough capacity, then don't try allocating
> +	 * unless the global pool has reached the cricital level.
> +	 */
> +	if (!pool_must_refill(&pool_global) && pool_can_fill(&pool_global, &pool_to_free))
> +		return;

As above, this code seems unnecessary.

> +
> +	/*
>  	 * Avoid allocation and lock contention when:
>  	 *   - One other CPU is already allocating
>  	 *   - the global pool has not reached the critical level yet
> @@ -427,11 +446,31 @@ static struct debug_obj *lookup_object(v
>  	return NULL;
>  }
>  
> +static void calc_usage(void)
> +{
> +	static DEFINE_RAW_SPINLOCK(avg_lock);
> +	static unsigned long avg_period;
> +	unsigned long cur, now = jiffies;
> +
> +	if (!time_after_eq(now, READ_ONCE(avg_period)))
> +		return;
> +
> +	if (!raw_spin_trylock(&avg_lock))
> +		return;
> +
> +	WRITE_ONCE(avg_period, now + msecs_to_jiffies(10));
> +	cur = READ_ONCE(pool_global.stats.cur_used) * ODEBUG_FREE_WORK_MAX;
> +	WRITE_ONCE(avg_usage, calc_load(avg_usage, EXP_5, cur));
> +	raw_spin_unlock(&avg_lock);
> +}
> +
>  static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
>  				      const struct debug_obj_descr *descr)
>  {
>  	struct debug_obj *obj;
>  
> +	calc_usage();
> +
>  	if (static_branch_likely(&obj_cache_enabled))
>  		obj = pcpu_alloc();
>  	else
> @@ -450,14 +489,26 @@ static struct debug_obj *alloc_object(vo
>  /* workqueue function to free objects. */
>  static void free_obj_work(struct work_struct *work)
>  {
> -	bool free = true;
> +	static unsigned long last_use_avg;
> +	unsigned long cur_used, last_used, delta;
> +	unsigned int max_free = 0;
>  
>  	WRITE_ONCE(obj_freeing, false);
>  
> +	/* Rate limit freeing based on current use average */
> +	cur_used = READ_ONCE(avg_usage);
> +	last_used = last_use_avg;
> +	last_use_avg = cur_used;
> +
>  	if (!pool_count(&pool_to_free))
>  		return;
>  
> -	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
> +	if (cur_used <= last_used) {
> +		delta = (last_used - cur_used) / ODEBUG_FREE_WORK_MAX;
> +		max_free = min(delta, ODEBUG_FREE_WORK_MAX);
> +	}
> +
> +	for (int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
>  		HLIST_HEAD(tofree);
>  
>  		/* Acquire and drop the lock for each batch */
> @@ -468,9 +519,10 @@ static void free_obj_work(struct work_st
>  			/* Refill the global pool if possible */
>  			if (pool_move_batch(&pool_global, &pool_to_free)) {
>  				/* Don't free as there seems to be demand */
> -				free = false;
> -			} else if (free) {
> +				max_free = 0;
> +			} else if (max_free) {
>  				pool_pop_batch(&tofree, &pool_to_free);
> +				max_free--;
>  			} else {
>  				return;
>  			}
> @@ -1110,7 +1162,7 @@ static int debug_stats_show(struct seq_f
>  	for_each_possible_cpu(cpu)
>  		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
>  
> -	pool_used = data_race(pool_global.stats.cur_used);
> +	pool_used = READ_ONCE(pool_global.stats.cur_used);
>  	pcp_free = min(pool_used, pcp_free);
>  	pool_used -= pcp_free;
>  
> 
> .
> 

-- 
Regards,
  Zhen Lei

