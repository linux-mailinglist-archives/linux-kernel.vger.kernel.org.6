Return-Path: <linux-kernel+bounces-538133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB0A494E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6383A18957E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5BD256C9C;
	Fri, 28 Feb 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOKn0S5t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86792256C8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734797; cv=none; b=g7UFNRtHosIbY2Mft4o2b5O4Ye+mTsKsMsW/1Emgy346w4pm7a7P9V25ntlZVAqAR6Ofko8sIg9B92yAVsgbt0QVVruNm/m8mdgGR49t7hYUZUrx6217hMXA6HhUENQBx2SwMpsZ80NbT21ZYRM+BI7d+jIJpkKwQ6w4U5ymYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734797; c=relaxed/simple;
	bh=+OpVSeUpNz374mUIvD9+SsPR4VmEAPvQ3OVJqKBiPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVdGQm2NJtcWyusn+gj3wZQ7xqwGu+0zdLmLB7qkJq4KQ8HCFLiMxcP9JBuhIOXw46cC6nhnVpVim6W0FyNWTid6gQnwsurkI+4qqSu2y+mqxzwcgkScUjA7SCw4FpKwhWpxM75hB1xc48naG8OeLJ/8OSHrdlZGbcIYAtib43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOKn0S5t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734795; x=1772270795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+OpVSeUpNz374mUIvD9+SsPR4VmEAPvQ3OVJqKBiPFc=;
  b=kOKn0S5tS70e22UgZXsctFmBDlu4WDtcw0aLI0ZiGqFlCo+/4Ldvd/h9
   AreVa26uxRnR3pWdjTgaVatBRb5+nhp1H1RuWVfyNQYbNuzzPCZUlr/eK
   yavERl8Xt976izpsUVmZTkPPP3RcgzVJcn1CwbRKRA0rrXbWUKfnGuDY3
   D1xSPP1D8RylhPfziHhX2H51xTPel0I7Nw/yO5VciXN11W7tv3zeDNHFm
   h/WK+GmUdTpLvGWpoZXvS1Gw3tEDz3IputqM8ZXFbSn0jej7hbmowIf9X
   UCG8Pii/Uf97rh/7yynprx2B28WTHXGL5tZ75oDojvrm43piNlbttHnKH
   Q==;
X-CSE-ConnectionGUID: g+Yor1i0Q9WpHx/9zVVaBg==
X-CSE-MsgGUID: ld8eGFJHSuSi57ICgOZDfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438330"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438330"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:34 -0800
X-CSE-ConnectionGUID: YCIywbGHQn+2LnF3xaNiZA==
X-CSE-MsgGUID: I4FfyRniSwO27MjSTpmPNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148212970"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:31 -0800
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
Subject: [PATCH v3 04/12] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Fri, 28 Feb 2025 17:26:23 +0800
Message-ID: <20250228092631.3425464-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c | 51 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 16dd8f0de76d..7efb32a0ac96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1172,32 +1172,28 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
 	return true;
 }
 
-static void iommu_enable_pci_caps(struct device_domain_info *info)
+static void iommu_enable_pci_ats(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	if (!dev_is_pci(info->dev))
+	if (!info->ats_supported)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+	if (!pci_ats_page_aligned(pdev))
+		return;
+
+	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
 }
 
-static void iommu_disable_pci_caps(struct device_domain_info *info)
+static void iommu_disable_pci_ats(struct device_domain_info *info)
 {
-	struct pci_dev *pdev;
-
-	if (!dev_is_pci(info->dev))
+	if (!info->ats_enabled)
 		return;
 
-	pdev = to_pci_dev(info->dev);
-
-	if (info->ats_enabled) {
-		pci_disable_ats(pdev);
-		info->ats_enabled = 0;
-	}
+	pci_disable_ats(to_pci_dev(info->dev));
+	info->ats_enabled = 0;
 }
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
@@ -1556,12 +1552,19 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
+	int ret;
 
 	if (!dev_is_pci(dev))
 		return domain_context_mapping_one(domain, iommu, bus, devfn);
 
-	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      domain_context_mapping_cb, domain);
+	ret = pci_for_each_dma_alias(to_pci_dev(dev),
+				     domain_context_mapping_cb, domain);
+	if (ret)
+		return ret;
+
+	iommu_enable_pci_ats(info);
+
+	return 0;
 }
 
 /* Return largest possible superpage level for a given mapping */
@@ -1843,8 +1846,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	iommu_enable_pci_caps(info);
-
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3198,6 +3199,7 @@ static void domain_context_clear(struct device_domain_info *info)
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
+	iommu_disable_pci_ats(info);
 }
 
 /*
@@ -3214,7 +3216,6 @@ void device_block_translation(struct device *dev)
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
-	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -3749,6 +3750,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
+	if (sm_supported(iommu))
+		iommu_enable_pci_ats(info);
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3765,6 +3769,8 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	iommu_disable_pci_ats(info);
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 		info->pasid_enabled = 0;
@@ -4365,13 +4371,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
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


