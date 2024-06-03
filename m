Return-Path: <linux-kernel+bounces-198917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968BC8D7F10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C71028338A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9484A4F;
	Mon,  3 Jun 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e19Jkq5X"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121E84A34
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407442; cv=none; b=Vj5MdxIfU9ArIV1cptIet6qpHvPwfXF3jow3xSaeHr6cjj4BMZctQ78++EsXKZkaw+glagQoS1QUi5HofU6tMtqI1mtQ6b5JZgZEeJO44FGbEZ8hydhHjyG8r1s0BWUXQWOPNqmf1ARk5SgYWva2pOo8qoPvp+f5xhrhP5+wX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407442; c=relaxed/simple;
	bh=NWTlpW6QobjmH+BM1dNPUWYU9mQVctb06bdqorK/vA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtRGiepjEqwCvTVnIbUrdVoC2kL0SVdYg0PJf+EJzZUhtc54tpmZ645SmnNXcKyiQu9gaQiuxfD2n88Rz5T/G+0BrH24jHHy/kEmt7s1XTVxc3Em3oPivAFzalKNS58mTrw7fkVJ1uvn86uol4nv5VD8Kph6bg8LkgwcXHR7bsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e19Jkq5X; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717407437; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Iva+9WQvYLiNTKeFAevO7LbMxV0uR7UoFIatWKMudCU=;
	b=e19Jkq5XQBIeQ19y8jzhAkAQhkMBOHxQCQVgkiP6UZl0zf4msfdLUwJh/ciP75LswRx0OkmCASNGhIbQshH8von43epRdjlpJLJIpHF0QYCjbARawATPf2q13sTyeqXoo2DbX2l1gTrdE0weXNpxHxTNT92c4ta4eZKwPsbzvqc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7lUb2m_1717407434;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7lUb2m_1717407434)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 17:37:15 +0800
Message-ID: <90fa2110-a74b-4445-b93d-63110a4a9f8a@linux.alibaba.com>
Date: Mon, 3 Jun 2024 17:37:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large
 folio
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4z60mrjuQ5qKCKn0+knk_M1dy=NsH4nVLqe5Khue_5gFw@mail.gmail.com>
 <e05df24a-6254-430e-88ca-6db23e5c6bab@linux.alibaba.com>
 <CAGsJ_4zsR=xA4sCSyMc0OafaRdp7ibRGpdc00mDFEqT6pSQbKA@mail.gmail.com>
 <CAGsJ_4yKaag+ryGvS=JMoYBXaKRTUoMacNXxgUCGe4YjucdqbQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yKaag+ryGvS=JMoYBXaKRTUoMacNXxgUCGe4YjucdqbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/3 17:01, Barry Song wrote:
> On Mon, Jun 3, 2024 at 8:58 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Jun 3, 2024 at 8:29 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2024/6/3 13:28, Barry Song wrote:
>>>> On Thu, May 30, 2024 at 2:04 PM Baolin Wang
>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>> Add large folio mapping establishment support for finish_fault() as a preparation,
>>>>> to support multi-size THP allocation of anonymous shmem pages in the following
>>>>> patches.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---------
>>>>>    1 file changed, 48 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index eef4e482c0c2..435187ff7ea4 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>    {
>>>>>           struct vm_area_struct *vma = vmf->vma;
>>>>>           struct page *page;
>>>>> +       struct folio *folio;
>>>>>           vm_fault_t ret;
>>>>>           bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>>>>                         !(vma->vm_flags & VM_SHARED);
>>>>> +       int type, nr_pages, i;
>>>>> +       unsigned long addr = vmf->address;
>>>>>
>>>>>           /* Did we COW the page? */
>>>>>           if (is_cow)
>>>>> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>                           return VM_FAULT_OOM;
>>>>>           }
>>>>>
>>>>> +       folio = page_folio(page);
>>>>> +       nr_pages = folio_nr_pages(folio);
>>>>> +
>>>>> +       /*
>>>>> +        * Using per-page fault to maintain the uffd semantics, and same
>>>>> +        * approach also applies to non-anonymous-shmem faults to avoid
>>>>> +        * inflating the RSS of the process.
>>>>
>>>> I don't feel the comment explains the root cause.
>>>> For non-shmem, anyway we have allocated the memory? Avoiding inflating
>>>> RSS seems not so useful as we have occupied the memory. the memory footprint
>>>
>>> This is also to keep the same behavior as before for non-anon-shmem, and
>>> will be discussed in the future.
>>
>> OK.
>>
>>>
>>>> is what we really care about. so we want to rely on read-ahead hints of subpage
>>>> to determine read-ahead size? that is why we don't map nr_pages for non-shmem
>>>> files though we can potentially reduce nr_pages - 1 page faults?
>>>
>>> IMHO, there is 2 cases for non-anon-shmem:
>>> (1) read mmap() faults: we can rely on the 'fault_around_bytes'
>>> interface to determin what size of mapping to build.
>>> (2) writable mmap() faults: I want to keep the same behavior as before
>>> (per-page fault), but we can talk about this when I send new patches to
>>> use mTHP to control large folio allocation for writable mmap().
>>
>> OK.
>>
>>>
>>>>> +        */
>>>>> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
>>>>> +               nr_pages = 1;
>>>>> +       } else if (nr_pages > 1) {
>>>>> +               pgoff_t idx = folio_page_idx(folio, page);
>>>>> +               /* The page offset of vmf->address within the VMA. */
>>>>> +               pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
>>>>> +
>>>>> +               /*
>>>>> +                * Fallback to per-page fault in case the folio size in page
>>>>> +                * cache beyond the VMA limits.
>>>>> +                */
>>>>> +               if (unlikely(vma_off < idx ||
>>>>> +                            vma_off + (nr_pages - idx) > vma_pages(vma))) {
>>>>> +                       nr_pages = 1;
>>>>> +               } else {
>>>>> +                       /* Now we can set mappings for the whole large folio. */
>>>>> +                       addr = vmf->address - idx * PAGE_SIZE;
>>>>> +                       page = &folio->page;
>>>>> +               }
>>>>> +       }
>>>>> +
>>>>>           vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>> -                                     vmf->address, &vmf->ptl);
>>>>> +                                      addr, &vmf->ptl);
>>>>>           if (!vmf->pte)
>>>>>                   return VM_FAULT_NOPAGE;
>>>>>
>>>>>           /* Re-check under ptl */
>>>>> -       if (likely(!vmf_pte_changed(vmf))) {
>>>>> -               struct folio *folio = page_folio(page);
>>>>> -               int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>>>>> -
>>>>> -               set_pte_range(vmf, folio, page, 1, vmf->address);
>>>>> -               add_mm_counter(vma->vm_mm, type, 1);
>>>>> -               ret = 0;
>>>>> -       } else {
>>>>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>> +       if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
>>>>> +               update_mmu_tlb(vma, addr, vmf->pte);
>>>>>                   ret = VM_FAULT_NOPAGE;
>>>>> +               goto unlock;
>>>>> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>>>>
>>>> In what case we can't use !pte_range_none(vmf->pte, 1) for nr_pages == 1
>>>> then unify the code for nr_pages==1 and nr_pages > 1?
>>>>
>>>> It seems this has been discussed before, but I forget the reason.
>>>
>>> IIUC, this is for uffd case, which is not a none pte entry.
>>
>> Is it possible to have a COW case for shmem? For example, if someone
>> maps a shmem
>> file as read-only and then writes to it, would that prevent the use of
>> pte_range_none?
> 
> sorry, i mean PRIVATE but not READ-ONLY.

Yes, I think so. Now CoW case still use per-page fault in do_cow_fault().

>> Furthermore, if we encounter a large folio in shmem while reading,
>> does it necessarily
>> mean we can map the entire folio? Is it possible for some processes to

Now this will depend on the 'fault_around_bytes' interface.

>> only map part
>> of large folios? For instance, if process A allocates large folios and
>> process B maps
>> only part of this shmem file or partially unmaps a large folio, how
>> would that be handled?

This is certainly possible.

For tmpfs:
(1) If 'fault_around_bytes' is enabled, filemap_map_pages() will handle 
partially mapping of the large folio for process B.

(2) If 'fault_around_bytes' is set to 0, finish_fault() will fallback to 
per-page fault.

For Anonomous shmem, process B should be the child of process A in your 
case, then:
(1) If 'fault_around_bytes' is enabled, behavior is same with tmpfs.

(2) If 'fault_around_bytes' is set to 0, finish_fault() will build the 
whole large folio mapping for process B. Since process B will copy the 
same shared VMA from parent process A, which means a mTHP mapping to share.

>> Apologies for not debugging this thoroughly, but these two corner
>> cases seem worth
>> considering. If these scenarios have already been addressed, please disregard my
>> comments.

No worries:) Thanks for your valuable input.

