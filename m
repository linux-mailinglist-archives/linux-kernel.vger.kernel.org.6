Return-Path: <linux-kernel+bounces-358747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B102D998317
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09701C219C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A21B5EBC;
	Thu, 10 Oct 2024 10:02:53 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3F36D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554573; cv=none; b=pi3Ih/4lqu+SLA6+0lPb62kdEhoiK/3X7WM1wfI+8VT1EWXjC51iq43GpjZEFl3mrbQfeBbJGcM2lIiDXFHaCN1n+k0Kea7eln/FLDjCWC4tKC1hBYZNdQBvZxMu8a63hGC3NJZcVq04aGi1xaHxHZtGRjV40Ha3XHIAg7Zvz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554573; c=relaxed/simple;
	bh=1HGiVbkIo5LnfhKf7Went0Udy39lKHfx2HU7N7yt8Sc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P0HegD/1sZ0jQUhIRALFE5wQjzbKQx/kXgXCWiAbDIOYxdd9AbLUXUccQilbfMTmYOXh12BiBko7znYaiaknlfaSP2PmMCpU2lkTAW0Ixqkgn6k0KWUwq61XNgpWhBsVDnkhv+4PYhaKojOabZPnJl6EbqopFLTTWv/YTq+LLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XPQJh4NN8z1SCPS;
	Thu, 10 Oct 2024 18:01:40 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id B04411A0188;
	Thu, 10 Oct 2024 18:02:47 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 18:02:47 +0800
Subject: Re: [patch 24/25] debugobjects: Refill per CPU pool more agressively
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.439053085@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <73661d9d-0fb4-08b8-aea9-e54fffba4027@huawei.com>
Date: Thu, 10 Oct 2024 18:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.439053085@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Right now the per CPU pools are only refilled when they become
> empty. That's suboptimal especially when there are still non-freed objects
> in the to free list.
> 
> Check whether an allocation from the per CPU pool emptied a batch and try
> to allocate from the free pool if that still has objects available.
> 
>    	    kmem_cache_alloc()	kmem_cache_free()
> Baseline:   295k		245k
> Refill:	    225k		173k

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -255,6 +255,24 @@ static struct debug_obj *pcpu_alloc(void
>  
>  		if (likely(obj)) {
>  			pcp->cnt--;
> +			/*
> +			 * If this emptied a batch try to refill from the
> +			 * free pool. Don't do that if this was the top-most
> +			 * batch as pcpu_free() expects the per CPU pool
> +			 * to be less than ODEBUG_POOL_PERCPU_SIZE.
> +			 */
> +			if (unlikely(pcp->cnt < (ODEBUG_POOL_PERCPU_SIZE - ODEBUG_BATCH_SIZE) &&
> +				     !(pcp->cnt % ODEBUG_BATCH_SIZE))) {

It seems better to swap the contents on both sides of &&. Because the probability
of the current right side is lower.

> +				/*
> +				 * Don't try to allocate from the regular pool here
> +				 * to not exhaust it prematurely.
> +				 */
> +				if (pool_count(&pool_to_free)) {
> +					guard(raw_spinlock)(&pool_lock);
> +					pool_move_batch(pcp, &pool_to_free);
> +					pcpu_refill_stats();
> +				}
> +			}
>  			return obj;
>  		}
>  
> 
> .
> 

-- 
Regards,
  Zhen Lei

