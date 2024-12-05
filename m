Return-Path: <linux-kernel+bounces-433087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4E9E53BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5869B165E68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939191E3796;
	Thu,  5 Dec 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QBGnCqqz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A620E30B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397615; cv=none; b=WDXGs4F8dNxR1zX5utvYWVvaZuASs3owaoB5p7Kz1PL/UGK0R2GzvMcCL0NO3GLbL75++Qjgklw2MDwt31M1K2VJPPJGpt7M4/84N7fQJ8AFjSTPq4j5pqHhAGqD3iCOvGj6loit4kP0K2khZLyxjeDQJIBSWCjw82q79pIR/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397615; c=relaxed/simple;
	bh=nZATu35jIwNzMOu/q32E4DVzYvYaOeYv03dex6aotrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/e+YOXBrnApeDXm/z/acQaLQGMrRhxCDWgP9KmF1hlbvtluuljJLmh1mP7Yj7dT4D2hTfKT6k6Jw/xIdRbHgOAB92RFvtnw8TwRTNjKmR2bjqCyXQegndLWzZVMvFlLaT8V5w1gYtAILZTa9rmqBhOU8TKYGoIHZpfamH6LCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=QBGnCqqz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ab136821so5523a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397612; x=1734002412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9yTySfaJQhr7Fo3SgjYPb/w7zlE9/XQ3JsIQbT3gRE=;
        b=QBGnCqqzeS0xJDWXwdLQPkPzS5gk78VJm+FMXvrinlr45DwF7NL84x11A4jTwu84aU
         fpHlye3rRedPIm/HUb27oUMNtqWcqxRy6002ISweg/zNVKZmeymqdynE94RRhpVnBspr
         InLPwn8cb+fh/xzQdIbIwPzJLZ9aKwdRCK1Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397612; x=1734002412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9yTySfaJQhr7Fo3SgjYPb/w7zlE9/XQ3JsIQbT3gRE=;
        b=tYp+XLsKdEmo3293S0/JNs7Dp1Va+wrElnzOtkUAsX7e+rZ1ZKbdp9xc0c9XKLlft5
         3RFFc+hVMz0hEbbT39412nvYGtCQ+CbB4FRbZpJpedAabMo6i2uj1pl9+323hcVVWYPC
         4iu+E0TWZxzB4JK9B0xKWlLLgencX2xW/ES9hbPFrWFn/OQyQanw8KUWfj78rjRnaFby
         gxTkNMMLPo3xPkV2nvI/Vpzp35LAlbZytQ6yprRlji73/eiZ+ZKAYTWTtg0WJHDUHvs2
         86dcTH1GvdE1PWRvaZNM6wsvX+kt5ZRjVJocNEeBraGM1p3n24e+HRyeR3fYfQjvsnks
         JGhg==
X-Gm-Message-State: AOJu0YyIgeZtZzEIWoya7GOGQ8YmENr+7nHlzKXKzdz2ZX953k7q199S
	qYxZUmBTj/RiW8vU42bWu9uyLCfH0rx+btSKkbYrFjdEYz1AyoXoCsYSLZZcEgQ87AoDAq6HZDQ
	V
X-Gm-Gg: ASbGncsloMegYUSClaebuKwwnSm1UJ7YsVCxUryrHWoFZIyNUve9Kx5eFt4Hplmx8i0
	DvNCleyoYNEb1qE2oxMgLIRo1nBIuch97ARtstpax0hPIsDfUPGHqXK3s0P3nev7Ya8i8t1w9V3
	Po4FF2u+rwoZiZXKz9nII0DjubbknBMid79LHwcg2AGM4YPogYPKFFbf07EQ7gaku+7kcYbfx5o
	PKPo2lTKfoQ4owOR+MTOKKg3JZAwQAChAUyfm9pc1Lj+tnzwPhErpxL1tGYG6DFDjwwKO1KYUvF
	Gyuuqrgv89IAftHWrOSdJQB+7qspfNcFSrfalunuGu+Dag==
X-Google-Smtp-Source: AGHT+IHkC2TdsvU53Arf9R3rEtIlqqSs2877Q+gumRy3NT+TL1A68HMegWO4XXkwBKx6SpYDp0zrGw==
X-Received: by 2002:a17:907:7841:b0:aa6:2987:9a4b with SMTP id a640c23a62f3a-aa629879b08mr105608066b.21.1733397612146;
        Thu, 05 Dec 2024 03:20:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:20:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v5 20/20] clk: imx8mn: support spread spectrum clock generation
Date: Thu,  5 Dec 2024 12:17:55 +0100
Message-ID: <20241205111939.1796244-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for spread spectrum clock generation for the audio, video,
and DRAM PLLs.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/clk/imx/clk-imx8mn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 588cebce6c9d..c61368e724f7 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -306,6 +306,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
+	struct imx_pll14xx_ssc ssc_conf;
 	int ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -338,9 +339,21 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_REF_SEL);
 
 	hws[IMX8MN_AUDIO_PLL1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1);
+	if (!imx_clk_pll14xx_ssc_parse_dt(np, "audio_pll1", &ssc_conf))
+		imx_clk_pll14xx_enable_ssc(hws[IMX8MN_AUDIO_PLL1], &ssc_conf);
+
 	hws[IMX8MN_AUDIO_PLL2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2);
+	if (!imx_clk_pll14xx_ssc_parse_dt(np, "audio_pll2", &ssc_conf))
+		imx_clk_pll14xx_enable_ssc(hws[IMX8MN_AUDIO_PLL2], &ssc_conf);
+
 	hws[IMX8MN_VIDEO_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL);
+	if (!imx_clk_pll14xx_ssc_parse_dt(np, "video_pll", &ssc_conf))
+		imx_clk_pll14xx_enable_ssc(hws[IMX8MN_VIDEO_PLL], &ssc_conf);
+
 	hws[IMX8MN_DRAM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL);
+	if (!imx_clk_pll14xx_ssc_parse_dt(np, "dram_pll", &ssc_conf))
+		imx_clk_pll14xx_enable_ssc(hws[IMX8MN_DRAM_PLL], &ssc_conf);
+
 	hws[IMX8MN_GPU_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL);
 	hws[IMX8MN_M7_ALT_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL);
 	hws[IMX8MN_ARM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL);
-- 
2.43.0


