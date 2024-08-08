Return-Path: <linux-kernel+bounces-279584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01694BF61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5BE1F27A64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0319049F;
	Thu,  8 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="en27hXIR"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650A18EFD2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126285; cv=none; b=NyyH5xQHaKuviPyT4+SpoL6Dnqy+oTjCTeHgRkn4L9zVvWl0LeuJsFFp+VPqwdbVT15oPo2SvukbMMSEM36SthGXB+Z38VajHbWCIRAcVPlgKm1Wj7YKA5IJX/1pOE633C24C4lqmpntOCIahU5UXU2xCzAJTN/QJKCONTujPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126285; c=relaxed/simple;
	bh=gR0CyM9a7lgnJr3lEM9JUrDdLahkhfxbkDJhWgDwKZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HA9izTASS5BSo95+W41Rnb+n2UHhM2R3GWkG1AlsNexIN3C/zB4FCIgl9vJzwmgjgqq3BvczxTDzOayqxs4uxdINzX6Zz95wgR4ZvHrFNsK927FqVryIGW/qBsuvNJXjfsbfPuAl67AprGX0Dq2T3EtBfFV6rHEXIiu6N0jwmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=en27hXIR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so1189151a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126280; x=1723731080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l83L9SwgjM7cQs40Ix45OsltdwbTgmJEPf1zQuQtrko=;
        b=en27hXIRhMA5daFt2gmE4HTs0Wo+icyc7KaojLz4wzRFwCItEm2ysP528zn+FIKcPl
         +HtiOzbnVEvtJUeiHcty6uLgtM3dCXvChjsQyfmVNnUikHjw9W3SYfyRq61D3UbDR07P
         EYjwMmALmFE/w4HWsbLP+ILYyFC5RilJtOWMrQCJY9e+36TcAIUt8yMjSXkw6vROBEpe
         M204yZCS9v9fNVa/pQAFKz3d8C7jzsWNS1rkJWmIfX5BL5Qxfj3lj6V+J8C4v0TwbRgY
         dYWTtvC3x8SjSAtoB5oZwMDSt2dd3Q8FuPCwpsPaMSYvBDSGWfvEKU0PyYTYc0lFf5zT
         iZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126280; x=1723731080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l83L9SwgjM7cQs40Ix45OsltdwbTgmJEPf1zQuQtrko=;
        b=wB9KvFclFhWsMuJm9tDoL8f2r8+VpOjsCeqhJc7M7GoHhmtXRzpsa5goppqxFz81Hz
         F0PX9+Vy7vOlIZneUGmWY50/iG+56OQ6ZB4p8A4MBiabeaIpXdALTCnCxAScBmqTITcY
         wa/q41hk7H9yQSuwXnjMbm7vJu7oj5EVPhfX185AEkJndBoJgtMIlcbvooHGIR3cn/wX
         YLf86saxVqz3jmugA1mqPUQUoRAjZIcBDftPzvgXmGKLH0Lz12EQq5ImB5YKrJeIeHzF
         +nxZMXvU0mIo9IYYfUBw6VXXv9Q9DnwPhJhDifIh78eX8FsdZ8vrdw1nigU2WF2WhMoj
         AjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2gQkNGBlpT5bVPCEI4LqaD5Spumfxp+jfPh7eDr/Ax5Ux1+Tim/P1tZ0WRn0MPdNBByNVBPH07ZLhrKCCQJGKGLUNtMyrzfKvAIGL
X-Gm-Message-State: AOJu0YyPODfqU8z5qg7iZqQa/Qr3N2ixaz+yMgoMTyRGbYua8u1ZCv+F
	ffmp8yEgpgobqciz8qfhzSsyzF0W7uNCNEpykHww1CAYwW3yd3jCztsW0/ybu6g=
X-Google-Smtp-Source: AGHT+IHHbEYfKvz99NCzEnYTqfn7cB+94G7FgbH5KFNqsiOTBHtM9BvVoArHK526vLwSDjCHbxrRMA==
X-Received: by 2002:a05:6402:27d3:b0:5a7:48de:deb7 with SMTP id 4fb4d7f45d1cf-5bbb21a4daemr1489870a12.14.1723126280575;
        Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:22 +0100
Subject: [PATCH v5 08/20] clk: imx: imx6sl: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-8-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx6sl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 47b8667cfa3f..bc3e414eeadd 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -439,7 +439,5 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(hws[IMX6SL_CLK_LCDIF_AXI_SEL]->clk,
 		       hws[IMX6SL_CLK_PLL2_PFD2]->clk);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);

-- 
2.46.0.rc2.264.g509ed76dc8-goog


