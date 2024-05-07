Return-Path: <linux-kernel+bounces-170633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92F8BD9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36861283846
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5D42AAE;
	Tue,  7 May 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UzrS513o"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D143FBA2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054468; cv=none; b=jk3rQ3sk274tekh97bBilhIvJiVFeDAnQXSbKEIHx2WOxJJAPwstyOYYNc2sgvX2mP/9pXmiVmjkvLxWciwm3vZ6ylXIpRtPRjt0utj9AbYtmDP3f1Y9otY1t9yFfFQCuUUm9GVUtDh0+o8J5lQUEN+2noO6Nywc83Oos1yGi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054468; c=relaxed/simple;
	bh=rzgHUnduc+fFHUYYKIxTu2uGCns8bWG/tjldW1aRBec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPjKLoAse0wYclJS+xR0zpBuih+60zMKCFXbvWNoza/VBAmwxwLZA+6NmYiBlLTLB7TWaHQUfijQ7jihYm+zHfkqaQb5XH1JGUaCBMAbJmSNWXQxMHV+gFZ2uYkcGwNftSI2V3TLhQAGADGpx55Fr9w3TBtQ/sZlXMTYqGm6gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UzrS513o; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715054463; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+ctt2P/2LDJisCep57rIzI8C5/U7zVuNvNZlY71euns=;
	b=UzrS513o4g87grPZF4vBgOTNu1/KAn+JQcioDttwhoXog3WUkXiwFu81oCMPD3pwhfeh3gBRufdx0xq4I2eDPUYw3liSnTYj8e0XZVBTLOF7PIkJrurADbbMsR72QCPw7Rbi+Tz0jnIbv/a4FORYolTkLaESJuvg/eVMtJ+wp2I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6-h3d7_1715054460;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6-h3d7_1715054460)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 12:01:01 +0800
Message-ID: <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com>
Date: Tue, 7 May 2024 12:00:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-4-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240501042700.83974-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/1 12:27, Lance Yang wrote:
> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> typically would not re-write to that memory again.
> 
> During memory reclaim, if we detect that the large folio and its PMD are
> both still marked as clean and there are no unexpected references
> (such as GUP), so we can just discard the memory lazily, improving the
> efficiency of memory reclamation in this case.  On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
> 
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
> 
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/huge_mm.h |  9 +++++
>   mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++
>   mm/rmap.c               |  3 ++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 38c4b5537715..017cee864080 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>   
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio);
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
> +			   pmd_t *pmdp, struct folio *folio);
>   
>   static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>   					unsigned long *start,
> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>   					unsigned long *start,
>   					unsigned long *end) {}
>   
> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> +					 unsigned long addr, pmd_t *pmdp,
> +					 struct folio *folio)
> +{
> +	return false;
> +}
> +
>   #define split_huge_pud(__vma, __pmd, __address)	\
>   	do { } while (0)
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 145505a1dd05..90fdef847a88 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
>   	try_to_unmap_flush();
>   }
>   
> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> +				       unsigned long addr, pmd_t *pmdp,
> +				       struct folio *folio)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	int ref_count, map_count;
> +	pmd_t orig_pmd = *pmdp;
> +	struct mmu_gather tlb;
> +	struct page *page;
> +
> +	if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> +		return false;
> +	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
> +		return false;
> +
> +	page = pmd_page(orig_pmd);
> +	if (unlikely(page_folio(page) != folio))
> +		return false;
> +
> +	tlb_gather_mmu(&tlb, mm);
> +	orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
> +	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> +
> +	/*
> +	 * Syncing against concurrent GUP-fast:
> +	 * - clear PMD; barrier; read refcount
> +	 * - inc refcount; barrier; read PMD
> +	 */
> +	smp_mb();
> +
> +	ref_count = folio_ref_count(folio);
> +	map_count = folio_mapcount(folio);
> +
> +	/*
> +	 * Order reads for folio refcount and dirty flag
> +	 * (see comments in __remove_mapping()).
> +	 */
> +	smp_rmb();
> +
> +	/*
> +	 * If the PMD or folio is redirtied at this point, or if there are
> +	 * unexpected references, we will give up to discard this folio
> +	 * and remap it.
> +	 *
> +	 * The only folio refs must be one from isolation plus the rmap(s).
> +	 */
> +	if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
> +	    pmd_dirty(orig_pmd)) {
> +		set_pmd_at(mm, addr, pmdp, orig_pmd);
> +		return false;
> +	}
> +
> +	folio_remove_rmap_pmd(folio, page, vma);
> +	zap_deposited_table(mm, pmdp);
> +	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +	folio_put(folio);

IIUC, you missed handling mlock vma, see mlock_drain_local() in 
try_to_unmap_one().

> +
> +	return true;
> +}
> +
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
> +			   pmd_t *pmdp, struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> +
> +	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> +		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);

Why add a new function, which is only used by unmap_huge_pmd_locked()? 
Seems can be folded in unmap_huge_pmd_locked(), but not a strong 
preference:)

> +
> +	return false;
> +}
> +
>   static void remap_page(struct folio *folio, unsigned long nr)
>   {
>   	int i = 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 432601154583..1d3d30cb752c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1675,6 +1675,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		}
>   
>   		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
> +						  folio))
> +				goto walk_done;
>   			/*
>   			 * We temporarily have to drop the PTL and start once
>   			 * again from that now-PTE-mapped page table.

