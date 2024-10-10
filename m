Return-Path: <linux-kernel+bounces-358449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627E997F88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F41F2512F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A01EF94D;
	Thu, 10 Oct 2024 07:39:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8A433C9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545966; cv=none; b=HzfUPFMaJpwPTEDAAJ4gRbD2BcPdN3DcJK/iyG6wMrNGuMCh0FMsLy3BmWU5ijTSvg+RVOAmCTIsocYK9qf2XFcplywCylEDPvCP0h3X6ZF6n0CgJItHj3BhKx0rYuBtTu36eUp8PrcwS252VFhEcu0B103thKXso3RJ4nTkgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545966; c=relaxed/simple;
	bh=bT69dXRMAGvZFXTup/QXktId8zC/nDeIddEF/ZVfV08=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T902djue3o8De9ALs3c0sSrczkLNj92wZXVQdi4VFZvVs8gSKIpMgqtbbWuGw9qtOv41wZxFs2PwXtiLSq98TeaXW6E0LxBWn7PsCYuNp7eJfPG5dSfjGzplep3+o7Avy9gGOx3afxjINOrOoWy3upL38y6p5MnCcDhBGn6W0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPM5b5DJPzfcfc;
	Thu, 10 Oct 2024 15:36:51 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id DE9161402CB;
	Thu, 10 Oct 2024 15:39:15 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 15:39:15 +0800
Subject: Re: [patch 16/25] debugobjects: Rework object freeing
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.955542307@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f8b86635-008c-3923-1f78-10575578f037@huawei.com>
Date: Thu, 10 Oct 2024 15:39:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.955542307@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> __free_object() is uncomprehensibly complex. The same can be achieved by:
> 
>    1) Adding the object to the per CPU pool
> 
>    2) If that pool is full, move a batch of objects into the global pool
>       or if the global pool is full into the to free pool
> 
> This also prepares for batch processing.

It feels like cutting the Gordian knot with a sharp sword.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   99 ++++++++++++-----------------------------------------
>  1 file changed, 24 insertions(+), 75 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -199,6 +199,27 @@ static struct debug_obj *pcpu_alloc(void
>  	}
>  }
>  
> +static void pcpu_free(struct debug_obj *obj)
> +{
> +	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	hlist_add_head(&obj->node, &pcp->objects);
> +	pcp->cnt++;
> +
> +	/* Pool full ? */
> +	if (pcp->cnt < ODEBUG_POOL_PERCPU_SIZE)
> +		return;
> +
> +	/* Remove a batch from the per CPU pool */
> +	guard(raw_spinlock)(&pool_lock);
> +	/* Try to fit the batch into the pool_global first */
> +	if (!pool_move_batch(&pool_global, pcp))
> +		pool_move_batch(&pool_to_free, pcp);
> +	obj_pool_used -= ODEBUG_BATCH_SIZE;
> +}
> +
>  static void free_object_list(struct hlist_head *head)
>  {
>  	struct hlist_node *tmp;
> @@ -375,83 +396,11 @@ static void free_obj_work(struct work_st
>  
>  static void __free_object(struct debug_obj *obj)
>  {
> -	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
> -	struct obj_pool *percpu_pool;
> -	int lookahead_count = 0;
> -	bool work;
> -
>  	guard(irqsave)();
> -
> -	if (unlikely(!obj_cache)) {
> +	if (likely(obj_cache))
> +		pcpu_free(obj);
> +	else
>  		hlist_add_head(&obj->node, &pool_boot);
> -		return;
> -	}
> -
> -	/*
> -	 * Try to free it into the percpu pool first.
> -	 */
> -	percpu_pool = this_cpu_ptr(&pool_pcpu);
> -	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
> -		hlist_add_head(&obj->node, &percpu_pool->objects);
> -		percpu_pool->cnt++;
> -		return;
> -	}
> -
> -	/*
> -	 * As the percpu pool is full, look ahead and pull out a batch
> -	 * of objects from the percpu pool and free them as well.
> -	 */
> -	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
> -		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
> -		if (!objs[lookahead_count])
> -			break;
> -		percpu_pool->cnt--;
> -	}
> -
> -	raw_spin_lock(&pool_lock);
> -	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
> -	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
> -	obj_pool_used--;
> -
> -	if (work) {
> -		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
> -		hlist_add_head(&obj->node, &pool_to_free.objects);
> -		if (lookahead_count) {
> -			WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + lookahead_count);
> -			obj_pool_used -= lookahead_count;
> -			while (lookahead_count) {
> -				hlist_add_head(&objs[--lookahead_count]->node,
> -					       &pool_to_free.objects);
> -			}
> -		}
> -
> -		if ((pool_global.cnt > pool_global.max_cnt) &&
> -		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
> -			int i;
> -
> -			/*
> -			 * Free one more batch of objects from obj_pool.
> -			 */
> -			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
> -				obj = __alloc_object(&pool_global.objects);
> -				hlist_add_head(&obj->node, &pool_to_free.objects);
> -				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
> -				WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
> -			}
> -		}
> -	} else {
> -		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
> -		hlist_add_head(&obj->node, &pool_global.objects);
> -		if (lookahead_count) {
> -			WRITE_ONCE(pool_global.cnt, pool_global.cnt + lookahead_count);
> -			obj_pool_used -= lookahead_count;
> -			while (lookahead_count) {
> -				hlist_add_head(&objs[--lookahead_count]->node,
> -					       &pool_global.objects);
> -			}
> -		}
> -	}
> -	raw_spin_unlock(&pool_lock);
>  }
>  
>  /*
> 
> .
> 

-- 
Regards,
  Zhen Lei

