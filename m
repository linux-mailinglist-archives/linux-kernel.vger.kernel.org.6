Return-Path: <linux-kernel+bounces-201597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7B8FC08F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1208FB2636A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5A2E634;
	Wed,  5 Jun 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlG7vbVo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E825C96
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547082; cv=none; b=TofvysnUVZgB6vp52YWiDfuVjr0ObdiaCy5M9PWMIGnh0M2HNb5Mqd4CT4qByN3FzBcBF4OnLYZ2C/+bmbwC9wFhXhUyo+BsMaM2azR2UpLVBNwwivcfwRyJNdr/XRBMECV4unL2LzjhmoHB1cgVgvg33uFR8D7M5IgYfP9qrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547082; c=relaxed/simple;
	bh=PVxTU2SLuK1+/8lpgmhPr8DzWOSexxu6WgUikZqB4Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROCyA+OIwKTs/R0IQDsx6Qzi3YN5C34X+XzaVWlnx9ouBtRcPt1SG9BOVd84F0Zn2aKenO28XB/ctABZsyx6zbuZqqDfNfdnygsRQoPZ3Hue5p3AmrCQ+QjYQxfpCpHXONxrXhqaYXffXXiAb9eM33aA8T2feASuntFj/UsJCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GlG7vbVo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6a837e9a3so417675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547081; x=1718151881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1AbhkHbMcMoNlGR2CNiQzfOA470DcPJEE3YgeJALa4=;
        b=GlG7vbVouALnYsNYKijVzLM3/LoW2GqNALEzt30Ugv7QgJMvDjy//8RkYMIwHlGEuF
         ogk876krQ8dmr44BN9/hD3SkwfbVD6dSLkzlGbRPntGZ1qAPtkVNF3oayQUN7yZprZGj
         IBLW2Q13YyRhjaayuQGde/nNWfkdkdLyWzMpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547081; x=1718151881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1AbhkHbMcMoNlGR2CNiQzfOA470DcPJEE3YgeJALa4=;
        b=n2ORTWhQsk1FQbze4ZV6ChDsqoPqEEjVSRxWWrjX8W+yvB2hi/ac+nqJIAe0NHXsP7
         49dsvdrYcwX0DWr/mbvIxKrOAzPLnoJI8NVYMCfEq2fQYqRfjn7suB2P5n6Q4kpAOxG8
         xyRyZuJnVLWIAOVtTqNFKLrki/WMyMHwLlHezrBu7jILiEZMlu3bOOiXDYeDKojE6FrA
         kTDpZhuphegm/rOqV1afXgC1yTmhTkebX3INmBedSGZfle7wB3jFn4nMCYpRclQOV+m/
         IMo5OjVmS477uU2hHMl40lTJ2tcw2ciy2NSFuKVeGLJCzGnWg6i85UKUzmehC+XDcrCR
         Owyw==
X-Forwarded-Encrypted: i=1; AJvYcCUHNzPZSCE+qESSnedMwL89AnUr61QqUHeXFutS4DZilb5Cco45faA6byg6vR1gjMjpvMFFUUGe0TmTh3GIW/B6SbRn5/D7mjy4QMmE
X-Gm-Message-State: AOJu0YzdFIbgW/dxkGgDSQCjG5zVg0SLSfCeL4gYx4d1cUmL3HBtBdVD
	Jaueu+LOoBU8VIkQL4wpuGG3kZTxu8grpZbNENLEwdG0lFVLDX0YkG7ZLrR7qw==
X-Google-Smtp-Source: AGHT+IGu8485oXCnzIRAECaBH3dhdfdAn+6q6Kuo2jjHznsxYxzsjH5Zj4/blut1i6HGmkU6SpKExQ==
X-Received: by 2002:a17:902:d506:b0:1f6:3215:3d3b with SMTP id d9443c01a7336-1f6a5a22ef8mr15113505ad.31.1717547080831;
        Tue, 04 Jun 2024 17:24:40 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:40 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/24] drm/panel: panasonic-vvx10f034n00: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:59 -0700
Message-ID: <20240604172305.v3.13.I7278e956ffd1cf686e737834578d4bb3ea527c7f@changeid>
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

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 35 +------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 8ba6d8287938..822ca2f971eb 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -32,9 +32,6 @@ struct wuxga_nt_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	ktime_t earliest_wake;
 
 	const struct drm_display_mode *mode;
@@ -53,28 +50,16 @@ static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
 static int wuxga_nt_panel_disable(struct drm_panel *panel)
 {
 	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
-	int mipi_ret, bl_ret = 0;
-
-	if (!wuxga_nt->enabled)
-		return 0;
-
-	mipi_ret = mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
-
-	wuxga_nt->enabled = false;
 
-	return mipi_ret ? mipi_ret : bl_ret;
+	return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
 }
 
 static int wuxga_nt_panel_unprepare(struct drm_panel *panel)
 {
 	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
 
-	if (!wuxga_nt->prepared)
-		return 0;
-
 	regulator_disable(wuxga_nt->supply);
 	wuxga_nt->earliest_wake = ktime_add_ms(ktime_get_real(), MIN_POFF_MS);
-	wuxga_nt->prepared = false;
 
 	return 0;
 }
@@ -85,9 +70,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 	int ret;
 	s64 enablewait;
 
-	if (wuxga_nt->prepared)
-		return 0;
-
 	/*
 	 * If the user re-enabled the panel before the required off-time then
 	 * we need to wait the remaining period before re-enabling regulator
@@ -117,8 +99,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	wuxga_nt->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -127,18 +107,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static int wuxga_nt_panel_enable(struct drm_panel *panel)
-{
-	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
-
-	if (wuxga_nt->enabled)
-		return 0;
-
-	wuxga_nt->enabled = true;
-
-	return 0;
-}
-
 static const struct drm_display_mode default_mode = {
 	.clock = 164402,
 	.hdisplay = 1920,
@@ -178,7 +146,6 @@ static const struct drm_panel_funcs wuxga_nt_panel_funcs = {
 	.disable = wuxga_nt_panel_disable,
 	.unprepare = wuxga_nt_panel_unprepare,
 	.prepare = wuxga_nt_panel_prepare,
-	.enable = wuxga_nt_panel_enable,
 	.get_modes = wuxga_nt_panel_get_modes,
 };
 
-- 
2.45.1.288.g0e0cd299f1-goog


