Return-Path: <linux-kernel+bounces-553507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38BA58AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DC0188DE15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B91C4A2D;
	Mon, 10 Mar 2025 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1npF8N4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431E1B85CC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574867; cv=none; b=rFC0aRjEYj0hZhkK8icghNkCauqS6Qw9+BqsHOJwqXzrseTM7Iyx5uO6GAh79VIJcgsa7KoDeYg/hdmuinFGils378bM4X2KpLP6+TqFvPYV2/OmgCpMMUxzlNC5/5oBnJ7ebCQfeferRfhbcvroVm3anhqF/8jgs85U62o1AV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574867; c=relaxed/simple;
	bh=uvmDMhSJxXxzxnFDExTRka6WtW0ou5h0o0fSWRSjBJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN2UfwqFew/a9nC1+gLCevpeRpdrcy+4VE6w/89Rui7x5dkfF3uDvtQ+TDEclGUjzzud9g3RR0McD6SKihD9z11LWwKKz/0M/ZFwM7JPfd5VjkyIuZwDBNRHBy9gyU/qL0eqkBnkbgU8AuHNa4kx3MeXi3TzixuA3z/QHasNJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1npF8N4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574866; x=1773110866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvmDMhSJxXxzxnFDExTRka6WtW0ou5h0o0fSWRSjBJ8=;
  b=h1npF8N4roeTwbwKXFFeX9NOnAqBuBRSux4++PKAfOKr0eiDK1EIjWA4
   Amz/igWShZyXGHaH/xnG1KKtH4Epf609Y3C3fvENL8VLntcTwlNaooWi8
   Fglm8cgttKW3BGYjqNI0vqLoYQBF/5j7og14A8l16vrc592hJiA7J77KV
   O9ky2LhhYW+JI1G8uNApJXzh3LGIFw1nIyuLwIkRy/hvj+HOmKD8X/d1Z
   oxnB8UoS6ExG/eCD/h0S8MDWR5wK1hmo1spJBkUsNsPc/pdmWXJiZAxZj
   wJlBFJJBlDsf0uBxcvcDL63MHYd9Li92xVfEtpMO97c81dGHCm28iCriu
   w==;
X-CSE-ConnectionGUID: znVXYjwDSbyBKh5u9MlnfA==
X-CSE-MsgGUID: uHHaDt7bSuy16Vrc3QvBww==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401615"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:43 -0700
X-CSE-ConnectionGUID: j1Ok4pvtS4OLAQxoGLZd0w==
X-CSE-MsgGUID: jDwWRNNARRultASU9+vMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079239"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iommu/vt-d: Cleanup intel_context_flush_present()
Date: Mon, 10 Mar 2025 10:47:49 +0800
Message-ID: <20250310024749.3702681-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_context_flush_present() is called in places where either the
scalable mode is disabled, or scalable mode is enabled but all PASID
entries are known to be non-present. In these cases, the flush_domains
path within intel_context_flush_present() will never execute. This dead
code is therefore removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/intel/iommu.h |  5 ++---
 drivers/iommu/intel/pasid.c | 41 +++++++------------------------------
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6a6c271ef7e6..85aa66ef4d61 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1783,7 +1783,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, true);
+	intel_context_flush_no_pasid(info, context, did);
 }
 
 int __domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 42b4e500989b..c4916886da5a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1286,9 +1286,8 @@ void cache_tag_flush_all(struct dmar_domain *domain);
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
-void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool affect_domains);
+void intel_context_flush_no_pasid(struct device_domain_info *info,
+				  struct context_entry *context, u16 did);
 
 int intel_iommu_enable_prq(struct intel_iommu *iommu);
 int intel_iommu_finish_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c2742e256552..7ee18bb48bd4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -932,7 +932,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, did, false);
+	intel_context_flush_no_pasid(info, context, did);
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
@@ -1119,17 +1119,15 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
 
 /*
  * Cache invalidations after change in a context table entry that was present
- * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations). If
- * IOMMU is in scalable mode and all PASID table entries of the device were
- * non-present, set flush_domains to false. Otherwise, true.
+ * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations).
+ * This helper can only be used when IOMMU is working in the legacy mode or
+ * IOMMU is in scalable mode but all PASID table entries of the device are
+ * non-present.
  */
-void intel_context_flush_present(struct device_domain_info *info,
-				 struct context_entry *context,
-				 u16 did, bool flush_domains)
+void intel_context_flush_no_pasid(struct device_domain_info *info,
+				  struct context_entry *context, u16 did)
 {
 	struct intel_iommu *iommu = info->iommu;
-	struct pasid_entry *pte;
-	int i;
 
 	/*
 	 * Device-selective context-cache invalidation. The Domain-ID field
@@ -1152,30 +1150,5 @@ void intel_context_flush_present(struct device_domain_info *info,
 		return;
 	}
 
-	/*
-	 * For scalable mode:
-	 * - Domain-selective PASID-cache invalidation to affected domains
-	 * - Domain-selective IOTLB invalidation to affected domains
-	 * - Global Device-TLB invalidation to affected functions
-	 */
-	if (flush_domains) {
-		/*
-		 * If the IOMMU is running in scalable mode and there might
-		 * be potential PASID translations, the caller should hold
-		 * the lock to ensure that context changes and cache flushes
-		 * are atomic.
-		 */
-		assert_spin_locked(&iommu->lock);
-		for (i = 0; i < info->pasid_table->max_pasid; i++) {
-			pte = intel_pasid_get_entry(info->dev, i);
-			if (!pte || !pasid_pte_is_present(pte))
-				continue;
-
-			did = pasid_get_domain_id(pte);
-			qi_flush_pasid_cache(iommu, did, QI_PC_ALL_PASIDS, 0);
-			iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-		}
-	}
-
 	__context_flush_dev_iotlb(info);
 }
-- 
2.43.0


