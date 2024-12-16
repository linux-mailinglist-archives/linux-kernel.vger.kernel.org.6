Return-Path: <linux-kernel+bounces-447766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F299F36D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7986188EDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104420969D;
	Mon, 16 Dec 2024 16:52:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C003206261
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367941; cv=none; b=V9dX5x1ZELeUITjRfCkro/r8uhgLTM1LQRZ92TxcoeQ4rtH+vqmGxSJcp35cQSMdtG1ru/IHHNsF74Ma3sL2Bx08Ty9ZrYijFBOPKiS8mfDaHhHoAYt8UrnH1IkdYhcWFljK4CnoLmHTgdGWh8DPhhn2GDEBNOSe8HH1Exf5hHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367941; c=relaxed/simple;
	bh=C70+LWn6tFJ84D4PU6SU9Shm+vO2wQu5vxL1j6bexdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xo6Kh4OkciQEGDKABjmHo8vogWy5FGAHMJFmzpDRVQoyrql30EyyNUnFXBaYKxPZOVm1EoUrizj+YbOmnRrd5gyO9VnTpB65S03fyzpdLlm2stkpWObgkTIIukLbI0NoeaZuN5ZMuU9a5CkEX1FG0lq+SWE6Y92pUEYajzgXhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C5F16F3;
	Mon, 16 Dec 2024 08:52:47 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5BF03F528;
	Mon, 16 Dec 2024 08:52:08 -0800 (PST)
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
Subject: [RFC PATCH 04/12] khugepaged: Generalize __collapse_huge_page_swapin()
Date: Mon, 16 Dec 2024 22:20:57 +0530
Message-Id: <20241216165105.56185-5-dev.jain@arm.com>
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

If any PTE in our scan range is a swap entry, then use do_swap_page() to swap-in
the corresponding folio.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2f0601795471..f52dae7d5179 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -998,17 +998,17 @@ static int check_pmd_still_valid(struct mm_struct *mm,
  */
 static int __collapse_huge_page_swapin(struct mm_struct *mm,
 				       struct vm_area_struct *vma,
-				       unsigned long haddr, pmd_t *pmd,
-				       int referenced)
+				       unsigned long addr, pmd_t *pmd,
+				       int referenced, int order)
 {
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
-	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
+	unsigned long address, end = addr + ((1UL << order) * PAGE_SIZE);
 	int result;
 	pte_t *pte = NULL;
 	spinlock_t *ptl;
 
-	for (address = haddr; address < end; address += PAGE_SIZE) {
+	for (address = addr; address < end; address += PAGE_SIZE) {
 		struct vm_fault vmf = {
 			.vma = vma,
 			.address = address,
@@ -1153,7 +1153,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 * that case.  Continuing to collapse causes inconsistency.
 		 */
 		result = __collapse_huge_page_swapin(mm, vma, address, pmd,
-						     referenced);
+						     referenced, order);
 		if (result != SCAN_SUCCEED)
 			goto out_nolock;
 	}
-- 
2.30.2


