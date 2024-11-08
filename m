Return-Path: <linux-kernel+bounces-400905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A19C13E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244282841F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5C1E4AB;
	Fri,  8 Nov 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwfyJbzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89591199BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032103; cv=none; b=l3k0ym5cJZHwpjQgxW13BpEA/FWZuIdmCGc63fbfHZQwzBsfajy6Gzj6L8XqBE1UGAsqIDPpPyeat42XQG9iad0Fs7rh6Iu7MNpgCVFttTdccn/O0JZTDyz4MASZ+LC+Av2IJcPx6joZbzql1GWEUP7lGj2S2EDbt/hXyPi4ibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032103; c=relaxed/simple;
	bh=w+eyi5SDR+GEiDrCO9seIHx/z9DNYStl43G2IPYxsVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzFKAv3//dpZc+fB3AbF9p2zzbiYz2Ke3hGZmGmEHfXDYm/X7NYqfCjpyYpz0fWSKwjd84IPEIPyDocp5vL6cSXy2f6KdzRt/fKyyES3A+fJ5dtokPIPvwr6BpwAWmxFEbVfVoooQI+/xPYiy9wdRgHGCTyYIanoSrnRvwM3U4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwfyJbzk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032101; x=1762568101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+eyi5SDR+GEiDrCO9seIHx/z9DNYStl43G2IPYxsVg=;
  b=QwfyJbzk+/8avhB56A9LgDQ775++nmMw+yO1crJHuDHKwEcVMoq/v6kG
   xcmXemrFqTqAuXlCvoEBFN6xdo0/N/QmKU1KybPXX7Im3yQzwnanl2ZdO
   yirjGrSR2QeNnOgwtfr4Ki8EzJuahia1hoc68S9BWRDSNYKyJuavvBXle
   cABpHay5+muYEq5woKgVKuYKBHL8UWP+WlNoAyyTPBodPPDt3qUQxtZp4
   PxsIsyTf1oXOvYoMlLO4sudZxw7POxIzmD80kawH490Ltz/DtNV3CuxFC
   57hCcQyZP5LhKZDgD6PeBWE51CtM8INQ7OPTpbqUgwF8i8qK4v4OFPAcF
   Q==;
X-CSE-ConnectionGUID: SadK35k3QKCeulCvkH0xpQ==
X-CSE-MsgGUID: BPWgsj/ZS2aCQDx1xaP3Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007729"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:00 -0800
X-CSE-ConnectionGUID: ZVs0WjrcTcWn2v1kQ8TINw==
X-CSE-MsgGUID: 7ObZAuxrRQKG1ai+fT0d5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213720"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:14:58 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] iommu: Pass old domain to set_dev_pasid op
Date: Fri,  8 Nov 2024 10:13:52 +0800
Message-ID: <20241108021406.173972-2-baolu.lu@linux.intel.com>
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

To support domain replacement for pasid, the underlying iommu driver needs
to know the old domain hence be able to clean up the existing attachment.
It would be much convenient for iommu layer to pass down the old domain.
Otherwise, iommu drivers would need to track domain for pasids by
themselves, this would duplicate code among the iommu drivers. Or iommu
drivers would rely group->pasid_array to get domain, which may not always
the correct one.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-2-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/amd_iommu.h                   | 3 ++-
 drivers/iommu/amd/pasid.c                       | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 ++-
 drivers/iommu/intel/iommu.c                     | 6 ++++--
 drivers/iommu/intel/svm.c                       | 3 ++-
 drivers/iommu/iommu.c                           | 3 ++-
 include/linux/iommu.h                           | 2 +-
 8 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..b11b014fa82d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -52,7 +52,8 @@ struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid);
+			    struct device *dev, ioasid_t pasid,
+			    struct iommu_domain *old);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain);
 
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 0657b9373be5..d1dfc745f55e 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -100,7 +100,8 @@ static const struct mmu_notifier_ops sva_mn = {
 };
 
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
-			    struct device *dev, ioasid_t pasid)
+			    struct device *dev, ioasid_t pasid,
+			    struct iommu_domain *old)
 {
 	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom = to_pdomain(domain);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a7c36654dee5..645da7b69bed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -332,7 +332,8 @@ void arm_smmu_sva_notifier_synchronize(void)
 }
 
 static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				      struct device *dev, ioasid_t id,
+				      struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..1517fe2c356e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2856,7 +2856,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 }
 
 static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
-				      struct device *dev, ioasid_t id)
+				     struct device *dev, ioasid_t id,
+				     struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e2b3aa601191..2d1d208d5125 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4070,7 +4070,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid)
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4356,7 +4357,8 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 }
 
 static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
-					 struct device *dev, ioasid_t pasid)
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3cc43a958b4d..4a2bd65614ad 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -111,7 +111,8 @@ static const struct mmu_notifier_ops intel_mmuops = {
 };
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
+				   struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..f3f81c04b8fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3331,7 +3331,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
+		ret = domain->ops->set_dev_pasid(domain, device->dev,
+						 pasid, NULL);
 		if (ret)
 			goto err_revert;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..32dce80aa7fd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -642,7 +642,7 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid);
+			     ioasid_t pasid, struct iommu_domain *old);
 
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
-- 
2.43.0


