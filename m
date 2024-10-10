Return-Path: <linux-kernel+bounces-358723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12F9982D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690F81C26AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CD1BC9FE;
	Thu, 10 Oct 2024 09:51:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673D1BD515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553871; cv=none; b=FncUaHfjcIqncwJUxepe21ia6l1RSkLlsFG95lGxM10uSdtNC9CxQ4F9CxEJBBZd3Mz22lSBXSmb164b+441HzYNjoewiyxxs2ZyVk3lc/f70ehO8QybJr61xTy5ajJS4K1i9W55GhjkgaFtJ3RwvP9X5OAQfypZw0q9aEm4CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553871; c=relaxed/simple;
	bh=OXmSnYEpZYZy1dFj6CWPMB3jE7AFBgtLCQ7yCrI8VgA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eFui5MU3sIcooXEiErwVJfVtFja7h+4ZI0qsziScsVk0BPD29eHQJanX1QSeUNHdve9PO+zfHb/o9QKi5ekqpeO6FZNL1k8ov7pvuZmQeDDD+VZ85GWQg8lq+lvGReQsm94/fWY0gcMR33oZtDgNtxHeO/2mP1felLjW5ZNp4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPQ321GhrzySKF;
	Thu, 10 Oct 2024 17:49:50 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 854E518007C;
	Thu, 10 Oct 2024 17:51:07 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 17:51:07 +0800
Subject: Re: [patch 23/25] debugobjects: Double the per CPU slots
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.378676302@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c29da181-b333-7ec9-5c08-0db3cfd4a9fb@huawei.com>
Date: Thu, 10 Oct 2024 17:51:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.378676302@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> In situations where objects are rapidly allocated from the pool and handed
> back, the size of the per CPU pool turns out to be too small.
> 
> Double the size of the per CPU pool.
> 
> This reduces the kmem cache allocation and free operations during a kernel compile:
> 
>      	     alloc    	    free
> Baseline:    380k           330k
> Double size: 295k	    245k
> 
> Especially the reduction of allocations is important because that happens
> in the hot path when objects are initialized.
> 
> The maximum increase in per CPU pool memory consumption is about 2.5K per
> online CPU, which is acceptable.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -28,7 +28,7 @@
>  #define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
>  #define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
>  
> -#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
> +#define ODEBUG_POOL_PERCPU_SIZE	(8 * ODEBUG_BATCH_SIZE)
>  
>  #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
>  #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
> 
> .
> 

-- 
Regards,
  Zhen Lei

