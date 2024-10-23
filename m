Return-Path: <linux-kernel+bounces-379006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AED9AD88C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88DC1C21C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB620012B;
	Wed, 23 Oct 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STpYxvfS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C61FF7B7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726764; cv=none; b=WbI1BPumpl+riyk5SM0gVgya+5Banv6jMVkDduvlEJenT2SmLnAS+uIfw9fnjCd0aEAD/Mp98ZBBpsRf2BmjGQfr3b31G+0VO0CKYN4IHvhVnqR0wFBhv/g7VVIKrAgYWQwX+VdFVd3b27jzsNr3J5rw0+tbxewTpFegEMcym0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726764; c=relaxed/simple;
	bh=DnOcHz9KmFrXRT0ci9znLuaYw7w3MglgopwNNF2CSag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFlB60gi7J/SHzZSrdy9CHHw/Oli2/FRmX2fXt03676D9PL+Btri0m/57yXfSK7L7EhiHLdR+/AuskD0QLPJvjaTg12BhqfFNK1cP+Yd8miPaBWkzNZxMeFSAMm+nVi+K7JnrvVqMdDjLUxr06/B2spCybUNQE7eaYIazCuJ/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STpYxvfS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729726762; x=1761262762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DnOcHz9KmFrXRT0ci9znLuaYw7w3MglgopwNNF2CSag=;
  b=STpYxvfSZHnv9fp2Lbp7h0rDsMPAx2BbXPPfz694nAWWAzST9oLkkY9d
   eeh31VFqHBEhwG5kYmThEyFLzgToeM106vY8kV852il+qJwdzSR3I1WIf
   0CYyol1u3Hu9ntjyOHobjIQoC6023+fIMOuqhdPr/UWrFFKDD7iyXscOa
   HVC7qtvthWNWKXyYn0neg/Yubv3bNmCb1nUNEWzZorQYYaBSyJK5MzPp4
   bub/z/U1enx3Ok+f9KDd0j71Z/RMiKKC1x4MJFsp7siIHzOHKUi80yMj3
   DAh6KeVQmEaNT/SV/L8tbFnKfaPB6sKvc3FWgna9JH+UHmtUZD/QU72ij
   g==;
X-CSE-ConnectionGUID: KCXkEMbDRv+01wzNp5EWeg==
X-CSE-MsgGUID: V8+sUiN2TImRx9DmhTJKzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33251097"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33251097"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:39:19 -0700
X-CSE-ConnectionGUID: vHd3tA6QSpCOaheKbKXr4Q==
X-CSE-MsgGUID: zKqmRqKLQUehodDvQOtCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80420924"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:39:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	simona.vetter@ffwll.ch,
	akpm@linux-foundation.org,
	felix.kuehling@amd.com,
	apopple@nvidia.com
Subject: [PATCH v3 1/1] mm/migrate: Add migrate_device_pfns
Date: Wed, 23 Oct 2024 16:39:44 -0700
Message-Id: <20241023233944.1798835-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023233944.1798835-1-matthew.brost@intel.com>
References: <20241023233944.1798835-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement migrate_device_pfns to prepare an array of PFNs for migration.
Handles non-contiguous ranges of device pages that require migration.

v2:
 - s/migrate_device_vma_range/migrate_device_prepopulated_range
 - Drop extra mmu invalidation (Vetter)
v3:
 - s/migrate_device_prepopulated_range/migrate_device_pfns (Alistair)
 - Use helper to lock device pages (Alistair)

Cc: Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/migrate.h |  1 +
 mm/migrate_device.c     | 52 +++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 002e49b2ebd9..6254746648cc 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -229,6 +229,7 @@ void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
 int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 			unsigned long npages);
+int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages);
 void migrate_device_pages(unsigned long *src_pfns, unsigned long *dst_pfns,
 			unsigned long npages);
 void migrate_device_finalize(unsigned long *src_pfns,
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf26592ac93..950229706485 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -876,6 +876,22 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 
+static unsigned long migrate_device_pfn_lock(unsigned long pfn)
+{
+	struct folio *folio;
+
+	folio = folio_get_nontail_page(pfn_to_page(pfn));
+	if (!folio)
+		return 0;
+
+	if (!folio_trylock(folio)) {
+		folio_put(folio);
+		return 0;
+	}
+
+	return migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
+}
+
 /**
  * migrate_device_range() - migrate device private pfns to normal memory.
  * @src_pfns: array large enough to hold migrating source device private pfns.
@@ -900,29 +916,35 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 {
 	unsigned long i, pfn;
 
-	for (pfn = start, i = 0; i < npages; pfn++, i++) {
-		struct folio *folio;
+	for (pfn = start, i = 0; i < npages; pfn++, i++)
+		src_pfns[i] = migrate_device_pfn_lock(pfn);
 
-		folio = folio_get_nontail_page(pfn_to_page(pfn));
-		if (!folio) {
-			src_pfns[i] = 0;
-			continue;
-		}
+	migrate_device_unmap(src_pfns, npages, NULL);
 
-		if (!folio_trylock(folio)) {
-			src_pfns[i] = 0;
-			folio_put(folio);
-			continue;
-		}
+	return 0;
+}
+EXPORT_SYMBOL(migrate_device_range);
 
-		src_pfns[i] = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
-	}
+/**
+ * migrate_device_pfns() - migrate device private pfns to normal memory.
+ * @src_pfns: pre-popluated array of source device private pfns to migrate.
+ * @npages: number of pages to migrate.
+ *
+ * Similar to migrate_device_range() but supports non-contiguous pre-popluated
+ * array of device pfns to migrate.
+ */
+int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
+{
+	unsigned long i;
+
+	for (i = 0; i < npages; i++)
+		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
 
 	migrate_device_unmap(src_pfns, npages, NULL);
 
 	return 0;
 }
-EXPORT_SYMBOL(migrate_device_range);
+EXPORT_SYMBOL(migrate_device_pfns);
 
 /*
  * Migrate a device coherent folio back to normal memory. The caller should have
-- 
2.34.1


