Return-Path: <linux-kernel+bounces-447773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E849F36DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126BA1891D41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49B20ADD6;
	Mon, 16 Dec 2024 16:53:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC320628A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368020; cv=none; b=m0wDxHpcHLTNCi6qKA1NIh/77iYuonXILJIfcZsCYfhNj18la4freOKlpFMCNVyTCl9Sol5U2fseMZXvLQaLFh14925ZzQ3E4vcSSIPRI866m3pA7XcZ9FM+6k4QaOBdTPVF5P/IRBChr35d/5XYPodSN9WETLGnVGMWvc1dKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368020; c=relaxed/simple;
	bh=Qq63Q6G0y1Jtctd8xyf5/g1EfA4Ks1NpSue9gU92jfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+jNEIbHWegMwsmdt2TVw6fyGV/aLTrVlT9JlPFyvrjF0hvfHXejowcErM8xAvZJWXTCwoGabAepP+6YXN/lfC846CeYusd7HAAD3I0jwAbA+XjoLmibX6Z1z1JMNUkTXd4+LEfOfFZ/T6gcWAtme9HRGe7GRg/R5SPnFaQutKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911B616F8;
	Mon, 16 Dec 2024 08:54:06 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B695E3F528;
	Mon, 16 Dec 2024 08:53:27 -0800 (PST)
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
Subject: [RFC PATCH 11/12] khugepaged: Enable sysfs to control order of collapse
Date: Mon, 16 Dec 2024 22:21:04 +0530
Message-Id: <20241216165105.56185-12-dev.jain@arm.com>
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

Activate khugepaged for anonymous collapse even if a single order is activated.
Note that, we are still scanning the VMAs only when they are PMD-aligned/sized,
for ease of implementation.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/khugepaged.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 47e7c476b893..ffc4d5aef991 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -414,24 +414,20 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 	       test_bit(MMF_DISABLE_THP, &mm->flags);
 }
 
-static bool hugepage_pmd_enabled(void)
+static bool thp_enabled(void)
 {
 	/*
 	 * We cover the anon, shmem and the file-backed case here; file-backed
 	 * hugepages, when configured in, are determined by the global control.
-	 * Anon pmd-sized hugepages are determined by the pmd-size control.
+	 * Anon mTHPs are determined by the per-size control.
 	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
 	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
 	 */
 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 	    hugepage_global_enabled())
 		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
-		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
-		return true;
-	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
-	    hugepage_global_enabled())
+	if (huge_anon_orders_always || huge_anon_orders_madvise ||
+	    (huge_anon_orders_inherit && hugepage_global_enabled()))
 		return true;
 	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
 		return true;
@@ -474,9 +470,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+	    thp_enabled()) {
+		if (thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
+					    BIT(PMD_ORDER + 1) - 1))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -2586,8 +2582,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+		if (!thp_vma_allowable_orders(vma, vma->vm_flags,
+					TVA_ENFORCE_SYSFS, BIT(PMD_ORDER + 1) - 1)) {
 skip:
 			progress++;
 			continue;
@@ -2611,6 +2607,11 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
 			if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+				if (!thp_vma_allowable_order(vma, vma->vm_flags,
+				    TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+					khugepaged_scan.address += HPAGE_PMD_SIZE;
+					continue;
+				}
 				struct file *file = get_file(vma->vm_file);
 				pgoff_t pgoff = linear_page_index(vma,
 						khugepaged_scan.address);
@@ -2689,7 +2690,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 
 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && thp_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2762,7 +2763,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (hugepage_pmd_enabled())
+	if (thp_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2793,7 +2794,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_pmd_enabled()) {
+	if (!thp_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2843,7 +2844,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled()) {
+	if (thp_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2869,7 +2870,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled() && khugepaged_thread)
+	if (thp_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
-- 
2.30.2


