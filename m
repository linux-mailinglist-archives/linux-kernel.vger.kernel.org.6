Return-Path: <linux-kernel+bounces-170619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A278BD9CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B283B216B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E53FB9F;
	Tue,  7 May 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vko02Lt1"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1EA93C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053229; cv=none; b=EaB6bFB8P4sVmAZi7kUcSz6+YxBlMAaUOmy5Hnt8F0i7+vRc4DjjoswkYTHVe025KDitptD7VL4UmJKFlKfLXdnE+sgc2f1ZzEBb4PrjzWC1JYbMWYIb6aIKYjPXp7DDczWvBCbkL4swcBpkGlHII7x3NBxryju98YEn5eNJvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053229; c=relaxed/simple;
	bh=8dW+VmawGitKabe4EAf5JZhpgfRaBbst3RRwVaVTIvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFIq0onBsw+9QXHyzOBvZ2f+YvLI4gCvbD4WMjw8uuU0aVWfYg18AA7dLe16nExcXuRk7grZ3F0P4eA7H9q1xJ4tF1ywERz8hFP26xwya07lnafkKcoz6fDzVBfPuxdPhHuN5bAGy+DlWQ7sG0go5s3yhMBfbfQV1YDKJ46c0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vko02Lt1; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715053219; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T1kb8aaj1YB35LBiWabfJHjOOXKZswjfPzIXa7wPy+Q=;
	b=vko02Lt1McH4+4ZfD03FhNFQ2aua82NyjcgIQU8TbJNVZdcQhavVlsNtD2IUdicL276EhXHnEUjREkI9cWx5CE725PyE4pr2ACK2mNVCq4MZgIoUdEDgBvxvmIX/BV/q0xKncX3/X54opdhwr2jzY9v8ViiPfMxtjAOr9S17cb8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6-n0uS_1715053215;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6-n0uS_1715053215)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 11:40:16 +0800
Message-ID: <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
Date: Tue, 7 May 2024 11:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240501042700.83974-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/1 12:26, Lance Yang wrote:
> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address()
> to split the folio.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/huge_mm.h | 20 ++++++++++++++++++++
>   mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
>   mm/rmap.c               | 24 +++++++++++++++++------
>   3 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8d3ec116e29..38c4b5537715 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
>   	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>   }
>   
> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
> +			   pmd_t *pmd, bool freeze, struct folio *folio);
> +
> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> +					unsigned long *start,
> +					unsigned long *end)
> +{
> +	*start = ALIGN(*start, HPAGE_PMD_SIZE);
> +	*end = ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
> +
> +	VM_WARN_ON_ONCE(vma->vm_start > *start);
> +	VM_WARN_ON_ONCE(vma->vm_end < *end);
> +}
> +
>   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
>   static inline bool folio_test_pmd_mappable(struct folio *folio)
> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   		unsigned long address, bool freeze, struct folio *folio) {}
>   static inline void split_huge_pmd_address(struct vm_area_struct *vma,
>   		unsigned long address, bool freeze, struct folio *folio) {}
> +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
> +					 unsigned long address, pmd_t *pmd,
> +					 bool freeze, struct folio *folio) {}
> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> +					unsigned long *start,
> +					unsigned long *end) {}
>   
>   #define split_huge_pud(__vma, __pmd, __address)	\
>   	do { } while (0)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8261b5669397..145505a1dd05 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   	pmd_populate(mm, pmd, pgtable);
>   }
>   
> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
> +			   pmd_t *pmd, bool freeze, struct folio *folio)
> +{
> +	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
> +	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> +	VM_BUG_ON(freeze && !folio);
> +
> +	/*
> +	 * When the caller requests to set up a migration entry, we
> +	 * require a folio to check the PMD against. Otherwise, there
> +	 * is a risk of replacing the wrong folio.
> +	 */
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> +	    is_pmd_migration_entry(*pmd)) {
> +		if (folio && folio != pmd_folio(*pmd))
> +			return;
> +		__split_huge_pmd_locked(vma, pmd, address, freeze);
> +	}
> +}
> +
>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   		unsigned long address, bool freeze, struct folio *folio)
>   {
> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
>   	mmu_notifier_invalidate_range_start(&range);
>   	ptl = pmd_lock(vma->vm_mm, pmd);
> -
> -	/*
> -	 * If caller asks to setup a migration entry, we need a folio to check
> -	 * pmd against. Otherwise we can end up replacing wrong folio.
> -	 */
> -	VM_BUG_ON(freeze && !folio);
> -	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> -
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		/*
> -		 * It's safe to call pmd_page when folio is set because it's
> -		 * guaranteed that pmd is present.
> -		 */
> -		if (folio && folio != pmd_folio(*pmd))
> -			goto out;
> -		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
> -	}
> -
> -out:
> +	split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
>   	spin_unlock(ptl);
>   	mmu_notifier_invalidate_range_end(&range);
>   }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7e2575d669a9..432601154583 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	if (flags & TTU_SYNC)
>   		pvmw.flags = PVMW_SYNC;
>   
> -	if (flags & TTU_SPLIT_HUGE_PMD)
> -		split_huge_pmd_address(vma, address, false, folio);
> -
>   	/*
>   	 * For THP, we have to assume the worse case ie pmd for invalidation.
>   	 * For hugetlb, it could be much worse if we need to do pud
> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	range.end = vma_address_end(&pvmw);
>   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>   				address, range.end);
> +	if (flags & TTU_SPLIT_HUGE_PMD)
> +		align_huge_pmd_range(vma, &range.start, &range.end);

I am not sure why need this alignment?
(1) For a partially mapped THP, 'range.start' and 'range.end' can beyond 
the VMA limits. For a PMD mapped THP, I think the address is already THP 
size alignment returned from vma_address(&folio->page, vma).
(2) The range.end is not used.

>   	if (folio_test_hugetlb(folio)) {
>   		/*
>   		 * If sharing is possible, start and end will be adjusted
> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   	mmu_notifier_invalidate_range_start(&range);
>   
>   	while (page_vma_mapped_walk(&pvmw)) {
> -		/* Unexpected PMD-mapped THP? */
> -		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> -
>   		/*
>   		 * If the folio is in an mlock()d vma, we must not swap it out.
>   		 */
> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			goto walk_done_err;
>   		}
>   
> +		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +			/*
> +			 * We temporarily have to drop the PTL and start once
> +			 * again from that now-PTE-mapped page table.
> +			 */
> +			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
> +					      folio);
> +			pvmw.pmd = NULL;
> +			spin_unlock(pvmw.ptl);

IMO, you should also make the 'pvmw.ptl = NULL;' after unlocking as 
page_vma_mapped_walk() did, in case some corner case met.

> +			flags &= ~TTU_SPLIT_HUGE_PMD;
> +			continue;
> +		}
> +
> +		/* Unexpected PMD-mapped THP? */
> +		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> +
>   		pfn = pte_pfn(ptep_get(pvmw.pte));
>   		subpage = folio_page(folio, pfn - folio_pfn(folio));
>   		address = pvmw.address;

