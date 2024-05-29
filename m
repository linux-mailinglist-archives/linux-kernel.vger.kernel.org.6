Return-Path: <linux-kernel+bounces-193465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E628D2CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D876B2652F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16616D338;
	Wed, 29 May 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPb1tEpP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BF16A36D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960988; cv=none; b=nZ/lz/ks2W2JvNjjSb3r6/g5qXYx+LSayojnvdwjIWF0nL3yzwsJNOEIDLbY6h9ohbkPW4WN7UBQBuN2g3TqRh9CQ9D82r85T9KXgZQzp9AFGaoOccDrfptYzo+oyg1Tu8hKJW9rKHPByiikf+cFdU9qkwxfMiaIn9FbUmnAFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960988; c=relaxed/simple;
	bh=kAf7SPBLso5zp49wUYubqs0YKzd/lC+tt+i0+MOxu64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jd86ZU6mlXlpTkXmqTm2M8hXaoNmLLSXtvRmNjbNr8NiX/JZIzSPZn5mlJ1bmvUbIOkG5KQZNkz5Mr6QWRAF76B3lWNS4YdDsR8XsYXFPHqLioBPBCy5HwfoMLEOR4imMA2FVQvlIbVk9Gh7ZAYehrf1pphzwFOFgP1VdIDd8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPb1tEpP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960987; x=1748496987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAf7SPBLso5zp49wUYubqs0YKzd/lC+tt+i0+MOxu64=;
  b=cPb1tEpPZcXN2opL0krE7oHdFJVjBHYvf8Opyhfe2vta2Dlz5K6w87az
   wLnSIC/o2IwU4bU1qCl4K0ACweiOOjuhvnz/D6I256lJkQ0OMIBER0M9M
   EyzpsLCycwjqORZntf3YMkHDEWlzcGeGv4L2u5yZ7uswENy/4UkHjztfQ
   S/jDOHPo/+5uP7pGwbiP5IpSujhUqmSiaNE+9uvujc0MywSkykEdLqZTR
   n6UjRqWtLsHoBQMuloLhLs1hl0/gP9Yqxs5qlqLTmUDHDkttlFf3Or1Md
   h/LYqasIL8nZNJj2vfyWyOc5qManwLmJxt85HPr8jbvLuJBI2U4oAwNoB
   w==;
X-CSE-ConnectionGUID: mJDRITGyQi2GWrdD2WVXSg==
X-CSE-MsgGUID: NBnqpYlhQvOAkwYbWABSFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569053"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569053"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:36:12 -0700
X-CSE-ConnectionGUID: cCZToLUCTQGJ9JPHPmk0WA==
X-CSE-MsgGUID: 3EA9i3ihQEyIhlN5IVrqow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257754"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:36:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 15/20] iommu/vt-d: Add helper to allocate paging domain
Date: Wed, 29 May 2024 13:32:45 +0800
Message-Id: <20240529053250.91284-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 87 +++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..ccde5f5972e4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3633,6 +3633,79 @@ static struct iommu_domain blocking_domain = {
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
@@ -3695,15 +3768,11 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
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
 
 	if (nested_parent) {
 		dmar_domain->nested_parent = true;
-- 
2.34.1


