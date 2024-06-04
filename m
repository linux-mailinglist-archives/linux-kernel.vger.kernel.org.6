Return-Path: <linux-kernel+bounces-199921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82B8FA7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D881C23C66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1B13E3F3;
	Tue,  4 Jun 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MT+2+YF4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E413D60F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466055; cv=none; b=NvmsWbE/uKBAgmgTDTaTA8JiJDMu+em6DLlmaucifW/cMEdTCvF1DJcMfLfPDqhEZ9yyCpoY4r/jd1P862+171itjJ3mWU7ZEKaMSQTEOAsm+hXfcvsQ8gs/AxsPKGLjqzqAc6P8PYVLhqIW++S4GRBqxj13jUtk2uqkO7PygWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466055; c=relaxed/simple;
	bh=Ixvg9rthHQ++gOUcIGxznMoJ6JJhVf/NaGpaKm7M1Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgTIRiZxgZCvtZsFcLgbYrn8D2IeIu5SZ7nIya2u6R2GCPGOT3Tsm28sPBRRi/e+CyJ+70RHUS1W2Uv9fkyCFWfY7Ykjawx8jzoDIEEkgz/iV1Us1jIyicP5zI2Q5taZQtBSmY9iNEaC5TFIxY+dKixuGJTQ9GuKn5Pv+Wa/FJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MT+2+YF4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466054; x=1749002054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ixvg9rthHQ++gOUcIGxznMoJ6JJhVf/NaGpaKm7M1Do=;
  b=MT+2+YF4SMqVj6Sy/ez9WCNzn3AlfeCLNbowDOFZ8J23qhkwsR5OZQ48
   NxnIsQTwKeFyD2SqcQ59uitu3D7tO96+oUuF+ONSSIWOaKybE9ycbz2Yy
   2FRAhPQTpJcgC6zSV6FNwewdausXJzBWHqLkmeiAu7YdjADDwAQkOYVwg
   gcxtGwoaZ61BHtD98Z3sVND16qz2LE5tkROwIo0IcJH3kPP7dDBkR61Mq
   JKtXZx/Nir7YCGvB1yNuoU//23naCa/wRJGJgI9o7jrvYk+h3v1jvMhjP
   YmHDCAajG9whKeXw2op2QRMyPL+qbafJTLySYvCXGcq2mhcXPcGCV5p+s
   A==;
X-CSE-ConnectionGUID: YRtrSYPSQZmXhMwecD2adw==
X-CSE-MsgGUID: 2h0wEOF5RzCbGqDRieuRIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384900"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:14 -0700
X-CSE-ConnectionGUID: KgtWwSTbSBOJFgVEw2AV7w==
X-CSE-MsgGUID: 8LxxIA6KQxawSj81m3DOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661817"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:10 -0700
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
Subject: [PATCH v2 04/22] vhost-vdpa: Use iommu_user_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:16 +0800
Message-Id: <20240604015134.164206-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace iommu_domain_alloc() with iommu_user_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vhost/vdpa.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..d15673cb05f2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1312,26 +1312,24 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
-	const struct bus_type *bus;
 	int ret;
 
 	/* Device want to do DMA by itself */
 	if (ops->set_map || ops->dma_map)
 		return 0;
 
-	bus = dma_dev->bus;
-	if (!bus)
-		return -EFAULT;
-
 	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		dev_warn_once(&v->dev,
 			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
 		return -ENOTSUPP;
 	}
 
-	v->domain = iommu_domain_alloc(bus);
-	if (!v->domain)
-		return -EIO;
+	v->domain = iommu_user_domain_alloc(dma_dev, 0);
+	if (IS_ERR(v->domain)) {
+		ret = PTR_ERR(v->domain);
+		v->domain = NULL;
+		return ret;
+	}
 
 	ret = iommu_attach_device(v->domain, dma_dev);
 	if (ret)
-- 
2.34.1


