Return-Path: <linux-kernel+bounces-175040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B630A8C197B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F3D1C21C31
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406AA12D759;
	Thu,  9 May 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtgtPKJk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF6129A6B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294261; cv=none; b=twE6du06OeqoIsX2tnqKHRb63C2j7lsBKjJ8q9gtZczhEDV3Yiks8UepzKZH4pqU4BlerbqkM8N/SEfn5sy8pc4NahHLXO7rnnD61EkmnWG1X+yhIjNfXaM5ozMf9z7p15QSuQcvWiE7A7ILJOFWo5M3GPBzHyKxhO2oW8WmIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294261; c=relaxed/simple;
	bh=u3yXba0jhIsz5BJfPsDI7HZ3897wJIDUeZTmdvqZ37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyaGqeY2n6eSIQuOCHHN7aUuPPVze3mAGzcErBERn1WddWfprqc7pJ2t2A6zJEL0lCXzGuz2OvaXU86lzVjTc4A/ATBHF8QRYniyWMQ39xzadl4OuMvn6njEJOzorqrVhcQNpQR9Ujr1DBT6La4CA5VO50JqNLd47grDrBHvJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtgtPKJk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so1572865e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294257; x=1715899057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2fkQEr6eD7CRzENX13yKAuKTWqMq+M/tO0KGCERLKE=;
        b=ZtgtPKJkL+l6VnIgHgvLgK1UombWpGijMsQvTOwC68AGf0+KP9ikcC2bInlP89Mr0D
         ZE8//lp+RXlteKVwyZ+vMzuzLmgrmMdl1dXRN6KQ6B5zOH6ht2qBssBYRdhjz3UKvs3k
         YP1tYVkLbmhfNvWx00AWYniiLmZ6+6A2+tP1l+ZLJ+J/Ym3poGdhimWb0y6kZaScQmaX
         F3huhhwycoEzjaNexRJ4uIB5Px1TPgZjKUdpZdb1N917BbcAMrk3ZGL5/puiwCk3TbnS
         ThAF2Qb5osbKXoJLUHtYZmqA55jf/t3iMHBhksv3ZElin2XrBmnqBjTao6jNKXK09ZLv
         9KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294257; x=1715899057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2fkQEr6eD7CRzENX13yKAuKTWqMq+M/tO0KGCERLKE=;
        b=DqyRQDNy6bgCj2+PhZfZ6iPfhLv+gmjULeFLZ5bNOUEce87zF9t8ubTP/I1I/ZaDnc
         aJEwr0ayBvKnNRvwuMvhH0eKFeqJndb9FqXa88xMmERoTfAktVTKE5E7Ib6F6E7duGaF
         Ee4OMa8lVwjM1R1v5c03b844etn29DxiV8uu21uVlvNHRm02cMBFHEkZU/dPC6iTb+Kf
         7W14jLUXVqdoMk8JXleOQNErm2rI+oy7HlWecrtVDhWhshzGCO9USYbBzAZyNsIx/a/b
         qyxDuvS7P8XYKBpvTyzy3rjtK71BGlGUws6SGI3bAp2ycXcG56sagZY4yNXro6o1A82F
         8W+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQpeIvzYvz5g5cP8LFS/oJWZjNdYJk7BhPtPRvpUCiCT9wbCK9BT3sgOzlpoJTXu1mbt1OiJBzLJhTQqeBa4Ux3lD27d9kTBlImy+d
X-Gm-Message-State: AOJu0YxGlGLvz6yQsVtNSlCRcNylukdiaFzGIpcqXo3K0kP8uqFiuFi7
	uqYqRnlWKErrXwe9wdVmG7eoA0Lj9iBSXieVyb6dhB0JXVcp7081AOtv4W1bNok=
X-Google-Smtp-Source: AGHT+IHIGDQk1/cR1Ijjw8/YhWlQDoNEI2P8frX0ryotsgebdB4Pvl9HL4FG6+YRX/QVkOW+BTjnxg==
X-Received: by 2002:ac2:4c55:0:b0:51f:4165:9305 with SMTP id 2adb3069b0e04-5221007016dmr553026e87.55.1715294257577;
        Thu, 09 May 2024 15:37:37 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:35 +0300
Subject: [PATCH RFC 2/7] drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-2-317c78a0dcc8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4789;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=u3yXba0jhIsz5BJfPsDI7HZ3897wJIDUeZTmdvqZ37g=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ptgN5k7t8f7LdnPmr5YqjeduNPwsvnmuKdC9e+zb3NZ
 5WcIyjUyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJfO9n/18tNMH4xx+D7hW2
 jnYVSfl+flaKuZ7/mkJvXLzTJ5aX3BuTfnxzUtYqud67+p/f74st7Tliku+zMWACT7fQ1vtL564
 zn33Wuz3SR/TY56Tqre7xZxr+LJ4SlnXO4izLxSU3M9g2Zcdy2D/VnTpTjMl1Pvc9donUcps1tt
 1izVNyNDIr+TdsuhYQmNV5qLVRc5qi5hGPGM/39po5nBZs5y8LrKo8VrinwizteQlH8RZRtUjXX
 3NSOezuaxhe9WbT36N5dHX4ZqEdc6a7rGxcInu0QKFMYuaTT4Fsp24dXiBqwc/4Y+KW3JUrI2Q+
 detb6Mvc+bruaYmCqYuP8bxIKas5P++bNHPsT6gPvvEYAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/exit code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 73 ++++++++------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index aab60cec0603..456c1a5a2110 100644
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
@@ -1490,13 +1466,12 @@ static int starry_himax83102_j02_init(struct boe_panel *boe)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x4f);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	msleep(120);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);
+	mipi_dsi_msleep(&ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
 	return ctx.accum_err;
 };
@@ -1508,20 +1483,14 @@ static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 
 static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
 {
-	struct mipi_dsi_device *dsi = boe->dsi;
-	int ret;
-
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	struct mipi_dsi_multi_context ctx = { .dsi = boe->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
+	boe->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int boe_panel_disable(struct drm_panel *panel)

-- 
2.39.2


