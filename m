Return-Path: <linux-kernel+bounces-526013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABBA3F8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA46705AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9B21D018;
	Fri, 21 Feb 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/RgqHAc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFA21B9DB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151525; cv=none; b=UyIQu1tsPBQTnovcYJs5NpizXoPTanWWkTrrMHhZkXg0J4RKHy4xiDA+PhH+Z0B6ybSzHTnbj24eF/m2QJSV6dIaoA6qfZin2VezTv6MQpLZa/FrZarQGtLKTwNqDaWVfjRZffMNhy7X0J+BF2g98bX3dU6dUj3clO0tyUpGalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151525; c=relaxed/simple;
	bh=9j53C1+qnm+aHmA6qWXPPt8RIq215xsppk2s0m9XEYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8HhgYj5jdOUqASi0AuRnvzmoD1kTpHhBq1DX3dgzyefF/4E9zZ4N6EsdPZXp/7rRWmcQDsRAYr8/JKMi/wDGAqiAC/9M6A51FQTPk7uCcO2h9BEqKjsavpUjxp3sI/ennmqzNiTxFsJEcG9AKl7l17F6MtGI+qAJzKAEihbvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/RgqHAc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7e08f56a0so39516466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151521; x=1740756321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpEkg4GMgasqkPBaNfAMoUVoblXWdGFYw/zEtAT4EL0=;
        b=A/RgqHAckD0VK4oruJTTslW8SEppQmb2U2teLLnBwZCr/LU4fjFTOEsZPlrIzvZuBQ
         asZDyJLqqxA5S7nLxXIlJtlXULi2/6Z3pZ0Vz+nuEv4Fb3Y0F1WpVDYwBTfNDFKY2Q5F
         fQHuQVqQaNNAFaxb5BRqs0IH5uP/0FMJw/DyXdztXLq2M07nvP3Qnx4My4ae+pdUDBjQ
         1XTv9b2P28PE7RzXCdtClyBH0XsK9y5bBxjWcWbfuSuwltDtfpDMuTRc96bAyZ/gvE4a
         nj4jdRyh19wsw+HdUfPpO7wl9BjoWYT2k2NytoKc3dsIAB/9KTvsrjiS8YVAhlbwXlSZ
         pS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151521; x=1740756321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpEkg4GMgasqkPBaNfAMoUVoblXWdGFYw/zEtAT4EL0=;
        b=ujsWCLkAD4QJ/9Gm9+QGvo6BBm6ftF93mLXch95/JlQTrmnnPYzUxGmxnrm0Tuf5Re
         /esX1Kn2wk1WhOU4BrriVHgp3wQyJfTlBWwcMPrgYVErKK0qswypW+tZsGRRdHkvngGV
         nDCxxMtFxTrD67mlpClSocXPJ5dPWOCPpPGnFYNnweC3U9mMAPPw1n3QYIwOO1m6Ce/E
         d84vUYALTHX5iab99xxvS1G9mgDd3NO98sle6/sORl7++1aTvygk+Y2YS8rXgfJF4uVZ
         yJKKzWOhccSREQeJNyXWnxsp3b7Nl6GTb72wVxjW1/qBQC/J3cl6QbYIweE/Esj3h6az
         K+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcRHlkK2l7g9oCnwxyrPZGquovoWsKAg18+XldwmNM4MWe+92nSmBD94RUvcEsNhuQzzIGZMYsejHeEc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQOGFU0kus7kXOfZpgiQS6DlLTLogiksYkQ9umurTDgsxKQiO
	1h2kzEeasF/Xbn+BJTLtqg0YlKVIyQaN/3al1OUi+yjKl5x5tJskihnAInOH/ok=
X-Gm-Gg: ASbGncuuMouUbxi7ZhUoO1BySzHNILeEyK/jBk2OUMA6D4HV1c+K1jbnHlrNS4HpgAX
	n5yoiWsVIdsHXfLQu8BgCYwxet83WF8Hs1nSMvC5c200GaJhw++lVWHJtgCfwKX7du8O0lnSB3y
	Ad+viT/FyLTcYhTVu91Xg8X/Gj6o2sqz2srpbsUzvGdaaB9MosfLYjzFoVIKl59FDpnx/3eCsFF
	sr8hgi96oyApwcGJpYVcontxT/VVhS+/zbF/u1bZKOJ38Tcz9WiTNDx4O3hn9y1zoBWSriE5kCj
	+1BBHp9A1nVpeeCRmzSuuovglFssd75Flu0+RKi1v80uEznvpN2BzKMEbfMahoLVkPXFpX1xaz/
	z
X-Google-Smtp-Source: AGHT+IH24BBn0meX0MImt6b25+SvtuCGIY1+rdNjvD4vGZrlx4J6rtSdOPUfe5/U/xL1Zrl15FqIEQ==
X-Received: by 2002:a17:907:6ea8:b0:ab7:cb76:1b10 with SMTP id a640c23a62f3a-abc09c0a93dmr134959166b.9.1740151521402;
        Fri, 21 Feb 2025 07:25:21 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:26 +0100
Subject: [PATCH v3 16/21] drm/msm/dsi: Add support for SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-16-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7825;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9j53C1+qnm+aHmA6qWXPPt8RIq215xsppk2s0m9XEYw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJq6fZFNiQhk0030EBCJGxRTKgBFX5NHNk4ZU
 ZoNQLabWNiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iaugAKCRDBN2bmhouD
 15kJD/0UG9LYrnX2e7uYAMFVHbfS9/aCJ9iWHI2ct+K4jPQqzz8I6JmELZMAlY0xPE1Gqsxo3OZ
 Z6e6juvBVf6Rtk1/e87bSnyQB/YbEYzO1w17RNHJX4rQAnq3WWa5ARfeWmkymKy7uD7eGkbPKh6
 4ppd/jES2p7r/D6RGvLkFFFAqhYueRu14iTxyN1+C67stDTYD7TyGCxC6Db9E+cqvetLA4SVKpo
 zmDKfquQ78+JvEXxCc6Aptup9WnmGxn7AN7u/GM9LKcRD4VXX+WUZnHs8p3Ie5BLSucFUlS3wB4
 B9J7iLht8KLr/RRNmsznN+nx3VvSeSuoy01xoXeEDo6OP2ayLznej8jGDPjyIX+GloNgNLCZVda
 WHKd3Jb4ba6zzG1VRdVb0ggeV3u4Di7oZNMGjTwEcBPEN6VDegHobjyIl7nRho2IZguBB4luILX
 LNsceffuLE8VOqQ3gcSXhi05HuG40BUlGULsWSskNyZhCBGtsTSYIAscw4YGNhV6Uj80WNf8WMZ
 0HPMCfe2hLeaR10sapfYnY0fMoTMKi0ZLpsAVUF0u4tWW0zsEXZ+lCxxlW8eUhdWtCNUWgargw0
 r0Go6WGbYJWhCMFCTwBrxB23Lo61tCg9AtaEZnuWzwnIKzUe20EZRCBwhii/kj70MR8PpuXqvCG
 94dkI/u47Hyz5IQ==
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
index 2218d4f0c5130a0b13f428e89aa30ba2921da572..ced28ee61eedc0a82da9f1d0792f17ee2a5538c4 100644
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


