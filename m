Return-Path: <linux-kernel+bounces-343081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C141D98968F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D651C20F80
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A0537E9;
	Sun, 29 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Hq6lMwtA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905E433C9
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630877; cv=none; b=DDimkrzB9uKdZH2PMy5f2hFJQVYy7Z544nDdOnDNKn87Hs+rOrwovt5GpXZUA8u52zSm32jufVFHqiNerd62IvrRGsnwC5m28S3l494Y/G2zGMzvbiksFaamDvCOwCN/fLtGtO8akw9S+s1SnWadQu4Xdqqj8GgbUUmeL8oEZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630877; c=relaxed/simple;
	bh=Wgv+/HWcXNYqtqEA0RPOt5fYJas9b80J8xiOGZ09A/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLvi8oqQQDZLpiW5J9ILZuQoNQZNuxdiQfa1t1FzprxNE0ACGFu7tRq0RnLs4smiRt8fDBaQyqJFb7GgZRxP1NktDvWtg3NIwprMF7QdZqfKjfpMe4X/Oi4LsmpuiS+rAgfg/MXBIKcz5EFUekmERylDEpESouJVe/FAAGqZYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Hq6lMwtA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso668026666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630873; x=1728235673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7j0vOxwdIuLpD77WK2SWPTcyyL5hPZ0rRLo8GOdwiU=;
        b=Hq6lMwtAD2DChcr9h7guiteIt3KzsZ8OPvy/nms2/DZXqdEBgWP4U7QhUk2iAw3Q8/
         J+3n6zBQXZeTBSjybcZwJhSXJNwD/rxk+xH8noweSDvrB6rfNe9WsYZHXO04PqUO6lPp
         06d+K05AzwfBPsIyxJDd1OGAnOVKjUl2g501A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630873; x=1728235673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7j0vOxwdIuLpD77WK2SWPTcyyL5hPZ0rRLo8GOdwiU=;
        b=T1APfpx/YPhagtlipGlYHkd1WrHxW3PRgVmqfTqyrelj67ajxLtt77GR03MnBnZiNK
         +cgrnGY6raK5Z4mwBfF6ztS+wu4XHPI0SDRFbuRmIcUErMXDDQ+w2sRdaHtwl+DXO0lH
         onJ/CZoUhHGmDbb+0V7PJrCb3KrEam/H0Wb3AD2QOR+oOL4GdRFDNfsHkqxHx6mYswgo
         glVkA7KB23BBuRGdjryfA12iedhqg9QIAetyrmqa6rDv45bEtkG4VzevQSFloiCn8sxJ
         F98nMWoDeIAPZHhxuuu3qBpJxcl3VIi0SKsa8Nh00PShh63lHa5VVe6hNxUu0QJfA5En
         6Agg==
X-Gm-Message-State: AOJu0YxHNprT/RCMN3AmQiBO9Gt8oO5hJrwONuwCJCiL/Mlnjw1gTW3Y
	6KVpl4VbEv45DJlP8WQNEROsL/rNlfMr2G73h6pnNUwszc1AFXgmSOBm4D+A04GGXgwMimN/LFG
	sZX4=
X-Google-Smtp-Source: AGHT+IFGFzdbP7v+VVZM0XVmIyCLSRIrz892t1qCo04UZ5WzOKuy2d0YwcdtUYh77K2CgaYdMJ8Ffg==
X-Received: by 2002:a17:907:749:b0:a8d:41d8:14ad with SMTP id a640c23a62f3a-a93b1679b22mr1493843566b.29.1727630872356;
        Sun, 29 Sep 2024 10:27:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:51 -0700 (PDT)
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
Subject: [PATCH v2 4/6] clk: imx8mn: support spread spectrum clock generation
Date: Sun, 29 Sep 2024 19:27:14 +0200
Message-ID: <20240929172743.1758292-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
References: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds support for spread spectrum clock generation for the
audio, video, and DRAM PLLs.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mn.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ab77e148e70c..b33590a9b7b7 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -321,6 +321,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
+	struct imx_pll14xx_ssc pll1443x_ssc;
 	int ret;
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
@@ -356,10 +357,14 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
-	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
-	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll);
-	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_AUDIO_PLL1, &pll1443x_ssc);
+	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx_ssc("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_AUDIO_PLL2, &pll1443x_ssc);
+	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx_ssc("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_VIDEO_PLL, &pll1443x_ssc);
+	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx_ssc("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_DRAM_PLL, &pll1443x_ssc);
+	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx_ssc("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll, &pll1443x_ssc);
 	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
 	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
 	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
-- 
2.43.0


