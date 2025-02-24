Return-Path: <linux-kernel+bounces-528190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10211A414A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1020C1895026
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919641DE4D3;
	Mon, 24 Feb 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgimoKgY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5DB1DB34C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374194; cv=none; b=jZ7FA3UFuodJdJUm504J3efrrEKc6ebNaLpTHp/nfHAnR953gG6315xMoJ9AVvo8g/KsHjYT9spnKz8IvG04c8vmvn2qolO1cqzyftt4VF/DqyAro5P7ZYdd0NwGrZeN4xBh10m+f1mZlA/I03Y2eG76At7bVn3xrKcEgMT++ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374194; c=relaxed/simple;
	bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL/3Z6EC3n4XCCzNmshiNtR2v+cjqv1zkM8c5BqKG75oLgCtP6NFbG+FdVSG8I92ryZaK5O527aD99cuMk9Adbk23p2xYS5aEvo62KMNQ/v6YivkDaChBbwMOdy+YvzwP8fElPEq/C1qyvoEnHoesmWTrBdPMYymAuUlGjD6zvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgimoKgY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374193; x=1771910193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tLnVPAC1yQLSjyQ6Ddtkoj6n74XKHutEDN5LFTmZpc=;
  b=cgimoKgYBUhPGlHMYrNCszYYZvJwEdzOfwAtPtaJfBZHquOxFaQrcoBr
   94vR+fRBwZSERj7all3a/3LilCgAqis9Ejnh8j9Prt8aIQI/JLMkS82PV
   1FUEs28FIDG+Z+/KXFOnETo2qYX6BN3wvHdR0B5hAEC6i6CzAVrsWdl8O
   e5XNKBgxd9y12/wtru1MY6K9zvYC0AgAAvNLbwtDTg3FGqwaFv30tlMRz
   easK4aYNReCFKjQkS1tQRHOopr/T0HI10fdKPauVt79G0+lGY7mexrB+0
   zhv1+6twxPkag6/FgQbA0XUUtg/qfcGHvf3okBArHGu49pkesFskap7wo
   Q==;
X-CSE-ConnectionGUID: ZTTTe/JISxul0jea/tY2Ig==
X-CSE-MsgGUID: +P+P9BWWTMu4YrcRsUj9TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024215"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:33 -0800
X-CSE-ConnectionGUID: uMAkBR1HTkqjUgaL134Dxw==
X-CSE-MsgGUID: hWm2vuvcR+KLBM+/N4ziWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143401"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:30 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/12] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Mon, 24 Feb 2025 13:16:18 +0800
Message-ID: <20250224051627.2956304-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device ATS is currently enabled when a domain is attached to the device
and disabled when the domain is detached. This creates a limitation:
when the IOMMU is operating in scalable mode and IOPF is enabled, the
device's domain cannot be changed.

Remove this limitation by moving ATS enablement to the device probe path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 78 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 16dd8f0de76d..f52602bde742 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1172,34 +1172,6 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_caps(struct device_domain_info *info)
-{
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
-		return;
-
-	pdev = to_pci_dev(info->dev);
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
-}
-
-static void iommu_disable_pci_caps(struct device_domain_info *info)
-{
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
-		return;
-
-	pdev = to_pci_dev(info->dev);
-
-	if (info->ats_enabled) {
-		pci_disable_ats(pdev);
-		info->ats_enabled = 0;
-	}
-}
-
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -1556,12 +1528,22 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
+	struct pci_dev *pdev;
+	int ret;
 
 	if (!dev_is_pci(dev))
 		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
-	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      domain_context_mapping_cb, domain);
+	pdev = to_pci_dev(dev);
+	ret = pci_for_each_dma_alias(pdev, domain_context_mapping_cb, domain);
+	if (ret)
+		return ret;
+
+	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+		info->ats_enabled = 1;
+
+	return 0;
 }
 
 /* Return largest possible superpage level for a given mapping */
@@ -1843,8 +1825,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	iommu_enable_pci_caps(info);
-
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3191,13 +3171,20 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
+	struct pci_dev *pdev;
+
 	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
 		return;
 	}
 
-	pci_for_each_dma_alias(to_pci_dev(info->dev),
-			       &domain_context_clear_one_cb, info);
+	pdev = to_pci_dev(info->dev);
+	pci_for_each_dma_alias(pdev, &domain_context_clear_one_cb, info);
+
+	if (info->ats_enabled) {
+		pci_disable_ats(pdev);
+		info->ats_enabled = 0;
+	}
 }
 
 /*
@@ -3214,7 +3201,6 @@ void device_block_translation(struct device *dev)
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
-	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -3749,6 +3735,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
+	if (sm_supported(iommu)) {
+		if (info->ats_supported && pci_ats_page_aligned(pdev)) {
+			ret = pci_enable_ats(pdev, VTD_PAGE_SHIFT);
+			if (ret)
+				pci_info(pdev, "Failed to enable ATS on device\n");
+			else
+				info->ats_enabled = 1;
+		}
+	}
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3765,6 +3761,11 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	if (info->ats_enabled) {
+		pci_disable_ats(to_pci_dev(dev));
+		info->ats_enabled = 0;
+	}
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 		info->pasid_enabled = 0;
@@ -4365,13 +4366,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
-	if (sm_supported(iommu)) {
+	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
-		if (!ret)
-			iommu_enable_pci_caps(info);
-	} else {
+	else
 		ret = device_setup_pass_through(dev);
-	}
 
 	return ret;
 }
-- 
2.43.0


