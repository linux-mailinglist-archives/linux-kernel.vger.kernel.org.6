Return-Path: <linux-kernel+bounces-279594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48E94BF6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2061F28B30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D87193071;
	Thu,  8 Aug 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpjuMond"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57818FC80
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126291; cv=none; b=EvvjGlgHSc6KcvcCi84p/Qm535meWrI0ZIgS3W6HeJHLjFmGETt5Vxg7LOhx+xesyfONyAFLjqZ6DMFpd39ihWf5WZJ5zn1YB78j4sck2SzrmiWgxiM6jBGYdAJ1t5MJ0nuU2UM2o/gsTR+LvFp01h+ky0ZXElIAUWYyK1BjfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126291; c=relaxed/simple;
	bh=IWr4xOLwFlcBBVMqbh/CeNYKnBYkZvyljj8xB0z/c08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohvS1jNRrMIsf9HS0az/ga4VNY6PcNq0uXpyqV1+QZnxiSO08YR2nVfTGXI6th89sczU87ukDzo3Ss5aoFne3OqwjDVDK7tWTsyPEz3dt6d/D0HeYoW4YDo7Vzso9rhtSoo3ynC2DgtaDE/HcFxCPDxvgu0K78yf/bYzKmsZ4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpjuMond; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1335437a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126285; x=1723731085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhprNA5ngdnDDPt6+AGX+wASXbiO8LYK4hmScrmWYDY=;
        b=EpjuMondvdDslUR7by+KlIehRWWqlPsoLi3hrNFp6GAnRUy4rwO4aenfgrFhVqRcnY
         IvcIDIjJlxx+jvX6XK8FtVRYZ8gkDbJ6ikak8qU0bs0NBhkkrLiw/mhxQ+p8P+ZfKdBG
         sOyJ403D03347IwhSTdnavNI8s1UDPnXi9gF20QsTeSn/UzAcZq8E5Mc9RW/4OMHNSBB
         /VRl48RjkhPt5uIvuGAF79/NNhtayYHuY05ECttVyJN9b9wS603d/rXgtF2B18phm+HJ
         F/VFBnKZcgZwofetAjIa4hx6+f/03lpdXJkFqMVpd1tx7RYtCGUj8AYeh1kmlFKWBpb5
         nIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126285; x=1723731085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhprNA5ngdnDDPt6+AGX+wASXbiO8LYK4hmScrmWYDY=;
        b=DZpy2itu9spOztPpPfGaao1Er0rAlpn1AbhA61lc/L1Tnkf0ruOvjQ1x4sNQbZpTC7
         TEyv/PKS/TurjRbAvHFpLeuV/y6yStJNGQV9Z7vhC3HcHzlsIGnfsTQza9mMZY9cFIMa
         OkKKXyQTqRvXEL9cSxtgYB9dgLwz5tDlE2+RrLwgqCYCDKqNzP6hVJcRmhZL+PwcuuaI
         O5TjR3y0JgMXD79d/cnbO5ZAiDkAZtzE5xOcZX+pJfU+lNNMwIq41WaTiPeigyuCbOZ5
         MO3qCDIN6tuHei/+ftZkPUwSKy60elT/DOdEaY4KLn7WW2JJdnl0VztbjOelzDhyr7Sv
         2y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1sc7sCgwJVngZttzz1Hcf/Kt2NPEz/YOT2PXfwJMD1rVMOU6sovbEXCZFnxCUBaZ0KJ0ffDbLTFc8ZY8MKSsAml0YyZvJmDg9a6de
X-Gm-Message-State: AOJu0Yx5HRIpqswPxJf/VUGac8UQrjPgMiXqbiDhaAmwZdB7Mp5OB701
	Nrs80ahm6aHqL+Olaff3rx1MDY8ZPwHpy8MsfcIoUC4reHH7vuEMKrHqXxx2J9o=
X-Google-Smtp-Source: AGHT+IGQe2l23uShoIpRGe0OtZ/F9zcL/2P+TyvQ982GKO9ePP01YLyep9DwZHa3XED5ok4WlLQprg==
X-Received: by 2002:a05:6402:42c4:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5bbb23f7c56mr1647715a12.26.1723126284803;
        Thu, 08 Aug 2024 07:11:24 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:24 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:31 +0100
Subject: [PATCH v5 17/20] clk: imx: imx8mq: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-17-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx8mq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index f70ed231b92d..db9aaec42800 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -604,8 +604,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks();
-
 	return 0;
 
 unregister_hws:

-- 
2.46.0.rc2.264.g509ed76dc8-goog


