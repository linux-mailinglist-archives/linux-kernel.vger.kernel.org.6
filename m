Return-Path: <linux-kernel+bounces-255032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F21933ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A1D1C212D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20AB17FABC;
	Wed, 17 Jul 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB0cznp9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5B17F387
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210683; cv=none; b=VFOCzDooGlqoORvlKMXoIfVBOFmCH86NSt/9mqux4Iq0a0QKdckyGyCu+vfCLD+y4WG2EV6qo48vs90Tis8pV0Vjkp/t2DYw0tD+EVo4kRVu+JlZ+iT1HqJo/DEzle3770DYsfEs3zNzrkJ42C7+Sutd/NTMySgscx8xGf4zRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210683; c=relaxed/simple;
	bh=3N6j5xYMSkSDjPk/3hdqKOhmpjdFz3yirqRzrJJVTOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBW5It2hJweZLLn7RxQo4PKb2LJMSEcQosz6TxBWrG1wl2MHCqESnu41uTCNR5fjGQHJN7n1er4v6M9Kg/CYrt8qCPWezcOkzJGYWg1DP0LzljJLWL7p9Y8gfjXAylUQZnZkTKVkT4CzZp7vDZkEdu2gNOOxolo5MSVziE8tbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HB0cznp9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so10776787e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210677; x=1721815477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaglgtgBjf+K7hShLXCzL/TDXcWcGfMqhjaiwVBTPZU=;
        b=HB0cznp9uNJMxthGapffMU4VzY/3PS5n2WcpnrRM2LS+46qqu4ezV4bnoRdb2sV3Bj
         Bk8uGrt/f0hQOBBgKD6SJBkP8PD7aUATWKyQD4Aye8b2XKmBKF/YJ+ao9Um7uhOcC+fc
         YlFqRFYgM9h3AKrgYWe0nThsUF1jOOnbQXRHe9BcV2EIcCEzoFUKDehS8TWa7xUxGDA8
         2/IFiOok0ef/O5fTxuGoEeSKO36Zw1ew6cY/UD2sgtfgqL0HXkS2Ax/AEEDGkLnjXTBr
         3tKnNFeEbZCW0tfkzUU0w2W+bP3FBE69ofKdu2R4HeOnhB/S90VRaAdHlaLJMRkzXhiR
         1rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210677; x=1721815477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaglgtgBjf+K7hShLXCzL/TDXcWcGfMqhjaiwVBTPZU=;
        b=Gm+YdhNxQ+8VGhMkMNggsBT9cJ3Rf3SU10k/0+Y/xrWY19vRy5kdJYpm9Hhi/q/Z/M
         Xbqbk9oXhPt2TJbGHJjYt7oUobednv1tkenJHfieqV8dvAgqBegTjJ1EmQIlsL3cFM1r
         SzmugdMD/FEHqqMknRABWh9vaPvWLpD8frvpJwTpDx51Km7t0zVUurczqIgB0F3KOYQr
         +CG6FSlNMHoMoApPm8V5iZilP3fOgjXmU6+/n0yh1egM/jSye9b8/mFeIiL5OP/klYLA
         15duEuzCTsNT9gpPRrWbPpstbtFlWG8wnyRTDdnWHq7+nI+s+8XdS2LL6AV7PT5GiWq4
         nX2g==
X-Forwarded-Encrypted: i=1; AJvYcCUIulHXls+hyw0Dea/R7SRlhBXkzOS/KljvqeFgYZphtISM7VMJjvve5YkWqtC2H1hKZ4ImgXP6P6tGcO3Jye/SSNZ1wSRTcN6y0q+r
X-Gm-Message-State: AOJu0YxpwAmfEP2MV0WU0h12PBlDsRFrNEtXygK+RUnbsBXGpEiDxOfK
	LWYXWvHuk3uOsMFbp6CVYBTNmousoUJLebboe1u2lmcLOCf49bV03yAcl9sUFqU=
X-Google-Smtp-Source: AGHT+IHITVcAkCMQmhM/lxkGhxT+UtgSKCR78hGtaI+vHWdXjDj+lsbxx+AmTup3nkcOpxQDhKo3Vg==
X-Received: by 2002:a05:6512:3da9:b0:52b:be6b:d16a with SMTP id 2adb3069b0e04-52ee53d7861mr1059248e87.31.1721210677004;
        Wed, 17 Jul 2024 03:04:37 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed253924asm1425391e87.262.2024.07.17.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:04:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:04:33 +0300
Subject: [PATCH v2 6/7] clk: qcom: fold dispcc-sm8650 info dispcc-sm8550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-dispcc-sm8550-fixes-v2-6-5c4a3128c40b@linaro.org>
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=58162;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3N6j5xYMSkSDjPk/3hdqKOhmpjdFz3yirqRzrJJVTOQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBml5cuTFokIG/ofExoMi6mvhZ91eKP9OVkRnTGZ
 7ayvjP+G12JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpeXLgAKCRCLPIo+Aiko
 1TfzB/9+2yqKym7XIZHFMVRANiqaT6c/uRvkoiB8H/USF8QH3SCtg5W03m5qW+opEncofygR1Pd
 3TPEf/CJTqEwHemSDI1PSWkKqhgy2HbnfgQM0tQCoxrD4VAX/TXNqSE/mU8z/jxSM3nn6sTXjps
 KZFkD+98gmYMC39TqRCv2GE9onAgHnF8dg31ZAfAEDwf27yFVXai1DoqMO7DJgCQmLDtPkD04mC
 B8oh69A123AWlVPeACNyemZfSjc9Xzr8GGv9QnnA6vPNUKP9mHp++PrkG6F+FZHxL9GaMc5DpUo
 Kous+KNR1J1H8k+Dp7WAdg0+L1oz0PV1dv+fmPz0fnQDXCmU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is a very minor difference between display clock controller
drivers for SM8550 and SM8650 platforms. Fold the second one into the
first one to reduce kernel footprint. The bindings for these two
hardware blocks are fully compatible.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig         |   14 +-
 drivers/clk/qcom/Makefile        |    1 -
 drivers/clk/qcom/dispcc-sm8550.c |   24 +-
 drivers/clk/qcom/dispcc-sm8650.c | 1796 --------------------------------------
 4 files changed, 24 insertions(+), 1811 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 11ae28430dad..497eed16a7d7 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -931,20 +931,10 @@ config SM_DISPCC_8450
 config SM_DISPCC_8550
 	tristate "SM8550 Display Clock Controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on SM_GCC_8550
+	depends on SM_GCC_8550 || SM_GCC_8650
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
-	  SM8550 devices.
-	  Say Y if you want to support display devices and functionality such as
-	  splash screen.
-
-config SM_DISPCC_8650
-	tristate "SM8650 Display Clock Controller"
-	depends on ARM64 || COMPILE_TEST
-	select SM_GCC_8650
-	help
-	  Support for the display clock controller on Qualcomm Technologies, Inc
-	  SM8650 devices.
+	  SM8550 or SM8650 devices.
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen.
 
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 0de5fce6113a..c8149ef37fe0 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -121,7 +121,6 @@ obj-$(CONFIG_SM_DISPCC_7150) += dispcc-sm7150.o
 obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
 obj-$(CONFIG_SM_DISPCC_8450) += dispcc-sm8450.o
 obj-$(CONFIG_SM_DISPCC_8550) += dispcc-sm8550.o
-obj-$(CONFIG_SM_DISPCC_8650) += dispcc-sm8650.o
 obj-$(CONFIG_SM_GCC_4450) += gcc-sm4450.o
 obj-$(CONFIG_SM_GCC_6115) += gcc-sm6115.o
 obj-$(CONFIG_SM_GCC_6125) += gcc-sm6125.o
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1d884e30d461..7f9021ca0ecb 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -71,7 +71,7 @@ enum {
 	P_SLEEP_CLK,
 };
 
-static const struct pll_vco lucid_ole_vco[] = {
+static struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2000000000, 0 },
 };
 
@@ -594,6 +594,18 @@ static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src_sm8650[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(85714286, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(100000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(150000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(200000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(325000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(402000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(514000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 	.cmd_rcgr = 0x80d8,
 	.mnd_width = 0,
@@ -1739,6 +1751,7 @@ static struct qcom_cc_desc disp_cc_sm8550_desc = {
 
 static const struct of_device_id disp_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sm8550-dispcc" },
+	{ .compatible = "qcom,sm8650-dispcc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
@@ -1762,6 +1775,13 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-dispcc")) {
+		lucid_ole_vco[0].max_freq = 2100000000;
+		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sm8650;
+		disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr.hw.init->parent_hws[0] =
+			&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw;
+	}
+
 	clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
 
@@ -1795,5 +1815,5 @@ static struct platform_driver disp_cc_sm8550_driver = {
 
 module_platform_driver(disp_cc_sm8550_driver);
 
-MODULE_DESCRIPTION("QTI DISPCC SM8550 Driver");
+MODULE_DESCRIPTION("QTI DISPCC SM8550 / SM8650  Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
deleted file mode 100644
index ce563cf93235..000000000000
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ /dev/null
@@ -1,1796 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved
- * Copyright (c) 2023, Linaro Ltd.
- */
-
-#include <linux/clk-provider.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/regmap.h>
-
-#include <dt-bindings/clock/qcom,sm8650-dispcc.h>
-
-#include "common.h"
-#include "clk-alpha-pll.h"
-#include "clk-branch.h"
-#include "clk-pll.h"
-#include "clk-rcg.h"
-#include "clk-regmap.h"
-#include "clk-regmap-divider.h"
-#include "reset.h"
-#include "gdsc.h"
-
-/* Need to match the order of clocks in DT binding */
-enum {
-	DT_BI_TCXO,
-	DT_BI_TCXO_AO,
-	DT_AHB_CLK,
-	DT_SLEEP_CLK,
-
-	DT_DSI0_PHY_PLL_OUT_BYTECLK,
-	DT_DSI0_PHY_PLL_OUT_DSICLK,
-	DT_DSI1_PHY_PLL_OUT_BYTECLK,
-	DT_DSI1_PHY_PLL_OUT_DSICLK,
-
-	DT_DP0_PHY_PLL_LINK_CLK,
-	DT_DP0_PHY_PLL_VCO_DIV_CLK,
-	DT_DP1_PHY_PLL_LINK_CLK,
-	DT_DP1_PHY_PLL_VCO_DIV_CLK,
-	DT_DP2_PHY_PLL_LINK_CLK,
-	DT_DP2_PHY_PLL_VCO_DIV_CLK,
-	DT_DP3_PHY_PLL_LINK_CLK,
-	DT_DP3_PHY_PLL_VCO_DIV_CLK,
-};
-
-#define DISP_CC_MISC_CMD	0xF000
-
-enum {
-	P_BI_TCXO,
-	P_DISP_CC_PLL0_OUT_MAIN,
-	P_DISP_CC_PLL1_OUT_EVEN,
-	P_DISP_CC_PLL1_OUT_MAIN,
-	P_DP0_PHY_PLL_LINK_CLK,
-	P_DP0_PHY_PLL_VCO_DIV_CLK,
-	P_DP1_PHY_PLL_LINK_CLK,
-	P_DP1_PHY_PLL_VCO_DIV_CLK,
-	P_DP2_PHY_PLL_LINK_CLK,
-	P_DP2_PHY_PLL_VCO_DIV_CLK,
-	P_DP3_PHY_PLL_LINK_CLK,
-	P_DP3_PHY_PLL_VCO_DIV_CLK,
-	P_DSI0_PHY_PLL_OUT_BYTECLK,
-	P_DSI0_PHY_PLL_OUT_DSICLK,
-	P_DSI1_PHY_PLL_OUT_BYTECLK,
-	P_DSI1_PHY_PLL_OUT_DSICLK,
-	P_SLEEP_CLK,
-};
-
-static const struct pll_vco lucid_ole_vco[] = {
-	{ 249600000, 2100000000, 0 },
-};
-
-static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xd,
-	.alpha = 0x6492,
-	.config_ctl_val = 0x20485699,
-	.config_ctl_hi_val = 0x00182261,
-	.config_ctl_hi1_val = 0x82aa299c,
-	.test_ctl_val = 0x00000000,
-	.test_ctl_hi_val = 0x00000003,
-	.test_ctl_hi1_val = 0x00009000,
-	.test_ctl_hi2_val = 0x00000034,
-	.user_ctl_val = 0x00000000,
-	.user_ctl_hi_val = 0x00000005,
-};
-
-static struct clk_alpha_pll disp_cc_pll0 = {
-	.offset = 0x0,
-	.vco_table = lucid_ole_vco,
-	.num_vco = ARRAY_SIZE(lucid_ole_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
-	.clkr = {
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_pll0",
-			.parent_data = &(const struct clk_parent_data) {
-				.index = DT_BI_TCXO,
-			},
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_reset_lucid_ole_ops,
-		},
-	},
-};
-
-static const struct alpha_pll_config disp_cc_pll1_config = {
-	.l = 0x1f,
-	.alpha = 0x4000,
-	.config_ctl_val = 0x20485699,
-	.config_ctl_hi_val = 0x00182261,
-	.config_ctl_hi1_val = 0x82aa299c,
-	.test_ctl_val = 0x00000000,
-	.test_ctl_hi_val = 0x00000003,
-	.test_ctl_hi1_val = 0x00009000,
-	.test_ctl_hi2_val = 0x00000034,
-	.user_ctl_val = 0x00000000,
-	.user_ctl_hi_val = 0x00000005,
-};
-
-static struct clk_alpha_pll disp_cc_pll1 = {
-	.offset = 0x1000,
-	.vco_table = lucid_ole_vco,
-	.num_vco = ARRAY_SIZE(lucid_ole_vco),
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
-	.clkr = {
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_pll1",
-			.parent_data = &(const struct clk_parent_data) {
-				.index = DT_BI_TCXO,
-			},
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_reset_lucid_ole_ops,
-		},
-	},
-};
-
-static const struct parent_map disp_cc_parent_map_0[] = {
-	{ P_BI_TCXO, 0 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_0[] = {
-	{ .index = DT_BI_TCXO },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_0_ao[] = {
-	{ .index = DT_BI_TCXO_AO },
-};
-
-static const struct parent_map disp_cc_parent_map_1[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
-	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
-	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_1[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
-	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
-	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
-};
-
-static const struct parent_map disp_cc_parent_map_2[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
-	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
-	{ P_DSI1_PHY_PLL_OUT_DSICLK, 3 },
-	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_2[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DSI0_PHY_PLL_OUT_DSICLK },
-	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
-	{ .index = DT_DSI1_PHY_PLL_OUT_DSICLK },
-	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
-};
-
-static const struct parent_map disp_cc_parent_map_3[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DP1_PHY_PLL_LINK_CLK, 2 },
-	{ P_DP2_PHY_PLL_LINK_CLK, 3 },
-	{ P_DP3_PHY_PLL_LINK_CLK, 4 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_3[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
-};
-
-static const struct parent_map disp_cc_parent_map_4[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
-	{ P_DP0_PHY_PLL_VCO_DIV_CLK, 2 },
-	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
-	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
-	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_4[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP0_PHY_PLL_VCO_DIV_CLK },
-	{ .index = DT_DP3_PHY_PLL_VCO_DIV_CLK },
-	{ .index = DT_DP1_PHY_PLL_VCO_DIV_CLK },
-	{ .index = DT_DP2_PHY_PLL_VCO_DIV_CLK },
-};
-
-static const struct parent_map disp_cc_parent_map_5[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
-	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_5[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DSI0_PHY_PLL_OUT_BYTECLK },
-	{ .index = DT_DSI1_PHY_PLL_OUT_BYTECLK },
-};
-
-static const struct parent_map disp_cc_parent_map_6[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DISP_CC_PLL1_OUT_MAIN, 4 },
-	{ P_DISP_CC_PLL1_OUT_EVEN, 6 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_6[] = {
-	{ .index = DT_BI_TCXO },
-	{ .hw = &disp_cc_pll1.clkr.hw },
-	{ .hw = &disp_cc_pll1.clkr.hw },
-};
-
-static const struct parent_map disp_cc_parent_map_7[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
-	{ P_DP1_PHY_PLL_LINK_CLK, 2 },
-	{ P_DP2_PHY_PLL_LINK_CLK, 3 },
-	{ P_DP3_PHY_PLL_LINK_CLK, 4 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_7[] = {
-	{ .index = DT_BI_TCXO },
-	{ .index = DT_DP0_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP1_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP2_PHY_PLL_LINK_CLK },
-	{ .index = DT_DP3_PHY_PLL_LINK_CLK },
-};
-
-static const struct parent_map disp_cc_parent_map_8[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_DISP_CC_PLL0_OUT_MAIN, 1 },
-	{ P_DISP_CC_PLL1_OUT_MAIN, 4 },
-	{ P_DISP_CC_PLL1_OUT_EVEN, 6 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_8[] = {
-	{ .index = DT_BI_TCXO },
-	{ .hw = &disp_cc_pll0.clkr.hw },
-	{ .hw = &disp_cc_pll1.clkr.hw },
-	{ .hw = &disp_cc_pll1.clkr.hw },
-};
-
-static const struct parent_map disp_cc_parent_map_9[] = {
-	{ P_SLEEP_CLK, 0 },
-};
-
-static const struct clk_parent_data disp_cc_parent_data_9[] = {
-	{ .index = DT_SLEEP_CLK },
-};
-
-static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
-	F(37500000, P_DISP_CC_PLL1_OUT_MAIN, 16, 0, 0),
-	F(75000000, P_DISP_CC_PLL1_OUT_MAIN, 8, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
-	.cmd_rcgr = 0x82e8,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_6,
-	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_ahb_clk_src",
-		.parent_data = disp_cc_parent_data_6,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static const struct freq_tbl ftbl_disp_cc_mdss_byte0_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
-	.cmd_rcgr = 0x8108,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_2,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_byte0_clk_src",
-		.parent_data = disp_cc_parent_data_2,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
-	.cmd_rcgr = 0x8124,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_2,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_byte1_clk_src",
-		.parent_data = disp_cc_parent_data_2,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
-	.cmd_rcgr = 0x81bc,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx0_aux_clk_src",
-		.parent_data = disp_cc_parent_data_0,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
-	.cmd_rcgr = 0x8170,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_7,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx0_link_clk_src",
-		.parent_data = disp_cc_parent_data_7,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx0_pixel0_clk_src = {
-	.cmd_rcgr = 0x818c,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_4,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx0_pixel0_clk_src",
-		.parent_data = disp_cc_parent_data_4,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx0_pixel1_clk_src = {
-	.cmd_rcgr = 0x81a4,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_4,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx0_pixel1_clk_src",
-		.parent_data = disp_cc_parent_data_4,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
-	.cmd_rcgr = 0x8220,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx1_aux_clk_src",
-		.parent_data = disp_cc_parent_data_0,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
-	.cmd_rcgr = 0x8204,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_3,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx1_link_clk_src",
-		.parent_data = disp_cc_parent_data_3,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx1_pixel0_clk_src = {
-	.cmd_rcgr = 0x81d4,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_1,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx1_pixel0_clk_src",
-		.parent_data = disp_cc_parent_data_1,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx1_pixel1_clk_src = {
-	.cmd_rcgr = 0x81ec,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_1,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx1_pixel1_clk_src",
-		.parent_data = disp_cc_parent_data_1,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx2_aux_clk_src = {
-	.cmd_rcgr = 0x8284,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx2_aux_clk_src",
-		.parent_data = disp_cc_parent_data_0,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
-	.cmd_rcgr = 0x8238,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_3,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx2_link_clk_src",
-		.parent_data = disp_cc_parent_data_3,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx2_pixel0_clk_src = {
-	.cmd_rcgr = 0x8254,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_1,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx2_pixel0_clk_src",
-		.parent_data = disp_cc_parent_data_1,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx2_pixel1_clk_src = {
-	.cmd_rcgr = 0x826c,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_1,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx2_pixel1_clk_src",
-		.parent_data = disp_cc_parent_data_1,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx3_aux_clk_src = {
-	.cmd_rcgr = 0x82d0,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx3_aux_clk_src",
-		.parent_data = disp_cc_parent_data_0,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
-	.cmd_rcgr = 0x82b4,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_3,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx3_link_clk_src",
-		.parent_data = disp_cc_parent_data_3,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_byte2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_dptx3_pixel0_clk_src = {
-	.cmd_rcgr = 0x829c,
-	.mnd_width = 16,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_1,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx3_pixel0_clk_src",
-		.parent_data = disp_cc_parent_data_1,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
-	.cmd_rcgr = 0x8140,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_5,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_esc0_clk_src",
-		.parent_data = disp_cc_parent_data_5,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
-	.cmd_rcgr = 0x8158,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_5,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_esc1_clk_src",
-		.parent_data = disp_cc_parent_data_5,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
-	F(85714286, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(100000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(150000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(200000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(325000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(402000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	F(514000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
-	.cmd_rcgr = 0x80d8,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_8,
-	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_mdp_clk_src",
-		.parent_data = disp_cc_parent_data_8,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_8),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
-	.cmd_rcgr = 0x80a8,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_2,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_pclk0_clk_src",
-		.parent_data = disp_cc_parent_data_2,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_pixel_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
-	.cmd_rcgr = 0x80c0,
-	.mnd_width = 8,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_2,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_pclk1_clk_src",
-		.parent_data = disp_cc_parent_data_2,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_pixel_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
-	.cmd_rcgr = 0x80f0,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_vsync_clk_src",
-		.parent_data = disp_cc_parent_data_0,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static const struct freq_tbl ftbl_disp_cc_sleep_clk_src[] = {
-	F(32000, P_SLEEP_CLK, 1, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 disp_cc_sleep_clk_src = {
-	.cmd_rcgr = 0xe05c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_9,
-	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_sleep_clk_src",
-		.parent_data = disp_cc_parent_data_9,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_9),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_rcg2 disp_cc_xo_clk_src = {
-	.cmd_rcgr = 0xe03c,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_xo_clk_src",
-		.parent_data = disp_cc_parent_data_0_ao,
-		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0_ao),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
-	.reg = 0x8120,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_byte0_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_byte0_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.ops = &clk_regmap_div_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
-	.reg = 0x813c,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_byte1_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_byte1_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.ops = &clk_regmap_div_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_dptx0_link_div_clk_src = {
-	.reg = 0x8188,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx0_link_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_regmap_div_ro_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_dptx1_link_div_clk_src = {
-	.reg = 0x821c,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx1_link_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_regmap_div_ro_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_dptx2_link_div_clk_src = {
-	.reg = 0x8250,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx2_link_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_regmap_div_ro_ops,
-	},
-};
-
-static struct clk_regmap_div disp_cc_mdss_dptx3_link_div_clk_src = {
-	.reg = 0x82cc,
-	.shift = 0,
-	.width = 4,
-	.clkr.hw.init = &(const struct clk_init_data) {
-		.name = "disp_cc_mdss_dptx3_link_div_clk_src",
-		.parent_hws = (const struct clk_hw*[]) {
-			&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_regmap_div_ro_ops,
-	},
-};
-
-static struct clk_branch disp_cc_mdss_accu_clk = {
-	.halt_reg = 0xe058,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0xe058,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_accu_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_xo_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_ahb1_clk = {
-	.halt_reg = 0xa020,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xa020,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_ahb1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_ahb_clk = {
-	.halt_reg = 0x80a4,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x80a4,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_byte0_clk = {
-	.halt_reg = 0x8028,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8028,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_byte0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_byte0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
-	.halt_reg = 0x802c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x802c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_byte0_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_byte0_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_byte1_clk = {
-	.halt_reg = 0x8030,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8030,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_byte1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_byte1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
-	.halt_reg = 0x8034,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8034,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_byte1_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_byte1_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_aux_clk = {
-	.halt_reg = 0x8058,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8058,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_aux_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_aux_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_crypto_clk = {
-	.halt_reg = 0x804c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x804c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_crypto_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_link_clk = {
-	.halt_reg = 0x8040,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8040,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_link_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_link_intf_clk = {
-	.halt_reg = 0x8048,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8048,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_pixel0_clk = {
-	.halt_reg = 0x8050,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8050,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_pixel0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_pixel0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_pixel1_clk = {
-	.halt_reg = 0x8054,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8054,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_pixel1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_pixel1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx0_usb_router_link_intf_clk = {
-	.halt_reg = 0x8044,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8044,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx0_usb_router_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_aux_clk = {
-	.halt_reg = 0x8074,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8074,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_aux_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_aux_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_crypto_clk = {
-	.halt_reg = 0x8070,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8070,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_crypto_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_link_clk = {
-	.halt_reg = 0x8064,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8064,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_link_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_link_intf_clk = {
-	.halt_reg = 0x806c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x806c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_pixel0_clk = {
-	.halt_reg = 0x805c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x805c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_pixel0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_pixel0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_pixel1_clk = {
-	.halt_reg = 0x8060,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8060,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_pixel1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_pixel1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx1_usb_router_link_intf_clk = {
-	.halt_reg = 0x8068,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8068,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx1_usb_router_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_aux_clk = {
-	.halt_reg = 0x808c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x808c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_aux_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_aux_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_crypto_clk = {
-	.halt_reg = 0x8088,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8088,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_crypto_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_link_clk = {
-	.halt_reg = 0x8080,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8080,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_link_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_link_intf_clk = {
-	.halt_reg = 0x8084,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8084,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_pixel0_clk = {
-	.halt_reg = 0x8078,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8078,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_pixel0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_pixel0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx2_pixel1_clk = {
-	.halt_reg = 0x807c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x807c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx2_pixel1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx2_pixel1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx3_aux_clk = {
-	.halt_reg = 0x809c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x809c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx3_aux_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx3_aux_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx3_crypto_clk = {
-	.halt_reg = 0x80a0,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x80a0,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx3_crypto_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx3_link_clk = {
-	.halt_reg = 0x8094,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8094,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx3_link_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx3_link_intf_clk = {
-	.halt_reg = 0x8098,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8098,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx3_link_intf_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx3_link_div_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_dptx3_pixel0_clk = {
-	.halt_reg = 0x8090,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8090,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_dptx3_pixel0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_dptx3_pixel0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_esc0_clk = {
-	.halt_reg = 0x8038,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8038,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_esc0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_esc0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_esc1_clk = {
-	.halt_reg = 0x803c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x803c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_esc1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_esc1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_mdp1_clk = {
-	.halt_reg = 0xa004,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xa004,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_mdp1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_mdp_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_mdp_clk = {
-	.halt_reg = 0x800c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x800c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_mdp_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_mdp_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_mdp_lut1_clk = {
-	.halt_reg = 0xa010,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xa010,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_mdp_lut1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_mdp_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
-	.halt_reg = 0x8018,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x8018,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_mdp_lut_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_mdp_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
-	.halt_reg = 0xc004,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0xc004,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_pclk0_clk = {
-	.halt_reg = 0x8004,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8004,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_pclk0_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_pclk0_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_pclk1_clk = {
-	.halt_reg = 0x8008,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8008,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_pclk1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_pclk1_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
-	.halt_reg = 0xc00c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xc00c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_rscc_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_ahb_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
-	.halt_reg = 0xc008,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xc008,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_rscc_vsync_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_vsync_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_vsync1_clk = {
-	.halt_reg = 0xa01c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xa01c,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_vsync1_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_vsync_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_mdss_vsync_clk = {
-	.halt_reg = 0x8024,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8024,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_mdss_vsync_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_mdss_vsync_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch disp_cc_sleep_clk = {
-	.halt_reg = 0xe074,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xe074,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "disp_cc_sleep_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&disp_cc_sleep_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct gdsc mdss_gdsc = {
-	.gdscr = 0x9000,
-	.pd = {
-		.name = "mdss_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
-};
-
-static struct gdsc mdss_int2_gdsc = {
-	.gdscr = 0xb000,
-	.pd = {
-		.name = "mdss_int2_gdsc",
-	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
-};
-
-static struct clk_regmap *disp_cc_sm8650_clocks[] = {
-	[DISP_CC_MDSS_ACCU_CLK] = &disp_cc_mdss_accu_clk.clkr,
-	[DISP_CC_MDSS_AHB1_CLK] = &disp_cc_mdss_ahb1_clk.clkr,
-	[DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
-	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
-	[DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
-	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
-	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
-	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
-	[DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
-	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
-	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
-	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp_cc_mdss_dptx0_aux_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp_cc_mdss_dptx0_aux_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX0_CRYPTO_CLK] = &disp_cc_mdss_dptx0_crypto_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp_cc_mdss_dptx0_link_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp_cc_mdss_dptx0_link_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx0_link_div_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp_cc_mdss_dptx0_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp_cc_mdss_dptx0_pixel0_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp_cc_mdss_dptx0_pixel1_clk.clkr,
-	[DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] =
-		&disp_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp_cc_mdss_dptx1_aux_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp_cc_mdss_dptx1_aux_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX1_CRYPTO_CLK] = &disp_cc_mdss_dptx1_crypto_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp_cc_mdss_dptx1_link_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp_cc_mdss_dptx1_link_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx1_link_div_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp_cc_mdss_dptx1_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp_cc_mdss_dptx1_pixel0_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp_cc_mdss_dptx1_pixel1_clk.clkr,
-	[DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] =
-		&disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp_cc_mdss_dptx2_aux_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp_cc_mdss_dptx2_aux_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX2_CRYPTO_CLK] = &disp_cc_mdss_dptx2_crypto_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp_cc_mdss_dptx2_link_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp_cc_mdss_dptx2_link_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx2_link_div_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp_cc_mdss_dptx2_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp_cc_mdss_dptx2_pixel0_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp_cc_mdss_dptx2_pixel1_clk.clkr,
-	[DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp_cc_mdss_dptx3_aux_clk.clkr,
-	[DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp_cc_mdss_dptx3_aux_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX3_CRYPTO_CLK] = &disp_cc_mdss_dptx3_crypto_clk.clkr,
-	[DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp_cc_mdss_dptx3_link_clk.clkr,
-	[DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp_cc_mdss_dptx3_link_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx3_link_div_clk_src.clkr,
-	[DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp_cc_mdss_dptx3_link_intf_clk.clkr,
-	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp_cc_mdss_dptx3_pixel0_clk.clkr,
-	[DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr,
-	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
-	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
-	[DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
-	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
-	[DISP_CC_MDSS_MDP1_CLK] = &disp_cc_mdss_mdp1_clk.clkr,
-	[DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
-	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
-	[DISP_CC_MDSS_MDP_LUT1_CLK] = &disp_cc_mdss_mdp_lut1_clk.clkr,
-	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
-	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
-	[DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
-	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
-	[DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
-	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
-	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
-	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
-	[DISP_CC_MDSS_VSYNC1_CLK] = &disp_cc_mdss_vsync1_clk.clkr,
-	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
-	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
-	[DISP_CC_PLL0] = &disp_cc_pll0.clkr,
-	[DISP_CC_PLL1] = &disp_cc_pll1.clkr,
-	[DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
-	[DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
-	[DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
-};
-
-static const struct qcom_reset_map disp_cc_sm8650_resets[] = {
-	[DISP_CC_MDSS_CORE_BCR] = { 0x8000 },
-	[DISP_CC_MDSS_CORE_INT2_BCR] = { 0xa000 },
-	[DISP_CC_MDSS_RSCC_BCR] = { 0xc000 },
-};
-
-static struct gdsc *disp_cc_sm8650_gdscs[] = {
-	[MDSS_GDSC] = &mdss_gdsc,
-	[MDSS_INT2_GDSC] = &mdss_int2_gdsc,
-};
-
-static const struct regmap_config disp_cc_sm8650_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0x11008,
-	.fast_io = true,
-};
-
-static struct qcom_cc_desc disp_cc_sm8650_desc = {
-	.config = &disp_cc_sm8650_regmap_config,
-	.clks = disp_cc_sm8650_clocks,
-	.num_clks = ARRAY_SIZE(disp_cc_sm8650_clocks),
-	.resets = disp_cc_sm8650_resets,
-	.num_resets = ARRAY_SIZE(disp_cc_sm8650_resets),
-	.gdscs = disp_cc_sm8650_gdscs,
-	.num_gdscs = ARRAY_SIZE(disp_cc_sm8650_gdscs),
-};
-
-static const struct of_device_id disp_cc_sm8650_match_table[] = {
-	{ .compatible = "qcom,sm8650-dispcc" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, disp_cc_sm8650_match_table);
-
-static int disp_cc_sm8650_probe(struct platform_device *pdev)
-{
-	struct regmap *regmap;
-	int ret;
-
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
-	regmap = qcom_cc_map(pdev, &disp_cc_sm8650_desc);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		goto err_put_rpm;
-	}
-
-	clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-	clk_lucid_ole_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
-
-	/* Enable clock gating for MDP clocks */
-	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
-
-	/* Keep some clocks always-on */
-	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
-
-	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8650_desc, regmap);
-	if (ret)
-		goto err_put_rpm;
-
-	pm_runtime_put(&pdev->dev);
-
-	return 0;
-
-err_put_rpm:
-	pm_runtime_put_sync(&pdev->dev);
-
-	return ret;
-}
-
-static struct platform_driver disp_cc_sm8650_driver = {
-	.probe = disp_cc_sm8650_probe,
-	.driver = {
-		.name = "disp_cc-sm8650",
-		.of_match_table = disp_cc_sm8650_match_table,
-	},
-};
-
-module_platform_driver(disp_cc_sm8650_driver);
-
-MODULE_DESCRIPTION("QTI DISPCC SM8650 Driver");
-MODULE_LICENSE("GPL");

-- 
2.39.2


