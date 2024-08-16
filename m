Return-Path: <linux-kernel+bounces-289517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21E9546F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99D0286E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E89197A7B;
	Fri, 16 Aug 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We8WPEkP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D52562E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805607; cv=none; b=MwJddNgHKPev8kIS+LNKpuiphJTo3lFmZDjJ3I1ouHDnccdXBgbZBUAsx+rSUUjsRiPGKP7VBKEP/HToSUE4dSAE9HTes8U3sHDsSadgdOXit9qP27pmoXNDPNLFZJje/Ldi5YhcglyrWRrvqfKl/AuAO4FJyYEHiXRishCRXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805607; c=relaxed/simple;
	bh=LSNCR4l+CeZIKpb6+ufHNdaAsvUEkCZPMk5KTPVDSzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5NLyf3hMj5o6RE7ZzdOcxo/a3LIvBmyy3SmxleqYcgVNDJH8UX67Fdf9hIXiOmLCkRmKIL7LD83nDCjn3TFekU3IUe7G2XcGtK4YlEU2ypiYz+HoUZm8npm4eZEZpiwqLiBs2n7QJL1eUvJ2bRA4LnKI2vmJEq71UgZwdKkBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We8WPEkP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723805604; x=1755341604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LSNCR4l+CeZIKpb6+ufHNdaAsvUEkCZPMk5KTPVDSzY=;
  b=We8WPEkPosPAQ324NdWEYvugZMSYC4lI9BFUXZ6wkIz3KdiY8LITdt5t
   jf3yUpe2wlwcS3tehulkAooT+FvpbE3cuHBteJqMitS/VUXvD8xackq+S
   HMCGSv3j/qn3w4tKBMV39BE5/02qc+5ACNs09Cr40kE0CnMHw8nR9B+6Z
   PBI0L3ltPueKho9JTnY0JTgVSoAyBMui/uG4Mh7u3q4J7vk/tcPWHL8PN
   uBAd7y9oXYe6M+N71vnTENXDe5rpTF20aKAuTcW8ptK/ZpQVnPmwBA0s4
   wCqmF28F/nZqPf7DHjZcESXgyt3Ldm+TkB7+7k3RykwjxQYkIllQdkzAe
   g==;
X-CSE-ConnectionGUID: oX2HgfDaR8mpeksdNkpe9A==
X-CSE-MsgGUID: uNhf68HYTsCHpz6fory7Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="24999892"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="24999892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 03:53:24 -0700
X-CSE-ConnectionGUID: /f6FDArgTgeLj4kAyZ7nhQ==
X-CSE-MsgGUID: XvXTu4pwR5utD+K1L2RrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64046038"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 16 Aug 2024 03:53:21 -0700
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
Subject: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Date: Fri, 16 Aug 2024 18:49:45 +0800
Message-Id: <20240816104945.97160-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..5a8080c71b04 100644
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
@@ -4110,6 +4096,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
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
 	intel_iommu_debugfs_create_dev(info);
 
 	return &iommu->iommu;
@@ -4128,6 +4124,9 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	if (info->pasid_enabled)
+		pci_disable_pasid(to_pci_dev(dev));
+
 	mutex_lock(&iommu->iopf_lock);
 	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
 		device_rbtree_remove(info);
-- 
2.34.1


