Return-Path: <linux-kernel+bounces-293183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7551957BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F7B1C23B11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83474502F;
	Tue, 20 Aug 2024 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOoI5B0e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82A25763
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123168; cv=none; b=oFHMRTBNqOTLNgHSsiYz5+ZnOAPrleup+xoAhXwTfPZvwElXXMGRiTAbQJsQpmIUfxSo/f3v+/CvtgTrXrWmcW49lmiKQ4rwBnoA0wUDAwcx1/yd4Imuwa/Nos4N5UzVo385745OuSIgEFzPEHlLYKyhl3xfUTNwjwLEUPd59F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123168; c=relaxed/simple;
	bh=D4NWc1ISe5L1Y95LSqKQcLDmDgdsikzzYZ3vCOvQJCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=us3hzIn9gBeEGfbal+yOOdi0zesvAYcFOGyArbrm1SPLOXUcW9L9KPRoe6ewe/7hF7VttaJkQuKudbj6aBZ3iO3fdW4tmHsdODuXQ35mkTused7D8ByqXCQmm9WASMxMr8gJC4/ECQTeIINEtoqKf+yFLa6yDvWb2+Bx6FQOVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOoI5B0e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724123167; x=1755659167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4NWc1ISe5L1Y95LSqKQcLDmDgdsikzzYZ3vCOvQJCI=;
  b=BOoI5B0eqT74GEcqjZTUIZacWZ+53rpS5RfqoNOtv9WpXG8rpz06a8Hy
   bSg0M7cM3M7yE6gqkxQsckM7XcohrBFpBlvvbBEyKxa+vpX4SAisSO8PT
   88VewOKZo6SvdtINA65uWxdapEvIUGMW+n+S2RIRymVyTB1+ovrMRBPLS
   QreZot39ux5Wkh2eUF/Wymkje9xojhcFkAsiGwRjdMfozqptwmLAnOKwH
   QNqMZY1eS7Me3xyegsN/LToUwkfC5LN3xkRNaLyapx/PUomsWANjd71fC
   efI7U7Kq9ubY0pt8Jj5JWzx66BguAbGdqL71IccH0C4XwJP+1kQI4Qx36
   A==;
X-CSE-ConnectionGUID: sjPrTIvAQLSeucaHQZxhiA==
X-CSE-MsgGUID: t3l+R9mxTTOpuvy9yAcXzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22542953"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22542953"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 20:05:50 -0700
X-CSE-ConnectionGUID: UHCmsldzR7S+yyCbUDK9Zw==
X-CSE-MsgGUID: H38gDz3ISSykmFz1pLykiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="65395406"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2024 20:05:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for pasid table updates
Date: Tue, 20 Aug 2024 11:02:08 +0800
Message-Id: <20240820030208.20020-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caching mode of an IOMMU is irrelevant to the behavior of the device
TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
check before device TLB flush") removed this redundant check in the
domain unmap path.

Checking the caching mode before flushing the device TLB after a pasid
table entry is updated is unnecessary and can lead to inconsistent
behavior.

Extends this consistency by removing the caching mode check in the pasid
table update path.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..dc00eac6be31 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -264,9 +264,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /*
@@ -493,9 +491,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 
 	return 0;
 }
@@ -572,9 +568,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /**
-- 
2.34.1


