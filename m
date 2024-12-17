Return-Path: <linux-kernel+bounces-448713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E179F4494
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63A816EB14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDE1DE8A2;
	Tue, 17 Dec 2024 06:53:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC2E1DE3DE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418412; cv=none; b=Jlmk3kXQ2T+BvyUfHxgv7IS8HuJ9+zWts3U3KrKv9VFcRtTcsU1C+F1ooX0ou5ywmJmURliUy86aQCjxS5iLNUngiJOC/PgG6mw33mRmQ/EViaMV3UPf50aSwRY5x32+O40tC2LZVLewKIYeUyro48P7C1YzPXYtJJEcp53005U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418412; c=relaxed/simple;
	bh=1v1fPD9iQX9kwhZSBJkQEwh/QHpcMY2sWw4DI5eCol4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azle1btHhUkFwG2vnlbaObn55Jkp0AdDiWOrgA5f+penfRirCliTlEWLQ1zSfaRITc8fne4DF2CJ8/ov/QFGyyJ2jaVCGf5neCH8Im7baGWh063R4YE1tPIygSWf8Wn83Wb8EPK69PxOWG8oHnoK3aQu8TBEgRLm1MlSeEpbWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19701007;
	Mon, 16 Dec 2024 22:53:57 -0800 (PST)
Received: from [10.57.91.184] (unknown [10.57.91.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D7B03F528;
	Mon, 16 Dec 2024 22:53:24 -0800 (PST)
Message-ID: <46939efe-cf79-4dcd-9e47-9340956feb03@arm.com>
Date: Tue, 17 Dec 2024 06:53:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
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
 <20241216165105.56185-3-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241216165105.56185-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2024 16:50, Dev Jain wrote:
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  mm/huge_memory.c        |  4 ++++
>  mm/khugepaged.c         | 13 +++++++++----
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 93e509b6c00e..8b6d0fed99b3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -119,6 +119,8 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
>  	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_ANON_COLLAPSE_ALLOC,
> +	MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED,
>  	MTHP_STAT_ZSWPOUT,
>  	MTHP_STAT_SWPIN,
>  	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2da5520bfe24..2e582fad4c77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc, MTHP_STAT_ANON_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc_failed, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>  DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -636,6 +638,8 @@ static struct attribute *anon_stats_attrs[] = {
>  	&anon_fault_alloc_attr.attr,
>  	&anon_fault_fallback_attr.attr,
>  	&anon_fault_fallback_charge_attr.attr,
> +	&anon_collapse_alloc_attr.attr,
> +	&anon_collapse_alloc_failed_attr.attr,
>  #ifndef CONFIG_SHMEM
>  	&zswpout_attr.attr,
>  	&swpin_attr.attr,
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 95643e6e5f31..02cd424b8e48 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1073,21 +1073,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  }
>  
>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      int order, struct collapse_control *cc)
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
>  	int node = hpage_collapse_find_target_node(cc);
>  	struct folio *folio;
>  
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop = NULL;
>  		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> +		if (order != HPAGE_PMD_ORDER)
> +			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);

Bug? We should be calling count_mthp_stat() for all orders, but only calling
count_vm_event(THP_*) for PMD_ORDER, as per pattern laid out by other mTHP stats.

The aim is for existing THP stats (which are implicitly only counting PMD-sized
THP) to continue only to count PMD-sized THP. It's a userspace ABI and we were
scared of the potential to break things if we changed the existing counters'
semantics.

>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>  	}
>  
>  	count_vm_event(THP_COLLAPSE_ALLOC);
> +	if (order != HPAGE_PMD_ORDER)
> +		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);

Same problem.

Also, I agree with Baolin that we don't want "anon" in the title. This is a
generic path used for file-backed memory. So once you fix the bug, the new stats
will also be counting the file-backed memory too (although for now, only for
PMD_ORDER).

> +
>  	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>  		folio_put(folio);
>  		*foliop = NULL;
> @@ -1124,7 +1129,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 */
>  	mmap_read_unlock(mm);
>  
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, order, cc);

Where is order coming from? I'm guessing that's added later, so this patch won't
compile on it's own? Perhaps HPAGE_PMD_ORDER for now?

>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>  
> @@ -1850,7 +1855,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>  	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>  
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, HPAGE_PMD_ORDER, cc);
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  


