Return-Path: <linux-kernel+bounces-449613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9469F5176
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13197168E92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE61F755F;
	Tue, 17 Dec 2024 16:58:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62E148310
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454723; cv=none; b=PYFhUjn8erK/eH92spVp2TpWQ2EM4AwiC5GxfePE03LauVM+1ez2iqwZOHVNehTEvvZ2wMsN/ue0QkiUXmxz1erGg0Ff2MYIAdhUgab//plQQmbBGDiy9HwMmp1tZLs9TLjaWUCE+aFBijLkpHpv8PnVYfSk8dUNBdwTuYP4pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454723; c=relaxed/simple;
	bh=3CFBhmTOQ5GsdcKU1bvZNaE2LIYKSLxf7gInUFTPGwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpVKhCJDgKfs/VpQMGmCyuLGNgL9L0yapj4AHnzzQDCktezS0sqW/QQnE4OmTazM3Cwy869nOzK6vjBY1dTohswFpicKIrbP+1wFEnKduLWzNHE3PJw5i/G0rrcrQE0tax/hunKOYEwVkbM4czGcDoSq4NwD9o4amCdGbnqsJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 115ECFEC;
	Tue, 17 Dec 2024 08:59:07 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A9F83F7B4;
	Tue, 17 Dec 2024 08:58:33 -0800 (PST)
Message-ID: <c3caa1be-5b15-46d2-a7ae-23fd925aaecf@arm.com>
Date: Tue, 17 Dec 2024 16:58:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/12] khugepaged: Generalize
 hugepage_vma_revalidate()
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-4-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241216165105.56185-4-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2024 16:50, Dev Jain wrote:
> Post retaking the lock, it must be checked that the VMA is suitable for our
> scan order. Hence, generalize hugepage_vma_revalidate().
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 02cd424b8e48..2f0601795471 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -918,7 +918,7 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>  
>  static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  				   bool expect_anon,
> -				   struct vm_area_struct **vmap,
> +				   struct vm_area_struct **vmap, int order,
>  				   struct collapse_control *cc)
>  {
>  	struct vm_area_struct *vma;
> @@ -931,9 +931,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  	if (!vma)
>  		return SCAN_VMA_NULL;
>  
> -	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> +	if (!thp_vma_suitable_order(vma, address, order))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1134,7 +1134,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		goto out_nolock;
>  
>  	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, order, cc);

some more compilation issues: replace order with HPAGE_PMD_ORDER.

>  	if (result != SCAN_SUCCEED) {
>  		mmap_read_unlock(mm);
>  		goto out_nolock;
> @@ -1168,7 +1168,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, order, cc);

and here.

>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>  	/* check if the pmd is still valid */
> @@ -2776,7 +2776,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  			mmap_read_lock(mm);
>  			mmap_locked = true;
>  			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc);
> +							 HPAGE_PMD_ORDER, cc);
>  			if (result  != SCAN_SUCCEED) {
>  				last_fail = result;
>  				goto out_nolock;


