Return-Path: <linux-kernel+bounces-321526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE37971BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F41F24325
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CA1BAEF3;
	Mon,  9 Sep 2024 13:51:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E31BA28F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889908; cv=none; b=gDxzd7WWsZWIHLCWSxEVKnm0skbN9zCTzaYkpzOgx39IwY6ulRFeVmOP4HiBar/vEZ00pCC3SA7aSCcx43t5esXjUuO5HRmMb/cDtn97kAMgDdrvjEfeQclZ9i5WM5/iCAjtSjDgROvT62nHFEq6e3L8hnjGWkJZiRNKbXYiMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889908; c=relaxed/simple;
	bh=jSlSEWw5SA2Xl/21zpZ93/2yeRbgqUqz9Uk8Ns7dM1g=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LNXs1JM4Nkx8jbpgP9WPBy6etn28aVwoRD1hq7PvntaCuPxr647fvwFaoT56QCsNzNcH+vUY49S8FzK9X0MbyqGkV4nYbBKmPN9Z3YEMtrGq56WwMrpa8rraiBAv0/KJSCZW+aLrUxxMEDeYMA7m9KY84vmhF7yDMp5zCh+75FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2Ssw36mdz2Dbq9;
	Mon,  9 Sep 2024 21:51:16 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F2611400DC;
	Mon,  9 Sep 2024 21:51:43 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 21:51:43 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
Date: Mon, 9 Sep 2024 21:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87bk0xc9iy.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/9 20:10, Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 11:22, Thomas Gleixner wrote:
>> On Thu, Sep 05 2024 at 11:45, Leizhen wrote:
>>> +               obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | GFP_NOWAIT);
>>> +               if (!obj)
>>> +                       return NULL;
>>
>> No. That fails on RT. See debug_object_fill_pool().
> 
> Some more thoughts on this. The goal is to reduce contention on pool
> lock. At the same time, this needs to ensure that the opportunistic fill
> mechanism actually works reliably.
> 
> debug_object_fill_pool() is invoked from
> 
>     - debug_object_init()
>     - debug_object_assert_init()
>     - debug_object_activate()
> 
> debug_object_init() is usually invoked from preemptible context. It will
> most of the time consume a tracking object from the per CPU or the
> global pool because re-initialization of a tracked object is rather
> rare.
> 
> debug_object_assert_init() and debug_object_activate() only consume a
> tracking object, when the to be tracked object is statically
> initialized or the call site failed to initialize the object. Both can
> be called from arbitrary contexts even under PREEMPT_RT, where
> preemptible context is a prerequisite for pool refill via allocations.
> 
> And of course any CPU which sits in fill_pool() can be preempted if the
> calling context is preemptible. And no, we can't disable preemption
> accross the whole thing due to RT.
> 
> So something like the uncompiled below should reduce lock contention
> significantly with a reasonable safety net.

It looks very good. Especially flexible use of 'state' and 'cpus_allocating'.
In this way, there is almost no conflict of lock 'pool_lock', and the more
cores, the less possible conflict.

Hi Thomas Gleixner:
  Do you plan to post this patch? But this patch will conflict with my patch 5/6.
If you're going to merge my patch 5/6, hopefully yours will be applied after mine.
  By the way, Do you have time to review the patches in the link below?
  https://lkml.org/lkml/2024/9/4/1094

> 
> Thanks,
> 
>         tglx
> ---
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -125,14 +125,10 @@ static const char *obj_states[ODEBUG_STA
>  	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
>  };
>  
> -static void fill_pool(void)
> +static void fill_pool_from_freelist(void)
>  {
> -	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
> +	static unsigned long state;
>  	struct debug_obj *obj;
> -	unsigned long flags;
> -
> -	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
> -		return;
>  
>  	/*
>  	 * Reuse objs from the global obj_to_free list; they will be
> @@ -141,25 +137,57 @@ static void fill_pool(void)
>  	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
>  	 * the WRITE_ONCE() in pool_lock critical sections.
>  	 */
> -	if (READ_ONCE(obj_nr_tofree)) {
> -		raw_spin_lock_irqsave(&pool_lock, flags);
> -		/*
> -		 * Recheck with the lock held as the worker thread might have
> -		 * won the race and freed the global free list already.
> -		 */
> -		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
> -			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> -			hlist_del(&obj->node);
> -			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
> -			hlist_add_head(&obj->node, &obj_pool);
> -			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
> -		}
> -		raw_spin_unlock_irqrestore(&pool_lock, flags);
> +	if (!READ_ONCE(obj_nr_tofree))
> +		return;
> +
> +	/*
> +	 * Prevent the context from being scheduled or interrupted after
> +	 * setting the state flag;
> +	 */
> +	guard(irqsave)();
> +
> +	/*
> +	 * Avoid lock contention on &pool_lock and avoid making the cache
> +	 * line exclusive by testing the bit before attempting to set it.
> +	 */
> +	if (test_bit(0, &state) || test_and_set_bit(0, &state))
> +		return;
> +
> +	guard(raw_spinlock)(&pool_lock);
> +	/*
> +	 * Recheck with the lock held as the worker thread might have
> +	 * won the race and freed the global free list already.
> +	 */
> +	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> +		hlist_del(&obj->node);
> +		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
> +		hlist_add_head(&obj->node, &obj_pool);
> +		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
>  	}
> +	clear_bit(0, &state);
> +}
> +
> +static void fill_pool(void)
> +{
> +	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
> +	static atomic_t cpus_allocating;
>  
>  	if (unlikely(!obj_cache))
>  		return;
>  
> +	/*
> +	 * Avoid allocation and lock contention when
> +	 *
> +	 *   - the CPU local pool has at least 2 objects left
> +	 *   - another CPU is already in the allocation path
> +	 *   - the global pool has not reached the critical level yet
> +	 */
> +	if (this_cpu_read(percpu_obj_pool.obj_free) > 1 && atomic_read(&cpus_allocating) &&
> +	    READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2))
> +		return;
> +
> +	atomic_inc(&cpus_allocating);
>  	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
>  		struct debug_obj *new[ODEBUG_BATCH_SIZE];
>  		int cnt;
> @@ -172,14 +200,14 @@ static void fill_pool(void)
>  		if (!cnt)
>  			return;
>  
> -		raw_spin_lock_irqsave(&pool_lock, flags);
> +		guard(raw_spinlock_irqsave)(&pool_lock);
>  		while (cnt) {
>  			hlist_add_head(&new[--cnt]->node, &obj_pool);
>  			debug_objects_allocated++;
>  			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
>  		}
> -		raw_spin_unlock_irqrestore(&pool_lock, flags);
>  	}
> +	atomic_dec(&cpus_allocating);
>  }
>  
>  /*
> @@ -598,6 +626,15 @@ static struct debug_obj *lookup_object_o
>  
>  static void debug_objects_fill_pool(void)
>  {
> +	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
> +		return;
> +
> +	/* Try reusing objects from obj_to_free_list */
> +	fill_pool_from_freelist();
> +
> +	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
> +		return;
> +
>  	/*
>  	 * On RT enabled kernels the pool refill must happen in preemptible
>  	 * context -- for !RT kernels we rely on the fact that spinlock_t and
> .
> 

-- 
Regards,
  Zhen Lei

