Return-Path: <linux-kernel+bounces-358556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A087E9980D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D31F29633
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1F1BBBD6;
	Thu, 10 Oct 2024 08:40:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A631BB6BA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549618; cv=none; b=YPmXrTRBpnGWx49z1qvkAVxqkf3Y8My4JIZFGlU8j+sjj7TBrcXS5QX6+TdGxfi/E82MWvxy7q/5bi6VIu/Du/L5VLqU81TqzVz3nUsO0+GllCR8lYcjZQ8c8w95O1on6muDMMHawmv+C+Ez53RmKYamTSH1NKpaHQFLcuMnBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549618; c=relaxed/simple;
	bh=fb9Rk2Krd0TgicfJpEfSkKdWscQ7TyxS7lg8O27ev4w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SNqbzvxb7S93n67Ysapvdb6ojYeKzolGZu2IhQ+yxrjio3HmWQox3y57b2QdzJdl8NLizt4WSV7wIeE3oReZhJSX8Tme7vBNC+vpuhQsLX/Te7rHoBvXY2DCqU4eYwE6u6vz35ZTNJ5Y8KhuvdDdXF3TOM4AKnPtdsNXlxOSW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPNTQ2pqBz1j9W3;
	Thu, 10 Oct 2024 16:39:06 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id A003C1A0188;
	Thu, 10 Oct 2024 16:40:12 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 16:40:12 +0800
Subject: Re: [patch 20/25] debugobjects: Prepare kmem_cache allocations for
 batching
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.198647184@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cd9df252-8ec8-cb84-533f-ebc98a788032@huawei.com>
Date: Thu, 10 Oct 2024 16:40:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.198647184@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Allocate a batch and then push it into the pool. Utilize the
> debug_obj::last_node pointer for keeping track of the batch boundary.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   80 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -164,6 +164,22 @@ static bool pool_move_batch(struct obj_p
>  	return true;
>  }
>  
> +static bool pool_push_batch(struct obj_pool *dst, struct hlist_head *head)
> +{
> +	struct hlist_node *last;
> +	struct debug_obj *obj;
> +
> +	if (dst->cnt >= dst->max_cnt)
> +		return false;
> +
> +	obj = hlist_entry(head->first, typeof(*obj), node);
> +	last = obj->batch_last;
> +
> +	hlist_splice_init(head, last, &dst->objects);
> +	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
> +	return true;
> +}
> +
>  static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
>  {
>  	if (!src->cnt)
> @@ -288,6 +304,28 @@ static void fill_pool_from_freelist(void
>  	clear_bit(0, &state);
>  }
>  
> +static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cache, gfp_t gfp)
> +{
> +	struct hlist_node *last = NULL;
> +	struct debug_obj *obj;
> +
> +	for (int cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
> +		obj = kmem_cache_zalloc(cache, gfp);
> +		if (!obj) {
> +			free_object_list(head);
> +			return false;
> +		}
> +		debug_objects_allocated++;
> +
> +		if (!last)
> +			last = &obj->node;
> +		obj->batch_last = last;
> +
> +		hlist_add_head(&obj->node, head);

There seems to be a need to use hlist_splice_init() outside the loop like patch 2/25.
Prepare the local list first, if all ODEBUG_BATCH_SIZE is successfully allocated,
attach it to 'head' at a time, including account debug_objects_allocated. Then back
to patch 8/25, keep debug_objects_freed still in lock protection and do not move it
into free_object_list(). Seems like it should be.

> +	}
> +	return true;
> +}
> +
>  static void fill_pool(void)
>  {
>  	static atomic_t cpus_allocating;
> @@ -302,25 +340,14 @@ static void fill_pool(void)
>  
>  	atomic_inc(&cpus_allocating);
>  	while (pool_should_refill(&pool_global)) {
> -		struct debug_obj *new, *last = NULL;
>  		HLIST_HEAD(head);
> -		int cnt;
>  
> -		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
> -			new = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
> -			if (!new)
> -				break;
> -			hlist_add_head(&new->node, &head);
> -			if (!last)
> -				last = new;
> -		}
> -		if (!cnt)
> +		if (!kmem_alloc_batch(&head, obj_cache, __GFP_HIGH | __GFP_NOWARN))
>  			break;
>  
>  		guard(raw_spinlock_irqsave)(&pool_lock);
> -		hlist_splice_init(&head, &last->node, &pool_global.objects);
> -		debug_objects_allocated += cnt;
> -		WRITE_ONCE(pool_global.cnt, pool_global.cnt + cnt);
> +		if (!pool_push_batch(&pool_global, &head))
> +			pool_push_batch(&pool_to_free, &head);
>  	}
>  	atomic_dec(&cpus_allocating);
>  }
> @@ -1302,26 +1329,18 @@ void __init debug_objects_early_init(voi
>  static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
>  {
>  	struct debug_bucket *db = obj_hash;
> -	struct debug_obj *obj, *new;
>  	struct hlist_node *tmp;
> +	struct debug_obj *obj;
>  	HLIST_HEAD(objects);
>  	int i;
>  
> -	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
> -		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
> -		if (!obj)
> +	for (i = 0; i < ODEBUG_POOL_SIZE; i += ODEBUG_BATCH_SIZE) {
> +		if (!kmem_alloc_batch(&objects, cache, GFP_KERNEL))
>  			goto free;
> -		hlist_add_head(&obj->node, &objects);
> +		pool_push_batch(&pool_global, &objects);
>  	}
>  
> -	debug_objects_allocated = ODEBUG_POOL_SIZE;
> -	pool_global.cnt = ODEBUG_POOL_SIZE;
> -
> -	/*
> -	 * Move the allocated objects to the global pool and disconnect the
> -	 * boot pool.
> -	 */
> -	hlist_move_list(&objects, &pool_global.objects);
> +	/* Disconnect the boot pool. */
>  	pool_boot.first = NULL;
>  
>  	/* Replace the active object references */
> @@ -1329,9 +1348,8 @@ static bool __init debug_objects_replace
>  		hlist_move_list(&db->list, &objects);
>  
>  		hlist_for_each_entry(obj, &objects, node) {
> -			new = hlist_entry(pool_global.objects.first, typeof(*obj), node);
> -			hlist_del(&new->node);
> -			pool_global.cnt--;
> +			struct debug_obj *new = pcpu_alloc();
> +
>  			/* copy object data */
>  			*new = *obj;
>  			hlist_add_head(&new->node, &db->list);
> @@ -1340,7 +1358,7 @@ static bool __init debug_objects_replace
>  	return true;
>  free:
>  	/* Can't use free_object_list() as the cache is not populated yet */
> -	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
> +	hlist_for_each_entry_safe(obj, tmp, &pool_global.objects, node) {
>  		hlist_del(&obj->node);
>  		kmem_cache_free(cache, obj);
>  	}
> 
> .
> 

-- 
Regards,
  Zhen Lei

