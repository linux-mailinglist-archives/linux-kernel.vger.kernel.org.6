Return-Path: <linux-kernel+bounces-281564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449494D833
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DA81C229B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487516D4CA;
	Fri,  9 Aug 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnn2OR0Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA43169382;
	Fri,  9 Aug 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236419; cv=none; b=azWly+yM6ipkU/M0/p3e5qvQPPMI6CBpAUDv/ieffLgKeRPfVdrvmdMIZ+k3+ncNqScrT4jkvvWWM5hQjGyL/mTGaUwHTEoO1X1t+n63nOhxyunRaCC9kzXMc7w8jwA44zegay/IbSif9aly1x7QzNPm2fXHjQF3mxzL8xGpQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236419; c=relaxed/simple;
	bh=axQz0+8Q6xW2CzOtllS3yvKMB4dD9yQfdyxVwizH5Fs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOveRAJuxy0BYWHoDiJrFWUg7OYOTlsKqR0Qr65U9paxaLKpmMEQQn0J1j6dXmUDln4qBUFkQr7lKEs2D5BNE4F7prUnYeIGDaVzrghNpRB0usuxRTkf/g8sspBnvkQAVlRTnCfYTyFKb0lmejsdtRQSP1D3p43lqiRpHtc3sRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnn2OR0Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236417; x=1754772417;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=axQz0+8Q6xW2CzOtllS3yvKMB4dD9yQfdyxVwizH5Fs=;
  b=bnn2OR0Q98/C/nwGHcE/Z0Clq92bw8NlhTcz7xm1093ACQ9Qua2DN0Ud
   wVL/rURIZu1uoJAwEG/o2pKO6jOrgOtEKxqzhffbckCcz3d/F/Tbo2mvA
   inVCk30CbWClOOmsOnjU8a1HwN7GnsSgMJk2DEIAxzi5DU1P4+ERLeN73
   sI9Qirmu5xM2nRiCi0IxRf53AgA3nPhVidCSr1ejCVD2BxrkWgOXTfLfK
   +9Vg6VWd8PFa1PnMAftUgdXBpjb8x+mRht01ciHj8pYp5xDxPWxDXcTbI
   sgcv3QUaJXEYJEbHaROKrxNBEu/pkPhzLp54PVFNAAIX2R25XRB3saced
   g==;
X-CSE-ConnectionGUID: kSDHncw+RKCR69cbgV/n1Q==
X-CSE-MsgGUID: ZrRsEETMSU+SVdZKKt41CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819027"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819027"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:55 -0700
X-CSE-ConnectionGUID: vNdL/ODNRWiX+ZO8TYsMYw==
X-CSE-MsgGUID: i7euIzKPT2eXrNb2OdboQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650474"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:54 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] platform/x86:intel/pmt: Get PMC from SSRAM for available platforms
Date: Fri,  9 Aug 2024 13:46:33 -0700
Message-ID: <20240809204648.1124545-5-xi.pardee@linux.intel.com>
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

Add support to discover and achieve PMC information from Intel
SSRAM Telemetry driver for Meteor Lake, Lunar Lake and Arror Lake
platforms.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 34 +++++++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.h |  3 +++
 drivers/platform/x86/intel/pmc/lnl.c  | 26 ++++++++++++++++----
 drivers/platform/x86/intel/pmc/mtl.c  | 34 +++++++++++++++++++++++----
 4 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 4b824612f355..7a340b8c7b6a 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -640,6 +640,22 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+static struct pmc_info arl_pmc_info_list[] = {
+	{
+		.devid	= PMC_DEVID_MTL_IOEP,
+		.map	= &mtl_ioep_reg_map,
+	},
+	{
+		.devid	= PMC_DEVID_ARL_SOCS,
+		.map	= &arl_socs_reg_map,
+	},
+	{
+		.devid	= PMC_DEVID_ARL_PCHS,
+		.map	= &arl_pchs_reg_map,
+	},
+	{}
+};
+
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
 /*
@@ -669,10 +685,20 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = arl_resume;
 
-	pmc->map = &arl_socs_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
+	pmcdev->regmap_list = arl_pmc_info_list;
+	ret = pmc_core_ssram_get_reg_base(pmcdev);
+
+	/* Try again later after Intel PMC SSRAM Telemetry driver finishes probe */
+	if (ret == -EAGAIN)
+		return -EPROBE_DEFER;
+
+	/* If regbase not assigned, set map and discover using legacy method */
+	if (ret) {
+		pmc->map = &arl_socs_reg_map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 890caf558307..07f8c3070ab9 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -288,9 +288,12 @@ enum ppfear_regs {
 /* SSRAM PMC Device ID*/
 /* ARL */
 #define PMC_DEVID_ARL_SOCS	0xae7f
+#define PMC_DEVID_ARL_PCHS	0x7f27
 
 /* MTL */
 #define PMC_DEVID_MTL_SOCM	0x7e7f
+#define PMC_DEVID_MTL_IOEP	0x7ecf
+#define PMC_DEVID_MTL_IOEM	0x7ebf
 
 /* LNL */
 #define PMC_DEVID_LNL_SOCM	0xa87f
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index e7a8077d1a3e..109b08d43fc8 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,6 +13,14 @@
 
 #include "core.h"
 
+static struct pmc_info lnl_pmc_info_list[] = {
+	{
+		.devid	= PMC_DEVID_LNL_SOCM,
+		.map	= &lnl_socm_reg_map,
+	},
+	{}
+};
+
 const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -561,10 +569,20 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = lnl_resume;
 
-	pmc->map = &lnl_socm_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
+	pmcdev->regmap_list = lnl_pmc_info_list;
+	ret = pmc_core_ssram_get_reg_base(pmcdev);
+
+	/* Try again later after Intel PMC SSRAM Telemetry driver finishes probe */
+	if (ret == -EAGAIN)
+		return -EPROBE_DEFER;
+
+	/* If regbase not assigned, set map and discover using legacy method */
+	if (ret) {
+		pmc->map = &lnl_socm_reg_map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
 
 	pmc_core_get_low_power_modes(pmcdev);
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 0b9efab21d60..86f8c2a24825 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -936,6 +936,22 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
 	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
 };
 
+static struct pmc_info mtl_pmc_info_list[] = {
+	{
+		.devid	= PMC_DEVID_MTL_SOCM,
+		.map	= &mtl_socm_reg_map,
+	},
+	{
+		.devid	= PMC_DEVID_MTL_IOEP,
+		.map	= &mtl_ioep_reg_map,
+	},
+	{
+		.devid	= PMC_DEVID_MTL_IOEM,
+		.map	= &mtl_ioem_reg_map
+	},
+	{}
+};
+
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -968,10 +984,20 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = mtl_resume;
 
-	pmc->map = &mtl_socm_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
+	pmcdev->regmap_list = mtl_pmc_info_list;
+	ret = pmc_core_ssram_get_reg_base(pmcdev);
+
+	/* Try again later after Intel PMC SSRAM Telemetry driver finishes probe */
+	if (ret == -EAGAIN)
+		return -EPROBE_DEFER;
+
+	/* If regbase not assigned, set map and discover using legacy method */
+	if (ret) {
+		pmc->map = &mtl_socm_reg_map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
 
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
-- 
2.43.0


