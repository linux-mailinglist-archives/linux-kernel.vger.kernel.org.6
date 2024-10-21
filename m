Return-Path: <linux-kernel+bounces-373942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B029A5F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9DB1F2353E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA061E2856;
	Mon, 21 Oct 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhVKW6tG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3F1E3DEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500999; cv=none; b=EmhumUKybrKCQ5MEu0QY+mVs3oKXzyZlsoFg7XqLc3FanD4UFQ6lKiCpEPyiZZ5QafPIW2NPqjyRYJNNNODT3GO2ozMwyfyXDiVeTdDdLvE1CY92FphkY8Lr8GoVW/9l9zEkxQfBoSTJ8A8AZHsNoBZ06gb73UO3A+AeJppVgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500999; c=relaxed/simple;
	bh=kqJ81w2X5hak4sjUBjP1L0SagSpWOgRvgVPYFi3njhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtNVav3e4Gw1kKZr4z5XaUkDQigKTMsoSzJd3hngWEe4UtWzr5sJmSssVZRx0RD8LH13A8qmfaBLxE5gkWSL7RRJs7HShUnjNk+KnVXeiajnZQhxnZyVPHuOYNT7QPhOIILOTxA0gfwK9dwso0xo3lLEnBv534CR9Tb9HBsTZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhVKW6tG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500998; x=1761036998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqJ81w2X5hak4sjUBjP1L0SagSpWOgRvgVPYFi3njhc=;
  b=BhVKW6tGEsgwqp0aXoMyCXCVUNhefBwIHypxFLEMtdSS4fClnBlzX5TG
   JV7g88E8VHLVh+lYElKWb/x/1dxxUyF1Lv2mvTw6NBJ/lDpvz8huFiVAA
   1uQPGJQvHoCH5Xns2fYQIyHTawt0VxqubuiFW6YWJMtqRsAz1dfYwHKdG
   jIF811ifAi74u4RkNy9LwWw/G2h3BmhYJ2JbvPXV0Whb3dzailFd9VgV3
   uGtx8w1oyALUXE8SL3Njk0BIklQcFLj4ty7F+wu2m4nAzl8/N+mGawJZz
   S4D7mv7/cipQ84Qj0Chda1OoDCd/gfalseVaqfAeWqWscgaGEe1xkrXuM
   g==;
X-CSE-ConnectionGUID: R2F2/b4FQSy3KPiFbfMQQw==
X-CSE-MsgGUID: gDNF1XXHT6G1p3v6NoWHoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780380"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780380"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:38 -0700
X-CSE-ConnectionGUID: ni7yTVQpSxeKmHIGG23Zhw==
X-CSE-MsgGUID: +dy3oQjkTnabhFoJXYluqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812784"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 6/7] iommu/vt-d: Refactor first_level_by_default()
Date: Mon, 21 Oct 2024 16:51:23 +0800
Message-ID: <20241021085125.192333-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first stage page table is compatible across host and guest kernels.
Therefore, this driver uses the first stage page table as the default for
paging domains.

The helper first_level_by_default() determines the feasibility of using
the first stage page table based on a global policy. This policy requires
consistency in scalable mode and first stage translation capability among
all iommu units. However, this is unnecessary as domain allocation,
attachment, and removal operations are performed on a per-device basis.

The domain type (IOMMU_DOMAIN_DMA vs. IOMMU_DOMAIN_UNMANAGED) should not
be a factor in determining the first stage page table usage. Both types
are for paging domains, and there's no fundamental difference between them.
The driver should not be aware of this distinction unless the core
specifies allocation flags that require special handling.

Convert first_level_by_default() from global to per-iommu and remove the
'type' input.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 36854b683b11..bad9593f2464 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1329,18 +1329,17 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(unsigned int type)
+static bool first_level_by_default(struct intel_iommu *iommu)
 {
 	/* Only SL is available in legacy mode */
-	if (!scalable_mode_support())
+	if (!sm_supported(iommu))
 		return false;
 
 	/* Only level (either FL or SL) is available, just use it */
-	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
-		return intel_cap_flts_sanity();
+	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
+		return ecap_flts(iommu->ecap);
 
-	/* Both levels are available, decide it based on domain type */
-	return type != IOMMU_DOMAIN_UNMANAGED;
+	return true;
 }
 
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
@@ -3110,7 +3109,7 @@ int __init intel_iommu_init(void)
 		 * the virtual and physical IOMMU page-tables.
 		 */
 		if (cap_caching_mode(iommu->cap) &&
-		    !first_level_by_default(IOMMU_DOMAIN_DMA)) {
+		    !first_level_by_default(iommu)) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
@@ -4359,10 +4358,12 @@ static struct iommu_domain identity_domain = {
 
 static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	bool first_stage;
 
-	first_stage = first_level_by_default(0);
+	first_stage = first_level_by_default(iommu);
 	dmar_domain = paging_domain_alloc(dev, first_stage);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
-- 
2.43.0


