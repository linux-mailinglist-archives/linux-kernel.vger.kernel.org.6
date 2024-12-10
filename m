Return-Path: <linux-kernel+bounces-439094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3971D9EAAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6052282328
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376622F381;
	Tue, 10 Dec 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjlkDKFZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EC41C64;
	Tue, 10 Dec 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819455; cv=none; b=ff2oN/hQcPOV5b8BsJQKnOFNUhQgueCd2VVcPDGR9bX3YLRZnuZ5IihsR4pDSzP7J9ioBMu6Kf+gtLzXUXFqCtwrctRYQBp+H8OT+ttdTkc60p82MUcbLNrbglgl9dbE0cIXL3VEhZBcci3+wb0KeJUmuWXyhrLgEjtoM7P2HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819455; c=relaxed/simple;
	bh=NDk1UlnFfI3f7i35JPDdgQRcBUxdeqLzIzQ8s03OAdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPTl2fahuPv46Bgdf/GZUdv/MxHwMHdImF2+McnBt6x6LXht5Px57bvmZJyKbnSuMzYJu3NZO3/1CCiWFBk9uJgD8bsw8KulFuvPKrnJ0z7ZZ17rzAt5MqDCGsEjtlj/61vrncFt9kXOe2taoIyZQGCMXNFuZPAs+sOsUH8xIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjlkDKFZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5134485e87.2;
        Tue, 10 Dec 2024 00:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733819452; x=1734424252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90ZkUIqsBdVLrJBG0q75ZwBWmjhC0C/y0EueSUVYRDg=;
        b=FjlkDKFZ1C/yJOXwMKgsJLcWBCS6POZDvQRszFAPbXjamf5XwG4/JCg8gmczUQ/oPE
         E7qwNFYJwewwq3dus4Hr8a4o6j3nk2vquLOB/Bvd/Ky44qbd0Btu9abNw4xg31m7wX1u
         jdAZcfuNk8Z78OIAVxUcOF39ycvG4TgqW53TPF+Y0Jv4OFIHh9tayYKczsquDHnX/dkQ
         MCa0cN0OdQBQ/l9hxu9V4YKaAXd8Pxizo0fGH2kyEY9Pj/bj5r45pgneLnQS/y9RJzu1
         ZnW11V3mFhBhKldTDGt1/QwbeDYJ8AkKtxmLT7iZuFFDXSZDxPRba9D0mMQ7UoOut5tW
         /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819452; x=1734424252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90ZkUIqsBdVLrJBG0q75ZwBWmjhC0C/y0EueSUVYRDg=;
        b=QW1HzEBXUGMjoI18OJsVRsEBhbQiUbc5v+DZ8JeA5jfo4B+3gdG26pJ4yEIfivLY0L
         GXFgAMxXfxU1dL/CtyfzKgg+bwLc5Lo8U72pItNQzfmH6gS1gOegb3Kcu3SgbXjaN8NK
         KtAe4MRfOh7+oY2CccwUrYZfWBV3iFO7gashxYYmqMHZkoJ40T4IN0vV9VMw4YCKV2vO
         97GaT1cLyQDE5EPjFD6CP7J6d1CAo/i8Qz5uTRaAed7jHeN+cWoI4E99fjV/xVbDDtZQ
         A1cU93z6D6MH/OqJpFToQKSk0RuJKcguuw0iBbYbZ9MQNuXx7+s3fLoy7Wwd/uKj2mj3
         +a5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm13+AkpQlFHSmaSpbEdweEnhqVyA9NfpaDqr9u7+bU0Z3kgSQPtruGZmCxuZTzlcbXXogmb4dSwI=@vger.kernel.org, AJvYcCVGFmQaavhReCARW/HtusaPi9/BzlP5nYSGlO1jiyXLoMmbUNmTzwyygR5oMYjwJG/a0OU9PoAo/mV3hWkE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDWPyvbi+BFw51IJBlWBKubMir2Lobns+tYQ3J6MQ7XKLhpXp
	PEGLDtOfaU68KRTl3w+t6wIeszlrUuXAQ1Yct2K4MT+W53EbCSZFjkMKJ+iuw9M=
X-Gm-Gg: ASbGncsqKr3iNpjPwL21kq/jgeHNp1l5h1PHnoKyAnMXyRFubp9NgA8V5cDYEvn5PLT
	/psQoMDsgFkmRCu90/ES1m3LAmraV7TsRN2eNx293OgwYmeDNKiBn26EsJ5nc1A3QkvVm6ExtLu
	Eqwo7U1AoCHZRD32WCEfb8fZfbjScaiQNOyJLsDnYOz7npYqbONR1OW//kndU0MZPR62IAZpJGj
	vHZniARfV++2QrbL+d57UHPOgU56gpHeZrjEQJho8yBHj7Xczsdt4U8S58iQ22I1IvtWjE60dCw
	0Ai3qTbzF+enEA==
X-Google-Smtp-Source: AGHT+IE5OZMXD5wGIi+gQNBFtFm/8ORVBm/3TlKPK1kt/NeR8RusvkrggIMTg8CDMExbsnpqReNNxg==
X-Received: by 2002:a05:6512:3c91:b0:53e:39c2:f021 with SMTP id 2adb3069b0e04-540240c0e6amr1174314e87.15.1733819451569;
        Tue, 10 Dec 2024 00:30:51 -0800 (PST)
Received: from wpc.yadro.com (host-95-152-63-227.dsl.sura.ru. [95.152.63.227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3745b0bbsm1216804e87.185.2024.12.10.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:30:50 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com,
	Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Yangtao Li <frank.li@vivo.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: thead: Fix TH1520 emmc and shdci clock rate
Date: Tue, 10 Dec 2024 11:30:27 +0300
Message-ID: <20241210083029.92620-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maksim Kiselev <bigunclemax@gmail.com>

In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
is 198Mhz which is got through frequency division of source clock
VIDEO PLL by 4 [1].

But now the AP_SUBSYS driver sets the CLK EMMC SDIO to the same
frequency as the VIDEO PLL, equal to 792 MHz. This causes emmc/sdhci
to work 4 times slower.

Let's fix this issue by adding fixed factor clock that divides
VIDEO PLL by 4 for emmc/sdhci.

Link: https://github.com/revyos/thead-kernel/blob/7563179071a314f41cdcdbfd8cf6e101e73707f3/drivers/clk/thead/clk-light-fm.c#L454

Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 17e32ae08720..1015fab95251 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -779,6 +779,13 @@ static struct ccu_div dpu1_clk = {
 	},
 };
 
+static CLK_FIXED_FACTOR_HW(emmc_sdio_ref_clk, "emmc-sdio-ref",
+			   &video_pll_clk.common.hw, 4, 1, 0);
+
+static const struct clk_parent_data emmc_sdio_ref_clk_pd[] = {
+	{ .hw = &emmc_sdio_ref_clk.hw },
+};
+
 static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x100, BIT(4), 0);
 static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x100, BIT(5), 0);
 static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_aclk_pd,
@@ -798,7 +805,7 @@ static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", p
 		0x150, BIT(12), 0);
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
 static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), 0);
-static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", video_pll_clk_pd, 0x204, BIT(30), 0);
+static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, BIT(30), 0);
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
 static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, BIT(23), 0);
@@ -1059,6 +1066,10 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		return ret;
 	priv->hws[CLK_PLL_GMAC_100M] = &gmac_pll_clk_100m.hw;
 
+	ret = devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
+	if (ret)
+		return ret;
+
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
 	if (ret)
 		return ret;
-- 
2.45.2


