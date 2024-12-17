Return-Path: <linux-kernel+bounces-449652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDFD9F531D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DF016E588
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AB1F8662;
	Tue, 17 Dec 2024 17:22:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A88615A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456169; cv=none; b=m/dex1wGRVHxbfHOYKreKkgFvT/CiBB1jOONB2b/mm0FepGPKhW7LMWPSeIbP58U26ioJ/qlnUwSihO9fMb6EDgfBTqIRS6SN9ftPopGRXiYIr2ShzX3Y3CH7iVl9QIQF5zdFHtfWaYLBu4TgXX4SKZsiHkSyb+gdtJghNYVPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456169; c=relaxed/simple;
	bh=1BVthTLTbPqK7bDL3gnfMZHv94YuQQJpQrUM1OGCX78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq9V2XPA0Cc2eJjcv9ZhxHBmvvI+GiUXvfJmXiWBBucGIHdrcsJqv+Z8bXhmOd/liuuvmXuJQ9cPrdStt+szKlkI/nFCMrGRx3tBRuHDOif3T4lDaKDGmb1ewqWuaLpDEqT9Pt+2D5ENKcl7XQg6I8cWbb9QyEaV9s8g1M8GbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7E2FEC;
	Tue, 17 Dec 2024 09:23:14 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00D4A3F7B4;
	Tue, 17 Dec 2024 09:22:40 -0800 (PST)
Message-ID: <4a2554ad-c204-4350-8898-545c1da124bb@arm.com>
Date: Tue, 17 Dec 2024 17:22:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/12] khugepaged: Generalize
 __collapse_huge_page_copy_failed()
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
 <20241216165105.56185-7-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241216165105.56185-7-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2024 16:50, Dev Jain wrote:
> Upon failure, we repopulate the PMD in case of PMD-THP collapse. Hence, make
> this logic specific for PMD case.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index de044b1f83d4..886c76816963 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -766,7 +766,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>  					     pmd_t *pmd,
>  					     pmd_t orig_pmd,
>  					     struct vm_area_struct *vma,
> -					     struct list_head *compound_pagelist)
> +					     struct list_head *compound_pagelist, int order)

nit: suggest putting order on its own line.

>  {
>  	spinlock_t *pmd_ptl;
>  
> @@ -776,14 +776,16 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
>  	 * pages. Since pages are still isolated and locked here,
>  	 * acquiring anon_vma_lock_write is unnecessary.
>  	 */
> -	pmd_ptl = pmd_lock(vma->vm_mm, pmd);
> -	pmd_populate(vma->vm_mm, pmd, pmd_pgtable(orig_pmd));
> -	spin_unlock(pmd_ptl);
> +	if (order == HPAGE_PMD_ORDER) {
> +		pmd_ptl = pmd_lock(vma->vm_mm, pmd);
> +		pmd_populate(vma->vm_mm, pmd, pmd_pgtable(orig_pmd));
> +		spin_unlock(pmd_ptl);
> +	}
>  	/*
>  	 * Release both raw and compound pages isolated
>  	 * in __collapse_huge_page_isolate.
>  	 */
> -	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
> +	release_pte_pages(pte, pte + (1UL << order), compound_pagelist);
>  }

Given this function is clearly so geared towards re-establishing the pmd, given
that it takes the *pmd and orig_pmd as params, and given that in the
non-pmd-order case, we only call through to release_pte_pages(), I wonder if
it's better to make the decision at a higher level and either call this function
or release_pte_pages() directly? No strong opinion, just looks a bit weird at
the moment.

>  
>  /*
> @@ -834,7 +836,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
>  						    compound_pagelist);
>  	else
>  		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
> -						 compound_pagelist);
> +						 compound_pagelist, order);
>  
>  	return result;
>  }


