Return-Path: <linux-kernel+bounces-279646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEF94C006
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1969283F04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598601917E0;
	Thu,  8 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHnoyFNO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E218F2C3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128177; cv=none; b=okAJQiMPT48YyL1xV12HtudaPjsoULv9+gTbKnvvgSXcv9ecZ9Y/jDholyqzlESTsoa5fJUZdtnCcOAgzTS+sI/S7Kwhph73waVyCmj108cFiwZ6E974A6m25YO7U2ZoppFohaYkBU6SP1iIEJ7XCzlK6PQImRxOV6UCz2wJhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128177; c=relaxed/simple;
	bh=RCzb4T7ygPujxOgSIHXjGoBW3H5sHyUhE9zlzlMY0qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuYT4iy+AhglBlpMIltdvgvVuP5eY764I5dkjgCcyLhOMD+dc20cvRbU/3YiVC+KpgzDb2lh5WyFnHW+2hvt014R/iy5iN71WwFSWm/aRXgiFPwdIWA7VsixZYTfnNBuOZWuCz30pHJoc1+AnP6+1EWttPL2bImOcaSQQIm3Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHnoyFNO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9e25008aso129366166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128174; x=1723732974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fELKcjyo4D+4io09ckq4Quxisz8/UoBpXMhoRi06ZaU=;
        b=kHnoyFNODF7gfI7Pdqy0W+LSMM6Vqz1TV569hl/m9I0uONtdqH/F9Tl9zniajqj4Oo
         nDaOBZYVeB+mBvqDD1z87V30l/W7wN6LXpTj4SbBTUDCArodXSSDjmRRmX+OweAy5dx5
         zbWj+Dv/PNoIeeO+Rom53w8IH2Ojt+wiOZUPy1jrnjarZ9GlKUCuTbQTauqBqqgfaxho
         XJyjGUdH0984R9tr+92dnQoDScLEo5Z6qRAtuJy6Rkblc7LLdP9mZ9O28DCVnMhR51D+
         ZL57p5hEUmpc88L231H0y6MI8OmGT9c4Mn3brphvGcHM6BQdtuH6xgyBDSpE3YPkupEL
         /o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128174; x=1723732974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fELKcjyo4D+4io09ckq4Quxisz8/UoBpXMhoRi06ZaU=;
        b=sJ6ZOPWm2zMR4r1RlFog/dM51+eWreuX1WBGbHUf5V4AXeQShrUieZOndZH17x+RFW
         6Y8SVYtI0lE7a2F7b2BfC1S+tdTzl4SiXmjomCZITyB+pLBIxchwHvLPS079sRSTbcgR
         WzEe9w994rimCixsxfpw7KHxR5rA747eDyhgtv+sllrjYWpA6n9CBDxREJFKCc4Lp76i
         qbM5iDD3yJhbY6fxkLWmhExxudfyjignjk5zwswwKeNdKw3tkc0/9VKFligIAkYVGZ6L
         CJmigglKH4s/eRAarna61Ikl1EDYL7r5JzlfZaoTvrQ+UGw1pcvBcbqXiy26dL3sYRZu
         bLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUcCdpNl75LpOGTsTgyzWnEokPmYVXsF2aTQMzwl/wuA0LHsiZgsO8dBb4dJRv12W2s0UPNhNMjYTW8UWcxP0QYphbID92QufpovQX/
X-Gm-Message-State: AOJu0YxynTrSauCujZInSqUEqNJK46HAtNFngb00nCrvkO2/qm9eAnYP
	XI6dSAplTRQzGkyRPS7opUXbA0y5fjv9OEtRn7TRFfPJjsTlt1fmK7hhfUVP3ps=
X-Google-Smtp-Source: AGHT+IEdiR2uqxL40ypq1eVBsdbq009S5HpqMJsLtiHNMyRcup08bUljMUs/bT8PIRSRi7Q4xYViWw==
X-Received: by 2002:a17:907:97cc:b0:a7a:b9dd:775f with SMTP id a640c23a62f3a-a8090e3cf84mr182258966b.55.1723128173566;
        Thu, 08 Aug 2024 07:42:53 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:52 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:52 +0100
Subject: [PATCH v6 11/20] clk: imx: imx6ul: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-11-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx6ul.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 05c7a82b751f..b828cecd3690 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -544,8 +544,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET1_REF_125M]->clk);
 	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF_125M]->clk);
-
-	imx_register_uart_clocks();
 }
 
 CLK_OF_DECLARE(imx6ul, "fsl,imx6ul-ccm", imx6ul_clocks_init);

-- 
2.46.0.rc2.264.g509ed76dc8-goog


