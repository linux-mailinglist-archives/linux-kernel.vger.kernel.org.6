Return-Path: <linux-kernel+bounces-279641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9594C002
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37C71C2223C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4518FC8D;
	Thu,  8 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHxOeBfq"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF318F2C1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128175; cv=none; b=mOgXnA2Ek1eHDTQPg6hUbWu0GP+E8eS8cIkCqakHWv/mQp/mPkARmS1zEMt4ZMRD993B3AxnABfGA2tMMyRNS2RZ5sXIYRE1PnAx6T4oFiO7otxYLHs7wLymLbtoKj7C+ESIVx54YQq8mTYHGzn4pt1/xXBAa28A2Nhl0yZvBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128175; c=relaxed/simple;
	bh=BM5NOBExieRXZnAEQvVUw0Kowl8OGVo6wjlq8o0hJrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGckNk0Lh7uOngMQxPj0gCPYejkDMkWFPOXea6i+fFJjbtbsZIvQhIqClhnzvM+yjEDCnjVRJ/mJsPco9A79oTwIod/rXhOl4tVv25IkuVI1ivnByey/pE101gPl/8G83hIvdfxiisSvt/zBPwq+yU+KktFwC+SHdVKY7jzQNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHxOeBfq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1062124a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128171; x=1723732971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0KZBbN+nQ1FI8ntFiIPj9qlGXoBaHjCw819hVXcAjw=;
        b=WHxOeBfqZmge0Tl4Yxhvx/jGsE1skSe9UqCo9H4KqGg9WInZidCCRPLSYvgrPvIoIF
         DzlCaJt3aumEuNh0ulTwxflGqEGnQPpJaEtAIpJmZn1WYAOHMBW3sw6GLm834cXV05FE
         rVn0DPYyOKT2OpKCFAmjbVXVnCUMCw0wD3VSXxl8XQ50/LML+yTQJ1/Po1sj4/LUd2AZ
         1FF548tmiRxYm2cc6jAXWoVg7LGdSJHVI1CKAG36UlHD3Mb2DbfraelX0Tvcdp0xYHAP
         pl6r1A1YMRY5SPa0x23gAgApVL87yarBqPhLm1DAg10JoUQBXH393Xlb1ELATW226UU5
         NdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128171; x=1723732971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0KZBbN+nQ1FI8ntFiIPj9qlGXoBaHjCw819hVXcAjw=;
        b=ODEMnY6UdqARlbiIR8TMS3HeSdbNEvabtHGlvgLwyxO4ZoEct0Wz8H9dbsVhlEZVUR
         91o5/ZxVFTh8brXIaVypJWnwvahO/8ebM+tD542hqGIQdO6Bmnz5SsmWkEKcljzJIkmT
         yyabAeaejKCvv1DCQxISKdK4gPs4+/5us/NJ6gvIESkLBcUoDEp53q2YhZMeDSdnkcvb
         Zw2zaLbDYL55NmXxxXfXrRPX9nPLSrhb6Up5BZxeuF4E3IRB8WXWTMrazWzRGTdznZvY
         s283uv50JYax0kKm5+doirdHPzNAvYZER4RlzCFeM+3CfFP+HVXjucIxPqyBWFy/sVYf
         va4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9v6nzBgRFCrU+T+1LCi+s1IHfnZdMFanQcvShYNF6MJqkfTt0Htagiur2KhqDKnTnb7SRqQaAWAzLzWUh8unhgpsRBit/5wwvSxQi
X-Gm-Message-State: AOJu0YwI6Uxa7pq5MLCRmJKPf3cjgtejw67eNuG9+LfAzfQasyyY0nEQ
	AycWWKyryqFrX/KYZiAnCKFFBZB5YyyPYd61enlGax5nneTaDCLkoiARt4ZMUCQ=
X-Google-Smtp-Source: AGHT+IF92aQdvuypDx1fq+tYFY5OivN5JbCVt20C0ukwfaeiDnLswwfjXsSThMmHvMSzFV280ksHCw==
X-Received: by 2002:a17:907:f1da:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a8090c828b5mr152030366b.22.1723128170682;
        Thu, 08 Aug 2024 07:42:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:47 +0100
Subject: [PATCH v6 06/20] clk: imx: imx5: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-6-e91c537acedc@linaro.org>
References: <20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
In-Reply-To: <20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
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


