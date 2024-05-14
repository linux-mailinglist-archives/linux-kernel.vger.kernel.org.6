Return-Path: <linux-kernel+bounces-178364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FCA8C4C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B3528233C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205710A22;
	Tue, 14 May 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vNSbGIGp"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91CF9F5
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670592; cv=none; b=WAKqkB3LIAqlSeSGcWx6HgSjKmpk25Rqf14b/l7Hl4VClJ+Zxe6qw+K/rN7cqHIkkKha9Vudy6hQy0IrqqJpudCMZPAMwAAxXP9ateaknDmCipLmRjdHCC3Zc5UdxjRFpTEywsRo/kNcXCyCjZ811mh6ORM9bJyH2mAmp0eE0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670592; c=relaxed/simple;
	bh=v+0oAWHsIv9vnLTWYZ9i+V46JUXTu4Vxy3Jo+j45eqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL+SVO0eD/dFZdjYYanABgdoULOLqiHFEKE1+7dqVlii4+DMcbz1t1NrX7ZJkZYvQ29gRdgfvbJ8ksO2W+7DJbxVQQdpk2xCwiLXLEEgwYEQ3viaKFX0PXIVHp8ngixPkqvtoNZPylFXJE3TQePqGiUmRbvGCVwPxPyGM4A6fPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vNSbGIGp; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715670587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jo5rH5YIlhlSc6vEql9IJ3mfVIRNd/BxXYvuoQUAM7I=;
	b=vNSbGIGpR3Op2b0QxeeJu/NsvNqnb5py0VayHiC1dYLVm4HGaT+B0BKczsmDFP3KsLPfpyg9RH9aCkoSOt5uiHXqvrjTdwoahavvfqfegqSeWdj9bNGHiHBc3zdy6SVfmHihZN1oyFmU1g+4XGLLAkw0Kjyl4uTY3ZdnbyE62BM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6U4g0e_1715670584;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6U4g0e_1715670584)
          by smtp.aliyun-inc.com;
          Tue, 14 May 2024 15:09:45 +0800
Message-ID: <c8f52a60-94a4-48cc-be0c-824b26956934@linux.alibaba.com>
Date: Tue, 14 May 2024 15:09:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 4/4] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240513074712.7608-1-ioworker0@gmail.com>
 <20240513074712.7608-5-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240513074712.7608-5-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/13 15:47, Lance Yang wrote:
> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> typically would not re-write to that memory again.
> 
> During memory reclaim, if we detect that the large folio and its PMD are
> both still marked as clean and there are no unexpected references
> (such as GUP), so we can just discard the memory lazily, improving the
> efficiency of memory reclamation in this case.
> 
> On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
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
>   mm/huge_memory.c        | 75 +++++++++++++++++++++++++++++++++++++++++
>   mm/rmap.c               | 31 ++++++++++-------
>   3 files changed, 103 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>   
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio);
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
> +			   pmd_t *pmdp, struct folio *folio);
>   
>   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
> @@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
>   					 unsigned long address, pmd_t *pmd,
>   					 bool freeze, struct folio *folio) {}
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
> index 425272c6c50b..3ceeeb2f42d4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2687,6 +2687,81 @@ static void unmap_folio(struct folio *folio)
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

The function is called under the ptl lock, so I have no idea why the pmd 
value can be changed, seems above validation is useless.

> +
> +	tlb_gather_mmu(&tlb, mm);

You missed tlb_finish_mmu() to do tlb flushing, and ...

> +	orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
> +	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);

I don't think tlb gather is helpful here, since you just flush one PMD 
entry. Just using pmdp_huge_clear_flush() seems enough.

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

Should we also call 'folio_set_swapbacked()' if the folio was redirtied?

> +		return false;
> +	}
> +
> +	folio_remove_rmap_pmd(folio, page, vma);
> +	zap_deposited_table(mm, pmdp);
> +	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +	if (vma->vm_flags & VM_LOCKED)
> +		mlock_drain_local();
> +	folio_put(folio);
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
> +
> +	return false;
> +}
> +
>   static void remap_page(struct folio *folio, unsigned long nr)
>   {
>   	int i = 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 08a93347f283..e09f2141b8dc 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1677,18 +1677,25 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			goto walk_done_err;
>   		}
>   
> -		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> -			/*
> -			 * We temporarily have to drop the PTL and start once
> -			 * again from that now-PTE-mapped page table.
> -			 */
> -			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
> -					      folio);
> -			pvmw.pmd = NULL;
> -			spin_unlock(pvmw.ptl);
> -			pvmw.ptl = NULL;
> -			flags &= ~TTU_SPLIT_HUGE_PMD;
> -			continue;
> +		if (!pvmw.pte) {
> +			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
> +						  folio))
> +				goto walk_done;
> +
> +			if (flags & TTU_SPLIT_HUGE_PMD) {
> +				/*
> +				 * We temporarily have to drop the PTL and start
> +				 * once again from that now-PTE-mapped page
> +				 * table.
> +				 */
> +				split_huge_pmd_locked(vma, range.start,
> +						      pvmw.pmd, false, folio);
> +				pvmw.pmd = NULL;
> +				spin_unlock(pvmw.ptl);
> +				pvmw.ptl = NULL;
> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> +				continue;
> +			}
>   		}
>   
>   		/* Unexpected PMD-mapped THP? */

