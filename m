Return-Path: <linux-kernel+bounces-174083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCE8C0A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C141C21AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098B13CAA4;
	Thu,  9 May 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ie/rV9Ai"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08D1DDEB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224682; cv=none; b=sb+kqsiCViAd8eTV7hIo0CzD4WI65nviBwYMbJF68cWTMi1y4Z3HEKhjBubQG9pbfvPpguHB90nIsthxcYKjkpAMUx5peSD+30HfQXpk/XRqrdzFQn/TDya58SlZOwtLwJhb7QmIzLoDXabfI+NdbUHvXoJs/aLYIo1+Fs4C+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224682; c=relaxed/simple;
	bh=O1LF+1WwuiO61NvWh6v4wD8HfaJ8BIoTXYSzCTQmYKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icX8N5aHWWGKiWdd7Ly3/iMhgSWOUUGkFYxreTJ6H9LpHIEqhFj4WpOD+z/q8DLxYtte7uP8rly33lfR+cxYrPvAeKRVW7N8hrnchBJXaSKJfJVhgWR7C1qCrIfiGxmyjwtKYqVA3WprTq/z821glUY/b01P3X5scY9hV5D8d2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ie/rV9Ai; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715224677; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bJbpI4Ykw2bPEOET9QEYBge5aKOtp0FuvaBCPXYq4j8=;
	b=ie/rV9AiPdVq499F/55o8QEytk35qC6N7I5QRXAdNwrZqbBdmPBCREq4qmVhF23U6Bh8H2VVywjwx3dyG6297HgHmvlbLjPhiFfX3UBuDg9IZU/fsdfBMyn0cXgPtAD6fK9JHNrkQaDkcJ0IpkAIswfjWOylL3TywvojCB9Ymw8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W65OPA9_1715224674;
Received: from 30.97.48.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W65OPA9_1715224674)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 11:17:56 +0800
Message-ID: <edf204e5-1b06-4079-8116-62b517bc98e1@linux.alibaba.com>
Date: Thu, 9 May 2024 11:17:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: hailong.liu@oppo.com, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
 Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
 <CAGsJ_4xoqdd7+vWAnAdaib_NM8Snf=pxkThT1-b0aU-CPaQBYA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xoqdd7+vWAnAdaib_NM8Snf=pxkThT1-b0aU-CPaQBYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/9 11:09, Barry Song wrote:
> On Thu, May 9, 2024 at 2:39 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi,
>>
>> On 2024/5/9 10:20, Barry Song wrote:
>>> On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
>>>>
>>>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>>>
>>>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>>>> includes support for __GFP_NOFAIL, but it presents a conflict with
>>>> commit dd544141b9eb ("vmalloc: back off when the current task is
>>>> OOM-killed"). A possible scenario is as belows:
>>>>
>>>> process-a
>>>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>>>       __vmalloc_node_range()
>>>>           __vmalloc_area_node()
>>>>               vm_area_alloc_pages()
>>>>               --> oom-killer send SIGKILL to process-a
>>>>               if (fatal_signal_pending(current)) break;
>>>> --> return NULL;
>>>>
>>>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>>>> if __GFP_NOFAIL set.
>>>>
>>>> Reported-by: Oven <liyangouwen1@oppo.com>
>>>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>>>> ---
>>>>    mm/vmalloc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 6641be0ca80b..2f359d08bf8d 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>
>>>>           /* High-order pages or fallback path if "bulk" fails. */
>>>>           while (nr_allocated < nr_pages) {
>>>> -               if (fatal_signal_pending(current))
>>>> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>>>>                           break;
>>>
>>> why not !nofail ?
>>>
>>> This seems a correct fix, but it undermines the assumption made in
>>> commit dd544141b9eb
>>>    ("vmalloc: back off when the current task is OOM-killed")
>>>
>>> "
>>>       This may trigger some hidden problems, when caller does not handle
>>>       vmalloc failures, or when rollaback after failed vmalloc calls own
>>>       vmallocs inside.  However all of these scenarios are incorrect: vmalloc
>>>       does not guarantee successful allocation, it has never been called with
>>>       __GFP_NOFAIL and threfore either should not be used for any rollbacks or
>>>       should handle such errors correctly and not lead to critical failures.
>>> "
>>>
>>> If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
>>> reverting the fix intended to address the OOM-killer issue in commit
>>> dd544141b9eb.
>>> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>>
>> Just from my perspective, I don't really care about kmalloc, vmalloc
>> or kvmalloc (__GFP_NOFAIL).  I even don't care if it returns three
>> order-0 pages or a high-order page.   I just would like to need a
>> virtual consecutive buffer (even it works slowly.) with __GFP_NOFAIL.
>>
>> Because in some cases, writing fallback code may be tough and hard to
>> test if such fallback path is correct since it only triggers in extreme
>> workloads, and even such buffers are just used in a very short lifetime.
>> Also see other FS discussion of __GFP_NOFAIL, e.g.
>> https://lore.kernel.org/all/ZcUQfzfQ9R8X0s47@tiehlicka/
>>
>> In the worst cases, it usually just needs < 5 order-0 pages (for many
>> cases it only needs one page), but with kmalloc it will trigger WARN
>> if it occurs to > order-1 allocation. as I mentioned before.
>>
>> With my limited understanding I don't see why it could any problem with
>> kvmalloc(__GFP_NOFAIL) since it has no difference of kmalloc(GFP_NOFAIL)
>> with order-0 allocation.
> 
> I completely understand that you're not concerned about the origin of
> the memory,
> such as whether it's organized by all zero-order pages. However, in the event
> that someone else allocates a large memory, like several megabytes with the
> NOFAIL flag, commit dd544141b9eb aims to halt the allocation before success
> if the process being allocated is targeted for termination of OOM-killer.
> 
> With the current patch, we miss the opportunity for early allocation
> termination.
> However, if the size of the kvmalloc() is small, as in your case, I
> believe it should
> be perfectly fine. but do we have any way to prevent large size allocation with
> NOFAIL?

I think large size order-0 virtual consecutive allocation prevention
should be done by the callers (e.g. EROFS) other than memory subsystem,
since it totally sounds like caller bugs.

It doesn't make sense for me to block getting a virtual consecutive buffer
which only needs more than two (e.g. three or five) order-0 pages in the
extreme cases.

Yes, I need to prevent very insane allocations but it's an on-disk hard
limitation of a filesystem itself.

Thanks,
Gao Xiang

> 
>>
>>
>> Thanks,
>> Gao XIang
> 
> Thanks
> Barry

