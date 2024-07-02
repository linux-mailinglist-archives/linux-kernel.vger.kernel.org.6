Return-Path: <linux-kernel+bounces-237819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862EE923E80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AE4289133
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EBA1A2FDF;
	Tue,  2 Jul 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUFK4xF+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9071A2FBA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925894; cv=none; b=onfT48ngY2tphXXOZLuf4n0sUj92NHfP4F8c+0oBDnUCCEUbyYR+Szl3Y/LlDwGzlf9eaYkFyyO+CipHS1mFDTHwE5O0e+VYw9+rvFGV5ZW/MWFD72wURRY2L18J5OkQjrrEM5GcKD+2Qh6D0Mo8wcwTyqpEjVJh6Wa4UeH2WoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925894; c=relaxed/simple;
	bh=CPNrATy825FEHzfvGjy5SHzIN9+YwYaoDVHNJTLIPw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sr+q8RgtBLj17zWKlnluxK0GmmEctdbl5lVMDmE0Jww82c1id0HCKgjDnhio6PRFqcoEBgQb1Lq8EZ9bFhe9j3E0mu0DX2hE5Dm9G4MqC9952pbk8eU5MExJSdH61OWchzorKTf2S6WUYLXo9eToIK4OOUeO3rbHjhOSASpW3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUFK4xF+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925893; x=1751461893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPNrATy825FEHzfvGjy5SHzIN9+YwYaoDVHNJTLIPw4=;
  b=YUFK4xF+g+YtoYgyHAfOIzbBBIn3iZTx3d8Z63pCIWqu/9IIwvxbvxbl
   +9BreJCMsUpZlROiNRXJ3BibV5vKcxXm0uURocIbAy7EPBYHd3Ihcs2QG
   RDm3IHHIt4vTa1Y+13B7/jNPUT6Dtc2xgBZ5f4FJZRSPa7to5othurLu6
   mxydVAkt5Qd8FghB/UOvghzs0v6dlrkYkV45iBZrzdA1N2izRgeDsOauh
   qUsGccP5RrJxG4InimvDLAjXHtBbxTw4PzpS1MDoBjNmiw0dKnB6vRyQh
   XQyNrzdQlPdf/KfekRjSddnzm042cLC+/dWaonMU0yUtiPmsEYsyYBfIF
   w==;
X-CSE-ConnectionGUID: uOrCGD3sROSNSrLFQT99xA==
X-CSE-MsgGUID: lqJWf3gQRJKgx3Q+feTQqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700027"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:31 -0700
X-CSE-ConnectionGUID: a18cdenGTiS7mLRWcz78Tg==
X-CSE-MsgGUID: 6YIkVVFwRiC5+Hz3MvS1mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250850"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iommu/vt-d: Add helper to allocate paging domain
Date: Tue,  2 Jul 2024 21:08:37 +0800
Message-Id: <20240702130839.108139-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain_alloc_user operation is currently implemented by allocating a
paging domain using iommu_domain_alloc(). This is because it needs to fully
initialize the domain before return. Add a helper to do this to avoid using
iommu_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240610085555.88197-16-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 90 +++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1b5519dfa085..1f0d6892a0b6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3622,6 +3622,79 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
+static int iommu_superpage_capability(struct intel_iommu *iommu, bool first_stage)
+{
+	if (!intel_iommu_superpage)
+		return 0;
+
+	if (first_stage)
+		return cap_fl1gp_support(iommu->cap) ? 2 : 1;
+
+	return fls(cap_super_page_val(iommu->cap));
+}
+
+static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_stage)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *domain;
+	int addr_width;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&domain->devices);
+	INIT_LIST_HEAD(&domain->dev_pasids);
+	INIT_LIST_HEAD(&domain->cache_tags);
+	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->cache_lock);
+	xa_init(&domain->iommu_array);
+
+	domain->nid = dev_to_node(dev);
+	domain->has_iotlb_device = info->ats_enabled;
+	domain->use_first_level = first_stage;
+
+	/* calculate the address width */
+	addr_width = agaw_to_width(iommu->agaw);
+	if (addr_width > cap_mgaw(iommu->cap))
+		addr_width = cap_mgaw(iommu->cap);
+	domain->gaw = addr_width;
+	domain->agaw = iommu->agaw;
+	domain->max_addr = __DOMAIN_MAX_ADDR(addr_width);
+
+	/* iommu memory access coherency */
+	domain->iommu_coherency = iommu_paging_structure_coherency(iommu);
+
+	/* pagesize bitmap */
+	domain->domain.pgsize_bitmap = SZ_4K;
+	domain->iommu_superpage = iommu_superpage_capability(iommu, first_stage);
+	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
+
+	/*
+	 * IOVA aperture: First-level translation restricts the input-address
+	 * to a canonical address (i.e., address bits 63:N have the same value
+	 * as address bit [N-1], where N is 48-bits with 4-level paging and
+	 * 57-bits with 5-level paging). Hence, skip bit [N-1].
+	 */
+	domain->domain.geometry.force_aperture = true;
+	domain->domain.geometry.aperture_start = 0;
+	if (first_stage)
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
+	else
+		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
+
+	/* always allocate the top pgd */
+	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_KERNEL);
+	if (!domain->pgd) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
+
+	return domain;
+}
+
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
@@ -3684,15 +3757,14 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * domain_alloc_user op needs to fully initialize a domain before
-	 * return, so uses iommu_domain_alloc() here for simple.
-	 */
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
-
-	dmar_domain = to_dmar_domain(domain);
+	/* Do not use first stage for user domain translation. */
+	dmar_domain = paging_domain_alloc(dev, false);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+	domain = &dmar_domain->domain;
+	domain->type = IOMMU_DOMAIN_UNMANAGED;
+	domain->owner = &intel_iommu_ops;
+	domain->ops = intel_iommu_ops.default_domain_ops;
 
 	if (nested_parent) {
 		dmar_domain->nested_parent = true;
-- 
2.34.1


