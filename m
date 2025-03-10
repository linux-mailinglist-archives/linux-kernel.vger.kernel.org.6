Return-Path: <linux-kernel+bounces-553506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F6A58AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F17188DB35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4E1C1AB4;
	Mon, 10 Mar 2025 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bmb7fxw/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3451B0F20
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574867; cv=none; b=iNDszRI7MPJTwdpKtrc8exRn1jm0xwQ2X1POPvoIkBMuyZgs482gLk8rIIOQ8ASTVc1RSTJgkG01bVs4PCPrh9ZYhh4T7bKJQ7yjhzo6eMgIIqbGg4fFdWt5bBEmSgsQxF/C8w25dXas6/sLO5LJk42+LIGCnFLlEpK+ewJUb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574867; c=relaxed/simple;
	bh=e8N98miGjhZxcY9cjAV3CsYuZfyz+ZbDyvNfXdF6jbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb99xhRJJlySrR6Pn835nUmELEbl0+gcGgkJKVirneES8znxGuAvvlKz5bp137bJJw16VMbt01E+mvkD3BvD4kKCkiPVhzwg6SKF9rgJxbztdWBKjU1ltldhQtVpYpekqhZOnGeBd+PfsUD8p5Opb0nkQlH43H2fkqpjyQ4x5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bmb7fxw/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574865; x=1773110865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8N98miGjhZxcY9cjAV3CsYuZfyz+ZbDyvNfXdF6jbU=;
  b=Bmb7fxw/dg7bQjAhGKqvm0Sb/YmKNR24MTJr96mwhDrG/ANxMpThIpPF
   LLcQjQqY4i9ORK0HT0jN8l3mL9+rDGE8qS3wfssH68+1TOaxcIs+Z7aln
   xfrAQ+7ksn2ZwHTeWNnpRS18Y9I/Mr1f+23qeITjv0X2xBlqvfFTxhv9G
   mfa9oBRh9h7c00eFBeN+wxJOmtx+lmmONL//3l9Ga0IwURpoe07BoOCxZ
   IPj7sanEsjHg3702tWJhir3nVQdRXkXHCGTNG075ncamiBXtoF9e1jcmD
   EE2TV+V1MuptyRF8kkxFIstN2MgB1XaGPrtos31jnzhVnWrf5duCSz5Zy
   A==;
X-CSE-ConnectionGUID: uHb4SrBaRCmZICJRAPjlGA==
X-CSE-MsgGUID: Gte5EnLlRqGRBop95KcO5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401608"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:40 -0700
X-CSE-ConnectionGUID: vrTO/rQeQsyjEJ9fd13EOg==
X-CSE-MsgGUID: Fk5YOvyMSqqlKPGkn9k/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079235"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/vt-d: Move scalable mode ATS enablement to probe path
Date: Mon, 10 Mar 2025 10:47:47 +0800
Message-ID: <20250310024749.3702681-5-baolu.lu@linux.intel.com>
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

Device ATS is currently enabled when a domain is attached to the device
and disabled when the domain is detached. This creates a limitation:
when the IOMMU is operating in scalable mode and IOPF is enabled, the
device's domain cannot be changed.

The previous code enables ATS when a domain is set to a device's RID and
disables it during RID domain switch. So, if a PASID is set with a
domain requiring PRI, ATS should remain enabled until the domain is
removed. During the PASID domain's lifecycle, if the RID's domain
changes, PRI will be disrupted because it depends on ATS, which is
disabled when the blocking domain is set for the device's RID.

Remove this limitation by moving ATS enablement to the device probe path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://lore.kernel.org/r/20250228092631.3425464-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 51 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 58bff6fe3a93..1c8724cd2ddc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1173,32 +1173,28 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
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
@@ -1557,12 +1553,19 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
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
@@ -1844,8 +1847,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	iommu_enable_pci_caps(info);
-
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3209,6 +3210,7 @@ static void domain_context_clear(struct device_domain_info *info)
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
+	iommu_disable_pci_ats(info);
 }
 
 /*
@@ -3225,7 +3227,6 @@ void device_block_translation(struct device *dev)
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
-	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
@@ -3760,6 +3761,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
+	if (sm_supported(iommu))
+		iommu_enable_pci_ats(info);
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3776,6 +3780,8 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	iommu_disable_pci_ats(info);
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 		info->pasid_enabled = 0;
@@ -4379,13 +4385,10 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
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


