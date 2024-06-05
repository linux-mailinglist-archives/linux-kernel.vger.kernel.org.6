Return-Path: <linux-kernel+bounces-201589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B48FC086
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC95E1F219BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77AF503;
	Wed,  5 Jun 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bon46oDt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C9DDCB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547065; cv=none; b=DuC4uY01qK21BPhRxaJanlws8n17jnIaIObojjZtIusXe0nv9E9nKPgkyNScRv+bAZph5/QdrnUx/PbTiaNmNspquGYjiQ/jtAH7+FnaKj1YKWglOGl8UG1+qBs1usSRwVLmDKc3mBEX3kCn0UqjGHOA2vd3wUALak+8C6y4vQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547065; c=relaxed/simple;
	bh=D0NAyK1OqDOveZZt1LmhU8rHOg6ppveTM9A/nwy9/4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxfsfcg/Tq5VNNUVhZy5bN+V+ulwW3kgxZGkqVUnCTJd+yYhdyPvvD1vESFHKtyaslMEKGyA52TJKWPYZtBWdWtmcjXiEC6kHx65wiFSf8A3DxiF/2/SFtuHacSC+lPqGJyoLiyNafPboGmbDbRHRjTAuUXLU/Sf/lMw2tG1F9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bon46oDt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f692d6e990so16283105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547063; x=1718151863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzvwGuJ+WTCRog8EdqXF+Obfr3JYyQtoUfl83gDvzVE=;
        b=Bon46oDt5tLyGsoUuB98dBH6L6HlqRawDCoYbzjepULVmqZT7hFP/ZyRoUTW+5WmRl
         GBQTIZbZ0pJbEhR2MxHyZ6Xfqxj2rlrmJvm56qgprX/0AfiecvvDhtCzjHQyu11F+2q8
         69j/9/ySh4SC4y7WYGgr0vo6tgP6Tao0vsFhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547063; x=1718151863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzvwGuJ+WTCRog8EdqXF+Obfr3JYyQtoUfl83gDvzVE=;
        b=VF3SPl/5XImko7Kj9dQJSahX905DFfBlLto49RT5zrmR5ueixDbjq91vZi5m4b32H+
         3o9BVRyb94xMZB6DP5RM/20n/ZyFRlPOR86I/T0igrsdbGjUQIsskMrG9+94/5lpMGVO
         KBx9sdoKP5C7H+AJksvoYjsyKzxEMbtojqBc6IAZRuN5OTVfnXTxxG63cnHWusD3FqGL
         Trep+YFWc5nr0dx9/E+yC/GHAoGFwS6zczHlBCDikaOQ4G/CosO//qiiLIVkG/VTBnya
         xUt6RHWnHmVK/uXIHvXotF6hjJ9SHPQ5ZkQtEN1ID2315sNMaQTgGMUYB78wuGu5+ATV
         j21w==
X-Forwarded-Encrypted: i=1; AJvYcCXNI7xxyKLsvP0LPsUybw7aKQQmrQrnKGVr/fhEqTVK3ObinqHrnHMoWtvzhJx57MHtNNVOX5+Z/3VX6bYU4THviPq4I19odlinowBD
X-Gm-Message-State: AOJu0YzprVztCM7dqiVgI81comiS8SJGJyZLahnIFV68Sr8Tkd4UefZU
	HklXpzG+XN5q+uNY1Zk9nlrpWRF8g6GvNPnK6bP8Tc4+kMt0BGaetVAtawPAGw==
X-Google-Smtp-Source: AGHT+IElsoNXkv7mUljM8/UDK3zzl3IwJ2DQTSHMSmNYHfMB/j0jhxzWAT3nNtc8jJhxnwRjLD3uqA==
X-Received: by 2002:a17:902:cec4:b0:1f6:7f8f:65c6 with SMTP id d9443c01a7336-1f6a5a10295mr15071235ad.24.1717547062977;
        Tue, 04 Jun 2024 17:24:22 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:22 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/24] drm/panel: olimex-lcd-olinuxino: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:51 -0700
Message-ID: <20240604172305.v3.5.I6a96d762be98321e02f56b5864359258d65d9da8@changeid>
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-olimex-lcd-olinuxino.c    | 41 -------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 4819ada69482..8a687d3ba236 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -64,9 +64,6 @@ struct lcd_olinuxino {
 	struct i2c_client *client;
 	struct mutex mutex;
 
-	bool prepared;
-	bool enabled;
-
 	struct regulator *supply;
 	struct gpio_desc *enable_gpio;
 
@@ -78,30 +75,13 @@ static inline struct lcd_olinuxino *to_lcd_olinuxino(struct drm_panel *panel)
 	return container_of(panel, struct lcd_olinuxino, panel);
 }
 
-static int lcd_olinuxino_disable(struct drm_panel *panel)
-{
-	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
-
-	if (!lcd->enabled)
-		return 0;
-
-	lcd->enabled = false;
-
-	return 0;
-}
-
 static int lcd_olinuxino_unprepare(struct drm_panel *panel)
 {
 	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
 
-	if (!lcd->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
 	regulator_disable(lcd->supply);
 
-	lcd->prepared = false;
-
 	return 0;
 }
 
@@ -110,27 +90,11 @@ static int lcd_olinuxino_prepare(struct drm_panel *panel)
 	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
 	int ret;
 
-	if (lcd->prepared)
-		return 0;
-
 	ret = regulator_enable(lcd->supply);
 	if (ret < 0)
 		return ret;
 
 	gpiod_set_value_cansleep(lcd->enable_gpio, 1);
-	lcd->prepared = true;
-
-	return 0;
-}
-
-static int lcd_olinuxino_enable(struct drm_panel *panel)
-{
-	struct lcd_olinuxino *lcd = to_lcd_olinuxino(panel);
-
-	if (lcd->enabled)
-		return 0;
-
-	lcd->enabled = true;
 
 	return 0;
 }
@@ -195,10 +159,8 @@ static int lcd_olinuxino_get_modes(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs lcd_olinuxino_funcs = {
-	.disable = lcd_olinuxino_disable,
 	.unprepare = lcd_olinuxino_unprepare,
 	.prepare = lcd_olinuxino_prepare,
-	.enable = lcd_olinuxino_enable,
 	.get_modes = lcd_olinuxino_get_modes,
 };
 
@@ -264,9 +226,6 @@ static int lcd_olinuxino_probe(struct i2c_client *client)
 		lcd->eeprom.num_modes = 4;
 	}
 
-	lcd->enabled = false;
-	lcd->prepared = false;
-
 	lcd->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(lcd->supply))
 		return PTR_ERR(lcd->supply);
-- 
2.45.1.288.g0e0cd299f1-goog


