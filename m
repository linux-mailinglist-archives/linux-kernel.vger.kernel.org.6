Return-Path: <linux-kernel+bounces-175044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232258C1980
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC14281ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E51339AB;
	Thu,  9 May 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPGP/b1V"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E912D775
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294264; cv=none; b=D6z+sevKVZGm4Zxi00QN82NvjSrZ4cr2vngNeEPy2SOhJvTMRjwKKSPESMh0lUduNb0o3/NNZfLvS5VM+HfAFMPZLq42LoeSoelaOCceBSTYRqMTRRNq1SHcsd9QDzeIH4psk80I2ZHYWglwqfMjrE/rMq1xbvYEauoF4u9tJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294264; c=relaxed/simple;
	bh=GUWCnr41TB+Guk2h1/zSROPDGudIEU9m291d3/Tj7jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dd5GSCBb/k/q+eD7U/TzORL16moZcRh1h5l8CR1uExDdpw8ZuleWmBUKed9yPTJb4+JXkUJbTC02qxaXRwBF5xa3uASOKEc3qnNr5mfQPVCN0DDMqXnYVUHmTwt6z7O7QVoO0AQkcmOB2Rt2AqGyucDoL/f5xAA+NzEwd3E4nlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPGP/b1V; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f60817e34so1722710e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294261; x=1715899061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V9OACuRHbXmTK2HTg8i0N9cnf1QLVjm1D07G84y0Mc=;
        b=QPGP/b1VPRIkuWBbyLfoZMA5MLHDqiQCB9ItPEPiPxChaTQODgCYDzCYKTX5Jp17Pc
         9WSiEuvpsgDzDfnS0Lfd+J58wXt4hlM1nwd+mbdj090GjlL8rouw5yDPgFWibi3Q5OW4
         UotU+rR9nh6waipK7ZgD9BDblQ0VjWR0wK1fYGz8UY9u5YFyUvioePiLYQRgTNB1lAMS
         hRcdqvrxNN9YICeO/3DeJ8tPY3z0gkW57lJhos/Rde+vZrZBdVWlq4CXMOWawXAKWwkm
         d3IyQbKAFPaeESCYa6ZtU+hCnueoOzeK/5t6I7FlgrVgVxteE9sUgnEf4rHzegMcyoeH
         UjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294261; x=1715899061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V9OACuRHbXmTK2HTg8i0N9cnf1QLVjm1D07G84y0Mc=;
        b=MflDeuHtnn6n58pwDskaK/1qmmjRaEGLwnr4DHXJoGZsDjwnr91Jzl8E0YCXdynZSx
         zBG683767WU6Dj5vm/fkNGqBxIpzIQ7+Cm1zeCoa+/8dgesFZz/SoqAz0SCLOp8WKLY+
         NSWWIlmERmhEfF4AFsw5N1pazHzhA8rClfPhxuW0dR9VvsB7hXJkSo/eOEHGVj6xjru1
         MpsqJ+6i+M1XUAHciQAJtgpMrR50iCxsaneUt3z1ro4u2gHGWIn/TQ3SQ+qdRAynH3Kd
         RC1yeduU0yCXNwM9NLmgd4YUGFiNxF7Z/ZhYNamrWCVHtC9H5PaLAVr9VOIbopcnya0q
         xUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmoS0jSBE7XJwC+luYJr39LzYtYjb+KVsKihDYbtRj8A06nNcX4iRYCA/1ZrEsI+9A+wAPz+NWxGDBZC70zPCnIAk219Lm44RYJus2
X-Gm-Message-State: AOJu0YwvKTSvUEKv0nGCXrgr8Bp40emCxcdCvvm8YUkj+h1nySy5iAzj
	de3Hv8Xhuq7TZdWtYqdGu8Yzcd1coIDKdp1EoFgOzL0QOJL6SeuugE4Qy9zVm6g=
X-Google-Smtp-Source: AGHT+IH4bxmqWpDeL+ZzttXl0YgWZBnt+QPrn2JZIDE00Yte/ysK+RFkfP2uB4AOozawEkV0ixvYWQ==
X-Received: by 2002:a05:6512:33ce:b0:513:edf4:6f20 with SMTP id 2adb3069b0e04-5220fe79457mr584485e87.54.1715294260804;
        Thu, 09 May 2024 15:37:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:40 +0300
Subject: [PATCH RFC 7/7] drm/panel: lg-sw43408: use new streamlined MIPI
 DSI API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-7-317c78a0dcc8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5760;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GUWCnr41TB+Guk2h1/zSROPDGudIEU9m291d3/Tj7jk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAvVHEpsHtQ0Di+uIOFvItselZiMK+9r+UUI
 k5OzkP5BZSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLwAKCRCLPIo+Aiko
 1Q3LB/9UnKKgdFuiCU5XHDbX1us37+pggofnVIlW3X8wgOEa4mWSE/6EpOUFQ2lzlJtqOZhs9jN
 XAwNM2NpoWTDGpXVFo5yOeHuRKKLPxVrjCr5C1DSPtnVqjEIn/tNYhAkRkA+r/rhHFS8KC8SL9i
 DIOibWPdbZmUfQybcPMc1IT7xP65iKfVbHo00p3VdDODEFC41reHt3GP6FeYnCT3KTQQsSMaBo0
 cW704hv6ADVO6lAqo95JjqZizVkt6YBuDuGyOI2kuLEzOza3qcWH1z+eIMNQPbgJ3FxihDg57Gr
 WoYpZp4zDFXGsnXHCgW6qDEK58pAHGDm8h1UxN+aRTsVSr8a
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use newer mipi_dsi_*_multi() functions in order to simplify and cleanup
panel's prepare() and unprepare() functions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 95 +++++++++++++-------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 67a98ac508f8..f3dcc39670ea 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -40,104 +40,83 @@ static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
 
 static int sw43408_unprepare(struct drm_panel *panel)
 {
-	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	int ret;
 
-	ret = mipi_dsi_dcs_set_display_off(ctx->link);
-	if (ret < 0)
-		dev_err(panel->dev, "set_display_off cmd failed ret = %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->link);
-	if (ret < 0)
-		dev_err(panel->dev, "enter_sleep cmd failed ret = %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
-	gpiod_set_value(ctx->reset_gpio, 1);
+	gpiod_set_value(sw43408->reset_gpio, 1);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(sw43408->supplies), sw43408->supplies);
 
-	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	return ret ? : ctx.accum_err;
 }
 
 static int sw43408_program(struct drm_panel *panel)
 {
-	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	struct drm_dsc_picture_parameter_set pps;
-	int ret;
 
-	mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
 
-	ret = mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set tearing: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
-	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x0c, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x01, 0x49, 0x0c);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->link);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 
-	msleep(135);
+	mipi_dsi_msleep(&ctx, 135);
 
 	/* COMPRESSION_MODE moved after setting the PPS */
 
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xac);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xe5,
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0xac);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe5,
 			       0x00, 0x3a, 0x00, 0x3a, 0x00, 0x0e, 0x10);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb5,
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5,
 			       0x75, 0x60, 0x2d, 0x5d, 0x80, 0x00, 0x0a, 0x0b,
 			       0x00, 0x05, 0x0b, 0x00, 0x80, 0x0d, 0x0e, 0x40,
 			       0x00, 0x0c, 0x00, 0x16, 0x00, 0xb8, 0x00, 0x80,
 			       0x0d, 0x0e, 0x40, 0x00, 0x0c, 0x00, 0x16, 0x00,
 			       0xb8, 0x00, 0x81, 0x00, 0x03, 0x03, 0x03, 0x01,
 			       0x01);
-	msleep(85);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xcd,
+	mipi_dsi_msleep(&ctx, 85);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcd,
 			       0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x16, 0x16);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xc0, 0x02, 0x02, 0x0f);
-	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
-
-	ret = mipi_dsi_dcs_set_display_on(ctx->link);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x02, 0x02, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0xca);
 
-	msleep(50);
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
-	ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	mipi_dsi_msleep(&ctx, 50);
 
-	drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
-	ret = mipi_dsi_picture_parameter_set(ctx->link, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set PPS: %d\n", ret);
-		return ret;
-	}
+	sw43408->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	drm_dsc_pps_payload_pack(&pps, sw43408->link->dsc);
 
-	ctx->link->mode_flags |= MIPI_DSI_MODE_LPM;
+	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+
+	sw43408->link->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	/*
 	 * This panel uses PPS selectors with offset:
 	 * PPS 1 if pps_identifier is 0
 	 * PPS 2 if pps_identifier is 1
 	 */
-	ret = mipi_dsi_compression_mode_ext(ctx->link, true,
+	mipi_dsi_compression_mode_ext_multi(&ctx, true,
 					    MIPI_DSI_COMPRESSION_DSC, 1);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set compression mode: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return ctx.accum_err;
 }
 
 static int sw43408_prepare(struct drm_panel *panel)

-- 
2.39.2


