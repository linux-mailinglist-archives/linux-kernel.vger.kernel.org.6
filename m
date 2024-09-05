Return-Path: <linux-kernel+bounces-316475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DE96D013
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298611C22A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D29192D79;
	Thu,  5 Sep 2024 07:04:19 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156ED1925BB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519858; cv=none; b=Iq0w85tltUN2NLeT71MWfpGFqsH1ih1m4w1ZkFamVUIUr76md1GqWJLgpcd04wGKg4hunF75VhoSjQlL7aU5edmZ2U6gIZKjvRUstsnSLp17B1H37Wq06K2HFN/tRUcsI7CCJNljnXX2KzEzrNvlNdjCoCIFM31sBLwBJryAuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519858; c=relaxed/simple;
	bh=6TreK1AMfwp8DrqbjRh4hzKOjl0roMFm7yxkJH3c06c=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QEKc1wEVoTlABT9Dw+WJ9hpxp6AULoC8QJLyzjMupKbdLejGairBL3Y2sA6/MBrnwZlZsDlri+G9S3M+fMiLs7ATt33KwRZgTfTAubGS6lWixSUldaI9P+mkyQPmu4ObJ2kmdhdsOMN9de8Zuwjo2HXFwYNRmtn/pPJWTM5daKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wzr1f4ql5z2Dbn1;
	Thu,  5 Sep 2024 15:03:50 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F8141400DC;
	Thu,  5 Sep 2024 15:04:12 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 15:04:11 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com>
Message-ID: <711bf7dd-1f57-7cee-54b0-e439a70db967@huawei.com>
Date: Thu, 5 Sep 2024 15:04:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/5 11:45, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/9/5 11:11, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2024/9/4 21:39, Zhen Lei wrote:
>>> If the conditions for starting fill are met, it means that all cores that
>>> call fill() later are blocked until the first core completes the fill
>>> operation. But obviously, for a core that has free nodes locally, it does
>>> not need to be blocked(see below for why). This is good in stress
>>> situations.
>>>
>>> 1. In the case of no nesting, a core uses only one node at a time. As long
>>>    as there is a local node, there is no need to use the free node in
>>>    obj_pool.
>>> 2. In the case of nesting depth is one, nodes in obj_pool need to be used
>>>    only when there is only one local node.
>>>    #define ODEBUG_POOL_PERCPU_SIZE      64
>>>    #define ODEBUG_BATCH_SIZE            16
>>>    Assume that when nested, the probability of percpu_obj_pool having each
>>>    number of nodes is the same. The probability of only one node is less
>>>    than 1/17=6%. Assuming the probability of nesting is 5%, that's a
>>>    pretty high estimate. Then the probability of using obj_pool is
>>>    6% * 5% = 0.3%. In other words, a 333-core environment produces only
>>>    one core to compete for obj_pool.
>>>    #define ODEBUG_POOL_MIN_LEVEL        256
>>>    #define ODEBUG_BATCH_SIZE            16
>>>    But we can tolerate "256 / (16 + 1)" = 15 cores competing at the same
>>>    time.
>>
>> One detail is omitted. In function debug_objects_mem_init(), an extra batch
>> is reserved for each core.
>> 	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
>> 	debug_objects_pool_min_level += extras;
>>
>> In addition, above method of calculating probabilities is wrong. The correct
>> calculation method is as follows:
>> When the number of local nodes is 0, fill is performed. When the number of
>> local nodes is 1 and nested, 16 nodes are moved from obj_pool to obj_pool.
>> As a result, the obj_pool resource pool keeps decreasing. When this happens
>> continuously(The number of local nodes equal 0 is not met), the resource
>> pool will eventually be exhausted. The error probability is:
>> (1/2)^((256+16^ncpus)/17) * (5% + 5%^2 + ... + 5%^N) * 2/17 < 1e-7 (ncpus=1).
> 
> Should be:
> ==> (1/2)^((256+16^ncpus)/17) * 5% * 2/17 < 9e-8 (ncpus=1).
> 
>> 1/2 ==> denominator sequence: 0,1; numerator sequence: 1
>> (5% + 5%^2 + ... + 5%^N) < 5% + (5%^2) * 2 = 0.055
>> 17 = ODEBUG_BATCH_SIZ + 1, amount moved from obj_pool when the number of local nodes is 0.
>> 2/17 ==> denominator sequence: 0-16; numerator sequence: 0,1
>> The more cores, the lower the probability of exhaustion.
>>
>> If obj_pool is not filled only when there are more than two local nodes,
>> the probability of exhaustion is:
>> (1/3)^((256+16^ncpus)/17) * (5% + 5%^2 + ... + 5%^N) * 3/17 < < 2.3e-10
> 
> Should be:
> ==> (1/3)^((256+16^ncpus)/17) * (5%^2) * 3/17 < 1.03e-11 (ncpus=1).
> 
>> 1/3 ==> denominator sequence: 0,1,2; numerator sequence: 2
>> 3/17 ==> denominator sequence: 0-16; numerator sequence: 0,1,2
> 
> Hi, Thomas Gleixner:
>   Seems to need to add an additional patch as follows to be foolproof.
> I'll prepare it.

I've rethinked this problem, and there's another remedy. When the number
of remaining free nodes is less than half of debug_objects_pool_min_level,
still do fill. In this way, "nr_cpus/2 + 256/(16+1)" cores are required to
bypass the check before obj_pool_free is updated, which is almost impossible.

But then again, I'm just theoretical, and I don't have the data, so maybe
the best solution is to give up this patch and talk about it in future.

By the way, I've found a new concern.
	static int debug_objects_pool_size = ODEBUG_POOL_SIZE;			//1024
	static int debug_objects_pool_min_level = ODEBUG_POOL_MIN_LEVEL;	//256
	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;			//16
	debug_objects_pool_size += extras;
	debug_objects_pool_min_level += extras;
When there are so many cores, it should be easier to walk back and forth
around debug_objects_pool_min_level. For example, nr_cpus=128,
	debug_objects_pool_min_level = 128 *16 + 256 = 2304
	debug_objects_pool_size - debug_objects_pool_min_level = 768	//fixed
There are many more loafers than workers. As above, it's better to
discuss it in future.

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 58de57090ac6389..2eb246901cf5367 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -135,6 +135,10 @@ static void fill_pool(void)
        if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
                return;

+       if (likely(obj_cache) &&
+           this_cpu_read(percpu_obj_pool.obj_free) > 0 &&
+           likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level / 2))
+               return;
        /*
         * Reuse objs from the global tofree list; they will be reinitialized
         * when allocating.


> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index e175cc74f7b7899..d3f8cc7dc1c9291 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -245,6 +245,21 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
> 
>         raw_spin_lock(&pool_lock);
>         obj = __alloc_object(&obj_pool);
> +       if (!obj) {
> +               raw_spin_unlock(&pool_lock);
> +               obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | GFP_NOWAIT);
> +               if (!obj)
> +                       return NULL;
> +
> +               raw_spin_lock(&pool_lock);
> +               debug_objects_allocated++;
> +
> +               /*
> +                * It can be understood that obj is allocated immediately after
> +                * being added to obj_pool.
> +                */
> +               obj_pool_used++;
> +       }
>         if (obj) {
>                 int cnt = 0;
> 
> 
> 
>>
>>> 3. In the case of nesting depth more than one, the probability is lower
>>>    and negligible.
>>>    Nesting Depth=2: "2/17 * 5% * 5%" = 0.03%
>>>    Nesting Depth=3: "3/17 * 5% * 5% * 5%" = 0.002%
>>>
>>> However, to ensure sufficient reliability, obj_pool is not filled only
>>> when there are more than two local nodes, reduce the probability of
>>> problems to the impossible.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  lib/debugobjects.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>> index 7a8ccc94cb037ba..4f64b5d4329c27d 100644
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -131,6 +131,16 @@ static void fill_pool(void)
>>>  	struct debug_obj *obj;
>>>  	unsigned long flags;
>>>  
>>> +	/*
>>> +	 * The upper-layer function uses only one node at a time. If there are
>>> +	 * more than two local nodes, it means that even if nesting occurs, it
>>> +	 * doesn't matter. The probability of nesting depth >= 2 is extremely
>>> +	 * low, and the number of global free nodes guarded by
>>> +	 * debug_objects_pool_min_level is adequate.
>>> +	 */
>>> +	if (likely(obj_cache) && this_cpu_read(percpu_obj_pool.obj_free) >= 2)
>>> +		return;
>>> +
>>>  	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
>>>  		return;
>>>  
>>>
>>
> 

-- 
Regards,
  Zhen Lei

