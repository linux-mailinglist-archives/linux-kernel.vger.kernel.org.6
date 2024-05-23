Return-Path: <linux-kernel+bounces-187322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551808CD02C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E020EB21F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD74144307;
	Thu, 23 May 2024 10:20:12 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D913CF85;
	Thu, 23 May 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459612; cv=none; b=M7vaxyfQgLWyEC5lla7yf1F4jeyxpg/xYKvSf8Rs9tx+yalLByMKOML+U0adXBTVgE0ukMC+QvgmYdvIVK/MQ45NzNDxDNiq+qNFPZ5ezaYMRWtjzEHz1zB6yTj1HsG4lLPy1bMX7iUchlITyKc92JL9sqyi+769StV1X/J53HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459612; c=relaxed/simple;
	bh=8JTKyZ/0SeVIZBbKW4ukbcW5JLX5SaWsiofypyn0zWg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=uXhsAqxPQkmQPMfJ3D4KNaAwNAffJ0Leyg/BS12HgelngSqcdjmMWWvymc7m5S3+OBrKIbnaaoudbUSAJs8xoH54na2rJUG645PB5ydCaSE37zC756WOKLuGaLrGtCATXrx52dlrC9KdrllV36hl1g+LkiJIzYwEIIMn85Y7JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC3E720085D;
	Thu, 23 May 2024 12:20:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8284F201292;
	Thu, 23 May 2024 12:20:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 37932180222C;
	Thu, 23 May 2024 18:20:06 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v5 4/5] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
Date: Thu, 23 May 2024 17:59:49 +0800
Message-Id: <1716458390-20120-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add CLK_SET_RATE_PARENT flags that when the device driver sets the
child clock rate, parent clock frequency can be refined accordingly.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 2ee68f518850..cef01f1fa0b4 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -325,12 +325,12 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(sels); i++) {
 		if (sels[i].num_parents == 1) {
 			hw = devm_clk_hw_register_gate_parent_data(dev,
-				sels[i].name, &sels[i].parent, 0,
+				sels[i].name, &sels[i].parent, CLK_SET_RATE_PARENT,
 				base + sels[i].reg, sels[i].shift, 0, NULL);
 		} else {
 			hw = devm_clk_hw_register_mux_parent_data_table(dev,
 				sels[i].name, sels[i].parents,
-				sels[i].num_parents, 0,
+				sels[i].num_parents, CLK_SET_RATE_PARENT,
 				base + sels[i].reg,
 				sels[i].shift, sels[i].width,
 				0, NULL, NULL);
@@ -373,7 +373,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
 
 	hw = devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
-				       0, base + SAI_PLL_GNRL_CTL, 13,
+				       CLK_SET_RATE_PARENT,
+				       base + SAI_PLL_GNRL_CTL, 13,
 				       0, NULL);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -382,7 +383,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT] = hw;
 
 	hw = devm_clk_hw_register_fixed_factor(dev, "sai_pll_out_div2",
-					       "sai_pll_out", 0, 1, 2);
+					       "sai_pll_out",
+					       CLK_SET_RATE_PARENT, 1, 2);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
 		goto err_clk_register;
-- 
2.34.1


