Return-Path: <linux-kernel+bounces-175043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C394F8C197F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E65281877
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984D133405;
	Thu,  9 May 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPq6I4ic"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6212D753
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294263; cv=none; b=tONYzMQa56AG4u97cpllE+9eawmUc4h9E3xLW6r3uGBW64D8axsF3cec/JlJv5tUImj9mnHgUTGGKBBOoN+X0iODQGVOoiRq7eOWO6Cv81igAE5WIcQoJFf6MdhRlMinDGXV2e+LutLf+5A5m8caDwoCi9H0xGq/iEkVFG3/dtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294263; c=relaxed/simple;
	bh=0hHShducaAcMM1humQX/WthNAOeANb5d92F25xx+Ojw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeF9y2duynxkHQPXsPaqJeS4xL3DxyG1cTj2jcVbOfZ9no3+wI2iLgFg88iw74ga5KJ2prYz6hFf/JmhHkX3yS+PsHL5e4fVgoQ4Cgcv2sNc/ufP+pn2E6vEfWuGpWs64fvynU6YtHAveopjaO4sR2qNc+NxSA4l592CegFXb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YPq6I4ic; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5206a5854adso1604246e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294260; x=1715899060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t68VnMD7f5eQp0ZMoa1zqW8nBoF/NRoHSPk2XnhQ8lw=;
        b=YPq6I4icl0cIWSgj3hW7EiLZsv4Npd8VD1ZJGmA1c1n0Ra8PVYko53Q556z6o5tn/2
         2KOnFfho/gLJHUO7HnRrV3696x4r6aGRRru8XZo2KwHNYujkoqHguUy5i1AkAWrI9+CY
         /HMtGxoC5wnsZoDHSmYUTAPia+2X3nIBnYeiiscaHAMJHb+vk3MaBHo60Rs6F6Of3KVU
         g87VMjQZhV6nAMn215sXrqxsUyvojEqIrA67JvgR9znYKu67ONZQTmNf4DK+DqNHbb4X
         i+l4WQ/AP5bC5lH5PAe4vhhdhJGjgPsI3AlDT8j6UVlYqV7kFzYO6AkEcGgUGgmXXboo
         T34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294260; x=1715899060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t68VnMD7f5eQp0ZMoa1zqW8nBoF/NRoHSPk2XnhQ8lw=;
        b=Nu1b7X5AnnMubppiqVnQFd9vsCOGWwvNOO8rf98oYZcT7CkAIUIuFxLkkIKv0sOQHu
         1e4bwgSCWnGRlo2xgKnKsNOBd2vNMS91RhaX1l9vdS1yRWM4n/JiJlFZhES+uNbJyjw9
         RGC6CUaX+Ck64uWxNnHHBXSio0W1fRRvxP625/R1Rt5CfPsZqkx3riA9UdEX3zlQ2Bf3
         sw1Mn8HdkcCaKnMqPjzunSzxBm8mBqOjLZAOFI9eHAbXbUH7DMSwPK9eu3rZTZ/jlfa/
         Vd+zuLHRib+TWi25uFe2bhfjreGbG+1i5iBJJ3GsjEDkWy1lqduEMCm/xhUXMlwvtPYy
         Nhdg==
X-Forwarded-Encrypted: i=1; AJvYcCWGZurzfXnAoX38WIOlpl7M7MPKLTA8ZriyYWeZQ6/63NhHh1tXp4NQKrd0cDN/t85ej+WkkxiHWBem4Q623ABurUrPwqeC5y8EmIAr
X-Gm-Message-State: AOJu0Ywe2QKu+gLWj9a5zmmy0biJeBEQEb24ZFAZytcam7wVGyC2Vm4B
	lWY2wmrl4+Iz5/kazGyfroi6ObYHzoEhkZaHx4VtOinzsivMtb/GO5VjOx/m75k=
X-Google-Smtp-Source: AGHT+IHFA/cX0NP9mCPfOfOYMEWQuBq1O8OW9hOsbV/JoUh2wlE3WrWL4Tbx12X8W80ajNAGYt4JUg==
X-Received: by 2002:ac2:59d0:0:b0:51a:c913:a9ce with SMTP id 2adb3069b0e04-5221016e9b5mr451242e87.50.1715294260157;
        Thu, 09 May 2024 15:37:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:39 +0300
Subject: [PATCH RFC 6/7] drm/panel: lg-sw43408: add missing error handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-6-317c78a0dcc8@linaro.org>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0hHShducaAcMM1humQX/WthNAOeANb5d92F25xx+Ojw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAv7uOuDHmzIgnZl/hgCLHI0ZGC3YAQ6chPy
 Lo2F9poo2qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLwAKCRCLPIo+Aiko
 1X4zCACLyiMXdslsIcAFwHjM5jLM9yNm8VCGKPBgQsAj+QXVcpr+yNuaAhwp3y5hy5dQc+ZmzUL
 xCK65hUPV2jIWvhcGahKYiHJCVmjtLxMAU5mYO2YTCnBnSqgvLrKNuDFSbhbRK+Pk+5Vy3Dio86
 ea1ttyRr4DaTFvL3eEpTEWSbP4S3xrDwP++NQvpqh3R9Zu67Ik8pV2b65uKQcxgtHiImdo3rrEA
 l8k356tA62lWznZWLTrMQHIla//i71FW9KQXHOmO0Cc0XnjU0ahapJPh1pe++Crht0oWU9z9pnM
 5fOf5xjkP3d//Wqc1GxiyIsAbZF081LHg+Q2d+Z+GwoYwpKZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add missing error handling for the mipi_dsi_ functions that actually
return error code instead of silently ignoring it.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 33 ++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 2b3a73696dce..67a98ac508f8 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -62,16 +62,25 @@ static int sw43408_program(struct drm_panel *panel)
 {
 	struct sw43408_panel *ctx = to_panel_info(panel);
 	struct drm_dsc_picture_parameter_set pps;
+	int ret;
 
 	mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
 
-	mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	ret = mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set tearing: %d\n", ret);
+		return ret;
+	}
 
 	mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
 	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
 	mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
 
-	mipi_dsi_dcs_exit_sleep_mode(ctx->link);
+	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->link);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
 
 	msleep(135);
 
@@ -97,14 +106,22 @@ static int sw43408_program(struct drm_panel *panel)
 	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
 	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
 
-	mipi_dsi_dcs_set_display_on(ctx->link);
+	ret = mipi_dsi_dcs_set_display_on(ctx->link);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
 
 	msleep(50);
 
 	ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
-	mipi_dsi_picture_parameter_set(ctx->link, &pps);
+	ret = mipi_dsi_picture_parameter_set(ctx->link, &pps);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set PPS: %d\n", ret);
+		return ret;
+	}
 
 	ctx->link->mode_flags |= MIPI_DSI_MODE_LPM;
 
@@ -113,8 +130,12 @@ static int sw43408_program(struct drm_panel *panel)
 	 * PPS 1 if pps_identifier is 0
 	 * PPS 2 if pps_identifier is 1
 	 */
-	mipi_dsi_compression_mode_ext(ctx->link, true,
-				      MIPI_DSI_COMPRESSION_DSC, 1);
+	ret = mipi_dsi_compression_mode_ext(ctx->link, true,
+					    MIPI_DSI_COMPRESSION_DSC, 1);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set compression mode: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }

-- 
2.39.2


