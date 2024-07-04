Return-Path: <linux-kernel+bounces-240536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED9926E83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA211F267E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61514A4EC;
	Thu,  4 Jul 2024 04:32:52 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E714A091
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067571; cv=none; b=VzFHtC7XQHPeDRUgX5V5LwuBex1hW4PFVgXw2vnrqcBrSGO5ejihPE5Hffke5D5wThbL7M4/dv2ZRzTNsWEQHpHRkiamPsFqaD73sYrmyHlleuqmH7t1kFkCIYiU8vyILCWMUlYCj4z+++wKqfWAOvA/qDk7Z9357GqQq9hrTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067571; c=relaxed/simple;
	bh=QshJOkmDi71DB8T1DtsDIKnVd/jaoOR9uj57jxAL840=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKxjP0wMY77xn2xgM+36tDauEBzgDJvgvuTY0C6TWVeWr14j6FqZsQ2ZLDIhVW6s/4xugHdiAXImK67lSz6Yudh/IKkuEKbC5XXguL3TuC2jAgElFM9flVqCBFv4BAkIV08uiXOGDMDG351NpbKHEkwSIIjieApzAP0jZJ6NO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1983A1FCF7;
	Thu,  4 Jul 2024 04:32:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06B7013889;
	Thu,  4 Jul 2024 04:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0LqbOO0lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:45 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 45/45] mm: Delete all hugetlb_entry entries
Date: Thu,  4 Jul 2024 06:31:32 +0200
Message-ID: <20240704043132.28501-46-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1983A1FCF7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Generic pagewalker can now deal with hugetlb pages as well, so there is
no need for specific hugetlb_entry functions.
Drop them all.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/mm/gmap.c      |  27 ------
 fs/proc/task_mmu.c       | 181 ---------------------------------------
 include/linux/pagewalk.h |  10 ---
 mm/damon/vaddr.c         |  89 -------------------
 mm/hmm.c                 |  54 ------------
 mm/memory-failure.c      |  17 ----
 mm/mempolicy.c           |  47 ----------
 mm/mincore.c             |  22 -----
 mm/mprotect.c            |  10 ---
 mm/pagewalk.c            |  49 +----------
 10 files changed, 1 insertion(+), 505 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 580e4ab6f018..3307f0ec505c 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2743,34 +2743,7 @@ static int __s390_enable_skey_pmd(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
-				      unsigned long hmask, unsigned long next,
-				      struct mm_walk *walk)
-{
-	pmd_t *pmd = (pmd_t *)pte;
-	unsigned long start, end;
-	struct page *page = pmd_page(*pmd);
-
-	/*
-	 * The write check makes sure we do not set a key on shared
-	 * memory. This is needed as the walker does not differentiate
-	 * between actual guest memory and the process executable or
-	 * shared libraries.
-	 */
-	if (pmd_val(*pmd) & _SEGMENT_ENTRY_INVALID ||
-	    !(pmd_val(*pmd) & _SEGMENT_ENTRY_WRITE))
-		return 0;
-
-	start = pmd_val(*pmd) & HPAGE_MASK;
-	end = start + HPAGE_SIZE;
-	__storage_key_init_range(start, end);
-	set_bit(PG_arch_1, &page->flags);
-	cond_resched();
-	return 0;
-}
-
 static const struct mm_walk_ops enable_skey_walk_ops = {
-	.hugetlb_entry		= __s390_enable_skey_hugetlb,
 	.pte_entry		= __s390_enable_skey_pte,
 	.pmd_entry		= __s390_enable_skey_pmd,
 	.walk_lock		= PGWALK_WRLOCK,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index df94f2093588..52fa82336825 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1066,52 +1066,15 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 	seq_putc(m, '\n');
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
-				 unsigned long addr, unsigned long end,
-				 struct mm_walk *walk)
-{
-	struct mem_size_stats *mss = walk->private;
-	struct vm_area_struct *vma = walk->vma;
-	pte_t ptent = huge_ptep_get(walk->mm, addr, pte);
-	struct folio *folio = NULL;
-	bool present = false;
-
-	if (pte_present(ptent)) {
-		folio = page_folio(pte_page(ptent));
-		present = true;
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
-
-		if (is_pfn_swap_entry(swpent))
-			folio = pfn_swap_entry_folio(swpent);
-	}
-
-	if (folio) {
-		/* We treat non-present entries as "maybe shared". */
-		if (!present || folio_likely_mapped_shared(folio) ||
-		    hugetlb_pmd_shared(pte))
-			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
-		else
-			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
-	}
-	return 0;
-}
-#else
-#define smaps_hugetlb_range	NULL
-#endif /* HUGETLB_PAGE */
-
 static const struct mm_walk_ops smaps_walk_ops = {
 	.pud_entry              = smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
-	.hugetlb_entry		= smaps_hugetlb_range,
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static const struct mm_walk_ops smaps_shmem_walk_ops = {
 	.pud_entry              = smaps_pud_range,
 	.pmd_entry		= smaps_pte_range,
-	.hugetlb_entry		= smaps_hugetlb_range,
 	.pte_hole		= smaps_pte_hole,
 	.walk_lock		= PGWALK_RDLOCK,
 };
@@ -1987,66 +1950,10 @@ static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
 #define pagemap_pud_range NULL
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-/* This function walks within one hugetlb entry in the single call */
-static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
-				 unsigned long addr, unsigned long end,
-				 struct mm_walk *walk)
-{
-	struct pagemapread *pm = walk->private;
-	struct vm_area_struct *vma = walk->vma;
-	u64 flags = 0, frame = 0;
-	int err = 0;
-	pte_t pte;
-
-	if (vma->vm_flags & VM_SOFTDIRTY)
-		flags |= PM_SOFT_DIRTY;
-
-	pte = huge_ptep_get(walk->mm, addr, ptep);
-	if (pte_present(pte)) {
-		struct folio *folio = page_folio(pte_page(pte));
-
-		if (!folio_test_anon(folio))
-			flags |= PM_FILE;
-
-		if (!folio_likely_mapped_shared(folio) &&
-		    !hugetlb_pmd_shared(ptep))
-			flags |= PM_MMAP_EXCLUSIVE;
-
-		if (huge_pte_uffd_wp(pte))
-			flags |= PM_UFFD_WP;
-
-		flags |= PM_PRESENT;
-		if (pm->show_pfn)
-			frame = pte_pfn(pte) +
-				((addr & ~hmask) >> PAGE_SHIFT);
-	} else if (pte_swp_uffd_wp_any(pte)) {
-		flags |= PM_UFFD_WP;
-	}
-
-	for (; addr != end; addr += PAGE_SIZE) {
-		pagemap_entry_t pme = make_pme(frame, flags);
-
-		err = add_to_pagemap(&pme, pm);
-		if (err)
-			return err;
-		if (pm->show_pfn && (flags & PM_PRESENT))
-			frame++;
-	}
-
-	cond_resched();
-
-	return err;
-}
-#else
-#define pagemap_hugetlb_range	NULL
-#endif /* HUGETLB_PAGE */
-
 static const struct mm_walk_ops pagemap_ops = {
 	.pud_entry      = pagemap_pud_range,
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
-	.hugetlb_entry	= pagemap_hugetlb_range,
 	.walk_lock	= PGWALK_RDLOCK,
 };
 
@@ -2789,67 +2696,6 @@ static int pagemap_scan_pud_entry(pud_t *pud, unsigned long start,
 #define pagemap_scan_pud_entry	NULL
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
-				      unsigned long start, unsigned long end,
-				      struct mm_walk *walk)
-{
-	struct pagemap_scan_private *p = walk->private;
-	struct vm_area_struct *vma = walk->vma;
-	unsigned long categories;
-	spinlock_t *ptl;
-	int ret = 0;
-	pte_t pte;
-
-	if (~p->arg.flags & PM_SCAN_WP_MATCHING) {
-		/* Go the short route when not write-protecting pages. */
-
-		pte = huge_ptep_get(walk->mm, start, ptep);
-		categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
-
-		if (!pagemap_scan_is_interesting_page(categories, p))
-			return 0;
-
-		return pagemap_scan_output(categories, p, start, &end);
-	}
-
-	i_mmap_lock_write(vma->vm_file->f_mapping);
-	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
-
-	pte = huge_ptep_get(walk->mm, start, ptep);
-	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
-
-	if (!pagemap_scan_is_interesting_page(categories, p))
-		goto out_unlock;
-
-	ret = pagemap_scan_output(categories, p, start, &end);
-	if (start == end)
-		goto out_unlock;
-
-	if (~categories & PAGE_IS_WRITTEN)
-		goto out_unlock;
-
-	if (end != start + HPAGE_SIZE) {
-		/* Partial HugeTLB page WP isn't possible. */
-		pagemap_scan_backout_range(p, start, end);
-		p->arg.walk_end = start;
-		ret = 0;
-		goto out_unlock;
-	}
-
-	make_uffd_wp_huge_pte(vma, start, ptep, pte);
-	flush_hugetlb_tlb_range(vma, start, end);
-
-out_unlock:
-	spin_unlock(ptl);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
-
-	return ret;
-}
-#else
-#define pagemap_scan_hugetlb_entry NULL
-#endif
-
 static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
 				 int depth, struct mm_walk *walk)
 {
@@ -2879,7 +2725,6 @@ static const struct mm_walk_ops pagemap_scan_ops = {
 	.pud_entry = pagemap_scan_pud_entry,
 	.pmd_entry = pagemap_scan_pmd_entry,
 	.pte_hole = pagemap_scan_pte_hole,
-	.hugetlb_entry = pagemap_scan_hugetlb_entry,
 };
 
 static int pagemap_scan_get_args(struct pm_scan_arg *arg,
@@ -3275,34 +3120,8 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	cond_resched();
 	return 0;
 }
-#ifdef CONFIG_HUGETLB_PAGE
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
-		unsigned long addr, unsigned long end, struct mm_walk *walk)
-{
-	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
-	struct numa_maps *md;
-	struct page *page;
-
-	if (!pte_present(huge_pte))
-		return 0;
-
-	page = pte_page(huge_pte);
-
-	md = walk->private;
-	gather_stats(page, md, pte_dirty(huge_pte), 1);
-	return 0;
-}
-
-#else
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
-		unsigned long addr, unsigned long end, struct mm_walk *walk)
-{
-	return 0;
-}
-#endif
 
 static const struct mm_walk_ops show_numa_ops = {
-	.hugetlb_entry = gather_hugetlb_stats,
 	.pud_entry = gather_pud_stats,
 	.pmd_entry = gather_pte_stats,
 	.walk_lock = PGWALK_RDLOCK,
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27cd1e59ccf7..6df0726eecb6 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -31,16 +31,6 @@ enum page_walk_lock {
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
- *			function is called with the vma lock held, in order to
- *			protect against a concurrent freeing of the pte_t* or
- *			the ptl. In some cases, the hook function needs to drop
- *			and retake the vma lock in order to avoid deadlocks
- *			while calling other functions. In such cases the hook
- *			function must either refrain from accessing the pte or
- *			ptl after dropping the vma lock, or else revalidate
- *			those items after re-acquiring the vma lock and before
- *			accessing them.
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6a383ce5a775..82a8d3146f05 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -360,63 +360,9 @@ static int damon_mkold_pud_entry(pmd_t *pud, unsigned long addr,
 	return 0;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
-				struct vm_area_struct *vma, unsigned long addr)
-{
-	bool referenced = false;
-	pte_t entry = huge_ptep_get(mm, addr, pte);
-	struct folio *folio = pfn_folio(pte_pfn(entry));
-	unsigned long psize = huge_page_size(hstate_vma(vma));
-
-	folio_get(folio);
-
-	if (pte_young(entry)) {
-		referenced = true;
-		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry, psize);
-	}
-
-#ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
-		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
-
-	if (referenced)
-		folio_set_young(folio);
-
-	folio_set_idle(folio);
-	folio_put(folio);
-}
-
-static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				     unsigned long addr, unsigned long end,
-				     struct mm_walk *walk)
-{
-	struct hstate *h = hstate_vma(walk->vma);
-	spinlock_t *ptl;
-	pte_t entry;
-
-	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry))
-		goto out;
-
-	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
-
-out:
-	spin_unlock(ptl);
-	return 0;
-}
-#else
-#define damon_mkold_hugetlb_entry NULL
-#endif /* CONFIG_HUGETLB_PAGE */
-
 static const struct mm_walk_ops damon_mkold_ops = {
 	.pud_entry = damon_mkold_pud_entry,
 	.pmd_entry = damon_mkold_pmd_entry,
-	.hugetlb_entry = damon_mkold_hugetlb_entry,
 	.walk_lock = PGWALK_RDLOCK,
 };
 
@@ -562,44 +508,9 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				     unsigned long addr, unsigned long end,
-				     struct mm_walk *walk)
-{
-	struct damon_young_walk_private *priv = walk->private;
-	struct hstate *h = hstate_vma(walk->vma);
-	struct folio *folio;
-	spinlock_t *ptl;
-	pte_t entry;
-
-	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry))
-		goto out;
-
-	folio = pfn_folio(pte_pfn(entry));
-	folio_get(folio);
-
-	if (pte_young(entry) || !folio_test_idle(folio) ||
-	    mmu_notifier_test_young(walk->mm, addr))
-		priv->young = true;
-	*priv->folio_sz = huge_page_size(h);
-
-	folio_put(folio);
-
-out:
-	spin_unlock(ptl);
-	return 0;
-}
-#else
-#define damon_young_hugetlb_entry NULL
-#endif /* CONFIG_HUGETLB_PAGE */
-
 static const struct mm_walk_ops damon_young_ops = {
 	.pud_entry = damon_young_pud_entry,
 	.pmd_entry = damon_young_pmd_entry,
-	.hugetlb_entry = damon_young_hugetlb_entry,
 	.walk_lock = PGWALK_RDLOCK,
 };
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 2b752f703b6d..fccde5dae818 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -463,59 +463,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #define hmm_vma_walk_pud	NULL
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				      unsigned long start, unsigned long end,
-				      struct mm_walk *walk)
-{
-	unsigned long addr = start, i, pfn;
-	struct hmm_vma_walk *hmm_vma_walk = walk->private;
-	struct hmm_range *range = hmm_vma_walk->range;
-	struct vm_area_struct *vma = walk->vma;
-	unsigned int required_fault;
-	unsigned long pfn_req_flags;
-	unsigned long cpu_flags;
-	spinlock_t *ptl;
-	pte_t entry;
-
-	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-
-	i = (start - range->start) >> PAGE_SHIFT;
-	pfn_req_flags = range->hmm_pfns[i];
-	cpu_flags = pte_to_hmm_pfn_flags(range, entry) |
-		    hmm_pfn_flags_order(huge_page_order(hstate_vma(vma)));
-	required_fault =
-		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
-	if (required_fault) {
-		int ret;
-
-		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-		/*
-		 * Avoid deadlock: drop the vma lock before calling
-		 * hmm_vma_fault(), which will itself potentially take and
-		 * drop the vma lock. This is also correct from a
-		 * protection point of view, because there is no further
-		 * use here of either pte or ptl after dropping the vma
-		 * lock.
-		 */
-		ret = hmm_vma_fault(addr, end, required_fault, walk);
-		hugetlb_vma_lock_read(vma);
-		return ret;
-	}
-
-	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
-	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
-		range->hmm_pfns[i] = pfn | cpu_flags;
-
-	spin_unlock(ptl);
-	return 0;
-}
-#else
-#define hmm_vma_walk_hugetlb_entry NULL
-#endif /* CONFIG_HUGETLB_PAGE */
-
 static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 			     struct mm_walk *walk)
 {
@@ -554,7 +501,6 @@ static const struct mm_walk_ops hmm_walk_ops = {
 	.pud_entry	= hmm_vma_walk_pud,
 	.pmd_entry	= hmm_vma_walk_pmd,
 	.pte_hole	= hmm_vma_walk_hole,
-	.hugetlb_entry	= hmm_vma_walk_hugetlb_entry,
 	.test_walk	= hmm_vma_walk_test,
 	.walk_lock	= PGWALK_RDLOCK,
 };
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 622862c4c300..c4ce4cf16651 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -882,26 +882,9 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	return ret;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
-			    unsigned long addr, unsigned long end,
-			    struct mm_walk *walk)
-{
-	struct hwpoison_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
-	struct hstate *h = hstate_vma(walk->vma);
-
-	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
-				      hwp->pfn, &hwp->tk);
-}
-#else
-#define hwpoison_hugetlb_range	NULL
-#endif
-
 static const struct mm_walk_ops hwpoison_walk_ops = {
 	.pud_entry = hwpoison_pud_range,
 	.pmd_entry = hwpoison_pte_range,
-	.hugetlb_entry = hwpoison_hugetlb_range,
 	.walk_lock = PGWALK_RDLOCK,
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 93b14090d484..8b5ca719193c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -645,51 +645,6 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
-			       unsigned long addr, unsigned long end,
-			       struct mm_walk *walk)
-{
-#ifdef CONFIG_HUGETLB_PAGE
-	struct queue_pages *qp = walk->private;
-	unsigned long flags = qp->flags;
-	struct folio *folio;
-	spinlock_t *ptl;
-	pte_t entry;
-
-	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry)))
-			qp->nr_failed++;
-		goto unlock;
-	}
-	folio = pfn_folio(pte_pfn(entry));
-	if (!queue_folio_required(folio, qp))
-		goto unlock;
-	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
-	    !vma_migratable(walk->vma)) {
-		qp->nr_failed++;
-		goto unlock;
-	}
-	/*
-	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
-	 * Choosing not to migrate a shared folio is not counted as a failure.
-	 *
-	 * See folio_likely_mapped_shared() on possible imprecision when we
-	 * cannot easily detect if a folio is shared.
-	 */
-	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (!folio_likely_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
-		if (!isolate_hugetlb(folio, qp->pagelist))
-			qp->nr_failed++;
-unlock:
-	spin_unlock(ptl);
-	if (qp->nr_failed && strictly_unmovable(flags))
-		return -EIO;
-#endif
-	return 0;
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * This is used to mark a range of virtual addresses to be inaccessible.
@@ -760,7 +715,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
-	.hugetlb_entry		= queue_folios_hugetlb,
 	.pud_entry		= queue_folios_pud,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
@@ -768,7 +722,6 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
 };
 
 static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
-	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 	.walk_lock		= PGWALK_WRLOCK,
diff --git a/mm/mincore.c b/mm/mincore.c
index 786df7246899..26f699a47371 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -23,27 +23,6 @@
 #include <linux/uaccess.h>
 #include "swap.h"
 
-static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
-			unsigned long end, struct mm_walk *walk)
-{
-#ifdef CONFIG_HUGETLB_PAGE
-	unsigned char present;
-	unsigned char *vec = walk->private;
-
-	/*
-	 * Hugepages under user process are always in RAM and never
-	 * swapped out, but theoretically it needs to be checked.
-	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
-	for (; addr != end; vec++, addr += PAGE_SIZE)
-		*vec = present;
-	walk->private = vec;
-#else
-	BUG();
-#endif
-	return 0;
-}
-
 /*
  * Later we can get more picky about what "in core" means precisely.
  * For now, simply check to see if the page is in the page cache,
@@ -197,7 +176,6 @@ static const struct mm_walk_ops mincore_walk_ops = {
 	.pud_entry		= mincore_pud_range,
 	.pmd_entry		= mincore_pte_range,
 	.pte_hole		= mincore_unmapped_range,
-	.hugetlb_entry		= mincore_hugetlb,
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..ca1962d5cb95 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -555,15 +555,6 @@ static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
 		0 : -EACCES;
 }
 
-static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
-				   unsigned long addr, unsigned long next,
-				   struct mm_walk *walk)
-{
-	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
-				  *(pgprot_t *)(walk->private)) ?
-		0 : -EACCES;
-}
-
 static int prot_none_test(unsigned long addr, unsigned long next,
 			  struct mm_walk *walk)
 {
@@ -572,7 +563,6 @@ static int prot_none_test(unsigned long addr, unsigned long next,
 
 static const struct mm_walk_ops prot_none_walk_ops = {
 	.pte_entry		= prot_none_pte_entry,
-	.hugetlb_entry		= prot_none_hugetlb_entry,
 	.test_walk		= prot_none_test,
 	.walk_lock		= PGWALK_WRLOCK,
 };
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 78d45f1450aa..7e2721f49e68 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -257,49 +257,6 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	return err;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static unsigned long hugetlb_entry_end(struct hstate *h, unsigned long addr,
-				       unsigned long end)
-{
-	unsigned long boundary = (addr & huge_page_mask(h)) + huge_page_size(h);
-	return boundary < end ? boundary : end;
-}
-
-static int walk_hugetlb_range(unsigned long addr, unsigned long end,
-			      struct mm_walk *walk)
-{
-	struct vm_area_struct *vma = walk->vma;
-	struct hstate *h = hstate_vma(vma);
-	unsigned long next;
-	unsigned long hmask = huge_page_mask(h);
-	unsigned long sz = huge_page_size(h);
-	pte_t *pte;
-	const struct mm_walk_ops *ops = walk->ops;
-	int err = 0;
-
-	do {
-		next = hugetlb_entry_end(h, addr, end);
-		pte = hugetlb_walk(vma, addr & hmask, sz);
-		if (pte)
-			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
-		else if (ops->pte_hole)
-			err = ops->pte_hole(addr, next, -1, walk);
-		if (err)
-			break;
-	} while (addr = next, addr != end);
-
-	return err;
-}
-
-#else /* CONFIG_HUGETLB_PAGE */
-static int walk_hugetlb_range(unsigned long addr, unsigned long end,
-			      struct mm_walk *walk)
-{
-	return 0;
-}
-
-#endif /* CONFIG_HUGETLB_PAGE */
-
 /*
  * Decide whether we really walk over the current vma on [@start, @end)
  * or skip it via the returned value. Return 0 if we do walk over the
@@ -346,11 +303,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 	}
 
 	vma_pgtable_walk_begin(vma);
-	if (is_vm_hugetlb_page(vma)) {
-		if (ops->hugetlb_entry)
-			err = walk_hugetlb_range(start, end, walk);
-	} else
-		err = walk_pgd_range(start, end, walk);
+	err = walk_pgd_range(start, end, walk);
 	vma_pgtable_walk_end(vma);
 
 	if (ops->post_vma)
-- 
2.26.2


