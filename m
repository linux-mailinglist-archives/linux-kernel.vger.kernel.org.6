Return-Path: <linux-kernel+bounces-556803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFEA5CED8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24E4179736
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD1267706;
	Tue, 11 Mar 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFHKFMld"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC492676DF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719780; cv=none; b=uq0VL6lshYtbQ0NDCAvVgzkDaXlWr5n0h2P0986u0jnIPcHZTk4xAdBs8+hPuWMuJUQO5oU3bJ/BSb+3bq2ef7tyb+l04AxI0u+a73956ncinJuh3JqzI1t7uOeFh1eiIvTwL0CKvmPNOKC4zerQxCAJW8B6uucI6GsPHVSPOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719780; c=relaxed/simple;
	bh=t8FvxqaJdihHwKxgh0Fs0c4phVeJBvGyAmt1zI323ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jk2FxgRQs3sEvTl/VOSrKZysokxiBODbduXFwZPHmQ29olFtkGtXV3qlKaOJ67LZoGg/DdnGzI3GI9BNe4+ijWhPWCZDMnILrWNruiO5iaGeL+7jqGQGZgSnf6tA/MscVGW61pzqGGf9sGRHP5ogebiBkmIcozShcysGpMr3zYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFHKFMld; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so337477f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719773; x=1742324573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz5W4tPqOXg5ur6hXvNsKe6he2272z++grYgIPJznII=;
        b=WFHKFMldHXtRHlP7a2XAraSsXZlI4iqPl7ZTnW9weD7X/BTG51+ryzzMfBsMWJsPnk
         OcElVczIFtUe88pyRaAJuoJhroTJdSDb1YcbHHG+UmVdlWdubfhOGR3oyCzMUlMsgQbz
         rk0k4I5/6TIsPy+BTmLl8B/z6UBUb4S+Z6+TQ/5H6LNpdpQzyKv6cfGAXe/KbhvH+WBH
         j3y/HF99S+t895c8Srtw7qL9MfnEGzVPycd+ZNdpmuCLsDMxKxwJOkIhsj42h/CVoRda
         iB6vbyCZWAID5W8UXuzNFJ85dYn/sqG7nsx6c6RFpSA72adS7S4ZQTqsvJddcEyuNGap
         6d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719773; x=1742324573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz5W4tPqOXg5ur6hXvNsKe6he2272z++grYgIPJznII=;
        b=dft5HajnX90G8mZfN54KaEQxNB+H0I8RgQOCHtP8wVYV1d0ZHP5x0sA7QWRRXV4Nee
         4rscUA7rCHSeJbbruORRnYiOyc3XGvYrQJP/q2XqVVrt7H3JtWA0UWDE29q3kTiwNbUY
         DtC0Ulp5Zrh3Od38heo0w9QjZbqjnkRFTMX0jOEjYDMZBoRDWSQ3FOtpABdnYu6HokPt
         rcQnC7g8olJXK8ccYFw4QjZvbWhDAYMZu62penGUEaqxTsZuYYIpCflQOsax+Pen0naf
         ZNpyAHvHplVCoRQ7WA16sx5ByxkwRhIbhm3m2GjPvKLYREbX/GhHszmP6/O+9XuWze4M
         7S/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcc4HZH2vYATtiuNx+KDigunZzxjQ9dgNAIM2Axby/EMboyJUkgaHPGl8oT1xUWiQ7jnTG7kRCxgscMus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSFOhQlbxeV7MocKpuMit+13V17uv4GuXP8CDnMXEGkRTUQNs
	AtRGMH76gVSCv3rv/x2vtSah/j2H2ByhvaAOreILPX1v6SJ+Afunj4Et0CSRW5M=
X-Gm-Gg: ASbGnctlF/00UxOo9u0o7Dl9H+arzfgDcemL5Fwwayq+G00y7ERc9f2ZB425AdVQSdq
	N8FKYhmuITwHNObaB2foKwSM/uNUxEGJlsCm8I/dFMZFs+B7q4iGEhU57V0ip6Z069l4V0B6uN3
	AauqokyYgF4SJnbXbmcznRUdw+hTk8DlHTikOr0mwM92FZSNsM/qszG1JCq5vIgHc6Mi4P8XUed
	fya3pCvO0ileLV9TkOe26JLuxWIJNE6UjFiEPtsQni09HGLThZuZMYSVrVXyhuJ7S4rJIF0OXni
	gfJgjT6NTi6Az+SMWwhnUtPODRBU4fKmhpmE+TzBOyhhZhoOPJtz30Y4R2Y=
X-Google-Smtp-Source: AGHT+IEYTOfAXHVaqG3d/rJObSxctWgIcna5lwKaQevwYo2r3BlABzF/kGHLFq/kKSeuYJyYKx73Tw==
X-Received: by 2002:a05:600c:1992:b0:439:9b3f:2dd9 with SMTP id 5b1f17b1804b1-43d01c305cfmr25918045e9.7.1741719773452;
        Tue, 11 Mar 2025 12:02:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:02:04 +0100
Subject: [PATCH v4 14/19] drm/msm/dsi: Add support for SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-14-da6b3e959c76@linaro.org>
References: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
In-Reply-To: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7825;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=t8FvxqaJdihHwKxgh0Fs0c4phVeJBvGyAmt1zI323ns=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0Iixn7NwYmY3ZHqvyw5AtyrRe5qhJx/pPyQa8
 W+AfV5Q15OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIsQAKCRDBN2bmhouD
 1xdMD/0TvWZnAqPk3TLKjYBeKWDarZcJI9r5CvK1wzeyO87z5ePjxb83CsKckqpybOVNSqmVxYS
 w+x3Y6nerBHBulfMcq10yfP7BFSMzgzisswbdWqa1Y0N5LBcb/bpBVyoa+Z8mZpwOgJFIO3QuqG
 /ocuhlXXTJ5J2qoshLUGLZVJcukUkh7kXNQ7SIxHVf5MhIiLzCViFqQhuYZSRs90QCLsiEyDq9G
 37HPVkt2jCfEzsmn2tjdd+A2eWwoB0NjtZE2LCXVYtuXMXVaRZC3joqD/mYOWckE/wE+ujAEFTR
 UXHP0VwW2iLxHT+qB1SsewrnDMJByaLfKdlOLSvFROUl6T3x+VP+QXGxevsnar61v51CPM+T5JC
 GZkfSO0UnzjuyIQ5duogostBm1n3Mswd+AIY3vXPmw2czwAJy49LaJxSIOxoMpc/nVoVs/ug2fL
 bZCufyJL/w1kKY/jw8RnTg/jBZDX68cA74/lo4F8mPMUCigwUIgyrOgG3Y9o5mAOJSfnT4rdZXy
 qh1l1tf3Ct/r+y40U3Im89J2gk+yDPNcgfOE9BIW3uOm1npd7DSieX4gRnHllCksEqWjBE9Vixk
 ZPJ0pgF+pY3Ulj9OLGx0VCxR7m+AG+rbO8xVQQZpj4KwMxwcR5EINxLobRWQP7cSyHWIRaDbqqY
 lGoc1ojDfoMoVgQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add support for DSI on Qualcomm SM8750 SoC with notable difference:

DSI PHY PLLs, the parents of pixel and byte clocks, cannot be used as
parents before DSI PHY is configured and the PLLs are prepared with
initial rate is set.  Therefore assigned-clock-parents are not working
here and driver is responsible for reparenting clocks with proper
procedure: see dsi_clk_init_6g_v2_9().

Part of the change is exactly the same as CLK_OPS_PARENT_ENABLE, however
CLK_OPS_PARENT_ENABLE won't work here because assigned-clock-parents are
executed way too early - before DSI PHY is configured.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Drop 'struct msm_dsi_config sm8750_dsi_cfg' and use sm8650 one.

SM8750 DSI PHY also needs Dmitry's patch:
https://patchwork.freedesktop.org/patch/542000/?series=119177&rev=1
(or some other way of correct early setting of the DSI PHY PLL rate)
---
 drivers/gpu/drm/msm/dsi/dsi.h      |  2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 14 +++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 80 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 87496db203d6c7582eadcb74e94eb56a219df292..93c028a122f3a59b1632da76472e0a3e781c6ae8 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -98,6 +98,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi);
 int msm_dsi_runtime_suspend(struct device *dev);
 int msm_dsi_runtime_resume(struct device *dev);
 int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host);
+int dsi_link_clk_set_rate_6g_v2_9(struct msm_dsi_host *msm_host);
 int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host);
 int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
 int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
@@ -115,6 +116,7 @@ int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *iova);
 int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *iova);
 int dsi_clk_init_v2(struct msm_dsi_host *msm_host);
 int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host);
+int dsi_clk_init_6g_v2_9(struct msm_dsi_host *msm_host);
 int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
 void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 7754dcec33d06e3d6eb8a9d55e53f24af073adb9..7f8a8de0897a579a525b466fd01bbcd95454c614 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -257,6 +257,18 @@ static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
 	.calc_clk_rate = dsi_calc_clk_rate_6g,
 };
 
+static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_9_host_ops = {
+	.link_clk_set_rate = dsi_link_clk_set_rate_6g_v2_9,
+	.link_clk_enable = dsi_link_clk_enable_6g,
+	.link_clk_disable = dsi_link_clk_disable_6g,
+	.clk_init_ver = dsi_clk_init_6g_v2_9,
+	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
+	.tx_buf_get = dsi_tx_buf_get_6g,
+	.tx_buf_put = dsi_tx_buf_put_6g,
+	.dma_base_get = dsi_dma_base_get_6g,
+	.calc_clk_rate = dsi_calc_clk_rate_6g,
+};
+
 static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 	{MSM_DSI_VER_MAJOR_V2, MSM_DSI_V2_VER_MINOR_8064,
 		&apq8064_dsi_cfg, &msm_dsi_v2_host_ops},
@@ -300,6 +312,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 		&sm8550_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_8_0,
 		&sm8650_dsi_cfg, &msm_dsi_6g_v2_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_9_0,
+		&sm8650_dsi_cfg, &msm_dsi_6g_v2_9_host_ops},
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 120cb65164c1ba1deb9acb513e5f073bd560c496..859c279afbb0377d16f8406f3e6b083640aff5a1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -30,6 +30,7 @@
 #define MSM_DSI_6G_VER_MINOR_V2_6_0	0x20060000
 #define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
 #define MSM_DSI_6G_VER_MINOR_V2_8_0	0x20080000
+#define MSM_DSI_6G_VER_MINOR_V2_9_0	0x20090000
 
 #define MSM_DSI_V2_VER_MINOR_8064	0x0
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 4d75529c0e858160761f5eb55db65e5d7565c27b..8ebcfd307779b8dfd35c64d3fea34123a5d0751b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -119,6 +119,15 @@ struct msm_dsi_host {
 	struct clk *pixel_clk;
 	struct clk *byte_intf_clk;
 
+	/*
+	 * Clocks which needs to be properly parented between DISPCC and DSI PHY
+	 * PLL:
+	 */
+	struct clk *byte_src_clk;
+	struct clk *pixel_src_clk;
+	struct clk *dsi_pll_byte_clk;
+	struct clk *dsi_pll_pixel_clk;
+
 	unsigned long byte_clk_rate;
 	unsigned long byte_intf_clk_rate;
 	unsigned long pixel_clk_rate;
@@ -269,6 +278,38 @@ int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host)
 	return ret;
 }
 
+int dsi_clk_init_6g_v2_9(struct msm_dsi_host *msm_host)
+{
+	struct device *dev = &msm_host->pdev->dev;
+	int ret;
+
+	ret = dsi_clk_init_6g_v2(msm_host);
+	if (ret)
+		return ret;
+
+	msm_host->byte_src_clk = devm_clk_get(dev, "byte_src");
+	if (IS_ERR(msm_host->byte_src_clk))
+		return dev_err_probe(dev, PTR_ERR(msm_host->byte_src_clk),
+				     "can't get byte_src clock\n");
+
+	msm_host->dsi_pll_byte_clk = devm_clk_get(dev, "dsi_pll_byte");
+	if (IS_ERR(msm_host->dsi_pll_byte_clk))
+		return dev_err_probe(dev, PTR_ERR(msm_host->dsi_pll_byte_clk),
+				     "can't get dsi_pll_byte clock\n");
+
+	msm_host->pixel_src_clk = devm_clk_get(dev, "pixel_src");
+	if (IS_ERR(msm_host->pixel_src_clk))
+		return dev_err_probe(dev, PTR_ERR(msm_host->pixel_src_clk),
+				     "can't get pixel_src clock\n");
+
+	msm_host->dsi_pll_pixel_clk = devm_clk_get(dev, "dsi_pll_pixel");
+	if (IS_ERR(msm_host->dsi_pll_pixel_clk))
+		return dev_err_probe(dev, PTR_ERR(msm_host->dsi_pll_pixel_clk),
+				     "can't get dsi_pll_pixel clock\n");
+
+	return 0;
+}
+
 static int dsi_clk_init(struct msm_dsi_host *msm_host)
 {
 	struct platform_device *pdev = msm_host->pdev;
@@ -370,6 +411,45 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 	return 0;
 }
 
+int dsi_link_clk_set_rate_6g_v2_9(struct msm_dsi_host *msm_host)
+{
+	struct device *dev = &msm_host->pdev->dev;
+	int ret;
+
+	/*
+	 * DSI PHY PLLs have to be enabled to allow reparenting to them and
+	 * setting the rates of pixel/byte clocks.
+	 */
+	ret = clk_prepare_enable(msm_host->dsi_pll_byte_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable dsi_pll_byte: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(msm_host->dsi_pll_pixel_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable dsi_pll_byte: %d\n", ret);
+		goto out_disable_byte_clk;
+	}
+
+	ret = clk_set_parent(msm_host->byte_src_clk, msm_host->dsi_pll_byte_clk);
+	if (ret)
+		dev_err(dev, "Failed to parent byte_src -> dsi_pll_byte: %d\n", ret);
+
+	ret = clk_set_parent(msm_host->pixel_src_clk, msm_host->dsi_pll_pixel_clk);
+	if (ret)
+		dev_err(dev, "Failed to parent pixel_src -> dsi_pll_pixel: %d\n", ret);
+
+	ret = dsi_link_clk_set_rate_6g(msm_host);
+
+	clk_disable_unprepare(msm_host->dsi_pll_pixel_clk);
+
+out_disable_byte_clk:
+	clk_disable_unprepare(msm_host->dsi_pll_byte_clk);
+
+	return ret;
+}
+
 int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;

-- 
2.43.0


