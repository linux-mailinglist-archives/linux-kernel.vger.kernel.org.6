Return-Path: <linux-kernel+bounces-172954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF778BF93A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBD5B221B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487B71B49;
	Wed,  8 May 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qzHefu3b"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECC3FE28
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159196; cv=none; b=gFPzp9BKadE5opaGGRLGHw0O2tV3HeJE4KQZSnL+Tmb7KlzimyPm/FpR80sw44PQ0BBgrnx6X1zVX0xOy2rmMTcLjVg4El3Ul2v7ZsQ9PGGXufLU0RVbwp72V4F9fU+SHimHnKL+cQACYUnoBYYIG6QlnxPHXZB6SeLouSzhRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159196; c=relaxed/simple;
	bh=8csx+naagCqO/zvRIhM1X5vjt6yhuL5MXp8F/9kLP3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmQbqVArowUU36VDvCmTocWFkx4yaQ9m2WE7YNRjLYk7hgpvIUPa97lHbqbv1W81cYbxJAmKS9cLdJ7vnxGAQ4bhyJ5fuZGOFy6lVmVilV4hkKTTcl50EdYcchHoxu+pa/JVRExOqxRchVk4AEoGbqMdVdtyukbLskODq9lyznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qzHefu3b; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715159192; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WHW+W0hGmLqX3Dp0aX8KDuI73KYPXnLkoFXURlwq6lM=;
	b=qzHefu3b02q9/nic5wWAfhnJWN6oSi8Em4vR5Gb/SOD9BpR6GR6pSTB6p7v6lBy1wr+cX7B2Isl3W0dsRiT0iBy6W0bvGX6e6owPmnvxtD1DiGIFreCmzG7FptLbi/XJc9iVQ5J2NF8lx5ura1SS10V6I4sxBPm/js3OSDZnED4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W638hki_1715159189;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W638hki_1715159189)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 17:06:30 +0800
Message-ID: <043a4f2d-e08d-4cea-a73d-819586509b12@linux.alibaba.com>
Date: Wed, 8 May 2024 17:06:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: memory: extend finish_fault() to support large
 folio
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <e3f4ae78ef2d565a65fadaa843e53a24bf5b57e4.1714978902.git.baolin.wang@linux.alibaba.com>
 <13939ade-a99a-4075-8a26-9be7576b7e03@arm.com>
 <d2bd3277-7ef5-4909-a149-6895ad95459e@linux.alibaba.com>
 <5564e708-4a9f-4010-806e-4c5a7a5d2ebe@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5564e708-4a9f-4010-806e-4c5a7a5d2ebe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/8 15:15, David Hildenbrand wrote:
> On 08.05.24 05:44, Baolin Wang wrote:
>>
>>
>> On 2024/5/7 18:37, Ryan Roberts wrote:
>>> On 06/05/2024 09:46, Baolin Wang wrote:
>>>> Add large folio mapping establishment support for finish_fault() as 
>>>> a preparation,
>>>> to support multi-size THP allocation of anonymous shmem pages in the 
>>>> following
>>>> patches.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/memory.c | 43 +++++++++++++++++++++++++++++++++----------
>>>>    1 file changed, 33 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index eea6e4984eae..936377220b77 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>    {
>>>>        struct vm_area_struct *vma = vmf->vma;
>>>>        struct page *page;
>>>> +    struct folio *folio;
>>>>        vm_fault_t ret;
>>>>        bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>>>                  !(vma->vm_flags & VM_SHARED);
>>>> +    int type, nr_pages, i;
>>>> +    unsigned long addr = vmf->address;
>>>>        /* Did we COW the page? */
>>>>        if (is_cow)
>>>> @@ -4780,24 +4783,44 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>                return VM_FAULT_OOM;
>>>>        }
>>>> +    folio = page_folio(page);
>>>> +    nr_pages = folio_nr_pages(folio);
>>>> +
>>>> +    if (unlikely(userfaultfd_armed(vma))) {
>>>> +        nr_pages = 1;
>>>> +    } else if (nr_pages > 1) {
>>>> +        unsigned long start = ALIGN_DOWN(vmf->address, nr_pages * 
>>>> PAGE_SIZE);
>>>> +        unsigned long end = start + nr_pages * PAGE_SIZE;
>>>> +
>>>> +        /* In case the folio size in page cache beyond the VMA 
>>>> limits. */
>>>> +        addr = max(start, vma->vm_start);
>>>> +        nr_pages = (min(end, vma->vm_end) - addr) >> PAGE_SHIFT;
>>>> +
>>>> +        page = folio_page(folio, (addr - start) >> PAGE_SHIFT);
>>>
>>> I still don't really follow the logic in this else if block. Isn't it 
>>> possible
>>> that finish_fault() gets called with a page from a folio that isn't 
>>> aligned with
>>> vmf->address?
>>>
>>> For example, let's say we have a file who's size is 64K and which is 
>>> cached in a
>>> single large folio in the page cache. But the file is mapped into a 
>>> process at
>>> VA 16K to 80K. Let's say we fault on the first page (VA=16K). You 
>>> will calculate
>>
>> For shmem, this doesn't happen because the VA is aligned with the
>> hugepage size in the shmem_get_unmapped_area() function. See patch 7.
> 
> Does that cover mremap() and MAP_FIXED as well.

Good point. Thanks for pointing this out.

> We should try doing this as cleanly as possible, to prepare for the 
> future / corner cases.

Sure. Let me re-think about the algorithm.

