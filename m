Return-Path: <linux-kernel+bounces-279656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C194C018
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB731C255A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED91946CF;
	Thu,  8 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWrA+3qw"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DEF190477
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128182; cv=none; b=N095D9uqrLwwxe/zYjdiY7xZqMLc2nWZFy70aMBbcyOzlMf8ThOGtZ5XiWNXR1MyquhfHyb2yZZCKMUT33L6hrx+46WozpoDpXChtrY9Inxt61WH779TOCDa24WyI5xjBNCHcpHBGSg/18/jhAx1osYSznKGaLlDZog+x2hgUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128182; c=relaxed/simple;
	bh=n+1hhj763mEFqV1dem2n36RFOjE3WvEU7qjocs6Feh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjK1Kns6TZwoeoqY7xbeED85lhCNQcHDN4j8UmWk/PD4I4Br2Iu4m9Ntkp0RmVYbWel8q+q7+ZhxUZ6vQTv7a3Pp14PGHnEX8anMutXbq58PeUb8mEIUeLsoKjUE0jgK6CZn6zfOsUypA6DJbASynlXSvhB+0sgwkUMuaNQV1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWrA+3qw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1323355a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128177; x=1723732977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lpweh87gijIIJF4cQA1mk27Giq5WUQNyR9nG1a9dx7o=;
        b=TWrA+3qwdFNB3y7+JZtZB15xK4EE9u5AQFyS2KP0Qfy3WMzL3VNGty5YJJ/pKPq6gq
         tDUBYSzY9jECxD6qPlmvSXz115zSsU2aGwJE0YIXSsbYo1m71HR+lm6xvmqMXP/BGEwp
         HK6ROv9XFwg8Hmww97yKnTryBhICc5yQGK3F3mshRq+DsXuVH0IvrnXBAvJYSntA5cOQ
         wmQOgj+/vOpJgUMdTv1WwcpDabT/TuIXEYWhuRyxpeoOhavHmAdCbnI1BmSqUWxYtTaN
         pmozGuMBa5XnzHhnrGK+oi/8KayxGEgh/PNqQAbLEd1zZWOxL3OhmybPZbj/C6pXxNJm
         rh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128177; x=1723732977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpweh87gijIIJF4cQA1mk27Giq5WUQNyR9nG1a9dx7o=;
        b=NVy2TVg28WqM/L5VcfxlfXIV+A4zmsMuqyPfKDvJoMIGDP/1tmQ7XdzNyFXGaA0kW4
         h+EVuDyaEmGp4D2LEKZ8+QA3q92lBJKKyZj7UFjzjVL4cPs+HqgT1uas8kBCmthH/Yha
         NK77fhbFP6Wh3UnuXcXymyAzXS30F+9xryfUv6BPG35ug90b73boxahTUU3jfm2p6P/q
         yBh0isR27dRi3lwoV98/8zua6U2frrDmS6IKVH3IwSqDS3iKmCm+7GtdgtOuIzVvAUfs
         bsMYs8er25rVWghEHc9rogYvwNKSuXVN+7fU6MxznWQuSj/mv5ea30s1Ep2zcHQgeVsI
         PDaw==
X-Forwarded-Encrypted: i=1; AJvYcCVEwmI1w1O2PdRI1oVKGfeByPcAjsh9c+oT3wVfqJD2Ez8aKstG715+eT5hO1MvP+i+MRfnZmzu7GT4r0ZsqIH67Tdf8j21JHR6kWIf
X-Gm-Message-State: AOJu0Yw6xvW2y2FhkHqViKBiLshKpiy0D6NCRZQpYZFYvw+jo6UMyAOj
	6+oKXh8U+ACSb7TNlrb6eXY2wmiyDJqIOdGgtGelhXN5x2TKIkMnpM9EHoVuTgU=
X-Google-Smtp-Source: AGHT+IEwPmF6AHiigxgHBV+EJFuVs6w3OGWE4wzZqmI7eDvxo4EYmmOjzDlsuV9hWRsxZBFpbrUimg==
X-Received: by 2002:a17:907:d59a:b0:a7a:c812:36c8 with SMTP id a640c23a62f3a-a8090c6b841mr159287966b.18.1723128177139;
        Thu, 08 Aug 2024 07:42:57 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:43:00 +0100
Subject: [PATCH v6 19/20] clk: imx: imx93: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-19-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx93.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..9b8006b15d0c 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -343,8 +343,6 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks();
-
 	return 0;
 
 unregister_hws:

-- 
2.46.0.rc2.264.g509ed76dc8-goog


