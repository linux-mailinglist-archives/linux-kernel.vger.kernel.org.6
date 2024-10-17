Return-Path: <linux-kernel+bounces-370270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB39A2A29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5172823D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887A1FBCA0;
	Thu, 17 Oct 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PX821oru"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AB1FAC54
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184257; cv=none; b=T5JLNVAALw7c7ogbDk+ClB33BxDsvCuvYrgk1m7wl6sA3bEkohCquvRDNxRM6dq/+SoSFBRlUJQIHwrZ92V+j7fPmWi99I8L0TpVKqHZnCKfbFCO/dl8wnKpPPCPM741VkHrCtulT6tcjaHZKSuoLVH2B0i3G6HczHZTbt9DPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184257; c=relaxed/simple;
	bh=fbvu1iWZ6scTvWN5W30gahzXbQWngQ6ZKmmxqc762gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+JUEo+jtNwJ9GRaV6nGeTX00QRBNArcaZrNeAqEqEAQpDWqNotBMRzy3+AiM8WsIaVdTpcO1/zh8TUzaS58C+9F2TtXkFiWNpIpAY3AtzM3T7S3Ko13eivs+Uxeu4f3USiMXo/Sue84LnWAlgAvN9UQfEdxv60AgItgHKjkK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PX821oru; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f2b95775so1523552e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729184249; x=1729789049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWvwIEnWIKsnzmjfvspCHHy4Tzem1b3ef8BsIrynqJg=;
        b=PX821oruSH5jXoEuuf1Mb4CwxvrT48y+22QTtPGO0xRVMsATzPYSKqRsrvcNeH+rDM
         swCwttupk5x28/c2el3ZicT3tLb+AYSomlisFW96Af3l3XVmw/e0goG57vFNHdd9ZAFa
         2684HxkGJj+vL1G0AmRPUqO1P0X3D0k6WIDuc7a5uc52vhqN8s3FnUsm3VpGjQkKoKzA
         Zxh/VOqDSzOfWm/T9gYvFU5KOyjwOHm3b2DlPzQ7DIwdLbKw4CwmH0mY4lIg90WjDV6f
         WOy1qF4/VxRg+Aei8CnH96pLjDLrPGPTRjohnPMlR2NtjVNfZSSd98qlJ4cyj4IFj1rR
         y3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184249; x=1729789049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWvwIEnWIKsnzmjfvspCHHy4Tzem1b3ef8BsIrynqJg=;
        b=JeKuh/eVe87iOz8tzMFvx8fk6OfrbGqY246NRVlg/SDTpGb8YVor/NKQDRJTShVJfv
         EGsJ15P9G78Eo9+dZ0M7D1s68QJF5nAW1bsyquWboYJntECefoKQ9is9KuNh5m5jwMUH
         vbnAV0FeXAnRc+HH016hZcoJvNyjnT4a7DTbQJdZQTrGRNScMc7j1aHOk+kaDLBJduAU
         4opsumR0qm6uozyfUWIORj9+xrJnN8eS6JXyN3lGZ51r/22ep9+Uy8DuBXxp01RmLqrE
         4P1saIt45LpBl3Fq0BUAQuHqUhOpxUit7qYn2uqzFF/paEn10DSrkocD8Ol1h6n6Q2U2
         Yynw==
X-Forwarded-Encrypted: i=1; AJvYcCVL9knKE//6FNhnX5AoxHCMkOj3hKUQP7CDDHl8JV7T2oKl5i5CzAwgA7QjlUX7rLWZeC+v0w6qWdFx2ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVP12wvZ1XR0VHy0Q8JzkroZ+DfNTirRSYSHodKtDS2Z7dAKiI
	WVEqI4AQEvmqZO9ar85TzYCYC47X4/+1SBSj2M5WLIjSw5ys5RT63T88xIl36TZaO2Y3GfOPSjy
	e2U0=
X-Google-Smtp-Source: AGHT+IHHgMHG97cvsCziaeoREzb6x3sqdGXN97AHTGzEq9Q7AS2odtpV/hY0nwS/mroLiy/fdKktig==
X-Received: by 2002:a05:6512:2398:b0:536:741a:6bc5 with SMTP id 2adb3069b0e04-539e54d6122mr15546193e87.12.1729184248603;
        Thu, 17 Oct 2024 09:57:28 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007078sm821563e87.212.2024.10.17.09.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:57:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:57:03 +0300
Subject: [PATCH 13/14] clk: qcom: dispcc-sm8550: enable support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-clocks-v1-13-f75e740f0a8d@linaro.org>
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
In-Reply-To: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fbvu1iWZ6scTvWN5W30gahzXbQWngQ6ZKmmxqc762gA=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUHelKbwpXrCLcfkbLA7qsgVjwlFOHUuLisTN
 ArAU0n6afSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFB3gAKCRAU23LtvoBl
 uDGfD/9wfL32JAfP60O6G+BHASkW5WfD8VWGCMiDYhmMfP9juzbIu9/VnhrdpkL8ZxV5Bzijj7w
 t6BzcYqROOZZKma1+XrKgcKttzFXVO3tupfYuSWmobuNmvZijbmJmwnso4/b9tdfyVryZxh2uxH
 oVSkQnLmh75oEX7bNLZomjR4rxqnkQp04c2nZVRkOTuiy3ojN8lOtnbmndRYWHbq2AhyhO/KzH+
 RHU2Y1JZbXfquCs8K1EA9xEIPSFmrUvW3BnMxSpFVcaSRqS5KkKz5WPqiywgaJDyUcZpwzyaZ8+
 oI4jNKtV0xnZu30EASg/e5OYzmvkhXtugkhiCIowtC1UYD6L6tUzL1ZSkSqpgmYVKJoXZxVKKsk
 xGjWtvxPuUNX37mGuPUcttBxl0RY54i2apEDAABGc6tzkP36/DIfSrSbgp7QU9LSnEgm8fc3eED
 R9dbv1G9oJgmvttVbC09tBQ8Zhy6Mhwj0j5vMrHkEUni3spk5ATZfLvuBwHoPuyKxKZDkATHItD
 xun5HqKVfguEohdQJXfIS4aIzVavs1qL2WalVXdT3mVC1RFRodX6/1fUGQH9nBbDBwsvz0qZDtv
 JEsHoyRonCPUV05F8c66m5KbOJEn3jgZqLQyj2brs9fBgvhNbdmVTJ0cL1n7MN99oGNkpTSyZRE
 WedYc4h8pZOdqlg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The display clock controller on SAR2130P is very close to the clock
controller on SM8550 (and SM8650). Reuse existing driver to add support
for the controller on SAR2130P.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig         |  4 ++--
 drivers/clk/qcom/dispcc-sm8550.c | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 5f7bf9db76cfcef1ab18a6ba09fb4dc506695f9d..f314f26fe136c0fc1612edc0cca23c4deba5cd9f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -968,10 +968,10 @@ config SM_DISPCC_8450
 config SM_DISPCC_8550
 	tristate "SM8550 Display Clock Controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on SM_GCC_8550 || SM_GCC_8650
+	depends on SM_GCC_8550 || SM_GCC_8650 || SAR_GCC_2130P
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
-	  SM8550 or SM8650 devices.
+	  SAR2130P, SM8550 or SM8650 devices.
 	  Say Y if you want to support display devices and functionality such as
 	  splash screen.
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 7f9021ca0ecb0ef743a40bed1bb3d2cbcfa23dc7..e41d4104d77021cae6438886bcb7015469d86a9f 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -75,7 +75,7 @@ static struct pll_vco lucid_ole_vco[] = {
 	{ 249600000, 2000000000, 0 },
 };
 
-static const struct alpha_pll_config disp_cc_pll0_config = {
+static struct alpha_pll_config disp_cc_pll0_config = {
 	.l = 0xd,
 	.alpha = 0x6492,
 	.config_ctl_val = 0x20485699,
@@ -106,7 +106,7 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 	},
 };
 
-static const struct alpha_pll_config disp_cc_pll1_config = {
+static struct alpha_pll_config disp_cc_pll1_config = {
 	.l = 0x1f,
 	.alpha = 0x4000,
 	.config_ctl_val = 0x20485699,
@@ -594,6 +594,13 @@ static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src_sar2130p[] = {
+	F(200000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(325000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(514000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
 static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src_sm8650[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(85714286, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
@@ -1750,6 +1757,7 @@ static struct qcom_cc_desc disp_cc_sm8550_desc = {
 };
 
 static const struct of_device_id disp_cc_sm8550_match_table[] = {
+	{ .compatible = "qcom,sar2130p-dispcc" },
 	{ .compatible = "qcom,sm8550-dispcc" },
 	{ .compatible = "qcom,sm8650-dispcc" },
 	{ }
@@ -1780,6 +1788,12 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sm8650;
 		disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr.hw.init->parent_hws[0] =
 			&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw;
+	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sar2130p-dispcc")) {
+		disp_cc_pll0_config.l = 0x1f;
+		disp_cc_pll0_config.alpha = 0x4000;
+		disp_cc_pll0_config.user_ctl_val = 0x1;
+		disp_cc_pll1_config.user_ctl_val = 0x1;
+		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sar2130p;
 	}
 
 	clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);

-- 
2.39.5


