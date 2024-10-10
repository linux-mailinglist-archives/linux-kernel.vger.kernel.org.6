Return-Path: <linux-kernel+bounces-358351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44962997D80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2FE1F24601
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986201A304A;
	Thu, 10 Oct 2024 06:40:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6081B3725
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542403; cv=none; b=rtBolbj1vfGby81HABKlPGA5nMQxWO6eRQTbgLUKkmBC03RpgXNjo+xptg/1OAbZ89Wfe+761eAjuhuMoZSOpgtfz6UJ8rJTqAOOQpKcRR14PTpbU517SvyoQmqPVwS63g4ZQmdXqQRMR/3NPE8bo3mcSIsrkkwR/0wOFknpeWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542403; c=relaxed/simple;
	bh=XipN3XuCesUMl0TDbbTMyiwQPzzn4zV7Y6A8SAS1Bgo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W6F5CT96XG0ljA0A0D9p46m6qyz9iEd8o9mGiaL+6ENj7reUKydns1kva81DmArNBtCwhIxV2mM7tgRwEy6xYBbPZwhD1L9vnT4rnMof6kPLqVndTrfsERuZJQQJM0hLNOGFlEFGomC3NqWbtLsC1r92J+N21ZH7H5Fjcewjt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XPKqD0znXz20pfq;
	Thu, 10 Oct 2024 14:39:20 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EEAB1400D2;
	Thu, 10 Oct 2024 14:39:57 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 14:39:57 +0800
Subject: Re: [patch 15/25] debugobjects: Rework object allocation
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.893554162@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <289c3e15-77ea-edb6-7485-5b2f8ce66db5@huawei.com>
Date: Thu, 10 Oct 2024 14:39:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.893554162@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> The current allocation scheme tries to allocate from the per CPU pool
> first. If that fails it allocates one object from the global pool and then
> refills the per CPU pool from the global pool.
> 
> That is in the way of switching the pool management to batch mode as the
> global pool needs to be a strict stack of batches, which does not allow
> to allocate single objects.
> 
> Rework the code to refill the per CPU pool first and then allocate the
> object from the refilled batch. Also try to allocate from the to free pool
> first to avoid freeing and reallocating objects.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |  144 +++++++++++++++++++++++++----------------------------
>  1 file changed, 69 insertions(+), 75 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -141,6 +141,64 @@ static __always_inline bool pool_must_re
>  	return pool_count(pool) < pool->min_cnt / 2;
>  }
>  
> +static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
> +{
> +	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
> +		return false;
> +
> +	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
> +		struct hlist_node *node = src->objects.first;
> +
> +		WRITE_ONCE(src->cnt, src->cnt - 1);
> +		WRITE_ONCE(dst->cnt, dst->cnt + 1);
> +
> +		hlist_del(node);
> +		hlist_add_head(node, &dst->objects);
> +	}
> +	return true;
> +}
> +
> +static struct debug_obj *__alloc_object(struct hlist_head *list)
> +{
> +	struct debug_obj *obj;
> +
> +	if (unlikely(!list->first))
> +		return NULL;
> +
> +	obj = hlist_entry(list->first, typeof(*obj), node);
> +	hlist_del(&obj->node);
> +	return obj;
> +}
> +
> +static struct debug_obj *pcpu_alloc(void)
> +{
> +	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	for (;;) {
> +		struct debug_obj *obj = __alloc_object(&pcp->objects);
> +
> +		if (likely(obj)) {
> +			pcp->cnt--;
> +			return obj;
> +		}
> +
> +		guard(raw_spinlock)(&pool_lock);
> +		if (!pool_move_batch(pcp, &pool_to_free)) {
> +			if (!pool_move_batch(pcp, &pool_global))
> +				return NULL;
> +		}
> +		obj_pool_used += pcp->cnt;
> +
> +		if (obj_pool_used > obj_pool_max_used)
> +			obj_pool_max_used = obj_pool_used;
> +
> +		if (pool_global.cnt < obj_pool_min_free)
> +			obj_pool_min_free = pool_global.cnt;
> +	}
> +}
> +
>  static void free_object_list(struct hlist_head *head)
>  {
>  	struct hlist_node *tmp;
> @@ -158,7 +216,6 @@ static void free_object_list(struct hlis
>  static void fill_pool_from_freelist(void)
>  {
>  	static unsigned long state;
> -	struct debug_obj *obj;
>  
>  	/*
>  	 * Reuse objs from the global obj_to_free list; they will be
> @@ -180,17 +237,11 @@ static void fill_pool_from_freelist(void
>  	if (test_bit(0, &state) || test_and_set_bit(0, &state))
>  		return;
>  
> -	guard(raw_spinlock)(&pool_lock);
> -	/*
> -	 * Recheck with the lock held as the worker thread might have
> -	 * won the race and freed the global free list already.
> -	 */
> -	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
> -		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
> -		hlist_del(&obj->node);
> -		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
> -		hlist_add_head(&obj->node, &pool_global.objects);
> -		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
> +	/* Avoid taking the lock when there is no work to do */
> +	while (pool_should_refill(&pool_global) && pool_count(&pool_to_free)) {
> +		guard(raw_spinlock)(&pool_lock);
> +		/* Move a batch if possible */
> +		pool_move_batch(&pool_global, &pool_to_free);
>  	}
>  	clear_bit(0, &state);
>  }
> @@ -251,74 +302,17 @@ static struct debug_obj *lookup_object(v
>  	return NULL;
>  }
>  
> -/*
> - * Allocate a new object from the hlist
> - */
> -static struct debug_obj *__alloc_object(struct hlist_head *list)
> +static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
> +				      const struct debug_obj_descr *descr)
>  {
> -	struct debug_obj *obj = NULL;
> -
> -	if (list->first) {
> -		obj = hlist_entry(list->first, typeof(*obj), node);
> -		hlist_del(&obj->node);
> -	}
> -
> -	return obj;
> -}
> -
> -static struct debug_obj *
> -alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
> -{
> -	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
>  	struct debug_obj *obj;
>  
> -	if (likely(obj_cache)) {
> -		obj = __alloc_object(&percpu_pool->objects);
> -		if (obj) {
> -			percpu_pool->cnt--;
> -			goto init_obj;
> -		}
> -	} else {
> +	if (likely(obj_cache))
> +		obj = pcpu_alloc();
> +	else
>  		obj = __alloc_object(&pool_boot);
> -		goto init_obj;
> -	}
> -
> -	raw_spin_lock(&pool_lock);
> -	obj = __alloc_object(&pool_global.objects);
> -	if (obj) {
> -		obj_pool_used++;
> -		WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
> -
> -		/*
> -		 * Looking ahead, allocate one batch of debug objects and
> -		 * put them into the percpu free pool.
> -		 */
> -		if (likely(obj_cache)) {
> -			int i;
> -
> -			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
> -				struct debug_obj *obj2;
> -
> -				obj2 = __alloc_object(&pool_global.objects);
> -				if (!obj2)
> -					break;
> -				hlist_add_head(&obj2->node, &percpu_pool->objects);
> -				percpu_pool->cnt++;
> -				obj_pool_used++;
> -				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
> -			}
> -		}
> -
> -		if (obj_pool_used > obj_pool_max_used)
> -			obj_pool_max_used = obj_pool_used;
> -
> -		if (pool_global.cnt < obj_pool_min_free)
> -			obj_pool_min_free = pool_global.cnt;
> -	}
> -	raw_spin_unlock(&pool_lock);
>  
> -init_obj:
> -	if (obj) {
> +	if (likely(obj)) {
>  		obj->object = addr;
>  		obj->descr  = descr;
>  		obj->state  = ODEBUG_STATE_NONE;
> 
> .
> 

-- 
Regards,
  Zhen Lei

