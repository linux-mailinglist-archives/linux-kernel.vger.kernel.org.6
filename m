Return-Path: <linux-kernel+bounces-212415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DA905FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0381E281FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B848F77;
	Thu, 13 Jun 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="px9BvqIl"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540CC147
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239916; cv=none; b=k+vIN5lgtDQSf766DLiWTnqQa9v8ekCRaSISOTatep6deu7F+Ln7Nym+w74dc7itVD0cm46Uo7558CMSD0KoeCjBZEpQjrdw9nqR24fcDEaqETWE4KA+TO2gkP8sPTt6yJcogWhfFHWUh+ETGPD3pXZSAZzK78n+R2tFw/cANtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239916; c=relaxed/simple;
	bh=SHoMcIdISwy0muoLftFNdJNW1Crs9VgbH4hEZTuX9Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK8I33VWZPG6QGKs1EFekit7rzGU+3rX1erLfH2/eBXqgjcLdzUgtq5oq/X/z2MdUWGVQvZnNbdtq2vWFHw+dKOVgh1k9LRvonY269oQ99+NwE9d5QUL8kuLHNOdVysdiIMT03ejCgNtB59m0OtFiYdC+kjVUxJL0z+lmf1TzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=px9BvqIl; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718239906; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HPjLzQBCigEVLIfXbDL0xmW8b3HFx8AMly+LLTrutZo=;
	b=px9BvqIldH4WACJnXdhtq9C0YDemf8u4KOJEuCOeEmhwEOGh5GiqY9U9jipAlqC9Sm5xrGeCX3YGXcWmAuBueVtEeQk+oIlMhlHEO0k+B0zvjk+ws9yNF60jQq/mKY4u6CY/7LU6swkMEv4LHppC7al9EIs8zEeYpJ2yOe5WkQM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8M6ggj_1718239904;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8M6ggj_1718239904)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 08:51:45 +0800
Message-ID: <86e8c75b-1717-4335-9a1f-c663192dbf84@linux.alibaba.com>
Date: Thu, 13 Jun 2024 08:51:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] mm: memory: extend finish_fault() to support large
 folio
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
 <bab26abd-9364-4a6b-9bed-5bcf2cb46952@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <bab26abd-9364-4a6b-9bed-5bcf2cb46952@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 21:40, Kefeng Wang wrote:
> 
> 
> On 2024/6/11 18:11, Baolin Wang wrote:
>> Add large folio mapping establishment support for finish_fault() as a
>> preparation, to support multi-size THP allocation of anonymous shmem 
>> pages
>> in the following patches.
>>
>> Keep the same behavior (per-page fault) for non-anon shmem to avoid 
>> inflating
>> the RSS unintentionally, and we can discuss what size of mapping to build
>> when extending mTHP to control non-anon shmem in the future.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eef4e482c0c2..72775ee99ff3 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>   {
>>       struct vm_area_struct *vma = vmf->vma;
>>       struct page *page;
>> +    struct folio *folio;
>>       vm_fault_t ret;
>>       bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>                 !(vma->vm_flags & VM_SHARED);
>> +    int type, nr_pages;
>> +    unsigned long addr = vmf->address;
>>       /* Did we COW the page? */
>>       if (is_cow)
>> @@ -4864,24 +4867,58 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>               return VM_FAULT_OOM;
>>       }
>> +    folio = page_folio(page);
>> +    nr_pages = folio_nr_pages(folio);
>> +
>> +    /*
>> +     * Using per-page fault to maintain the uffd semantics, and same
>> +     * approach also applies to non-anonymous-shmem faults to avoid
>> +     * inflating the RSS of the process.
>> +     */
>> +    if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
>> +        nr_pages = 1;
>> +    } else if (nr_pages > 1) {
>> +        pgoff_t idx = folio_page_idx(folio, page);
>> +        /* The page offset of vmf->address within the VMA. */
>> +        pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
>> +
>                          vma->vm_pgoff
> 
>> +        /*
>> +         * Fallback to per-page fault in case the folio size in page
>> +         * cache beyond the VMA limits.
>> +         */
>> +        if (unlikely(vma_off < idx ||
>> +                 vma_off + (nr_pages - idx) > vma_pages(vma))) {
>> +            nr_pages = 1;
>> +        } else {
>> +            /* Now we can set mappings for the whole large folio. */
>> +            addr = vmf->address - idx * PAGE_SIZE;
> 
>              addr -= idx * PAGE_SIZE;
> 
>> +            page = &folio->page;
>> +        }
>> +    }
>> +
>>       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>> -                      vmf->address, &vmf->ptl);
>> +                       addr, &vmf->ptl);
> 
> no newline now,
> 
>>       if (!vmf->pte)
>>           return VM_FAULT_NOPAGE;
>>       /* Re-check under ptl */
>> -    if (likely(!vmf_pte_changed(vmf))) {
>> -        struct folio *folio = page_folio(page);
>> -        int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>> -
>> -        set_pte_range(vmf, folio, page, 1, vmf->address);
>> -        add_mm_counter(vma->vm_mm, type, 1);
>> -        ret = 0;
>> -    } else {
>> -        update_mmu_tlb(vma, vmf->address, vmf->pte);
>> +    if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
>> +        update_mmu_tlb(vma, addr, vmf->pte);
>> +        ret = VM_FAULT_NOPAGE;
>> +        goto unlock;
>> +    } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> +        update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>>           ret = VM_FAULT_NOPAGE;
>> +        goto unlock;
>>       }
> 
> We may add a vmf_pte_range_changed(), but separate it.
> 
> Some very small nits, up to you,
> 
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for reviewing. If a new version is needed, then I will clean up 
these coding style issues.

