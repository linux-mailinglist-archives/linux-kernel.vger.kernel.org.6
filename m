Return-Path: <linux-kernel+bounces-173498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCF8C012C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3401F271DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E0127B4B;
	Wed,  8 May 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xOtcRita"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92021A2C05
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182858; cv=none; b=til6DfD+3DftWu+8RMZNoBPa7Q2loF7ufxi4R/o8JQ5cAtFiq1a63I5rBcN5ib67RFQoL7nlBvKY2M48MldFbV0wpvtVZyCM0hhBUqp+y1f0dJiCvMQXOwqOyUS2vMXuY6+7DEPbirPxAA6gDLsnh2p3TyABK2p8gfbvy3sybTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182858; c=relaxed/simple;
	bh=F1Rp7bm1v7JDm1wmC7kHqlBoj7QvWLYP8Z3Rq0voJV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnvgnN8WfERF+yxalhRkKluyGgKzb2aq2n+Q3w2Aorbv0vh/CiAXvn3Am66Bf7go2UJOrn70CjqJXjrXY+MHvZIaW1cG51yK/WODgzzxVzNw2Avgdn+yTYnvm6mKRiG3fbuqhaNaerW+7ox/prxJPKJh/GpwFSk/siWNrlC4ogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xOtcRita; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715182852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XyuxJfEXTFVhGV1vkhbcNXjqNPlcKbZiS9jBEQ2/05o=;
	b=xOtcRitaE4E8LFHpAhq4YVngHii3JqrO8Ajgk5vpvjHAFNx6N+62RzGu0nXazfowmPpg67+U1KqFbblvUAfcGguSUBQt+miJTuwhnLhcr3LmEsBe0vpIJz3sFKwoRYwEhTS2ht+qKtiOmy0W1T6BKbvbUPtPUtFy/FF8gkP8nj0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W64.LOy_1715182848;
Received: from 30.25.222.148(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W64.LOy_1715182848)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 23:40:51 +0800
Message-ID: <52f9e300-4ab9-43c1-abae-cbe3da27e5b0@linux.alibaba.com>
Date: Wed, 8 May 2024 23:40:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Hailong Liu <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
 urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, xiang@kernel.org,
 chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
 <20240508144321.ymnhn54daaabalhe@oppo.com>
 <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
 <20240508153136.x4rxildsgza234uv@oppo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240508153136.x4rxildsgza234uv@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/8 23:31, Hailong Liu wrote:
> On Wed, 08. May 23:10, Gao Xiang wrote:
>> Hi,
>>
>> On 2024/5/8 22:43, Hailong Liu wrote:
>>> On Wed, 08. May 21:41, Gao Xiang wrote:
>>>>
>>>> +Cc Michal,
>>>>
>>>> On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
>>>>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>>>>
>>>>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>>>>> includes support for __GFP_NOFAIL, but it presents a conflict with
>>>>> commit dd544141b9eb ("vmalloc: back off when the current task is
>>>>> OOM-killed"). A possible scenario is as belows:
>>>>>
>>>>> process-a
>>>>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>>>>        __vmalloc_node_range()
>>>>> 	__vmalloc_area_node()
>>>>> 	    vm_area_alloc_pages()
>>>>>                --> oom-killer send SIGKILL to process-a
>>>>>                if (fatal_signal_pending(current)) break;
>>>>> --> return NULL;
>>>>>
>>>>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>>>>> if __GFP_NOFAIL set.
>>>>>
>>>>> Reported-by: Oven <liyangouwen1@oppo.com>
>>>>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>>>>
>>>> Why taging this as RFC here?  It seems a corner-case fix of
>>>> commit a421ef303008
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>
>>> Hi Gao Xiang:
>>>
>>> RFC here to wait for a better way to handle this case :).
>>> IMO, if vmalloc support __GFP_NOFAIL it should not return
>>> null even system is deadlock on memory.
>>
>> The starting point is that kmalloc doesn't support __GFP_NOFAIL
>> if order > 1 (even for very short temporary uses), see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.8#n2896
>>
>> but it is possible if we have such page pointer array (since two
>> (order-1) pages can only keep 1024 8-byte entries, it can happen
>> if compression ratios are high), and kvmalloc(__GFP_NOFAIL) has
>> already been supported for almost two years, it will fallback to
>> order-0 allocation as described in commit e9c3cda4d86e
>> ("mm, vmalloc: fix high order __GFP_NOFAIL allocations").
>>
>> With my limited understanding, I'm not sure why it can cause
>> deadlock here since it will fallback to order-0 allocation then,
>> and such allocation is just for short temporary uses again
>> because kmalloc doesn't support order > 1 short memory
>> allocation strictly.
>>
> 
> deadlock on memory meands there is a memory leak causing
> system to be unable to allocate memory not actual
> *deadlock*.

Where is memory leak? If it's caused by kvmalloc(__GFP_NOFAIL)
callers, then it's bugs of callers and we should fix the callers.

Also why kmalloc(__GFP_NOFAIL) (for example, also order-0
allocation) differs?

Thanks,
Gao Xiang


> 
>> Thanks,
>> Gao Xiang
>>
> 
> --
> 
> Best Regards,
> Hailong.

