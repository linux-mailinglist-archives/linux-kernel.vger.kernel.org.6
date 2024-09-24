Return-Path: <linux-kernel+bounces-337183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79646984691
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DCBB22F53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA601A725D;
	Tue, 24 Sep 2024 13:13:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF691B85DD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183608; cv=none; b=ETqnGk+x6OihcEe98Ztc9F8XKJ885Yr1BNI2/tunnC+ciUZDJ1lgMRaXb17c0q8kmSrsl2pcrnyiGMZ7IXaXitP/l2SoKfeoVvyDMlDNt9+fzrRZjp4fgKxpEkI1ioLc4ve63IcoQQw4WqLs6lhns/z2y6JnRy8fOBKAVU4YkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183608; c=relaxed/simple;
	bh=vFMlNR6E5c3x7AgCFp2QNq2hSCWb45w4t6NuuLZT1oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBHOTnab4XRMa+tq6GGlTgJKD0N4a6r8WZ5kpfv6ie0jkqPB3wAvaKYrqv6XKzc3UlMldkj+OfEJV/Arb77J1kCrwjhWx+gEAt3WPzDaFimh8Ca+HdjPrMQmaqJVd0hooc7jCdB/4jaqDydoDULHh4bY0H+bkIDcITD7hCjKW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XCgJ60gHNzySFf;
	Tue, 24 Sep 2024 21:12:22 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D07D180AE8;
	Tue, 24 Sep 2024 21:13:22 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 21:13:21 +0800
Message-ID: <7d21314c-9c53-4aa0-9a27-b07d21da429e@huawei.com>
Date: Tue, 24 Sep 2024 21:13:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mm: Allocate THP on hugezeropage wp-fault
To: Dev Jain <dev.jain@arm.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <willy@infradead.org>, <kirill.shutemov@linux.intel.com>
CC: <ryan.roberts@arm.com>, <anshuman.khandual@arm.com>,
	<catalin.marinas@arm.com>, <cl@gentwo.org>, <vbabka@suse.cz>,
	<mhocko@suse.com>, <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
	<will@kernel.org>, <baohua@kernel.org>, <jack@suse.cz>,
	<mark.rutland@arm.com>, <hughd@google.com>, <aneesh.kumar@kernel.org>,
	<yang@os.amperecomputing.com>, <peterx@redhat.com>, <ioworker0@gmail.com>,
	<jglisse@google.com>, <ziy@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240924101654.1777697-1-dev.jain@arm.com>
 <20240924101654.1777697-3-dev.jain@arm.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240924101654.1777697-3-dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/24 18:16, Dev Jain wrote:
> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
> replace it with a PMD-mapped THP. Remember to flush TLB entry
> corresponding to the hugezeropage. In case of failure, fallback
> to splitting the PMD.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bdbf67c18f6c..fbb195bc2038 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1790,6 +1790,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>   	spin_unlock(vmf->ptl);
>   }
>   
> +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
> +{
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct mmu_notifier_range range;
> +	struct folio *folio;
> +	vm_fault_t ret = 0;
> +
> +	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
> +	if (unlikely(!folio)) {
> +		ret = VM_FAULT_FALLBACK;

I'd like to return VM_FAULT_FALLBACK if you re-post.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> +		goto out;
> +	}
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
> +				haddr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
> +		goto release;
> +	ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		goto release;
> +	(void)pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
> +	map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
> +	goto unlock;
> +release:
> +	folio_put(folio);
> +unlock:
> +	spin_unlock(vmf->ptl);
> +	mmu_notifier_invalidate_range_end(&range);
> +out:
> +	return ret;
> +}
> +
>   vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>   {
>   	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> @@ -1802,8 +1837,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>   	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>   	VM_BUG_ON_VMA(!vma->anon_vma, vma);
>   
> -	if (is_huge_zero_pmd(orig_pmd))
> +	if (is_huge_zero_pmd(orig_pmd)) {
> +		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
> +
> +		if (!(ret & VM_FAULT_FALLBACK))
> +			return ret;
> +
> +		/* Fallback to splitting PMD if THP cannot be allocated */
>   		goto fallback;
> +	}
>   
>   	spin_lock(vmf->ptl);
>   


