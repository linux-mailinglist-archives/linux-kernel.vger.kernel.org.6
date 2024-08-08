Return-Path: <linux-kernel+bounces-279650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6B94C00A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C347284560
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4A191F93;
	Thu,  8 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGyJfXU9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AE18EFE2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128180; cv=none; b=mIEgZj2I7eeB9vYhu9aqh1Zp4xwRpR7mD8RD5vLRRCXgt2/Uyb61SEw8RH91SyxibhKCUhA3hjmTlO862IHDlccyIWLYdKSY8yY/pztOiMSO1xFHdkIVn2bcSmdhNtP27mwG3VQeIw1Rju0wfvuDTLFnJy1uac71XQ0X8Gj2sHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128180; c=relaxed/simple;
	bh=1ir13MZl0az/9cRAPNM2xtHw/7Fiznd6AQuTHA91Vq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlRL9nJfwUgH/Z2lNoT0Q/ouiFJTS298IGUefik/G/1ofzyQt4swAw3y2ek9iAjgmvwmD2Tyglc3UiwbWmwWw3oMTXZQoaI5y/RdWZM1/Axi0gGlJNv1pmUDhQOCSSASomABPOJvqRkGAgzMStQAMsI5N4p/Ganq6H/OArfzauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGyJfXU9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so116216966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128175; x=1723732975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1g12t0G6k+jblt/poXm1qsZh457ASaKEWb3Du9DwTI=;
        b=MGyJfXU9yClvXIacDKZqOCQ65/UWleygTiq5h6GcDklsIaAaD0ctuJzsejnLXF/mrx
         o8xvAjnIzMocXKvSUD4/3p7hpJrWzN7U6gfJTGmc64NW+00tY+z4GcAE+17td7vqqsh8
         /yp0tOPsI93XQZBQOl+sYmgRrVep0tIMDXzADLaPF7l2H0mo5OCMrfDfYCUulAI07ZWe
         bnEYuqG7acSahnGyiQpnbQliEMFMB8XldUW9mQwRWJSNpfWvLRoARbEppcSvi1we8Rav
         fDiGFzpdjrZu+zxjgJ4T+Df0DVEns4SkUpix2cOd/2FhYfwOkoCauwGRCTDVBg/aCCOb
         RJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128175; x=1723732975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1g12t0G6k+jblt/poXm1qsZh457ASaKEWb3Du9DwTI=;
        b=tryc0HE18I7fEa272AYQa5UPBJTOLwLEAFlh3mFMLOrpHQteyv79wWUuIHJ1hKG5g3
         fiAkvWJ9Yh+Q8OuOs8widpSElwUuDB8qDWxs38a3BKhwMjh8H0gTIjsixLhBKp5VrCPS
         1Pz9dE7AvYFZ/K8AV6ktCEc0Ljgz3YnbpfGpmc/rbArEkmKRzhG1ZW722CTIXqfNreUP
         xrcex0uiuGtLdPgQGOfTQyU82yfCvBx1ataviRRlzZKl5S3bHYRC0Z41uWb3+4QtSduU
         BfxDbBx9OuvmRAmW+HIp5BKNWugD14xwReFI8ls/q2YGL/mudyc4Lva9mmB7m23jbOUz
         uzcg==
X-Forwarded-Encrypted: i=1; AJvYcCWwcdb1BbjbmJgAx4CEbRday3OyYDQcFJTH1P7aGJL5Qz0e6W+tCvz+dor4JbHdCKw5l13Y3vMuUBUYMp7HtqZk5AG63DpvCnMIj6uR
X-Gm-Message-State: AOJu0Yyr2VMcZrhBMw6OM63e8oxfLI82K7r6zBhDZ3iZ13sOMjxSAYVE
	9PTvCNeFgq4aZN6TdzOP4WO2PU+fzRxKNKHgst4S0TEQ3huGhWEaEq1E5m/fd94=
X-Google-Smtp-Source: AGHT+IGAVsFCrxEa0nQ5OTtx9phtXWv1jG1gQdi9l9rawdN91kA1XKHVuXOiSginDsSrGNiBP3l5gA==
X-Received: by 2002:a17:907:c8a0:b0:a7a:83f8:cfd2 with SMTP id a640c23a62f3a-a8090c68ad0mr142902266b.17.1723128175026;
        Thu, 08 Aug 2024 07:42:55 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:55 +0100
Subject: [PATCH v6 14/20] clk: imx: imx8mm: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-14-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx8mm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 342049b847b9..3f649da0230d 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -609,8 +609,6 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks();
-
 	return 0;
 
 unregister_hws:

-- 
2.46.0.rc2.264.g509ed76dc8-goog


