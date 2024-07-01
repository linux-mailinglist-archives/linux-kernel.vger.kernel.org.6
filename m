Return-Path: <linux-kernel+bounces-235915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBE91DB38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA531C20C90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7384D12;
	Mon,  1 Jul 2024 09:14:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066EB43AD2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825280; cv=none; b=Ia7rKwybF8h/YPKJWYyYvS0UozXCs0pnhi1cJDA/a/8pytPZQUFNxAgvjM1DwSKapqQDsTYsCiqVrpQ1xyrw7VWbHyGBmxabfNjVDArrWxWxvHauZS7dzDEt6ZV+e9cuAQ5KuhQRlVsL8k0b7svVf0FedDcEj4B0xZ0q7ItPVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825280; c=relaxed/simple;
	bh=kw1IJZWIxeTgiurf3kOwpvy8kXCFRwNqIzsE5VfG4Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSVqEymqcXGFukAxG8pdqyhTi/qPb1FWmJhRTwQpXUA6fMAfJmVh0LbLDg46lTdwGWH4nGuxhwj+Ot9wBi7+L1/5bxqpIiHx+Q01n/J2vSfiA0h1hB2aiWoGF97Gy/DGaIRXqttlnIeiu2PwFWdFkFF4ea34rbCVtwECF3MVDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1198F339;
	Mon,  1 Jul 2024 02:15:02 -0700 (PDT)
Received: from [10.57.72.41] (unknown [10.57.72.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F3A23F766;
	Mon,  1 Jul 2024 02:14:35 -0700 (PDT)
Message-ID: <2e0a1554-d24f-4d0d-860b-0c2cf05eb8da@arm.com>
Date: Mon, 1 Jul 2024 10:14:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Bang Li
 <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org
Cc: wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com>
 <597ac51e-3f27-4606-8647-395bb4e60df4@redhat.com>
 <6f68fb9d-3039-4e38-bc08-44948a1dae4d@arm.com>
 <992cdbf9-80df-4a91-aea6-f16789c5afd7@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <992cdbf9-80df-4a91-aea6-f16789c5afd7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/07/2024 09:57, David Hildenbrand wrote:
> On 01.07.24 10:50, Ryan Roberts wrote:
>> On 01/07/2024 09:48, David Hildenbrand wrote:
>>> On 01.07.24 10:40, Ryan Roberts wrote:
>>>> On 01/07/2024 09:33, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>>>>> On 28/06/2024 11:49, Bang Li wrote:
>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>>>>> anonymous shmem"), we can configure different policies through
>>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>>>>> currently "THPeligible" indicates only whether the mapping is
>>>>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>>>>> mappable or not for anonymous shmem, we need to support semantics
>>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>>>>> anonymous memory.
>>>>>>>
>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>>>>> ---
>>>>>>>     fs/proc/task_mmu.c      | 10 +++++++---
>>>>>>>     include/linux/huge_mm.h | 11 +++++++++++
>>>>>>>     mm/shmem.c              |  9 +--------
>>>>>>>     3 files changed, 19 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>>>> index 93fb2c61b154..09b5db356886 100644
>>>>>>> --- a/fs/proc/task_mmu.c
>>>>>>> +++ b/fs/proc/task_mmu.c
>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>>>     {
>>>>>>>         struct vm_area_struct *vma = v;
>>>>>>>         struct mem_size_stats mss = {};
>>>>>>> +    bool thp_eligible;
>>>>>>>           smap_gather_stats(vma, &mss, 0);
>>>>>>>     @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>>>           __show_smap(m, &mss, false);
>>>>>>>     -    seq_printf(m, "THPeligible:    %8u\n",
>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>>>>>>> +    if (vma_is_anon_shmem(vma))
>>>>>>> +        thp_eligible =
>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>>>>
>>>>>> Afraid I haven't been following the shmem mTHP support work as much as I
>>>>>> would
>>>>>> have liked, but is there a reason why we need a separate function for shmem?
>>>>>
>>>>> Since shmem_allowable_huge_orders() only uses shmem specific logic to
>>>>> determine
>>>>> if huge orders are allowable, there is no need to complicate the
>>>>> thp_vma_allowable_orders() function by adding more shmem related logic, making
>>>>> it more bloated. In my view, providing a dedicated helper
>>>>> shmem_allowable_huge_orders(), specifically for shmem, simplifies the logic.
>>>>
>>>> My point was really that a single interface (thp_vma_allowable_orders)
>>>> should be
>>>> used to get this information. I have no strong opinon on how the implementation
>>>> of that interface looks. What you suggest below seems perfectly reasonable
>>>> to me.
>>>
>>> Right. thp_vma_allowable_orders() might require some care as discussed in other
>>> context (cleanly separate dax and shmem handling/orders). But that would be
>>> follow-up cleanups.
>>
>> Are you planning to do that, or do you want me to send a patch?
> 
> I'm planning on looking into some details, especially the interaction with large
> folios in the pagecache. I'll let you know once I have a better idea what
> actually should be done :)

OK great - I'll scrub it from my todo list... really getting things done today :)



