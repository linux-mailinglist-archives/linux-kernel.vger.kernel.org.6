Return-Path: <linux-kernel+bounces-343083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FD989693
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C9283C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB574BE1;
	Sun, 29 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mjd9rIgy"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C95466B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630880; cv=none; b=WgM9C1OToI1RwX1ZGkWddNAjCDOJAcbakJ/uVWdeTYA6mLWWwPNuaYlE9LWS86kkUK18xv8e3TE7gfIT44AzvglgsXGQ+4PU0jPCFvqotWO9h8J5uVx1iRVzQr/wYwc1g4Vd6wbAQAXJ1PnYWVYCr+ACoEig1iNdDFQqNVg/mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630880; c=relaxed/simple;
	bh=Ug7wY8jPGPHXKlaEJWDLzwP2YJRZZ0pjcvr+/Y2WFTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7bP+ifeZ0cQ84jeDKESVDgYFQXNQxvMLO3iLMzV4AVMUxRoI8e200+/0wWZOGp5cwAhNKhhoQNBBWpnQfRJYr06yy+5M9aYuKeUh+kRuKKet78II5AQDw7EjWb/x7CIPZ7FsWF6i0zkGLkghs5Y4Aw1V4NMOaqmDb+3wLA9apQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mjd9rIgy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso575185566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630876; x=1728235676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0iBp/WuiGBbwsQFlblUsJsTztRh00umfcE38KK4N/I=;
        b=mjd9rIgyX9GxmSpEmUu7uwgD2LDP/qz66a0VwV6m1I5pXL5w6KlKTcDFKd4sy0LA6O
         SHIY8R7bhLuLzI636+w9O5cNQLadR8VK7LcqxgUSLdY0GqLtBxy5ofdyd9DSTTpKf5Xd
         hhs2AQIVkO2MnxB6xjDGjSWevJAhcJTCj3J7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630876; x=1728235676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0iBp/WuiGBbwsQFlblUsJsTztRh00umfcE38KK4N/I=;
        b=pjk1GDVqew/+TXxKw7fKKIiY416WBEkzjqWtsq4+6dvxPQZPHdZ3238L/+gP5FzTvO
         3FIltPcDtVjw2CVJNAOI399NSxPdSyelwtMCNC+IcJruMlF/HYb94rhc+XKZydmJQjbv
         UXBgPghUVCNXmHHUXmxA089gl0rDGpfIPE+m6KAP0Gj1bDv5DIvMmdCQ8ETdYt7W7du1
         8kNrq2Kt0X2n69wnZS9RR63EU7vFNdgSN01qVu2WBvEC4KuSLlT1eMsazm7PfWbKPehA
         FeDPu7M/lW2e07VyD7vVKT2/yNBgodx1jNGvnxOPaLlyLVrf+PYBVX2KcbPwPRfNOsQS
         g6uA==
X-Gm-Message-State: AOJu0Yx4A2mGbu6fnxFYVHJbseLNZBOrOBlrEwXsC6uPO5VMtHcXx/UT
	HsyhsoI0JzFJImE4sJhdIKVruBxiTg53TaGrhxc8HmsCaxgjuWXoQboHRo+XOv80V+Qcn7GWPjm
	IghE=
X-Google-Smtp-Source: AGHT+IGLXVyYvBPaOSAKwxQv4nClWIr3rmZocj2kb4LCU/k1nVaoIjd/hf0Piycmvcx3tLSB+8EClg==
X-Received: by 2002:a17:907:6d20:b0:a8a:8c92:1c9c with SMTP id a640c23a62f3a-a93c4967869mr949147066b.29.1727630876427;
        Sun, 29 Sep 2024 10:27:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:55 -0700 (PDT)
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
Subject: [PATCH v2 6/6] clk: imx8mp: support spread spectrum clock generation
Date: Sun, 29 Sep 2024 19:27:16 +0200
Message-ID: <20240929172743.1758292-7-dario.binacchi@amarulasolutions.com>
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

 drivers/clk/imx/clk-imx8mp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b2778958a572..460e8271def5 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -410,6 +410,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np, *anatop_np;
 	void __iomem *anatop_base, *ccm_base;
+	struct imx_pll14xx_ssc pll1443x_ssc;
 	int err;
 
 	anatop_np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
@@ -449,10 +450,14 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_SYS_PLL2_REF_SEL] = imx_clk_hw_mux("sys_pll2_ref_sel", anatop_base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MP_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", anatop_base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	hws[IMX8MP_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll);
-	hws[IMX8MP_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll);
-	hws[IMX8MP_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
-	hws[IMX8MP_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll);
+	imx_clk_pll14xx_get_ssc_conf(anatop_np, IMX8MP_AUDIO_PLL1, &pll1443x_ssc);
+	hws[IMX8MP_AUDIO_PLL1] = imx_clk_hw_pll14xx_ssc("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(anatop_np, IMX8MP_AUDIO_PLL2, &pll1443x_ssc);
+	hws[IMX8MP_AUDIO_PLL2] = imx_clk_hw_pll14xx_ssc("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(anatop_np, IMX8MP_VIDEO_PLL1, &pll1443x_ssc);
+	hws[IMX8MP_VIDEO_PLL1] = imx_clk_hw_pll14xx_ssc("video_pll1", "video_pll1_ref_sel", anatop_base + 0x28, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(anatop_np, IMX8MP_DRAM_PLL, &pll1443x_ssc);
+	hws[IMX8MP_DRAM_PLL] = imx_clk_hw_pll14xx_ssc("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll, &pll1443x_ssc);
 	hws[IMX8MP_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", anatop_base + 0x64, &imx_1416x_pll);
 	hws[IMX8MP_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", anatop_base + 0x74, &imx_1416x_pll);
 	hws[IMX8MP_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", anatop_base + 0x84, &imx_1416x_pll);
-- 
2.43.0


