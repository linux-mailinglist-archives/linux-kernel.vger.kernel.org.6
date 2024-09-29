Return-Path: <linux-kernel+bounces-343080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AA98968D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27032B23AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89770433CF;
	Sun, 29 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L9FRhsys"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1E3A8CB
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630873; cv=none; b=GuQf8pIXfjhWD/pTkAirLDs4CwnpomiXoFJWoj3NKW63WSxXZgP5zBCFVhp+3cMuKUUIMroFzPC06xM5ubLtCfIJIugRj6o2uXNWYqzgpyz3L4VX8FsDqgeiQioeVyCMLY1WMkaglF1lXfZMUIgXiweeIOo2Gp6ThBM/bGF9/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630873; c=relaxed/simple;
	bh=F1YZUa0uBs3p0s+UyzZZaIzlz+mQ6JgHZeSITf84o6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBnltYq1hi3c0ohagqDFF31IO9ES0ZB8TYXVdBTMahagh+ltuObMbPPR5bMoJZj0PrC7uqP/D7hRESSuPDuQzew4jyrVhp5zkP8sWZNe/WajkPPaVI3/KdIA1FAlJuNiC82zlTHNPHUsYwmbsh47VoK/r4b29Yt4qddp+kxd0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=L9FRhsys; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d446adf6eso618018966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630870; x=1728235670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlAZxFonTMYipfw1/+w0+N2nElhJYRwH4anfNSm1DKU=;
        b=L9FRhsysx2hsMtZPZ6Db+eIjsokW4zk+pOJ0QW7woZ6twYgb1SA3M9XRgrfOliITzL
         Yq4E/ksLV4ItLGuibsiuNBvhWdOVF33Fw4woBy0Fr4I5F82P5jMPabrUZJVviFG1LLFS
         Z1Qfjo6/9Y3TMaYc2qp/8zKcI/eBsG9YsPGJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630870; x=1728235670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlAZxFonTMYipfw1/+w0+N2nElhJYRwH4anfNSm1DKU=;
        b=Z7CfH3b27a5aVfBQ/Nt9GN4Y8l69sRDCx1qQR+TgNxcBhjxdhpwleB3i9xBMATpxVF
         id878nMGzfURGlwpelzj3c7dH88xKoFCrACURwrm0kkyiqPm3XDUvhHzJtxsjap7HEmE
         rk1idnFGFu6q6XK1O+WV+pxD/fFLiFKwGtlS5P4bIXJ4iQkQizKB5tm/LFFBK1r86fKH
         eQhHXvv5uaDVx36Od1lgOo4Y/Nc6gN1OET0LK4ZS0ud7ry6ElhoBJQWXt560C4Qms2TU
         kxRVX2T4ALLjiAySl3M1GX41p93DbVyjC5Xr73TJjQl5nLiHC6yqCa7zUnUEkNsk1YE/
         /FHg==
X-Gm-Message-State: AOJu0YzeiAcZf8joflOVCjmhcKLKLbENQaO1GojLrYiTN1jLdOv3D8kq
	Wf4EjnFH23rDlqygPuJYxuoPYFa1YSOmYtvNrQivuHD47RiRFViuFs1lDhe+nsviuLvWLRdLtJC
	v1Bk=
X-Google-Smtp-Source: AGHT+IF5EyJXB6BLVT4w8ezS8lVolu33rzxdTtoyzfLSukimbpS2fec5UUuxMdt8Kp8bSewJHtaosA==
X-Received: by 2002:a17:907:7b8d:b0:a90:419f:d8c3 with SMTP id a640c23a62f3a-a93c4a607b7mr981791766b.49.1727630870391;
        Sun, 29 Sep 2024 10:27:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:50 -0700 (PDT)
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
Subject: [PATCH v2 3/6] clk: imx8mm: support spread spectrum clock generation
Date: Sun, 29 Sep 2024 19:27:13 +0200
Message-ID: <20240929172743.1758292-4-dario.binacchi@amarulasolutions.com>
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

 drivers/clk/imx/clk-imx8mm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 342049b847b9..0acf2979c929 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -301,6 +301,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
+	struct imx_pll14xx_ssc pll1443x_ssc;
 	int ret;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
@@ -334,10 +335,14 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MM_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	hws[IMX8MM_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
-	hws[IMX8MM_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
-	hws[IMX8MM_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
-	hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MM_AUDIO_PLL1, &pll1443x_ssc);
+	hws[IMX8MM_AUDIO_PLL1] = imx_clk_hw_pll14xx_ssc("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MM_AUDIO_PLL2, &pll1443x_ssc);
+	hws[IMX8MM_AUDIO_PLL2] = imx_clk_hw_pll14xx_ssc("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MM_VIDEO_PLL1, &pll1443x_ssc);
+	hws[IMX8MM_VIDEO_PLL1] = imx_clk_hw_pll14xx_ssc("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MM_DRAM_PLL, &pll1443x_ssc);
+	hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx_ssc("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll, &pll1443x_ssc);
 	hws[IMX8MM_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
 	hws[IMX8MM_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
 	hws[IMX8MM_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
-- 
2.43.0


