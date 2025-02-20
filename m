Return-Path: <linux-kernel+bounces-523597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77306A3D8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697433BEB97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA111F3FC0;
	Thu, 20 Feb 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klO8C5eZ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B46A1F3FE2;
	Thu, 20 Feb 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051513; cv=none; b=idqc/ybz0dR3gK+K86FqCKwKDPkgU/NzJNUrQOnD6ou6MwWzHVw+PXuu6GTDFn7FUOrdDqTOzOtlAJdvoMjalvPEwi6OYD2zz0pN2JRokziJ6AwXEv2neeKSzuW/sap5dlXUkcMMOclh+KGafAORWjEW+FVzIqzkYSAmyy6kEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051513; c=relaxed/simple;
	bh=+Bz4MMy1JRSDhE2rgB6ML0bRlLGnbn9wbdNBtvLsphQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDv96iyPOYx6MGuIyiVgUjvTOCJJQZqvDYSkMDH6mw7ZeTaYbTIZWM6EGs4+uBpVis1Eydn1JuZTuukyLc74SBBU2MMqQwGidc0Juc2je6cNmfIvsc+0pxzbMqkMme0f5Ftr283Y1gOD6R3GDQwWpk82xLrZWwbGpRsUEkaJ4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klO8C5eZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb90f68f8cso165990266b.3;
        Thu, 20 Feb 2025 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740051510; x=1740656310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExfFdnElv6RE+Criap0BQCRCLdiCh0cHD/QHqlYNoyM=;
        b=klO8C5eZDN3Ob2wT2vlcb4yHXvYzxYojEU2MRUMdKHqZHufIHsaf2IRsxVN7WONkYA
         UfpWPEKtLdtl82w0/2hYLQG7uHU0tvXCvFRfft+Zj2YxgATArFkrirKPDsZq3AVWMlai
         u+tT6/U/x2ZD+WZWdV8CFFKuiOdG9B/XtfITxRSYTRQc0mFM4Y8oby8haOyQySMFhQ+q
         nwJz4ddv3XmpPhWWqU/iu0O+BB6zuW9k5KW+iTjo4u6N2on5t/uM6FlP4xExW2nxo1Um
         f1KWyJGC621mJ8mHIVEuGnq6bi9no/ZbQmDp4VzGbrdxa81o4oNk78b7DefL8n3cbm3W
         kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740051510; x=1740656310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExfFdnElv6RE+Criap0BQCRCLdiCh0cHD/QHqlYNoyM=;
        b=MeSt5o7Q4a0AkPRCQm+XCBQgJSwSnOYg4p/S4L4ZJlNlaZj0m5ocuFkxTaKHCJQ0a+
         wJwMnYVdre+2wtTTQojK4oocwlR2vyezWScE7x1hImZl8mX6cUb4iZf1fAClUMBE8qcF
         0sS149zMU5hXnGKD91kS0tW/qsNLoKB6HXSgIQQ96JpNpgFp20GPlXzSWmuwbofch4yG
         3E3oClXkHUunM80fG2CY91X0qFOAbfhXIx3I+E6qkCRmc443fHrS8zS4fLXXwaGMHHvs
         UqEm7HPoytMa06OX3WkE3lOF0r18VvutnkyLqxCjFOzVfGXNX2nbcupbo/T8z35TUdgC
         6I8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJLmkucLMxgDlItYQB1g8SZl0mo1xMft0v+iv6Tj+2az0fm8lmuzCpJEk3u/FRAUVPRFFVA9FGjmw=@vger.kernel.org, AJvYcCXFaEivd9benfeaWo5k63S4Zy0n9Bq8y0HV3L/SCPjmxsqc3IAIv16iTfsd67vbjzflK4r8LGLJTcpqA77z@vger.kernel.org
X-Gm-Message-State: AOJu0YwCle23qwJQ1E35ln8icqcqvIiA3VJdDEDHbxGkYnvhvWkRobXi
	v97SnX9nEOgW3bPUY2CkGHtAK7cZvLB4RyIIhYfZLUaLQRXenEc1
X-Gm-Gg: ASbGncv+OWJNxztMBVOOVjY9Y1S43TZELyikJqWcKFFcjWa4q1pAIZyLay3X3GSK48a
	a8RwGZk3oSgGcmfVelJ8V1UeyIfd3cirEox4TYmbks/4sNQ62Fokw4DA7DCWrDgg0MK8Po1Y0zn
	fDSt6PDAwj7wze+LOUEpijqhY7crkpL1oM+nRBd72Viy5uNGEhzBIQu2CXcH4zjOwJCOS3o+mY2
	7R44KswR1YH9Z2SppdB6PMAU9hp5JmGZtZrMWn1rQrPuemIRxtz9Eglzf+PrPRwkJq3a0cRGxzZ
	l8B+cVMAyOQFbgBbNADyClWx+vgIb3emSik/RQ6/j8sCk2j5gc+W89VxBZyeFLOj0Eto/6nWrKD
	6IA==
X-Google-Smtp-Source: AGHT+IGjGppdPvcKBaNnCyGcV/by69IhzWTFcP15FubbfmQQ7R/MJ4PUeEtgq7WsyithVWyBUUJNNw==
X-Received: by 2002:a17:907:c02:b0:ab6:d575:9540 with SMTP id a640c23a62f3a-abb70df619emr2280560566b.50.1740051509436;
        Thu, 20 Feb 2025 03:38:29 -0800 (PST)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7200144fsm1047675466b.184.2025.02.20.03.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:38:29 -0800 (PST)
From: Philippe Simons <simons.philippe@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Philippe Simons <simons.philippe@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 1/1] clk: sunxi-ng: h616: Reparent GPU clock during frequency changes
Date: Thu, 20 Feb 2025 12:38:08 +0100
Message-ID: <20250220113808.1122414-2-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220113808.1122414-1-simons.philippe@gmail.com>
References: <20250220113808.1122414-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The H616 manual does not state that the GPU PLL supports
dynamic frequency configuration, so we must take extra care when changing
the frequency. Currently any attempt to do device DVFS on the GPU lead
to panfrost various ooops, and GPU hangs.

The manual describes the algorithm for changing the PLL
frequency, which the CPU PLL notifier code already support, so we reuse
that to reparent the GPU clock to GPU1 clock during frequency
changes.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 36 +++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 190816c35..6050cbfa9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -328,10 +328,16 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", gpu0_parents, 0x670,
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
 				       CLK_SET_RATE_PARENT);
+
+/*
+ * This clk is needed as a temporary fall back during GPU PLL freq changes.
+ * Set CLK_IS_CRITICAL flag to prevent from being disabled.
+ */
+#define SUN50I_H616_GPU_CLK1_REG        0x674
 static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
 					0, 2,	/* M */
 					BIT(31),/* gate */
-					0);
+					CLK_IS_CRITICAL);
 
 static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
 		      0x67c, BIT(0), 0);
@@ -1120,6 +1126,19 @@ static struct ccu_pll_nb sun50i_h616_pll_cpu_nb = {
 	.lock		= BIT(28),
 };
 
+static struct ccu_mux_nb sun50i_h616_gpu_nb = {
+	.common		= &gpu0_clk.common,
+	.cm		= &gpu0_clk.mux,
+	.delay_us	= 1, /* manual doesn't really say */
+	.bypass_index	= 1, /* GPU_CLK1@400MHz */
+};
+
+static struct ccu_pll_nb sun50i_h616_pll_gpu_nb = {
+	.common		= &pll_gpu_clk.common,
+	.enable		= BIT(29),	/* LOCK_ENABLE */
+	.lock		= BIT(28),
+};
+
 static int sun50i_h616_ccu_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
@@ -1170,6 +1189,14 @@ static int sun50i_h616_ccu_probe(struct platform_device *pdev)
 	val |= BIT(0);
 	writel(val, reg + SUN50I_H616_PLL_AUDIO_REG);
 
+	/*
+	 * Set the input-divider for the gpu1 clock to 3, to reach a safe 400 MHz.
+	 */
+	val = readl(reg + SUN50I_H616_GPU_CLK1_REG);
+	val &= ~GENMASK(1, 0);
+	val |= 2;
+	writel(val, reg + SUN50I_H616_GPU_CLK1_REG);
+
 	/*
 	 * First clock parent (osc32K) is unusable for CEC. But since there
 	 * is no good way to force parent switch (both run with same frequency),
@@ -1190,6 +1217,13 @@ static int sun50i_h616_ccu_probe(struct platform_device *pdev)
 	/* Re-lock the CPU PLL after any rate changes */
 	ccu_pll_notifier_register(&sun50i_h616_pll_cpu_nb);
 
+	/* Reparent GPU during GPU PLL rate changes */
+	ccu_mux_notifier_register(pll_gpu_clk.common.hw.clk,
+				  &sun50i_h616_gpu_nb);
+
+	/* Re-lock the GPU PLL after any rate changes */
+	ccu_pll_notifier_register(&sun50i_h616_pll_gpu_nb);
+
 	return 0;
 }
 
-- 
2.48.1


