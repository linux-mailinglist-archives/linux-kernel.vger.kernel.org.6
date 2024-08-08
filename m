Return-Path: <linux-kernel+bounces-279588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D794BF66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EB2B26592
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8819066F;
	Thu,  8 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJXPM9NW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9018F2D4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126287; cv=none; b=ofspa8miDBZL0deCq2R6iXF+04//9/RY9gnLjtEu1FqqEhyUXuoLK6Xmgb9koCD93LOtW1ZMI/aN5yzIF+/XFEPCoY9mcMg0pz++VFR0bd2beoXXYYKASTnm5nEQRAVopjsXvnS7enO7EbF+vAgCkZ70sDEjn2dV7pvVPLX28zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126287; c=relaxed/simple;
	bh=RCzb4T7ygPujxOgSIHXjGoBW3H5sHyUhE9zlzlMY0qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEiD05JnXIUI7stTBeKEZDaBebuSs3Jz/AMkLdWUXcO9DqHzHOU/1fcx6LaDqTrVMGmYpQFJx8Rm57bqz0JZtGExbn/+HOuL+sLahYqHGkHcJvftgNZgyP+9Xsce/LXSdWSK7OTv8p/1VZtpZwW6qDr2F8tR4DRdlvBpy41UkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJXPM9NW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so1189386a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126282; x=1723731082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fELKcjyo4D+4io09ckq4Quxisz8/UoBpXMhoRi06ZaU=;
        b=IJXPM9NWiWDbrKT8adumI9yZxij3JSDL16fU5u9zbVC/7Z1II7YaWNi+zF42ALZjQj
         FZCuDkayb02jHMoS0JxcE/argN74gS4svTsRW+s6VjVESq9vY9YONBeeZnzWpKsR04+3
         6AAGlOGKWQWNHHzZHCLTDBGzU4W9XJsm4/XS5T7hgWs3vo1hI69bZy5G2pTviCTFDNeI
         ZGXF8b14qkJbkhZkoQrplvIMdIJCimVYArIzRAg09MBl/lbvNdgUAJZVvvtwT9vtFb5G
         x78fCvokqITljOk7Qjn707+pRNhQN9of89aVJeMzAOGasX+yp+smfd7jkQXCGvQMERBG
         du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126282; x=1723731082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fELKcjyo4D+4io09ckq4Quxisz8/UoBpXMhoRi06ZaU=;
        b=OnK5dToKRD7uQ0nU3X2ILV/JPwG+hZK5pUC2aZSUud7b6/0WyiygrAvNwWdoMh6bi/
         lyzDTa7H/gCo3jTBAcWM1uiGPELjhsR7AZZAVqHeA8ZKBUzn5lgnETZ2N1R4kfOEV8z5
         VkPRIOeWanOK9AHohpxLKOtv8lfBwaEiY+91eZT/4vFW5BwYbb2Ub/XdIm+HNEAFDpe1
         A4+KgTURS7H0Bzvulb7IMozZukbQkBwty2cQ3JZjlVBlyg/DxoojRHNtyHW0cZzmAQCT
         S5P5+8z1s3tKeFw0xc/5agf8GNc5sBk5B44QTVSPEhCE5qHgC6jnFC8wqxpfpJKGmSro
         8aXw==
X-Forwarded-Encrypted: i=1; AJvYcCW+4UKhmL7R/CDBbF1E0Zrmts6XC7Vr6wLHi7PPsGsaEIamj+LYTcnV348ajg10f6vLjybmbYjy5G+gDtJmHu6Rs2h3tJ6RK0oIkiH1
X-Gm-Message-State: AOJu0Yx8u0kIvBBYDEZTTnJE009DpDVd0sYsduKLIiYPdB3kWc+rFw8V
	/oGZViqGdsV8cbvsxufZCq5uC7l5EvN9b62o2S3RUmDf5G/ZBpZHmFSCd11FZyU=
X-Google-Smtp-Source: AGHT+IFXR1vW0WZ0FRgrHfrqZdVlmPqP0fVrSp2izewTrWhjcdUCbNwG/FeaTyMsaopKQeaan59LLw==
X-Received: by 2002:a05:6402:270d:b0:5a3:4ae8:cbd3 with SMTP id 4fb4d7f45d1cf-5bbb21a38a5mr1707354a12.11.1723126282055;
        Thu, 08 Aug 2024 07:11:22 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:21 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:25 +0100
Subject: [PATCH v5 11/20] clk: imx: imx6ul: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-11-11cffef0634e@linaro.org>
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


