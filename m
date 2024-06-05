Return-Path: <linux-kernel+bounces-201595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC88FC08D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AD32863BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBB26AFC;
	Wed,  5 Jun 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Am2BigQ5"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC222079
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547078; cv=none; b=AHkJBh85U27ZeRu748sUwQX9b4HU3neJ8AzB8BUdVPfyhv8uRjOfj6Yl4EKZr/Jhprk+kunNplY17A0NYjiUBUDovww13RrDCVHhg00txRSsX0eIKI9zToz67DRg3GGkQN7rIszypZAQeOuzpYnFf4X6YVm/RnH1AxQlvvYXIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547078; c=relaxed/simple;
	bh=pbiMSRqECHUwKQnUOsdOAxThHwTVUE+CpCvDig4VJv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J35cGUiFvFro7CtltTKY9EOiRoybmBHUbmVP3CFZKcOwn9aUH5Ohngw7nqCpg5cXN5HptrNm8ufMXoWUqWG6Epm1YkN02zpMrqe5lUFU/MP6HEtNrBKmPf9xsO5EMCB5Av8cOK2I1JpIaXRQJE+F78rl/SLvmdqcMVfMeMxCO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Am2BigQ5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so1343551a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547076; x=1718151876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt+Uz61a2MDORYQbLM7hqg1KrTLX44Z8XHA6HpQkDA0=;
        b=Am2BigQ5ai0uusi3V1fVnWi6TYpy05qU5jb/yOp41kL1nyWPJx67JFlVP4KDjWMhqo
         o5AyOppuCBG/mS4e9cUfdod4nbOwz2ftAQRH8bDpsgdQa2EbLybb/vVpN9A0UibqO50u
         65d3hDvGcL1/ARGLS5gl3UimCoIFaZgUri7LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547076; x=1718151876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt+Uz61a2MDORYQbLM7hqg1KrTLX44Z8XHA6HpQkDA0=;
        b=YIlGI8ykEu0+gZy661EpNuEbs8ds5EaC54Z3c79h54VEfJnbNEo3k/eNKLWzT4dTOo
         ve2R9q5U266/94bPbM7eGwWf4VhR3S8Mp6DrxLfu6IkwsNSqJsGfin/m9dC6MUulsRtD
         tREmUERF1bt1UW7noqxilCEEJONHwLhEN2ajo5/i5eJi35aakTl81FGoQXg5bc3BCqzv
         FdEy4f3nx586E9D2ILxMjbGLMP0eD17znyDfugvXfmIoXDyFOZfORU4/OhQXywiZ1g6W
         FBFnmw4lukY6uy2Xk7CRRxpc+1CaWWadrC8B3NBtDrdMcPbi3nKG/lRHU1lhBOj34Zv0
         P6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV7nz4K7gHEB303HX+a+/FIl36rjLMan8h/DbdVkXp6fh5dFPITyHT+Gn10/NYzLDlSzlVCPfVfHaQtxENaZEn0nvbE44q6CNvdbsq1
X-Gm-Message-State: AOJu0YyWUtwLUR2jGa4brjVZn8uJeMCOOp6Pms31j6aUXNQunDQYGQ2M
	Zs0eAEqwDn/Gc3CI0w8X687QBa+3ClQBv5fpOMS4b/irqvv2UlBaqFpEb3wi+Q==
X-Google-Smtp-Source: AGHT+IG8GVjkkeUZPe82uyMtW/A8Z+0TZ1mgkbT3D57ki2eM/keBp6CyQM3mvG3P3K8NdynAMqX0zA==
X-Received: by 2002:a05:6a21:18f:b0:1b2:a780:2d08 with SMTP id adf61e73a8af0-1b2b6e4ab78mr1534566637.10.1717547076080;
        Tue, 04 Jun 2024 17:24:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Vinay Simha BN <simhavcs@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/24] drm/panel: jdi-lt070me05000: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:57 -0700
Message-ID: <20240604172305.v3.11.I2e991044def6644c18ad8d7d686f4f3006f278de@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

NOTE: as part of this, transition the panel's direct calls to its
disable function in shutdown/remove to call through DRM panel.

Cc: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note: since we are able to identify that this panel only appears to be
used on Qualcomm boards and we have to touch the shutdown/remove path
in this patch anyway, we could possibly squash this with the next
patch that removes the disable call in shutdown/remove. For now I'm
keeping them separate just to keep the concepts separate.

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 27 ++-----------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index f9a69f347068..4ddddee6fa1e 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -37,9 +37,6 @@ struct jdi_panel {
 	struct gpio_desc *dcdc_en_gpio;
 	struct backlight_device *backlight;
 
-	bool prepared;
-	bool enabled;
-
 	const struct drm_display_mode *mode;
 };
 
@@ -176,13 +173,8 @@ static int jdi_panel_disable(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_jdi_panel(panel);
 
-	if (!jdi->enabled)
-		return 0;
-
 	backlight_disable(jdi->backlight);
 
-	jdi->enabled = false;
-
 	return 0;
 }
 
@@ -192,9 +184,6 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 	struct device *dev = &jdi->dsi->dev;
 	int ret;
 
-	if (!jdi->prepared)
-		return 0;
-
 	jdi_panel_off(jdi);
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(jdi->supplies), jdi->supplies);
@@ -207,8 +196,6 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 
 	gpiod_set_value(jdi->dcdc_en_gpio, 0);
 
-	jdi->prepared = false;
-
 	return 0;
 }
 
@@ -218,9 +205,6 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 	struct device *dev = &jdi->dsi->dev;
 	int ret;
 
-	if (jdi->prepared)
-		return 0;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(jdi->supplies), jdi->supplies);
 	if (ret < 0) {
 		dev_err(dev, "regulator enable failed, %d\n", ret);
@@ -250,8 +234,6 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	jdi->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -272,13 +254,8 @@ static int jdi_panel_enable(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_jdi_panel(panel);
 
-	if (jdi->enabled)
-		return 0;
-
 	backlight_enable(jdi->backlight);
 
-	jdi->enabled = true;
-
 	return 0;
 }
 
@@ -475,7 +452,7 @@ static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = jdi_panel_disable(&jdi->base);
+	ret = drm_panel_disable(&jdi->base);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
 
@@ -491,7 +468,7 @@ static void jdi_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
 
-	jdi_panel_disable(&jdi->base);
+	drm_panel_disable(&jdi->base);
 }
 
 static struct mipi_dsi_driver jdi_panel_driver = {
-- 
2.45.1.288.g0e0cd299f1-goog


