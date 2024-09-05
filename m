Return-Path: <linux-kernel+bounces-316254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72396CD14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF19282581
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7E143759;
	Thu,  5 Sep 2024 03:11:58 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AD2E62B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505918; cv=none; b=cMDC1la/zdcNS3hK2XeI57UZ+/7cXS4MFTVJ/iGIstfVf7hBOD0r/o2ez7Q6h1uRSPEWkVuNzuFH7qq9BHPaXB7pq1jTYk7veiDQdFLfBnSCbZ4Tc829y1HfWgTwQJnCC7Bt5M8BGNbD+gNXMqG+00gUbZa7ohOpBmbudO8Y1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505918; c=relaxed/simple;
	bh=5gmZvQ6sukWr7ijJhfXhs89SjFPF160dbGv/qzJPr/4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ls10b/t01jO+/pWZulmRDyab3YOtHrBG0fhxvgjswZN6fRYCPK9SNnCorLPK0P8nQwFRuYpWu8BSORYw9UdyYUlaRoLzTzWlar9qclnfeY57qn3+yY37ySpRdKfk57xDAqP0hDu4O5cBLMfwRo/L9WxLNOFjOuB4QIQwndpQgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzksT6dXFz1j7rx;
	Thu,  5 Sep 2024 11:11:25 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id F22D71A0190;
	Thu,  5 Sep 2024 11:11:46 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 11:11:46 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
Date: Thu, 5 Sep 2024 11:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240904133944.2124-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/4 21:39, Zhen Lei wrote:
> If the conditions for starting fill are met, it means that all cores that
> call fill() later are blocked until the first core completes the fill
> operation. But obviously, for a core that has free nodes locally, it does
> not need to be blocked(see below for why). This is good in stress
> situations.
> 
> 1. In the case of no nesting, a core uses only one node at a time. As long
>    as there is a local node, there is no need to use the free node in
>    obj_pool.
> 2. In the case of nesting depth is one, nodes in obj_pool need to be used
>    only when there is only one local node.
>    #define ODEBUG_POOL_PERCPU_SIZE      64
>    #define ODEBUG_BATCH_SIZE            16
>    Assume that when nested, the probability of percpu_obj_pool having each
>    number of nodes is the same. The probability of only one node is less
>    than 1/17=6%. Assuming the probability of nesting is 5%, that's a
>    pretty high estimate. Then the probability of using obj_pool is
>    6% * 5% = 0.3%. In other words, a 333-core environment produces only
>    one core to compete for obj_pool.
>    #define ODEBUG_POOL_MIN_LEVEL        256
>    #define ODEBUG_BATCH_SIZE            16
>    But we can tolerate "256 / (16 + 1)" = 15 cores competing at the same
>    time.

One detail is omitted. In function debug_objects_mem_init(), an extra batch
is reserved for each core.
	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
	debug_objects_pool_min_level += extras;

In addition, above method of calculating probabilities is wrong. The correct
calculation method is as follows:
When the number of local nodes is 0, fill is performed. When the number of
local nodes is 1 and nested, 16 nodes are moved from obj_pool to obj_pool.
As a result, the obj_pool resource pool keeps decreasing. When this happens
continuously(The number of local nodes equal 0 is not met), the resource
pool will eventually be exhausted. The error probability is:
(1/2)^((256+16^ncpus)/17) * (5% + 5%^2 + ... + 5%^N) * 2/17 < 1e-7 (ncpus=1).
1/2 ==> denominator sequence: 0,1; numerator sequence: 1
(5% + 5%^2 + ... + 5%^N) < 5% + (5%^2) * 2 = 0.055
17 = ODEBUG_BATCH_SIZ + 1, amount moved from obj_pool when the number of local nodes is 0.
2/17 ==> denominator sequence: 0-16; numerator sequence: 0,1
The more cores, the lower the probability of exhaustion.

If obj_pool is not filled only when there are more than two local nodes,
the probability of exhaustion is:
(1/3)^((256+16^ncpus)/17) * (5% + 5%^2 + ... + 5%^N) * 3/17 < 2.3e-10
1/3 ==> denominator sequence: 0,1,2; numerator sequence: 2
3/17 ==> denominator sequence: 0-16; numerator sequence: 0,1,2

> 3. In the case of nesting depth more than one, the probability is lower
>    and negligible.
>    Nesting Depth=2: "2/17 * 5% * 5%" = 0.03%
>    Nesting Depth=3: "3/17 * 5% * 5% * 5%" = 0.002%
> 
> However, to ensure sufficient reliability, obj_pool is not filled only
> when there are more than two local nodes, reduce the probability of
> problems to the impossible.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  lib/debugobjects.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 7a8ccc94cb037ba..4f64b5d4329c27d 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -131,6 +131,16 @@ static void fill_pool(void)
>  	struct debug_obj *obj;
>  	unsigned long flags;
>  
> +	/*
> +	 * The upper-layer function uses only one node at a time. If there are
> +	 * more than two local nodes, it means that even if nesting occurs, it
> +	 * doesn't matter. The probability of nesting depth >= 2 is extremely
> +	 * low, and the number of global free nodes guarded by
> +	 * debug_objects_pool_min_level is adequate.
> +	 */
> +	if (likely(obj_cache) && this_cpu_read(percpu_obj_pool.obj_free) >= 2)
> +		return;
> +
>  	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
>  		return;
>  
> 

-- 
Regards,
  Zhen Lei

