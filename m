Return-Path: <linux-kernel+bounces-223278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D8791109E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665EF2840F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8E1B375E;
	Thu, 20 Jun 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC2HV5P6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DB39FC6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907147; cv=none; b=eA/IUu8eCN0JugIuWKN0ohBaxfPHRx8iQWqMbVy4cLopgRJtPGheRd5iAL8M5EJDdcgmg/VORcDnDnxyL3/mrF++f6ZyqM65+QV21xLpwFrwITyeBb2l7I740aAK/l+n6uZHPBTzcVRxa5WYGzadV+RQrbfQELz7FvHklbzyiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907147; c=relaxed/simple;
	bh=jIp2LDR9mwYgwKKbvBuh1nM1arTh9ksnCU0HCkCFTnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQsBsobdbQbbLPErud1MHovaYJmRWMghtBP9p33tRpqGEQn4o6K93uynnGV21dmGjqJZ547wlDFL+8lu4AN6fDl3FiUFvTYczCr9TiwLAvOBgMYffL59QZgZVHnAcxqiuUlZy5aKIjEJZToEhMH/ZUcNia/RNT7bRhmguJ5GXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC2HV5P6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9de13d6baso4518825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907145; x=1719511945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2HzAIPRZdkW+tj9ANIWovc+pu+HPRBNk4X+XXrJl3g=;
        b=hC2HV5P6XuKUWL/pPzQXYAA95qqXVOfMG3s5zGUVjl+nsisIRLMb9EZO0bvOtCHc4Q
         QHUEwlVTrcsn/ckORebpNJSDRPwd4H34IonBtiJ2JaKetRkhivDN1cVJH8Yux41EZizU
         W7bOrgtqDvurFVbC6mzvk8GeSJBVyidGx8v5T4yfZlL0uKNYCXNc+FR7HLPfKTGKBT2u
         aSUpt0zJzlNCSK31935Va5A2cts7g5+lBhyHYSe5mBFXg7uGqPhgK6rowIJpJE0zSxrM
         pAVQZ3ces0HHtvhnVJrngQTRdz5OrijWPS9bzGhZsdDYTzy7MNmp7p716trPJsQr6XzB
         WVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907145; x=1719511945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2HzAIPRZdkW+tj9ANIWovc+pu+HPRBNk4X+XXrJl3g=;
        b=Dd8uaVEet30EJBipK2o/go2Yixq194jmbi663RPiNYLFmOwskn0ttFdKGMldSj2sOe
         gPDzRhKIHWwO7/g/LE9WCTxtY7NWeZNsok6VS8NfUccsrzpkol0DJSmSkvoHoPiVpZFQ
         Gh9FF7Pl1OWK2+LhtdD/fJ8rqEg8xo0fY1D4EooisBg9effGA3MgDLTsoo3dAFuwViDk
         YTPXILBWJWYcgzWKdEvfjBsMjY1rVKnPOFco2mYte8gxywnhv2ys09hhM3chzHwXtaSS
         dRBtAadfz96pAP7iiAQNGn2H5dVpGeaYEgu/cyOo8iy4fI9Lifek624I9lKNAgt0+Uz9
         Od8w==
X-Forwarded-Encrypted: i=1; AJvYcCWAjIqVxakerbVVXHebQRL6OXHCDgxsjrxsw1GtXDjka58f+GGSp1pNwKlaWBFejc0ZvkeqJeo2c+laprzNHOKXPQ3xU1f2dLYLpeTK
X-Gm-Message-State: AOJu0YyukN/RHI0bOBXwlYij42J1lJ2yNSRvRPXtnnbhrvCTl3bAZAJp
	jI8FBCEVsemhslTYfscF9+YuEbVr46uCgVj6thdhKzWZdUvlX6za
X-Google-Smtp-Source: AGHT+IGgJzwQnUgC2K3ytXxUiEyV+EGacfXYG59zNba1MzMuaxu2FlEmjfeH9HgVlPLqJgvR9z5Agw==
X-Received: by 2002:a17:903:1cf:b0:1f7:42ba:5b1e with SMTP id d9443c01a7336-1f9aa412090mr63353065ad.17.1718907144898;
        Thu, 20 Jun 2024 11:12:24 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.85.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9cd18cde5sm17240035ad.66.2024.06.20.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:12:24 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/panel: raydium-rm692e5: transition to mipi_dsi wrapped functions
Date: Thu, 20 Jun 2024 23:40:49 +0530
Message-ID: <20240620181051.102173-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") for the
raydium-rm692e5 panel.

Additionally, the error handling in rm692e5_prepare() is changed to
properly power the panel off in the case of a wider range of
initialization commands failing than before. 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v3:
    - Remove extra blank line
    - Expanded on error handling functionality in patch notes

Changes in v2:
    - Change rm692e5_on to return void and take mipi_dsi_multi_context
      as an argument.
    - Remove unnecessary warnings.
    - More efficient error handling in rm692e5_prepare

v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail.com/

v2: https://lore.kernel.org/all/20240619033351.230929-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 238 ++++++++----------
 1 file changed, 99 insertions(+), 139 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index 21d97f6b8a2f..ea1b728e85a2 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -40,176 +40,136 @@ static void rm692e5_reset(struct rm692e5_panel *ctx)
 	usleep_range(10000, 11000);
 }
 
-static int rm692e5_on(struct rm692e5_panel *ctx)
+static void rm692e5_on(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
-
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x41);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x16);
-	mipi_dsi_generic_write_seq(dsi, 0x8a, 0x87);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x71);
-	mipi_dsi_generic_write_seq(dsi, 0x82, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x2c);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x64);
-	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x3c);
-	mipi_dsi_generic_write_seq(dsi, 0xca, 0x80);
-	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf4);
-	mipi_dsi_generic_write_seq(dsi, 0x00, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x01, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x02, 0xcf);
-	mipi_dsi_generic_write_seq(dsi, 0x03, 0xbc);
-	mipi_dsi_generic_write_seq(dsi, 0x04, 0xb9);
-	mipi_dsi_generic_write_seq(dsi, 0x05, 0x99);
-	mipi_dsi_generic_write_seq(dsi, 0x06, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0x07, 0x0a);
-	mipi_dsi_generic_write_seq(dsi, 0x08, 0xe0);
-	mipi_dsi_generic_write_seq(dsi, 0x09, 0x4c);
-	mipi_dsi_generic_write_seq(dsi, 0x0a, 0xeb);
-	mipi_dsi_generic_write_seq(dsi, 0x0b, 0xe8);
-	mipi_dsi_generic_write_seq(dsi, 0x0c, 0x32);
-	mipi_dsi_generic_write_seq(dsi, 0x0d, 0x07);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf4);
-	mipi_dsi_generic_write_seq(dsi, 0x0d, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0x0e, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x0f, 0xff);
-	mipi_dsi_generic_write_seq(dsi, 0x10, 0x33);
-	mipi_dsi_generic_write_seq(dsi, 0x11, 0x6f);
-	mipi_dsi_generic_write_seq(dsi, 0x12, 0x6e);
-	mipi_dsi_generic_write_seq(dsi, 0x13, 0xa6);
-	mipi_dsi_generic_write_seq(dsi, 0x14, 0x80);
-	mipi_dsi_generic_write_seq(dsi, 0x15, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0x16, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x17, 0xd3);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x3a);
-	mipi_dsi_generic_write_seq(dsi, 0x19, 0xba);
-	mipi_dsi_generic_write_seq(dsi, 0x1a, 0xcc);
-	mipi_dsi_generic_write_seq(dsi, 0x1b, 0x01);
-
-	ret = mipi_dsi_dcs_nop(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to nop: %d\n", ret);
-		return ret;
-	}
-	msleep(32);
-
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x38);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xd1);
-	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0xf9);
-	mipi_dsi_generic_write_seq(dsi, 0x00, 0xaf);
-	mipi_dsi_generic_write_seq(dsi, 0x1d, 0x37);
-	mipi_dsi_generic_write_seq(dsi, 0x44, 0x0a, 0x7b);
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xfa, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x08);
-	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x51, 0x05, 0x42);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(100);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x41);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd6, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x16);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8a, 0x87);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x71);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x82, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc6, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc7, 0x2c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc8, 0x64);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc9, 0x3c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xca, 0x80);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcb, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcc, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x01, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x02, 0xcf);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x03, 0xbc);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x04, 0xb9);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x05, 0x99);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x06, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x07, 0x0a);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x08, 0xe0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x09, 0x4c);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0a, 0xeb);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0b, 0xe8);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0c, 0x32);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0x07);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0xc0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0e, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0f, 0xff);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x10, 0x33);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x6f);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x12, 0x6e);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x13, 0xa6);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x14, 0x80);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x15, 0x02);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x16, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x17, 0xd3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x3a);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x19, 0xba);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1a, 0xcc);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1b, 0x01);
+
+	mipi_dsi_dcs_nop_multi(dsi_ctx);
+
+	mipi_dsi_msleep(dsi_ctx, 32);
+
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xd1);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd3, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd0, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd2, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd4, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xb4, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf9);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xaf);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1d, 0x37);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x44, 0x0a, 0x7b);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfa, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc2, 0x08);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x35, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x51, 0x05, 0x42);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 100);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
 }
 
 static int rm692e5_disable(struct drm_panel *panel)
 {
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(100);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	mipi_dsi_msleep(&dsi_ctx, 100);
+
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_prepare(struct drm_panel *panel)
 {
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 	struct drm_dsc_picture_parameter_set pps;
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
-		return ret;
-	}
+	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	rm692e5_reset(ctx);
 
-	ret = rm692e5_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
-		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-		return ret;
-	}
+	rm692e5_on(&dsi_ctx);
 
 	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
 
-	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_compression_mode(ctx->dsi, true);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable compression mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_compression_mode_ext_multi(&dsi_ctx, true, MIPI_DSI_COMPRESSION_DSC, 0);
+	mipi_dsi_msleep(&dsi_ctx, 28);
 
-	msleep(28);
-
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x40);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
 
 	/* 0x05 -> 90Hz, 0x00 -> 60Hz */
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xbd, 0x05);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x05);
 
-	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
 
-	return 0;
+	if (dsi_ctx.accum_err) {
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	}
+
+	return dsi_ctx.accum_err;
 }
 
 static int rm692e5_unprepare(struct drm_panel *panel)
-- 
2.45.2


