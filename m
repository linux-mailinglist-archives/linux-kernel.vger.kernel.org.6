Return-Path: <linux-kernel+bounces-280396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A22394C9FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045E41F21E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F416D301;
	Fri,  9 Aug 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EE/SDKM9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B616D338
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183093; cv=none; b=TJRSRrs6M85w1qwDXltNwz0nTSSHCN97bfDTl5qRLHD9Wy2tReQkapHRcQWmJ84KyfnYbb9A3CMrM7X0I8UcfHtT2oLGj3bY8j2xKsUsrP28YIFjblembfBPDCWseQhOUvMQOdaDQ04QBGOSJG/TZ6LzpmWeXDIleZnTGzmnvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183093; c=relaxed/simple;
	bh=c7v96DK+GCPmvTOHcXM9hx7vasVuUoNQMA4x16fiRTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/K77V2SvsbxbDnJN5vYXHmRIzZGpSF3vqR0d7zoG+N37eNpzwxf+OJucBaKr2GSrVggKluyBMQzzRz5r6MYjudGLWeNjm9b2CryXP3vYan+/tBLu8+3I+79u0Pc+fZLfdmnlMiGJ9RtTFe4ruu0r1PmKL8foGDSbqYEVeN3SVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EE/SDKM9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183092; x=1754719092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7v96DK+GCPmvTOHcXM9hx7vasVuUoNQMA4x16fiRTA=;
  b=EE/SDKM9mrB7f7SWJmKQ5jx6bQa1Yx9JwqxXNh9QsKskFAhIB6MNdbLg
   ourCb57nkPsMrnKgGqoBgCbsI2gm7Z3gw8jO0UaXNpqmItm1AdLVrt3PT
   Fair87s3IBX9/JcedSiZwZqQQssIb8Rn218S2+0nBXKWdHE7iI3/7iGFL
   IKatFtGJccdlPON5SMOExk5hXfdwdBfDAoxnw/Zzo6cTxbFokKybz3+1N
   SmXpGb5YUqyGwBIxblxJuUbaeJwGHDiBYV81uUQnx6OZnn1MnIYxjsaIz
   HQx9NvKw/gLJBshly9A9jqLIbiabJPkFOq9XTy0snC8HPKFC2HVifA4rw
   w==;
X-CSE-ConnectionGUID: QH7/OrFLQJq926HnVJgTIQ==
X-CSE-MsgGUID: W7muLkdtRfy5XxXGIPBc+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469143"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469143"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:12 -0700
X-CSE-ConnectionGUID: YOdDjjWtRAi+TWiIO2bKRA==
X-CSE-MsgGUID: mBmRpl6OT2e2Lj2mitnpHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540907"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 4/7] iommu/vt-d: Remove has_iotlb_device flag
Date: Fri,  9 Aug 2024 13:54:28 +0800
Message-Id: <20240809055431.36513-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The has_iotlb_device flag was used to indicate if a domain had attached
devices with ATS enabled. Domains without this flag didn't require device
TLB invalidation during unmap operations, optimizing performance by
avoiding unnecessary device iteration.

With the introduction of cache tags, this flag is no longer needed. The
code to iterate over attached devices was removed by commit 06792d067989
("iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()").

Remove has_iotlb_device to avoid unnecessary code.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  |  2 --
 drivers/iommu/intel/iommu.c  | 34 +---------------------------------
 drivers/iommu/intel/nested.c |  2 --
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..01002ae2a091 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -588,7 +588,6 @@ struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
 
-	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;
@@ -1104,7 +1103,6 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-void domain_update_iotlb(struct dmar_domain *domain);
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c019fb3b3e78..aa8e10a2ad51 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -485,7 +485,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
 	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
-	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1263,32 +1262,6 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-void domain_update_iotlb(struct dmar_domain *domain)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	bool has_iotlb_device = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
 /*
  * The extra devTLB flush quirk impacts those QAT devices with PCI device
  * IDs ranging from 0x4940 to 0x4943. It is exempted from risky_device()
@@ -1325,10 +1298,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		info->pasid_enabled = 1;
 
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
-	}
 }
 
 static void iommu_disable_pci_caps(struct device_domain_info *info)
@@ -1343,7 +1314,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
 	}
 
 	if (info->pasid_enabled) {
@@ -1517,7 +1487,6 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->use_first_level = true;
-	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
@@ -3518,7 +3487,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	xa_init(&domain->iommu_array);
 
 	domain->nid = dev_to_node(dev);
-	domain->has_iotlb_device = info->ats_enabled;
 	domain->use_first_level = first_stage;
 
 	/* calculate the address width */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 16a2bcf5cfeb..36a91b1b52be 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -66,8 +66,6 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
-	domain_update_iotlb(dmar_domain);
-
 	return 0;
 unassign_tag:
 	cache_tag_unassign_domain(dmar_domain, dev, IOMMU_NO_PASID);
-- 
2.34.1


