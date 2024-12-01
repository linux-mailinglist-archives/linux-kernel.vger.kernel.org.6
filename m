Return-Path: <linux-kernel+bounces-426704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFD9DF6D6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38636162F4F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE11DE88E;
	Sun,  1 Dec 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CLYHiAyO"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10631DE4FA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075277; cv=none; b=gRdc6YsDqbESAXd3hr4imYG5Phh75kKuceXXx/yObzkpTuPJN9mGhkWVimDCii0vFOD5dIMGJUqZ1V0EBoDRX+YBbp9XRvZs/Wxmvo2cqlqewZbjt6+rQ8Bq815KSpDTfFH8CJ0UiUx1aoxtINtNi2s4fx8H4CnMxEu7TR9EVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075277; c=relaxed/simple;
	bh=nZATu35jIwNzMOu/q32E4DVzYvYaOeYv03dex6aotrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuCtrz7dWcmquWeXXJ3QAakaOK21X0i005wrwt+Qe+JOLYNvo13rsssHST4cEYP20SBOkvHGuQeb/ix/UppiJ0AZ/Vtv7cuX+QrRrIpCBSqbLyDNoD6CP5EX5eeTjbOLYpE9zb3eBpWxgFCwI1puS0MJkpNpxpN2YHYprO/onx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CLYHiAyO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so627235666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075274; x=1733680074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9yTySfaJQhr7Fo3SgjYPb/w7zlE9/XQ3JsIQbT3gRE=;
        b=CLYHiAyObbKP6HMywAKiV1bIWLXQCxW9s/xw30x4/aWcsfnmhdsQxXHLMfGEuTvoUL
         T3utnjyDpyvvS7R1Pm4zdI6y+FTjQKIJMmEXEtFNgYgGxlHtQwsc2d+lIEBoy2tAlrHn
         RKxyIkuY5OgzULvB5F7pcWpfN1kvhDYR0oJis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075274; x=1733680074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9yTySfaJQhr7Fo3SgjYPb/w7zlE9/XQ3JsIQbT3gRE=;
        b=bo1/nN2bU2+2YwzPoIuWyotYz4b/rVNW3xm9VeSVoJDZgzelHiTR0i6FAm8H9yme1Y
         Okmvbmt5f6dmb8Tl041e40FGO2lDquXRlQrEmiSxmT8khlqRDaBa3Udorr3MxtdK8IKN
         WwI4IYJL9hx/4DS58m+LPJpqnsm+crYizsvXVswpXSk4Jm2h64uF1mDozZNniylFZ5pn
         BFUla2mxWKZ6AlXnQIgAoYLtjzvlbAVuxrWLuRTmh82KjRTXKkWbCg6xMQ1mybtnYEGa
         hw7+n878BV0nuL3XogVu2PrPvO7CAgp7vnc7gnt1wIF3q/8REUIBZP3cCX1jBSM0fwWJ
         Vg8w==
X-Gm-Message-State: AOJu0YzgWf55yXE2KioI9xpLsFH2/eSDWGa19vyAtiDQ/s5mhaGi9vzP
	hYPSBVLbFOl8rumFiyd3m0OxNkEAsE/QkgP1seoZJVu/PmAwDpJQSr5m/TFCWmqksmNfLxt3ec3
	1
X-Gm-Gg: ASbGncswZdnE/3Oli7SXC3oaOAAl5BQXRydN/pj+4l/K66aTsnxSi6Z58JVGSb7T9yq
	zz6XEutwXRHfQKHptkAIizZ7ZpO1ibz8g2ufreSTDthi/VEI4j0Leq/VqC+yNtljQl1VqIaSD1G
	4ztEt4LEJReMsAPsrPwu3VmUqZjFvAOH2UWqKflQijGcPL0ia+LwO5C8LLTo0zLNedKNv62K+kd
	8erOXlTNitsJKtlBqLDbYK5YwqiFO+nZkTwMb7NfP+kJiy1nLq7EI2PlmgMhq2e5o5KKRUC8GGa
	tu/Q+rHfcAu06SQvIvOpUDJMk+bHYvpB9gJD50OpTVubiaHSFqHt6twr3l7ot3h87OEEfPL6mXg
	ZYLiCg0NtJ9k8y1Bv
X-Google-Smtp-Source: AGHT+IEHR1z9laXzqUjryQO8q5Ffq5yH85Q8LM2nOnrBHdiW2uHs2gYFItB4lX4kLCeuRgS8cGojqQ==
X-Received: by 2002:a17:907:3683:b0:aa5:500f:56b3 with SMTP id a640c23a62f3a-aa5945ea088mr1602165966b.18.1733075274323;
        Sun, 01 Dec 2024 09:47:54 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:53 -0800 (PST)
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
Subject: [PATCH v4 18/18] clk: imx8mn: support spread spectrum clock generation
Date: Sun,  1 Dec 2024 18:46:18 +0100
Message-ID: <20241201174639.742000-19-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
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


