Return-Path: <linux-kernel+bounces-279582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E194BF60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4151B262B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C418FC7A;
	Thu,  8 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMVCVZht"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0818EFC5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126284; cv=none; b=C1Juwt+9+b8+kCVUbBe34vue49qfY7f3I+CPLOZx+8cM8rtnpPH6nf3mnHy0v9JX9Uqfyq/yNO/5c1xrJ8VRH/kWjZOm3rtzylqRRuVQIb4RdU2Tx2TZm1w2u8mymKkhuEhgAJXzlGRLsSyAilcQueCYSDovJvBAOe7O5T7nvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126284; c=relaxed/simple;
	bh=BM5NOBExieRXZnAEQvVUw0Kowl8OGVo6wjlq8o0hJrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQh1qJnZMwViG57kERxkrISrKZXmblmT/qgv89YrgrL7q7CL86rbMQcwZdHSFx/91neOyUG3oH7PTdwuSYI7UbciIjevPprDBrzvogkmb/1BJ3fD8X6J2zHzBNRd+kXMqBqVQBHDD8imu+oeAldMD/+llcZzwgbuJE+8ZN+XbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMVCVZht; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso1355043a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126280; x=1723731080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0KZBbN+nQ1FI8ntFiIPj9qlGXoBaHjCw819hVXcAjw=;
        b=nMVCVZhtA6O/C5ZVwUff+byxNH0oUo0SWBAm/HGOvD/qKdEk42enTwEwDmC/YDBVXZ
         Qgcj4isRf7Uv6n0hkVzLurUTtRElqDmn9d5Q1kc3gpCUzeC8TwkZpR9X0TgQKeon25dD
         knKmygCDjQKRKxj8gWY+g3zBQukYFL6VOJaqneAv8qtiRLzwq+C17I2+sOeJIhyz5qij
         EhQBGzAgWBeqNiO1UkiLbP2loJI8+kNQ3q/iyg0HQbhq2ncM0Dpo26N8HZuzY/Y+rX7d
         9Iiz4pRbt5JA2QDNxiPj/SUOXmJ0emcQoGy1adIufhXm3o80AG9QrOLsr0v9dW2o3mGD
         K8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126280; x=1723731080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0KZBbN+nQ1FI8ntFiIPj9qlGXoBaHjCw819hVXcAjw=;
        b=Hgb48Z5fdIRnl1egeMf9zPOzAY6+c1EeSFLJ8wE2diOZdt3qgh0W9/C+tTDK8Giur0
         wGGkgwK+bGOmxNTknHSyCk80ejz7gRM+LKAN330t482/JTlYm1IE0ynt7QNjP7BDQJNz
         NMTO/EtGH3EsDCG6BKFniXj/xX6ef/RIcaWts+mhVLqd86dvO0VFy2rQuQ+a5/cGVAiR
         2UCOndyLKHMddqJW4qqu7qKHA7DPgzW3nQw531oqc27dfp8+8Vq7A80dYp34WB088c+l
         ajsLImpn0Mg6Uk1yFu2yvbrWDZhHkfVsyMnJmOpEH7Myn/8ujOtbHVxmqSZPSROVdxR6
         eVmg==
X-Forwarded-Encrypted: i=1; AJvYcCWusgbmjQ0/25SPIVKc5SuSA6K+FGJsgwLvB9HPFDaAm/n3Cag3unTIJZl3uCVcIsRltB7XGB1LEhpz6xa/MA28DpDqtFLSWUVhYKqu
X-Gm-Message-State: AOJu0YyTjiPABay75j27HOQEePh09su2lFxm1FBDjT8NuyxhhbxZm8LC
	+6BK4+r4rFYpOJe5gIASBK4es15BxFmKjVMD7ECbm48p2dSu3IKxa4JA181IPYs=
X-Google-Smtp-Source: AGHT+IGtyeiAxYcp18rF8HoQf16HSx6tLGtDmNJrCO+VQaF0ML3hsMyoqYty49GZM6aDNVCYElHp5w==
X-Received: by 2002:a05:6402:2695:b0:57c:7471:a0dd with SMTP id 4fb4d7f45d1cf-5bbb21a3148mr1640366a12.12.1723126279666;
        Thu, 08 Aug 2024 07:11:19 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:19 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:20 +0100
Subject: [PATCH v5 06/20] clk: imx: imx5: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-6-11cffef0634e@linaro.org>
References: <20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
In-Reply-To: <20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Abel Vesa <abelvesa@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The clk core now does something similar for us as part of
of_clk_add_provider() and of_clk_add_hw_provider() and this i.MX
specific call isn't necessary anymore.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/imx/clk-imx5.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx5.c b/drivers/clk/imx/clk-imx5.c
index b82044911603..163bed084a57 100644
--- a/drivers/clk/imx/clk-imx5.c
+++ b/drivers/clk/imx/clk-imx5.c
@@ -357,8 +357,6 @@ static void __init mx50_clocks_init(struct device_node *np)
 
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx50_ccm, "fsl,imx50-ccm", mx50_clocks_init);
 
@@ -463,8 +461,6 @@ static void __init mx51_clocks_init(struct device_node *np)
 	val = readl(MXC_CCM_CLPCR);
 	val |= 1 << 23;
 	writel(val, MXC_CCM_CLPCR);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx51_ccm, "fsl,imx51-ccm", mx51_clocks_init);
 
@@ -608,7 +604,5 @@ static void __init mx53_clocks_init(struct device_node *np)
 
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx53_ccm, "fsl,imx53-ccm", mx53_clocks_init);

-- 
2.46.0.rc2.264.g509ed76dc8-goog


