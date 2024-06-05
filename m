Return-Path: <linux-kernel+bounces-201601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10038FC094
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2291F261BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355E482C3;
	Wed,  5 Jun 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PS78I+Lo"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE33FE4A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547092; cv=none; b=kgYBjsX7KYmVoz1I7/1aOOC58AdiTBdDxQcYKrWTnaLTuIdOjSFLQBZJL8UHG/MlCZOIjT6PlVKdgnKyHEB+8VGppPRuj+/SQJFNWZniY8HRD2Kl6bViWb6mpe7nEltTFT6xpwbzRIKrowa6SSojTYLsJakdhWEhh872lS6KFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547092; c=relaxed/simple;
	bh=FLeShtPouJuV2Qn0M4852+lvvp6t/uuZDKf+IJVMyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sogi2PXM9dfJ4oob/SbPrLDllLJpPHJsTSoCPDnsh6t0508oQvMGYomRX1idAVN7HHBcWyxtuiCtFHrOzVceGHKbfR6efxyNrue74gsN947RX+q7DWEhrwhcOYxVprllKcPLaFNfjK5MuprlppA2wAx+5otF5JdphxwGX6IhIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PS78I+Lo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70249faa853so1525518b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547090; x=1718151890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwSr2LQpLEh1dbqQjF4R2fgSgqdzndDaTOcijaWNa9w=;
        b=PS78I+LoM40OuleZKj5KIJdGMErJYNP5wM0ahjJwJMN2y0ZQfZBg1TNYcYodzLeiC1
         JogrBOxq/bi3rOXi8fXESEviBSbdd5b219pvanN3fn6POIPvpO4IdicC8XSd5P6K/TCr
         8Z6DCU7pXp75AYvrsSrDgR2iyK+rS+0KTRwr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547090; x=1718151890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwSr2LQpLEh1dbqQjF4R2fgSgqdzndDaTOcijaWNa9w=;
        b=bfQWoG5go1jisALSeJUrd6bTLXHVk7n+kBIJ8dgMWl9eeqimt73xf5UBaRuo0DBVlF
         z+B3DOaUOY5EehLHawKEfTwGzqBuTrDrHFXqNXYzv07HfZFFAdxk0IugAAckLybFHOcQ
         /1y/9vdBz7XpJD0yRwPRYbcf6LvqiRzqHbXHpGPqgCCCqjsgKC4RwiUjmw/KbjiPeM0X
         2nSbYOuNuC9Co88D/fJm3wHGPaI45uW3jToLdS/B6FCfBoeJa80Yt/RMyo2IzyHuynMH
         WWOuOeD0CDdgCexhtJrS8G4ibsSl5NIKH/GpTgiVibDZsiBwqhtXm1sEdfH5okfXx4ra
         OXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8TPVwKJt6r+U/fmlbHLeM7i8MhdKVKYOCZeeQmXrGxy9iSnlAQ8k/rcM5S+xaYrtBGBNgkkU9fFeHZ6iNKaKGX2PVkU0XgsSsKY3Z
X-Gm-Message-State: AOJu0YzqSStcY8F0BTZyf73U6VeWVemQG9aPlHlgYKJx0vTpU/zrBdv+
	TQXnPuwaVAirugyorUygyr2nXurX5FK+E1S3zWz5AFlBMNe4OAoMXN67HZih+A==
X-Google-Smtp-Source: AGHT+IHTA/HmCvWBMAd8tf+YR+vrYnIMOjenFrx5elkt8kCQQG58qBMYuoMj6MIUTI76RDDnK6YNvQ==
X-Received: by 2002:a05:6a21:819f:b0:1b2:7d48:7f7d with SMTP id adf61e73a8af0-1b2b71c8e82mr1254043637.61.1717547090168;
        Tue, 04 Jun 2024 17:24:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thierry Reding <treding@nvidia.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/24] drm/panel: sharp-lq101r1sx01: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:23:03 -0700
Message-ID: <20240604172305.v3.17.Ifd6b12b8a4bca7d492e892ea7455e83f5c0ab5a8@changeid>
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

Cc: Thierry Reding <treding@nvidia.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 14851408a5e1..8f6c21b99522 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -24,9 +24,6 @@ struct sharp_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	const struct drm_display_mode *mode;
 };
 
@@ -85,26 +82,11 @@ static __maybe_unused int sharp_panel_read(struct sharp_panel *sharp,
 	return err;
 }
 
-static int sharp_panel_disable(struct drm_panel *panel)
-{
-	struct sharp_panel *sharp = to_sharp_panel(panel);
-
-	if (!sharp->enabled)
-		return 0;
-
-	sharp->enabled = false;
-
-	return 0;
-}
-
 static int sharp_panel_unprepare(struct drm_panel *panel)
 {
 	struct sharp_panel *sharp = to_sharp_panel(panel);
 	int err;
 
-	if (!sharp->prepared)
-		return 0;
-
 	sharp_wait_frames(sharp, 4);
 
 	err = mipi_dsi_dcs_set_display_off(sharp->link1);
@@ -119,8 +101,6 @@ static int sharp_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(sharp->supply);
 
-	sharp->prepared = false;
-
 	return 0;
 }
 
@@ -164,9 +144,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	u8 format = MIPI_DCS_PIXEL_FMT_24BIT;
 	int err;
 
-	if (sharp->prepared)
-		return 0;
-
 	err = regulator_enable(sharp->supply);
 	if (err < 0)
 		return err;
@@ -235,8 +212,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	sharp->prepared = true;
-
 	/* wait for 6 frames before continuing */
 	sharp_wait_frames(sharp, 6);
 
@@ -247,18 +222,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int sharp_panel_enable(struct drm_panel *panel)
-{
-	struct sharp_panel *sharp = to_sharp_panel(panel);
-
-	if (sharp->enabled)
-		return 0;
-
-	sharp->enabled = true;
-
-	return 0;
-}
-
 static const struct drm_display_mode default_mode = {
 	.clock = 278000,
 	.hdisplay = 2560,
@@ -295,10 +258,8 @@ static int sharp_panel_get_modes(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs sharp_panel_funcs = {
-	.disable = sharp_panel_disable,
 	.unprepare = sharp_panel_unprepare,
 	.prepare = sharp_panel_prepare,
-	.enable = sharp_panel_enable,
 	.get_modes = sharp_panel_get_modes,
 };
 
-- 
2.45.1.288.g0e0cd299f1-goog


