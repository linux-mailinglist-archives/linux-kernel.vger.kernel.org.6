Return-Path: <linux-kernel+bounces-193455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543E8D2C94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137ADB25582
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE601167282;
	Wed, 29 May 2024 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqiw3jwQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E015FCE6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960976; cv=none; b=ZEVMezhmVLVqyClx/FF3w/xn1YPKL5+Vql6/AqvhuBJ4A1pCVB7rlAUMvU0cTo0KsLtkt2ejwF510d2IrhJG5x8lqoGDpx17sotDGH3em4+lybpEpfhxYmfL3dodddkQ8Kbv0yRGVilO4TwxhNbI+1svsD/NEJxYrQGT47ZK/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960976; c=relaxed/simple;
	bh=btq9QncSBgyBYPM+1ZLAyc+X7006n3UNtW5/Bz7GLZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeUXdY6i9FlUpLV8jCB+2eJyQp76Wj1e8+kzjqJ1zx25GxPt0IpvrpzS/BVCkDetZOFQxqdixuyTpGMmUERodTeHXNF++uwUuzrS9MT82oZmDZUj7M0bWwRDF4qxgZ2Jbt/WKbLD3N28dP1hWgz/1i0nuSJVJjd8LPWVsaIR7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqiw3jwQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960975; x=1748496975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btq9QncSBgyBYPM+1ZLAyc+X7006n3UNtW5/Bz7GLZE=;
  b=lqiw3jwQc2SVq6O8cP5eBHlAXTvF8fgsmMPHNDDKg4UhX5OZscVXiLzP
   4CUd1VOQJyS2AgHoyeO5UArCs6uFKz06RTg7qRIkNVoPNV4KBXOONry3f
   VQdxevMmIqG30TozSP74JZXgx2POGkIvoMVJEJscyWiVJQCicm+ukSoiP
   Nq4IKV275BXvsmr0SwELFk2aUC5NS13ztmgbRmXghhxufG0vrTxCaacCa
   dpUmKjMZa78OjTARHx0Ln4gpPR6aQogra0tunMlPKGQ+VUvm83NrF8ih+
   wxGLHyByNDI/mJtylceqr3Vj0MgntuLlK8ScWkRlnam6GyqfozzX+UlBz
   g==;
X-CSE-ConnectionGUID: BrTwlDWvRqKFVeLAloCbTg==
X-CSE-MsgGUID: /9oCaxyhSeudc856ZhkoDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568851"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568851"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:30 -0700
X-CSE-ConnectionGUID: PJuAP/85SO2v/dKzt8Un2A==
X-CSE-MsgGUID: fVOd5tHsThGjTLV7SoVvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257574"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:25 -0700
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
Subject: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:36 +0800
Message-Id: <20240529053250.91284-7-baolu.lu@linux.intel.com>
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

The domain allocated in msm_iommu_new() is for the @dev. Replace
iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.

Update msm_iommu_new() to always return ERR_PTR in failure cases instead
of NULL.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index d5512037c38b..f7e28d4b5f62 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	struct msm_iommu *iommu;
 	int ret;
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		return NULL;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
 	iommu_set_pgtable_quirks(domain, quirks);
 
@@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 	struct msm_mmu *mmu;
 
 	mmu = msm_iommu_new(dev, quirks);
-	if (IS_ERR_OR_NULL(mmu))
+	if (IS_ERR(mmu))
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
-- 
2.34.1


