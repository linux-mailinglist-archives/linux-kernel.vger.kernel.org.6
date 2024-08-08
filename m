Return-Path: <linux-kernel+bounces-279651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E694C00D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E3A1F24733
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD98191F9E;
	Thu,  8 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS/BSQ4x"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622618FDB8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128180; cv=none; b=aBKUeKJKTzlvYoyfG/bgt9AuOn7bSZjc15xVhRTGbT+iFIMsfTA4pcyOzHFBaiJH4hwDfyKvrHp1oV3/8skEne6IanJt3Qe4+V6X7knHfRq1xWf6qjoRqxHFCm3lf3JiENF7PmFwSlsT/zNEYiqJE2zqS4GiSsQnmHBgmGSYAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128180; c=relaxed/simple;
	bh=dtBXWxh6pEv7DtMPsjNa6bKadgnceb0rxD2xntEHe8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ub0hwVENFkdq/aiwAIRGFX2rntk7WYLEeiAU9QIOoJfiK5qXOWw3w59m65Zf/xvFnija2pWxfj0ob9HsncWnod8J1ZclWhBmnuYmFnyGfL+ZLriygTw0MoWEzGXZbGgusBlyRdOeqRf4g6IWdzAeODVEOrP+vfm8lggGGAj/lNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xS/BSQ4x; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so1251897a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128175; x=1723732975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=645sqhYxiGhlKPfMQkDqwsuRcG9BMBI/0rO4pG2w9xI=;
        b=xS/BSQ4xTvxPagThXnGdCwTw8sdDHRM6SPm7Y8ZvflVVAuLwl9Iecqi4mWQLuuUdhM
         kOlW70W5bLXwvupxF+spl9gfAIJrWKwa1061rp10XAMje+DfcbgNpehsUcGs+AaG7Am9
         JFumh7oXDytZSMz5pleNYrIebthfOiYd5nWvWIS92HeTISJKVAbhMYX3zAPalpOLKlQK
         +ZWsLf7xPqGl1frgHnb366j7lHC/Mhn60C62O1NlM8HOr1SeXkHrSFSQBmiEvjZwg9NV
         MIBmhVcaQwwQJGtVVtvAvqOyDo+vE1DhosEwb+cd1hQqSdAXBeCbDA/2sOrALHHnVI4Q
         cyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128175; x=1723732975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=645sqhYxiGhlKPfMQkDqwsuRcG9BMBI/0rO4pG2w9xI=;
        b=SfzZk85FM0xVdkIpgd+5aEV5y2BkZRbcXVga6mnb9ecuGihcvkwFX6XVWaoXRUgw2X
         G1I8PeJM0OnaHCd4aaUNj1Xg2CM5kSCyeeTc5DRsBVvsIlhZGN1Dm2lFyNDrJIllAUbk
         cCc6M76nyNWL+bd8/x4SK/u3F+oZO52DRX+LnQqeyAPl7MizKa+EbGZRzkhK51oNPmTa
         gZ+FpSus8VxZUlgbqC76tDqgSpdsV2W6jpKL9W/PVRwtPnjlLSxvzcmeItQcpxv2eI6D
         MKHZhotqsR5pkPZ6Vr8TJwI5bRt0S+Dxw9oGpHlR/gHgn9UBjSwIbo++cmTI3p7qgxqj
         3kcg==
X-Forwarded-Encrypted: i=1; AJvYcCWsnLR0+GswLwnXUV6wvJVFK4LSwwoXaR3JjoU2mWslizo5CMWy7rNo++cz7pw30Q7gzx7//4nU45HIFRf46kOnL9pQgfw1pEjoiZeE
X-Gm-Message-State: AOJu0Yy2gMb3/Le3zzLhYGQuJPOmvaAT07UE1SXw850kPaPTgE55YWtt
	zG+QKMEnBoDum+6MUcs4iP8SwYNGPWUtQUTaZpJFDPgAfT/0ZP0ZdTK8l9vOH5A=
X-Google-Smtp-Source: AGHT+IHmAxlBw4O2VUn/A8heI+wfeEh/p3nxcqvtlZJmde0nHyNMStnoDpAJEr+6mWLx5is/WLQ66A==
X-Received: by 2002:a17:907:e6e7:b0:a7d:3de1:4ab2 with SMTP id a640c23a62f3a-a8090c829ecmr157391766b.27.1723128174551;
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:54 +0100
Subject: [PATCH v6 13/20] clk: imx: imx7ulp: drop calls to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-13-e91c537acedc@linaro.org>
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


