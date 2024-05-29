Return-Path: <linux-kernel+bounces-193466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6438D2CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D31C24926
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2D16DED5;
	Wed, 29 May 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7NE/xLs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743116D4D6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960990; cv=none; b=YjTPVhBjMVIAZ7gvSD1AZyEmdiuA6eB3wXRvULm94Y8r/i45ytuVGwNn/9Y8XPHAPZfJ8vyPrm7nLiIW09KmIN/UgL3dd/R5RLOPQDrocq/C6KVPRPZx3MEdmCiko9VEl/JdZuhSCDFeGM7m6KO77nOxxY9i0/2J67GxrwNIRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960990; c=relaxed/simple;
	bh=5ePUNFSt1UVyBK/XkIEBW5JIdBwW2K6T9xjoabFYw84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kgy/1+OvWyWcBPwCqv51g0LMLSuPsC3xOcO1GTYpatXj5VVsCyvBLJRi8YVLeH83n/DwuF1hDK784tUHTZYi3upbHZ6D5ui3zxZtg6nPokvfVNf72yiTI1kKNXrJMkEviCeH+GGAsUJ+88IyAsw+w+WvjODIagqGD+i1pWy6i2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7NE/xLs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960989; x=1748496989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ePUNFSt1UVyBK/XkIEBW5JIdBwW2K6T9xjoabFYw84=;
  b=W7NE/xLsCxwvKNge2GQYuVBqoDqq3snFCbMtBtFSZqSDL05qAjqSr6So
   zR5jfBCMkUWs2Wq+P8C2Bls9OBMLvQGdH67z0uUno95Ggm644+VD9aLsj
   sQYwEBTROs3qZ+egGx+pnt8qPVC/kmfhA6SZmChgPj1JttNTOg8DP6pCE
   y4zB4kQ1NK/pjAN1rq1dWjnfp+280O9u0HhylLN16Dk2CPs136ODTSGkY
   9ww6bNJEy53AswhRPgbFt2z6P7Veis6apcObLjE5adw7yz2lKhZug0yV4
   10UOn9NilMBD4Q5b/P/tfYwDbhC/7KEWTiNzICt2dZfbXuyPqQe+VzzfX
   w==;
X-CSE-ConnectionGUID: N7FNK+P4QU+wgpICv643LQ==
X-CSE-MsgGUID: xJB+Qsh1RTaeAtvhuj0A2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569068"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569068"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:36:18 -0700
X-CSE-ConnectionGUID: bMLT6m7ZQya8CnSU5hJh7Q==
X-CSE-MsgGUID: X6Uf2wUXQVWNu0/eZhCs2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257765"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:36:12 -0700
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
Subject: [PATCH 16/20] iommu/vt-d: Add domain_alloc_paging support
Date: Wed, 29 May 2024 13:32:46 +0800
Message-Id: <20240529053250.91284-17-baolu.lu@linux.intel.com>
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

Move paging domain allocation code out from intel_iommu_domain_alloc().
The intel_iommu_domain_alloc()  is still remaining to allocate an identity
domain. However, it will soon disappear as we are about to convert the
identity domain to a global static one.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ccde5f5972e4..eb8e08699b80 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3708,35 +3708,8 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
-
-	switch (type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(type);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
-			return NULL;
-		}
-		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-			pr_err("Domain initialization failed\n");
-			domain_exit(dmar_domain);
-			return NULL;
-		}
-
-		domain = &dmar_domain->domain;
-		domain->geometry.aperture_start = 0;
-		domain->geometry.aperture_end   =
-				__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-		domain->geometry.force_aperture = true;
-
-		return domain;
-	case IOMMU_DOMAIN_IDENTITY:
+	if (type == IOMMU_DOMAIN_IDENTITY)
 		return &si_domain->domain;
-	default:
-		return NULL;
-	}
 
 	return NULL;
 }
@@ -3791,6 +3764,26 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return domain;
 }
 
+static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct dmar_domain *dmar_domain;
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+
+	/* Do not support the legacy iommu_domain_alloc() interface. */
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	info = dev_iommu_priv_get(dev);
+	iommu = info->iommu;
+	dmar_domain = paging_domain_alloc(dev,
+			sm_supported(iommu) && ecap_flts(iommu->ecap));
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+
+	return &dmar_domain->domain;
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4650,6 +4643,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.34.1


