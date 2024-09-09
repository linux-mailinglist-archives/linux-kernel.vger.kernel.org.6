Return-Path: <linux-kernel+bounces-321229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502EC971629
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CDA1F23AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC471B5EAF;
	Mon,  9 Sep 2024 11:03:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EE1B5EA1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879819; cv=none; b=mHYGY9DlO1Ml22w8qVfFiA8/j6jdOGN+NIL7VMLrlWwXXcT2bFTlYHjPr8KvURw9kAQ65yG5TxJxtaSmelC/yAQ9z05xibt2vnGFYhqVBY1QoRGkQMe0gs2ixI2UTWb7edRNTccCq/IDE3lO95HDNnPXXcJRUWhtwaGb49S6HUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879819; c=relaxed/simple;
	bh=TC17ossRNQACYbUYPo0ROZa7ygaNNGgBFMadhOE9NKk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ebVEtklQl8BVHMWSeiViIfmscWTjGL3x5myWXdRL7onsraRnRtGagV4085NMYHtSbaiuXYuEm8GIPdy6icCwm5tl9Lgg+cfO+6P2KpxAkYu5E6QJLYbRCI2Ev/c02Y8kg/QK+c556xrgHoJ7QTO/JpLQa7q6kpjbvKywlwcQ84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X2P660s1zzpVXh;
	Mon,  9 Sep 2024 19:01:34 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E703180087;
	Mon,  9 Sep 2024 19:03:34 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 19:03:34 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cf687aec-f8fe-c032-e22b-6572edc529a3@huawei.com>
Date: Mon, 9 Sep 2024 19:03:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87ed5tchc6.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/9 17:22, Thomas Gleixner wrote:
> On Thu, Sep 05 2024 at 11:45, Leizhen wrote:
>> On 2024/9/5 11:11, Leizhen (ThunderTown) wrote:
>>   Seems to need to add an additional patch as follows to be foolproof.
>> I'll prepare it.
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index e175cc74f7b7899..d3f8cc7dc1c9291 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -245,6 +245,21 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
>>
>>         raw_spin_lock(&pool_lock);
>>         obj = __alloc_object(&obj_pool);
>> +       if (!obj) {
>> +               raw_spin_unlock(&pool_lock);
>> +               obj = kmem_cache_zalloc(obj_cache, __GFP_HIGH | GFP_NOWAIT);
>> +               if (!obj)
>> +                       return NULL;
>> +
>> +               raw_spin_lock(&pool_lock);
>> +               debug_objects_allocated++;
>> +
>> +               /*
>> +                * It can be understood that obj is allocated immediately after
>> +                * being added to obj_pool.
>> +                */
>> +               obj_pool_used++;
>> +       }
>>         if (obj) {
>>                 int cnt = 0;
> 
> No. That fails on RT. See debug_object_fill_pool().

OK, I got it, thanks.

> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

