Return-Path: <linux-kernel+bounces-358123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1E997A73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EF01F23E66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E263E479;
	Thu, 10 Oct 2024 02:14:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14979224CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526458; cv=none; b=KdQr7LqKEpnQZz8MSeDDzSUSDwfp0G4Xju2uWkOK/JlgE84QejWmYWE1tgP3ZCq3CRL8bOodrV0rbTN3TW/JjBVtRLgdnVivGp8kNDrB8TJKkNW689IAq+jpF7axFVMZ9ECMfDzbxen5unrDTypL5tP97+PdibQCZvoPKyIScRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526458; c=relaxed/simple;
	bh=4pZtp+eHy4BbRvgYZFdqiU6SwGhWN3BlTa5WLAhYOrA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jIVlKYkp504RxZtCvTwdcFfSZ5UrxjJ/q15UelnTO6BQ3ZoM/+iXenp1DjO3szARLY+G1OE6JsdV2Q3yy7uvQ0TtExPfkS0DOeZC2YUx4LLQp8p6BRHGPJCIo4sBjSKoL7pmcmLTogPdlquAFszNOAH+nYyNBJb/Ywodo8aWBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPCrS3RJNz1HKMJ;
	Thu, 10 Oct 2024 10:10:00 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E3A3314037C;
	Thu, 10 Oct 2024 10:14:06 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:14:06 +0800
Subject: Re: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.137021337@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com>
Date: Thu, 10 Oct 2024 10:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.137021337@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:49, Thomas Gleixner wrote:
> debug_objects_mem_init() is invoked from mm_core_init() before work queues
> are available. If debug_objects_mem_init() destroys the kmem cache in the
> error path it causes an Oops in __queue_work():
> 
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  RIP: 0010:__queue_work+0x35/0x6a0
>   queue_work_on+0x66/0x70
>   flush_all_cpus_locked+0xdf/0x1a0
>   __kmem_cache_shutdown+0x2f/0x340
>   kmem_cache_destroy+0x4e/0x150
>   mm_core_init+0x9e/0x120
>   start_kernel+0x298/0x800
>   x86_64_start_reservations+0x18/0x30
>   x86_64_start_kernel+0xc5/0xe0
>   common_startup_64+0x12c/0x138
> 
> Further the object cache pointer is used in various places to check for
> early boot operation. It is exposed before the replacments for the static
> boot time objects are allocated and the self test operates on it.
> 
> This can be avoided by:
> 
>      1) Running the self test with the static boot objects
> 
>      2) Exposing it only after the replacement objects have been added to
>      	the pool.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   68 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 33 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1211,7 +1211,7 @@ static __initconst const struct debug_ob
>  
>  static __initdata struct self_test obj = { .static_init = 0 };
>  
> -static void __init debug_objects_selftest(void)
> +static bool __init debug_objects_selftest(void)
>  {
>  	int fixups, oldfixups, warnings, oldwarnings;
>  	unsigned long flags;
> @@ -1280,9 +1280,10 @@ static void __init debug_objects_selftes
>  	descr_test = NULL;
>  
>  	local_irq_restore(flags);
> +	return !!debug_objects_enabled;
>  }
>  #else
> -static inline void debug_objects_selftest(void) { }
> +static inline bool debug_objects_selftest(void) { return true; }
>  #endif
>  
>  /*
> @@ -1302,18 +1303,21 @@ void __init debug_objects_early_init(voi
>  }
>  
>  /*
> - * Convert the statically allocated objects to dynamic ones:
> + * Convert the statically allocated objects to dynamic ones.
> + * debug_objects_mem_init() is called early so only one CPU is up and
> + * interrupts are disabled, which means it is safe to replace the active
> + * object references.
>   */
> -static int __init debug_objects_replace_static_objects(void)
> +static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
>  {
>  	struct debug_bucket *db = obj_hash;
> -	struct hlist_node *tmp;
>  	struct debug_obj *obj, *new;
> +	struct hlist_node *tmp;
>  	HLIST_HEAD(objects);
>  	int i, cnt = 0;
>  
>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
> -		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
> +		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
>  		if (!obj)
>  			goto free;
>  		hlist_add_head(&obj->node, &objects);
> @@ -1322,12 +1326,6 @@ static int __init debug_objects_replace_
>  	debug_objects_allocated += i;
>  
>  	/*
> -	 * debug_objects_mem_init() is now called early that only one CPU is up
> -	 * and interrupts have been disabled, so it is safe to replace the
> -	 * active object references.
> -	 */
> -
> -	/*
>  	 * Replace the statically allocated objects list with the allocated
>  	 * objects list.
>  	 */
> @@ -1347,15 +1345,14 @@ static int __init debug_objects_replace_
>  		}
>  	}
>  
> -	pr_debug("%d of %d active objects replaced\n",
> -		 cnt, obj_pool_used);
> -	return 0;
> +	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
> +	return true;
>  free:
>  	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
>  		hlist_del(&obj->node);
> -		kmem_cache_free(obj_cache, obj);
> +		kmem_cache_free(cache, obj);
>  	}
> -	return -ENOMEM;
> +	return false;
>  }
>  
>  /*
> @@ -1366,6 +1363,7 @@ static int __init debug_objects_replace_
>   */
>  void __init debug_objects_mem_init(void)
>  {
> +	struct kmem_cache *cache;
>  	int cpu, extras;
>  
>  	if (!debug_objects_enabled)
> @@ -1380,29 +1378,33 @@ void __init debug_objects_mem_init(void)
>  	for_each_possible_cpu(cpu)
>  		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
>  
> -	obj_cache = kmem_cache_create("debug_objects_cache",
> -				      sizeof (struct debug_obj), 0,
> -				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
> -				      NULL);
> +	if (!debug_objects_selftest())
> +		return;
> +
> +	cache = kmem_cache_create("debug_objects_cache", sizeof (struct debug_obj), 0,
> +				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
>  
> -	if (!obj_cache || debug_objects_replace_static_objects()) {
> +	if (!cache || !debug_objects_replace_static_objects(cache)) {
>  		debug_objects_enabled = 0;
> -		kmem_cache_destroy(obj_cache);

kmem_cache_destroy(cache) should be kept, or move it into debug_objects_replace_static_objects()
and place it above 'return false'.

> -		pr_warn("out of memory.\n");
> +		pr_warn("Out of memory.\n");
>  		return;
> -	} else
> -		debug_objects_selftest();
> -
> -#ifdef CONFIG_HOTPLUG_CPU
> -	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
> -					object_cpu_offline);
> -#endif
> +	}
>  
>  	/*
> -	 * Increase the thresholds for allocating and freeing objects
> -	 * according to the number of possible CPUs available in the system.
> +	 * Adjust the thresholds for allocating and freeing objects
> +	 * according to the number of possible CPUs available in the
> +	 * system.
>  	 */
>  	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
>  	debug_objects_pool_size += extras;
>  	debug_objects_pool_min_level += extras;
> +
> +	/* Everything worked. Expose the cache */
> +	obj_cache = cache;
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
> +				  object_cpu_offline);
> +#endif
> +	return;
>  }
> 
> .
> 

-- 
Regards,
  Zhen Lei

