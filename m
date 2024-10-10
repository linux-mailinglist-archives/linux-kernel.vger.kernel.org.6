Return-Path: <linux-kernel+bounces-358696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B96998287
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381001F20C95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADE1BBBC3;
	Thu, 10 Oct 2024 09:39:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B301187859
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553162; cv=none; b=Ggc3/cHwYILt6KA6b+7jvRVC6/Fc6bIFpj+3aZQafmv9/L1tjKT7eG7uzzQX3orm0NgOFPC3WS4WaBA5WVrDzL5EcvDi7pRjwgzq0DqnsOTk2XteF4NpcP73CHbJrMOpfsFk+cBm1CKAjK+QA7XaXIX4z+YfMRVCQTjxlKXSnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553162; c=relaxed/simple;
	bh=TUEExBDmXOMKGA7QMEpcIYMd2sXLOSkTm0h7tsDYN28=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kbk5cdeEALDOJ3o7Cb/Sljjp+1l1S336IzB5+CixzCUgsYxDsrH3AzEj3+O3DBCf2kBccBj1ZpeLbaKlJCwci1PGYVIc+8yLGDTJkO4Ey4WDWicQG4TUzOUW56mWEKOohEe2MLCAPLv7U3kSqUV4ZXEU4QCN4oFW0SPzKX+KkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XPPmk2nmYz1T88N;
	Thu, 10 Oct 2024 17:37:26 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id EFCE218010F;
	Thu, 10 Oct 2024 17:39:10 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 17:39:10 +0800
Subject: Re: [patch 21/25] debugobjects: Implement batch processing
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.258995000@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <192cb914-556e-4617-fdfa-25bdc8c56f43@huawei.com>
Date: Thu, 10 Oct 2024 17:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.258995000@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Adding and removing single objects in a loop is bad in terms of lock
> contention and cache line accesses.
> 
> To implement batching, record the last object in a batch in the object
> itself. This is trivialy possible as hlists are strictly stacks. At a batch
> boundary, when the first object is added to the list the object stores a
> pointer to itself in debug_obj::batch_last. When the next object is added
> to the list then the batch_last pointer is retrieved from the first object
> in the list and stored in the to be added one.
> 
> That means for batch processing the first object always has a pointer to
> the last object in a batch, which allows to move batches in a cache line
> efficient way and reduces the lock held time.

It seems that adding a helper function hlist_cut_position() can make the code
look more concise and clear. But there's a lot of patches now. We can do it
later, and maybe I can do it then.

Similar to the current list_cut_position():
/**
 * list_cut_position - cut a list into two
 * @list: a new list to add all removed entries
 * @head: a list with entries
 * @entry: an entry within head


Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   61 +++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -149,18 +149,31 @@ static __always_inline bool pool_must_re
>  
>  static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
>  {
> -	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
> +	struct hlist_node *last, *next_batch, *first_batch;
> +	struct debug_obj *obj;
> +
> +	if (dst->cnt >= dst->max_cnt || !src->cnt)
>  		return false;
>  
> -	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
> -		struct hlist_node *node = src->objects.first;
> +	first_batch = src->objects.first;
> +	obj = hlist_entry(first_batch, typeof(*obj), node);
> +	last = obj->batch_last;
> +	next_batch = last->next;
>  
> -		WRITE_ONCE(src->cnt, src->cnt - 1);
> -		WRITE_ONCE(dst->cnt, dst->cnt + 1);
> +	/* Move the next batch to the front of the source pool */
> +	src->objects.first = next_batch;
> +	if (next_batch)
> +		next_batch->pprev = &src->objects.first;
> +
> +	/* Add the extracted batch to the destination pool */
> +	last->next = dst->objects.first;
> +	if (last->next)
> +		last->next->pprev = &last->next;
> +	first_batch->pprev = &dst->objects.first;
> +	dst->objects.first = first_batch;
>  
> -		hlist_del(node);
> -		hlist_add_head(node, &dst->objects);
> -	}
> +	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
> +	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
>  	return true;
>  }
>  
> @@ -182,16 +195,27 @@ static bool pool_push_batch(struct obj_p
>  
>  static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
>  {
> +	struct hlist_node *last, *next;
> +	struct debug_obj *obj;
> +
>  	if (!src->cnt)
>  		return false;
>  
> -	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
> -		struct hlist_node *node = src->objects.first;
> +	/* Move the complete list to the head */
> +	hlist_move_list(&src->objects, head);
>  
> -		WRITE_ONCE(src->cnt, src->cnt - 1);
> -		hlist_del(node);
> -		hlist_add_head(node, head);
> -	}
> +	obj = hlist_entry(head->first, typeof(*obj), node);
> +	last = obj->batch_last;
> +	next = last->next;
> +	/* Disconnect the batch from the list */
> +	last->next = NULL;
> +
> +	/* Move the node after last back to the source pool. */
> +	src->objects.first = next;
> +	if (next)
> +		next->pprev = &src->objects.first;
> +
> +	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
>  	return true;
>  }
>  
> @@ -226,7 +250,7 @@ static struct debug_obj *pcpu_alloc(void
>  			if (!pool_move_batch(pcp, &pool_global))
>  				return NULL;
>  		}
> -		obj_pool_used += pcp->cnt;
> +		obj_pool_used += ODEBUG_BATCH_SIZE;
>  
>  		if (obj_pool_used > obj_pool_max_used)
>  			obj_pool_max_used = obj_pool_used;
> @@ -239,9 +263,16 @@ static struct debug_obj *pcpu_alloc(void
>  static void pcpu_free(struct debug_obj *obj)
>  {
>  	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
> +	struct debug_obj *first;
>  
>  	lockdep_assert_irqs_disabled();
>  
> +	if (!(pcp->cnt % ODEBUG_BATCH_SIZE)) {
> +		obj->batch_last = &obj->node;
> +	} else {
> +		first = hlist_entry(pcp->objects.first, typeof(*first), node);
> +		obj->batch_last = first->batch_last;
> +	}
>  	hlist_add_head(&obj->node, &pcp->objects);
>  	pcp->cnt++;
>  
> 
> .
> 

-- 
Regards,
  Zhen Lei

