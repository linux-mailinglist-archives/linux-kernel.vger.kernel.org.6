Return-Path: <linux-kernel+bounces-447772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18E9F36DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB65188E750
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265A20ADD3;
	Mon, 16 Dec 2024 16:53:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E814B96E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368009; cv=none; b=UsuHmfyh1QJcZ8aaKCFJxRah7HxuGML5WIyk0qNt1GkFW93I62KzsSDuz/EMsswfZvjqDf8CWVKaVW2p2AWxnNxKo/1HsI+M2/OYeFRU0NDQ/7WQVgmwFEy2VyYUfIYxSvVF+G5WrnXer9LWQtcUW6mVhWvvBaP9rx0iTPzZKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368009; c=relaxed/simple;
	bh=x8/lax7AnEY8aIMV7rJN+ovhV7eHuZNGumeyQOCxLVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnK6lHb3eh+pGcn+IbMf9Pl/EwPu4AyTuhVlOCkVkxHVhy98FYBCiK8r5JOC56LRzRixeXk7H62ts2bOeJ4pxCrFYuN0GZNwoyfiEBFb762435GrLKtw96qX5QBebmR6G+5062yntjJyppY/lCYi1RBqYIylZ/qm5gchzeI4s8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32FFE16F8;
	Mon, 16 Dec 2024 08:53:55 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 552383F528;
	Mon, 16 Dec 2024 08:53:16 -0800 (PST)
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
Subject: [RFC PATCH 10/12] khugepaged: Skip PTE range if a larger mTHP is already mapped
Date: Mon, 16 Dec 2024 22:21:03 +0530
Message-Id: <20241216165105.56185-11-dev.jain@arm.com>
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

We may hit a situation wherein we have a larger folio mapped. It is incorrect
to go ahead with the collapse since some pages will be unmapped, leading to
the entire folio getting unmapped. Therefore, skip the corresponding range.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
In the future, if at all it is required that at some point we want all the folios
in the system to be of a specific order, we may split these larger folios.

 mm/khugepaged.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8040b130e677..47e7c476b893 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -33,6 +33,7 @@ enum scan_result {
 	SCAN_PMD_NULL,
 	SCAN_PMD_NONE,
 	SCAN_PMD_MAPPED,
+	SCAN_PTE_MAPPED,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_EXCEED_SWAP_PTE,
 	SCAN_EXCEED_SHARED_PTE,
@@ -609,6 +610,11 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		folio = page_folio(page);
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
+		if (order !=HPAGE_PMD_ORDER && folio_order(folio) >= order) {
+			result = SCAN_PTE_MAPPED;
+			goto out;
+		}
+
 		/* See hpage_collapse_scan_ptes(). */
 		if (folio_likely_mapped_shared(folio)) {
 			++shared;
@@ -1369,6 +1375,7 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 	unsigned long orders;
 	pte_t *pte, *_pte;
 	spinlock_t *ptl;
+	int found_order;
 	pmd_t *pmd;
 	int order;
 
@@ -1467,6 +1474,24 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
+		found_order = folio_order(folio);
+
+		/*
+		 * No point of scanning. Two options: if this folio was hit
+		 * somewhere in the middle of the scan, then drop down the
+		 * order. Or, completely skip till the end of this folio. The
+		 * latter gives us a higher order to start with, with atmost
+		 * 1 << order PTEs not collapsed; the former may force us
+		 * to end up going below order 2 and exiting.
+		 */
+		if (order != HPAGE_PMD_ORDER && found_order >= order) {
+			result = SCAN_PTE_MAPPED;
+			_address += (PAGE_SIZE << found_order);
+			_pte += (1UL << found_order);
+			pte_unmap_unlock(pte, ptl);
+			goto decide_order;
+		}
+
 		/*
 		 * We treat a single page as shared if any part of the THP
 		 * is shared. "False negatives" from
@@ -1550,6 +1575,10 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 		if (_address == org_address + (PAGE_SIZE << HPAGE_PMD_ORDER))
 			goto out;
 	}
+	/* A larger folio was mapped; it will be skipped in next iteration */
+	if (result == SCAN_PTE_MAPPED)
+		goto decide_order;
+
 	if (result != SCAN_SUCCEED) {
 
 		/* Go to the next order. */
@@ -1558,6 +1587,8 @@ static int hpage_collapse_scan_ptes(struct mm_struct *mm,
 			goto out;
 		goto maybe_mmap_lock;
 	} else {
+
+decide_order:
 		address = _address;
 		pte = _pte;
 
-- 
2.30.2


