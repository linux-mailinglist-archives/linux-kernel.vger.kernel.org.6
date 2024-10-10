Return-Path: <linux-kernel+bounces-358319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE78997D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DE7285176
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D019EED2;
	Thu, 10 Oct 2024 06:23:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD81311AC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541420; cv=none; b=SzY6jIzpPij6XUw8l5G2kX4S29vRe3uOMd3lLwopCg4bSqGk47NbHOD9gixFkBgWFlFd1b2eUtN9uBM+0AqK2syLlb/jq9fsL7VBoQTzdlcjsHkQdpfgJ2c29zuMKp8i3uV426kHpK4qpAawrUIJ/pNuqpAa3kTMmme9Y9v4PHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541420; c=relaxed/simple;
	bh=1KByvVZ1FvuZMXChOGTpKcLF9Y+ZjvDj/rnc9Of+SUc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EE44wfnAnMD2xdUCdp0KAyDtZQE+xPXQ5mAd6AfSs8nM2eRg9syOujYwTb02pz3sKPNPCCysEPRwmi1HzVPaRPmK/PQp/If8EWAs8yHxu2OPwIsBdW8dpKpcLFqW1qPtcKeUrpg/6AwMQKgs+paCS14u4pnOC4jOx30sU+x4Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPKRX1r87zySr9;
	Thu, 10 Oct 2024 14:22:16 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 728D61401E9;
	Thu, 10 Oct 2024 14:23:33 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 14:23:33 +0800
Subject: Re: [patch 13/25] debugobjects: Rename and tidy up per CPU pools
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.770595795@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <30b4864b-4d41-3484-f324-76598a98f7d4@huawei.com>
Date: Thu, 10 Oct 2024 14:23:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.770595795@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> No point in having a separate data structure. Reuse struct obj_pool and
> tidy up the code.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -43,21 +43,12 @@ struct debug_bucket {
>  	raw_spinlock_t		lock;
>  };
>  
> -/*
> - * Debug object percpu free list
> - * Access is protected by disabling irq
> - */
> -struct debug_percpu_free {
> -	struct hlist_head	free_objs;
> -	int			obj_free;
> -};
> -
>  struct obj_pool {
>  	struct hlist_head	objects;
>  	unsigned int		cnt;
>  } ____cacheline_aligned;
>  
> -static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
> +static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
>  
>  static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
>  
> @@ -271,13 +262,13 @@ static struct debug_obj *__alloc_object(
>  static struct debug_obj *
>  alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>  {
> -	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
> +	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
>  	struct debug_obj *obj;
>  
>  	if (likely(obj_cache)) {
> -		obj = __alloc_object(&percpu_pool->free_objs);
> +		obj = __alloc_object(&percpu_pool->objects);
>  		if (obj) {
> -			percpu_pool->obj_free--;
> +			percpu_pool->cnt--;
>  			goto init_obj;
>  		}
>  	} else {
> @@ -304,8 +295,8 @@ alloc_object(void *addr, struct debug_bu
>  				obj2 = __alloc_object(&pool_global.objects);
>  				if (!obj2)
>  					break;
> -				hlist_add_head(&obj2->node, &percpu_pool->free_objs);
> -				percpu_pool->obj_free++;
> +				hlist_add_head(&obj2->node, &percpu_pool->objects);
> +				percpu_pool->cnt++;
>  				obj_pool_used++;
>  				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
>  			}
> @@ -384,7 +375,7 @@ static void free_obj_work(struct work_st
>  static void __free_object(struct debug_obj *obj)
>  {
>  	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
> -	struct debug_percpu_free *percpu_pool;
> +	struct obj_pool *percpu_pool;
>  	int lookahead_count = 0;
>  	bool work;
>  
> @@ -398,10 +389,10 @@ static void __free_object(struct debug_o
>  	/*
>  	 * Try to free it into the percpu pool first.
>  	 */
> -	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
> -	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
> -		hlist_add_head(&obj->node, &percpu_pool->free_objs);
> -		percpu_pool->obj_free++;
> +	percpu_pool = this_cpu_ptr(&pool_pcpu);
> +	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
> +		hlist_add_head(&obj->node, &percpu_pool->objects);
> +		percpu_pool->cnt++;
>  		return;
>  	}
>  
> @@ -410,10 +401,10 @@ static void __free_object(struct debug_o
>  	 * of objects from the percpu pool and free them as well.
>  	 */
>  	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
> -		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
> +		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
>  		if (!objs[lookahead_count])
>  			break;
> -		percpu_pool->obj_free--;
> +		percpu_pool->cnt--;
>  	}
>  
>  	raw_spin_lock(&pool_lock);
> @@ -494,10 +485,10 @@ static void put_objects(struct hlist_hea
>  static int object_cpu_offline(unsigned int cpu)
>  {
>  	/* Remote access is safe as the CPU is dead already */
> -	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
> +	struct obj_pool *pcp = per_cpu_ptr(&pool_pcpu, cpu);
>  
> -	put_objects(&pcp->free_objs);
> -	pcp->obj_free = 0;
> +	put_objects(&pcp->objects);
> +	pcp->cnt = 0;
>  	return 0;
>  }
>  #endif
> @@ -1076,7 +1067,7 @@ static int debug_stats_show(struct seq_f
>  	int cpu, obj_percpu_free = 0;
>  
>  	for_each_possible_cpu(cpu)
> -		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
> +		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
>  
>  	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
>  	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
> 
> .
> 

-- 
Regards,
  Zhen Lei

