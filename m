Return-Path: <linux-kernel+bounces-279591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C594BF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222FDB2281B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11819069B;
	Thu,  8 Aug 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia83qOcX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941718EFD4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126289; cv=none; b=ZOFZc4i8YdW5hzT8+EzW63KnCiv0wc/cEs3cq7rAGlCTzfs1zbVPoLD9xevTu04g8evtOVWRHDivmUw4XsOGSlUaX21YPU8obL+9sDEduHqUV9KUCOs12zmZ3/vfOqDhXaddscC1VZDqQ1/eEK2dxgcHSdvkhEemB0JgMAe0WL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126289; c=relaxed/simple;
	bh=dtBXWxh6pEv7DtMPsjNa6bKadgnceb0rxD2xntEHe8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKdMrJkXwtdmxtt68HGp8WSwkDXgJ5y6YEi/J7V9zltqREFcSs6DbK/FAYiAmzXISLsSMD7Y8pDrc07F2GEROD8VjPsZVh0HPDG2VqWExeqPW8yo2EaBSe46U7kXeAOmNTJbTcswPbtGprGyQ/m/Qg+v95/Yt5sbqfSvjYKmwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ia83qOcX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso390887a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126283; x=1723731083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=645sqhYxiGhlKPfMQkDqwsuRcG9BMBI/0rO4pG2w9xI=;
        b=ia83qOcXqlnleAF7+8oOHFyzOIrr11a4XEabC5nnVXshqvDHurIKr7uQ33mkTWrdpa
         /zBBlw5RucsLRnlmo3AptJvvDrXZZ80tLpH34EW/V6ulr9mSHFOox8j0SGml7b40c43F
         bjQc61M3dQnVQkK4QoPcJ3+nISQyz9SFXiKGuf/g4OBo2zA0fxZLAiD6rKN4XoaiFEan
         RUGzzAQ429T1ggbA9QVhdhfyyV8OlmJeitJzZlHf2TA2rcxOO53mFyrYHFp0UIthAwOK
         m8mTKaH+a+7syyS9VmEtIgF/MIAtqAPfLBuSHayEZotVjkPEQ66apvGGXYX963BM8IK5
         qM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126283; x=1723731083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=645sqhYxiGhlKPfMQkDqwsuRcG9BMBI/0rO4pG2w9xI=;
        b=E4IdGJls7MGnYixB5Rihz/9dN0woZiDMy8TAMFY/HudnVXENuAMOIS3MnSPOsl+zh+
         TEscgHGn6mR1Me08vWVNO6mG4oS+gusYRuTaPwr4/kLnvLZauyFvXO1fZav7reOLXWJJ
         oCBBeOV4W9igQyxinZbSqUn3bxcbqAsLzT+FNfsqmhNUh3wPBZCrMcqcQs7n6pS+Xm2N
         vno1RyiW80//VyIU1ZLn1Dr8BUt6qsk2AW39A0mewQziOVtRmUACqwGebiclXiZniEQs
         GUStA0PDC+LbdyqtgRo2tGqFMvNxCJrxRXnsvbI8QaLsAnrfExHIedjDgAigLW35ig1m
         4kog==
X-Forwarded-Encrypted: i=1; AJvYcCVkmbxK5qLu+v0x5JtVRKcPEqj7WEKy0QYUZ5lIa4OvGPapy1BRh1PmiP9upYuffRJ1mLq+4sys6HW2iI0f9uxFyz0L1Yv0kTyylNOa
X-Gm-Message-State: AOJu0Yzjl4HG4Y3u+1wv6uWH1onSeY+GmE0MFqK4ExPbwEjQnJr1qUpl
	F5KnKRRYzooH4iSL1jc1H/6eAj9PXng0i8sZ3v/lZoRA4v0Cwg7ICYzqHwqf7xY=
X-Google-Smtp-Source: AGHT+IG0sC08kh/zmsOObZ3PvXcjyWyb0j5P2FOkvROsWIocHE2S7w2vlae2/iLc1s1v1RsqBQB2DQ==
X-Received: by 2002:a05:6402:5308:b0:5a2:2b56:e06e with SMTP id 4fb4d7f45d1cf-5bbb24be6d4mr1598591a12.36.1723126282994;
        Thu, 08 Aug 2024 07:11:22 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:22 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:27 +0100
Subject: [PATCH v5 13/20] clk: imx: imx7ulp: drop calls to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-13-11cffef0634e@linaro.org>
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

This should also plug a memory and clock reference leak due to multiple
calls to imx_register_uart_clocks(), one for each clock unit.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/imx/clk-imx7ulp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index f4a48a42637f..517fb388ce85 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -175,8 +175,6 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	imx_check_clk_hws(hws, clk_data->num);
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init);
 
@@ -222,8 +220,6 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	imx_check_clk_hws(hws, clk_data->num);
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
-
-	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init);
 

-- 
2.46.0.rc2.264.g509ed76dc8-goog


