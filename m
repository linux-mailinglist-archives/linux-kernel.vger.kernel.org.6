Return-Path: <linux-kernel+bounces-447770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F09F36D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7576189064D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E420A5C9;
	Mon, 16 Dec 2024 16:53:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A7207A03
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367986; cv=none; b=Z0eIVbCF+0vdKVzQMQbz+1DchdZUDJ2/xsvfFkPKt13Ds4yhUBMuxl8TDAekyF7fArZWzarBw4oCstOvI365rIEqNAxK5LcPM+hvVB3U7OkFjcTT4SjRDSsWw3MDfksfS2vEmXj8rV1y8epFKNZ3nscSHWo8KRyTXcQ/4lo0Bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367986; c=relaxed/simple;
	bh=4YEoph5wgjSnLtk0qNr+xrEdds8hSnIuYMICDvRWMwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8Ax2mjj5mEDaC3ujqPTNj7bJ9aqWX9GceIVUKa+gGGZns9NxbR/OeqNJxck28Qeil/2OjWNnYCrTI6EXyUvE71Op2kvy7055ntmD+6RmEyKxVbqn682iNKh3ohpDG6WbzCt86SxYpHFU6yHEs+unpokNWCCUddq1jeh9WP7PA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BFE216F8;
	Mon, 16 Dec 2024 08:53:32 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C07E13F528;
	Mon, 16 Dec 2024 08:52:53 -0800 (PST)
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
Subject: [RFC PATCH 08/12] khugepaged: Abstract PMD-THP collapse
Date: Mon, 16 Dec 2024 22:21:01 +0530
Message-Id: <20241216165105.56185-9-dev.jain@arm.com>
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

Abstract away taking the mmap_lock exclusively, copying page contents, and
setting the PMD, into vma_collapse_anon_folio_pmd().

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 119 +++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 078794aa3335..88beebef773e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1111,58 +1111,17 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
 	return SCAN_SUCCEED;
 }
 
-static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
-			      int referenced, int unmapped, int order,
-			      struct collapse_control *cc)
+static int vma_collapse_anon_folio_pmd(struct mm_struct *mm, unsigned long address,
+		struct vm_area_struct *vma, struct collapse_control *cc, pmd_t *pmd,
+		struct folio *folio)
 {
+	struct mmu_notifier_range range;
+	spinlock_t *pmd_ptl, *pte_ptl;
 	LIST_HEAD(compound_pagelist);
-	pmd_t *pmd, _pmd;
-	pte_t *pte;
 	pgtable_t pgtable;
-	struct folio *folio;
-	spinlock_t *pmd_ptl, *pte_ptl;
-	int result = SCAN_FAIL;
-	struct vm_area_struct *vma;
-	struct mmu_notifier_range range;
-
-	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-
-	/*
-	 * Before allocating the hugepage, release the mmap_lock read lock.
-	 * The allocation can take potentially a long time if it involves
-	 * sync compaction, and we do not need to hold the mmap_lock during
-	 * that. We will recheck the vma after taking it again in write mode.
-	 */
-	mmap_read_unlock(mm);
-
-	result = alloc_charge_folio(&folio, mm, order, cc);
-	if (result != SCAN_SUCCEED)
-		goto out_nolock;
-
-	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, order, cc);
-	if (result != SCAN_SUCCEED) {
-		mmap_read_unlock(mm);
-		goto out_nolock;
-	}
-
-	result = find_pmd_or_thp_or_none(mm, address, &pmd);
-	if (result != SCAN_SUCCEED) {
-		mmap_read_unlock(mm);
-		goto out_nolock;
-	}
-
-	if (unmapped) {
-		/*
-		 * __collapse_huge_page_swapin will return with mmap_lock
-		 * released when it fails. So we jump out_nolock directly in
-		 * that case.  Continuing to collapse causes inconsistency.
-		 */
-		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced, order);
-		if (result != SCAN_SUCCEED)
-			goto out_nolock;
-	}
+	int result;
+	pmd_t _pmd;
+	pte_t *pte;
 
 	mmap_read_unlock(mm);
 	/*
@@ -1174,7 +1133,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, true, &vma, order, cc);
+
+	result = hugepage_vma_revalidate(mm, address, true, &vma, HPAGE_PMD_ORDER, cc);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -1206,7 +1166,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-						      &compound_pagelist, order);
+						      &compound_pagelist, HPAGE_PMD_ORDER);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
@@ -1262,11 +1222,64 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	deferred_split_folio(folio, false);
 	spin_unlock(pmd_ptl);
 
-	folio = NULL;
-
 	result = SCAN_SUCCEED;
 out_up_write:
 	mmap_write_unlock(mm);
+	return result;
+}
+
+static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
+			      int referenced, int unmapped, int order,
+			      struct collapse_control *cc)
+{
+	struct vm_area_struct *vma;
+	int result = SCAN_FAIL;
+	struct folio *folio;
+	pmd_t *pmd;
+
+	/*
+	 * Before allocating the hugepage, release the mmap_lock read lock.
+	 * The allocation can take potentially a long time if it involves
+	 * sync compaction, and we do not need to hold the mmap_lock during
+	 * that. We will recheck the vma after taking it again in write mode.
+	 */
+	mmap_read_unlock(mm);
+
+	result = alloc_charge_folio(&folio, mm, order, cc);
+	if (result != SCAN_SUCCEED)
+		goto out_nolock;
+
+	mmap_read_lock(mm);
+	result = hugepage_vma_revalidate(mm, address, true, &vma, order, cc);
+	if (result != SCAN_SUCCEED) {
+		mmap_read_unlock(mm);
+		goto out_nolock;
+	}
+
+	result = find_pmd_or_thp_or_none(mm, address, &pmd);
+	if (result != SCAN_SUCCEED) {
+		mmap_read_unlock(mm);
+		goto out_nolock;
+	}
+
+	if (unmapped) {
+		/*
+		 * __collapse_huge_page_swapin will return with mmap_lock
+		 * released when it fails. So we jump out_nolock directly in
+		 * that case.  Continuing to collapse causes inconsistency.
+		 */
+		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
+						     referenced, order);
+		if (result != SCAN_SUCCEED)
+			goto out_nolock;
+	}
+
+	if (order == HPAGE_PMD_ORDER)
+		result = vma_collapse_anon_folio_pmd(mm, address, vma, cc, pmd, folio);
+
+	if (result == SCAN_SUCCEED)
+		folio = NULL;
+
 out_nolock:
 	if (folio)
 		folio_put(folio);
-- 
2.30.2


