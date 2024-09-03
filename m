Return-Path: <linux-kernel+bounces-312877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C3969CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A778D28221C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA91C768F;
	Tue,  3 Sep 2024 12:06:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D781A42D6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365199; cv=none; b=egSsZfea0B4uC6XGMhh85erpA+xnnQQqh5hnEEvDoz9bqjwv83+Z4q+Iqf8cVaCAxbgVNA6il9GtSLv+0YlGRKZBofivoI2G+PCWiPaJKCDKoL3/d2tqQhp5WwpvfeVr1JrUv8UhYMIz0SQXdNcOEUx5lazBuRtzHJ5RFiZe/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365199; c=relaxed/simple;
	bh=sy03hUcUxnqokfHSvhnNTsDNiFZY74akAeG+3ml92e8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YoY5eSCyxQ1lXrOx3nfXFiXyOpJwvYJEzUpKnpBjTsAV38kU+PWXSMvM+t7w4mShxg+ex12bQp9vnVb0wAgSAdqR0mnAyvn0a05bNqsHyVMhRB8KS6KwG2Y/WMBuxlqD903grtKBhpFQ2Rh+tzM9AqisClmFw/u2Wdqxce7gVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wykpp1xdqzyR6K;
	Tue,  3 Sep 2024 20:05:38 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id B1D7918010A;
	Tue,  3 Sep 2024 20:06:34 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 20:06:34 +0800
Subject: Re: [PATCH 3/5] debugobjects: Don't start fill if there are remaining
 nodes locally
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <87o75583nv.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b3e5d119-8a29-3345-8074-ad1b47ca9cce@huawei.com>
Date: Tue, 3 Sep 2024 20:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o75583nv.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 17:52, Thomas Gleixner wrote:
> On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
> 
>> If the conditions for starting fill are met, it means that all cores that
>> call fill() later are blocked until the first core completes the fill
>> operation. But obviously, for a core that has free nodes locally, it does
>> not need to be blocked. This is good in stress situations.
> 
> Sure it's good, but is it correct? You need to explain why this can't> cause a pool depletion. The pool is filled opportunistically.
In the case of no nesting, a core uses only one node at a time.
Even if nesting occurs and there is only one local node,
256 / (16 + 1) = 15, the current parameter definition tolerates
15 cores, which should be sufficient. In fact, many cores may
see just >= 256 at the same time without filling. Therefore,
to eliminate the probability problem completely, an additional
mechanism is needed.

#define ODEBUG_POOL_MIN_LEVEL	256
#define ODEBUG_BATCH_SIZE	16

> 
> Aside of that the lock contention in fill_pool() is minimal. The heavy
> lifting is the allocation of objects.

I'm optimizing this, too. However, a new hlist helper function need to
be added. Now that you've mentioned it, I'll send it in V2 too!

> 
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index aba3e62a4315f51..fc8224f9f0eda8f 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -130,10 +130,15 @@ static void fill_pool(void)
>>  	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
>>  	struct debug_obj *obj;
>>  	unsigned long flags;
>> +	struct debug_percpu_free *percpu_pool;
> 
> Please keep variables in reverse fir tree order.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

OK, I will correct it.

>   
>>  	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
>>  		return;
>>  
>> +	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
> 
> You don't need the pointer
> 
>> +	if (likely(obj_cache) && percpu_pool->obj_free > 0)
> 
> 	if (likely(obj_cache) && this_cpu_read(percpu_pool.obj_free) > 0)

Nice, thanks

> 
> This lacks a comment explaining the rationale of this check.

OK, I'll add.

> 
> Thanks,
> 
>         tglx
> 
> 
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

