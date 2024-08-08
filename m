Return-Path: <linux-kernel+bounces-279579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048AA94BF3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0249BB242E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C218E034;
	Thu,  8 Aug 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcDoRYW6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97118E756
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126281; cv=none; b=Ts01/bofrH3pmwlAj83XooVBGS9HoPw4KcyCNW9/AzA0jwxYnjzhpulunbMClOLYk+RCeSYhZ44NxS78+s23WZ0GLjVFzWILQeyf5S1Hq7C5bM7pY7MW/xPnli949TSNy4MeoEWcWJN+Nrs9sBzbEngaTTqz+z9RzEPELTYH0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126281; c=relaxed/simple;
	bh=YJSi6uCRK0b9FvCZAgAg7fTVxuzjlsUrLU2YoRGNUgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfmE7C917wDx5/zNFdQQm1XtZ+6phKrbOI+1FXSX/aIPHJs1FIdHP4t9l6GgreAyRw+gPeJLv1mno1J5isgyxg6emJJj6bBYBbeo7buVxQhE5fAE2M442j+gUd2XbzNcqMi8jcXGs9J/vUcxNkiPGZ9jdkP6UsfTDZt/tsjpK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcDoRYW6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so1021261a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723126278; x=1723731078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i61g3HqvXtrI0H4Wdt6BZeDZIZP41pUUULE7Fmxi5BU=;
        b=xcDoRYW6y8VXLyWK6fSh64Xf2+KWetmtvJDPu0bwE2sU1sDFIIAbB9L+wpoP6wFKJ1
         oUVAli0Iabbrgqxx+vfmCANTWuvA9BkX2S/ssRc7zLnsIF283YB2HF8gYcLUhdhzbSyV
         AAj+fme1XRjIrl4pfMOiU9GkCouQ1KphTj3cgLCegzglpzR3bHu6nzKnCHoKX0/y+nnF
         CBr+2Sc5TGM/krC4My7pELYgkpPf8WYIWPu0pUwJvspVbUta5G7OTCUDRsS3aZnN+Cft
         VWeVl3bdUaZmfgYQIygJ5uFz61Cr7CCRHdacp1FInTzN+21E6suakm0Iqlg2Plp9rT3c
         FKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126278; x=1723731078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i61g3HqvXtrI0H4Wdt6BZeDZIZP41pUUULE7Fmxi5BU=;
        b=bTVeVhqgoknnu00HOb16FHp2OTxL++eY86w018z0TC4oS97YfI2o9PxmibS3wobsJ3
         +eBL4/QRnnMjrRqPUj4EQdS7Eg5dxGimf7HYdOOKwihiFj80/jI/OVSuT5kDTwE9F5mh
         ZCPss2U+OtNb1LZayhZltEgEopdinSwSzN6F1VKrxiKnk+Y/GB6ZKMMpuNGjrRc9Sc8b
         6dMQRk3SqF2LqxgjOA1dAxOGpvE2Iw/q4DjMNzRBoZkjT3ytfyQwlypRVlMCPeWzkKyM
         QXUT4JPkBLWjBVJtaR3vZ/f5gP61vhoCFcTPAQqyOrtgbzQ14zAQ7OcBWpusCFELsMP8
         zsOw==
X-Forwarded-Encrypted: i=1; AJvYcCXRr7G0cN3zUoODiW8+MlCdMvbAE3IARlskIAYY/tfyLWc+aykxvFxUm8ueDxV9P+ZBHOCbT/zxHVgp6IIsj4Pm6KBBtwQdNWbejdK8
X-Gm-Message-State: AOJu0YxJCEbKsRHxoK4oR8asUfWCD6xkftKX7+XNVPatepG+lX/5gg+D
	vY9rBWXqqd6abm+Z9Q8DhmiyTKWnV9mtLS634RwkoIod/abNID9IDHjbkuj8YAU=
X-Google-Smtp-Source: AGHT+IEiMhOMDiTpZBQDmYwk/4O0X4rmiXEoHQeeCddSIXSmt9SZ1xmlKbwP23bfJ7piM3Yp2IjSiw==
X-Received: by 2002:a05:6402:2354:b0:5b8:34a9:7fd9 with SMTP id 4fb4d7f45d1cf-5bbb23c7b6dmr1889019a12.27.1723126277640;
        Thu, 08 Aug 2024 07:11:17 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c29f79sm671761a12.33.2024.08.08.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:11:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 08 Aug 2024 15:11:16 +0100
Subject: [PATCH v5 02/20] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240808-gs101-non-essential-clocks-2-v5-2-11cffef0634e@linaro.org>
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

The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
peric0/uart_usi, with pclk being the bus clock. Without pclk running,
any bus access will hang.
Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
update USI UART to use peric0 clocks") the gs101 DT ended up specifying
an incorrect pclk in the respective node and instead the two clocks
here were marked as critical.

As a side-effect and by accident, having them 'critical' also
worked-around a problem where earlycon stops to work sometime into the
boot for two reasons:
    * peric0_top1_ipclk_0 requires its parent gout_cmu_peric0_ip to be
      running, but because earlycon doesn't deal with clocks that
      parent will be disabled when none of the other drivers that
      actually deal with clocks correctly require it to be running and
      the real serial driver (which does deal with clocks) hasn't taken
      over yet
    * hand-over between earlycon and serial driver appears to be
      fragile and clocks get enabled and disabled a few times, which
      also causes register access to hang while earlycon is still
      active
(A wordier explanation can also be found in [1])

Since then, the DT has been updated to use the correct clock in
commit 21e4e8807bfc ("arm64: dts: exynos: gs101: use correct clocks for
usi_uart"). Furthermore, the clk core now helps OF platforms with their
stdout (earlycon) clocks during early boot and thereby avoids the
problem described above.

The driver here can now be corrected and the work-arounds removed. Do
so.

Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/ [1]
Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

---
v5: update commit message

v4:
- the earlycon issue described in the commit message in previous
  versions of this patch is gone with "clk: samsung: gs101: allow
  earlycon to work unconditionally", so no need to mention anything

v3:
- add git commit SHA1s (Krzysztof)
- add link to wordier description of earlycon issue

v2:
- commit message typo fixed
- collect Reviewed-by: tags
---
 drivers/clk/samsung/clk-gs101.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 1759eb23263b..0c963e72e8bd 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3947,20 +3947,18 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	     "gout_peric0_peric0_top0_pclk_9", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_PCLK_9,
 	     21, 0, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0,
 	     "gout_peric0_peric0_top1_ipclk_0", "dout_peric0_usi0_uart",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2,
 	     "gout_peric0_peric0_top1_ipclk_2", "dout_peric0_usi14_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_2,
 	     21, CLK_SET_RATE_PARENT, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0,
 	     "gout_peric0_peric0_top1_pclk_0", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2,
 	     "gout_peric0_peric0_top1_pclk_2", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_2,

-- 
2.46.0.rc2.264.g509ed76dc8-goog


