Return-Path: <linux-kernel+bounces-383447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A769B1BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5C282435
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0D2154430;
	Sun, 27 Oct 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cv5IiL6N"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D68154433
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729992314; cv=none; b=LE0n+bIBnGIoRalmqG4eixuF2MyqEnKFTG+LuEv59d/G5zgCoVq516tV3n2ZnY3H7rRjlFtCyS2StfHj92Zd5Z9i6oKJMmK0WlrsmT7vOF89taD5u86k8LlWargc7yRy9x7xRsCjC2xrfl+mf826Uhro2d4DvMBio2xZsqKnVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729992314; c=relaxed/simple;
	bh=R2XkeFMnY0AjsGKXPK3B1naOIoaPvO0i7z+qzjzFpa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcT+Hesh4alHcDrF4krc7G0wSVTptjeCmFXQuBQ3/PAXIrZ1Z31YeyfKRFQFdXV7K1kgvHcnJxO7hWJf4iONm7trrCvIHwZAk42Y0Ws9Sbgho3DGvFtS2BVDmgydlGQiTPM/kitxJmSzZwSGzHLFjUendxehAyKdT0tcDT6/Szs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cv5IiL6N; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so3411908e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729992310; x=1730597110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef/t7amGJ7V2Yr0hBMFyJSXb1urInybmc74/xsHCZk0=;
        b=cv5IiL6NOp2OgweHxJol5qn2VPy2g2XFajtOYQE89G/M6q9xaWvniWm+2pnB7Zlo7u
         89Y6uTQmEPtEJzHx3Bf/AX3jaUFJcyl6pha25ogNIGvY/qQrDgFYZwpuCU3Xo3Dn2apy
         ETmQuMnYewCgRbBWLxJ9+dzKKWi1hjtWVsUct6hrmAWKR/qSxYr4qnBYjA8jn58FFDBl
         yr2qxKWcZE4YK/FwJDMbG9RyMNFxi/remqVFqHBVz/Qvfg4yGCL8TXIaWi3Gu+JKkKTr
         lRDXn0rKXpSwe4Ip05UWa14RM8uSDf6Cg5aCh0cQjILx2ytMGkHhPK9kjAlY3A/VdB+J
         7ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729992310; x=1730597110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ef/t7amGJ7V2Yr0hBMFyJSXb1urInybmc74/xsHCZk0=;
        b=RnbDDA5G+e7QpbAlfljrM7xfiOYfxdcvp0qoPbynTXK27m/9YwFiE42ibz4wg76xiJ
         5R0QB8e3+taE20XSA6qh7VfU826ytuC4nWyoTQNN1drWRDLWUfP8OvKOcjBi3MmCmiir
         Yln4QcN1dDiFFVT0yw9X/c82+k9mp0ko0y/OZ9CQu1vfDN2eoeQ7lau8EeT8OieEjKVR
         ALf3R7QvtWr+1a8nrVg5rUyV0sXKCqrUCppF6xbCQWd4viAqNQMnpvPeGtkOmiEPjsRi
         HUXT+UcGZAoRK5mwJ+l49WZXyLAlQLb3jJ+odAH75UjiqepY+8JWNSu8uh2HmGrnOmYj
         Saag==
X-Forwarded-Encrypted: i=1; AJvYcCWHEKIrs0lhfvwPZraKbA6Thvnl7I6MMMr3nn1DL9h7U9vn6QEyQIvjWhP5Ui50hgR49PaCeW2XsdbC1fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYidkxVfh/kGG08nMzyaPGZ7LVpjABIjtua2ohOmT2fiULMZcO
	jxI/dsO8buCZ/Sc36DIBWgBK3HZMzFrRPaaWDr2/HghqW0R7qmUK+QHupo0AA1o=
X-Google-Smtp-Source: AGHT+IEM0yFfXlXcvTZRyWI/L6v8EYLRrAEIAFkulPXH82HmxHCB0hj+BflTxLfYZ9xeHy/RQZrQag==
X-Received: by 2002:a05:6512:3c90:b0:539:ea54:8d22 with SMTP id 2adb3069b0e04-53b348d2696mr1461491e87.18.1729992309708;
        Sat, 26 Oct 2024 18:25:09 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c901esm642356e87.219.2024.10.26.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 18:25:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 27 Oct 2024 03:24:49 +0200
Subject: [PATCH v5 10/11] clk: qcom: dispcc-sm8550: enable support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-sar2130p-clocks-v5-10-ecad2a1432ba@linaro.org>
References: <20241027-sar2130p-clocks-v5-0-ecad2a1432ba@linaro.org>
In-Reply-To: <20241027-sar2130p-clocks-v5-0-ecad2a1432ba@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3580;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=R2XkeFMnY0AjsGKXPK3B1naOIoaPvO0i7z+qzjzFpa0=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHZZiw13nflzB7ic9/9eQu6/oMMSijFaHKJ9If
 qWZTFjJEamJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx2WYgAKCRAU23LtvoBl
 uE1rD/0dIYt2WRrZoNMjpEA+lkDeuWMrRNJgdjXFJtfG63rk7WvGbEwUKA3mT9abtHoxhc/JsqY
 /pbcOg8FfWJYXZxvyOs7E/lvx0dVf3AVuaZ838sElCTtI0Ppt3DRJjpdP6B5TUyJCMyYyPFrO3S
 HX9tompPWgyFu3RWtD6YI1B+HbZH6CqtM7vpkPmBSj+sIu+saPIGgRSbC7Zg+f5l01ZnSNv+kUx
 RLBdX+xDihyJ7HsQWGQ3WJxrpr75qNXiPGYMfrVDDt0EknO3QRtcCNITfDuvQEdr19qMX6bokUD
 9BFNmDRGWxn60XHyvwxxFVIB9NwHyCaJ26uutYJ7Y1cnwzkeAPQm/Oj8JP6gfsSLM9Kf9ZXS3SR
 Q91qePZkAG764NGJr9dizcCqZ1BpL2iU0D8OmQ1d4ZENEHjDUqeY/UtBbelGY0KBJEnHGjqJ6wl
 53SLr7KAf6FQ0O8K1oJYS0qz9VxtH5miHnlHXASYFrxovT+9GWIAhdk7gXc48JIden6OZ65qdI9
 wJaFd4vZuvGO0fwle+csA3stD7HXp/kfqHtnTH3KjOKlJ+I0DvJl3hR/vjWloiuv2okkldwhnk0
 74Eh7THGroTSSie6Mu+mQxtcaUrKunZL11XLw1E5hkJ8kpwqo6Mq9WAR+uJcFMgABc23bhZrAbz
 76clb5cV5IlQFHw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The display clock controller on SAR2130P is very close to the clock
controller on SM8550 (and SM8650). Reuse existing driver to add support
for the controller on SAR2130P.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig         |  4 ++--
 drivers/clk/qcom/dispcc-sm8550.c | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0cb5d5a052744761c95a5c72047cd322ddb8e0fc..77a4139d222ec7dea87d63b24896324973e4838b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -988,10 +988,10 @@ config SM_DISPCC_8450
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


