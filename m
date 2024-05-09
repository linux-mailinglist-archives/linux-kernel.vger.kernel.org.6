Return-Path: <linux-kernel+bounces-174079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317268C0A00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BE31C212F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A635C13CAA4;
	Thu,  9 May 2024 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WnOqDtna"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24DD517
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224322; cv=none; b=Z0L1T4KHzq5Ooj0sQLeGhGk1FYe6LIU9r5MNAPvjac/FE7C1emkGM5DGWTVyea2yVRdOPBR7m2byUq+HtMrQPZkzkcPf0yDy2C0ptlcfHIW92r96uYSDSFGWl4ANUt3s+VZEq9yOPkzAV02s8+ejF5ygepuoiAp7AC1bP+r5nRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224322; c=relaxed/simple;
	bh=YfG0ih3FfAYJAHhpAgMhMaRIbJyjTL6x7d81gfZXnZo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qAlUCrZGa4NWbvzvOaeYcmq3AjcqXBNTpYBgpLGptxn1lxCiGOT/AYRlKOv6rMSBBNnNQ4x2V5qSlrQof3Nposn4CrVLuSW3OeUjx/oaEYYzglzrJyg4nW9wascXgdEA3J9LHhUPq/nhP8A7KGbsnyl+FSrS1KrZuA8bUDywSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WnOqDtna; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715224317; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=27nn0gbmoM0S5j5G2H5A+L8Sx0+wcMP1UH2vqgqnJH0=;
	b=WnOqDtnaeEEVjw2JcrPJeBrQFyj0ftn0io5w0nbsz9BRkeXBHWQlQv69Ud4zC+JHFSOZJAlYGNl0Sl+3wJYf0U/VO3H7Qd0Rh7/VNmfjem7QAuakbAG1aFXVsFOvww2Tyklqvm0lPGWOlPSfqGOcFgqvFTYOkoBizoOzHz5KlcM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W65FCcV_1715224314;
Received: from 30.97.48.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W65FCcV_1715224314)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 11:11:56 +0800
Message-ID: <c1f461e6-742b-45c1-9a35-4f2225ae8179@linux.alibaba.com>
Date: Thu, 9 May 2024 11:11:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Barry Song <21cnbao@gmail.com>, hailong.liu@oppo.com,
 Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
In-Reply-To: <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/9 10:39, Gao Xiang wrote:
> Hi,
> 
> On 2024/5/9 10:20, Barry Song wrote:
>> On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
>>>
>>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>>
>>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>>> includes support for __GFP_NOFAIL, but it presents a conflict with
>>> commit dd544141b9eb ("vmalloc: back off when the current task is
>>> OOM-killed"). A possible scenario is as belows:
>>>
>>> process-a
>>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>>      __vmalloc_node_range()
>>>          __vmalloc_area_node()
>>>              vm_area_alloc_pages()
>>>              --> oom-killer send SIGKILL to process-a
>>>              if (fatal_signal_pending(current)) break;
>>> --> return NULL;
>>>
>>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>>> if __GFP_NOFAIL set.
>>>
>>> Reported-by: Oven <liyangouwen1@oppo.com>
>>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>>> ---
>>>   mm/vmalloc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 6641be0ca80b..2f359d08bf8d 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>
>>>          /* High-order pages or fallback path if "bulk" fails. */
>>>          while (nr_allocated < nr_pages) {
>>> -               if (fatal_signal_pending(current))
>>> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>>>                          break;
>>
>> why not !nofail ?
>>
>> This seems a correct fix, but it undermines the assumption made in
>> commit dd544141b9eb
>>   ("vmalloc: back off when the current task is OOM-killed")
>>
>> "
>>      This may trigger some hidden problems, when caller does not handle
>>      vmalloc failures, or when rollaback after failed vmalloc calls own
>>      vmallocs inside.  However all of these scenarios are incorrect: vmalloc
>>      does not guarantee successful allocation, it has never been called with
>>      __GFP_NOFAIL and threfore either should not be used for any rollbacks or
>>      should handle such errors correctly and not lead to critical failures.
>> "
>>
>> If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
>> reverting the fix intended to address the OOM-killer issue in commit
>> dd544141b9eb.
>> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
> 
> Just from my perspective, I don't really care about kmalloc, vmalloc
> or kvmalloc (__GFP_NOFAIL).  I even don't care if it returns three
> order-0 pages or a high-order page.   I just would like to need a
> virtual consecutive buffer (even it works slowly.) with __GFP_NOFAIL.
> 
> Because in some cases, writing fallback code may be tough and hard to
> test if such fallback path is correct since it only triggers in extreme
> workloads, and even such buffers are just used in a very short lifetime.

add some words...

    ^ here extreme cases were mostly just generated by syzkaller fuzzing
tests, but if real users try to use some configuration to compress more,
I still think it needs to be handled (even such kvmalloc may be slow if
falling back to order-0 allocations due to memory pressures)

> Also see other FS discussion of __GFP_NOFAIL, e.g.
> https://lore.kernel.org/all/ZcUQfzfQ9R8X0s47@tiehlicka/
> 
> In the worst cases, it usually just needs < 5 order-0 pages (for many
> cases it only needs one page), but with kmalloc it will trigger WARN
> if it occurs to > order-1 allocation. as I mentioned before.
> 
> With my limited understanding I don't see why it could any problem with
> kvmalloc(__GFP_NOFAIL) since it has no difference of kmalloc(GFP_NOFAIL)
> with order-0 allocation.

. kvmalloc with order-0 pages to form a virtual consecutive buffer
just like several kmalloc(__GFP_NOFAIL) allocations together in the
callers, I don't see any difference of memory pressure here.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Gao XIang

