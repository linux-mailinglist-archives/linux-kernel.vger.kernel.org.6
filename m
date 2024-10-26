Return-Path: <linux-kernel+bounces-383285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EB9B197D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BFA1C20E11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01BB1D86D6;
	Sat, 26 Oct 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6cmhJj8"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0351D86F2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957642; cv=none; b=NZKhtw1P9xhdVeW/K4Cl7DoYNibH8xYEgSp/yUOnapQj9DcdTo+crwcNE5DzwduK6wrvppqAOZE+stLlJxhWh0YKsZXB4LzPPNNawbvKqfBE+HpaIcaSsCveiezRc5m6HGMu0aMLT89JkxiFmTc/jmIO75/EpozDGoScBuglAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957642; c=relaxed/simple;
	bh=cusbsCXcCRICgVtoFfcST5RUPxhuJU5/xKi/V+i68TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXUFd6+d82BnEGOdTVR4sZKaQJPDV9kQTOSl9ZtvLFke9gxSFhsVzdYkQDXEALt02Cz9KGRDJrji9PiJsE6F8MpPZomSVXVutX36VdrJZAcEIJWnGqua4Q/51VrcPSedwnEUW026DNOL92FlhUY9eruY3OafUtPP5UlQD16g7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y6cmhJj8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f7606199so3538513e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729957638; x=1730562438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3AXSQsePizUA8LIscchHebVQbgFWw+Kxco+4DEcCkc=;
        b=Y6cmhJj8KlXmbd0dKC97OZTZb76RSOj6WEyO4R0D1MC69fuZodR9szTYIzPRCQUFZ6
         2GMA/k0cHZykEfZqhwlWetYcK9Bgu2mH9WXf6CSjl9m+97PlPJ6uWiaAHrW+koLJiJ7J
         kk/6e/3IxI+PHeq/XamcEih4wXiA99qwtWeO1o5neRLPhEY38h8ucrQAoFcI8XfVEE4Z
         DZdGDdQzkeMKKDJ8VAAUCYwgDZe68DnZKwi9xFO9mOCMpqTyLEYUtaz/iijTwbm12u3M
         OvRixReqZPk6nFaCTYJCrpPCdcVbPjRyTT2lWGGQdzeC9W7w1GPJ09jnpIM/1hSJib4v
         guew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957638; x=1730562438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3AXSQsePizUA8LIscchHebVQbgFWw+Kxco+4DEcCkc=;
        b=SdjaEZUuRG6/SQTRYY3nOkqEDdEmpw+BHzCGCtCsoR3Bitzc86FPl4IwBjcuu/yM73
         OT1NsST+Ad4OzLcwta58reIxUKTV6cCWyHm/Q7iybHnfNFI8ZakLNorQGeEIi3p3KzDW
         tWUUWtm5i3xntFjMkpVmMWXRxZH+YOBIqa/9ja7JM7IZEWMOTZnNLqdxmGjFJISUf90B
         3FBSWCQ7jKmArhSckHIGPT8o5JUjCuPQ1oSaXN01pfJZ4UPeTPK3l84Hjn9qGenaBV7f
         PkQJAIt9/Rq/cthp0zwfHjgRYNTDXNSyB3r9prItRRlzKpU/EfKtLKSXWvF1J00kqF6t
         S+9g==
X-Forwarded-Encrypted: i=1; AJvYcCX42f44+UXdLeUDj7lwrU1UhneKJva30DscRJAg4OPYWYjhULpO8Jjyv23cpiYo0WDjtIZJlLYNmPE0KHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZusQY2573oHC9vSbf5i6sJN597wEZWwlweRG45BitJy5N2mW
	r3M7lzLuQN/tkmsG64JKuubnNc63ImgFaAeTMxkrurRH0pv3VKi/PxgrM1GB3ZM=
X-Google-Smtp-Source: AGHT+IE7tmK5dd6mEkUh2mJnegruwvTXCaYtEVqGqkPVUun+kWmGhaaP8x5JCizVqtXBKQAMXWqPpA==
X-Received: by 2002:a05:6512:3f03:b0:52f:ca2b:1d33 with SMTP id 2adb3069b0e04-53b348cb983mr1138073e87.20.1729957637679;
        Sat, 26 Oct 2024 08:47:17 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c7cf4sm532188e87.184.2024.10.26.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:47:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 26 Oct 2024 18:47:05 +0300
Subject: [PATCH v4 07/11] clk: qcom: rpmh: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-sar2130p-clocks-v4-7-37100d40fadc@linaro.org>
References: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
In-Reply-To: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
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
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHQ73Tki+Xsxf1dinXG+Wrvd8DwDiuJ9fwPJOk
 5BCX1265K2JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx0O9wAKCRAU23LtvoBl
 uCE+D/9mdGBLdt17bqFVQuL5Be1WlBqM5+iqYe1Qgk66VIoF7U0MaaETSk3wil5gYDkDi1v+/70
 dOTemaNxb55VFC8Nf9rWIEcEyIoukq59nuLhmzhRAhuoRVldsOc4rA/sQlsPNY45aiH8Bxjmbxy
 yJRlhl1MO5EK1yF7NZ7z5CUUDXkx/GbV1dDny3xyB5ER2iZHgK6MCGr5JPV6sG7JOUrufvsOQmU
 Bc7EyeW/f/JEVUwgbH/E/TV8G2u0jy7CCIAt3qwF2YIWiXXUZk/pNYm9zcqL6EfAez4HHwro4YI
 8kOSPnXuB0xkZjTq+TreLGWXKFTH8knKfRwPwVw9jd31gNy3/TgRTsN2UfvDINMRDEpsVMUcLtj
 OctlHFHDTsXkBni4dHpkYE8rTKm+/LDNs4UlwdL7gqRfG343c32sqH1djh87kSmxOPny+OkaEHV
 tlWvsLssy7zfYeGQfBTbb2UD/RYMtkwwqvZkNPLVcIz39mpxTFb0ekXe5QSE9JXiBfP5b8ePZQ1
 fXR58k/w6YhdrgPbAFzVAs+tvlUTCwcUdadnDfXO0EgunU0VVDUFvZD/oaepsQlmc5HmGYdmWap
 JGq7+6Us0gRwbV5wVOUA/W2bWcXbdDQI8VuFzaavK8G5FdVnuWZcqWLylZSzJOugLBDxs2FhnEK
 D0M6HUSAA5lyyWg==
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


