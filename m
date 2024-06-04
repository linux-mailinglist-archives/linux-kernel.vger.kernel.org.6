Return-Path: <linux-kernel+bounces-199929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31A8FA7E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1B5B247EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943FD13DDC4;
	Tue,  4 Jun 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE2t4oR1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F91411D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466095; cv=none; b=qF4PXMQ4TpUEJ6SMvYD+GQKX+mVXa1jQ3WMvkSzlhYz6A37qq2D1YvA8NtrE20HO1eir5ZSV2Kh5zMf5Yk54sG9uVbXtMh1i2t0yaRlakTNyzBE1eRuJ3hWvqy6DC4ESYPeCWUu62E3uwSK4pDrXzgZUoi1DK6prphTMa9k1Iis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466095; c=relaxed/simple;
	bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+pB1b/4Nm2JZ15TzeoFMOYTycLCbPJ5PcZEgvffrYg8Soa0Ai8ukHZegb8eyPOnI24lPCsC4X695cBWa7Z+T4I+WeABrrqggPVBs1lGdIRbMmn0y8GIy5lZ48SEbgBQXYg6jOIgKzrpHh6TlBDL+ZZRZaDFhO7Geu4DI0UsI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE2t4oR1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466094; x=1749002094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4g7oPuUpFCf7ehXVGbGAAANzK1lpGoRJJpR32Cbgc4=;
  b=bE2t4oR1SXKURPiz1Dsdxe0KQsjSDDW/MIuOMpgWNpM8h+I3a4ciWn3m
   N/yPzNc6yJ0vb2Z4VfEcLEPYrxoGpxMCoHQzeJbt2oN9lpT3dmPp4XLWA
   N5MKjIvDShvDwxxfDV2N3oQDCrckZtapmhofcTGNE12yrUE1Mfc69L6eN
   bMIALIWH8+tlKZUKrjzliktBt9y4Wqq1TfNuVft4V6YqgtUc8JRRzqCCr
   wDMPO+YPLWjQVjl7GMAEFkCqpAhVHgHvlR7D68hKzl1wWt/er4sgDvNdE
   U9x28K2EQLJdqeGBEReodVBqRi3GJaZFQcJCs3AkFbYnlrUUhFBJeeOpQ
   w==;
X-CSE-ConnectionGUID: Knvb5Fc7Qlqk8uLovWBSVQ==
X-CSE-MsgGUID: 6ud5bYqJREeh6jX++cLQ8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385045"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385045"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:54 -0700
X-CSE-ConnectionGUID: DQ0egUMjQGSEUpZ0ZFVhjw==
X-CSE-MsgGUID: 2DpNSy0/Tymi8iHi2D3nuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661916"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:50 -0700
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
Subject: [PATCH v2 12/22] wifi: ath11k: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:24 +0800
Message-Id: <20240604015134.164206-13-baolu.lu@linux.intel.com>
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


