Return-Path: <linux-kernel+bounces-281566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49294D836
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F94E1C22BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA616DC23;
	Fri,  9 Aug 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtSwpaes"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FC16CD3D;
	Fri,  9 Aug 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236421; cv=none; b=mLXPxrZSUHKJxVr8++rR7hAUHEZFunz2AFBmfGvLzxpQtKVNhJ8nyBMkE1HqDjXfGsl7BvU41xdjSYtGu3b65JITZa8qj3j+RMpaeJeJa0KBFkZcu6x1h7GJp3knIlXKRzuze8jvawUhaBjQvPHQ8hnfcX6Zksa7NKDXAcdALXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236421; c=relaxed/simple;
	bh=VaA0qvmu8YEqoRCmewI0letx315jeZBhGiXu7x4E41w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejvV+yMlxPr13VccN2TIQoMs4NC/yJfkBNu4r1GPsfLDzzTtkrpYr0YFjJweOqmMRelC1OeL1zlc+p6WbF5hR0xGH//5ScnzGo+SO8f9vp7WeHwUFvop5bnG2MUyDFTvI0SrIREjSbazXBq9DkAqU3NVS0EG/bCChkOH2xK6nlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtSwpaes; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236419; x=1754772419;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VaA0qvmu8YEqoRCmewI0letx315jeZBhGiXu7x4E41w=;
  b=AtSwpaes8m7E5la2L8vRFK7F4tYDTxONbu5mX0ZByJCIDO/6m6RbZ/Iu
   ZW5liirp/KBSwUOdo1v6meUBBsFxlHuws+Zg6gIZalzK0QR8008PAXNUI
   eMVICvVkhFdmc/huWjsyVekZwpZ21201HuVymw0k7FawtrAZ1eqTs4hM0
   GAyt9Gl2Z4ZPFWXE/Ahe0oJJ/WXWGnqqDK4zIxpc4CxC/38fsJ2LamEq2
   noCg2ADQZR3ze4R9voEhrBGUkkitlNi+a/daMcA8s0Vo0OISGFkRgxG6u
   JucwEJ+0hlX58oeXbm40QBG55c9iXYIVWvdbb6pPbDzGsqAWmFsa9WEhP
   Q==;
X-CSE-ConnectionGUID: c4kTs7f5TXWJhAj2OO3WGA==
X-CSE-MsgGUID: C0kw8hfmQAa3KW+AjkwW4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819040"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819040"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:59 -0700
X-CSE-ConnectionGUID: i/2HbBonRvCrHfMTe/A8YQ==
X-CSE-MsgGUID: HDnZyscjQLayzmFcWQAmpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650483"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:57 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] platform/x86:intel/pmc: Get LPM information for available platforms
Date: Fri,  9 Aug 2024 13:46:36 -0700
Message-ID: <20240809204648.1124545-8-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to find and read the requirements from the telemetry
entries for Meteor Lake, Lunar Lake and Arror Lake platforms.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 16 ++++++++++++++--
 drivers/platform/x86/intel/pmc/lnl.c | 10 ++++++++--
 drivers/platform/x86/intel/pmc/mtl.c | 17 +++++++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 7a340b8c7b6a..0db16deacf85 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -11,6 +11,13 @@
 #include <linux/pci.h>
 #include "core.h"
 
+/* PMC SSRAM PMT Telemetry GUID */
+#define IOEP_LPM_REQ_GUID	0x5077612
+#define SOCS_LPM_REQ_GUID	0x8478657
+#define PCHS_LPM_REQ_GUID	0x9684572
+
+static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 const struct pmc_bit_map arl_socs_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -269,6 +276,7 @@ const struct pmc_reg_map arl_socs_reg_map = {
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
+	.lpm_reg_index = ARL_LPM_REG_INDEX,
 	.etr3_offset = ETR3_OFFSET,
 	.pson_residency_offset = TGL_PSON_RESIDENCY_OFFSET,
 	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
@@ -637,19 +645,23 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
+	.lpm_reg_index = ARL_LPM_REG_INDEX,
 	.etr3_offset = ETR3_OFFSET,
 };
 
 static struct pmc_info arl_pmc_info_list[] = {
 	{
+		.guid	= IOEP_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_MTL_IOEP,
 		.map	= &mtl_ioep_reg_map,
 	},
 	{
+		.guid	= SOCS_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_ARL_SOCS,
 		.map	= &arl_socs_reg_map,
 	},
 	{
+		.guid	= PCHS_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_ARL_PCHS,
 		.map	= &arl_pchs_reg_map,
 	},
@@ -679,7 +691,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
 int arl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret;
+	int ret, func = 0;
 
 	arl_d3_fixup();
 	pmcdev->suspend = cnl_suspend;
@@ -703,5 +715,5 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
 
-	return 0;
+	return pmc_core_get_lpm_reqs(pmcdev, func);
 }
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 109b08d43fc8..66e4d39d0493 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,8 +13,13 @@
 
 #include "core.h"
 
+#define SOCM_LPM_REQ_GUID	0x15099748
+
+static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 static struct pmc_info lnl_pmc_info_list[] = {
 	{
+		.guid	= SOCM_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_LNL_SOCM,
 		.map	= &lnl_socm_reg_map,
 	},
@@ -536,6 +541,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = lnl_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.lpm_reg_index = LNL_LPM_REG_INDEX,
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -561,7 +567,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
-	int ret;
+	int ret, func = 2;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 
 	lnl_d3_fixup();
@@ -586,5 +592,5 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
-	return 0;
+	return pmc_core_get_lpm_reqs(pmcdev, func);
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 86f8c2a24825..20bcb1b7029b 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -11,6 +11,13 @@
 #include <linux/pci.h>
 #include "core.h"
 
+/* PMC SSRAM PMT Telemetry GUIDS */
+#define SOCP_LPM_REQ_GUID	0x2625030
+#define IOEM_LPM_REQ_GUID	0x4357464
+#define IOEP_LPM_REQ_GUID	0x5077612
+
+static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 /*
  * Die Mapping to Product.
  * Product SOCDie IOEDie PCHDie
@@ -465,6 +472,7 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_sts = mtl_socm_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioep_pfear_map[] = {
@@ -788,6 +796,7 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
 	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
 	.lpm_en_offset = MTL_LPM_EN_OFFSET,
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioem_pfear_map[] = {
@@ -934,18 +943,22 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
 	.lpm_en_offset = MTL_LPM_EN_OFFSET,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
 	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 static struct pmc_info mtl_pmc_info_list[] = {
 	{
+		.guid	= SOCP_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_MTL_SOCM,
 		.map	= &mtl_socm_reg_map,
 	},
 	{
+		.guid	= IOEP_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_MTL_IOEP,
 		.map	= &mtl_ioep_reg_map,
 	},
 	{
+		.guid	= IOEM_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_MTL_IOEM,
 		.map	= &mtl_ioem_reg_map
 	},
@@ -977,7 +990,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret;
+	int ret, func = 2;
 
 	mtl_d3_fixup();
 
@@ -1002,5 +1015,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
 
-	return 0;
+	return pmc_core_get_lpm_reqs(pmcdev, func);
 }
-- 
2.43.0


