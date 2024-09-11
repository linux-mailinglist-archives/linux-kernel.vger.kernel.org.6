Return-Path: <linux-kernel+bounces-324147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0D97486A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E6CB24F89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93412C182;
	Wed, 11 Sep 2024 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp8WYSiN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E82A1B8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023762; cv=none; b=ow01L+eW9KobJS1AoqhMn9siGZLmGFk7t9lpQvHDHBjGoNRRiatOyv9Ig2ouGnMWsjM6yD+xg4D39zo+gVx4af8tW3WmxhukVKMs+Uow2VBTJFxC0zVHblfITr4tgCz+ZHBypzr4x0+d+gHxR1iRPRyG0YELAPZBVzMfVzmis4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023762; c=relaxed/simple;
	bh=A7W8LEOsBbOr46JpvVY36Ibjl1xDtTX61OC/71XBNqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqkR91xcSvHBN1BMMnl5Aa4M2zh/x2WkGbn4+W+qbV13E+Tc955EYnVbXHV/eO/shcryDcgxmyZ0tk23PGeEnztzGwBUtLRqkxGTi7lxy4gUATroPnz9XKQMP/9esygxZsgTvveDosir7AyFH5G6u3Aokr/4YpPhTwqc7/nLnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp8WYSiN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726023761; x=1757559761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A7W8LEOsBbOr46JpvVY36Ibjl1xDtTX61OC/71XBNqY=;
  b=Vp8WYSiNOqQ+Nhkmg0yIE3Yw1/BT7ZCsu8mxkwCNMyF6tOEZ2hBInpu2
   VbY574/Pwqbw5Mt0J09E0MMBeZudJZgw4PsOmfXy7sZU0hNT2FxkNLR4W
   1hPO8bUKdr0f8S4WBag/eYDPIMl3/nAYfA/UmXPRpE8zCQUx7exv521tk
   kubaVPslTlrH5s62lP+HL3fAOYWGgLjdkoK1IWm17IQ+uzykgxh1ccB9/
   RlcLItfvfyP13DkTpPB9H+MUNLlzEHUMhVpwGSZebuHM8nlEOtgH9u8A0
   uxRZdbFK7sGqAPq4JJgLfjncM1DnWn1H/G0FENZSUowwaRLkR0dFTFImA
   A==;
X-CSE-ConnectionGUID: I1VUimGDRhuvU1rPx8JVCw==
X-CSE-MsgGUID: CiUOBa71SISYALxjm2Gv/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24907783"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24907783"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 20:02:37 -0700
X-CSE-ConnectionGUID: NM/m61pSQAqt4mnZYvCFUw==
X-CSE-MsgGUID: FbyUWgeuSK+jdFDAFUU9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67732255"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 20:02:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	simona.vetter@ffwll.ch,
	Philip.Yang@amd.com,
	akpm@linux-foundation.org,
	felix.kuehling@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 1/1] mm/migrate: Trylock device page in do_swap_page
Date: Tue, 10 Sep 2024 20:03:37 -0700
Message-Id: <20240911030337.870160-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911030337.870160-1-matthew.brost@intel.com>
References: <20240911030337.870160-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid multiple CPU page faults to the same device page racing by locking
the page in do_swap_page before taking an additional reference to the
page. This prevents scenarios where multiple CPU page faults each take
an extra reference to a device page, which could abort migration in
folio_migrate_mapping. With the device page locked in do_swap_page, the
migrate_vma_* functions need to be updated to avoid locking the
fault_page argument.

Prior to this change, a livelock scenario could occur in Xe's (Intel GPU
DRM driver) SVM implementation if enough threads faulted the same device
page.

Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Suggessted-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/memory.c         | 13 +++++++---
 mm/migrate_device.c | 60 +++++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3c01d68065be..bbd97d16a96a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4046,10 +4046,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * Get a page reference while we know the page can't be
 			 * freed.
 			 */
-			get_page(vmf->page);
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
-			put_page(vmf->page);
+			if (trylock_page(vmf->page)) {
+				get_page(vmf->page);
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+				put_page(vmf->page);
+				unlock_page(vmf->page);
+			} else {
+				pte_unmap_unlock(vmf->pte, vmf->ptl);
+			}
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
 		} else if (is_pte_marker_entry(entry)) {
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..049893a5a179 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -60,6 +60,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				   struct mm_walk *walk)
 {
 	struct migrate_vma *migrate = walk->private;
+	struct folio *fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
 	struct vm_area_struct *vma = walk->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr = start, unmapped = 0;
@@ -88,11 +90,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			folio_get(folio);
 			spin_unlock(ptl);
-			if (unlikely(!folio_trylock(folio)))
+			if (unlikely(fault_folio != folio &&
+				     !folio_trylock(folio)))
 				return migrate_vma_collect_skip(start, end,
 								walk);
 			ret = split_folio(folio);
-			folio_unlock(folio);
+			if (fault_folio != folio)
+				folio_unlock(folio);
 			folio_put(folio);
 			if (ret)
 				return migrate_vma_collect_skip(start, end,
@@ -192,7 +196,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		 * optimisation to avoid walking the rmap later with
 		 * try_to_migrate().
 		 */
-		if (folio_trylock(folio)) {
+		if (fault_folio == folio || folio_trylock(folio)) {
 			bool anon_exclusive;
 			pte_t swp_pte;
 
@@ -204,7 +208,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 				if (folio_try_share_anon_rmap_pte(folio, page)) {
 					set_pte_at(mm, addr, ptep, pte);
-					folio_unlock(folio);
+					if (fault_folio != folio)
+						folio_unlock(folio);
 					folio_put(folio);
 					mpfn = 0;
 					goto next;
@@ -363,6 +368,8 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 					  unsigned long npages,
 					  struct page *fault_page)
 {
+	struct folio *fault_folio = fault_page ?
+		page_folio(fault_page) : NULL;
 	unsigned long i, restore = 0;
 	bool allow_drain = true;
 	unsigned long unmapped = 0;
@@ -427,7 +434,8 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 		remove_migration_ptes(folio, folio, false);
 
 		src_pfns[i] = 0;
-		folio_unlock(folio);
+		if (fault_folio != folio)
+			folio_unlock(folio);
 		folio_put(folio);
 		restore--;
 	}
@@ -536,6 +544,8 @@ int migrate_vma_setup(struct migrate_vma *args)
 		return -EINVAL;
 	if (args->fault_page && !is_device_private_page(args->fault_page))
 		return -EINVAL;
+	if (args->fault_page && !PageLocked(args->fault_page))
+		return -EINVAL;
 
 	memset(args->src, 0, sizeof(*args->src) * nr_pages);
 	args->cpages = 0;
@@ -799,19 +809,13 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 }
 EXPORT_SYMBOL(migrate_vma_pages);
 
-/*
- * migrate_device_finalize() - complete page migration
- * @src_pfns: src_pfns returned from migrate_device_range()
- * @dst_pfns: array of pfns allocated by the driver to migrate memory to
- * @npages: number of pages in the range
- *
- * Completes migration of the page by removing special migration entries.
- * Drivers must ensure copying of page data is complete and visible to the CPU
- * before calling this.
- */
-void migrate_device_finalize(unsigned long *src_pfns,
-			unsigned long *dst_pfns, unsigned long npages)
+static void __migrate_device_finalize(unsigned long *src_pfns,
+				      unsigned long *dst_pfns,
+				      unsigned long npages,
+				      struct page *fault_page)
 {
+	struct folio *fault_folio = fault_page ?
+		page_folio(fault_page) : NULL;
 	unsigned long i;
 
 	for (i = 0; i < npages; i++) {
@@ -838,7 +842,8 @@ void migrate_device_finalize(unsigned long *src_pfns,
 		src = page_folio(page);
 		dst = page_folio(newpage);
 		remove_migration_ptes(src, dst, false);
-		folio_unlock(src);
+		if (fault_folio != src)
+			folio_unlock(src);
 
 		if (is_zone_device_page(page))
 			put_page(page);
@@ -854,6 +859,22 @@ void migrate_device_finalize(unsigned long *src_pfns,
 		}
 	}
 }
+
+/*
+ * migrate_device_finalize() - complete page migration
+ * @src_pfns: src_pfns returned from migrate_device_range()
+ * @dst_pfns: array of pfns allocated by the driver to migrate memory to
+ * @npages: number of pages in the range
+ *
+ * Completes migration of the page by removing special migration entries.
+ * Drivers must ensure copying of page data is complete and visible to the CPU
+ * before calling this.
+ */
+void migrate_device_finalize(unsigned long *src_pfns,
+			unsigned long *dst_pfns, unsigned long npages)
+{
+	return __migrate_device_finalize(src_pfns, dst_pfns, npages, NULL);
+}
 EXPORT_SYMBOL(migrate_device_finalize);
 
 /**
@@ -869,7 +890,8 @@ EXPORT_SYMBOL(migrate_device_finalize);
  */
 void migrate_vma_finalize(struct migrate_vma *migrate)
 {
-	migrate_device_finalize(migrate->src, migrate->dst, migrate->npages);
+	__migrate_device_finalize(migrate->src, migrate->dst, migrate->npages,
+				  migrate->fault_page);
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 
-- 
2.34.1


