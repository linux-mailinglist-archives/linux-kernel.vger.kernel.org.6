Return-Path: <linux-kernel+bounces-383445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF89B1BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EE51F21BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFC1459EA;
	Sun, 27 Oct 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LN5mAk3J"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700C126C0F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729992306; cv=none; b=aF9iZ2miTwFRrUfRihlR6CCxdtHShPZVCIwMdmxjXU0AI2osi7zvHCBJmKJe0/Z5owUdvrc2OxEt53yr8lJATiZjS5tlhsIDlO7jA3qztVhv8NiTBSvzsEaEsT/k9QSkzvkQ3QhcYIiHy45FJ7NkxQqoC6ogpzuYZA+NwWmAr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729992306; c=relaxed/simple;
	bh=cusbsCXcCRICgVtoFfcST5RUPxhuJU5/xKi/V+i68TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVq+AN2DBurDcJ6V47VScjzxokm29tDJzJTviyRcXCWMUZoquMNvmnHEkg/st1qvj10JbLujXZwhNcFUJE5PrXTqh45+RZ9FYRIHBJuG8lWqnXUFBwSbadrvyXnLBNzO7R42iRQiTV0CKLSJy3iTdcI4AUk/9v3xX2FHXjuvDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LN5mAk3J; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3774374e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729992303; x=1730597103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3AXSQsePizUA8LIscchHebVQbgFWw+Kxco+4DEcCkc=;
        b=LN5mAk3JmTjVt1JVRnDC1RIpqP8lWBXcNR61jnsjeJJjrXkRYy3SDCyhfJtDWotzMm
         srd1opvMPOfBwG7ESDWYXEt9hAD85NOW6urGW9p6IW0LWG3DCXRQG2fC3BVCD/OiDKct
         E/VmUDB96OgCGTcd5p1b1uCTsO5fvoo0LH5fP9nh4mxLCs6JHaiwQiKoiJQ19I59ynii
         IhwzQZFViP8n4HHpRYiCqMMjPtqyq0Ojpo+gEJOXY1J6wawVPodIpsha86lG0HvAcq9v
         bJCx3d6POiBGqUfeD+apeECk/yXdbYz2zoyy3Q/LhqAtpBFpqna3TKdRd1HTGBCeJhYp
         8s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729992303; x=1730597103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3AXSQsePizUA8LIscchHebVQbgFWw+Kxco+4DEcCkc=;
        b=bbMUQXl6cfyVExabZAnBVvXdmHiTfNpJA8QDlcR1Rgt8mDoRIZ69eksaVjcYvC4fFE
         xF6v0nGUN4zsumoSYvMB4FFQ7S/CDVTo9fInOLLxIa5k1jCHqN01ATHCmDvSq2rCk+qA
         LEnnxefHVMI6oIaMV3sQppETWrv0govbpnWIRMxiOdFiOx6A3YrfupswG2YaFohiTvWX
         UBaGPdHLrJnAx+OUDcjudlezl9qHYGgF3ecFbvgO3fDkX7MGMogVyI+QAs+J2LdVFtL7
         PH/YQXL9ehy6i+ZzCPO98YLM4IzLhdjftMu8OQxrQWzUb3RBd3oIIa79oIHByDSyBix/
         KU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmiN49WoPlYhucpMMAH1ejXiflTeX6UhNjWOJFg/SxMv38nr+VEQYR6nwQWZsqZTQTFPAhddCfKAMe6nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvIIlzF5CQpTemhFEUiyNDYF44ImKyCG7GEhP5Q7OWxDc0Xn8
	OuW/6v03r6xWw1V2cGbgFdyO2/o5USR6w9Lu+zDNcIv65Vvsk4B4Mm+UXkv5zbg=
X-Google-Smtp-Source: AGHT+IElBSD4I3dXEGlc1jmOwlFmw33CuIPXif06ZQcCejXnCg1fZ/yvrX7RJUuVmCvtMgBETlfLUA==
X-Received: by 2002:a05:6512:3409:b0:53a:7e:bcc6 with SMTP id 2adb3069b0e04-53b34b3730fmr1358657e87.53.1729992302696;
        Sat, 26 Oct 2024 18:25:02 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c901esm642356e87.219.2024.10.26.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 18:25:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 27 Oct 2024 03:24:46 +0200
Subject: [PATCH v5 07/11] clk: qcom: rpmh: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-sar2130p-clocks-v5-7-ecad2a1432ba@linaro.org>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=cusbsCXcCRICgVtoFfcST5RUPxhuJU5/xKi/V+i68TA=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHZZhKZngsB6N7Ls+WS90KYp16lLGCsoZISuMu
 JXdDKdotp2JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx2WYQAKCRAU23LtvoBl
 uJYYD/49rt7ADfwCMeugWzpK5Ns3NMaOJ2X5IbxP7FniagYkyOinMK3OULzSGcG1B7DFbDTkKjR
 lTfEMhnIfb3ufmSLMOAK+h0TIT2TjfHVWLLdEtYtAHxcZHcAtHY5iSbcFJU+iUnRlyXmoUbYuH8
 pOwXGtvk3PHDE7YYvpBXtqBUwaRERf06TNk9biiYAzvnHjD5OzrcktakUzXfEUe5HgyZla0fxuC
 K9UpChDP3wk2h4IjnaAeMDIbrWmKQXISloGBVuP95yEs3+UFYSPmJ3Pjza7zTDzm5YflFvKiKIM
 pfspQspBPuA8V/W/JoZqxFlYtTxIIEhNfhybnsHM2NYpTvbuVHcdjxw3DFn6LQKeibGo/r0Dnr0
 jnhtEhQ7juuq1eUb0HZY4SKyw781JuHnWNOWPO2tfN6JNPpXeV8J+TAonmreRrPO9i2D4xMH8cI
 dTSVFYp+zJjs1bK7FKCcxtVFGJB6NjbSOillMxpeentDk75mdRRwhwC5fluZd1FWsghlXFIAke5
 WRkR+pTKj9uHx7/ZXYVtdxm4pmFSbg3squ/qxdflYd9y1EHOYUz8BCA/cKhOWp/Ada6GjS0dQiK
 eKYCms267FlOirX+wtHp4FaX6IDq6/8eOmK0uyWxJ8hVXECLPzlnxS6QvFO1qws+/v1yCHOI6bT
 oku7+L4y9zaghqA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define clocks as supported by the RPMh on the SAR2130P platform. The
msm-5.10 kernel declares just the CXO clock, the RF_CLK1 clock was added
following recommendation from Taniya Das.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 4acde937114af3d7fdc15f3d125a72d42d0fde21..eefc322ce367989f625f1285dcccddbdd8341a12 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -389,6 +389,18 @@ DEFINE_CLK_RPMH_BCM(ipa, "IP0");
 DEFINE_CLK_RPMH_BCM(pka, "PKA0");
 DEFINE_CLK_RPMH_BCM(qpic_clk, "QP0");
 
+static struct clk_hw *sar2130p_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div1.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div1_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sar2130p = {
+	.clks = sar2130p_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sar2130p_rpmh_clocks),
+};
+
 static struct clk_hw *sdm845_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
 	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
@@ -880,6 +892,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
 	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = &clk_rpmh_sa8775p},
+	{ .compatible = "qcom,sar2130p-rpmh-clk", .data = &clk_rpmh_sar2130p},
 	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
 	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},

-- 
2.39.5


