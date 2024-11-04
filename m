Return-Path: <linux-kernel+bounces-394076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144369BAA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F581C2102C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7A18A95F;
	Mon,  4 Nov 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKHT8Ui1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D117C7C6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684491; cv=none; b=AlNJNIkZod3763Ns/rzUhuE0bftJwbYfamddqHfAhZ+PBT6QVycsQmlhiv2TtmQJLtDwvsLobnEq3OPdACRZXj3umEGPQTO/88j56dxQ2lReG2hNOHnREvsCzzbTvDVwp6CZBEzH4Ngm2vBeBcqrg7/7YfwhfqJiFFiqbklnc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684491; c=relaxed/simple;
	bh=5ikrJYE2v63GTuWmc304uEtArJ9WsMTRZafX88ViieY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVB/Le61vfgAJlspObv050ckEPo02yXjmhB7pFg3i65PI9H1lyacDgw1Clr7xwltNTmTLRkSDxVOCVCk6ZnFGq9Pt7QJrybaxkwfno17q10tIQfBdab1TiLJtfW9nQwdAGbWtp0Hs8XzncLKwoMURgAG3VcyRvz5XpkNLqlvB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKHT8Ui1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684490; x=1762220490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ikrJYE2v63GTuWmc304uEtArJ9WsMTRZafX88ViieY=;
  b=WKHT8Ui1AHWHjc5zuQh0q9n3oDc7haOp9aWtmi0kMRi0UJMth6egeAN0
   51PqzDs6Hi08FzGuuRGhYCoY46iFqHSxSRfkIomRv8QHPfB6/WFihKhYC
   4b8xSpJPHVOjLI2TOjR1ztk7o+yie4W1UJ0wdjOClJvq1G17u1QcCrHGL
   wC+WlaGcXBWELcUPUoRp7Nf2zlUoIhTDkcy+TuNRO+Nvap+qHhJpj3CNx
   /q/eUYMaQlzj5UPKh6I2O2p01dRsYZF3EA+0F7+t2J7iBxHuO2I1LU9A9
   0HaNF2FeIPa9zQxND0yVIJYfo7qEm743pjf6meVfIdzxiuUQJMH2cIHQo
   A==;
X-CSE-ConnectionGUID: 6LNAzmVVR7ywJpoVcqcm1g==
X-CSE-MsgGUID: cLxdGqB4SZy9ZarFiryExw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221922"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221922"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:30 -0800
X-CSE-ConnectionGUID: RzDLdfinTGivi1W9WHPObg==
X-CSE-MsgGUID: HRG+D7AiT3iW6JgkzSoLMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020881"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:29 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] iommu/vt-d: Remove domain_update_iommu_superpage()
Date: Mon,  4 Nov 2024 09:40:25 +0800
Message-ID: <20241104014040.106100-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement for consistent super page support across all the IOMMU
hardware in the system has been removed. In the past, if a new IOMMU
was hot-added and lacked consistent super page capability, the hot-add
process would be aborted. However, with the updated attachment semantics,
it is now permissible for the super page capability to vary among
different IOMMU hardware units.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 39 +------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d148274e7135..f6dc83c26fa5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -352,36 +352,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static int domain_update_iommu_superpage(struct dmar_domain *domain,
-					 struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int mask = 0x3;
-
-	if (!intel_iommu_superpage)
-		return 0;
-
-	/* set iommu_superpage to the smallest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			if (domain && domain->use_first_level) {
-				if (!cap_fl1gp_support(iommu->cap))
-					mask = 0x1;
-			} else {
-				mask &= cap_super_page_val(iommu->cap);
-			}
-
-			if (!mask)
-				break;
-		}
-	}
-	rcu_read_unlock();
-
-	return fls(mask);
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -2605,20 +2575,13 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
+	int ret;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
 
-	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
-	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("%s: Doesn't support large page.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-- 
2.43.0


