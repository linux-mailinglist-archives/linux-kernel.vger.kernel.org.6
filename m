Return-Path: <linux-kernel+bounces-279653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6094C016
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B681F29449
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEF1946BB;
	Thu,  8 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxnuzTGD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE3190070
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128181; cv=none; b=OQ0xkuZzt0BnYTrrdROSpUXfJO2ixfauwVheX5yjrr1OHxgZIo3Zt9xb80ltOffmXvSFIpoU6IxkVEDAwl1PR8N6cKNEYLX+1LfBynckmKJAJga8dVeDqpqp9N+W7K8SxBtrRTiYcfadBoyt8oDelysk4uSU2mUXwpLUt88pUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128181; c=relaxed/simple;
	bh=3MuovDtIRZorURIU9tYKQJVq47VGHfGnfR9ISQ9xJW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP7isyhEAd+IT7i1ND4SdLtpkxpPKeQeL6R4BD4hK4Gte5ScBGF50vmL+KZegc2KrGpWXh4/ZFEhToUQaHYEZhaA3wrDadG2lDAMVqDYWxKM3RNGxS51zscCo6A48loAGUyzSAKfLuc+4Sagamei3bcuebn8ZGZyYDVqbSG0dPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mxnuzTGD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so168209666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128177; x=1723732977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZspTtdY5QAEUSn7UgNMVbYIWDm0rZtsqchGrqjMzsE=;
        b=mxnuzTGDiigYZua/xLBvyxa1x7N4KSbrsGQb7mN1+Kxbbq4CMNB7qtuG4SfmmIHjHJ
         gl4Yqf2EgggyiY7KkXqMQWG4TQ1Zh8sVZzGb+LTZ3qbXH6/twvAgsR0KbItU0fPwH0AG
         janONPeA7hgsnHFx4Kb/8UNqGf7WY7rBL41ovduP5984hkCLt2g9BPgxGi3O/tdwP3RM
         jGPt8X2SSis7B2rYthAEsu6JGG1YzD3bios50STX2W3Pj+Uwa8kMUXrQp7kw+Muaxkz3
         FlTbyXE+6tdi/rS7s9XBrG2wzB9ZiCuVQPUbRwRLD6QsT87TRbE/wq2/XYMEDHxzNdIe
         wvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128177; x=1723732977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZspTtdY5QAEUSn7UgNMVbYIWDm0rZtsqchGrqjMzsE=;
        b=FtorlDUlGNKHySSAQ5+Q3StO44tA2gh8VhMKz2MA0V53u5Zl7tWQb2/myAzyytrV1r
         MyzMNc2TgKuCNnB+n5I/NwAUeSZYPLpabtV27F7MTCa94o5XuHOtk6TrEC0V493qdzRS
         qiULY3v4J0Ousq1YkGp6AjYFjW2oSXm8uS6ZdH0RUrRqcmGdCavQK90wgHkKqP2JhnhJ
         hP5WFHIGfIvBpzEvxiQhGIFJ+jSFp413DSTGLuqkv8jG5hgUKSFqR03ZDxH77T76SfVn
         0pjOaJkz2OYMPGQ0lLs+8Q/q8pTS5ogc510Ww1vkHIR+B4WUVVaM82XeBasjIAQODxPU
         cpsw==
X-Forwarded-Encrypted: i=1; AJvYcCU+HcbN7rhfoQfsXqH7629fIjH2m7CDri6mfYqg9t7u8qwQFq1MH1OT3qPHjtbyXk7EsycbK0uRS/Uh52RSB9fTQN4j8JgdMcMyqoRe
X-Gm-Message-State: AOJu0Yx4cQsoTKR0JjOQL5Poz/sE+AjXavzJgqsRkkkFtBdO8CpnKY++
	u39P3BLhaa3Y3wQJ3/rnI3gjSvhcUnu7Tonx5iRZKVdUw3O7yi1dImmLvNjp/lQ=
X-Google-Smtp-Source: AGHT+IE7R8B3T4fgiuoLqDk3xF7+I+3kP37bpToSGsITYor/oRfOoUboQm8qOJh9YQr2roRMF9fkPA==
X-Received: by 2002:a17:907:8692:b0:a7c:d284:4f1d with SMTP id a640c23a62f3a-a8091fd825emr175510066b.28.1723128176714;
        Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e04sm759298966b.175.2024.08.08.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:42:59 +0100
Subject: [PATCH v6 18/20] clk: imx: imx8ulp: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v6-18-e91c537acedc@linaro.org>
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
 drivers/clk/imx/clk-imx8ulp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 535b6364ca7e..5531e51a1e80 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -385,8 +385,6 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	imx_register_uart_clocks();
-
 	/* register the pcc3 reset controller */
 	return imx8ulp_pcc_reset_init(pdev, base, pcc3_resets, ARRAY_SIZE(pcc3_resets));
 }

-- 
2.46.0.rc2.264.g509ed76dc8-goog


