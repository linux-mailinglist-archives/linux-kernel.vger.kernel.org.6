Return-Path: <linux-kernel+bounces-280338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF694C8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B97B22E89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EA18654;
	Fri,  9 Aug 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kvqS1Y7s"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AA1804E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175010; cv=none; b=gaDQL+Rw0JPR3DkMydpC4E7dzgiguL81G936f1uXWeGlxmgPrIcd2OfxGnJuxmWH4A9CBd04YENPfqT892PdWgYJF0muHIr2X9AvfScxny2N7GWoLjL1jhxnoAnHluj6diqUjkdIDpDVglaysjMpQ3r9HbF2wLt/7u66SYtlO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175010; c=relaxed/simple;
	bh=4nTA9mBWE7+1xTty7YbYAywBdCk5uoF6uCKDTTZza3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuKZMDeLIOuwJCJodYpX+YfPoVDAjD3GiDCiK4UxGXHnY7U01KsVMlzPG0uEAVbHTXbrXzgSYDqaagYG64qM1htvYcUeGVzhfN9QAQd7BVnEJ6dEn4JUy5pqfpMdjzCiEP11zFZa2ZWwAnI4XWxi40aB4ENnYYIEBdiPbMqDsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kvqS1Y7s; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723175005; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LkBIUvVrpl0JBWdf4u/kUWlqJW2P6LxmcD6sEDhgjUA=;
	b=kvqS1Y7sqY54XH4ArbEwBm6mpa9ceJzDLPWjQMd0M5ODB9o+BzMnkhL6NcZVM0rMtf1jGCmd++3mv84DAr6o5EhwoqnfF9ecV+AAIDQA4BhMSHDoS8v7fCu/5rG3JUPRjaoFO3GsD5xXbPWzjXgN/KZUdf3e3uFpcdvkAWAdBCQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WCOQmX4_1723175004;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCOQmX4_1723175004)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 11:43:25 +0800
Message-ID: <585f2459-674b-494f-9036-8b2474ffa73d@linux.alibaba.com>
Date: Fri, 9 Aug 2024 11:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org
References: <20240808233728.1477034-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240808233728.1477034-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/9 07:37, Zi Yan wrote:
> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
> reduce redundancy, move common code to numa_migrate_prep() and rename
> the function to numa_migrate_check() to reflect its functionality.
> 
> Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
> flag.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/huge_memory.c | 29 +++++++++-------------
>   mm/internal.h    |  5 ++--
>   mm/memory.c      | 63 +++++++++++++++++++++++++-----------------------
>   3 files changed, 47 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4e4364a17e6d..96a52e71d167 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1669,22 +1669,23 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
>   vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> -	pmd_t oldpmd = vmf->orig_pmd;
> -	pmd_t pmd;
>   	struct folio *folio;
>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>   	int nid = NUMA_NO_NODE;
> -	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	int target_nid, last_cpupid;
> +	pmd_t pmd, old_pmd;
>   	bool writable = false;
>   	int flags = 0;
>   
>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> +	old_pmd = pmdp_get(vmf->pmd);
> +
> +	if (unlikely(!pmd_same(old_pmd, vmf->orig_pmd))) {
>   		spin_unlock(vmf->ptl);
>   		return 0;
>   	}
>   
> -	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
> +	pmd = pmd_modify(old_pmd, vma->vm_page_prot);
>   
>   	/*
>   	 * Detect now whether the PMD could be writable; this information
> @@ -1699,18 +1700,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	if (!folio)
>   		goto out_map;
>   
> -	/* See similar comment in do_numa_page for explanation */
> -	if (!writable)
> -		flags |= TNF_NO_GROUP;
> -
>   	nid = folio_nid(folio);
> -	/*
> -	 * For memory tiering mode, cpupid of slow memory page is used
> -	 * to record page access time.  So use default value.
> -	 */
> -	if (!folio_use_access_time(folio))
> -		last_cpupid = folio_last_cpupid(folio);
> -	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> +
> +	target_nid = numa_migrate_check(folio, vmf, haddr, &flags, writable,
> +					&last_cpupid);
>   	if (target_nid == NUMA_NO_NODE)
>   		goto out_map;
>   	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> @@ -1728,7 +1721,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	} else {
>   		flags |= TNF_MIGRATE_FAIL;
>   		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> +		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
>   			spin_unlock(vmf->ptl);
>   			return 0;
>   		}
> @@ -1736,7 +1729,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   
>   out_map:
>   	/* Restore the PMD */
> -	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
> +	pmd = pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
>   	pmd = pmd_mkyoung(pmd);
>   	if (writable)
>   		pmd = pmd_mkwrite(pmd, vma);
> diff --git a/mm/internal.h b/mm/internal.h
> index 52f7fc4e8ac3..fb16e18c9761 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>   
>   void __vunmap_range_noflush(unsigned long start, unsigned long end);
>   
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags);
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, int *flags, bool writable,
> +		      int *last_cpupid);
>   
>   void free_zone_device_folio(struct folio *folio);
>   int migrate_device_coherent_page(struct page *page);
> diff --git a/mm/memory.c b/mm/memory.c
> index d9b1dff9dc57..3441f60d54ef 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>   	return ret;
>   }
>   
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags)
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, int *flags,
> +		      bool writable, int *last_cpupid)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   
> +	/*
> +	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
> +	 * much anyway since they can be in shared cache state. This misses
> +	 * the case where a mapping is writable but the process never writes
> +	 * to it but pte_write gets cleared during protection updates and
> +	 * pte_dirty has unpredictable behaviour between PTE scan updates,
> +	 * background writeback, dirty balancing and application behaviour.
> +	 */
> +	if (!writable)
> +		*flags |= TNF_NO_GROUP;
> +
> +	/*
> +	 * Flag if the folio is shared between multiple address spaces. This
> +	 * is later used when determining whether to group tasks together
> +	 */
> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
> +		*flags |= TNF_SHARED;
> +	/*
> +	 * For memory tiering mode, cpupid of slow memory page is used
> +	 * to record page access time.  So use default value.
> +	 */
> +	if (folio_use_access_time(folio))
> +		*last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	else
> +		*last_cpupid = folio_last_cpupid(folio);
> +
>   	/* Record the current PID acceesing VMA */
>   	vma_set_access_pid_bit(vma);
>   
>   	count_vm_numa_event(NUMA_HINT_FAULTS);
> -	if (page_nid == numa_node_id()) {
> +	if (folio_nid(folio) == numa_node_id()) {
>   		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>   		*flags |= TNF_FAULT_LOCAL;
>   	}
> @@ -5479,35 +5506,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	if (!folio || folio_is_zone_device(folio))
>   		goto out_map;
>   
> -	/*
> -	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
> -	 * much anyway since they can be in shared cache state. This misses
> -	 * the case where a mapping is writable but the process never writes
> -	 * to it but pte_write gets cleared during protection updates and
> -	 * pte_dirty has unpredictable behaviour between PTE scan updates,
> -	 * background writeback, dirty balancing and application behaviour.
> -	 */
> -	if (!writable)
> -		flags |= TNF_NO_GROUP;
> -
> -	/*
> -	 * Flag if the folio is shared between multiple address spaces. This
> -	 * is later used when determining whether to group tasks together
> -	 */
> -	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
> -		flags |= TNF_SHARED;
> -
>   	nid = folio_nid(folio);
>   	nr_pages = folio_nr_pages(folio);
> -	/*
> -	 * For memory tiering mode, cpupid of slow memory page is used
> -	 * to record page access time.  So use default value.
> -	 */
> -	if (folio_use_access_time(folio))
> -		last_cpupid = (-1 & LAST_CPUPID_MASK);
> -	else
> -		last_cpupid = folio_last_cpupid(folio);
> -	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
> +
> +	target_nid = numa_migrate_check(folio, vmf, vmf->address, &flags,
> +					writable, &last_cpupid);
>   	if (target_nid == NUMA_NO_NODE)
>   		goto out_map;
>   	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {

