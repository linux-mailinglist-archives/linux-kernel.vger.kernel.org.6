Return-Path: <linux-kernel+bounces-178543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD38C4F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD01C20DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0913D89A;
	Tue, 14 May 2024 10:08:07 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF258AC4;
	Tue, 14 May 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681286; cv=none; b=o5g+z3a3k5lbUR513lL3tC4SCH4fv7SQIPZSdx+g3orQSFheKdxZ2kCQBC66XGufPhM2FfGAVKWLHtn7MQ/9gg/KgaLDOFQvtoqYHnUioHC7pBLCF/VhlNI68C/Y4C2IZ9SmQbknuIH3WzbP380N9Nl8qdRV7HKZFmyXdFNoOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681286; c=relaxed/simple;
	bh=SECeU/hWqv/TiUa66e4a5CsD04TBkyJmeXiGLL2YMfk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=BvHXHo7ujonxC5LUXDLvRyoFvfdRA1OotRU5KnA6X/Yf+oWmsXyqQoHEWwwLYIiGfoRUrVXzbOZLEk0Z+ukzrgEhyvkNF+r3YtnwYZusLrrCBveT97m/AjatVaE1VJzAopHoi5LAPrwn1DRO3xYBrCj2SgaIJn/qAH46XrqCn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC3DD1A18FA;
	Tue, 14 May 2024 11:53:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4AE01A191F;
	Tue, 14 May 2024 11:53:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D7F5180222C;
	Tue, 14 May 2024 17:52:59 +0800 (+08)
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
Subject: [PATCH v3 4/6] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
Date: Tue, 14 May 2024 17:33:28 +0800
Message-Id: <1715679210-9588-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
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
index b381d6f784c8..466b5b0d665c 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -269,12 +269,12 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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
@@ -317,7 +317,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
 
 	hw = devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
-				       0, base + SAI_PLL_GNRL_CTL, 13,
+				       CLK_SET_RATE_PARENT,
+				       base + SAI_PLL_GNRL_CTL, 13,
 				       0, NULL);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
@@ -326,7 +327,8 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
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


