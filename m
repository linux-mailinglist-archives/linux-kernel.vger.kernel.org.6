Return-Path: <linux-kernel+bounces-447771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29B9F36D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5CA188FD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C0207DF2;
	Mon, 16 Dec 2024 16:53:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73C14B96E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367998; cv=none; b=TaUQ1d8AMg/5cXEDOeKiXUEt3CLKHGsqc3Hrnr3DgnCeProiLPCV/GhPy+qhmgdeAvCrlsNli1ve0DDAU4vXqHytFsLhTPlbxChva2EIFaGyRdqF8wk90zIVBFDhXRDSLOhqHhU5gC4HUe8ZiPdO7Y1IubBYlNb5SaE3RwY1Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367998; c=relaxed/simple;
	bh=/lM/lm4WngV8L+aveUlJ0+j1Jt+cUCYWF6sWZAKhYFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzpv1CF1PghbuRG0L7OnbgTQxIUTSBGYPjWVve+zwNqRBmNYicv6YyWdHtOymcmfpidkDGeBDW0KEyUF/KLDZ/KANtN0tfiow4yKxdQ6cBskPABMTqrSwEa+8ic1wkb8+DFvUlEehZ/BrRrcJrO8KgHm5gtp325s7bzZoSNP1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC2C16F8;
	Mon, 16 Dec 2024 08:53:43 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C5503F528;
	Mon, 16 Dec 2024 08:53:04 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 09/12] khugepaged: Introduce vma_collapse_anon_folio()
Date: Mon, 16 Dec 2024 22:21:02 +0530
Message-Id: <20241216165105.56185-10-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241216165105.56185-1-dev.jain@arm.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrast to PMD-collapse, we do not need to operate on two levels of pagetable
simultaneously. Therefore, downgrade the mmap lock from write to read mode. Still
take the anon_vma lock in exclusive mode so as to not waste time in the rmap path,
which is anyways going to fail since the PTEs are going to be changed. Under the PTL,
copy page contents, clear the PTEs, remove folio pins, and (try to) unmap the
old folios. Set the PTEs to the new folio using the set_ptes() API.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Note: I have been trying hard to get rid of the locks in here: we still are
taking the PTL around the page copying; dropping the PTL and taking it after
the copying should lead to a deadlock, for example:
khugepaged						madvise(MADV_COLD)
folio_lock()						lock(ptl)
lock(ptl)						folio_lock()

We can create a locked folio list, altogether drop both the locks, take the PTL,
do everything which __collapse_huge_page_isolate() does *except* the isolation and
again try locking folios, but then it will reduce efficiency of khugepaged
and almost looks like a forced solution :)
Please note the following discussion if anyone is interested:
https://lore.kernel.org/all/66bb7496-a445-4ad7-8e56-4f2863465c54@arm.com/
(Apologies for not CCing the mailing list from the start)

 mm/khugepaged.c | 108 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 21 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88beebef773e..8040b130e677 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -714,24 +714,28 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 						struct vm_area_struct *vma,
 						unsigned long address,
 						spinlock_t *ptl,
-						struct list_head *compound_pagelist)
+						struct list_head *compound_pagelist, int order)
 {
 	struct folio *src, *tmp;
 	pte_t *_pte;
 	pte_t pteval;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_pte = pte; _pte < pte + (1UL << order);
 	     _pte++, address += PAGE_SIZE) {
 		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
 			if (is_zero_pfn(pte_pfn(pteval))) {
-				/*
-				 * ptl mostly unnecessary.
-				 */
-				spin_lock(ptl);
-				ptep_clear(vma->vm_mm, address, _pte);
-				spin_unlock(ptl);
+				if (order == HPAGE_PMD_ORDER) {
+					/*
+					* ptl mostly unnecessary.
+					*/
+					spin_lock(ptl);
+					ptep_clear(vma->vm_mm, address, _pte);
+					spin_unlock(ptl);
+				} else {
+					ptep_clear(vma->vm_mm, address, _pte);
+				}
 				ksm_might_unmap_zero_page(vma->vm_mm, pteval);
 			}
 		} else {
@@ -740,15 +744,20 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 			src = page_folio(src_page);
 			if (!folio_test_large(src))
 				release_pte_folio(src);
-			/*
-			 * ptl mostly unnecessary, but preempt has to
-			 * be disabled to update the per-cpu stats
-			 * inside folio_remove_rmap_pte().
-			 */
-			spin_lock(ptl);
-			ptep_clear(vma->vm_mm, address, _pte);
-			folio_remove_rmap_pte(src, src_page, vma);
-			spin_unlock(ptl);
+			if (order == HPAGE_PMD_ORDER) {
+				/*
+				* ptl mostly unnecessary, but preempt has to
+				* be disabled to update the per-cpu stats
+				* inside folio_remove_rmap_pte().
+				*/
+				spin_lock(ptl);
+				ptep_clear(vma->vm_mm, address, _pte);
+				folio_remove_rmap_pte(src, src_page, vma);
+				spin_unlock(ptl);
+			} else {
+				ptep_clear(vma->vm_mm, address, _pte);
+				folio_remove_rmap_pte(src, src_page, vma);
+			}
 			free_page_and_swap_cache(src_page);
 		}
 	}
@@ -807,7 +816,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		pmd_t *pmd, pmd_t orig_pmd, struct vm_area_struct *vma,
 		unsigned long address, spinlock_t *ptl,
-		struct list_head *compound_pagelist)
+		struct list_head *compound_pagelist, int order)
 {
 	unsigned int i;
 	int result = SCAN_SUCCEED;
@@ -815,7 +824,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 	/*
 	 * Copying pages' contents is subject to memory poison at any iteration.
 	 */
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < (1 << order); i++) {
 		pte_t pteval = ptep_get(pte + i);
 		struct page *page = folio_page(folio, i);
 		unsigned long src_addr = address + i * PAGE_SIZE;
@@ -834,7 +843,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 
 	if (likely(result == SCAN_SUCCEED))
 		__collapse_huge_page_copy_succeeded(pte, vma, address, ptl,
-						    compound_pagelist);
+						    compound_pagelist, order);
 	else
 		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
 						 compound_pagelist, order);
@@ -1196,7 +1205,7 @@ static int vma_collapse_anon_folio_pmd(struct mm_struct *mm, unsigned long addre
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
-					   &compound_pagelist);
+					   &compound_pagelist, HPAGE_PMD_ORDER);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
 		goto out_up_write;
@@ -1228,6 +1237,61 @@ static int vma_collapse_anon_folio_pmd(struct mm_struct *mm, unsigned long addre
 	return result;
 }
 
+/* Enter with mmap read lock */
+static int vma_collapse_anon_folio(struct mm_struct *mm, unsigned long address,
+		struct vm_area_struct *vma, struct collapse_control *cc, pmd_t *pmd,
+		struct folio *folio, int order)
+{
+	int result;
+	struct mmu_notifier_range range;
+	spinlock_t *pte_ptl;
+	LIST_HEAD(compound_pagelist);
+	pte_t *pte;
+	pte_t entry;
+	int nr_pages = folio_nr_pages(folio);
+
+	anon_vma_lock_write(vma->anon_vma);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
+				address + (PAGE_SIZE << order));
+	mmu_notifier_invalidate_range_start(&range);
+
+	pte = pte_offset_map_lock(mm, pmd, address, &pte_ptl);
+	if (pte)
+		result = __collapse_huge_page_isolate(vma, address, pte, cc,
+						      &compound_pagelist, order);
+	else
+		result = SCAN_PMD_NULL;
+
+	if (unlikely(result != SCAN_SUCCEED))
+		goto out_up_read;
+
+	anon_vma_unlock_write(vma->anon_vma);
+
+	__folio_mark_uptodate(folio);
+	entry = mk_pte(&folio->page, vma->vm_page_prot);
+	entry = maybe_mkwrite(entry, vma);
+
+	result = __collapse_huge_page_copy(pte, folio, pmd, *pmd,
+					   vma, address, pte_ptl,
+					   &compound_pagelist, order);
+	if (unlikely(result != SCAN_SUCCEED))
+		goto out_up_read;
+
+	folio_ref_add(folio, nr_pages - 1);
+	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
+	folio_add_lru_vma(folio, vma);
+	deferred_split_folio(folio, false);
+	set_ptes(mm, address, pte, entry, nr_pages);
+	update_mmu_cache_range(NULL, vma, address, pte, nr_pages);
+	pte_unmap_unlock(pte, pte_ptl);
+	mmu_notifier_invalidate_range_end(&range);
+	result = SCAN_SUCCEED;
+
+out_up_read:
+	mmap_read_unlock(mm);
+	return result;
+}
+
 static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 			      int referenced, int unmapped, int order,
 			      struct collapse_control *cc)
@@ -1276,6 +1340,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	if (order == HPAGE_PMD_ORDER)
 		result = vma_collapse_anon_folio_pmd(mm, address, vma, cc, pmd, folio);
+	else
+		result = vma_collapse_anon_folio(mm, address, vma, cc, pmd, folio, order);
 
 	if (result == SCAN_SUCCEED)
 		folio = NULL;
-- 
2.30.2


