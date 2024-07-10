Return-Path: <linux-kernel+bounces-247300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731892CDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF588282F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1817CA03;
	Wed, 10 Jul 2024 08:59:28 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69317B516;
	Wed, 10 Jul 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601968; cv=none; b=Kr69YyIokQOMQl3kDyHbwtnt3bCk3rJvt4DtkFlHjNEYXPbQr1Uk+ddztPOtf0MlepThSeHsVfPFz0YTZhEMNzNtCsuhD/tHPWstviV1bynWhwh47Z84qX2EntbOBB9TerlVxXyMpuTX0hwxA8UnV57YLI2cxvlQpk9ZSimA9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601968; c=relaxed/simple;
	bh=QR3vrdm6Tw0jXM4c95/q8aSOd5Fb+85TowCeTOlRDVQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=htBofsbi4pth4gTipxF/Abw5hopyXbTMYedPfcDe3uws3fUm5mPUVpmdbYhNpxtQ4y+oxBqvBo7Zh9r2Xhp7D84l1WnCqfKlW1ftGUq6mN53zxrly9YtLB19lUFYCnsQxPiSJzYqP3QEEH7Lb3b5BF25DB2qcEdCiVCRwD7MWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C52001A054C;
	Wed, 10 Jul 2024 10:59:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 625971A0543;
	Wed, 10 Jul 2024 10:59:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF2A6183487B;
	Wed, 10 Jul 2024 16:59:16 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: imx: imx8: Use clk_hw pointer for self registered clock in clk_parent_data
Date: Wed, 10 Jul 2024 16:41:00 +0800
Message-Id: <1720600860-18866-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

"acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
driver, but they are the parent clocks for other clocks, in order to
use assigned-clock-parents in device tree, the ".fw_name" can't be used,
need to assign the clk_hw pointer for the imx8qm_mclk_sels[],
imx8qxp_mclk_sels[], imx8dxl_mclk_sels[].

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---

changes in v2:
- don't use string name, but use the clk_hw pointer for "acm_aud_clk0_sel"
  and "acm_aud_clk1_sel"

 drivers/clk/imx/clk-imx8-acm.c | 38 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1bdb480cc96c..61d8c7e9ae0b 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -54,10 +54,12 @@ struct clk_imx8_acm_sel {
  * struct imx8_acm_soc_data - soc specific data
  * @sels: pointer to struct clk_imx8_acm_sel
  * @num_sels: numbers of items
+ * @mclk_sels: pointer to imx8qm/qxp/dxl_mclk_sels
  */
 struct imx8_acm_soc_data {
 	struct clk_imx8_acm_sel *sels;
 	unsigned int num_sels;
+	struct clk_parent_data *mclk_sels;
 };
 
 /**
@@ -111,11 +113,14 @@ static const struct clk_parent_data imx8qm_mclk_out_sels[] = {
 	{ .fw_name = "sai6_rx_bclk" },
 };
 
-static const struct clk_parent_data imx8qm_mclk_sels[] = {
+#define ACM_AUD_CLK0_SEL_INDEX  2
+#define ACM_AUD_CLK1_SEL_INDEX  3
+
+static struct clk_parent_data imx8qm_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{  }, /* clk_hw pointer of "acm_aud_clk0_sel" */
+	{  }, /* clk_hw pointer of "acm_aud_clk1_sel" */
 };
 
 static const struct clk_parent_data imx8qm_asrc_mux_clk_sels[] = {
@@ -176,11 +181,11 @@ static const struct clk_parent_data imx8qxp_mclk_out_sels[] = {
 	{ .fw_name = "sai4_rx_bclk" },
 };
 
-static const struct clk_parent_data imx8qxp_mclk_sels[] = {
+static struct clk_parent_data imx8qxp_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{  }, /* clk_hw pointer of "acm_aud_clk0_sel" */
+	{  }, /* clk_hw pointer of "acm_aud_clk1_sel" */
 };
 
 static struct clk_imx8_acm_sel imx8qxp_sels[] = {
@@ -228,11 +233,11 @@ static const struct clk_parent_data imx8dxl_mclk_out_sels[] = {
 	{ .index = -1 },
 };
 
-static const struct clk_parent_data imx8dxl_mclk_sels[] = {
+static struct clk_parent_data imx8dxl_mclk_sels[] = {
 	{ .fw_name = "aud_pll_div_clk0_lpcg_clk" },
 	{ .fw_name = "aud_pll_div_clk1_lpcg_clk" },
-	{ .fw_name = "acm_aud_clk0_sel" },
-	{ .fw_name = "acm_aud_clk1_sel" },
+	{  }, /* clk_hw pointer of "acm_aud_clk0_sel" */
+	{  }, /* clk_hw pointer of "acm_aud_clk1_sel" */
 };
 
 static struct clk_imx8_acm_sel imx8dxl_sels[] = {
@@ -375,6 +380,18 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 			imx_check_clk_hws(hws, IMX_ADMA_ACM_CLK_END);
 			goto err_clk_register;
 		}
+
+		/*
+		 * The IMX_ADMA_ACM_AUD_CLK0_SEL and IMX_ADMA_ACM_AUD_CLK1_SEL are
+		 * registered first. After registration, update the clk_hw pointer
+		 * to imx8qm/qxp/dxl_mclk_sels structures.
+		 */
+		if (sels[i].clkid == IMX_ADMA_ACM_AUD_CLK0_SEL)
+			priv->soc_data->mclk_sels[ACM_AUD_CLK0_SEL_INDEX].hw =
+								hws[IMX_ADMA_ACM_AUD_CLK0_SEL];
+		if (sels[i].clkid == IMX_ADMA_ACM_AUD_CLK1_SEL)
+			priv->soc_data->mclk_sels[ACM_AUD_CLK1_SEL_INDEX].hw =
+								hws[IMX_ADMA_ACM_AUD_CLK1_SEL];
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
@@ -406,16 +423,19 @@ static void imx8_acm_clk_remove(struct platform_device *pdev)
 static const struct imx8_acm_soc_data imx8qm_acm_data = {
 	.sels = imx8qm_sels,
 	.num_sels = ARRAY_SIZE(imx8qm_sels),
+	.mclk_sels = imx8qm_mclk_sels,
 };
 
 static const struct imx8_acm_soc_data imx8qxp_acm_data = {
 	.sels = imx8qxp_sels,
 	.num_sels = ARRAY_SIZE(imx8qxp_sels),
+	.mclk_sels = imx8qxp_mclk_sels,
 };
 
 static const struct imx8_acm_soc_data imx8dxl_acm_data = {
 	.sels = imx8dxl_sels,
 	.num_sels = ARRAY_SIZE(imx8dxl_sels),
+	.mclk_sels = imx8dxl_mclk_sels,
 };
 
 static const struct of_device_id imx8_acm_match[] = {
-- 
2.34.1


