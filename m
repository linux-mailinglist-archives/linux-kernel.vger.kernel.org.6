Return-Path: <linux-kernel+bounces-338014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672698526B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F4B1C22CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78ED1487F6;
	Wed, 25 Sep 2024 05:31:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0051B85D1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242286; cv=none; b=p29Md91a+J5Y3bG2owj0dbQB8ZynkLLu0SxqR1gZiWFcbEcyql0Xhk7dT/8sxLG93FAgFaHv70HrFIiN0RSwoveD6FOARUWwYPC3+AWUhx9BUgyuimZtY3xBaNddN31tX0VPgs4c+XU1D7EEU4NUlykBZpVg2U1Aoqq+M0GCJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242286; c=relaxed/simple;
	bh=pvGwlwzxPWNgtYxefMYr8drFNbR3hfLG8+2Io21SEds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXlqh0cAXbU5FB7pOJk0uy+jV+36Qqp2I5d0E07tpULCam87jJVyggbwwMlPFmQhcrJDe+bARbUMZnS4vp/JMtYNMD1g/GiHJKqCJ4sXdFmts5wYxZQrIaTKT0/+tbr1J5UJIWfvscCB5zN6Ujm2ftpRyXpWdLaJnOf1QloW79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B0F0DA7;
	Tue, 24 Sep 2024 22:31:53 -0700 (PDT)
Received: from [10.162.43.26] (e116581.arm.com [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D523F528;
	Tue, 24 Sep 2024 22:31:14 -0700 (PDT)
Message-ID: <903de160-e2cf-42cc-93ee-6b356cdca6de@arm.com>
Date: Wed, 25 Sep 2024 11:01:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mm: Allocate THP on hugezeropage wp-fault
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, ziy@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240924101654.1777697-1-dev.jain@arm.com>
 <20240924101654.1777697-3-dev.jain@arm.com>
 <7d21314c-9c53-4aa0-9a27-b07d21da429e@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7d21314c-9c53-4aa0-9a27-b07d21da429e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/24/24 18:43, Kefeng Wang wrote:
>
>
> On 2024/9/24 18:16, Dev Jain wrote:
>> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
>> replace it with a PMD-mapped THP. Remember to flush TLB entry
>> corresponding to the hugezeropage. In case of failure, fallback
>> to splitting the PMD.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bdbf67c18f6c..fbb195bc2038 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1790,6 +1790,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>>       spin_unlock(vmf->ptl);
>>   }
>>   +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
>> +{
>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    struct mmu_notifier_range range;
>> +    struct folio *folio;
>> +    vm_fault_t ret = 0;
>> +
>> +    folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
>> +    if (unlikely(!folio)) {
>> +        ret = VM_FAULT_FALLBACK;
>
> I'd like to return VM_FAULT_FALLBACK if you re-post.

That's cleaner. I need to keep my "goto" obsession in control...
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks!
>
>> +        goto out;
>> +    }
>> +
>> +    mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, 
>> haddr,
>> +                haddr + HPAGE_PMD_SIZE);
>> +    mmu_notifier_invalidate_range_start(&range);
>> +    vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> +    if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
>> +        goto release;
>> +    ret = check_stable_address_space(vma->vm_mm);
>> +    if (ret)
>> +        goto release;
>> +    (void)pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
>> +    map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>> +    goto unlock;
>> +release:
>> +    folio_put(folio);
>> +unlock:
>> +    spin_unlock(vmf->ptl);
>> +    mmu_notifier_invalidate_range_end(&range);
>> +out:
>> +    return ret;
>> +}
>> +
>>   vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>   {
>>       const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>> @@ -1802,8 +1837,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault 
>> *vmf)
>>       vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>>       VM_BUG_ON_VMA(!vma->anon_vma, vma);
>>   -    if (is_huge_zero_pmd(orig_pmd))
>> +    if (is_huge_zero_pmd(orig_pmd)) {
>> +        vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
>> +
>> +        if (!(ret & VM_FAULT_FALLBACK))
>> +            return ret;
>> +
>> +        /* Fallback to splitting PMD if THP cannot be allocated */
>>           goto fallback;
>> +    }
>>         spin_lock(vmf->ptl);
>
>

