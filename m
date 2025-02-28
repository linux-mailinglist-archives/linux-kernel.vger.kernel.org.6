Return-Path: <linux-kernel+bounces-538134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF07A494EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D8E3B4676
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543E25A33F;
	Fri, 28 Feb 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVu1+Hyp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9625A2C5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734799; cv=none; b=CT/7kgBLkGts9mJllJdsJKM56INniw5JSJy8uGQGr66MfgIP2ivrILhdff0f31HHvCeHC0iv0/P2X2Yg5AYDH+TyshBgMiZrr1IbuLjlQf2F3vHEYsbHl7SlkqWuAecrAMJ80PAvizxsQ3ACLvvEbF3dHX+CLyzMVIxjR6KCJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734799; c=relaxed/simple;
	bh=pQCEoGBncSLlXRXT6R9po8QIsdRtJnfH8c8ZNRKeTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j31utIewSm9fcpklOnmm+uh1gzruoMLs+1zBZNOw1SSkzgWSdIM+DQlnhz9in91nQxRg1hR3TGLHlPeFiyb9XkfMzUd6OHYNmNEmVTGoboC5n4533yG2Zt4MwT+vpkfuyP0O9sXIOs5cyJesxdt7E7uwWvHjwocffsPyZXHepJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVu1+Hyp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734798; x=1772270798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQCEoGBncSLlXRXT6R9po8QIsdRtJnfH8c8ZNRKeTik=;
  b=aVu1+Hyp0N19UbbKVaM9nP32YCLZRcstyYFDkqoPw0YcuYls4ffkqSHH
   055H+KyWxPeTvnUG39g0itKhLU56a3s/l1tYaY/VVxey9GiNKJGkA/iu5
   p0FgI//ygE85BT+c5hsSpYisfF0f69h+rVF/Z8D5lJ+G8/hre8SF+R7uM
   cf/k879jm88joJDXsurf4/scTdBhpam5zmRkQLiAw6tviZ59MQ7RpuRzG
   Btw5dIdD4GNKrFY7l3/5QB5kKQ/fDf9Dav5e8aD7DLlH2o9S8a/rbfTSY
   gHsfZeMb6sFEiRvVcRbci5BUw9PHNKUnl6Jl2HN3sQTfVG92v+f4YX5Qt
   w==;
X-CSE-ConnectionGUID: wqxrB5+cSQi+t06ZHgshiw==
X-CSE-MsgGUID: C3HvDGrxQTG/CSAWYmZGPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438341"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438341"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:38 -0800
X-CSE-ConnectionGUID: /nUBoTIuRFSYvZ63ahn7xQ==
X-CSE-MsgGUID: h8qvJFXZTzW1Ym9r4vxQAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148212977"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:34 -0800
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
Subject: [PATCH v3 05/12] iommu/vt-d: Move PRI enablement in probe path
Date: Fri, 28 Feb 2025 17:26:24 +0800
Message-ID: <20250228092631.3425464-6-baolu.lu@linux.intel.com>
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

Update PRI enablement to use the new method, similar to the amd iommu
driver. Enable PRI in the device probe path and disable it when the device
is released. PRI is enabled throughout the device's iommu lifecycle. The
infrastructure for the iommu subsystem to handle iopf requests is created
during iopf enablement and released during iopf disablement.  All invalid
page requests from the device are automatically handled by the iommu
subsystem if iopf is not enabled. Add iopf_refcount to track the iopf
enablement.

Convert the return type of intel_iommu_disable_iopf() to void, as there
is no way to handle a failure when disabling this feature.  Make
intel_iommu_enable/disable_iopf() helpers global, as they will be used
beyond the current file in the subsequent patch.

The iopf_refcount is not protected by any lock. This is acceptable, as
there is no concurrent access to it in the current code. The following
patch will address this by moving it to the domain attach/detach paths,
which are protected by the iommu group mutex.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/intel/iommu.c | 137 +++++++++++++-----------------------
 drivers/iommu/intel/iommu.h |   4 ++
 drivers/iommu/intel/pasid.c |   2 +
 drivers/iommu/intel/prq.c   |   2 +-
 4 files changed, 55 insertions(+), 90 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7efb32a0ac96..35acb6438ea4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1196,6 +1196,37 @@ static void iommu_disable_pci_ats(struct device_domain_info *info)
 	info->ats_enabled = 0;
 }
 
+static void iommu_enable_pci_pri(struct device_domain_info *info)
+{
+	struct pci_dev *pdev;
+
+	if (!info->ats_enabled || !info->pri_supported)
+		return;
+
+	pdev = to_pci_dev(info->dev);
+	/* PASID is required in PRG Response Message. */
+	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
+		return;
+
+	if (pci_reset_pri(pdev))
+		return;
+
+	if (!pci_enable_pri(pdev, PRQ_DEPTH))
+		info->pri_enabled = 1;
+}
+
+static void iommu_disable_pci_pri(struct device_domain_info *info)
+{
+	if (!info->pri_enabled)
+		return;
+
+	if (WARN_ON(info->iopf_refcount))
+		iopf_queue_remove_device(info->iommu->iopf_queue, info->dev);
+
+	pci_disable_pri(to_pci_dev(info->dev));
+	info->pri_enabled = 0;
+}
+
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -3752,6 +3783,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	if (sm_supported(iommu))
 		iommu_enable_pci_ats(info);
+	iommu_enable_pci_pri(info);
 
 	return &iommu->iommu;
 free_table:
@@ -3769,6 +3801,7 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	iommu_disable_pci_pri(info);
 	iommu_disable_pci_ats(info);
 
 	if (info->pasid_enabled) {
@@ -3857,116 +3890,41 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-static int context_flip_pri(struct device_domain_info *info, bool enable)
+int intel_iommu_enable_iopf(struct device *dev)
 {
-	struct intel_iommu *iommu = info->iommu;
-	u8 bus = info->bus, devfn = info->devfn;
-	struct context_entry *context;
-	u16 did;
-
-	spin_lock(&iommu->lock);
-	if (context_copied(iommu, bus, devfn)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	context = iommu_context_addr(iommu, bus, devfn, false);
-	if (!context || !context_present(context)) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-	did = context_domain_id(context);
-
-	if (enable)
-		context_set_sm_pre(context);
-	else
-		context_clear_sm_pre(context);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(context, sizeof(*context));
-	intel_context_flush_present(info, context, did, true);
-	spin_unlock(&iommu->lock);
-
-	return 0;
-}
-
-static int intel_iommu_enable_iopf(struct device *dev)
-{
-	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
-	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
+	if (!info->pri_enabled)
 		return -ENODEV;
 
-	if (info->pri_enabled)
-		return -EBUSY;
-
-	iommu = info->iommu;
-	if (!iommu)
-		return -EINVAL;
-
-	/* PASID is required in PRG Response Message. */
-	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
-		return -EINVAL;
-
-	ret = pci_reset_pri(pdev);
-	if (ret)
-		return ret;
+	if (info->iopf_refcount) {
+		info->iopf_refcount++;
+		return 0;
+	}
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
 
-	ret = context_flip_pri(info, true);
-	if (ret)
-		goto err_remove_device;
-
-	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret)
-		goto err_clear_pri;
-
-	info->pri_enabled = 1;
+	info->iopf_refcount = 1;
 
 	return 0;
-err_clear_pri:
-	context_flip_pri(info, false);
-err_remove_device:
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	return ret;
 }
 
-static int intel_iommu_disable_iopf(struct device *dev)
+void intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
-	if (!info->pri_enabled)
-		return -EINVAL;
+	if (WARN_ON(!info->pri_enabled || !info->iopf_refcount))
+		return;
 
-	/* Disable new PRI reception: */
-	context_flip_pri(info, false);
+	if (--info->iopf_refcount)
+		return;
 
-	/*
-	 * Remove device from fault queue and acknowledge all outstanding
-	 * PRQs to the device:
-	 */
 	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	/*
-	 * PCIe spec states that by clearing PRI enable bit, the Page
-	 * Request Interface will not issue new page requests, but has
-	 * outstanding page requests that have been transmitted or are
-	 * queued for transmission. This is supposed to be called after
-	 * the device driver has stopped DMA, all PASIDs have been
-	 * unbound and the outstanding PRQs have been drained.
-	 */
-	pci_disable_pri(to_pci_dev(dev));
-	info->pri_enabled = 0;
-
-	return 0;
 }
 
 static int
@@ -3986,7 +3944,8 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
-		return intel_iommu_disable_iopf(dev);
+		intel_iommu_disable_iopf(dev);
+		return 0;
 
 	default:
 		return -ENODEV;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6ea7bbe26b19..f7d78cf0778c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -774,6 +774,7 @@ struct device_domain_info {
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
 	u8 ats_qdep;
+	unsigned int iopf_refcount;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
@@ -1314,6 +1315,9 @@ void intel_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			       struct iommu_page_response *msg);
 void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid);
 
+int intel_iommu_enable_iopf(struct device *dev);
+void intel_iommu_disable_iopf(struct device *dev);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb59a7d35958..c2742e256552 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -992,6 +992,8 @@ static int context_entry_set_pasid_table(struct context_entry *context,
 		context_set_sm_dte(context);
 	if (info->pasid_supported)
 		context_set_pasid(context);
+	if (info->pri_supported)
+		context_set_sm_pre(context);
 
 	context_set_fault_enable(context);
 	context_set_present(context);
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 064194399b38..5b6a64d96850 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -67,7 +67,7 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	u16 sid, did;
 
 	info = dev_iommu_priv_get(dev);
-	if (!info->pri_enabled)
+	if (!info->iopf_refcount)
 		return;
 
 	iommu = info->iommu;
-- 
2.43.0


