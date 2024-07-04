Return-Path: <linux-kernel+bounces-240824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421F927346
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF9D281B8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC91AB51B;
	Thu,  4 Jul 2024 09:43:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D41A2555
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086210; cv=none; b=ns0nGv2RuLzkpBOel2leCZ1kOY4Mk+Mlia4hwEHSpb0wN4+laph0YGyVF/Svs/bWBHMp0xxbDjo7gt5GlYmtz05K1tEZcOyWzGoVSFDP6o6Chsq8otgFvNE2cR2IWfcLsfut9hX6xmnsA7PpqILtDm3z0aaMjjHJarrEf4B+jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086210; c=relaxed/simple;
	bh=XNVlXmwjWxTdsIpOYEgbBPXcbZLyYi+ZecX1qdtzNhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0AeFZ3+ykFCmyKr4Je6uW/ex6Bh+OeX8xJfKnleloRRCZAOQF7tj+2ap7mTO2ZtPnnqOmKg3enwqPt3DPhbkMZQHObfSU7uZvgIDAF+5AAd2KOakgbL8KLq2gJkrKeWl5Ebpb86iwC/RgWA9pFcHaEUlQqqZ/ab5jz6wO3A2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7DC367;
	Thu,  4 Jul 2024 02:43:45 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943333F766;
	Thu,  4 Jul 2024 02:43:18 -0700 (PDT)
Message-ID: <4de05ed8-6ec7-4b90-942c-a170a26be384@arm.com>
Date: Thu, 4 Jul 2024 10:43:17 +0100
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
To: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Bang Li
 <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com>
 <597ac51e-3f27-4606-8647-395bb4e60df4@redhat.com>
 <6f68fb9d-3039-4e38-bc08-44948a1dae4d@arm.com>
 <992cdbf9-80df-4a91-aea6-f16789c5afd7@redhat.com>
 <2e0a1554-d24f-4d0d-860b-0c2cf05eb8da@arm.com>
 <06c74db8-4d10-4a41-9a05-776f8dca7189@redhat.com>
 <429f2873-8532-4cc8-b0e1-1c3de9f224d9@arm.com>
 <7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com>
 <CAHbLzkrv2U39oOFuuHpmcfvDOuMayjwdgXLshxtDSSPGPzOkJQ@mail.gmail.com>
 <2450e4f8-236f-49ce-8bd3-b30a6d8c5e57@arm.com>
 <CAHbLzkponjBbtYo6F0+QJ_tmoUFa8i2VPCX7MGX758sAmyLtpQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkponjBbtYo6F0+QJ_tmoUFa8i2VPCX7MGX758sAmyLtpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/07/2024 17:08, Yang Shi wrote:
> On Tue, Jul 2, 2024 at 1:24 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 01/07/2024 19:20, Yang Shi wrote:
>>> On Mon, Jul 1, 2024 at 3:23 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 01.07.24 12:16, Ryan Roberts wrote:
>>>>> On 01/07/2024 10:17, David Hildenbrand wrote:
>>>>>> On 01.07.24 11:14, Ryan Roberts wrote:
>>>>>>> On 01/07/2024 09:57, David Hildenbrand wrote:
>>>>>>>> On 01.07.24 10:50, Ryan Roberts wrote:
>>>>>>>>> On 01/07/2024 09:48, David Hildenbrand wrote:
>>>>>>>>>> On 01.07.24 10:40, Ryan Roberts wrote:
>>>>>>>>>>> On 01/07/2024 09:33, Baolin Wang wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>>>>>>>>>>>> On 28/06/2024 11:49, Bang Li wrote:
>>>>>>>>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>>>>>>>>>>>> anonymous shmem"), we can configure different policies through
>>>>>>>>>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>>>>>>>>>>>> currently "THPeligible" indicates only whether the mapping is
>>>>>>>>>>>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>>>>>>>>>>>> mappable or not for anonymous shmem, we need to support semantics
>>>>>>>>>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>>>>>>>>>>>> anonymous memory.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>       fs/proc/task_mmu.c      | 10 +++++++---
>>>>>>>>>>>>>>       include/linux/huge_mm.h | 11 +++++++++++
>>>>>>>>>>>>>>       mm/shmem.c              |  9 +--------
>>>>>>>>>>>>>>       3 files changed, 19 insertions(+), 11 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>>>>>>>>>>> index 93fb2c61b154..09b5db356886 100644
>>>>>>>>>>>>>> --- a/fs/proc/task_mmu.c
>>>>>>>>>>>>>> +++ b/fs/proc/task_mmu.c
>>>>>>>>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>>>>>>>>>>       {
>>>>>>>>>>>>>>           struct vm_area_struct *vma = v;
>>>>>>>>>>>>>>           struct mem_size_stats mss = {};
>>>>>>>>>>>>>> +    bool thp_eligible;
>>>>>>>>>>>>>>             smap_gather_stats(vma, &mss, 0);
>>>>>>>>>>>>>>       @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void
>>>>>>>>>>>>>> *v)
>>>>>>>>>>>>>>             __show_smap(m, &mss, false);
>>>>>>>>>>>>>>       -    seq_printf(m, "THPeligible:    %8u\n",
>>>>>>>>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>>>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>>>>>>>>>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>>>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>>>>>>>>>>>>>> +    if (vma_is_anon_shmem(vma))
>>>>>>>>>>>>>> +        thp_eligible =
>>>>>>>>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>>>>>>>>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>>>>>>>>>>>
>>>>>>>>>>>>> Afraid I haven't been following the shmem mTHP support work as much as I
>>>>>>>>>>>>> would
>>>>>>>>>>>>> have liked, but is there a reason why we need a separate function for
>>>>>>>>>>>>> shmem?
>>>>>>>>>>>>
>>>>>>>>>>>> Since shmem_allowable_huge_orders() only uses shmem specific logic to
>>>>>>>>>>>> determine
>>>>>>>>>>>> if huge orders are allowable, there is no need to complicate the
>>>>>>>>>>>> thp_vma_allowable_orders() function by adding more shmem related logic,
>>>>>>>>>>>> making
>>>>>>>>>>>> it more bloated. In my view, providing a dedicated helper
>>>>>>>>>>>> shmem_allowable_huge_orders(), specifically for shmem, simplifies the logic.
>>>>>>>>>>>
>>>>>>>>>>> My point was really that a single interface (thp_vma_allowable_orders)
>>>>>>>>>>> should be
>>>>>>>>>>> used to get this information. I have no strong opinon on how the
>>>>>>>>>>> implementation
>>>>>>>>>>> of that interface looks. What you suggest below seems perfectly reasonable
>>>>>>>>>>> to me.
>>>>>>>>>>
>>>>>>>>>> Right. thp_vma_allowable_orders() might require some care as discussed in
>>>>>>>>>> other
>>>>>>>>>> context (cleanly separate dax and shmem handling/orders). But that would be
>>>>>>>>>> follow-up cleanups.
>>>>>>>>>
>>>>>>>>> Are you planning to do that, or do you want me to send a patch?
>>>>>>>>
>>>>>>>> I'm planning on looking into some details, especially the interaction with large
>>>>>>>> folios in the pagecache. I'll let you know once I have a better idea what
>>>>>>>> actually should be done :)
>>>>>>>
>>>>>>> OK great - I'll scrub it from my todo list... really getting things done today :)
>>>>>>
>>>>>> Resolved the khugepaged thiny already? :P
>>>>>>
>>>>>> [khugepaged not active when only enabling the sub-size via the 2M folder IIRC]
>>>>>
>>>>> Hmm... baby brain?
>>>>
>>>> :)
>>>>
>>>> I think I only mentioned it in a private mail at some point.
>>>>
>>>>>
>>>>> Sorry about that. I've been a bit useless lately. For some reason it wasn't on
>>>>> my list, but its there now. Will prioritise it, because I agree it's not good.
>>>>
>>>>
>>>> IIRC, if you do
>>>>
>>>> echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>>> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>>>
>>>> khugepaged will not get activated.
>>>
>>> khugepaged is controlled by the top level knob.
>>
>> What do you mean by "top level knob"? I assume
>> /sys/kernel/mm/transparent_hugepage/enabled ?
> 
> Yes.
> 
>>
>> If so, that's not really a thing in its own right; its just the legacy PMD-size
>> THP control, and we only take any notice of it if a per-size control is set to
>> "inherit". So if we have:
>>
>> # echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>
>> Then by design, /sys/kernel/mm/transparent_hugepage/enabled should be ignored.
>>
>>> But the above setting
>>> sounds confusing, can we disable the top level knob, but enable it on
>>> a per-order basis? TBH, it sounds weird and doesn't make too much
>>> sense to me.
>>
>> Well that's the design and that's how its documented. It's done this way for
>> back-compat. All controls are now per-size. But at boot, we default all per-size
>> controls to "never" except for the PMD-sized control, which is defaulted to
>> "inherit". That way, an unenlightened user-space can still control PMD-sized THP
>> via the legacy (top-level) control. But enlightened apps can directly control
>> per-size.
> 
> OK, good to know.
> 
>>
>> I'm not sure how your way would work, because you would have 2 controls
>> competing to do the same thing?
> 
> I don't see how they compete if they are 2-level knobs. 

I'm not sure I understand exactly how your 2-level proposal works. Could you
explain in more detail?

The problem as I see it, is that the control can take multiple values; "never",
"always" or "madvise". In a two-level scheme, what do we do when top level says
"always" but per-size control says "madvise", or vice-versa? The scheme we
adopted has clear and obvious (to me at least) semantics in this case.

The other problem is that the top-level control is still used to control file
memory collapse (when CONFIG_READ_ONLY_THP_FOR_FS is configured). If you're
advocating for a scheme where the top-level is set to the most permissive you
want to allow, then the per-size controls are only able to further restrict,
that would make it impossible to, for instance set all 2M THP (inc file-backed)
to madvise, but set all 64K THP to always.

> And I failed
> to see how it achieved back-compat. For example, memcached reads
> /sys/kernel/mm/transparent_hugepage/enabled to determine whether it
> should manage memory in huge page (2M) granularity. If the setting is
> set to :
> 
> # echo never > /sys/kernel/mm/transparent_hugepage/enabled
> # echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> memcached will manage memory in 4K granularity, but 2M THP is actually
> enabled unless memcached checks the per-order knobs.
> 
> If we use 2-level mode, memcached doesn't need check per-order setting
> at all in order to know whether THP is enabled or not. And it actually
> doesn't care about what orders are enabled, it assumes THP size is 2M
> (or PMD size). Even though 2M is not enabled but lower orders are
> enabled, memcached still can fully utilize the mTHP since the memory
> chunk managed by memcached is still 2M aligned in this setting. So
> unenlightened applications still can work well. Jemalloc should do the
> similar thing if I remember correctly.

I wonder why we didn't decide to just make
/sys/kernel/mm/transparent_hugepage/enabled an alias for
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled ? That may have
solved this problem more cleanly? But that would have made it difficult to
introduce "auto" in future (the idea was to set all per-size to 'inherit' and
then set top-level to 'auto').


> 
>>
>>>
>>>>
>>>> --
>>>> Cheers,
>>>>
>>>> David / dhildenb
>>>>
>>>>
>>


