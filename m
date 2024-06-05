Return-Path: <linux-kernel+bounces-201605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F48FC098
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D30F284FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03996A33D;
	Wed,  5 Jun 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JttC+yGW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4360DEA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547102; cv=none; b=TU05kaqoInlqUrh0IG6lmGQvvWxOC5/IibCXANMiZtqDFEGlekYzu67EOHIto8W2jAcheQTeeqCAHpV/SfKm6ijMelj6kEy7yjeKjwhTNPEQ/lwn39zTuIet6iC+PCDdfWsL/Ae63LHwN8bTs+lGGfN1SF6AMlEGmIjxKGsAC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547102; c=relaxed/simple;
	bh=dFCPdrxang2IE3UA8MelYZxgyedNpercmPCgOQLHYMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnLABqq1gK1aKdWAl7dNuK8EYnsk/oPzvw5oQ8MCsJ3gGz1q2nr2v4PyyXx8oBxAE6jG1JffT8FHdZPe7nmw8A/MJJBWtlOs34boaOIiGv2Tn9mjRNwFqtY5VfjPmsZYf5h93JHAuG070STxcWnBpTQ2bohNPttUbYVBc5JFT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JttC+yGW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f62fae8c3cso46592105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547101; x=1718151901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KycAHbM1YaBsC19utL2dTXUooV8ldiwTH4nNPolNGA=;
        b=JttC+yGW/U9dTQmEfgZV0aThV2xyezhYTMKR/UcI+OEkI/JCpFAoW4IQVPwqGDJnR1
         KV1SohoQE/NJIdO7n//xpigLy5VyHHNhg0OyyIQnFgs0RVrw/CXesn/ZGC6smHnwGhtl
         MHYnas/ff2Kdad0MQtr73f2u2sZJnuDkc8uUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547101; x=1718151901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KycAHbM1YaBsC19utL2dTXUooV8ldiwTH4nNPolNGA=;
        b=DGI+xBRr+7j60w1DUOEHy0xURMGk6xZUEs+4BtKC/FQGx3NbismKCks7Eq0AbblRW3
         uSxHOk/CwvHZScAe45BSkoOWPWqKC5YcCTHdBPQYmngTuwFZvxXQaX7XbfdTLYMWRXce
         J2/MxpwCPoMfy8cRi9yQ3dC0o0nHLnG+/E32UQnDJbkGelbFxVvlMUm5rIs7N3om8lFH
         4FWDpWMp5cmFKy3F6tmo/v40QD3R11hzOvmNhodatxZF1YpCVpJv78xdvCwo+JSddwz4
         Iz581U2LmX5ZOn0o084M07Zwc0uRo5owc1qds27MhIDd16pCew+13OhKlnQhFE1e1yId
         e5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjsUGUK42037Tme7ABv3l4xyM0kJo70Y+4iDqBBB9D3JhfnPK4wzXGxBok4ci2gYxS8U6qvubK1Xi4rTrNiaBX/bDnji6q0tTa5NMA
X-Gm-Message-State: AOJu0Yxdhhcr1dMiGGLAEi9vVax3oIxKAPEJGkmZNKArlyVIcY9CxlFI
	6EwM0JSvbjB3Ln/yb3vwvFBYWSbJRSJrP342nW/m2u991WOgatF3KD4aG76Q8A==
X-Google-Smtp-Source: AGHT+IGS08PCmE1Z7uwVEhya3rKGJf5usM/7rzf00Dp5D3r9ukR+JKiJgZjVJN3F4E95srjcIWbunA==
X-Received: by 2002:a17:902:ccd2:b0:1f6:6a94:76be with SMTP id d9443c01a7336-1f6a5a6be45mr14458485ad.46.1717547100710;
        Tue, 04 Jun 2024 17:25:00 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:59 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/24] drm/panel: raydium-rm67191: Stop tracking enabled
Date: Tue,  4 Jun 2024 17:23:07 -0700
Message-ID: <20240604172305.v3.21.I20f82e9dd1597a14ae37a64c6b8275add60fbdb1@changeid>
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

The conversion of the rm67191 panel driver follows many of the other
panel drivers but has a few differences that need to be called out.

Like in commit 1e0465eb16a4 ("drm/panel: otm8009a: Don't double check
prepared/enabled"), this panel also uses the "prepared" flag to
prevent the backlight functions from running when the panel is powered
off. This is probably not the safest thing to do but the old behavior
was preserved. See the discussion in the otm8009a patch. Because of
this, I've left the driver tracking "prepared" but removed its
tracking of "enabled".

NOTE: as part of this, transition the panel's direct calls to its
disable/unprepare functions in shutdown to call through DRM panel.

Cc: Robert Chiras <robert.chiras@nxp.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index dbb1ed4efbed..fa9bf89d3bb5 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -205,7 +205,6 @@ struct rad_panel {
 	unsigned int num_supplies;
 
 	bool prepared;
-	bool enabled;
 };
 
 static const struct drm_display_mode default_mode = {
@@ -267,9 +266,6 @@ static int rad_panel_prepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (rad->prepared)
-		return 0;
-
 	ret = regulator_bulk_enable(rad->num_supplies, rad->supplies);
 	if (ret)
 		return ret;
@@ -291,9 +287,6 @@ static int rad_panel_unprepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (!rad->prepared)
-		return 0;
-
 	/*
 	 * Right after asserting the reset, we need to release it, so that the
 	 * touch driver can have an active connection with the touch controller
@@ -322,9 +315,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 	int color_format = color_format_from_dsi_format(dsi->format);
 	int ret;
 
-	if (rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	ret = rad_panel_push_cmd_list(dsi);
@@ -389,8 +379,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 
 	backlight_enable(rad->backlight);
 
-	rad->enabled = true;
-
 	return 0;
 
 fail:
@@ -406,9 +394,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 	struct device *dev = &dsi->dev;
 	int ret;
 
-	if (!rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	backlight_disable(rad->backlight);
@@ -429,8 +414,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 		return ret;
 	}
 
-	rad->enabled = false;
-
 	return 0;
 }
 
@@ -633,8 +616,8 @@ static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
 
-	rad_panel_disable(&rad->panel);
-	rad_panel_unprepare(&rad->panel);
+	drm_panel_disable(&rad->panel);
+	drm_panel_unprepare(&rad->panel);
 }
 
 static const struct of_device_id rad_of_match[] = {
-- 
2.45.1.288.g0e0cd299f1-goog


