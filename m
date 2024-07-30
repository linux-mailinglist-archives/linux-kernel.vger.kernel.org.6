Return-Path: <linux-kernel+bounces-267788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618DC941579
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1FC1C229CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D81A2547;
	Tue, 30 Jul 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SLzKJj2S"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDF85947
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353467; cv=none; b=T5Qt6KxX/hhBcCve80IkLM416pmZQp8puBQul4k4XiR2Srgmm9JVX9ExCkGStGQk0X9bP2wbdVFiW4cq+8UcefnIcvu7v2vIm82Op56xXUMErkvrIPiXhYY/V9qTSeXoYYMZ+cGh51HB9D4U0gsYe53EHOk6vFVSuqijRqEa05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353467; c=relaxed/simple;
	bh=M8zhX8zE7s76FmCkPZjgYkFGIIHpSC+K95bZxGEmumM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ffOKJZ2qTJlzFeRyBtZGqTwEOavURpqflySUFzLe/nkaLmKzAwJKdcTYrAU2OjlIW9xIsDThz6kftDi7LiT0OTTos5E//D7rABFcY740iURMJMLjKyDkJyhRfy6SONWqcTGtKpygwAjOLYsy6+t24IUByKjUYR/vzvBtU8xsKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SLzKJj2S; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240730153058euoutp02a403d70199863df7b847325461080924~nB1hlAtqi2644526445euoutp02e
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:30:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240730153058euoutp02a403d70199863df7b847325461080924~nB1hlAtqi2644526445euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722353458;
	bh=2PQpQsbAN5MaQMdAU4JjRDjJAqY5eT9H1H/1ruZGlZE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SLzKJj2SlAPestBN17layZUtvWmxBK6B2YaYWZgsKdf9c+RtPhxOsY4aCts0CmWzo
	 NZO0MNfZvrxDyNVcZcnVyGWyfi4v2wHQQNC1F5wWBiq0Aj5qVkOcA/xyLUn25NsKxT
	 tGsdYyDbiw/1T+9vYc3IyCOqWEpW1ga/AXmzwQmk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240730153058eucas1p1567728eebd7208e4a3039146d70ea409~nB1hX5Vat1872218722eucas1p1w;
	Tue, 30 Jul 2024 15:30:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.BD.09620.23709A66; Tue, 30
	Jul 2024 16:30:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3~nB1hARyfA1738517385eucas1p2Q;
	Tue, 30 Jul 2024 15:30:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730153058eusmtrp211ee04cee701282b58c6d6fc7b921cd7~nB1g-mpXi0626506265eusmtrp2G;
	Tue, 30 Jul 2024 15:30:58 +0000 (GMT)
X-AuditID: cbfec7f5-5acd8a8000002594-30-66a90732bea8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.EA.08810.13709A66; Tue, 30
	Jul 2024 16:30:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240730153057eusmtip1b3cbb5ed8e4ce8d90f540d94d16d4089~nB1gP5CrM1725417254eusmtip1n;
	Tue, 30 Jul 2024 15:30:57 +0000 (GMT)
Message-ID: <97d87df8-6076-4df0-90a9-a8f5ddea42e9@samsung.com>
Date: Tue, 30 Jul 2024 17:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Muchun
	Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>, Oscar Salvador
	<osalvador@suse.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240725183955.2268884-2-david@redhat.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNmxlmBrQ4FrTXBZrU4EKkgPoxRkWMSmoiiRo/1ESxygBGFpmK
	ipoIahQaF2gEbEELGhWkiJRitOJCRSoIDXFBRAoxkNSARBGqAVyHqcrfufecc++5L4/GpSVe
	M+k9yfs5PlmdqCB9iDsNI46QRVRZXFhTvj9bVGkiWXflKM6+tBaRbJfplxd7/d57gm3O51nL
	o69UJKUyf9FRqmcXxwhVSUYervr08DWpqn5+RDVkDtxAbvNZHssl7jnA8aERO30S6s86sX2m
	FYecro9YBqoM1yJvGpglYDP+oLTIh5YypQje9bsJgZAywwharGEiMYSgXVdB/nX0DOtJkbiB
	YLgqF4nFIIIf95vG7RImAuy2PC8BE0wQXGttQ2J/KjTqe8c10xg5dHdcpATsx6yDwZ9ZmBbR
	tD8TBTlXtgozccaEwHneOK7BGRl09BoxAZNMOGgHtOOJvBkWqh6UezRyOFFTiAtmYHppKC0v
	QmLsNXDjWyMlYj/os1s8eDb8uicMFQynERSPdXuKHAQZrg6Pexl0OkZJIR7OLIBKa6jYXgUF
	jzNxoQ2ML7QPTBVD+ILuToGnLYGsU1JRPRcM9lv/1ta1vsBzkMIw4VkME840TDjH8H9vMSJu
	IhmXpkmK5zSLk7mDSo06SZOWHK/cnZJkRn9+0fOfdvddVNo3qLQhjEY2BDSu8JfEvLoWJ5XE
	qtMPc3xKDJ+WyGlsaBZNKGSSoFg5J2Xi1fu5vRy3j+P/shjtPTMDi3p29tjG1KTHy93Fp8tc
	b7ANJY0DgZewwuaa6BV7W68YV23Wp4yVKFc6aVnwDJ2taVeA9ajfSEhK3NO67ty+EWTxWqkn
	d5/J0tfq3QmqYOPAh/U7az5GjroW+qauja53oSfp/R+y++ZMTp3ST5m3dr6V68o6W61dW27v
	OKokskei5OmWsUiZdpJj/WZ3zPTo1MVLM782fuqus8h6jwT1aAMW3a26UKH7XnVq3pAv3xYx
	v7Yuf0HZ6rnm+Ha7ttA0ZOYnN4RSk9ztV9d8Lg511J+LuNzTdZB9uTHT8bTcuall9vU3adkt
	dEO1ulaxfYfxZHhQWIUiZNhw2y/yeHNbdYGC0CSow4NxXqP+DRjvUQW0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7qG7CvTDM4vNbWYs34Nm8XX9b+Y
	LS7vmsNmcW/Nf1aLZTsfslicmVZksWX/N3YHdo9Nnyaxe5yY8ZvFY2HDVGaP9/uusnlsPl3t
	8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
	gl7Gkd67TAVrbCvuPn/D1MC43rCLkZNDQsBE4vGXmWxdjFwcQgJLGSVud59kh0jISJyc1sAK
	YQtL/LnWBVX0nlFi7scGRpAEr4CdxPFDU8GKWARUJZZeuAYVF5Q4OfMJC4gtKiAvcf/WDLCh
	wgKeEh//dTB1MXJwiAi4SUxYFAkyk1lgDaPE8eavzCA1QgKpEtebz7OB2MwC4hK3nsxnArHZ
	BAwlut52gcU5BSwkNu5dzQ5RYybRtbWLEcKWl2jeOpt5AqPQLCRnzEIyahaSlllIWhYwsqxi
	FEktLc5Nzy021CtOzC0uzUvXS87P3cQIjL1tx35u3sE479VHvUOMTByMhxglOJiVRHjjryxN
	E+JNSaysSi3Kjy8qzUktPsRoCgyLicxSosn5wOjPK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
	SE8sSc1OTS1ILYLpY+LglGpgWhT50skk5DK/vppR8Q75fQ5cCdtKW5hEOx46sDE6108vmNZ/
	t6DjZc/3veVhNvm8qy6bvInKdgk2/ikzeWGwcphUyWHmau0dPv8dVGMiTsk8uXd3rlE5z0+u
	a1MvqRX/2CfA9bXt2YUFd0/1+uln8+8ycgz4v+xd/L4pK2UTO95EXpXiFWO9k39Iv9D8qLnp
	qyx3RtG/LnaszXvmf38+zzD60QLj+zP5FFddPR/dq6ERcvdK9qpjk1J+Xnpqdju2+J5WWYI8
	c8K+B/JpP9VFNa37PSdP2ebtpZ4X8fLCQtdNZ2XXvqvniUr1tn54TU2/XIUhecG09z+NFpVl
	dDMeXVTWKmj6qzLM4Zrg7s1KLMUZiYZazEXFiQChjpb6RgMAAA==
X-CMS-MailID: 20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3
References: <20240725183955.2268884-1-david@redhat.com>
	<20240725183955.2268884-2-david@redhat.com>
	<CGME20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3@eucas1p2.samsung.com>

On 25.07.2024 20:39, David Hildenbrand wrote:
> pte_lockptr() is the only *_lockptr() function that doesn't consume
> what would be expected: it consumes a pmd_t pointer instead of a pte_t
> pointer.
>
> Let's change that. The two callers in pgtable-generic.c are easily
> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
> pte_offset_map_nolock() to obtain the lock, even though we won't actually
> be traversing the page table.
>
> This makes the code more similar to the other variants and avoids other
> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
> reside now only in  pgtable-generic.c.
>
> Maybe, using pte_offset_map_nolock() is the right thing to do because
> the PTE table could have been removed in the meantime? At least it sounds
> more future proof if we ever have other means of page table reclaim.
>
> It's not quite clear if holding the PTE table lock is really required:
> what if someone else obtains the lock just after we unlock it? But we'll
> leave that as is for now, maybe there are good reasons.
>
> This is a preparation for adapting hugetlb page table locking logic to
> take the same locks as core-mm page table walkers would.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

This patch landed in today's linux-next as commit e98970a1d2d4 ("mm: let 
pte_lockptr() consume a pte_t pointer"). Unfortunately it causes the 
following issue on most of my ARM 32bit based test boards:

Run /sbin/init as init process
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 
00000010 when read
[00000010] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.10.0-12930-ge98970a1d2d4 #15137
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at __lock_acquire+0x20/0x1604
LR is at lock_acquire+0x21c/0x394
pc : [<c01990e4>]    lr : [<c019b2e8>]    psr: 20000093
sp : f082dc80  ip : 00000001  fp : c1d20000
r10: 00000000  r9 : c13096c8  r8 : 00000001
r7 : 00000000  r6 : c1d20000  r5 : c1278594  r4 : c1278594
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000010
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
...
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xf082dc80 to 0xf082e000)
...
Call trace:
  __lock_acquire from lock_acquire+0x21c/0x394
  lock_acquire from _raw_spin_lock+0x3c/0x4c
  _raw_spin_lock from __pte_offset_map_lock+0x64/0x118
  __pte_offset_map_lock from handle_mm_fault+0xee0/0x13c8
  handle_mm_fault from __get_user_pages+0x18c/0x848
  __get_user_pages from get_user_pages_remote+0xdc/0x474
  get_user_pages_remote from get_arg_page+0x90/0x2a4
  get_arg_page from copy_string_kernel+0x14c/0x184
  copy_string_kernel from kernel_execve+0x94/0x174
  kernel_execve from try_to_run_init_process+0xc/0x3c
  try_to_run_init_process from kernel_init+0xcc/0x12c
  kernel_init from ret_from_fork+0x14/0x28
Exception stack(0xf082dfb0 to 0xf082dff8)
...
---[ end trace 0000000000000000 ]---
note: swapper/0[1] exited with irqs disabled
note: swapper/0[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---

Reverting $subject on top of next-20240730 fixes/hides this issue.


> ---
>   include/linux/mm.h   |  7 ++++---
>   mm/khugepaged.c      | 21 +++++++++++++++------
>   mm/pgtable-generic.c |  4 ++--
>   3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2c6ccf088c7be..0472a5090b180 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2873,9 +2873,10 @@ static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>   }
>   #endif /* ALLOC_SPLIT_PTLOCKS */
>   
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>   {
> -	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> +	/* PTE page tables don't currently exceed a single page. */
> +	return ptlock_ptr(virt_to_ptdesc(pte));
>   }
>   
>   static inline bool ptlock_init(struct ptdesc *ptdesc)
> @@ -2898,7 +2899,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
>   /*
>    * We use mm->page_table_lock to guard all pagetable pages of the mm.
>    */
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>   {
>   	return &mm->page_table_lock;
>   }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdd1d8655a76b..f3b3db1046155 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1697,12 +1697,13 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   	i_mmap_lock_read(mapping);
>   	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>   		struct mmu_notifier_range range;
> +		bool retracted = false;
>   		struct mm_struct *mm;
>   		unsigned long addr;
>   		pmd_t *pmd, pgt_pmd;
>   		spinlock_t *pml;
>   		spinlock_t *ptl;
> -		bool skipped_uffd = false;
> +		pte_t *pte;
>   
>   		/*
>   		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> @@ -1739,9 +1740,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		mmu_notifier_invalidate_range_start(&range);
>   
>   		pml = pmd_lock(mm, pmd);
> -		ptl = pte_lockptr(mm, pmd);
> +
> +		/*
> +		 * No need to check the PTE table content, but we'll grab the
> +		 * PTE table lock while we zap it.
> +		 */
> +		pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
> +		if (!pte)
> +			goto unlock_pmd;
>   		if (ptl != pml)
>   			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +		pte_unmap(pte);
>   
>   		/*
>   		 * Huge page lock is still held, so normally the page table
> @@ -1752,20 +1761,20 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		 * repeating the anon_vma check protects from one category,
>   		 * and repeating the userfaultfd_wp() check from another.
>   		 */
> -		if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
> -			skipped_uffd = true;
> -		} else {
> +		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
>   			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>   			pmdp_get_lockless_sync();
> +			retracted = true;
>   		}
>   
>   		if (ptl != pml)
>   			spin_unlock(ptl);
> +unlock_pmd:
>   		spin_unlock(pml);
>   
>   		mmu_notifier_invalidate_range_end(&range);
>   
> -		if (!skipped_uffd) {
> +		if (retracted) {
>   			mm_dec_nr_ptes(mm);
>   			page_table_check_pte_clear_range(mm, addr, pgt_pmd);
>   			pte_free_defer(mm, pmd_pgtable(pgt_pmd));
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index a78a4adf711ac..13a7705df3f87 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -313,7 +313,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>   
>   	pte = __pte_offset_map(pmd, addr, &pmdval);
>   	if (likely(pte))
> -		*ptlp = pte_lockptr(mm, &pmdval);
> +		*ptlp = pte_lockptr(mm, pte);
>   	return pte;
>   }
>   
> @@ -371,7 +371,7 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>   	pte = __pte_offset_map(pmd, addr, &pmdval);
>   	if (unlikely(!pte))
>   		return pte;
> -	ptl = pte_lockptr(mm, &pmdval);
> +	ptl = pte_lockptr(mm, pte);
>   	spin_lock(ptl);
>   	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>   		*ptlp = ptl;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


