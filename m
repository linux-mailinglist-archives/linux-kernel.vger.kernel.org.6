Return-Path: <linux-kernel+bounces-535449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589AA47316
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46002188B4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15D1DC9AB;
	Thu, 27 Feb 2025 02:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evzKn7iW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1C1D7995
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623133; cv=none; b=lcme0i8M7kh9oH+TpfakthZ1oXAMIhgVamPTDHhoTw/V2IgH2Y8BOISwJSoKVB3JO43cXZaGjU1w81sQS8guOVczZL1LVH7Z8oeMp8JZZvkV81l3bWeiS4IV3jbSsxvAE8fRFXQoUoKIXSul6KYVcC9UZP9sF7y8aSpsi1BB8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623133; c=relaxed/simple;
	bh=90eJnitNHrEK/bHG/5dquibI/K0ZaJ2fO88HjDQ4Cno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqRf8msXBRglMkXTaslUC6fzGSP4bdsMdZMdBwBdqq83Q8vlPEFOuYB74fir2KzUO70GGU4Mjk8uZ7rapaD5wf0FPYdLRu5UVPFGJi9yx234v4MydE+rbcWn4Xzzm4ksN6JuFLmiIS6XXZVt0e+opjQYhaGLD6ZhAun0O0i+Z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evzKn7iW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462ea9691cso413979e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623129; x=1741227929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+FSEAZwM3JMz4x3mQU5rxG2ANMYWACSorMBKNolQMw=;
        b=evzKn7iWWbKrv3+wYZ9ISmzGdzYUCIaN0Q24hjEiwU5rUrydoQOxXtaJFrjojTWIZX
         8Ca/e2vev2ar3bHoZDq6a+IgptdjG6uzXsprebrfy9E7m1bIh/nAkMIG1cyoQHin0W0N
         cMxLcCmvcAHn31wDacEFiEeVG9UcLW+ScId9el96B6RJ0gF2yAPJwWAgsaBy2Wgh48E0
         17x3l3jKXv/hrjPQN2NZcA6ebtvk3CcCE7FIVG+mKZ/5k3VbyuufUmdQLeKdOR2e8WMN
         jr8b5Zqk9InacnHLqkpSsypTwf5bZyQOUX3UfhPyeDSw2szkAzo4v/g+Lw+vBF6SbNFe
         Aw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623129; x=1741227929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+FSEAZwM3JMz4x3mQU5rxG2ANMYWACSorMBKNolQMw=;
        b=Mz3dv3PODzv5BguQkcgL0TMdYVvgFwI7DpSudR9NXrqWqXeLaTAFxnHM5XefHXQi1i
         t4GogMRfQyxBcjzBFq0j9HD8cmtjdCfNc4YTT+4ss78Zueus8fRr6KjifHaXE7x6K/cQ
         QhgiFrTkrvawWqiciQWi7DvENwTfyLwPQ0MHbahNVizV/ordSSscrDkxcRo24LjwKVoG
         Y7jTRWFRecfYhorD/dsqptHw8pJMGWBCc9aMooFKGZIQ1r7Q+IrEkIejMj9f1d+CxNh5
         sEG18eK4fZEzfASqAzsgXri5tq+sSDnH1fL8kX1+c4pIxUy+tkGDRqnWklz7cCuJrHfZ
         O7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVBxfI6+PCReTORiHY+foxFlvOoifvNjztnm26yd06NGlrclrmr0vxyI2N7pYK2Q2u+osX+qZIzjnKGXvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsR7bgMATTQaGmC75lg/DVMbGy2DtAQo4SeF+7hVLIXo1kQ3l
	TZ7DdKd/jbfVgZedLr9vkxWmt/xxVARnk2eFTKJNEJAxQXL3Yt8hvIQnRcq8xnE=
X-Gm-Gg: ASbGncsET2DTxFJnSSAWy3pepo8i/56kNBN4umlIFE6JtSb37x/pw6f4eChYq66TZ06
	LYQmOUFMsmvH6vCDYbMVo8o1ZfT9Qy0wr196/pru52vBk/0lxD7wZxXFppUAWeaLV4SPf1/ibRp
	FMYHYDzFPTI80bqw2G1fgf1sgpY5qtJWce5B+36mU5yADdcR/0UzbgkL7drKPRwGQvh7EkzI+JY
	MLJ1chk3859b1fflfbwh4EAabdFbCknTgJaeDa7iFuWP9x2N3iG+ueGMEQGN/v0AOagtJuRG0gj
	UO0taiX8Dzt0DTYeSjVfgyVxdqgLlLLcxw==
X-Google-Smtp-Source: AGHT+IEb02nQavOXOTZLj5r926nspuygodhMvivWQgeNEa/oOtFENkgYUEcxBrvNe4iEFFoz5pWyvg==
X-Received: by 2002:a05:6512:3e05:b0:546:2ea9:6666 with SMTP id 2adb3069b0e04-5493c5b8deemr4087543e87.34.1740623128921;
        Wed, 26 Feb 2025 18:25:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:14 +0200
Subject: [PATCH v3 6/7] drm/msm/mdp4: switch LVDS to use
 drm_bridge/_connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-6-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10669;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=90eJnitNHrEK/bHG/5dquibI/K0ZaJ2fO88HjDQ4Cno=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80HoeWx66fTPOHWuISqj9RZhIfWub/BXusDs
 jnSIEMTdsaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBwAKCRCLPIo+Aiko
 1d36CACuMr+t63zgWn7+j7zED/ci+Ofhu2ZBQ/evQCDyDnZRiO8fm4YEz7lHFXz9Rtv5/7JJcO1
 ezS2i1Htlm/LUrkgEJI5s3nXeFhCJ3bHJR2OsWLp0pZSkPPSwt9YXOCAOl/kMLyn/vy9iMBLRxs
 LIiO2HcLyQ3YqjL20YV6wQ9x81NmHdkCQG6tHWXucqev+WFfB4hP6QK+AxHq/0/wtQ+CMBg/w2/
 oi62xsA6tVY7sA8DhLHF/Fz8OL9laAb5l9b8TaLDFutPTs+kSU2VKxyaPyIatg0m0CJFp6HeRPV
 vFsUfWwxonoFOyPMsvRd4JAt5foNYVpHGF5V95qmPyfSU2sT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

LVDS support in MDP4 driver makes use of drm_connector directly. However
LCDC encoder and LVDS connector are wrappers around drm_panel. Switch
them to use drm_panel_bridge/drm_bridge_connector. This allows using
standard interface for the drm_panel and also inserting additional
bridges between encoder and panel.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/Makefile                       |   1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |  34 +++++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h           |   6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |  20 +----
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    | 100 ---------------------
 5 files changed, 28 insertions(+), 133 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 5df20cbeafb8bf07c825a1fd72719d5a56c38613..7a2ada6e2d74a902879e4f12a78ed475e5209ec2 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -48,7 +48,6 @@ msm-display-$(CONFIG_DRM_MSM_MDP4) += \
 	disp/mdp4/mdp4_dsi_encoder.o \
 	disp/mdp4/mdp4_dtv_encoder.o \
 	disp/mdp4/mdp4_lcdc_encoder.o \
-	disp/mdp4/mdp4_lvds_connector.o \
 	disp/mdp4/mdp4_lvds_pll.o \
 	disp/mdp4/mdp4_irq.o \
 	disp/mdp4/mdp4_kms.o \
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 689e210660a5218ed1e2d116073723215af5a187..93c9411eb422bc67b7fedb5ffce4c330310b520f 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -6,6 +6,8 @@
 
 #include <linux/delay.h>
 
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_vblank.h>
 
 #include "msm_drv.h"
@@ -189,7 +191,7 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
-	struct device_node *panel_node;
+	struct drm_bridge *next_bridge;
 	int dsi_id;
 	int ret;
 
@@ -199,27 +201,43 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 		 * bail out early if there is no panel node (no need to
 		 * initialize LCDC encoder and LVDS connector)
 		 */
-		panel_node = of_graph_get_remote_node(dev->dev->of_node, 0, 0);
-		if (!panel_node)
-			return 0;
+		next_bridge = devm_drm_of_get_bridge(dev->dev, dev->dev->of_node, 0, 0);
+		if (IS_ERR(next_bridge)) {
+			ret = PTR_ERR(next_bridge);
+			if (ret == -ENODEV)
+				return 0;
+			return ret;
+		}
 
-		encoder = mdp4_lcdc_encoder_init(dev, panel_node);
+		encoder = mdp4_lcdc_encoder_init(dev);
 		if (IS_ERR(encoder)) {
 			DRM_DEV_ERROR(dev->dev, "failed to construct LCDC encoder\n");
-			of_node_put(panel_node);
 			return PTR_ERR(encoder);
 		}
 
 		/* LCDC can be hooked to DMA_P (TODO: Add DMA_S later?) */
 		encoder->possible_crtcs = 1 << DMA_P;
 
-		connector = mdp4_lvds_connector_init(dev, panel_node, encoder);
+		ret = drm_bridge_attach(encoder, next_bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret) {
+			DRM_DEV_ERROR(dev->dev, "failed to attach LVDS panel/bridge: %d\n", ret);
+
+			return ret;
+		}
+
+		connector = drm_bridge_connector_init(dev, encoder);
 		if (IS_ERR(connector)) {
 			DRM_DEV_ERROR(dev->dev, "failed to initialize LVDS connector\n");
-			of_node_put(panel_node);
 			return PTR_ERR(connector);
 		}
 
+		ret = drm_connector_attach_encoder(connector, encoder);
+		if (ret) {
+			DRM_DEV_ERROR(dev->dev, "failed to attach LVDS connector: %d\n", ret);
+
+			return ret;
+		}
+
 		break;
 	case DRM_MODE_ENCODER_TMDS:
 		encoder = mdp4_dtv_encoder_init(dev);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index e0380d3b7e0cee99c4c376bf6369887106f44ede..306f5ca8f810aaeecea56e74065933bbffcb67ec 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -191,11 +191,7 @@ struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
 long mdp4_dtv_round_pixclk(struct drm_encoder *encoder, unsigned long rate);
 struct drm_encoder *mdp4_dtv_encoder_init(struct drm_device *dev);
 
-struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
-		struct device_node *panel_node);
-
-struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
-		struct device_node *panel_node, struct drm_encoder *encoder);
+struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev);
 
 #ifdef CONFIG_DRM_MSM_DSI
 struct drm_encoder *mdp4_dsi_encoder_init(struct drm_device *dev);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index cfcedd8a635cf0297365e845ef415a8f0d553183..a4f3edabefbd06286bfb8fbcd7f8c0a4281e5ef1 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -14,7 +14,6 @@
 
 struct mdp4_lcdc_encoder {
 	struct drm_encoder base;
-	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct clk *lcdc_clk;
 	unsigned long int pixclock;
@@ -262,19 +261,12 @@ static void mdp4_lcdc_encoder_disable(struct drm_encoder *encoder)
 	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder =
 			to_mdp4_lcdc_encoder(encoder);
 	struct mdp4_kms *mdp4_kms = get_kms(encoder);
-	struct drm_panel *panel;
 
 	if (WARN_ON(!mdp4_lcdc_encoder->enabled))
 		return;
 
 	mdp4_write(mdp4_kms, REG_MDP4_LCDC_ENABLE, 0);
 
-	panel = of_drm_find_panel(mdp4_lcdc_encoder->panel_node);
-	if (!IS_ERR(panel)) {
-		drm_panel_disable(panel);
-		drm_panel_unprepare(panel);
-	}
-
 	/*
 	 * Wait for a vsync so we know the ENABLE=0 latched before
 	 * the (connector) source of the vsync's gets disabled,
@@ -300,7 +292,6 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 			to_mdp4_lcdc_encoder(encoder);
 	unsigned long pc = mdp4_lcdc_encoder->pixclock;
 	struct mdp4_kms *mdp4_kms = get_kms(encoder);
-	struct drm_panel *panel;
 	uint32_t config;
 	int ret;
 
@@ -335,12 +326,6 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 	if (ret)
 		DRM_DEV_ERROR(dev->dev, "failed to enable lcdc_clk: %d\n", ret);
 
-	panel = of_drm_find_panel(mdp4_lcdc_encoder->panel_node);
-	if (!IS_ERR(panel)) {
-		drm_panel_prepare(panel);
-		drm_panel_enable(panel);
-	}
-
 	setup_phy(encoder);
 
 	mdp4_write(mdp4_kms, REG_MDP4_LCDC_ENABLE, 1);
@@ -375,8 +360,7 @@ static const struct drm_encoder_helper_funcs mdp4_lcdc_encoder_helper_funcs = {
 };
 
 /* initialize encoder */
-struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
-		struct device_node *panel_node)
+struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev)
 {
 	struct drm_encoder *encoder;
 	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder;
@@ -387,8 +371,6 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 	if (IS_ERR(mdp4_lcdc_encoder))
 		return ERR_CAST(mdp4_lcdc_encoder);
 
-	mdp4_lcdc_encoder->panel_node = panel_node;
-
 	encoder = &mdp4_lcdc_encoder->base;
 
 	drm_encoder_helper_add(encoder, &mdp4_lcdc_encoder_helper_funcs);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
deleted file mode 100644
index 4755eb13ef79f313d2be088145c8cd2e615226fe..0000000000000000000000000000000000000000
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014 Red Hat
- * Author: Rob Clark <robdclark@gmail.com>
- * Author: Vinay Simha <vinaysimha@inforcecomputing.com>
- */
-
-#include "mdp4_kms.h"
-
-struct mdp4_lvds_connector {
-	struct drm_connector base;
-	struct drm_encoder *encoder;
-	struct device_node *panel_node;
-	struct drm_panel *panel;
-};
-#define to_mdp4_lvds_connector(x) container_of(x, struct mdp4_lvds_connector, base)
-
-static enum drm_connector_status mdp4_lvds_connector_detect(
-		struct drm_connector *connector, bool force)
-{
-	struct mdp4_lvds_connector *mdp4_lvds_connector =
-			to_mdp4_lvds_connector(connector);
-
-	if (!mdp4_lvds_connector->panel) {
-		mdp4_lvds_connector->panel =
-			of_drm_find_panel(mdp4_lvds_connector->panel_node);
-		if (IS_ERR(mdp4_lvds_connector->panel))
-			mdp4_lvds_connector->panel = NULL;
-	}
-
-	return mdp4_lvds_connector->panel ?
-			connector_status_connected :
-			connector_status_disconnected;
-}
-
-static void mdp4_lvds_connector_destroy(struct drm_connector *connector)
-{
-	struct mdp4_lvds_connector *mdp4_lvds_connector =
-			to_mdp4_lvds_connector(connector);
-
-	drm_connector_cleanup(connector);
-
-	kfree(mdp4_lvds_connector);
-}
-
-static int mdp4_lvds_connector_get_modes(struct drm_connector *connector)
-{
-	struct mdp4_lvds_connector *mdp4_lvds_connector =
-			to_mdp4_lvds_connector(connector);
-	struct drm_panel *panel = mdp4_lvds_connector->panel;
-	int ret = 0;
-
-	if (panel)
-		ret = drm_panel_get_modes(panel, connector);
-
-	return ret;
-}
-
-static const struct drm_connector_funcs mdp4_lvds_connector_funcs = {
-	.detect = mdp4_lvds_connector_detect,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = mdp4_lvds_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-static const struct drm_connector_helper_funcs mdp4_lvds_connector_helper_funcs = {
-	.get_modes = mdp4_lvds_connector_get_modes,
-};
-
-/* initialize connector */
-struct drm_connector *mdp4_lvds_connector_init(struct drm_device *dev,
-		struct device_node *panel_node, struct drm_encoder *encoder)
-{
-	struct drm_connector *connector = NULL;
-	struct mdp4_lvds_connector *mdp4_lvds_connector;
-
-	mdp4_lvds_connector = kzalloc(sizeof(*mdp4_lvds_connector), GFP_KERNEL);
-	if (!mdp4_lvds_connector)
-		return ERR_PTR(-ENOMEM);
-
-	mdp4_lvds_connector->encoder = encoder;
-	mdp4_lvds_connector->panel_node = panel_node;
-
-	connector = &mdp4_lvds_connector->base;
-
-	drm_connector_init(dev, connector, &mdp4_lvds_connector_funcs,
-			DRM_MODE_CONNECTOR_LVDS);
-	drm_connector_helper_add(connector, &mdp4_lvds_connector_helper_funcs);
-
-	connector->polled = 0;
-
-	connector->interlace_allowed = 0;
-	connector->doublescan_allowed = 0;
-
-	drm_connector_attach_encoder(connector, encoder);
-
-	return connector;
-}

-- 
2.39.5


