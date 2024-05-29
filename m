Return-Path: <linux-kernel+bounces-193462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA828D2C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39AA1F2643B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4200169AD4;
	Wed, 29 May 2024 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtQRuAwV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BD169361
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960983; cv=none; b=Bz1Sgt7vv5TWLfxUfKkRPnMMaE0JirwxEYFFQHq2i3RzACxzl/LGecvzYtyYOOVA0TvhV0oo+SnyTCK7BykSWAdxpJC3sLeQc7aE8rG3HC0qGJbPG+xJQVJFpR0W3C4NqOqCgs+b/82FRthvn5yUGUcEUg9Z4ts6EAvSYGTrCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960983; c=relaxed/simple;
	bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCoN4wbOc1twV5RTOL5l0ktpbqiJBxxAcEf+eR0vn7ffcyHJ4WoIPJ7W18+IfDti4XOqXHmhp31Yp4/nRTfkdZCHR0Lp75365T94j2ge5G88VGqoEn3hVk9GgOK57QT2pVhb+AvD7TRSv9Ny9GHd+8xB2K/Ke9U84Mg8gBfpGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtQRuAwV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960982; x=1748496982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
  b=MtQRuAwVDwjaHlFy08UV2efRhFgL668SHjzjjOQ6h6LwkSe98pVEn+Pm
   7Ccpv86MFUxka+FjC2IrhSQjTjqXY5KmhKLAt/lX53XNvEPZ/bFPuRXeF
   t5iCibF8Z+S2S//9GYL1dWLPwKP3faQnkh4u+OBJ+YiSP506pyB+fVL+O
   dnWiTwDFw8f29zziTo06+9PBi9lrVc2nnJ/t8OigYR73E+1FXz7ZPZk5S
   fP/jy6pq3fCO8fjNmrv2H/tlN68J8ZMPMJyluymCDyi4CHksK+bYRZDua
   gkVYnVYVRx5YJaiINQjE7nfSUJ1ZfrxS4mj11hZvrrcS7ScA63JeGFfmP
   w==;
X-CSE-ConnectionGUID: ia63W5EGT56wWlHk+88+AQ==
X-CSE-MsgGUID: d8kRWINnSd+aDbBwXzIDHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569008"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:58 -0700
X-CSE-ConnectionGUID: V3zZjpVoRS2Q2WQoWQMxtQ==
X-CSE-MsgGUID: 5T9hg/jYScSPheKhITTpNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257707"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:53 -0700
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
Subject: [PATCH 12/20] wifi: ath11k: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:42 +0800
Message-Id: <20240529053250.91284-13-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
attached to ab_ahb->fw.dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index ca0f17ddebba..a469647719f9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1001,10 +1001,10 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 
 	ab_ahb->fw.dev = &pdev->dev;
 
-	iommu_dom = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu_dom) {
+	iommu_dom = iommu_paging_domain_alloc(ab_ahb->fw.dev);
+	if (IS_ERR(iommu_dom)) {
 		ath11k_err(ab, "failed to allocate iommu domain\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(iommu_dom);
 		goto err_unregister;
 	}
 
-- 
2.34.1


