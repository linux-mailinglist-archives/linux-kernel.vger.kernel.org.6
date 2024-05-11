Return-Path: <linux-kernel+bounces-176770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997368C34AA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AE91C21004
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E94DA13;
	Sat, 11 May 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnI6b2Xt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9EC3B2BD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468432; cv=none; b=dyWlJq8zEmvnJBovIAqIqlJm2AehNCz19q/rLA8Fi4i0TtCdmdYaIt87s3a/ozHBlwLQ6O/WaBPHDFXYawgomu6AcqWl1kvlGezPLo+zSqI2h81YbeeaFq9UfLR/3nRG2HyHWl7WN5ELaB1jH4N3Y4BVzhpGUpyK9XXaLUTb97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468432; c=relaxed/simple;
	bh=Nb2j0chWOl3K4obprfCylvl2x756Dew7S8N3+vA9f8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEAGYnbCVu+iCdvWFuCKPfexUs5f5lPGiAO5ShUf6F15pdI2qZdZ/K0TmYfpEJxTzYtpHELjUSTyC4xTISD0ezKV70pHXaq6fBcChYEmPgssnhBDcQHIMIEj+KKWIyCuhjdIzEq5BkF2+BSc6WKAYbzfpNleQb4QZWK7lIw1RQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnI6b2Xt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so3342241e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468429; x=1716073229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hu0NGC1822F78E4qEEGMD+epvzx8Hq6ZdfvN33IsmMQ=;
        b=nnI6b2XtaAaFCxROBIawMZJ6HyZCkBSlh9TrMsjIVQ2L5JUU6h9fckAanVrk2zxR3m
         DmA5/rivwRQ/KyJ8SecPDzd8MMws55KnF64frp7C4PJ8ppCdFR+btFhqtgBlq4e0HE+s
         ADXN1h70HaOJlcXiIzHJ/oOE9jUtve0w2CNoBpv0n4L/h/RTRL+90sGFkL55LvAlho/3
         ijmkI3h7WAasBl/Te1Mk3giC5IeBDzPycw3CZBme0WVSlir/pwb1gnVXLCqsZQAExewL
         7rRDT3Qc84wHKAl+1L7TsqlBcazKtGaWM5wjhZYiEIo0SPeb2FTphEVo8vFnh90ULept
         oeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468429; x=1716073229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu0NGC1822F78E4qEEGMD+epvzx8Hq6ZdfvN33IsmMQ=;
        b=sGtkpwPiHT1y3QWk3L2nv2htr7Hq7bSBRBZB0FyFgxwUa2LtY2yTHcPU21B5BXmmFg
         7tTOnZs3a4ilmdlq2aMEBjbCOgPrM6U7pphDEt49YPxmqjZTs7488Xax10e9t3IYQEeU
         3+eubrTpcLTKtTdHAlaE+EU9VMNGPRgLoe2v0DfUTlk5BmfylnPls7Gt9KPqj6PNUdr3
         DdU+5L2hiRISkZTQDiYEjI7Nx/SsRZSd/Bhg48MI9HTikxUJATQny63rJWEgLMUgBojE
         t+FtWeaKaE9+zrWsf+2ZLan4MASPdK93CNdY/H8JIdgaIkQ96rFF7sayQdtPEPI2MUt4
         5Q9g==
X-Forwarded-Encrypted: i=1; AJvYcCW8EgxWZ8dBCUGH27sxzYPWbUrDCrwsyfgzM4hwaOZ9AtKDSl8ZrCQSqZXHdPDOJk9di7sGpf3UJnxsnvpysg2DvM04vINJWKckRhIt
X-Gm-Message-State: AOJu0Yxs+LAo9Bmb4T0YfQCAacH2zvq4q7kP+sFC+NkIZGfG0EhOICu5
	N0xV4/WIFy+sUjCN7OWXb1wuL0ZS0KFZqc9jlMKTkHbugGn1mGmjGZ/b8FBONig=
X-Google-Smtp-Source: AGHT+IFr3JJ2vBf6ZQy+IfFzBDbsVRhgW4zc3ltkOgtdnJYsgPSuJLiHSVasG/nFGY1o3ezKQcVUvQ==
X-Received: by 2002:ac2:4437:0:b0:519:2d60:d71b with SMTP id 2adb3069b0e04-5220fb748e2mr3750214e87.22.1715468428990;
        Sat, 11 May 2024 16:00:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:20 +0300
Subject: [PATCH v2 3/7] drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-3-e31ca14d102e@linaro.org>
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
In-Reply-To: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
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
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4693;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Nb2j0chWOl3K4obprfCylvl2x756Dew7S8N3+vA9f8A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iJPUx6S2iov6pW2UiDrNkON3xTRY9bGzjD5
 M6NaOHeuR6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iQAKCRCLPIo+Aiko
 1eFkB/9JXBh7kAEoKU1ZGODiXQ9dFDltFasZEZd5OcbnNrPxpevLyXu0CWhZj2Bn6+lGaZ/TfUR
 Psn26XBaBBlqancXr61dMYJfulvUJkDEqsWiAg0/KHwm82Z7aWBd5y7I52BR00EI5g/CMYIuTDP
 o628o7vV2AmVFLEAXfuoisFcYBbeAXsbhIf0SpvmwmMo3ovCgtkm1LbuVhz1uEcfNkeQyaXgzro
 AXUmpdFU72BV6AkBvd3T+g4gyTJjiEfNCxt7jV4A+2VG+E/Ug+WcPe63OOJyurrC2x6V7Gbpw2M
 LPoIuKd5xUrtL1U/xgk6pNCXKJN/r1iyGExMS2bjIZZ2NyOw
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/exit code.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 81 ++++++--------------------
 1 file changed, 19 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 4b4b125a6c6b..8e839a1749e4 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -448,22 +448,16 @@ static int boe_tv110c9m_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x13);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3b, 0x03, 0x96, 0x1a, 0x04, 0x04);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(200);
+	mipi_dsi_msleep(&ctx, 200);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
 	return 0;
 };
@@ -893,22 +887,16 @@ static int inx_hj110iz_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3b, 0x03, 0xae, 0x1a, 0x04, 0x04);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(200);
+	mipi_dsi_msleep(&ctx, 200);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
 	return 0;
 };
@@ -1207,10 +1195,8 @@ static int boe_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x08);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x04);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x68);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(150);
+	mipi_dsi_msleep(&ctx, 150);
 
 	return 0;
 };
@@ -1222,16 +1208,12 @@ static int auo_kd101n80_45na_init(struct boe_panel *boe)
 	msleep(24);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(120);
+	mipi_dsi_msleep(&ctx, 120);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(120);
+	mipi_dsi_msleep(&ctx, 120);
 
 	return 0;
 };
@@ -1283,10 +1265,8 @@ static int auo_b101uan08_3_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe5, 0x4f);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe6, 0x41);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe7, 0x41);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(150);
+	mipi_dsi_msleep(&ctx, 150);
 
 	return 0;
 };
@@ -1385,16 +1365,12 @@ static int starry_qfh032011_53g_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe1, 0x23);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe2, 0x07);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0X11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(120);
+	mipi_dsi_msleep(&ctx, 120);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0X29);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(80);
+	mipi_dsi_msleep(&ctx, 80);
 
 	return 0;
 };
@@ -1404,38 +1380,19 @@ static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 	return container_of(panel, struct boe_panel, base);
 }
 
-static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
-{
-	struct mipi_dsi_device *dsi = boe->dsi;
-	int ret;
-
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int boe_panel_disable(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
-	int ret;
+	struct mipi_dsi_multi_context ctx = { .dsi = boe->dsi };
 
-	ret = boe_panel_enter_sleep_mode(boe);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
-		return ret;
-	}
+	boe->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	msleep(150);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	return 0;
+	mipi_dsi_msleep(&ctx, 150);
+
+	return ctx.accum_err;
 }
 
 static int boe_panel_unprepare(struct drm_panel *panel)

-- 
2.39.2


