Return-Path: <linux-kernel+bounces-279654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656794C017
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A51F2957F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5631946CA;
	Thu,  8 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WV2n8drj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AA18FDDB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128182; cv=none; b=XKYaEZohqxbpKnpFAfgBKRtHtUJ12ylhb0SeIMAcvQHOSK7eYxHekuEXUZAJasUMNBqFsB5Mq7btvAZ/B50+N6vEMUGx/WhhGK0tL+WM4JKbVb2vza9RNJ5KN0UQW7/6dbl9tC4ZS78IXyZaRUj/53pSCoCdSdz10+yLdce13s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128182; c=relaxed/simple;
	bh=IWr4xOLwFlcBBVMqbh/CeNYKnBYkZvyljj8xB0z/c08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7fJAeigHKycxsvvgjEIULZjc5NgNrLygXpTu8zTlstFz8RAuHFQDSup0z6lD0tsAM70ggZlgAnXkkbElxRkgaBXFWuYuf19Kai3jIrP0PNPxrHiauKajab4h9K5Tp60seuh4rikNWLsma8/7vvEJUIic0uAXIVgzBBUWCZQ3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WV2n8drj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso90935366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128176; x=1723732976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhprNA5ngdnDDPt6+AGX+wASXbiO8LYK4hmScrmWYDY=;
        b=WV2n8drjrDy93mcLGnYvxa8qaA2jEKQWsq547a1vd8QtoprPZ3bslpqfmZDEr1bQ/e
         imHrI1VdaM4981Bq5WQGOTs/xaa96qUzUM2z4NF34fRE+NKbh36+TTDWAz+wiDBjiG3e
         sRptq0ptC9gTzGfIk62eL4ERwmfirkC4NddVAF/onaXyvlFR5y1F58HnSw+fzg7ghkrv
         /t0awBGju4aLhQzn4J3L+m08wurCfwHp++3icjEdL1MZkkpDTaKX26B/HexC/eX5cFH3
         9Q8s1fKv93xFIWPAsSvhXxIVZ0tnwnHbfIcpsraDmIJXE8xYmRcOGIuP9v+8CAE0NZPN
         g72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128176; x=1723732976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhprNA5ngdnDDPt6+AGX+wASXbiO8LYK4hmScrmWYDY=;
        b=FdYd6LXOs3NDCTB3MQRheCMjY2fMcw7QHw3aQLCZhHV0IGPFdy3skEn/77S16cDfzi
         LzokheCnxmyQp0DqqMVMAMfMPApd5wdZqUEu2UsF6PlGAOcWdYdPvvSJCQnPNUuywm+O
         7syMJqEq05XIzlBe/qmJWMLF+aEqIBp++jPisRshvNhhFoC+MunzGy31Y4OG5dv67kLt
         ab7FJZmgpD65XyBDE95ymdFuFqmWwiiOVBP+muVgel+YHjAwhjcOGt0VbU4EiaJo9hoB
         8DqMw7/lhxbItjNzRexhwd1YshY2h8kuSIG2G5PLWSy7bmVj45IuqXAYVFFf0HuESHYd
         BUqw==
X-Forwarded-Encrypted: i=1; AJvYcCVgMfTM/S6O/NsPz/B0yXTS60GKtfJJCrte+epZFqZnA7wCm9mrYq4POAdRZepHoJkl4+3em3JXJ4uEyhGPVx+tP+bOvankoXfzECAS
X-Gm-Message-State: AOJu0YwlWoL/o1/d+VOG0kpT2nXeDtHUi549sfS2WOJ6oluyPjvlXbdt
	oVu1Th+/6P9do6erUTfwR7XjoHPyOzH+YOlAGIGLPTMw7SMeNyU3SjHuJGJtxc4=
X-Google-Smtp-Source: AGHT+IGqiI0vglxKcqyNtx/0toY2g/EAxqDpRfsnT3HZrYPk9OUoo9cgt0W0M6U+BQ788mgVAuOhmA==
X-Received: by 2002:a17:907:f1dc:b0:a7a:9d70:82b9 with SMTP id a640c23a62f3a-a8090c826fcmr135586466b.17.1723128176276;
        Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:55 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:58 +0100
Subject: [PATCH v6 17/20] clk: imx: imx8mq: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-17-e91c537acedc@linaro.org>
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


