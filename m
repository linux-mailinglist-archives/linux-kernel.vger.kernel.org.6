Return-Path: <linux-kernel+bounces-449629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2329F51C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8750188D8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8BE1F75BE;
	Tue, 17 Dec 2024 17:09:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4331F37BE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455391; cv=none; b=rHT/qHzzC8Wg8x0BYKcZ4oOGgeYI7G5XVQBhrquVSGQ9lf73PzJ0NjyyVaXEc492hHOlj14Zb6xqZRakXabemoerxh9C5SqI7QUs3sAFDO8jFHOZBUtQ19FuXw4KT9eiLswiJP8YBYjzQr/jfTRbCWd1ljylSGfF0DvudqmA+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455391; c=relaxed/simple;
	bh=uGZYXrfVPJL0VviBMmCM3Pll7/4KrxvbhxdKOvJn/+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM6iREkEJJdwZXx+u3SoXD/qzm54pXAwwhtC2K966YFqrBfzpsbYsSsftsdPy2Co39ceOfBs/i3pJGj0rhGRIUNZxoYxpBaNizSL358UezPZIJJw+YzgOBicrkRUcUo2TIWJKk5ZGRJjk+IeQpiD/ZN6ki/2ggRGFQFPInf8qYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7B6DFEC;
	Tue, 17 Dec 2024 09:10:15 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DE703F7B4;
	Tue, 17 Dec 2024 09:09:41 -0800 (PST)
Message-ID: <23e93e90-0681-4039-a3bb-f4b01b8eefeb@arm.com>
Date: Tue, 17 Dec 2024 17:09:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] khugepaged: Generalize
 __collapse_huge_page_isolate()
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
 <20241216165105.56185-6-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241216165105.56185-6-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2024 16:50, Dev Jain wrote:
> Scale down the scan range and the sysfs tunables according to the scan order,
> and isolate the folios.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f52dae7d5179..de044b1f83d4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -564,15 +564,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  					unsigned long address,
>  					pte_t *pte,
>  					struct collapse_control *cc,
> -					struct list_head *compound_pagelist)
> +					struct list_head *compound_pagelist, int order)
>  {
> -	struct page *page = NULL;
> -	struct folio *folio = NULL;
> -	pte_t *_pte;
> +	unsigned int max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
> +	unsigned int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);

This is implicitly rounding down. I think that's the right thing to do; it's
better to be conservative.

>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> +	struct folio *folio = NULL;
> +	struct page *page = NULL;
>  	bool writable = false;
> +	pte_t *_pte;
>  
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +
> +	for (_pte = pte; _pte < pte + (1UL << order);
>  	     _pte++, address += PAGE_SIZE) {
>  		pte_t pteval = ptep_get(_pte);
>  		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -580,7 +583,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  			++none_or_zero;
>  			if (!userfaultfd_armed(vma) &&
>  			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			     none_or_zero <= max_ptes_none)) {
>  				continue;
>  			} else {
>  				result = SCAN_EXCEED_NONE_PTE;
> @@ -609,7 +612,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		if (folio_likely_mapped_shared(folio)) {
>  			++shared;
>  			if (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared) {
> +			    shared > max_ptes_shared) {
>  				result = SCAN_EXCEED_SHARED_PTE;
>  				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>  				goto out;
> @@ -1200,7 +1203,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
>  	if (pte) {
>  		result = __collapse_huge_page_isolate(vma, address, pte, cc,
> -						      &compound_pagelist);
> +						      &compound_pagelist, order);
>  		spin_unlock(pte_ptl);
>  	} else {
>  		result = SCAN_PMD_NULL;


