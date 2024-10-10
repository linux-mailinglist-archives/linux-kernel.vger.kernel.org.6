Return-Path: <linux-kernel+bounces-358498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2457998026
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD21C21703
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE51BC091;
	Thu, 10 Oct 2024 08:10:09 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F24192D8C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547809; cv=none; b=MdNW3/8JEXW2FjXLCUtKeE3ZPhgYf8u2zDX5milhL6hQl3wGyycdCq+syNsIGn37EJgL3ztF6fKq8n2bmC1fOyaQUl1aIJ1YJ6Tk5U8a18C8xUQGQyxnNfFXUXTOZZyXxyq9GfXIBq2KGWp0VRaE3KiuIvMHD6eZjK45yXw92OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547809; c=relaxed/simple;
	bh=72RycIbjzSkb6GvYMe95nf2qRRF4sFJZxvrtYg6Barg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qF0xp+snIDCq5zCy7daLkx+YlEKGa+Z+4p3H2SoYOozHVo7oaDFdotK5X/aQAVFZqxfamhfqzQHYzo0Y2igV73BpVO46iSRydi0wdpO9KhV8wVvUnJ9ibFMPkYcioHMmTt0bKdUO0iPqDkXR5subzFLr8qLa3fqo3fEBX19tISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPMpb5sK6z1j9Dl;
	Thu, 10 Oct 2024 16:08:55 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EF191A016C;
	Thu, 10 Oct 2024 16:10:02 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 16:10:01 +0800
Subject: Re: [patch 17/25] debugobjects: Rework free_object_work()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.015906394@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3f8b6240-1ec7-67ac-5f95-6e406fb80d48@huawei.com>
Date: Thu, 10 Oct 2024 16:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.015906394@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Convert it to batch processing with intermediate helper functions. This
> reduces the final changes for batch processing.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   80 +++++++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 42 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -35,7 +35,7 @@
>   * frequency of 10Hz and about 1024 objects for each freeing operation.
>   * So it is freeing at most 10k debug objects per second.
>   */
> -#define ODEBUG_FREE_WORK_MAX	1024
> +#define ODEBUG_FREE_WORK_MAX	(1024 / ODEBUG_BATCH_SIZE)
>  #define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
>  
>  struct debug_bucket {
> @@ -158,6 +158,21 @@ static bool pool_move_batch(struct obj_p
>  	return true;
>  }
>  
> +static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
> +{
> +	if (!src->cnt)
> +		return false;
> +
> +	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
> +		struct hlist_node *node = src->objects.first;
> +
> +		WRITE_ONCE(src->cnt, src->cnt - 1);
> +		hlist_del(node);
> +		hlist_add_head(node, head);
> +	}
> +	return true;
> +}
> +
>  static struct debug_obj *__alloc_object(struct hlist_head *list)
>  {
>  	struct debug_obj *obj;
> @@ -343,55 +358,36 @@ static struct debug_obj *alloc_object(vo
>  	return obj;
>  }
>  
> -/*
> - * workqueue function to free objects.
> - *
> - * To reduce contention on the global pool_lock, the actual freeing of
> - * debug objects will be delayed if the pool_lock is busy.
> - */
> +/* workqueue function to free objects. */
>  static void free_obj_work(struct work_struct *work)
>  {
> -	struct debug_obj *obj;
> -	unsigned long flags;
> -	HLIST_HEAD(tofree);
> +	bool free = true;
>  
>  	WRITE_ONCE(obj_freeing, false);
> -	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
> +
> +	if (!pool_count(&pool_to_free))
>  		return;
>  
> -	if (pool_global.cnt >= pool_global.max_cnt)
> -		goto free_objs;
> +	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
> +		HLIST_HEAD(tofree);
>  
> -	/*
> -	 * The objs on the pool list might be allocated before the work is
> -	 * run, so recheck if pool list it full or not, if not fill pool
> -	 * list from the global free list. As it is likely that a workload
> -	 * may be gearing up to use more and more objects, don't free any
> -	 * of them until the next round.
> -	 */
> -	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
> -		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
> -		hlist_del(&obj->node);
> -		hlist_add_head(&obj->node, &pool_global.objects);
> -		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
> -		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
> -	}
> -	raw_spin_unlock_irqrestore(&pool_lock, flags);
> -	return;
> -
> -free_objs:
> -	/*
> -	 * Pool list is already full and there are still objs on the free
> -	 * list. Move remaining free objs to a temporary list to free the
> -	 * memory outside the pool_lock held region.
> -	 */
> -	if (pool_to_free.cnt) {
> -		hlist_move_list(&pool_to_free.objects, &tofree);
> -		WRITE_ONCE(pool_to_free.cnt, 0);
> +		/* Acquire and drop the lock for each batch */
> +		scoped_guard(raw_spinlock_irqsave, &pool_lock) {
> +			if (!pool_to_free.cnt)
> +				return;
> +
> +			/* Refill the global pool if possible */
> +			if (pool_move_batch(&pool_global, &pool_to_free)) {
> +				/* Don't free as there seems to be demand */
> +				free = false;
> +			} else if (free) {
> +				pool_pop_batch(&tofree, &pool_to_free);
> +			} else {
> +				return;
> +			}
> +		}
> +		free_object_list(&tofree);
>  	}
> -	raw_spin_unlock_irqrestore(&pool_lock, flags);
> -
> -	free_object_list(&tofree);
>  }
>  
>  static void __free_object(struct debug_obj *obj)
> 
> .
> 

-- 
Regards,
  Zhen Lei

