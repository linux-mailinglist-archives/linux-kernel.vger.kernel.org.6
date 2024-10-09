Return-Path: <linux-kernel+bounces-356247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F1995E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B601C20D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E26156242;
	Wed,  9 Oct 2024 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCS0km45"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE1150997
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447408; cv=none; b=XuqTkwTH5Xg8jHBXkJMh72w6yVG+djIQX8ck9Bz+y4c37S6nMWkujbCfFtpwU6Fj7ojra8X8aDcnNScjJI6tNh/BAOnrJ35//aqYv+nk6Muz3JLOujX8/y+S/Lu3+hHfor3Vl4bqp+QDL4NYy5/ca7kA7rgiDEd3K71e7vJzlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447408; c=relaxed/simple;
	bh=FNZtLfJ5rXbaDZePK51gpgINvo8ZfmFIhkL4SyhfFH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHQATjcC7EAOERUnM5ZL9HJwpg691IaJ+f2TApx7WtKZy+OqDbtq4WkVS7AqQz+5nCo1gV+T82Iw2by+de2viKKUFoOpY4XeA3Lhk6Wci+hrInJ1kjKGcjUGRKs71en/HBn4prkB/RViMmH95Ym+CHa4NQ95htekXv7TA1r/pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCS0km45; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447407; x=1759983407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNZtLfJ5rXbaDZePK51gpgINvo8ZfmFIhkL4SyhfFH8=;
  b=cCS0km45F5nBYyZjWgNtM4+jwKP9S7LNvmVjrtCrKJ5aio/gm6vwGp0Y
   OZs7k7BM7yEVhkQ+2GB3rcDmTLihjt8v4M0MHEr3/glV9XMeGHWAB9LaC
   MRNvavSugChxmoPOGY9RjgTXETvprzHzFjbI67VEaKpXZMyUp54Tr/zFs
   IcRlMLK5QBcm24Xa+iEPLYkFAzbstrn4xPBn1OiEadeMbQTCxDvShYCS4
   0NECaHek1vssv1bv0YBg4J33SckJYcqvt3Y5nWi5r5YVv3SkR+dJsar0A
   IzbkBUZUmPdco0eZAfKTXsKcfI8Cb1afiuhVAvL3e4L/MyXg5vFgh6uZE
   Q==;
X-CSE-ConnectionGUID: hK8v/oFFTlytsmstXy/rJA==
X-CSE-MsgGUID: /ds4GKQJQYmiY9joqAq9mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53127018"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="53127018"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:16:47 -0700
X-CSE-ConnectionGUID: 5W+A5CHwRjGF5/AsJMPzkg==
X-CSE-MsgGUID: qyyee3xYTNuRtsRlsQMXVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80095743"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 21:16:41 -0700
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
	Lyude Paul <lyude@redhat.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH v4 3/4] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Date: Wed,  9 Oct 2024 12:11:46 +0800
Message-ID: <20241009041147.28391-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009041147.28391-1-baolu.lu@linux.intel.com>
References: <20241009041147.28391-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nvkm_device_tegra_probe_iommu(), a paging domain is allocated for @dev
and attached to it on success. Use iommu_paging_domain_alloc() to make it
explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index d1c294f00665..78a83f904bbd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -120,8 +120,8 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	mutex_init(&tdev->iommu.mutex);
 
 	if (device_iommu_mapped(dev)) {
-		tdev->iommu.domain = iommu_domain_alloc(&platform_bus_type);
-		if (!tdev->iommu.domain)
+		tdev->iommu.domain = iommu_paging_domain_alloc(dev);
+		if (IS_ERR(tdev->iommu.domain))
 			goto error;
 
 		/*
-- 
2.43.0


