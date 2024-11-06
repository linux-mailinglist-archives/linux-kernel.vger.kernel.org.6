Return-Path: <linux-kernel+bounces-397889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04CE9BE1F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A200B23241
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93A1DE2BA;
	Wed,  6 Nov 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BT0Kw9mC"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307F1DF24E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883980; cv=none; b=qCQJTs1x04Xx5lLyGgaM+Xo8Ya+Ev4hvIQbj4Q2aySpyWhkqUS4ZPNGHjnjnKrRIniTY4fI5ZsxUiRSkUGWQ3jUbMgn/QNoUK+EmKUG5HJm/nZYwSoG9SH4gEUJGvddhQdSIrJo40goHl8hjgkejOPepzqcFm55UOz9vG1fONdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883980; c=relaxed/simple;
	bh=VHXKQi9VZmAgjKyf/s8nZ7wpCgJ6T8S6/7VeEB0Z6lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHnQBfutcM3HEg99/a1kyk4//rDeg4ulTuQR8htESfn8sTwfcymZq5EDj/ZPCtmok3s41pPdl11KGOEIyrlcpbnp2egRJasj87NwgniWQNGzDIy/GWaKLZFZ7mFJv+cXjd2XDogOnirDdsMp93GDZDFy1yRZ0Ye9mFnl4qHrPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BT0Kw9mC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso9011485e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730883976; x=1731488776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk3reyPLNpPW1T5hBq9gLHNsgFGFKl4S7Oe3HhKsMOw=;
        b=BT0Kw9mC6caUahnmTqSAxOf4NkbABGxsC0ke9PU/enJOmrM/yUREatMguPTbSeYkDq
         OiSkuE0oPuZKFL2E++JHHVCFWSV+L/mV6oSZ0rcHg3J5BL7fj860aSKZre5cr5QGK0cF
         4T4MDFnE3ToIuSgv+yOSswN7VZ+mMmzrCDEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883976; x=1731488776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk3reyPLNpPW1T5hBq9gLHNsgFGFKl4S7Oe3HhKsMOw=;
        b=jAuxUn4bnfOeRgmH9J/Ph4sTP3xzDzt7P6ttPilg1VeJRINY9NFxLnZopUhqVZPXZi
         6nTP4xZaoNTPiitmMGY8Cln8LYivuFq+fZYjvM+FYndv7CTEZLspkUPLBILkBUKCQGfE
         geoR2ldzDaCuZW4xg9wrVWX7FRHcWP4mTTEM39PdvzvDgHwnIiL/BqXRouarvRqJz4AU
         IdBeGeSwQQcc+jiRNa5aSnDDhz+o8CqtfxbVVlrp0rZcG5ACEAsLYmqoET35li4AeUTn
         k/U8t458jypr2VaiGAgQ/FncoGDyJm3DMocSulfRYWuAxverKV0Dd/VCkmrN/Bq07ub8
         jChw==
X-Gm-Message-State: AOJu0Yw1OuGpd/EKTAV6T/iiw7OxbqsPu/tEuNpG4Shc03+CbXl1GW99
	+3cR6zB+zCpl7hbNTbQdkIUm0OCkF3r3/Vx5SSrrNsO5QzWwoa/8AvGKRW5h9M/P3b25OquMYR1
	K
X-Google-Smtp-Source: AGHT+IFfiGc0K4IbypV9SvZMfMNxXdKGIpD8FKjB2HVHQBbxWo+3XOmyQxGHdE3l/c9HDP8UE/3JzA==
X-Received: by 2002:a05:6512:159c:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53d65e16881mr13255338e87.55.1730883976448;
        Wed, 06 Nov 2024 01:06:16 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:afb5:f524:6416:8e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9422sm247781366b.139.2024.11.06.01.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:06:16 -0800 (PST)
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
Subject: [PATCH v3 6/8] clk: imx8mn: support spread spectrum clock generation
Date: Wed,  6 Nov 2024 09:58:02 +0100
Message-ID: <20241106090549.3684963-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Use ccm node device

 drivers/clk/imx/clk-imx8mn.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index feefc9ef4f51..91b819d1c523 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -322,6 +322,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *anatop_np;
 	void __iomem *base, *anatop_base;
+	struct imx_pll14xx_ssc pll1443x_ssc;
 	int ret;
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
@@ -357,13 +358,18 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", anatop_base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", anatop_base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll);
-	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll);
-	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
-	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_AUDIO_PLL1, &pll1443x_ssc);
+	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx_ssc("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_AUDIO_PLL2, &pll1443x_ssc);
+	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx_ssc("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_VIDEO_PLL, &pll1443x_ssc);
+	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx_ssc("video_pll", "video_pll_ref_sel", anatop_base + 0x28, &imx_1443x_pll, &pll1443x_ssc);
+	imx_clk_pll14xx_get_ssc_conf(np, IMX8MN_DRAM_PLL, &pll1443x_ssc);
+	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx_ssc("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll, &pll1443x_ssc);
 	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", anatop_base + 0x64, &imx_1416x_pll);
 	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", anatop_base + 0x74, &imx_1416x_pll);
 	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", anatop_base + 0x84, &imx_1416x_pll);
+
 	hws[IMX8MN_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
 	hws[IMX8MN_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
 	hws[IMX8MN_SYS_PLL3] = imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel", anatop_base + 0x114, &imx_1416x_pll);
-- 
2.43.0


