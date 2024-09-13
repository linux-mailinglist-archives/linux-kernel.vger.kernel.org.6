Return-Path: <linux-kernel+bounces-327871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956F977C16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1221F28889
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C21D6C7D;
	Fri, 13 Sep 2024 09:19:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA01D5CC1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219178; cv=none; b=r81KIsPwWezQWKQGGS8StDqwNWRloHzZ4KSqMJCJYY2zG4k4ya+I2iuKZEJF2nf8pFEGXzog1mEu5W9HEj+XPkkOJvx9r1h3n15d7JjYapIbBCTvbvjgbo/AptmJDkmlWOu2tXeFEovjouXLA2lgDKoocamuXPALeB2hVtTdTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219178; c=relaxed/simple;
	bh=CXvpaSN+tVJEE0/BqYHUploPRrHWtOXgqxZ7f+sqGnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5sFLqRufgDG17cF+nacEfZ8h42NbIObXG5hHCpshoX3ZCgIaBZQLpVLFmVViAC9E3aRneAlnIThCGkXrQ5fd7GN0jBgWogS/YMEZEiSzyYTLbsjpHwlz6eOpfIyDu8dIt+slU+7PACnhcs+iw3w4hkz2CNZmow/0zyRekoweT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42CFD339;
	Fri, 13 Sep 2024 02:20:05 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2ACB33F73B;
	Fri, 13 Sep 2024 02:19:30 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	hughd@google.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com,
	gshan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: Compute mTHP order efficiently
Date: Fri, 13 Sep 2024 14:49:02 +0530
Message-Id: <20240913091902.1160520-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use pte_range_none() to determine whether contiguous PTEs are empty
for an mTHP allocation. Instead of iterating the while loop for every
order, use some information, which is the first set PTE found, from the
previous iteration, to eliminate some cases. The key to understanding
the correctness of the patch is that the ranges we want to examine
form a strictly decreasing sequence of nested intervals.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3c01d68065be..ffc24a48ef15 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4409,26 +4409,27 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	return ret;
 }
 
-static bool pte_range_none(pte_t *pte, int nr_pages)
+static int pte_range_none(pte_t *pte, int nr_pages)
 {
 	int i;
 
 	for (i = 0; i < nr_pages; i++) {
 		if (!pte_none(ptep_get_lockless(pte + i)))
-			return false;
+			return i;
 	}
 
-	return true;
+	return nr_pages;
 }
 
 static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	pte_t *first_set_pte = NULL, *align_pte, *pte;
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
-	pte_t *pte;
+	int max_empty;
 	gfp_t gfp;
 	int order;
 
@@ -4463,8 +4464,23 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	order = highest_order(orders);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		if (pte_range_none(pte + pte_index(addr), 1 << order))
+		align_pte = pte + pte_index(addr);
+
+		/* Range to be scanned known to be empty */
+		if (align_pte + (1 << order) <= first_set_pte)
 			break;
+
+		/* Range to be scanned contains first_set_pte */
+		if (align_pte <= first_set_pte)
+			goto repeat;
+
+		/* align_pte > first_set_pte, so need to check properly */
+		max_empty = pte_range_none(align_pte, 1 << order);
+		if (max_empty == 1 << order)
+			break;
+
+		first_set_pte = align_pte + max_empty;
+repeat:
 		order = next_order(&orders, order);
 	}
 
@@ -4579,7 +4595,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, addr, vmf->pte);
 		goto release;
-	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
 		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		goto release;
 	}
@@ -4915,7 +4931,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vma, addr, vmf->pte);
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
-	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
 		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
-- 
2.30.2


