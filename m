Return-Path: <linux-kernel+bounces-447768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8879F36D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0581E16CB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8C209F5F;
	Mon, 16 Dec 2024 16:52:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57B20967E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367964; cv=none; b=RpIpnTnkN3UWmFXzz50P0ZdDX15xj+IUQi2wMxX8RL93Ubr44jPtPpla8/CqBKJD0sz4ydILLSUyjenZQRhwULjtZxrtzFx23MyDTXhVanZxUsuB8A5DZSFKEEUutGVSMtu8Og1uW9iP8tfo1ekr6nN97NW+purRSb8yITzE6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367964; c=relaxed/simple;
	bh=s4Dcm7BxivCXfxFTi4K7SM7RPhBnJFy1cF3ksI6fZ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVfsv5YrKXEgqtLdk4B/jx0iy+4B5hqJj0entLT49s+mduqc+5+9bRUz2IIovn3iZ5r2VT9BnfT7WzjvGHt9YJLRSJgUp5x9iTPUoyyKHjCe0LhUhqYr6KMdLywflIrKLCihhEwr+LFkOcR8xUk4I5+zbzmq8M8BlEYeLUlPrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2894116F8;
	Mon, 16 Dec 2024 08:53:10 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 364F13F528;
	Mon, 16 Dec 2024 08:52:30 -0800 (PST)
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
Subject: [RFC PATCH 06/12] khugepaged: Generalize __collapse_huge_page_copy_failed()
Date: Mon, 16 Dec 2024 22:20:59 +0530
Message-Id: <20241216165105.56185-7-dev.jain@arm.com>
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

Upon failure, we repopulate the PMD in case of PMD-THP collapse. Hence, make
this logic specific for PMD case.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index de044b1f83d4..886c76816963 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -766,7 +766,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 					     pmd_t *pmd,
 					     pmd_t orig_pmd,
 					     struct vm_area_struct *vma,
-					     struct list_head *compound_pagelist)
+					     struct list_head *compound_pagelist, int order)
 {
 	spinlock_t *pmd_ptl;
 
@@ -776,14 +776,16 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * pages. Since pages are still isolated and locked here,
 	 * acquiring anon_vma_lock_write is unnecessary.
 	 */
-	pmd_ptl = pmd_lock(vma->vm_mm, pmd);
-	pmd_populate(vma->vm_mm, pmd, pmd_pgtable(orig_pmd));
-	spin_unlock(pmd_ptl);
+	if (order == HPAGE_PMD_ORDER) {
+		pmd_ptl = pmd_lock(vma->vm_mm, pmd);
+		pmd_populate(vma->vm_mm, pmd, pmd_pgtable(orig_pmd));
+		spin_unlock(pmd_ptl);
+	}
 	/*
 	 * Release both raw and compound pages isolated
 	 * in __collapse_huge_page_isolate.
 	 */
-	release_pte_pages(pte, pte + HPAGE_PMD_NR, compound_pagelist);
+	release_pte_pages(pte, pte + (1UL << order), compound_pagelist);
 }
 
 /*
@@ -834,7 +836,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 						    compound_pagelist);
 	else
 		__collapse_huge_page_copy_failed(pte, pmd, orig_pmd, vma,
-						 compound_pagelist);
+						 compound_pagelist, order);
 
 	return result;
 }
-- 
2.30.2


