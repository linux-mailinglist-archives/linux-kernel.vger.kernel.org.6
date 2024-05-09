Return-Path: <linux-kernel+bounces-173999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573C8C08E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AE3283856
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189CD13A3F3;
	Thu,  9 May 2024 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vk3oSltj"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FE6A33E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217046; cv=none; b=Fli15HRTkhUQ3cO37DOV/DCfhXJJaIdtpnsw/115dg3TCrw0kBk/d/J7YFkA7f6qbGpl44zQAKZl0+G91HBNdNmJKblVI0Bp2dsbckxKC3Ofmp2RUcf45pngiI9CIPPIvK2B7cqueZdr7JGKWt7tXSBXAVK5/zmjBLqyXcO1VjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217046; c=relaxed/simple;
	bh=tzxHlTOuw0/6sC3SURI/ydtWBAl4F1kDf7azIlZioQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQKporcx2cULIP7UdVBlBmrbMsuUkcOWDHC8TrNm2AQlZr4vuEQKPccdNGHBdhpcl+FQYZ+ux/stDc8Dl82uAPLroO5zhP8CNZZ/7zFF7fawEmLiQcb4+Tm+iJDVKAaDlmsyPGNgszPgpF14gWLRgUNtrtSl8AA7UqHD+tnikkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vk3oSltj; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715217040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4BqDry6rZsEe7WYoV9P+LOQn47pNlnrQoyVly4Xb9f0=;
	b=vk3oSltjh09zfrGJfVrsIpJTr7BSHILXUciCwQx6767bSWASsUjfkEpc6dl3IUCEMd+qrpR/6URUcTXXC9pxjfwe23Z42NLljb3CYqJrUpAwdTrWQhWItYoJGJYLuHiZiNjAJlqtvYg7k5oab/5tOE9yeOX2itNKb5nbJWmY0+Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W64wo0V_1715217036;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W64wo0V_1715217036)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 09:10:38 +0800
Message-ID: <fc7d3a7b-e4a9-48c3-9df3-5489c62789e7@linux.alibaba.com>
Date: Thu, 9 May 2024 09:10:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: memory: extend finish_fault() to support large
 folio
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
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
 <900579ab-ea0c-4ce1-ad33-4f81827081d4@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <900579ab-ea0c-4ce1-ad33-4f81827081d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/8 18:47, Ryan Roberts wrote:
> On 08/05/2024 10:31, Baolin Wang wrote:
>>
>>
>> On 2024/5/8 16:53, Ryan Roberts wrote:
>>> On 08/05/2024 04:44, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/5/7 18:37, Ryan Roberts wrote:
>>>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>>>> Add large folio mapping establishment support for finish_fault() as a
>>>>>> preparation,
>>>>>> to support multi-size THP allocation of anonymous shmem pages in the following
>>>>>> patches.
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>>     mm/memory.c | 43 +++++++++++++++++++++++++++++++++----------
>>>>>>     1 file changed, 33 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index eea6e4984eae..936377220b77 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>>     {
>>>>>>         struct vm_area_struct *vma = vmf->vma;
>>>>>>         struct page *page;
>>>>>> +    struct folio *folio;
>>>>>>         vm_fault_t ret;
>>>>>>         bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>>>>>                   !(vma->vm_flags & VM_SHARED);
>>>>>> +    int type, nr_pages, i;
>>>>>> +    unsigned long addr = vmf->address;
>>>>>>           /* Did we COW the page? */
>>>>>>         if (is_cow)
>>>>>> @@ -4780,24 +4783,44 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>>                 return VM_FAULT_OOM;
>>>>>>         }
>>>>>>     +    folio = page_folio(page);
>>>>>> +    nr_pages = folio_nr_pages(folio);
>>>>>> +
>>>>>> +    if (unlikely(userfaultfd_armed(vma))) {
>>>>>> +        nr_pages = 1;
>>>>>> +    } else if (nr_pages > 1) {
>>>>>> +        unsigned long start = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>>>>> +        unsigned long end = start + nr_pages * PAGE_SIZE;
>>>>>> +
>>>>>> +        /* In case the folio size in page cache beyond the VMA limits. */
>>>>>> +        addr = max(start, vma->vm_start);
>>>>>> +        nr_pages = (min(end, vma->vm_end) - addr) >> PAGE_SHIFT;
>>>>>> +
>>>>>> +        page = folio_page(folio, (addr - start) >> PAGE_SHIFT);
>>>>>
>>>>> I still don't really follow the logic in this else if block. Isn't it possible
>>>>> that finish_fault() gets called with a page from a folio that isn't aligned
>>>>> with
>>>>> vmf->address?
>>>>>
>>>>> For example, let's say we have a file who's size is 64K and which is cached
>>>>> in a
>>>>> single large folio in the page cache. But the file is mapped into a process at
>>>>> VA 16K to 80K. Let's say we fault on the first page (VA=16K). You will
>>>>> calculate
>>>>
>>>> For shmem, this doesn't happen because the VA is aligned with the hugepage size
>>>> in the shmem_get_unmapped_area() function. See patch 7.
>>>
>>> Certainly agree that shmem can always make sure that it packs a vma in a way
>>> such that its folios are naturally aligned in VA when faulting in memory. If you
>>> mremap it, that alignment will be lost; I don't think that would be a problem
>>
>> When mremap it, it will also call shmem_get_unmapped_area() to align the VA, but
>> for mremap() with MAP_FIXED flag as David pointed out, yes, this patch may be
>> not work perfectly.
> 
> Assuming this works similarly to anon mTHP, remapping to an arbitrary address
> shouldn't be a problem within a single process; the previously allocated folios
> will now be unaligned, but they will be correctly mapped so it doesn't break
> anything. And new faults will allocate folios so that they are as large as
> allowed by the sysfs interface AND which do not overlap with any non-none pte
> AND which are naturally aligned. It's when you start sharing with other
> processes that the fun and games start...
> 
>>
>>> for a single process; mremap will take care of moving the ptes correctly and
>>> this path is not involved.
>>>
>>> But what about the case when a process mmaps a shmem region, then forks, then
>>> the child mremaps the shmem region. Then the parent faults in a THP into the
>>> region (nicely aligned). Then the child faults in the same offset in the region
>>> and gets the THP that the parent allocated; that THP will be aligned in the
>>> parent's VM space but not in the child's.
>>
>> Sorry, I did not get your point here. IIUC, the child's VA will also be aligned
>> if the child mremap is not set MAP_FIXED, since the child's mremap will still
>> call shmem_get_unmapped_area() to find an aligned new VA.
> 
> In general, you shouldn't be relying on the vma bounds being aligned to a THP
> boundary.
> 
>> Please correct me if I missed your point.
> 
> (I'm not 100% sure this is definitely how it works, but seems the only sane way
> to me):
> 
> Let's imagine we have a process that maps 4 pages of shared anon memory at VA=64K:
> 
>    mmap(64K, 16K, PROT_X, MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, ...)
> 
> Then it forks a child, and the child moves the mapping to VA=68K:
> 
>    mremap(64K, 16K, 16K, MREMAP_FIXED | MREMAP_MAYMOVE, 68K)
> 
> Then the parent writes to address 64K (offset 0 in the shared region); this will
> fault and cause a 16K mTHP to be allocated and mapped, covering the whole region
> at 64K-80K in the parent.
> 
> Then the child reads address 68K (offset 0 in the shared region); this will
> fault and cause the previously allocated 16K folio to be looked up and it must
> be mapped in the child between 68K-84K. This is not naturally aligned in the child.
> 
> For the child, your code will incorrectly calculate start/end as 64K-80K.

OK, so you set MREMAP_FIXED flag, just as David pointed out. Yes, it 
will not aligned in the child for this case. Thanks for the explanation.

