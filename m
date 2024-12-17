Return-Path: <linux-kernel+bounces-449011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F89F4872
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC381883F68
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4841DF253;
	Tue, 17 Dec 2024 10:07:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08A1DDA34
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430054; cv=none; b=GH6j10zcUlBsfsYk8wQxynzKkynEiAtFe8CwQoVXzgJNr18/eqP/6JuVcyU9LOaOsw7K6/IVO26M+VCN4IFtu3cz3xHk/HbzPEQaOGsbISTpDowX1oS+aYHktmMY/qDw49eBe8g/Wx5BsEnZyfQCewHad4ZKOIQdJjVzdVVc6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430054; c=relaxed/simple;
	bh=nWN8HpKKx0evKLEOlzXrTnhjbA/3NDtE1+NPZlgRcxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUofC6eIwtOiupTJa3vMxWPPYwPUVgjjaWkQKeSvlhhqTNnmbadtAS7FTsAH2BGbiR0QKBbNqDa7oJIak4p51TirFe8JdJGVjUiHEnXmlKjJk58Pt97uvSnAY473Wpt2YLASGK6X8VPm5Rxhq/kYLrWxkftZR0L5Uhr5ImqWa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E881F1007;
	Tue, 17 Dec 2024 02:07:58 -0800 (PST)
Received: from [10.162.40.67] (K4MQJ0H1H2.blr.arm.com [10.162.40.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC5D3F528;
	Tue, 17 Dec 2024 02:07:21 -0800 (PST)
Message-ID: <28013908-65d8-462e-b975-cd0f63d226b1@arm.com>
Date: Tue, 17 Dec 2024 15:37:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] khugepaged: Introduce vma_collapse_anon_folio()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-10-dev.jain@arm.com>
 <2215dd8e-233a-427b-b15c-a2ffbce8f46d@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2215dd8e-233a-427b-b15c-a2ffbce8f46d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16/12/24 10:36 pm, David Hildenbrand wrote:
> On 16.12.24 17:51, Dev Jain wrote:
>> In contrast to PMD-collapse, we do not need to operate on two levels 
>> of pagetable
>> simultaneously. Therefore, downgrade the mmap lock from write to read 
>> mode. Still
>> take the anon_vma lock in exclusive mode so as to not waste time in 
>> the rmap path,
>> which is anyways going to fail since the PTEs are going to be 
>> changed. Under the PTL,
>> copy page contents, clear the PTEs, remove folio pins, and (try to) 
>> unmap the
>> old folios. Set the PTEs to the new folio using the set_ptes() API.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> Note: I have been trying hard to get rid of the locks in here: we 
>> still are
>> taking the PTL around the page copying; dropping the PTL and taking 
>> it after
>> the copying should lead to a deadlock, for example:
>> khugepaged                        madvise(MADV_COLD)
>> folio_lock()                        lock(ptl)
>> lock(ptl)                        folio_lock()
>>
>> We can create a locked folio list, altogether drop both the locks, 
>> take the PTL,
>> do everything which __collapse_huge_page_isolate() does *except* the 
>> isolation and
>> again try locking folios, but then it will reduce efficiency of 
>> khugepaged
>> and almost looks like a forced solution :)
>> Please note the following discussion if anyone is interested:
>> https://lore.kernel.org/all/66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com/ 
>>
>> (Apologies for not CCing the mailing list from the start)
>>
>>   mm/khugepaged.c | 108 ++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 87 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 88beebef773e..8040b130e677 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -714,24 +714,28 @@ static void 
>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>                           struct vm_area_struct *vma,
>>                           unsigned long address,
>>                           spinlock_t *ptl,
>> -                        struct list_head *compound_pagelist)
>> +                        struct list_head *compound_pagelist, int order)
>>   {
>>       struct folio *src, *tmp;
>>       pte_t *_pte;
>>       pte_t pteval;
>>   -    for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>> +    for (_pte = pte; _pte < pte + (1UL << order);
>>            _pte++, address += PAGE_SIZE) {
>>           pteval = ptep_get(_pte);
>>           if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>               add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>>               if (is_zero_pfn(pte_pfn(pteval))) {
>> -                /*
>> -                 * ptl mostly unnecessary.
>> -                 */
>> -                spin_lock(ptl);
>> -                ptep_clear(vma->vm_mm, address, _pte);
>> -                spin_unlock(ptl);
>> +                if (order == HPAGE_PMD_ORDER) {
>> +                    /*
>> +                    * ptl mostly unnecessary.
>> +                    */
>> +                    spin_lock(ptl);
>> +                    ptep_clear(vma->vm_mm, address, _pte);
>> +                    spin_unlock(ptl);
>> +                } else {
>> +                    ptep_clear(vma->vm_mm, address, _pte);
>> +                }
>>                   ksm_might_unmap_zero_page(vma->vm_mm, pteval);
>>               }
>>           } else {
>> @@ -740,15 +744,20 @@ static void 
>> __collapse_huge_page_copy_succeeded(pte_t *pte,
>>               src = page_folio(src_page);
>>               if (!folio_test_large(src))
>>                   release_pte_folio(src);
>> -            /*
>> -             * ptl mostly unnecessary, but preempt has to
>> -             * be disabled to update the per-cpu stats
>> -             * inside folio_remove_rmap_pte().
>> -             */
>> -            spin_lock(ptl);
>> -            ptep_clear(vma->vm_mm, address, _pte);
>> -            folio_remove_rmap_pte(src, src_page, vma);
>> -            spin_unlock(ptl);
>> +            if (order == HPAGE_PMD_ORDER) {
>> +                /*
>> +                * ptl mostly unnecessary, but preempt has to
>> +                * be disabled to update the per-cpu stats
>> +                * inside folio_remove_rmap_pte().
>> +                */
>> +                spin_lock(ptl);
>> +                ptep_clear(vma->vm_mm, address, _pte);
>
>
>
>
>> + folio_remove_rmap_pte(src, src_page, vma);
>> +                spin_unlock(ptl);
>> +            } else {
>> +                ptep_clear(vma->vm_mm, address, _pte);
>> +                folio_remove_rmap_pte(src, src_page, vma);
>> +            }
>
> As I've talked to Nico about this code recently ... :)
>
> Are you clearing the PTE after the copy succeeded? If so, where is the 
> TLB flush?
>
> How do you sync against concurrent write acess + GUP-fast?
>
>
> The sequence really must be: (1) clear PTE/PMD + flush TLB (2) check 
> if there are unexpected page references (e.g., GUP) if so back off (3) 
> copy page content (4) set updated PTE/PMD.

Thanks...we need to ensure GUP-fast does not write when we are copying 
contents, so (2) will ensure that GUP-fast will see the cleared PTE and 
back-off.
>
> To Nico, I suggested doing it simple initially, and still clear the 
> high-level PMD entry + flush under mmap write lock, then re-map the 
> PTE table after modifying the page table. It's not as efficient, but 
> "harder to get wrong".
>
> Maybe that's already happening, but I stumbled over this clearing 
> logic in __collapse_huge_page_copy_succeeded(), so I'm curious.

No, I am not even touching the PMD. I guess the sequence you described 
should work? I just need to reverse the copying and PTE clearing order 
to implement this sequence.

