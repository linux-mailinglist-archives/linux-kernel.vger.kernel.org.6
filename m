Return-Path: <linux-kernel+bounces-358223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13955997B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F114283638
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B4192B71;
	Thu, 10 Oct 2024 04:05:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA04CB2B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533103; cv=none; b=Q8JWNWv9E2gjtKWjFYHZvlBH0vCMarf/pFCdlYrOppVfxqR12eZc8Gk9nk1hzD3CDuW+jSwhA9vxlbIdHyJ0sX2LhM3Z2n7FYK01rB/zi1csFq0NnbglEUTuwlJMqR5HtWDg0S0lcW79eE/zZ2bGW5vCBQQt1SWM60k9zqf2u6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533103; c=relaxed/simple;
	bh=F5Ac08cnS0BpBmMtK8RQf5XZif8L8A3phmgr5TqE7Ok=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N1FzUoXWKBnyXwC1SaRrbVXNi3AUOCwIRpv2A1N/SIsCStjOJcBl4N23vTQGfmPFk38eQ4hCfzen/G3u9DTatSrMpy2em9hF1GuGvC+s5NchYRYGPF2UXUmQygwIH9e2VZezdiyQ4d170H+iGxOyS45vfRJwfrPV0sq/rEnqBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPGM55rVQz10N3f;
	Thu, 10 Oct 2024 12:03:13 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 60A4318010F;
	Thu, 10 Oct 2024 12:04:58 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 12:04:57 +0800
Subject: Re: [patch 12/25] debugobjects: Use separate list head for boot pool
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.708939081@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <97f23c1f-276c-54b2-d1b2-6d805a597d46@huawei.com>
Date: Thu, 10 Oct 2024 12:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.708939081@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> There is no point to handle the statically allocated objects during early
> boot in the actual pool list. This phase does not require accounting, so
> all of the related complexity can be avoided.

That's great. The design of 'pool_boot' is clever! The code logic is clearer.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -68,6 +68,8 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
>  static struct obj_pool		pool_global;
>  static struct obj_pool		pool_to_free;
>  
> +static HLIST_HEAD(pool_boot);
> +
>  /*
>   * Because of the presence of percpu free pools, obj_pool_free will
>   * under-count those in the percpu free pools. Similarly, obj_pool_used
> @@ -278,6 +280,9 @@ alloc_object(void *addr, struct debug_bu
>  			percpu_pool->obj_free--;
>  			goto init_obj;
>  		}
> +	} else {
> +		obj = __alloc_object(&pool_boot);
> +		goto init_obj;
>  	}
>  
>  	raw_spin_lock(&pool_lock);
> @@ -381,12 +386,14 @@ static void __free_object(struct debug_o
>  	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
>  	struct debug_percpu_free *percpu_pool;
>  	int lookahead_count = 0;
> -	unsigned long flags;
>  	bool work;
>  
> -	local_irq_save(flags);
> -	if (!obj_cache)
> -		goto free_to_obj_pool;
> +	guard(irqsave)();
> +
> +	if (unlikely(!obj_cache)) {
> +		hlist_add_head(&obj->node, &pool_boot);
> +		return;
> +	}
>  
>  	/*
>  	 * Try to free it into the percpu pool first.
> @@ -395,7 +402,6 @@ static void __free_object(struct debug_o
>  	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
>  		hlist_add_head(&obj->node, &percpu_pool->free_objs);
>  		percpu_pool->obj_free++;
> -		local_irq_restore(flags);
>  		return;
>  	}
>  
> @@ -410,7 +416,6 @@ static void __free_object(struct debug_o
>  		percpu_pool->obj_free--;
>  	}
>  
> -free_to_obj_pool:
>  	raw_spin_lock(&pool_lock);
>  	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
>  	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
> @@ -455,7 +460,6 @@ static void __free_object(struct debug_o
>  		}
>  	}
>  	raw_spin_unlock(&pool_lock);
> -	local_irq_restore(flags);
>  }
>  
>  /*
> @@ -1341,10 +1345,9 @@ void __init debug_objects_early_init(voi
>  	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
>  		raw_spin_lock_init(&obj_hash[i].lock);
>  
> +	/* Keep early boot simple and add everything to the boot list */
>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
> -		hlist_add_head(&obj_static_pool[i].node, &pool_global.objects);
> -
> -	pool_global.cnt = ODEBUG_POOL_SIZE;
> +		hlist_add_head(&obj_static_pool[i].node, &pool_boot);
>  }
>  
>  /*
> @@ -1372,10 +1375,11 @@ static bool __init debug_objects_replace
>  	pool_global.cnt = ODEBUG_POOL_SIZE;
>  
>  	/*
> -	 * Replace the statically allocated objects list with the allocated
> -	 * objects list.
> +	 * Move the allocated objects to the global pool and disconnect the
> +	 * boot pool.
>  	 */
>  	hlist_move_list(&objects, &pool_global.objects);
> +	pool_boot.first = NULL;
>  
>  	/* Replace the active object references */
>  	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
> 
> .
> 

-- 
Regards,
  Zhen Lei

