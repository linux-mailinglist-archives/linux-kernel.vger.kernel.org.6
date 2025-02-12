Return-Path: <linux-kernel+bounces-511639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63940A32D98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234193A2E29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CF25A631;
	Wed, 12 Feb 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVYHntye"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6525A343;
	Wed, 12 Feb 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381808; cv=none; b=kMYBkOfGi91RKisg6hHTCsdudhgKQLztKVTkSKeutplGthAinEXzkTdm0O+Px+ZG05ZhmX9OSWkOcL8JslsQD3umFn9Dxl9fcaOQ0OCwJ5/BwNQJkL6CwBk8HqdGgQi/mVtJGFogXGzD+ZdQKROvAzkOf2+DQ84jbAq2XJEjvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381808; c=relaxed/simple;
	bh=F9wiijtTYA6qqPa8iyHu/cykIH+jWU/oHC3FG3o4qGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPI9PTWGCmWaPZU7y9OEu12wL728B41W0qCdmB6TCcjUxTk4nlPRZf9SYAVSyJFCXc52NdqqvucUzSfCn689k1s+6PxHu6WvcxWC1UX96uET/gazEsSpaovv4ZQMHlJPV30urozT1IgCEdFdsGq9Jbwkq2PqQ5ju615vEBlcfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVYHntye; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so9723666b.0;
        Wed, 12 Feb 2025 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381804; x=1739986604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HOAmeZSd8XozBfBj4jNyXC9XonCoX2cwbZMmLfFjDQ=;
        b=NVYHntyeyvNMR/DSJzJCqeaaQa9VvLo6qZPDpLSS2lV3NSt6Wc+Nm9G28Ti9japROe
         5uL/XDqaXk06+CiSBFUAagEyE/8J9ixTqaG4NBX1u4yXyB5KDUZm8KynKMCmiLrVduvx
         FEQhph5qXPV0vmmi52qjk2NOIwAh4a4LQIwdP5kV+rr6sDe/rZI9C+y0QSmbMMb+1FL6
         xdev/3YbwAFVsqFbuSyIPjU0L3+TlKmOXYXvMKS+sE97+XMwHJUO03aPuu9noPMRTT/G
         zTZ2rVPZs70CQ565PQXt9uVLdzEDYlbiCfXYL0VBpl/9x3KgRlYY2yS/QIPE6I1Ne2WD
         k/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381804; x=1739986604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HOAmeZSd8XozBfBj4jNyXC9XonCoX2cwbZMmLfFjDQ=;
        b=w2NeBvgVjEouq31xp5rHDZ2ZfkksfuUzRONy/eu2afhXNZylDv1EVf0euK4bLESTsp
         L3Lt4iugCQjjFyiyrbNFQtw/mxseRESA3NDYhwlXK5NuLIetJzr2M+1aSR/PTXqe83eB
         FG98DYPIl19jkYvj7m8rZYljt3rKkdlEwEc6N1IK9TOBWc9rysshOccqj5L0Ty1ve+MX
         La2pITT5zuHG3q/07DdUM8Yn7VHRB6ouCNS1N3yApVXZdQFYzXC5Unasp9CKSEouCoTI
         rvTwbxYwqpJ/KCr9a19Hy8jGwmxNK4qQLJ1DdTpLDt5FovSV8cfQmhf9CoUJ/snYlpha
         06Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mrzR8yrqpDVgVkHE83UHLlnhpnH0jl5s7Li6orPBpdyyXGcmz432dFkKP45knbzBw4BomTiBWno=@vger.kernel.org, AJvYcCWJ4Bn9B1cMGZg6uSgIAyIxQ8YqbJcOszKOv6UilRBDULtJqLkNfw76gAzCZLoaMv/1BVCGe0sn4ibgDLQh@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXCVuQjifs+/7xNEAka6QK0HjOoGQIDYhq8vZ4NI6eFXwbKq7
	P/EThil05gisJOmDUCmnOyFmk8MFpxht2O6ItNXdJKgnbPysLxs9
X-Gm-Gg: ASbGnctYs8UBuv2BmtFCihRHDnla1/tWUXUC2HXHzeNPH7/+8XFI4KPcQb3MtCsvxhK
	5n8+r53Sp8PpE0M1p2c5/iOpIueSDzGcr5vbG0Xz3Vjk5POuVoB1k68q0VerBAfNaut3S8WmX/9
	8T1xx7qNdXQvYrBQiGarLUb6DXJNzc0aXjGnP1HdRYJxUjaSVG0GDborNfQcFVf01QA+wkhj41V
	vtW0EsxlgJZGKd1AGwW56iVzUBhlSZRUxtgC+OTmx7Rp8afT9SZD0OACUXYyrO/G4Pgi+N+zf3k
	ekcFBTg1kvPGOjhC7mQkeKfptbjH5mgW6nVXZcJutzjr+6uLCF5FliMqANmX+1M+QrUdMJs+4jG
	ylg==
X-Google-Smtp-Source: AGHT+IHDCBgJfM+/ys0ROHnLWBIi5z2k0taelB9+5yUdQur2jxtf7oYUmNm/5oCfY1oM9+jShWu3Ig==
X-Received: by 2002:a17:907:971f:b0:ab6:511d:8908 with SMTP id a640c23a62f3a-ab7f34a0f04mr350523966b.40.1739381804140;
        Wed, 12 Feb 2025 09:36:44 -0800 (PST)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d18e006csm500162466b.52.2025.02.12.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:36:43 -0800 (PST)
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
Cc: Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH v2] clk: sunxi-ng: h616: Reparent GPU clock during frequency changes
Date: Wed, 12 Feb 2025 18:36:39 +0100
Message-ID: <20250212173640.396404-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
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
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 38 ++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 190816c35..884f9a6b5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -328,10 +328,16 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", gpu0_parents, 0x670,
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
 				       CLK_SET_RATE_PARENT);
-static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
+
+/*
+ * This clk is needed as a temporary fall back during GPU PLL freq changes.
+ * Set CLK_IS_CRITICAL flag to prevent from being disabled.
+ */
+ #define SUN50I_H616_GPU_CLK1_REG        0x674
+ static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
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
+	.common			= &gpu0_clk.common,
+	.cm				= &gpu0_clk.mux,
+	.delay_us		= 1, /* manual doesn't really say */
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
+	 * Set the input-divider for the gpu1 clock to 3.
+	 */
+	val = readl(reg + SUN50I_H616_GPU_CLK1_REG);
+	val &= ~GENMASK(1, 0);
+	val |= BIT(1);
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


