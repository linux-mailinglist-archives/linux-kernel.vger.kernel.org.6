Return-Path: <linux-kernel+bounces-394089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BD9BAA79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843CA2831B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1D1ACDED;
	Mon,  4 Nov 2024 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCWfnPIz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3821AB52D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684508; cv=none; b=t9cFz7eUG/r4QDSrNnQeNz5Dxpm+2aCBejpHyqUh4MhDbA6dcbdFcHyLcNqmfdJGiNL7MTejWqFcf+y7pKZbsgDYEXRWomouj81cp9AYr6MWneJbBjJtB1kfkFhnPQh6ea/fav34eoQVNO8UKoMhD8rdDgNgSiY3cJXFWKXckYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684508; c=relaxed/simple;
	bh=7d3csjJ3DYXPQKUIp1GBHIvCPxoLtAyeR0KKMwyATM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBXWdBuRQKUOOhGSzJOLyuQda5KHTHuGyYoCbql5B6h3ivDpZInl6dAQLwNEN2yDtTAZUj5okPPFA/p+6UbepHuf7ye4ZoExLw9pzovaoHV09TlcJHUastP6v5qgf31Xv64R+EpyaTFEjvq6R/fhKuXJXnSb0Xbg6crmBBq6rBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCWfnPIz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684506; x=1762220506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7d3csjJ3DYXPQKUIp1GBHIvCPxoLtAyeR0KKMwyATM0=;
  b=SCWfnPIzv9t+FzY6nC8wuooDiZ1hsx3GTKZcrGHDazxHPOCwhCwGmIpF
   5l4uHuxZuum2UfQHArISgkEgHZdhHa+I7Fa1H7pPJ+yjn2xY5M8UQ5TQC
   eYh4ZjiMsCeg3v/1QW9+gayqXViaGqqZtZAhXR7qPMzpdjpQQlW6PlNdm
   qlJoAIwWiRBgaZIfsikPWSLVxMvbfDIq3CBBunHuvkSIFy90CtkJCBIPP
   wssJjNtoOoIY1/96v2crCrruTS6T8dkqcNtd64msb/ebM1+vvq/tODc2v
   qbbTH8xvFwfGSrOFqCpNsQuLn9IxudRcrzpH8jS5pv+YLl1RMVPA39O6s
   w==;
X-CSE-ConnectionGUID: iepv+dE3Tdur9338MWPL1A==
X-CSE-MsgGUID: FZeM1dxRRJSUQxgPrzzMBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221964"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221964"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:46 -0800
X-CSE-ConnectionGUID: +I98svfDQn2OxAfdLPFW7w==
X-CSE-MsgGUID: 2XeJd0MVQUGI3+Nv6gF51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020909"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] iommu/vt-d: Drop pasid requirement for prq initialization
Date: Mon,  4 Nov 2024 09:40:38 +0800
Message-ID: <20241104014040.106100-19-baolu.lu@linux.intel.com>
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

From: Klaus Jensen <k.jensen@samsung.com>

PASID support within the IOMMU is not required to enable the Page
Request Queue, only the PRS capability.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20241015-jag-iopfv8-v4-5-b696ca89ba29@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1e432729ea09..87a3563dfe54 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1329,10 +1329,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-	if (pasid_supported(iommu)) {
-		if (ecap_prs(iommu->ecap))
-			intel_iommu_finish_prq(iommu);
-	}
+	if (ecap_prs(iommu->ecap))
+		intel_iommu_finish_prq(iommu);
 }
 
 /*
@@ -2192,7 +2190,7 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+		if (ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
@@ -2616,7 +2614,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
-- 
2.43.0


