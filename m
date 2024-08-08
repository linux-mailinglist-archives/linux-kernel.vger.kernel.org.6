Return-Path: <linux-kernel+bounces-279596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291E94BF6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9E31C259DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09B19307D;
	Thu,  8 Aug 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHR/1avL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9D18FC7E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126291; cv=none; b=OHWjw98T5nLxNIdNOHvqUNWwd0dCCGH78l3dYDd8rJ9e2W2yqGuyuF80Jj5ZF3Kq86wNig5AgVKAO/KQRIX3uUNi4/CJLeqTyJB/0G+4KDf1po2VuiC5aqbbQUICvMxoIyTpq7j0SF7RWAASGQ6tg4R2/ciem8qewp46tmfdvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126291; c=relaxed/simple;
	bh=n+1hhj763mEFqV1dem2n36RFOjE3WvEU7qjocs6Feh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1z61ODQMdSpZlHNLjfyvaC4o7gxU9BYVLx4RsDiz3lRQ8PoL3gp9kb5z+8QEOxTvRjSiCvn8eLbMl7a94kc5o9EjTRi6JVY5Iln/gWgsgcwwlvZkuG0lclcCeSphTTJ8uTv8H6wvY6Ewry3G0kAzwOiYVo5AmmCheL9LvBBZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHR/1avL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so1189274a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126286; x=1723731086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lpweh87gijIIJF4cQA1mk27Giq5WUQNyR9nG1a9dx7o=;
        b=mHR/1avLG8RejJr/a6M854mctT0SMj3vwL2HbbkCK5+yqu08yqXROmkanqW1jsU37s
         5fcesP/Htgo1zGeIhnBCiGVtafS+tTIXTEOzEl8VCEc9OyZ7lqpYTgbzsSL+M/BpemOU
         TSXY/ioLbC11iQqBUbxGgZSxSZFVrd56UB3rtZ73K9M07miDo6DnQo9xC9TOAont3CO0
         a0k324CtRRz1dZmp7ngSaWdTpEh/BYy216sQhwp4HPa4CMRm9DRfGwUUBlbeVGtYr5Ex
         7L7j5fL+laM5NBgqusVe2KwYC40p7V0Ezo7hUvWWr0MYMoPpycIhla3TYVGJKax5VSic
         LOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126286; x=1723731086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpweh87gijIIJF4cQA1mk27Giq5WUQNyR9nG1a9dx7o=;
        b=SjNXfrSZBPQcFxFDfXom64mRlVjOO5Hii3XszHAw9npCylo06bJmjstR6+E+SUwQj7
         q+ySJAVUZP1zEECFeBkNrdRBViglSY2pLAd9dp30ULY60ihqk1Z5rJQhr/pnMYto8Akh
         d0gfvXjvZsAQ/1ViMZN9tKRAltDnsQH6LQaM6qYOnn7r9zYTUt28jMJk1CVoz1m4m0yp
         M8Qma84tpLuQM2QpnvfSvInRx0D5GDwqnSaX3grwEnk2JOKoUQrlmMbvYyS8Fd290jyX
         j1OmX77FCIFY/3Pugdajv09BBrlxUBL5jqUUUCNzdOQ36odp74qbM2Gxr7Jpy7umniEA
         VwSw==
X-Forwarded-Encrypted: i=1; AJvYcCVJpGw0wpRsJeHfe2o6ZGi21mgJx4eTqpAOnAohS2PlnHCdLwwRq7yFr+ZqC2ex0+AZEr7EpDwWxBSYSF0fbNkKi2AatudLFLDhPhDz
X-Gm-Message-State: AOJu0YwiTrqSjRggvH0ZaFQOH796V4p8ibdu7DZuGsSKsH2v3JXM0LWQ
	/EXqWZ+TFxEwss98JVmGpz+dO9QRQ5cjUjUi3/Teca9lHpmkd73gMWSZvtKZvbQ=
X-Google-Smtp-Source: AGHT+IFHP+WAJRQKtBDAPTtKu22SVp1AeXoLDnW177RheT0ogYkQLTg/lKBXGJw5OqPnaZBvaHWibA==
X-Received: by 2002:a05:6402:2755:b0:5b4:fa3c:d9ab with SMTP id 4fb4d7f45d1cf-5bbb2234971mr1842865a12.23.1723126285743;
        Thu, 08 Aug 2024 07:11:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:33 +0100
Subject: [PATCH v5 19/20] clk: imx: imx93: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-19-11cffef0634e@linaro.org>
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


