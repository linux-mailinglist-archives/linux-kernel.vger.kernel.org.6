Return-Path: <linux-kernel+bounces-381981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A99B073C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505E11C23798
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9A21E632;
	Fri, 25 Oct 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RabTfG0B"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAF216203
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868663; cv=none; b=i5NvJ2ROLfXaabOhfN8jOyDviaLlcLMeH7nrWFyVZ2k7pvJBheCiy+EUIdpTKes/HJoHtoYECO6yJxLhmychmk56JOO+fBB4ep8N9isKkAzvU5QKRg2h4M30UXH5YtYP8YITMlkd8KLJwwun2Dm+Q/nbopqbJX2muYk+KcmsyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868663; c=relaxed/simple;
	bh=PgUHmFdy/8IXl2Ih12X3KfX+3gP6WyToyydVdAOKAoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0KTWwi5NcCbw65X/zi6NZoWiGOItuWFcUwO/uonhPpyrDsBRZB/a+NSNIwlfSDKz5HIsgYEmm/hJ9DdyGpvtGHBPNYKHqkMCwjX+ruRYIOKAzs4PYdn75pVA5dnM6M/vZyrQ1yv89RJ2B0pLSEcioY1hpD4i1Hs11EhIKh+4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RabTfG0B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so3027664e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729868658; x=1730473458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhWjPDR01VyPmkS+g9wDQI09Awa9JCuuAq0juv5oCEE=;
        b=RabTfG0BR+nWok1btsY9Th6oYWgZPgp+V9rnVKIx7a/u54KqeJbLtk7D9XfkShe2bN
         TBDlWkYEPjV9LVhTLRITVrTwEt5UDDL0Yts80KGmL76tb92gpKBO2/KS1fLNWjunALe9
         4YNQvNBBQjdOZ30mfquIfgy1Or1d3drn4XQEC9lQsNd8Ll1AF+eX5CG5W5A/81cYT/ux
         DNCt7Ps9D/PbuNtC5wnY5p5jaiPoXrCmp0d1nf0b5bFUpW7L1rsvEFyXCERuUwM1TSrI
         JBv8ka7cBM/uRvqcJGcBAwtIkROKJnOoQsOFgymo4G58wQyIadRBdiO/hZNdMlH9HNOl
         5T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868658; x=1730473458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhWjPDR01VyPmkS+g9wDQI09Awa9JCuuAq0juv5oCEE=;
        b=PqMSQ8rnN3kv/Hc4wrlRU6g+FBmCKyX5rW+cP86yjugH/evMJGm43VDLy/TQKpWwk7
         wR2jNoIjBfNdsB0sU+uAMIK+ZCk+oC4/VnroDZ+zH+f8t+M9cLVzf/1F90PgQJ/kY0wD
         2iuPAbCeyPSRyChbjkW+2czeBvk49XWCjBniDX/QmUmw93lL6aIKswtysSbRYDF7X9sG
         MutTrQAZS7VsGD4NJh8J8whWauBE90Udrkmu3q63Ex7S3keOCpSEsmoabifnQNS+N9tx
         wm6LHNYCq6WcpdzfGIBBBEYDV160ynOEvELCo+zo4lpXN32vvi9W2cvlw+cAaYLtlPBj
         2b/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtKeDOKPjlaRW6F4qavNTK/SXUYjodxT2Rpd+hcbzBdxa6Qv7klCRk2Zmgpm4FaR6h3AGy9w6GPSX0EAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MP+cdCOIF0ckB8ohMT9/TKn+tfKS0SDvBXKBucf9psRQLHIN
	DwqIj9iRPwLECeKKpkeXs2uVDcFx5JkzV5jytwg5F85dOwsCB7C+Tu8uELbHWak=
X-Google-Smtp-Source: AGHT+IFOHPlSpj7S7IBeSaeF7wNAwH4f4/VKeIRCl0Jwww8I4AkoqFRn2jYxDvVmYbE1M8y3b15Hng==
X-Received: by 2002:a05:6512:b0d:b0:539:e6bf:ca9a with SMTP id 2adb3069b0e04-53b23ddee9amr3805385e87.6.1729868656091;
        Fri, 25 Oct 2024 08:04:16 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a915sm209542e87.12.2024.10.25.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:04:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 18:03:44 +0300
Subject: [PATCH v3 10/11] clk: qcom: dispcc-sm8550: enable support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-sar2130p-clocks-v3-10-48f1842fd156@linaro.org>
References: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
In-Reply-To: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3519;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PgUHmFdy/8IXl2Ih12X3KfX+3gP6WyToyydVdAOKAoU=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnG7NVYlZcvhzoMKoY5H1LFlgmkK6FmY6xs1MAb
 STi1P1SyAaJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxuzVQAKCRAU23LtvoBl
 uI+DD/4/4hj/osuQWCSS5EZQYWUUV4eBOg4wnd1AxMKfk89HFVLsfGjPtQeSe6gELEX1cuhwhfH
 TFBPqU+8RXeGVJuizkphMQLlyRsf3HH89obJlXa0XybE6MUv7lcwfxQw4Yd0bwLLj+V/OTS8MUd
 yKib/I8IbGBodUlXjMjVgQuXwHgXvE5NLU8pJALQtsJkfELT6AKzS4xn0t4Yzm0SdSwHPCOWGnO
 zWiM6R14kXbXnB074tPHNiaiKWuvzKsCxTcU5jiBj0ixOf7CsZwXr7cSVD2EUQGbAP463+7vqp7
 IMMl1UsICRUhyGx793L6OSZ4mFQu5kV0xQ/9C8DxXn6PsB5YFUi2GEi4KbY7BEh2Li/KHvQZxbg
 nEzYNngfclwUny1BpvStLbjx4KTbWb6gKun1wjioyyr9hyHCZ2Ep1WG6M/YvrhNkfejP8ZjGhgV
 rgElnz0s20LTsGo+5TnN9Hyq+5zkEjrGqjqGF9l1MoNtRbRc2Ld7g1TV4KYAMyO+yx1RjjXlAR2
 TSYsiod0tWW84RRsNUXaecl0kIPjkoEDeF7ndm0yNDk+KBLpqn7prZtgF+YaMp1mW7pja9VB7I4
 VsIibtn7RSxaRsbztxRCSU6IqhrN8NKfS+wIYHQJXF1rb2UWG2gVKR/wil3PHYjYGy89lBiV81s
 r0WfAH/ZM+9QayA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The display clock controller on SAR2130P is very close to the clock
controller on SM8550 (and SM8650). Reuse existing driver to add support
for the controller on SAR2130P.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


