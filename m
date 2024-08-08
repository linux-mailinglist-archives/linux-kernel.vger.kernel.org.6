Return-Path: <linux-kernel+bounces-279587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DF94BF62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B241F27B41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57B190664;
	Thu,  8 Aug 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5Cx9jnO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0018EFF8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126287; cv=none; b=L8/qLht7XXSc6+LX7GfieT5Qv4HQZBFij1l1RBCYB0ySASF89mZGn+mEIyLImvj5jkovH1KnhC8Elk9xEVxiu+ADONtmYUSFuQi09tAUaqrMyoUqJlEXQ8nNSvp69CzrIOmQEhTmACwN38egpEptryyg1s7tGUZPK3pMeKb2I1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126287; c=relaxed/simple;
	bh=F8XBaUKciL76OFnGIv5KAgXWQ49BMItLdMHThv/YF90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJTstKuXIdyQxOKlUmy26z8ByVt7QzTqDXCLJJhglTLAaxDj4ko6EBsYU02XOjErrnepSDhgMqD8qzWatvAUXWbRhn92j7Hkjew5po0OrP0SPyVYAe8tjhTs5a1dewUj6d5KyMc68WC61RmBTa5R2a+LWoLyhjJRmq4+nQPAX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5Cx9jnO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so9579051fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126281; x=1723731081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG/ZG6dnK/7FkbT8sGSrbUNfGaArXZW8+ft27slBbKg=;
        b=o5Cx9jnOenVDPajoFBtH6K9AYA37/I6CVdzl9yq411JVX8QBqfu4ozy1vUZD/Fj0Au
         dnfXsVrEwUFYojNhouzxBwaFTRfrGzxJEKndNw0OX7uGD/rW0NFs5ppYCkNckjg40fr+
         nDRtcw6FYs2q5gRHwqwL0JS7Kgu7tgo4WvgD1OCyVZjmdlqdSiDEcn+j84gY7LIFNJ2m
         Uv4YaSgFIMna5r2/P4tcgDOiItG2VXFxPI6abTRaWejf4GJ4uGQDeeR2Z5VtkwfXPRce
         sbAX/KtNKt1DXAdnJqL/wycYUm46Lv+FT9VD73Z9fNFc6f7L6LTFT6Gh6UAP8dOcAlLT
         vEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126281; x=1723731081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG/ZG6dnK/7FkbT8sGSrbUNfGaArXZW8+ft27slBbKg=;
        b=QJs08RzMzaGKU/V6XxCX9R3xZkIqZAnCVEEwTKRyk0EfQMnaM9LB5+QNCfkKDAu7Yi
         9Y0BW+z+taoJZD8ZMGDPNWOYxuI8t+ubOXL+ZYvPNNlCHRmduYga6ig0iNT3YtCPdKMh
         upLSD/a4Jm+7h/f5SbMzcCRLXx2mKAq9pe5DWxaxTTFl3H+eN9sTB7RetsuGesrbvt11
         CQErywLXq3kQrEnvPJRNhj9HoQhffnrFaWpjiH9mtk8r3/GWao9x2WEGIeW1rJyIlxup
         W2t6BCPSeJ4ryl4iYcAulBz4GHtdnAwjRbQF+WvL5wKQa2R+2+hWcx8ZxCPPr7IqJ87+
         esXA==
X-Forwarded-Encrypted: i=1; AJvYcCWlImOrWcKpNrQpDA9cAuMBCrTsQwRVN5Jy2ek31l89TAr2Oum1pEzETzcRNQUb9uJUVuDxQa8nLggD8hY+bPikYSg27uqsI4EUvz8+
X-Gm-Message-State: AOJu0YxBhmKW1HQeqSsFHK3x4hNwQViFdHWmXvyn02ljlkVkBQ7o1IFA
	r28rLzKNVGgXOVNxHd+Smlb3tHhoyyH/YtlKyWSJQAVro8bL4KIxEmlaSKSeRwk=
X-Google-Smtp-Source: AGHT+IE+EuzjKtlzVGUkIG93q6FhwJZo7ntOcGAcERKFIalXABnZj7xmQM8pOykTOJhv2cPudFbycw==
X-Received: by 2002:a2e:f01:0:b0:2ef:2dac:9078 with SMTP id 38308e7fff4ca-2f19de2a28emr14087411fa.16.1723126281066;
        Thu, 08 Aug 2024 07:11:21 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:20 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:23 +0100
Subject: [PATCH v5 09/20] clk: imx: imx6sll: drop call to
 imx_register_uart_clocks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-9-11cffef0634e@linaro.org>
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
 drivers/clk/imx/clk-imx6sll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 2fa70bf35e45..4310adc5d54f 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -340,8 +340,6 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 
-	imx_register_uart_clocks();
-
 	/* Lower the AHB clock rate before changing the clock source. */
 	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 99000000);
 

-- 
2.46.0.rc2.264.g509ed76dc8-goog


