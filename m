Return-Path: <linux-kernel+bounces-281560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BE94D82E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9951C22825
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641216B3BA;
	Fri,  9 Aug 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXEWLLAI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB439224EA;
	Fri,  9 Aug 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236417; cv=none; b=ZSIu5GxpM37JDy4/FRqqbS2XDRPlX55zLozKnNg6nHF13pSjs9hykNpTHcwNWdVIY8T2Faj7B3u2WraE43IjxNHxIWOiaDF8Yx9qGel3OcYvdLanBzqLsGHsNTjnltFBwRAbDyDWnEPHXH1GkZLeIMwfiaxj4X264q+O+TGgLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236417; c=relaxed/simple;
	bh=C2prt3WBAXRkPj9xnutVI8kguGe7vJnrpDdwmWF57/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icE5mHxK5WGT5UqAwByLjAkqDnQ0MRWSMG/ZL3v6wGlur0HLKVCwbHX2aSDiWE7eSEQTgg3hUIOpqGjjEeo6aKB4t8lazw59/Mmk6zSYZcDjrrggjVIfbfenVKI+pBCFXKlhu1mxDbM6kBjwBIxrQNb6/d8CngrsEGLNeIlL+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXEWLLAI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236414; x=1754772414;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=C2prt3WBAXRkPj9xnutVI8kguGe7vJnrpDdwmWF57/0=;
  b=SXEWLLAIHU6S4sflOoKGHNfibIaUDKrTZT4DVmaKKQUl36KW11Wb/ymc
   H/o79PDFQ4/lxrYD7DzfKxJu4XrA+k8Ewr4ho6XSbT73zePLHVRiafHDf
   SBtbhmLRMqDC5er7ff4lzmwreqFyqpbMtU4xL83rRcXwIoLlRGXZTWdym
   rrXz5wKl5LRFe2xyeavOQabfJcDmJV61IUXajYk23vHOWPhYvrNz0ZhAm
   FxHVJijHWTSCgS0tcIUQ6RJXm8N4GZPX7bYcRhb7rVS3nGY+gyUsNHgi9
   uuf7scwaNU/504AkesqCUPq03q0knRy6fkPo0VCKgt3ib3gZ3dMxZ/Apf
   A==;
X-CSE-ConnectionGUID: cR09dAm7S6+Dt3TnMWGFsA==
X-CSE-MsgGUID: z2WoZSY3Tl6D0P3awRhaWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819016"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819016"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:53 -0700
X-CSE-ConnectionGUID: 44PgeGMHQA6rVc/u0rGPGA==
X-CSE-MsgGUID: xiqrTauKQ5u/8aWuVoBmdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650470"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:52 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] platform/x86:intel/pmc: Remove SSRAM support from PMC Core
Date: Fri,  9 Aug 2024 13:46:30 -0700
Message-ID: <20240809204648.1124545-2-xi.pardee@linux.intel.com>
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

From: Xi Pardee <xi.pardee@intel.com>

Remove SSRAM support code from PMC Core driver. That includes removing
support to discover PMCs through SSRAM device and achieve LPM requirement
data from telemetry endpoints. A separate Intel SSRAM Telemetry driver
will be added later in this series to be responsible for the SSRAM device.

Currently PMC Core driver gets PWRMBASE address and devid for each PMC from
the SSRAM device and also registers telemetry endpoints through intel_vsec
driver. PMC Core probe function returns -EPROBE_DEFER when getting LPM
requirement data from a telem endpoint that is not available yet. This
setup may result in an infinite loop of .probe() calls as -EPROBE_DEFER
is returned after a child device has been registered. Creating a new Intel
SSRAM Telemetry driver prevents the infinite loop possibility.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile     |   4 +-
 drivers/platform/x86/intel/pmc/arl.c        |  58 +---
 drivers/platform/x86/intel/pmc/core.c       |   6 +-
 drivers/platform/x86/intel/pmc/core.h       |   5 -
 drivers/platform/x86/intel/pmc/core_ssram.c | 326 --------------------
 drivers/platform/x86/intel/pmc/mtl.c        |  59 +---
 6 files changed, 12 insertions(+), 446 deletions(-)
 delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 389e5419dadf..6b682be0ec5a 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,8 +3,8 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o core_ssram.o spt.o cnp.o \
-					   icl.o tgl.o adl.o mtl.o arl.o lnl.o
+intel_pmc_core-y			:= core.o spt.o cnp.o icl.o \
+					   tgl.o adl.o mtl.o arl.o lnl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index e10527c4e3e0..4b824612f355 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -10,14 +10,6 @@
 
 #include <linux/pci.h>
 #include "core.h"
-#include "../pmt/telemetry.h"
-
-/* PMC SSRAM PMT Telemetry GUID */
-#define IOEP_LPM_REQ_GUID	0x5077612
-#define SOCS_LPM_REQ_GUID	0x8478657
-#define PCHS_LPM_REQ_GUID	0x9684572
-
-static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
 const struct pmc_bit_map arl_socs_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
@@ -277,7 +269,6 @@ const struct pmc_reg_map arl_socs_reg_map = {
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
-	.lpm_reg_index = ARL_LPM_REG_INDEX,
 	.etr3_offset = ETR3_OFFSET,
 	.pson_residency_offset = TGL_PSON_RESIDENCY_OFFSET,
 	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
@@ -646,32 +637,9 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.lpm_num_maps = ADL_LPM_NUM_MAPS,
-	.lpm_reg_index = ARL_LPM_REG_INDEX,
 	.etr3_offset = ETR3_OFFSET,
 };
 
-#define PMC_DEVID_SOCS 0xae7f
-#define PMC_DEVID_IOEP 0x7ecf
-#define PMC_DEVID_PCHS 0x7f27
-static struct pmc_info arl_pmc_info_list[] = {
-	{
-		.guid	= IOEP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEP,
-		.map	= &mtl_ioep_reg_map,
-	},
-	{
-		.guid	= SOCS_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCS,
-		.map	= &arl_socs_reg_map,
-	},
-	{
-		.guid	= PCHS_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_PCHS,
-		.map	= &arl_pchs_reg_map,
-	},
-	{}
-};
-
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
 /*
@@ -696,36 +664,18 @@ int arl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 	int ret;
-	int func = 0;
-	bool ssram_init = true;
 
 	arl_d3_fixup();
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = arl_resume;
-	pmcdev->regmap_list = arl_pmc_info_list;
 
-	/*
-	 * If ssram init fails use legacy method to at least get the
-	 * primary PMC
-	 */
-	ret = pmc_core_ssram_init(pmcdev, func);
-	if (ret) {
-		ssram_init = false;
-		pmc->map = &arl_socs_reg_map;
-
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
+	pmc->map = &arl_socs_reg_map;
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
 
-	if (ssram_init)	{
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..5ecf55176734 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1386,11 +1386,6 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 			iounmap(pmc->regbase);
 	}
 
-	if (pmcdev->ssram_pcidev) {
-		pci_dev_put(pmcdev->ssram_pcidev);
-		pci_disable_device(pmcdev->ssram_pcidev);
-	}
-
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
@@ -1623,5 +1618,6 @@ static struct platform_driver pmc_core_driver = {
 
 module_platform_driver(pmc_core_driver);
 
+MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..b0c66df8cd98 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -386,7 +386,6 @@ struct pmc {
  * struct pmc_dev - pmc device structure
  * @devs:		pointer to an array of pmc pointers
  * @pdev:		pointer to platform_device struct
- * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
  * @crystal_freq:	crystal frequency from cpuid
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
@@ -406,7 +405,6 @@ struct pmc_dev {
 	struct pmc *pmcs[MAX_NUM_PMC];
 	struct dentry *dbgfs_dir;
 	struct platform_device *pdev;
-	struct pci_dev *ssram_pcidev;
 	unsigned int crystal_freq;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
@@ -579,7 +577,6 @@ extern const struct pmc_bit_map *arl_pchs_lpm_maps[];
 extern const struct pmc_reg_map arl_pchs_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
-extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
@@ -588,8 +585,6 @@ extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 extern void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
 extern void pmc_core_set_device_d3(unsigned int device);
 
-extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
-
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
deleted file mode 100644
index 1bde86c54eb9..000000000000
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ /dev/null
@@ -1,326 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * This file contains functions to handle discovery of PMC metrics located
- * in the PMC SSRAM PCI device.
- *
- * Copyright (c) 2023, Intel Corporation.
- * All Rights Reserved.
- *
- */
-
-#include <linux/cleanup.h>
-#include <linux/pci.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
-
-#include "core.h"
-#include "../vsec.h"
-#include "../pmt/telemetry.h"
-
-#define SSRAM_HDR_SIZE		0x100
-#define SSRAM_PWRM_OFFSET	0x14
-#define SSRAM_DVSEC_OFFSET	0x1C
-#define SSRAM_DVSEC_SIZE	0x10
-#define SSRAM_PCH_OFFSET	0x60
-#define SSRAM_IOE_OFFSET	0x68
-#define SSRAM_DEVID_OFFSET	0x70
-
-/* PCH query */
-#define LPM_HEADER_OFFSET	1
-#define LPM_REG_COUNT		28
-#define LPM_MODE_OFFSET		1
-
-DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
-
-static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
-{
-	for (; list->map; ++list)
-		if (list->map == map)
-			return list->guid;
-
-	return 0;
-}
-
-static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
-{
-	struct telem_endpoint *ep;
-	const u8 *lpm_indices;
-	int num_maps, mode_offset = 0;
-	int ret, mode, i;
-	int lpm_size;
-	u32 guid;
-
-	lpm_indices = pmc->map->lpm_reg_index;
-	num_maps = pmc->map->lpm_num_maps;
-	lpm_size = LPM_MAX_NUM_MODES * num_maps;
-
-	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
-	if (!guid)
-		return -ENXIO;
-
-	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
-	if (IS_ERR(ep)) {
-		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
-			PTR_ERR(ep));
-		return -EPROBE_DEFER;
-	}
-
-	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
-					 lpm_size * sizeof(u32),
-					 GFP_KERNEL);
-	if (!pmc->lpm_req_regs) {
-		ret = -ENOMEM;
-		goto unregister_ep;
-	}
-
-	/*
-	 * PMC Low Power Mode (LPM) table
-	 *
-	 * In telemetry space, the LPM table contains a 4 byte header followed
-	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
-	 * has a 4 byte header followed by a set of registers that describe the
-	 * IP state requirements for the given mode. The IP mapping is platform
-	 * specific but the same for each block, making for easy analysis.
-	 * Platforms only use a subset of the space to track the requirements
-	 * for their IPs. Callers provide the requirement registers they use as
-	 * a list of indices. Each requirement register is associated with an
-	 * IP map that's maintained by the caller.
-	 *
-	 * Header
-	 * +----+----------------------------+----------------------------+
-	 * |  0 |      REVISION              |      ENABLED MODES         |
-	 * +----+--------------+-------------+-------------+--------------+
-	 *
-	 * Low Power Mode 0 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  2 |           LPM0 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 29 |           LPM0 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 * ...
-	 *
-	 * Low Power Mode 7 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * | 60 |           LPM7 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 87 |           LPM7 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 */
-	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
-	pmc_for_each_mode(i, mode, pmcdev) {
-		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
-		int m;
-
-		for (m = 0; m < num_maps; m++) {
-			u8 sample_id = lpm_indices[m] + mode_offset;
-
-			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
-			if (ret) {
-				dev_err(&pmcdev->pdev->dev,
-					"couldn't read Low Power Mode requirements: %d\n", ret);
-				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
-				goto unregister_ep;
-			}
-			++req_offset;
-		}
-		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
-	}
-
-unregister_ep:
-	pmt_telem_unregister_endpoint(ep);
-
-	return ret;
-}
-
-int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
-{
-	int ret, i;
-
-	if (!pmcdev->ssram_pcidev)
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		if (!pmcdev->pmcs[i])
-			continue;
-
-		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static void
-pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
-{
-	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
-	struct intel_vsec_platform_info info = {};
-	struct intel_vsec_header *headers[2] = {};
-	struct intel_vsec_header header;
-	void __iomem *dvsec;
-	u32 dvsec_offset;
-	u32 table, hdr;
-
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		return;
-
-	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
-	iounmap(ssram);
-
-	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
-	if (!dvsec)
-		return;
-
-	hdr = readl(dvsec + PCI_DVSEC_HEADER1);
-	header.id = readw(dvsec + PCI_DVSEC_HEADER2);
-	header.rev = PCI_DVSEC_HEADER1_REV(hdr);
-	header.length = PCI_DVSEC_HEADER1_LEN(hdr);
-	header.num_entries = readb(dvsec + INTEL_DVSEC_ENTRIES);
-	header.entry_size = readb(dvsec + INTEL_DVSEC_SIZE);
-
-	table = readl(dvsec + INTEL_DVSEC_TABLE);
-	header.tbir = INTEL_DVSEC_TABLE_BAR(table);
-	header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
-	iounmap(dvsec);
-
-	headers[0] = &header;
-	info.caps = VSEC_CAP_TELEMETRY;
-	info.headers = headers;
-	info.base_addr = ssram_base;
-	info.parent = &pmcdev->pdev->dev;
-
-	intel_vsec_register(pcidev, &info);
-}
-
-static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
-{
-	for (; list->map; ++list)
-		if (devid == list->devid)
-			return list->map;
-
-	return NULL;
-}
-
-static inline u64 get_base(void __iomem *addr, u32 offset)
-{
-	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
-}
-
-static int
-pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-		 const struct pmc_reg_map *reg_map, int pmc_index)
-{
-	struct pmc *pmc = pmcdev->pmcs[pmc_index];
-
-	if (!pwrm_base)
-		return -ENODEV;
-
-	/* Memory for primary PMC has been allocated in core.c */
-	if (!pmc) {
-		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
-		if (!pmc)
-			return -ENOMEM;
-	}
-
-	pmc->map = reg_map;
-	pmc->base_addr = pwrm_base;
-	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
-
-	if (!pmc->regbase) {
-		devm_kfree(&pmcdev->pdev->dev, pmc);
-		return -ENOMEM;
-	}
-
-	pmcdev->pmcs[pmc_index] = pmc;
-
-	return 0;
-}
-
-static int
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
-{
-	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
-	void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
-	void __iomem __free(pmc_core_iounmap) *ssram = NULL;
-	const struct pmc_reg_map *map;
-	u64 ssram_base, pwrm_base;
-	u16 devid;
-
-	if (!pmcdev->regmap_list)
-		return -ENOENT;
-
-	ssram_base = ssram_pcidev->resource[0].start;
-	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-
-	if (pmc_idx != PMC_IDX_MAIN) {
-		/*
-		 * The secondary PMC BARS (which are behind hidden PCI devices)
-		 * are read from fixed offsets in MMIO of the primary PMC BAR.
-		 */
-		ssram_base = get_base(tmp_ssram, offset);
-		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-		if (!ssram)
-			return -ENOMEM;
-
-	} else {
-		ssram = no_free_ptr(tmp_ssram);
-	}
-
-	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
-	devid = readw(ssram + SSRAM_DEVID_OFFSET);
-
-	/* Find and register and PMC telemetry entries */
-	pmc_add_pmt(pmcdev, ssram_base, ssram);
-
-	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
-	if (!map)
-		return -ENODEV;
-
-	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
-}
-
-int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func)
-{
-	struct pci_dev *pcidev;
-	int ret;
-
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
-	if (!pcidev)
-		return -ENODEV;
-
-	ret = pcim_enable_device(pcidev);
-	if (ret)
-		goto release_dev;
-
-	pmcdev->ssram_pcidev = pcidev;
-
-	ret = pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_MAIN, 0);
-	if (ret)
-		goto disable_dev;
-
-	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
-	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
-
-	return 0;
-
-disable_dev:
-	pmcdev->ssram_pcidev = NULL;
-	pci_disable_device(pcidev);
-release_dev:
-	pci_dev_put(pcidev);
-
-	return ret;
-}
-MODULE_IMPORT_NS(INTEL_VSEC);
-MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c7d15d864039..0b9efab21d60 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -10,14 +10,6 @@
 
 #include <linux/pci.h>
 #include "core.h"
-#include "../pmt/telemetry.h"
-
-/* PMC SSRAM PMT Telemetry GUIDS */
-#define SOCP_LPM_REQ_GUID	0x2625030
-#define IOEM_LPM_REQ_GUID	0x4357464
-#define IOEP_LPM_REQ_GUID	0x5077612
-
-static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
 /*
  * Die Mapping to Product.
@@ -473,7 +465,6 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_sts = mtl_socm_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
-	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioep_pfear_map[] = {
@@ -797,7 +788,6 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
 	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
 	.lpm_en_offset = MTL_LPM_EN_OFFSET,
 	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
-	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
 const struct pmc_bit_map mtl_ioem_pfear_map[] = {
@@ -944,29 +934,6 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
 	.lpm_en_offset = MTL_LPM_EN_OFFSET,
 	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
 	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
-	.lpm_reg_index = MTL_LPM_REG_INDEX,
-};
-
-#define PMC_DEVID_SOCM	0x7e7f
-#define PMC_DEVID_IOEP	0x7ecf
-#define PMC_DEVID_IOEM	0x7ebf
-static struct pmc_info mtl_pmc_info_list[] = {
-	{
-		.guid	= SOCP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_SOCM,
-		.map	= &mtl_socm_reg_map,
-	},
-	{
-		.guid	= IOEP_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEP,
-		.map	= &mtl_ioep_reg_map,
-	},
-	{
-		.guid	= IOEM_LPM_REQ_GUID,
-		.devid	= PMC_DEVID_IOEM,
-		.map	= &mtl_ioem_reg_map
-	},
-	{}
 };
 
 #define MTL_GNA_PCI_DEV	0x7e4c
@@ -995,35 +962,19 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 	int ret;
-	int func = 2;
-	bool ssram_init = true;
 
 	mtl_d3_fixup();
 
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = mtl_resume;
-	pmcdev->regmap_list = mtl_pmc_info_list;
-
-	/*
-	 * If ssram init fails use legacy method to at least get the
-	 * primary PMC
-	 */
-	ret = pmc_core_ssram_init(pmcdev, func);
-	if (ret) {
-		ssram_init = false;
-		dev_warn(&pmcdev->pdev->dev,
-			 "ssram init failed, %d, using legacy init\n", ret);
-		pmc->map = &mtl_socm_reg_map;
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
+
+	pmc->map = &mtl_socm_reg_map;
+	ret = get_primary_reg_base(pmc);
+	if (ret)
+		return ret;
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
 
-	if (ssram_init)
-		return pmc_core_ssram_get_lpm_reqs(pmcdev);
-
 	return 0;
 }
-- 
2.43.0


