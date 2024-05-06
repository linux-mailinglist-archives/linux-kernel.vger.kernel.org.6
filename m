Return-Path: <linux-kernel+bounces-169297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDF8BC674
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEBD1C213B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32C47F78;
	Mon,  6 May 2024 04:17:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40D43AD4;
	Mon,  6 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969063; cv=none; b=eyLbKChgHk6Dlsz13nFdwhyYDvxC0eqlVu1jbMSfKXnMeKhSIlpe4EZQfWDwHxiiCL2KLu7PbpiE+8UufLxPuni2RSRoOjh/8N+5fKQ2FNpUQVlLFElb71qlW+aCBu8bfIj2GRfEy9qWJrALun8u9UEZevy7hzrK9lTGyHnQGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969063; c=relaxed/simple;
	bh=cuF4ShSYVujALPJHLQ/c5Aoi2MpWdkwrNf8KpGKxWgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XdHd/6YNQ6fQFZgaAH3FP+kHEiwmFxumfvEqLi8IFGJhFhBYbuY6s/bxKVj2dfISynSHLavx8P+U+L3yCncmam/27M/WauvKBnrqS7JRNVk+zWJcoW/vgy+Zm82ZkWcw1mXQOjYRoJ5X9qXagUIVQFQPQ944QuIVouALqpx/xiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49BA420095A;
	Mon,  6 May 2024 06:08:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F14A5200930;
	Mon,  6 May 2024 06:08:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ABBE9181D0F9;
	Mon,  6 May 2024 12:08:17 +0800 (+08)
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
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
Date: Mon,  6 May 2024 11:49:18 +0800
Message-Id: <1714967359-27905-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
References: <1714967359-27905-1-git-send-email-shengjiu.wang@nxp.com>
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
index 58630b521e67..6c888abcc6b5 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -348,12 +348,12 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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
@@ -396,7 +396,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
 
 	hw = devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
-				       0, base + SAI_PLL_GNRL_CTL, 13,
+				       CLK_SET_RATE_PARENT,
+				       base + SAI_PLL_GNRL_CTL, 13,
 				       0, NULL);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -405,7 +406,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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


