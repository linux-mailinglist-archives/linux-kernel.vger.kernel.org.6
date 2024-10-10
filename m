Return-Path: <linux-kernel+bounces-358137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC15D997A99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EE21C215FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3281531E9;
	Thu, 10 Oct 2024 02:33:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C296BB5B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527590; cv=none; b=U8a9qUoFzXOXGF9ZtBP5I0WumIYTfLsh8z0rQYkPdF5WS9pxyRe/y87ROulK3ucgWIPntqxqNMyTkGHj8c8a/ajaGIvBQdZWBUP0iU93M37oZB7OtrVjb20X33LBeojOIHrdEMK+K5/gsmhKxLjyu+UqD2BxeflEoFTBLKV75Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527590; c=relaxed/simple;
	bh=gEkIVsMINRAC26Yd4SF3x6Z6cXcNIeAHF1l/vUaFepY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XZE1036BMPGEDUPypA0VGDef2cRnwlkkmKR1Fgya9a5cRAvoZCjBts+384fKwYKdmmN3ZmiZHm6aipoPilYJdjg7E4vZj4qmdEzYhM4CtESfcXMTTx7G0hbF2rxlrvLh3N7IYvA7txfTTqXE4N2051tWnBOAfQa8quvPUOQD+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XPDKq4Ng6z2DdHY;
	Thu, 10 Oct 2024 10:31:59 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id B46361A0190;
	Thu, 10 Oct 2024 10:33:05 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:33:05 +0800
Subject: Re: [patch 05/25] debugobjects: Dont free objects directly on CPU
 hotplug
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.263960570@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5f37fb04-b703-dec9-8f05-ee357efd0904@huawei.com>
Date: Thu, 10 Oct 2024 10:33:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.263960570@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:49, Thomas Gleixner wrote:
> Freeing the per CPU pool of the unplugged CPU directly is suboptimal as the
> objects can be reused in the real pool if there is room. Aside of that this
> gets the accounting wrong.
> 
> Use the regular free path, which allows reuse and has the accounting correct.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -430,27 +430,28 @@ static void free_object(struct debug_obj
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -static int object_cpu_offline(unsigned int cpu)
> +static void put_objects(struct hlist_head *list)
>  {
> -	struct debug_percpu_free *percpu_pool;
>  	struct hlist_node *tmp;
>  	struct debug_obj *obj;
> -	unsigned long flags;
>  
> -	/* Remote access is safe as the CPU is dead already */
> -	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
> -	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
> +	/*
> +	 * Using free_object() puts the objects into reuse or schedules
> +	 * them for freeing and it get's all the accounting correct.
> +	 */
> +	hlist_for_each_entry_safe(obj, tmp, list, node) {
>  		hlist_del(&obj->node);
> -		kmem_cache_free(obj_cache, obj);
> +		free_object(obj);
>  	}
> +}
>  
> -	raw_spin_lock_irqsave(&pool_lock, flags);
> -	obj_pool_used -= percpu_pool->obj_free;
> -	debug_objects_freed += percpu_pool->obj_free;
> -	raw_spin_unlock_irqrestore(&pool_lock, flags);
> -
> -	percpu_pool->obj_free = 0;
> +static int object_cpu_offline(unsigned int cpu)
> +{
> +	/* Remote access is safe as the CPU is dead already */
> +	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
>  
> +	put_objects(&pcp->free_objs);
> +	pcp->obj_free = 0;
>  	return 0;
>  }
>  #endif
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

