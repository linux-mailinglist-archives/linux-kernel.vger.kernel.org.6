Return-Path: <linux-kernel+bounces-400915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122C9C13F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181681F2414D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D1194AEB;
	Fri,  8 Nov 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maqGcqzA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C3192D98
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032129; cv=none; b=k+sUlG3q4uBJbH/wHwrHVz9vWFT+RrTg1DGagzNghtPe8nKRpo2RD+T6G/isdFqnMRW1QIRSUtZl1YqUBA/jRwP0va1xKQ1Ci9OaoALNOpbT4kiy18b5elHoq9Ra1VWZUOlYUd8Gg1LyCvZp8+FOFreux3EUjAHg7QUw2JLc/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032129; c=relaxed/simple;
	bh=bzOyekv0clUGynmdW7dlvJLFDi2gKYykZx0AhaRfTPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPb6IhC+dpWWl4Ptt46lxPEM4mqmbUf5LdYOW1ggI6nmXuEd+FKEGRT6ShmszHJr85pjhzd3WQ/MkDGMTheV/zsm5IQnH/IC8mEjhsvt5FMseTH9YmkzNi8wOUJmsqYJI/cgLACWTAb5iUpIiyt0AwaHd9bleNImHtY2yXoWp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maqGcqzA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032128; x=1762568128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzOyekv0clUGynmdW7dlvJLFDi2gKYykZx0AhaRfTPk=;
  b=maqGcqzAm/6uVCCE/+NP4x/RFHEcve1+2ANV0FZViJfVZAGJ0kVrgUq1
   IBfQENwKykTC3tdf25Rs8pyXzcEjsBRPPiaOWtGJXMTfrQWuwJc+M6T6c
   hBjaKAs4c5oG5ST0arQZx/wHUxzoeXMO0ldK9Zg1HAHf9x4USQ28Ylw9F
   fMlh41Dad4DzCEunV3+x90tnBTGeMJaWmeVsaQ/WwVreU2Vt8bkwgD58z
   lQbGIFPEJhWAe6dQPNnUJ42jDm9F01pFUsviyWdQ0WGzNYH8whW6Y3Bbk
   CEBQrhlIozNgeVG0ATFhaartJehnYwVVLoQp3HE/YfOmpF8huAemgOioi
   w==;
X-CSE-ConnectionGUID: 91JO/iSrTuGKIz5z9aCWHw==
X-CSE-MsgGUID: tAz2bxavR+Wtng70MOrG8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007855"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007855"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:20 -0800
X-CSE-ConnectionGUID: 9cKA4ULqSLy7b0vvOVwdTg==
X-CSE-MsgGUID: crUOT37tSMOSb/dVl35N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213840"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Fri,  8 Nov 2024 10:14:02 +0800
Message-ID: <20241108021406.173972-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Add intel_nested_set_dev_pasid() to set a nested type domain to a PASID
of a device.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-12-yi.l.liu@intel.com
---
 drivers/iommu/intel/iommu.c  |  6 -----
 drivers/iommu/intel/iommu.h  |  7 +++++
 drivers/iommu/intel/nested.c | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ba984cb4aa44..b380b38315b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1812,12 +1812,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  (pgd_t *)pgd, flags, old);
 }
 
-static bool dev_is_real_dma_subdevice(struct device *dev)
-{
-	return dev && dev_is_pci(dev) &&
-	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d23977cc7d90..2cca094c259d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
+#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -832,6 +833,12 @@ iommu_domain_did(struct iommu_domain *domain, struct intel_iommu *iommu)
 	return domain_id_iommu(to_dmar_domain(domain), iommu);
 }
 
+static inline bool dev_is_real_dma_subdevice(struct device *dev)
+{
+	return dev && dev_is_pci(dev) &&
+	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
+}
+
 /*
  * 0: readable
  * 1: writable
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 989ca5cc04eb..42c4533a6ea2 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -130,8 +130,58 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static int domain_setup_nested(struct intel_iommu *iommu,
+			       struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_nested(iommu, dev, pasid, domain);
+	return intel_pasid_replace_nested(iommu, dev, pasid,
+					  iommu_domain_did(old, iommu),
+					  domain);
+}
+
+static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_domain *old)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
+
+	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
+	if (ret)
+		goto out_remove_dev_pasid;
+
+	domain_remove_dev_pasid(old, dev, pasid);
+
+	return 0;
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_nested_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.43.0


