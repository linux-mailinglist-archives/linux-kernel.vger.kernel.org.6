Return-Path: <linux-kernel+bounces-207909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A307A901DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A061F257BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853D1369AA;
	Mon, 10 Jun 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+vJEdC9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A67BAFF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009991; cv=none; b=I7BbvRglkg4GCLdLLRepMEEfFCiKh1vKcXRqhLuQQflmWynvN0/UXJ+FJx6n6e4TAj6rtVhrSEVCUrAiIYW8jk8zQlyb5T+a8NZ1arG1/G/rmbhSmNDimjSl2psznlhWNifJ2B60GKmdU7IuhjO+CQF8ErG4cKGCl9T4/PLWbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009991; c=relaxed/simple;
	bh=2RzKLZKa9aMbeh8zX7gRXSDK8Hv/vXOsjqYlhYXqS5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pf2+1vBBnO7twqWf67J5gk6PKVY5KaZGLfMGgF6hqJXc6OkhzxYFK89ofoIyLlgMq09xV6QOus/1x/RL1F3qvB02tp/+6D+fLLJjeBuIMiayiVlE8N7oGdqqebf0JOZfEqyzzbeHUV3v1H2l6rKIHXGwKE+K/71NMYVp8uSYzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+vJEdC9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009990; x=1749545990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RzKLZKa9aMbeh8zX7gRXSDK8Hv/vXOsjqYlhYXqS5Y=;
  b=m+vJEdC9Iej41wk0zA+0I82K8ei1Y5Tf4vxWr3iPw4z3euj86Y/1n8ce
   W2t1zQ+morYxoWtfqwYtZE6gk6ppJg/E54lGKyM85XK0EPiCePwZ5FwgI
   CYWen3pRQOnOMtPJbZRQnAxTQXPu6VUsOROpCKHhrpn/iNT45mQqWgUXP
   d3nMa9c3w6p6Y3d87GYkGymOMtr986h3OvPaHQOuCusDMt8DMIoA8N+MU
   5xwR8XCSL3cPiz/g3sfqEPpDahEDB2/0Hang9VTGhIxX+pZ1po5HjS8Bq
   Ga9egzQ4OfC2tfpr01ia6lo2X31N/tQuj9OGEEJDWJ1xZpin8goXUW3A9
   g==;
X-CSE-ConnectionGUID: O/z7bgccT9CozMb1okql5Q==
X-CSE-MsgGUID: nJb3C9WwSp+B993c2u7jmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581971"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581971"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:59:49 -0700
X-CSE-ConnectionGUID: QxgTd28SQrGRjUA9euRVfg==
X-CSE-MsgGUID: gs8aoJhZQmubGCpSr1nBLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43433021"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:59:45 -0700
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
Subject: [PATCH v3 18/21] drm/rockchip: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:52 +0800
Message-Id: <20240610085555.88197-19-baolu.lu@linux.intel.com>
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

Commit <421be3ee36a4> ("drm/rockchip: Refactor IOMMU initialisation") has
refactored rockchip_drm_init_iommu() to pass a device that the domain is
allocated for. Replace iommu_domain_alloc() with
iommu_paging_domain_alloc() to retire the former.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab55d7132550..52126ffb9280 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -103,13 +103,17 @@ static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 	struct rockchip_drm_private *private = drm_dev->dev_private;
 	struct iommu_domain_geometry *geometry;
 	u64 start, end;
+	int ret;
 
 	if (IS_ERR_OR_NULL(private->iommu_dev))
 		return 0;
 
-	private->domain = iommu_domain_alloc(private->iommu_dev->bus);
-	if (!private->domain)
-		return -ENOMEM;
+	private->domain = iommu_paging_domain_alloc(private->iommu_dev);
+	if (IS_ERR(private->domain)) {
+		ret = PTR_ERR(private->domain);
+		private->domain = NULL;
+		return ret;
+	}
 
 	geometry = &private->domain->geometry;
 	start = geometry->aperture_start;
-- 
2.34.1


