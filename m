Return-Path: <linux-kernel+bounces-447769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6059F36D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226AD163E24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0F20967E;
	Mon, 16 Dec 2024 16:52:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E66206261
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367975; cv=none; b=VO/fdcIAuRXD3SuiLbCUYJhjrAJy+3hz1mw68m6NO+X2raAuGignKGnCxg6rGjy2VoaVHc5XpDCiiGYmFa1m+ZPPpFoxIW0eMbyjGfcp2sQkmm6AZzt2pD1jfxoEzpFhE9jzAsQ+QxhxqySCz2yCMmJLE+lou5XU1PIqT55P84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367975; c=relaxed/simple;
	bh=uC5ZXq3Aad3MK7iTcNO4KgggSYyI1G5HepkvikAssAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6zIKwQHsZq0tCic3YxpYNx7vfZJP8jlD792I1feTarMa+AK16fDyI6eu/n8RqjdcPRUz4IBO6fsHsLQOlWpEZ1mbGNXHRftjyktJxgYjfBa2wPQI1HIWa4Twz1UeUsnZMgEaAkTIQVAKMjLDmWJNAnci7BUV28rlyQGd41YorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42BAF16F8;
	Mon, 16 Dec 2024 08:53:21 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A83103F528;
	Mon, 16 Dec 2024 08:52:42 -0800 (PST)
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
Subject: [RFC PATCH 07/12] khugepaged: Scan PTEs order-wise
Date: Mon, 16 Dec 2024 22:21:00 +0530
Message-Id: <20241216165105.56185-8-dev.jain@arm.com>
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

Scan the PTEs order-wise, using the mask of suitable orders for this VMA
derived in conjunction with sysfs THP settings. Scale down the tunables; in
case of collapse failure, we drop down to the next order. Otherwise, we try to
jump to the highest possible order and then start a fresh scan. Note that
madvise(MADV_COLLAPSE) has not been generalized.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 886c76816963..078794aa3335 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -20,6 +20,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/ksm.h>
+#include <linux/count_zeros.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1111,7 +1112,7 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
 }
 
 static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
-			      int referenced, int unmapped,
+			      int referenced, int unmapped, int order,
 			      struct collapse_control *cc)
 {
 	LIST_HEAD(compound_pagelist);
@@ -1278,38 +1279,59 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 				   unsigned long address, bool *mmap_locked,
 				   struct collapse_control *cc)
 {
-	pmd_t *pmd;
-	pte_t *pte, *_pte;
-	int result = SCAN_FAIL, referenced = 0;
-	int none_or_zero = 0, shared = 0;
-	struct page *page = NULL;
+	unsigned int max_ptes_shared, max_ptes_none, max_ptes_swap;
+	int referenced, shared, none_or_zero, unmapped;
+	unsigned long _address, org_address = address;
 	struct folio *folio = NULL;
-	unsigned long _address;
-	spinlock_t *ptl;
-	int node = NUMA_NO_NODE, unmapped = 0;
+	struct page *page = NULL;
+	int node = NUMA_NO_NODE;
+	int result = SCAN_FAIL;
 	bool writable = false;
+	unsigned long orders;
+	pte_t *pte, *_pte;
+	spinlock_t *ptl;
+	pmd_t *pmd;
+	int order;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER + 1) - 1);
+	orders = thp_vma_suitable_orders(vma, address, orders);
+	order = highest_order(orders);
+
+	/* MADV_COLLAPSE needs to work irrespective of sysfs setting */
+	if (!cc->is_khugepaged)
+		order = HPAGE_PMD_ORDER;
+
+scan_pte_range:
+
+	max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
+	max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
+	max_ptes_swap = khugepaged_max_ptes_swap >> (HPAGE_PMD_ORDER - order);
+	referenced = 0, shared = 0, none_or_zero = 0, unmapped = 0;
+
+	/* Check pmd after taking mmap lock */
 	result = find_pmd_or_thp_or_none(mm, address, &pmd);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!pte) {
 		result = SCAN_PMD_NULL;
 		goto out;
 	}
 
-	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
+	for (_address = address, _pte = pte; _pte < pte + (1UL << order);
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (is_swap_pte(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
-			    unmapped <= khugepaged_max_ptes_swap) {
+			    unmapped <= max_ptes_swap) {
 				/*
 				 * Always be strict with uffd-wp
 				 * enabled swap entries.  Please see
@@ -1330,7 +1352,7 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
+			     none_or_zero <= max_ptes_none)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -1375,7 +1397,7 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
+			    shared > max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out_unmap;
@@ -1432,7 +1454,7 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 		result = SCAN_PAGE_RO;
 	} else if (cc->is_khugepaged &&
 		   (!referenced ||
-		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
+		    (unmapped && referenced < (1UL << order) / 2))) {
 		result = SCAN_LACK_REFERENCED_PAGE;
 	} else {
 		result = SCAN_SUCCEED;
@@ -1441,9 +1463,41 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
 		result = collapse_huge_page(mm, address, referenced,
-					    unmapped, cc);
+					    unmapped, order, cc);
 		/* collapse_huge_page will return with the mmap_lock released */
 		*mmap_locked = false;
+
+		/* Immediately exit on exhaustion of range */
+		if (_address == org_address + (PAGE_SIZE << HPAGE_PMD_ORDER))
+			goto out;
+	}
+	if (result != SCAN_SUCCEED) {
+
+		/* Go to the next order. */
+		order = next_order(&orders, order);
+		if (order < 2)
+			goto out;
+		goto maybe_mmap_lock;
+	} else {
+		address = _address;
+		pte = _pte;
+
+
+		/* Get highest order possible starting from address */
+		order = count_trailing_zeros(address >> PAGE_SHIFT);
+
+		/* This needs to be present in the mask too */
+		if (!(orders & (1UL << order)))
+			order = next_order(&orders, order);
+		if (order < 2)
+			goto out;
+
+maybe_mmap_lock:
+		if (!(*mmap_locked)) {
+			mmap_read_lock(mm);
+			*mmap_locked = true;
+		}
+		goto scan_pte_range;
 	}
 out:
 	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
-- 
2.30.2


