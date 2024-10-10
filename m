Return-Path: <linux-kernel+bounces-358504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B0998031
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4381C1C21D05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DC21C175A;
	Thu, 10 Oct 2024 08:12:38 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0D1A0BD1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547957; cv=none; b=Q7lzWfthHZNLdHPywPiUCqy+7zk24WXaZ7S9IdY18hq9LUoYn2KXjEHcKQfucr1FJyho5PycFJE7YokIe0SIo2zytmuYCh2axAFRrVpRx73zV/VEmj24b+osOtiXXvd/Wu0o9knfH34AQgUKuHnFCoz3S773p+CuK9Y03eASP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547957; c=relaxed/simple;
	bh=bSI3p159q51MJ7vXrtQ+nTWKBXttqLl7L0awryMSoFk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cQBASCNBng0L+Gf7s8gB5KO9p7RDgMoge3cVGLq9lH2NtvrbY10XPDuOdPeM9TlgW9kmftcGj6mubidzyw6j1nvj92VHukyF5NmCHT53QzuNzRHrCpGZf3CjlxBmBZPjd+3jWa8wU6iRej0sP6mYZDCOiB5unSsH8suNT87aqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPMsV5Sxsz1j9L9;
	Thu, 10 Oct 2024 16:11:26 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 0288C1A0188;
	Thu, 10 Oct 2024 16:12:33 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 16:12:32 +0800
Subject: Re: [patch 18/25] debugobjects: Use static key for boot pool
 selection
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.077247071@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6b7c8b4d-0748-b72a-b1b6-aa99134253a8@huawei.com>
Date: Thu, 10 Oct 2024 16:12:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.077247071@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Get rid of the conditional in the hot path.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -7,16 +7,16 @@
>  
>  #define pr_fmt(fmt) "ODEBUG: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/debugobjects.h>
> -#include <linux/interrupt.h>
> +#include <linux/debugfs.h>
> +#include <linux/hash.h>
> +#include <linux/kmemleak.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/seq_file.h>
> -#include <linux/debugfs.h>
>  #include <linux/slab.h>
> -#include <linux/hash.h>
> -#include <linux/kmemleak.h>
> -#include <linux/cpu.h>
> +#include <linux/static_key.h>
>  
>  #define ODEBUG_HASH_BITS	14
>  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
> @@ -103,6 +103,8 @@ static int __data_racy		debug_objects_fr
>  static void free_obj_work(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
>  
> +static DEFINE_STATIC_KEY_FALSE(obj_cache_enabled);
> +
>  static int __init enable_object_debug(char *str)
>  {
>  	debug_objects_enabled = true;
> @@ -343,7 +345,7 @@ static struct debug_obj *alloc_object(vo
>  {
>  	struct debug_obj *obj;
>  
> -	if (likely(obj_cache))
> +	if (static_branch_likely(&obj_cache_enabled))
>  		obj = pcpu_alloc();
>  	else
>  		obj = __alloc_object(&pool_boot);
> @@ -393,7 +395,7 @@ static void free_obj_work(struct work_st
>  static void __free_object(struct debug_obj *obj)
>  {
>  	guard(irqsave)();
> -	if (likely(obj_cache))
> +	if (static_branch_likely(&obj_cache_enabled))
>  		pcpu_free(obj);
>  	else
>  		hlist_add_head(&obj->node, &pool_boot);
> @@ -572,7 +574,7 @@ static struct debug_obj *lookup_object_o
>  
>  static void debug_objects_fill_pool(void)
>  {
> -	if (unlikely(!obj_cache))
> +	if (!static_branch_likely(&obj_cache_enabled))
>  		return;
>  
>  	if (likely(!pool_should_refill(&pool_global)))
> @@ -1378,6 +1380,7 @@ void __init debug_objects_mem_init(void)
>  
>  	/* Everything worked. Expose the cache */
>  	obj_cache = cache;
> +	static_branch_enable(&obj_cache_enabled);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
> 
> .
> 

-- 
Regards,
  Zhen Lei

