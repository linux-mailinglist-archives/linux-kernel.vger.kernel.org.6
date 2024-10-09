Return-Path: <linux-kernel+bounces-356246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A1995E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405EF288946
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898015382F;
	Wed,  9 Oct 2024 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUqemO13"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C398137C37
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447402; cv=none; b=usXdzIbuzU43yoH3L/u0KYpDn47d5DaoWQgJ56mj8pcS1OTVk60tvSlEURVKf8sKy12cCSDGZxODhDzWAfb5DiFBMG5P132jRHRnG2cZINOBrNY1Gel1hIx1qtqrmMXH3nP77PZ979gdLVgfRADZrNW5IDilgaF/ET9QXeorWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447402; c=relaxed/simple;
	bh=uEZHu/PVfdBPbQ846vnRaHi9qbLdVY+D5A9rU1Lwz6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0Oaymiwm2sj2anwIK7q2rzpWqrnJQ3ou+mrcU11gvLsagyj58bA9J4Xc0ibDY1jxSj75FNOJhI8wr+caJSp0odRHvuRWj2UofeBfYG1Pur2mzD9BMfWdCv7haQ8xF8KJt35DteUaj3ueae459xiou/HvOX7EIiXYq1CHc6frls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUqemO13; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447402; x=1759983402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEZHu/PVfdBPbQ846vnRaHi9qbLdVY+D5A9rU1Lwz6c=;
  b=FUqemO13orIRFRRDwX8h3slx3eTgm3PXsKrPolNzOF3tQUnZpicilAVB
   4mSRFpDeHkq8Fjc/kzmKjj4qeoyMIU07DlkvWCBccDsm2phpyoM2ZmoJD
   HV3zMy2WLZmRkirOBtc2wzb8GYEU+CdHUBukb8XDj5vben5VNoGp3lkNj
   ZxcnowPEBu86iGZS2/791mmQpJ08RfLh5bTHZpp/x8e1ZE9oYEhRznQJz
   VtCYQxT74x+YznQWEJNFs+Cg7i15gbqXcwz3XkG5CZMHdaa0xmBRW8ctD
   l3TNBVLQ9bXXHqO1hWU2ntWcWpKgeUNk08vW6JdHeCRZrV4asxTHOzQWT
   Q==;
X-CSE-ConnectionGUID: YemWL/txSMOExWXWXBIvQg==
X-CSE-MsgGUID: ZSOlOiRnR6q9DIH1aorYfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53126998"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="53126998"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:16:41 -0700
X-CSE-ConnectionGUID: UYwQwEn3SgCh1SLgrMHEFg==
X-CSE-MsgGUID: +AYjs8w1TPWVJjIqb4V2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80095725"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 21:16:36 -0700
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH v4 2/4] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Date: Wed,  9 Oct 2024 12:11:45 +0800
Message-ID: <20241009041147.28391-3-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
vde->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index 5521ed3e465f..b1d9d841d944 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -78,9 +78,10 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 		arm_iommu_release_mapping(mapping);
 	}
 #endif
-	vde->domain = iommu_domain_alloc(&platform_bus_type);
-	if (!vde->domain) {
-		err = -ENOMEM;
+	vde->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(vde->domain)) {
+		err = PTR_ERR(vde->domain);
+		vde->domain = NULL;
 		goto put_group;
 	}
 
-- 
2.43.0


