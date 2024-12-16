Return-Path: <linux-kernel+bounces-447767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886D9F36CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8107716CF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FF209F44;
	Mon, 16 Dec 2024 16:52:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360D206261
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367953; cv=none; b=WtCxzlnlkdG83CmDVRpGSchi2bPQo9shbkO5tm0WcP9fRGwZ304+hw9gMwUHId4ntyrIl7jpU2kc0vb/OhQi4jZ8IqZ6wC7T97eUpeLWhlddLN3t6VwYa6RIsA45yR8o2Avs4VrdB77Hx1WyofVTLUlhOYnbJATDH8SijQQiQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367953; c=relaxed/simple;
	bh=256Ahx58gErL3CDuIbymk9CjuoQB/zV6T5dPnCoRtk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8MwqpnNhh4pUii5gotAYBGnlJk/tBRoziM5n6ulamWhBW/xdNDS4hY50ZWrCqxjb6mvdUC/uWaVSCXHRV3pNXc6ft+xCS/q7MkX7PfGeHDBJIzbmIOXXwL5cjm6KfJ7XETNClaut+A/s0BHODUN5qbLI0SE3C+xcoFDEX025x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905511AED;
	Mon, 16 Dec 2024 08:52:58 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F31C3F528;
	Mon, 16 Dec 2024 08:52:19 -0800 (PST)
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
Subject: [RFC PATCH 05/12] khugepaged: Generalize __collapse_huge_page_isolate()
Date: Mon, 16 Dec 2024 22:20:58 +0530
Message-Id: <20241216165105.56185-6-dev.jain@arm.com>
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

Scale down the scan range and the sysfs tunables according to the scan order,
and isolate the folios.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f52dae7d5179..de044b1f83d4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -564,15 +564,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 					unsigned long address,
 					pte_t *pte,
 					struct collapse_control *cc,
-					struct list_head *compound_pagelist)
+					struct list_head *compound_pagelist, int order)
 {
-	struct page *page = NULL;
-	struct folio *folio = NULL;
-	pte_t *_pte;
+	unsigned int max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
+	unsigned int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
 	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
+	struct folio *folio = NULL;
+	struct page *page = NULL;
 	bool writable = false;
+	pte_t *_pte;
 
-	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
+
+	for (_pte = pte; _pte < pte + (1UL << order);
 	     _pte++, address += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
 		if (pte_none(pteval) || (pte_present(pteval) &&
@@ -580,7 +583,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
+			     none_or_zero <= max_ptes_none)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -609,7 +612,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
-			    shared > khugepaged_max_ptes_shared) {
+			    shared > max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 				goto out;
@@ -1200,7 +1203,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
 		result = __collapse_huge_page_isolate(vma, address, pte, cc,
-						      &compound_pagelist);
+						      &compound_pagelist, order);
 		spin_unlock(pte_ptl);
 	} else {
 		result = SCAN_PMD_NULL;
-- 
2.30.2


