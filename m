Return-Path: <linux-kernel+bounces-291478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FE95631B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E71C21354
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CE14A4F9;
	Mon, 19 Aug 2024 05:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IilTE1CA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF514BF8A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044910; cv=none; b=Fuakjrb88sRw2/DwkaGCCYBYkXzqqAlpCgu6xs983ZsgE+1FeowOsTNV0kMRM7h7zNn+hmj7DtinNbgPVaX97OkOPENN3F84nMdjj9+h7QBBwgLiILJh69mLecj65iNl+C8mSjEq+uFE8V7FrNbAmZkKDvNL7oxyr0W0g0NqxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044910; c=relaxed/simple;
	bh=1CA+mLrd/zB5BFX5juWvQpnwhN2yzJAGei4ZyjTn2yA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TRhlQGjUqiR3GI9BS+McVqvcGJXsakM0GYELSWQFfDbNeqJFCNcpiD3vQmK/DGfhP7l8P0ovepvKF1MEWTo5Iwtrsm/bAYHSiO/byLUnd+cQeoD2uTq9zwTEEHDXItK+yNsqSKPjNTOsvX+txQoWC3PgOpTLnTINZsJNXRJ7iAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IilTE1CA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724044909; x=1755580909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1CA+mLrd/zB5BFX5juWvQpnwhN2yzJAGei4ZyjTn2yA=;
  b=IilTE1CABgCZSKTvM4pmEGHQVmreRtrQs9QMUN7ZvPsVG+r8bv9R395I
   zD5Fz9GKLdL2+cXmJxFH1+WwyRd5dEvxXLcx5VCBbLKFiuKtOszAxyFCl
   eRx034tVFl/88SQJH2V6i24GJG42X0IBrvHcFnd8L1z/FKRfD843rSoAq
   9QNmCX8hd6wVsCb6i0UUI5diQKutSH8GjmhHB51zShzfzoR4LcnK8dDMI
   ZqrJIn57xIg+GVEaP31nItBOScioAQzp+LsHDDHB/4lo2KVxpe1N2LPIi
   O4Q/EfzXc5Kb28/UFHrbZdOmLqc35B+Qw39r55khsnk9b27zyleYZSl0c
   A==;
X-CSE-ConnectionGUID: 9TkrKZgHS/+erGbp86QjSg==
X-CSE-MsgGUID: FRmXCs/uThuM09Slee4uHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26022923"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="26022923"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:21:48 -0700
X-CSE-ConnectionGUID: STI6FQj+QwmfZ8ZdJWMLQQ==
X-CSE-MsgGUID: 8GMf9WVlRN+/ElDunzmiOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64641440"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 22:21:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Date: Mon, 19 Aug 2024 13:18:05 +0800
Message-Id: <20240819051805.116936-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
attached to the device and disabled when the device transitions to block
translation mode. This approach is inappropriate as PCI PASID is a device
feature independent of the type of the attached domain.

Enable PCI PASID during the IOMMU device probe and disables it during the
release path.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

Change log:
v2:
 - Move pasid enablement the last step in intel_iommu_probe_device().
 - Clear pasid enabled flags after pci_disable_pasid().

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..43ad1f551581 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-
-	/* The PCIe spec, in its wisdom, declares that the behaviour of
-	   the device if you enable PASID support after ATS support is
-	   undefined. So always enable PASID support on devices which
-	   have it, even if we can't yet know if we're ever going to
-	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
-		info->pasid_enabled = 1;
-
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 		info->ats_enabled = 0;
 		domain_update_iotlb(info->domain);
 	}
-
-	if (info->pasid_enabled) {
-		pci_disable_pasid(pdev);
-		info->pasid_enabled = 0;
-	}
 }
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
@@ -4112,6 +4098,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	intel_iommu_debugfs_create_dev(info);
 
+	/*
+	 * The PCIe spec, in its wisdom, declares that the behaviour of the
+	 * device is undefined if you enable PASID support after ATS support.
+	 * So always enable PASID support on devices which have it, even if
+	 * we can't yet know if we're ever going to use it.
+	 */
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+		info->pasid_enabled = 1;
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -4128,6 +4124,11 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	if (info->pasid_enabled) {
+		pci_disable_pasid(to_pci_dev(dev));
+		info->pasid_enabled = 0;
+	}
+
 	mutex_lock(&iommu->iopf_lock);
 	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
 		device_rbtree_remove(info);
-- 
2.34.1


