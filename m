Return-Path: <linux-kernel+bounces-207910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48C901DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DE51C21EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600C7CF16;
	Mon, 10 Jun 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwWZ25QR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B17C09E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009998; cv=none; b=S+ItXFBxR0ALjt76hLOy5jr+ZKKBlnrTAuROEBbeVEf2KBL8HRbD6CoWkNc9+nMIXiIC6cvZx8Xc3sFsmt5IqIMTBnQAVoI8OBTDj9C45cvjuX/ht5vsjdIioCKyXOLt8EF75pK4uQ1RaCQfkNww/SvAnTCZlhGG6QF5a5tO1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009998; c=relaxed/simple;
	bh=I56l8aUrWEsOdJKWYfI6TJlpnl4t+tX3NQmfYGnyV7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeDWnhf1pujv5Dvy8rjWBUFUWOVxQz+sv7i2j2dCk62jsQIIJq+GCkpXGrhVnjIQl795DKLklBbbK+jAbEj/977+c/V1TH9xyMi/zeIycqdLCAJNDR+x63ODJIcGQ9incBVanUO05q3iUG6n8T0g9UV2sX+M496apoFAhXV+Apo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwWZ25QR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009997; x=1749545997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I56l8aUrWEsOdJKWYfI6TJlpnl4t+tX3NQmfYGnyV7M=;
  b=GwWZ25QRKt38SZPrBw59wJMufvbOz2Wu90Bh+6iPI/li6jb6f+/K6ZHp
   lnQwn7dhazxM+ieIkO/TkYEegRvlG4uvGiCIOxUzD8IJuxzxy4skF5flD
   Ok50pwaSetJvrv3uQApPrFXx3ls5VXL3Ie8I+LyLQjSuEiP5woD+F8SB3
   LMMhP7hplCN+l65AoAhVdBBZysf57Qu4tbcdVxN28GtQKTi2nyePUr5iV
   VPoqmKX/vNKp7zceUyuS4PcmM5Xu1wmlmmyV4tYlEF51+U8s9F+LHA6vR
   vblB5soDUY9KVRhpXUcxUKfLrEuhmDAx5NWRuW4BNPxEV79MynMW91ykB
   w==;
X-CSE-ConnectionGUID: bH587zMWQNOziq7gB7Gpiw==
X-CSE-MsgGUID: NMKR1Ws3TWCa+GVUi+x1YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581990"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:56 -0700
X-CSE-ConnectionGUID: dSiXcWhERE2aZC+rbkMwCw==
X-CSE-MsgGUID: zTw8PCNRSvSb9YRaNVvOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43433094"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:50 -0700
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 19/21] drm/tegra: Remove call to iommu_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:53 +0800
Message-Id: <20240610085555.88197-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
the bus structure. The iommu subsystem no longer relies on bus for
operations. So iommu_domain_alloc() interface is no longer relevant.

Normally, iommu_paging_domain_alloc() could be a replacement for
iommu_domain_alloc() if the caller has the right device for IOMMU API
use. Unfortunately, this is not the case for this driver.

Iterate the devices on the platform bus and find a suitable device
whose device DMA is translated by an IOMMU. Then use this device to
allocate an iommu domain. The iommu subsystem prevents domains
allocated by one iommu driver from being attached to devices managed
by any different iommu driver.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/tegra/drm.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 03d1c76aec2d..ee391f859992 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1133,6 +1133,17 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
 	return domain != NULL;
 }
 
+static int iommu_mapped_device(struct device *dev, void *data)
+{
+	struct device **iommu_dev = data;
+
+	if (!device_iommu_mapped(dev))
+		return 0;
+
+	*iommu_dev = dev;
+	return 1;
+}
+
 static int host1x_drm_probe(struct host1x_device *dev)
 {
 	struct tegra_drm *tegra;
@@ -1149,16 +1160,21 @@ static int host1x_drm_probe(struct host1x_device *dev)
 		goto put;
 	}
 
-	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
-		tegra->domain = iommu_domain_alloc(&platform_bus_type);
-		if (!tegra->domain) {
-			err = -ENOMEM;
-			goto free;
+	if (host1x_drm_wants_iommu(dev)) {
+		struct device *iommu_dev = NULL;
+
+		bus_for_each_dev(&platform_bus_type, NULL, &iommu_dev, iommu_mapped_device);
+		if (iommu_dev) {
+			tegra->domain = iommu_paging_domain_alloc(iommu_dev);
+			if (IS_ERR(tegra->domain)) {
+				err = PTR_ERR(tegra->domain);
+				goto free;
+			}
+
+			err = iova_cache_get();
+			if (err < 0)
+				goto domain;
 		}
-
-		err = iova_cache_get();
-		if (err < 0)
-			goto domain;
 	}
 
 	mutex_init(&tegra->clients_lock);
-- 
2.34.1


