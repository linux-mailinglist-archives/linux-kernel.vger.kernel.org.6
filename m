Return-Path: <linux-kernel+bounces-174048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840C8C099A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57412810DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A613D269;
	Thu,  9 May 2024 02:03:40 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423C13CF9D;
	Thu,  9 May 2024 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220219; cv=none; b=O3V90jHFqGzagtyJwwVnK5gI5md1ckL08m6A06iYKLdmx2f1i7qz3qmL/bSgsLvNMl9CID3h9FiehaYBPTfr0cmYzqMtKjjVn0GykRoXBvac8yHtvmLBEkW3oYuPxpEG3g5JAC4z7ZfkW+IEEj3Du6G+wBO62Z+JWOvxQKQM6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220219; c=relaxed/simple;
	bh=OVs+Y2ThZkMlLhMXiwc9wDKzZBMnQZpqVmGK/YgZWqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aZAHFiXel/9QFB4ws1ZSSoraUAIGqd7l9ggKSVgykn9YzWY1Jnb26wirSYW2Rz3V3CNnCHim3MgGq7AYSVS9rPdjDcZLKnHqVjDtPV5O9OiH/IrKR1bdc69X8LB0R9lLlZYbc0XNLdCPrGz8uOj0DznjYQ/FIKTMZQ5JAMAW7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6196D201ED4;
	Thu,  9 May 2024 04:03:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 256A920185F;
	Thu,  9 May 2024 04:03:31 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 195B3181D0FD;
	Thu,  9 May 2024 10:03:29 +0800 (+08)
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
Subject: [PATCH v2 3/4] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
Date: Thu,  9 May 2024 09:43:57 +0800
Message-Id: <1715219038-32453-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com>
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
index e84365cef71b..6ed44cd5001b 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -347,12 +347,12 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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
@@ -395,7 +395,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
 
 	hw = devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
-				       0, base + SAI_PLL_GNRL_CTL, 13,
+				       CLK_SET_RATE_PARENT,
+				       base + SAI_PLL_GNRL_CTL, 13,
 				       0, NULL);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -404,7 +405,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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


