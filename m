Return-Path: <linux-kernel+bounces-275621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFB9487AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E67E1F23EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336338F91;
	Tue,  6 Aug 2024 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHyPfCKr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C438397
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912206; cv=none; b=t0/aHFL8OvxcV8UBfLKFu8F8iDlR4vemtvUaCo6SE7j2BZ5zVqJlB8unrY56PRPWCpO+sx+Mb3ysYs4ATb4CV/XsjqZVOcQejBRb4+2Ge4JlrReeCZTqlL8G6BVv4lLQzwn8IRZJuqySMhrcVdrpQ0Ci14UadZL2OCoZ6mtosoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912206; c=relaxed/simple;
	bh=h/DVCRTfMTrs5WILT1m9EibX0xteVcKQVQ0yKI2cSQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfXemR8ftk0b/3z2SthBudqjFZLuSs4UUYGp1MgqvcxZc/M9FR08k8xTUFjugAKIUNqIL9h6zh+sP84Lu1bX183UfWFTEpKSflVJdt5wmwLln5zEUjO2G7nHg6JkXguVIpn4hATwrJvc5CE/tBLFeKGLGGfIMx9b3DihlA84j8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHyPfCKr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912203; x=1754448203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/DVCRTfMTrs5WILT1m9EibX0xteVcKQVQ0yKI2cSQw=;
  b=dHyPfCKrJ+jyZ7Ss7vKGrtV24Yvn9JIr8t//faj/ZAag5M+ky4gTCMds
   ZAjqDpm5V8jfkKh4Oozx4f7I62LmnsePPFwiDaSM02xBuwxp1IRndQIP7
   etA7m7gDe9uuITE7GVYK1gnYUr8432wdlpmpiiTV/OLgVi/IKREpNzkjK
   cGVr0Y1Nnln1MZPF1CKwFztnUMJIolpDSaSBop30Ua0poxIWghVfThb02
   LQOelKCymrUrlQ9nIqNLhSRHG1S8G51NVlgSIXIVxAhayDJAlVG59iwRm
   DFrqUF4efccbHs/r150g439ZWnl7R8O7lgxr3BWuAYvmmWwB+3IzpPyQT
   g==;
X-CSE-ConnectionGUID: +4pOPFPUT2Or/YrPIM2YqQ==
X-CSE-MsgGUID: VTXtO683SGmYiMPbKrkdKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756287"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756287"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:23 -0700
X-CSE-ConnectionGUID: /IjjgwfKRXewN8Fg+SoAfg==
X-CSE-MsgGUID: n3jv0f6ZT3+U3UEbhxrfjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572535"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/7] iommu/vt-d: Factor out helpers from domain_context_mapping_one()
Date: Tue,  6 Aug 2024 10:39:39 +0800
Message-Id: <20240806023941.93454-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806023941.93454-1-baolu.lu@linux.intel.com>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract common code from domain_context_mapping_one() into new helpers,
making it reusable by other functions such as the upcoming identity domain
implementation. No intentional functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f37c8c3cba3c..2ac56e2355e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1631,6 +1631,61 @@ static void domain_exit(struct dmar_domain *domain)
 	kfree(domain);
 }
 
+/*
+ * For kdump cases, old valid entries may be cached due to the
+ * in-flight DMA and copied pgtable, but there is no unmapping
+ * behaviour for them, thus we need an explicit cache flush for
+ * the newly-mapped device. For kdump, at this point, the device
+ * is supposed to finish reset at its driver probe stage, so no
+ * in-flight DMA will exist, and we don't need to worry anymore
+ * hereafter.
+ */
+static void copied_context_tear_down(struct intel_iommu *iommu,
+				     struct context_entry *context,
+				     u8 bus, u8 devfn)
+{
+	u16 did_old;
+
+	if (!context_copied(iommu, bus, devfn))
+		return;
+
+	assert_spin_locked(&iommu->lock);
+
+	did_old = context_domain_id(context);
+	context_clear_entry(context);
+
+	if (did_old < cap_ndoms(iommu->cap)) {
+		iommu->flush.flush_context(iommu, did_old,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
+					 DMA_TLB_DSI_FLUSH);
+	}
+
+	clear_context_copied(iommu, bus, devfn);
+}
+
+/*
+ * It's a non-present to present mapping. If hardware doesn't cache
+ * non-present entry we only need to flush the write-buffer. If the
+ * _does_ cache non-present entries, then it does so in the special
+ * domain #0, which we have to flush:
+ */
+static void context_present_cache_flush(struct intel_iommu *iommu, u16 did,
+					u8 bus, u8 devfn)
+{
+	if (cap_caching_mode(iommu->cap)) {
+		iommu->flush.flush_context(iommu, 0,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+}
+
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      u8 bus, u8 devfn)
@@ -1659,31 +1714,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_present(context) && !context_copied(iommu, bus, devfn))
 		goto out_unlock;
 
-	/*
-	 * For kdump cases, old valid entries may be cached due to the
-	 * in-flight DMA and copied pgtable, but there is no unmapping
-	 * behaviour for them, thus we need an explicit cache flush for
-	 * the newly-mapped device. For kdump, at this point, the device
-	 * is supposed to finish reset at its driver probe stage, so no
-	 * in-flight DMA will exist, and we don't need to worry anymore
-	 * hereafter.
-	 */
-	if (context_copied(iommu, bus, devfn)) {
-		u16 did_old = context_domain_id(context);
-
-		if (did_old < cap_ndoms(iommu->cap)) {
-			iommu->flush.flush_context(iommu, did_old,
-						   (((u16)bus) << 8) | devfn,
-						   DMA_CCMD_MASK_NOBIT,
-						   DMA_CCMD_DEVICE_INVL);
-			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-		}
-
-		clear_context_copied(iommu, bus, devfn);
-	}
-
+	copied_context_tear_down(iommu, context, bus, devfn);
 	context_clear_entry(context);
+
 	context_set_domain_id(context, did);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
@@ -1719,23 +1752,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	context_set_present(context);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
-
-	/*
-	 * It's a non-present to present mapping. If hardware doesn't cache
-	 * non-present entry we only need to flush the write-buffer. If the
-	 * _does_ cache non-present entries, then it does so in the special
-	 * domain #0, which we have to flush:
-	 */
-	if (cap_caching_mode(iommu->cap)) {
-		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
-
+	context_present_cache_flush(iommu, did, bus, devfn);
 	ret = 0;
 
 out_unlock:
-- 
2.34.1


