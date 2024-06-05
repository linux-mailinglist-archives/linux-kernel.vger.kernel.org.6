Return-Path: <linux-kernel+bounces-201587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F388FC07F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7061F22517
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51BBE68;
	Wed,  5 Jun 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VmuLzQ4S"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D27945A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547059; cv=none; b=SnHE/DSSIjcpeX2WZ+DzVS8IXd8sOY4nzqz+us3EH6abzwMB1uBkL6KufwpojOhEK3GPyZcrvcf/O1j/RsDIma6vqxCStVd9i4qzElttJlI1hOfJ1/9MzgWQHr00MfCIDztv/YLAXN5NxML0Vra7K64WQVR3W9zmc4wBpcpIBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547059; c=relaxed/simple;
	bh=/0uYtNJ/uubrgwMaD2RowVr0RhvwtvtS77O0R3hwQQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0SmqYePZ8W2zCiNkSLkeU613HH81cBB75lnVtPggYfp8zNBENwlcgndQlh1M6LJPBjisRdPlmBJqgLh4ctFp5pDSEloAOyNso8UrRiSF3skBaQSBtVKJrf1bJPLwWwnNUGe8E+a7e32sjM+gRV7onqCDdNNqa3Sv+h9ge9LFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VmuLzQ4S; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f32a3b9491so45640505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547058; x=1718151858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWtosQoN9Pg9d9xBQ0Jlap54LBTP0iCSFOQ0mCtxtm8=;
        b=VmuLzQ4S+xdpTmnx7VTy+RCWWGN9p93Pi3fHeW8Wni8ocbSb+jt3s5uHDm87WgVuGk
         aB95kFW9JSaY+xzbAM9R7fbPMfcqHlPR+35h89EZ2VuT4mdciA6fEr7DUb4K2dNaz8FF
         /NeiNr0SvSLEyzrAaGKWDjp7Cg5qUN6mf1REA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547058; x=1718151858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWtosQoN9Pg9d9xBQ0Jlap54LBTP0iCSFOQ0mCtxtm8=;
        b=rI0KoGwkMpYchHKpw+fSFnZsKRyhzA1wtqv8G1wbpKF035s1nIMGDZ4+46XeQfDd2v
         1EN2PD52Eaw3ozE48pAJsdhPuwYjiR/G7g+lFNV6zSI7PUHAyPzFH5fDXRLrICfXg437
         XdbhgyKL05bR2nCGZ2BXSq5b7zzvgbVbBSQCBd0zY9K7gke4grPZAvFPvLtSjELskp41
         LkkuOGeyv107Zac4tFlOoAyn5q5Eo+fRdCDgxX9kOupsfxvS3ehZearLVUvLqYJdT2ca
         tffx+aKY4pPRTW645uU+ZEjsyCFFAnpG+unHiqD4pW9cTdbCTQhn6AQ3/OHyMA0oTEBs
         Sn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQT0PoJGMAmBZ2ySlpbz4JMq3vy8yUNXmdfCYACKlAz39y88+5t0x7YplD1VnsNgl4CGrnr0R0Lhp1HrvfRkvJzzAoyrwc1N5bFsYw
X-Gm-Message-State: AOJu0YzXUSIY8p6iwF2nbKn5x6wHCdVm/kkukZ+i6zSX/YcACowjkGD5
	8mjgOFVhuCR2wsjvWVjHL6r1uGG896a+YzXxddG9VVysBpI5r0+Dd+BrdUoIWQ==
X-Google-Smtp-Source: AGHT+IHtuzDG9J3AvSsXPl+LDhBqir5tDRLdDFJ6NPngQ8hMl8P6Nu+AEhJKyneAQQgkyOjDeML77g==
X-Received: by 2002:a17:902:f20a:b0:1f6:278b:4524 with SMTP id d9443c01a7336-1f6a5a6bd0emr9313335ad.54.1717547057593;
        Tue, 04 Jun 2024 17:24:17 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/24] drm/panel: khadas-ts050: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:49 -0700
Message-ID: <20240604172305.v3.3.Ibed1026f20cab08c90fa376e68c2f23a343e826b@changeid>
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

Cc: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Nicolas Belin <nbelin@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-khadas-ts050.c | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index c54be0cc3f08..e35762ebdbd1 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -26,9 +26,6 @@ struct khadas_ts050_panel {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
 	struct khadas_ts050_panel_data *panel_data;
-
-	bool prepared;
-	bool enabled;
 };
 
 struct khadas_ts050_panel_cmd {
@@ -642,9 +639,6 @@ static int khadas_ts050_panel_prepare(struct drm_panel *panel)
 	unsigned int i;
 	int err;
 
-	if (khadas_ts050->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
 
 	err = regulator_enable(khadas_ts050->supply);
@@ -708,8 +702,6 @@ static int khadas_ts050_panel_prepare(struct drm_panel *panel)
 
 	usleep_range(10000, 11000);
 
-	khadas_ts050->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -726,11 +718,6 @@ static int khadas_ts050_panel_unprepare(struct drm_panel *panel)
 	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
 	int err;
 
-	if (!khadas_ts050->prepared)
-		return 0;
-
-	khadas_ts050->prepared = false;
-
 	err = mipi_dsi_dcs_enter_sleep_mode(khadas_ts050->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
@@ -747,31 +734,17 @@ static int khadas_ts050_panel_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static int khadas_ts050_panel_enable(struct drm_panel *panel)
-{
-	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
-
-	khadas_ts050->enabled = true;
-
-	return 0;
-}
-
 static int khadas_ts050_panel_disable(struct drm_panel *panel)
 {
 	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
 	int err;
 
-	if (!khadas_ts050->enabled)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(khadas_ts050->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
 
 	usleep_range(10000, 11000);
 
-	khadas_ts050->enabled = false;
-
 	return 0;
 }
 
@@ -815,7 +788,6 @@ static int khadas_ts050_panel_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs khadas_ts050_panel_funcs = {
 	.prepare = khadas_ts050_panel_prepare,
 	.unprepare = khadas_ts050_panel_unprepare,
-	.enable = khadas_ts050_panel_enable,
 	.disable = khadas_ts050_panel_disable,
 	.get_modes = khadas_ts050_panel_get_modes,
 };
-- 
2.45.1.288.g0e0cd299f1-goog


