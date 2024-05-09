Return-Path: <linux-kernel+bounces-174088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082128C0A18
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715711F23264
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242A146D71;
	Thu,  9 May 2024 03:18:48 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3841148828;
	Thu,  9 May 2024 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224727; cv=none; b=XMPJclCLdYP3dmw9HP8/vMUcQ1imQzZHRl5GdtbviGeIMo1oyBVxoP24YXFhNgBptmTpWrhAxLTZJm8t8Q5Cm7Fe4rEi6DO6JKlYO956t3TXpoCQs5ERAPZFU1w3ErO1hkli47Gu620nMdejSzySc2LeCDeN/8e3Wg/Aneb2MIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224727; c=relaxed/simple;
	bh=zkn2U5Dn/Ax3O7GpVyBbtoa+H+obFnYJJlCCzDb7A1I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Wq2zCuPYnS9la6yzDFP8+wXTs+Ti3014SUBUzH+3xKviOgp64anUDBrlq8f9ibthfFdnoXKoUkfpySQIOhwT5R0yfzZbWiQ/XJ+Ed4jI6rRto3N3FRdDKe2dkrxkyEhE+LBsCaZtf1wvRQ1/DZMMFF/R2IP8OvZC4N95JUJVRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 383F72007D5;
	Thu,  9 May 2024 05:18:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A54E6200AB5;
	Thu,  9 May 2024 05:18:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BB97180222F;
	Thu,  9 May 2024 11:18:41 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] ASoC: fsl_xcvr: Add support for i.MX95 platform
Date: Thu,  9 May 2024 10:57:40 +0800
Message-Id: <1715223460-32662-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On i.MX95, the XCVR uses a new PLL in the PHY, which is
General Purpose (GP) PLL. Add GP PLL configuration support
in the driver and add the 'pll_ver' flag to distinguish
different PLL on different platforms.

The XCVR also use PHY but limited for SPDIF only case
Add 'use_phy' flag to distinguish these platforms.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 120 +++++++++++++++++++++++++--------------
 sound/soc/fsl/fsl_xcvr.h |  91 +++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 43 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 0ffa10e924ef..6b1715ac67c5 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -20,10 +20,17 @@
 
 #define FSL_XCVR_CAPDS_SIZE	256
 
+enum fsl_xcvr_pll_verison {
+	PLL_MX8MP,
+	PLL_MX95,
+};
+
 struct fsl_xcvr_soc_data {
 	const char *fw_name;
 	bool spdif_only;
 	bool use_edma;
+	bool use_phy;
+	enum fsl_xcvr_pll_verison pll_ver;
 };
 
 struct fsl_xcvr {
@@ -265,10 +272,10 @@ static int fsl_xcvr_ai_write(struct fsl_xcvr *xcvr, u8 reg, u32 data, bool phy)
 static int fsl_xcvr_en_phy_pll(struct fsl_xcvr *xcvr, u32 freq, bool tx)
 {
 	struct device *dev = &xcvr->pdev->dev;
-	u32 i, div = 0, log2;
+	u32 i, div = 0, log2, val;
 	int ret;
 
-	if (xcvr->soc_data->spdif_only)
+	if (!xcvr->soc_data->use_phy)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(fsl_xcvr_pll_cfg); i++) {
@@ -291,45 +298,62 @@ static int fsl_xcvr_en_phy_pll(struct fsl_xcvr *xcvr, u32 freq, bool tx)
 		return ret;
 	}
 
-	/* PLL: BANDGAP_SET: EN_VBG (enable bandgap) */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_BANDGAP_SET,
-			  FSL_XCVR_PLL_BANDGAP_EN_VBG, 0);
-
-	/* PLL: CTRL0: DIV_INTEGER */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0, fsl_xcvr_pll_cfg[i].mfi, 0);
-	/* PLL: NUMERATOR: MFN */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_NUM, fsl_xcvr_pll_cfg[i].mfn, 0);
-	/* PLL: DENOMINATOR: MFD */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_DEN, fsl_xcvr_pll_cfg[i].mfd, 0);
-	/* PLL: CTRL0_SET: HOLD_RING_OFF, POWER_UP */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
-			  FSL_XCVR_PLL_CTRL0_HROFF | FSL_XCVR_PLL_CTRL0_PWP, 0);
-	udelay(25);
-	/* PLL: CTRL0: Clear Hold Ring Off */
-	fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_CLR,
-			  FSL_XCVR_PLL_CTRL0_HROFF, 0);
-	udelay(100);
-	if (tx) { /* TX is enabled for SPDIF only */
-		/* PLL: POSTDIV: PDIV0 */
-		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
-				  FSL_XCVR_PLL_PDIVx(log2, 0), 0);
-		/* PLL: CTRL_SET: CLKMUX0_EN */
-		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
-				  FSL_XCVR_PLL_CTRL0_CM0_EN, 0);
-	} else if (xcvr->mode == FSL_XCVR_MODE_EARC) { /* eARC RX */
-		/* PLL: POSTDIV: PDIV1 */
-		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
-				  FSL_XCVR_PLL_PDIVx(log2, 1), 0);
-		/* PLL: CTRL_SET: CLKMUX1_EN */
-		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
-				  FSL_XCVR_PLL_CTRL0_CM1_EN, 0);
-	} else { /* SPDIF / ARC RX */
-		/* PLL: POSTDIV: PDIV2 */
-		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
-				  FSL_XCVR_PLL_PDIVx(log2, 2), 0);
-		/* PLL: CTRL_SET: CLKMUX2_EN */
+	switch (xcvr->soc_data->pll_ver) {
+	case PLL_MX8MP:
+		/* PLL: BANDGAP_SET: EN_VBG (enable bandgap) */
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_BANDGAP_SET,
+				  FSL_XCVR_PLL_BANDGAP_EN_VBG, 0);
+
+		/* PLL: CTRL0: DIV_INTEGER */
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0, fsl_xcvr_pll_cfg[i].mfi, 0);
+		/* PLL: NUMERATOR: MFN */
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_NUM, fsl_xcvr_pll_cfg[i].mfn, 0);
+		/* PLL: DENOMINATOR: MFD */
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_DEN, fsl_xcvr_pll_cfg[i].mfd, 0);
+		/* PLL: CTRL0_SET: HOLD_RING_OFF, POWER_UP */
 		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
-				  FSL_XCVR_PLL_CTRL0_CM2_EN, 0);
+				  FSL_XCVR_PLL_CTRL0_HROFF | FSL_XCVR_PLL_CTRL0_PWP, 0);
+		udelay(25);
+		/* PLL: CTRL0: Clear Hold Ring Off */
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_CLR,
+				  FSL_XCVR_PLL_CTRL0_HROFF, 0);
+		udelay(100);
+		if (tx) { /* TX is enabled for SPDIF only */
+			/* PLL: POSTDIV: PDIV0 */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
+					  FSL_XCVR_PLL_PDIVx(log2, 0), 0);
+			/* PLL: CTRL_SET: CLKMUX0_EN */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
+					  FSL_XCVR_PLL_CTRL0_CM0_EN, 0);
+		} else if (xcvr->mode == FSL_XCVR_MODE_EARC) { /* eARC RX */
+			/* PLL: POSTDIV: PDIV1 */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
+					  FSL_XCVR_PLL_PDIVx(log2, 1), 0);
+			/* PLL: CTRL_SET: CLKMUX1_EN */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
+					  FSL_XCVR_PLL_CTRL0_CM1_EN, 0);
+		} else { /* SPDIF / ARC RX */
+			/* PLL: POSTDIV: PDIV2 */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_PDIV,
+					  FSL_XCVR_PLL_PDIVx(log2, 2), 0);
+			/* PLL: CTRL_SET: CLKMUX2_EN */
+			fsl_xcvr_ai_write(xcvr, FSL_XCVR_PLL_CTRL0_SET,
+					  FSL_XCVR_PLL_CTRL0_CM2_EN, 0);
+		}
+		break;
+	case PLL_MX95:
+		val = fsl_xcvr_pll_cfg[i].mfi << FSL_XCVR_GP_PLL_DIV_MFI_SHIFT | div;
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_GP_PLL_DIV, val, 0);
+		val = fsl_xcvr_pll_cfg[i].mfn << FSL_XCVR_GP_PLL_NUMERATOR_MFN_SHIFT;
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_GP_PLL_NUMERATOR, val, 0);
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_GP_PLL_DENOMINATOR,
+				  fsl_xcvr_pll_cfg[i].mfd, 0);
+		val = FSL_XCVR_GP_PLL_CTRL_POWERUP | FSL_XCVR_GP_PLL_CTRL_CLKMUX_EN;
+		fsl_xcvr_ai_write(xcvr, FSL_XCVR_GP_PLL_CTRL, val, 0);
+		break;
+	default:
+		dev_err(dev, "Error for PLL version %d\n", xcvr->soc_data->pll_ver);
+		return -EINVAL;
 	}
 
 	if (xcvr->mode == FSL_XCVR_MODE_EARC) { /* eARC mode */
@@ -378,7 +402,7 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 		return ret;
 	}
 
-	if (xcvr->soc_data->spdif_only)
+	if (!xcvr->soc_data->use_phy)
 		return 0;
 	/* Release AI interface from reset */
 	ret = regmap_write(xcvr->regmap, FSL_XCVR_PHY_AI_CTRL_SET,
@@ -1022,7 +1046,7 @@ static bool fsl_xcvr_readable_reg(struct device *dev, unsigned int reg)
 {
 	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
 
-	if (xcvr->soc_data->spdif_only)
+	if (!xcvr->soc_data->use_phy)
 		if ((reg >= FSL_XCVR_IER && reg <= FSL_XCVR_PHY_AI_RDATA) ||
 		    reg > FSL_XCVR_TX_DPTH_BCRR)
 			return false;
@@ -1095,7 +1119,7 @@ static bool fsl_xcvr_writeable_reg(struct device *dev, unsigned int reg)
 {
 	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
 
-	if (xcvr->soc_data->spdif_only)
+	if (!xcvr->soc_data->use_phy)
 		if (reg >= FSL_XCVR_IER && reg <= FSL_XCVR_PHY_AI_RDATA)
 			return false;
 	switch (reg) {
@@ -1239,6 +1263,8 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 
 static const struct fsl_xcvr_soc_data fsl_xcvr_imx8mp_data = {
 	.fw_name = "imx/xcvr/xcvr-imx8mp.bin",
+	.use_phy = true,
+	.pll_ver = PLL_MX8MP,
 };
 
 static const struct fsl_xcvr_soc_data fsl_xcvr_imx93_data = {
@@ -1246,9 +1272,17 @@ static const struct fsl_xcvr_soc_data fsl_xcvr_imx93_data = {
 	.use_edma = true,
 };
 
+static const struct fsl_xcvr_soc_data fsl_xcvr_imx95_data = {
+	.spdif_only = true,
+	.use_phy = true,
+	.use_edma = true,
+	.pll_ver = PLL_MX95,
+};
+
 static const struct of_device_id fsl_xcvr_dt_ids[] = {
 	{ .compatible = "fsl,imx8mp-xcvr", .data = &fsl_xcvr_imx8mp_data },
 	{ .compatible = "fsl,imx93-xcvr", .data = &fsl_xcvr_imx93_data},
+	{ .compatible = "fsl,imx95-xcvr", .data = &fsl_xcvr_imx95_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_xcvr_dt_ids);
diff --git a/sound/soc/fsl/fsl_xcvr.h b/sound/soc/fsl/fsl_xcvr.h
index 044058fc6aa2..882428592e1a 100644
--- a/sound/soc/fsl/fsl_xcvr.h
+++ b/sound/soc/fsl/fsl_xcvr.h
@@ -291,4 +291,95 @@
 #define FSL_XCVR_RX_CS_BUFF_1		0xA0 /* Second RX CS buffer */
 #define FSL_XCVR_CAP_DATA_STR		0x300 /* Capabilities data structure */
 
+/* GP PLL Registers */
+#define FSL_XCVR_GP_PLL_CTRL			0x00
+#define FSL_XCVR_GP_PLL_CTRL_SET		0x04
+#define FSL_XCVR_GP_PLL_CTRL_CLR		0x08
+#define FSL_XCVR_GP_PLL_CTRL_TOG		0x0C
+#define FSL_XCVR_GP_PLL_ANA_PRG			0x10
+#define FSL_XCVR_GP_PLL_ANA_PRG_SET		0x14
+#define FSL_XCVR_GP_PLL_ANA_PRG_CLR		0x18
+#define FSL_XCVR_GP_PLL_ANA_PRG_TOG		0x1C
+#define FSL_XCVR_GP_PLL_TEST			0x20
+#define FSL_XCVR_GP_PLL_TEST_SET		0x24
+#define FSL_XCVR_GP_PLL_TEST_CLR		0x28
+#define FSL_XCVR_GP_PLL_TEST_TOG		0x2C
+#define FSL_XCVR_GP_PLL_SPREAD_SPECTRUM		0x30
+#define FSL_XCVR_GP_PLL_SPREAD_SPECTRUM_SET	0x34
+#define FSL_XCVR_GP_PLL_SPREAD_SPECTRUM_CLR	0x38
+#define FSL_XCVR_GP_PLL_SPREAD_SPECTRUM_TOG	0x3C
+#define FSL_XCVR_GP_PLL_NUMERATOR		0x40
+#define FSL_XCVR_GP_PLL_NUMERATOR_SET		0x44
+#define FSL_XCVR_GP_PLL_NUMERATOR_CLR		0x48
+#define FSL_XCVR_GP_PLL_NUMERATOR_TOG		0x4C
+#define FSL_XCVR_GP_PLL_DENOMINATOR		0x50
+#define FSL_XCVR_GP_PLL_DENOMINATOR_SET		0x54
+#define FSL_XCVR_GP_PLL_DENOMINATOR_CLR		0x58
+#define FSL_XCVR_GP_PLL_DENOMINATOR_TOG		0x5C
+#define FSL_XCVR_GP_PLL_DIV			0x60
+#define FSL_XCVR_GP_PLL_DIV_SET			0x64
+#define FSL_XCVR_GP_PLL_DIV_CLR			0x68
+#define FSL_XCVR_GP_PLL_DIV_TOG			0x6C
+#define FSL_XCVR_GP_PLL_DFS_CTRL0		0x70
+#define FSL_XCVR_GP_PLL_DFS_CTRL0_SET		0x74
+#define FSL_XCVR_GP_PLL_DFS_CTRL0_CLR		0x78
+#define FSL_XCVR_GP_PLL_DFS_CTRL0_TOG		0x7C
+#define FSL_XCVR_GP_PLL_DFS_DIV0		0x80
+#define FSL_XCVR_GP_PLL_DFS_DIV0_SET		0x84
+#define FSL_XCVR_GP_PLL_DFS_DIV0_CLR		0x88
+#define FSL_XCVR_GP_PLL_DFS_DIV0_TOG		0x8C
+#define FSL_XCVR_GP_PLL_DFS_CTRL1		0x90
+#define FSL_XCVR_GP_PLL_DFS_CTRL1_SET		0x94
+#define FSL_XCVR_GP_PLL_DFS_CTRL1_CLR		0x98
+#define FSL_XCVR_GP_PLL_DFS_CTRL1_TOG		0x9C
+#define FSL_XCVR_GP_PLL_DFS_DIV1		0xA0
+#define FSL_XCVR_GP_PLL_DFS_DIV1_SET		0xA4
+#define FSL_XCVR_GP_PLL_DFS_DIV1_CLR		0xA8
+#define FSL_XCVR_GP_PLL_DFS_DIV1_TOG		0xAC
+#define FSL_XCVR_GP_PLL_DFS_CTRL2		0xB0
+#define FSL_XCVR_GP_PLL_DFS_CTRL2_SET		0xB4
+#define FSL_XCVR_GP_PLL_DFS_CTRL2_CLR		0xB8
+#define FSL_XCVR_GP_PLL_DFS_CTRL2_TOG		0xBC
+#define FSL_XCVR_GP_PLL_DFS_DIV2		0xC0
+#define FSL_XCVR_GP_PLL_DFS_DIV2_SET		0xC4
+#define FSL_XCVR_GP_PLL_DFS_DIV2_CLR		0xC8
+#define FSL_XCVR_GP_PLL_DFS_DIV2_TOG		0xCC
+#define FSL_XCVR_GP_PLL_DFS_CTRL3		0xD0
+#define FSL_XCVR_GP_PLL_DFS_CTRL3_SET		0xD4
+#define FSL_XCVR_GP_PLL_DFS_CTRL3_CLR		0xD8
+#define FSL_XCVR_GP_PLL_DFS_CTRL3_TOG		0xDC
+#define FSL_XCVR_GP_PLL_DFS_DIV3		0xE0
+#define FSL_XCVR_GP_PLL_DFS_DIV3_SET		0xE4
+#define FSL_XCVR_GP_PLL_DFS_DIV3_CLR		0xE8
+#define FSL_XCVR_GP_PLL_DFS_DIV3_TOG		0xEC
+#define FSL_XCVR_GP_PLL_STATUS			0xF0
+#define FSL_XCVR_GP_PLL_STATUS_SET		0xF4
+#define FSL_XCVR_GP_PLL_STATUS_CLR		0xF8
+#define FSL_XCVR_GP_PLL_STATUS_TOG		0xFC
+
+/* GP PLL Control Register */
+#define FSL_XCVR_GP_PLL_CTRL_LBYPASS		BIT(31)
+#define FSL_XCVR_GP_PLL_CTRL_HCS		BIT(16)
+#define FSL_XCVR_GP_PLL_CTRL_MSD		BIT(12)
+#define FSL_XCVR_GP_PLL_CTRL_DITHER_EN3		BIT(11)
+#define FSL_XCVR_GP_PLL_CTRL_DITHER_EN2		BIT(10)
+#define FSL_XCVR_GP_PLL_CTRL_DITHER_EN1		BIT(9)
+#define FSL_XCVR_GP_PLL_CTRL_SPREADCTL		BIT(8)
+#define FSL_XCVR_GP_PLL_CTRL_CLKMUX_BYPASS	BIT(2)
+#define FSL_XCVR_GP_PLL_CTRL_CLKMUX_EN		BIT(1)
+#define FSL_XCVR_GP_PLL_CTRL_POWERUP		BIT(0)
+
+/* GP PLL Numerator Register */
+#define FSL_XCVR_GP_PLL_NUMERATOR_MFN_SHIFT	2
+#define FSL_XCVR_GP_PLL_NUMERATOR_MFN		GENMASK(31, 2)
+
+/* GP PLL Denominator Register */
+#define FSL_XCVR_GP_PLL_DENOMINATOR_MFD		GENMASK(29, 0)
+
+/* GP PLL Dividers Register */
+#define FSL_XCVR_GP_PLL_DIV_MFI_SHIFT		16
+#define FSL_XCVR_GP_PLL_DIV_MFI			GENMASK(24, 16)
+#define FSL_XCVR_GP_PLL_DIV_RDIV		GENMASK(15, 13)
+#define FSL_XCVR_GP_PLL_DIV_ODIV		GENMASK(7, 0)
+
 #endif /* __FSL_XCVR_H */
-- 
2.34.1


