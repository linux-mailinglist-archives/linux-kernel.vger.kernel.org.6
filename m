Return-Path: <linux-kernel+bounces-173080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C52D8BFB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3314F28184E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE181737;
	Wed,  8 May 2024 10:47:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883A2836D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165233; cv=none; b=mCvHn2Xo5Jay7Q1hdoRJY4v8CoWKhaM6pkz94s8PLq9tBYmG0M9WnVbBmQYyjfR5R1A/UtxC5LDQtSnMtQfiL+1G/9pajwZdkCBs7GJA6Y7naGNlWYiPo0P7bQkF30dFEOjCnq3lmBzhFCByUJwF+ufRMLo5qeD1toN6UbuzILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165233; c=relaxed/simple;
	bh=0cfvpd+TLvQba0fltgS/GS6+JtmRpMgv92fdlu9WThw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7+uT1arPluliXdgYiLdOt/PQgWp6JK3i3zaBSkmxHnLqtHNT9UkWJBEUlpPTdZEq9dufpQm8pPPs/T2YehQQXBn9xsVj1BfOOq0VRlYpZMEjuzoWNsa3gNYHRpJJwQsAo+3aEO8g60BsMmwGEvg9ypWzNc8uDwy2m5IREdN1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ACAA1063;
	Wed,  8 May 2024 03:47:35 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FA93F587;
	Wed,  8 May 2024 03:47:07 -0700 (PDT)
Message-ID: <900579ab-ea0c-4ce1-ad33-4f81827081d4@arm.com>
Date: Wed, 8 May 2024 11:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: memory: extend finish_fault() to support large
 folio
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <e3f4ae78ef2d565a65fadaa843e53a24bf5b57e4.1714978902.git.baolin.wang@linux.alibaba.com>
 <13939ade-a99a-4075-8a26-9be7576b7e03@arm.com>
 <d2bd3277-7ef5-4909-a149-6895ad95459e@linux.alibaba.com>
 <e5c5b9ff-e874-4d97-a036-48178bd147cc@arm.com>
 <3d87da24-7887-4912-abcf-14062e8514de@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3d87da24-7887-4912-abcf-14062e8514de@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 10:31, Baolin Wang wrote:
> 
> 
> On 2024/5/8 16:53, Ryan Roberts wrote:
>> On 08/05/2024 04:44, Baolin Wang wrote:
>>>
>>>
>>> On 2024/5/7 18:37, Ryan Roberts wrote:
>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>> Add large folio mapping establishment support for finish_fault() as a
>>>>> preparation,
>>>>> to support multi-size THP allocation of anonymous shmem pages in the following
>>>>> patches.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    mm/memory.c | 43 +++++++++++++++++++++++++++++++++----------
>>>>>    1 file changed, 33 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index eea6e4984eae..936377220b77 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>    {
>>>>>        struct vm_area_struct *vma = vmf->vma;
>>>>>        struct page *page;
>>>>> +    struct folio *folio;
>>>>>        vm_fault_t ret;
>>>>>        bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>>>>                  !(vma->vm_flags & VM_SHARED);
>>>>> +    int type, nr_pages, i;
>>>>> +    unsigned long addr = vmf->address;
>>>>>          /* Did we COW the page? */
>>>>>        if (is_cow)
>>>>> @@ -4780,24 +4783,44 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>                return VM_FAULT_OOM;
>>>>>        }
>>>>>    +    folio = page_folio(page);
>>>>> +    nr_pages = folio_nr_pages(folio);
>>>>> +
>>>>> +    if (unlikely(userfaultfd_armed(vma))) {
>>>>> +        nr_pages = 1;
>>>>> +    } else if (nr_pages > 1) {
>>>>> +        unsigned long start = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>>>> +        unsigned long end = start + nr_pages * PAGE_SIZE;
>>>>> +
>>>>> +        /* In case the folio size in page cache beyond the VMA limits. */
>>>>> +        addr = max(start, vma->vm_start);
>>>>> +        nr_pages = (min(end, vma->vm_end) - addr) >> PAGE_SHIFT;
>>>>> +
>>>>> +        page = folio_page(folio, (addr - start) >> PAGE_SHIFT);
>>>>
>>>> I still don't really follow the logic in this else if block. Isn't it possible
>>>> that finish_fault() gets called with a page from a folio that isn't aligned
>>>> with
>>>> vmf->address?
>>>>
>>>> For example, let's say we have a file who's size is 64K and which is cached
>>>> in a
>>>> single large folio in the page cache. But the file is mapped into a process at
>>>> VA 16K to 80K. Let's say we fault on the first page (VA=16K). You will
>>>> calculate
>>>
>>> For shmem, this doesn't happen because the VA is aligned with the hugepage size
>>> in the shmem_get_unmapped_area() function. See patch 7.
>>
>> Certainly agree that shmem can always make sure that it packs a vma in a way
>> such that its folios are naturally aligned in VA when faulting in memory. If you
>> mremap it, that alignment will be lost; I don't think that would be a problem
> 
> When mremap it, it will also call shmem_get_unmapped_area() to align the VA, but
> for mremap() with MAP_FIXED flag as David pointed out, yes, this patch may be
> not work perfectly.

Assuming this works similarly to anon mTHP, remapping to an arbitrary address
shouldn't be a problem within a single process; the previously allocated folios
will now be unaligned, but they will be correctly mapped so it doesn't break
anything. And new faults will allocate folios so that they are as large as
allowed by the sysfs interface AND which do not overlap with any non-none pte
AND which are naturally aligned. It's when you start sharing with other
processes that the fun and games start...

> 
>> for a single process; mremap will take care of moving the ptes correctly and
>> this path is not involved.
>>
>> But what about the case when a process mmaps a shmem region, then forks, then
>> the child mremaps the shmem region. Then the parent faults in a THP into the
>> region (nicely aligned). Then the child faults in the same offset in the region
>> and gets the THP that the parent allocated; that THP will be aligned in the
>> parent's VM space but not in the child's.
> 
> Sorry, I did not get your point here. IIUC, the child's VA will also be aligned
> if the child mremap is not set MAP_FIXED, since the child's mremap will still
> call shmem_get_unmapped_area() to find an aligned new VA.

In general, you shouldn't be relying on the vma bounds being aligned to a THP
boundary.

> Please correct me if I missed your point.

(I'm not 100% sure this is definitely how it works, but seems the only sane way
to me):

Let's imagine we have a process that maps 4 pages of shared anon memory at VA=64K:

  mmap(64K, 16K, PROT_X, MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, ...)

Then it forks a child, and the child moves the mapping to VA=68K:

  mremap(64K, 16K, 16K, MREMAP_FIXED | MREMAP_MAYMOVE, 68K)

Then the parent writes to address 64K (offset 0 in the shared region); this will
fault and cause a 16K mTHP to be allocated and mapped, covering the whole region
at 64K-80K in the parent.

Then the child reads address 68K (offset 0 in the shared region); this will
fault and cause the previously allocated 16K folio to be looked up and it must
be mapped in the child between 68K-84K. This is not naturally aligned in the child.

For the child, your code will incorrectly calculate start/end as 64K-80K.

> 
>>>> start=0 and end=64K I think?
>>>
>>> Yes. Unfortunately, some file systems that support large mappings do not perform
>>> alignment for multi-size THP (non-PMD sized, for example: 64K). I think this
>>> requires modification to __get_unmapped_area--->thp_get_unmapped_area_vmflags()
>>> or file->f_op->get_unmapped_area() to align VA for multi-size THP in future.
>>
>> By nature of the fact that a file mapping is shared between multiple processes
>> and each process can map it where ever it wants down to 1 page granularity, its
>> impossible for any THP containing a part of that file to be VA-aligned in every
>> process it is mapped in.
> 
> Yes, so let me re-polish this patch. Thanks.
> 
>>> So before adding that VA alignment changes, only allow building the large folio
>>> mapping for anonymous shmem:
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 936377220b77..9e4d51826d23 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4786,7 +4786,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>          folio = page_folio(page);
>>>          nr_pages = folio_nr_pages(folio);
>>>
>>> -       if (unlikely(userfaultfd_armed(vma))) {
>>> +       if (unlikely(userfaultfd_armed(vma)) || !vma_is_anon_shmem(vma)) {
>>
>> If the above theoretical flow for fork & mremap is valid, then I don't think
>> this is sufficient.
>>
>>>                  nr_pages = 1;
>>>          } else if (nr_pages > 1) {
>>>                  unsigned long start = ALIGN_DOWN(vmf->address, nr_pages *
>>> PAGE_SIZE);
>>>
>>>> Additionally, I think this path will end up mapping the entire folio (as
>>>> long as
>>>> it fits in the VMA). But this bypasses the fault-around configuration. As I
>>>> think I mentioned against the RFC, this will inflate the RSS of the process and
>>>> can cause behavioural changes as a result. I believe the current advice is to
>>>> disable fault-around to prevent this kind of bloat when needed.
>>>
>>> With above change, I do not think this is a problem? since users already want to
>>> use mTHP for anonymous shmem.
>>>
>>>> It might be that you need a special variant of finish_fault() for shmem?
>>>>
>>>>
>>>>> +    }
>>>>>        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>> -                      vmf->address, &vmf->ptl);
>>>>> +                       addr, &vmf->ptl);
>>>>>        if (!vmf->pte)
>>>>>            return VM_FAULT_NOPAGE;
>>>>>          /* Re-check under ptl */
>>>>> -    if (likely(!vmf_pte_changed(vmf))) {
>>>>> -        struct folio *folio = page_folio(page);
>>>>> -        int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>>>>> -
>>>>> -        set_pte_range(vmf, folio, page, 1, vmf->address);
>>>>> -        add_mm_counter(vma->vm_mm, type, 1);
>>>>> -        ret = 0;
>>>>> -    } else {
>>>>> -        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>> +    if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
>>>>> +        update_mmu_tlb(vma, addr, vmf->pte);
>>>>> +        ret = VM_FAULT_NOPAGE;
>>>>> +        goto unlock;
>>>>> +    } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>>>>> +        for (i = 0; i < nr_pages; i++)
>>>>> +            update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>>>>>            ret = VM_FAULT_NOPAGE;
>>>>> +        goto unlock;
>>>>>        }
>>>>>    +    set_pte_range(vmf, folio, page, nr_pages, addr);
>>>>> +    type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>>>>> +    add_mm_counter(vma->vm_mm, type, nr_pages);
>>>>> +    ret = 0;
>>>>> +
>>>>> +unlock:
>>>>>        pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>        return ret;
>>>>>    }


