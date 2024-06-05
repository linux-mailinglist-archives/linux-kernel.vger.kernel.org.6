Return-Path: <linux-kernel+bounces-201599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B08FC092
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1061F2385C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319E8F40;
	Wed,  5 Jun 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cXm/vFRl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288F3BBE2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547088; cv=none; b=ewIzo9aDyKY+wq9h+fv5VYzyUNaoCmMumv7Xdt/ArqWceQInza+zcdzRCOTgCoVwmxxkAXNrjhDr4X3/44ixBylYbxT5vOYNDj6gLviX088juwn16Whsxa1CyOyiX/BR6DgE914gwW4ZAWrBZod/8VqtcfeSVduO5Tte7j4QJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547088; c=relaxed/simple;
	bh=a8C6qjcG7YKqYTIWyjBBzJzmga0Lilu8SJniiSROS1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDFFet8P/zLnwXphLBxYp+rk2f45BClrbrh+SYmjeGoIovplEtQlKJCgQnaWzIH8DnQDomqy3+Aclgcm0DW9fE87DpKvzTGAZ2DTnzZersyXemAo8Zw0wOtXGVf/OhupU3b2LWVBjlOkhY70P8UYcsTc8bo7qIYMZ5juEXUmQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cXm/vFRl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a0050b9aso42179755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547086; x=1718151886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFzIDtydxqVVGN3IYfhfbW6uYn49tP8HLCeKu1mdxF0=;
        b=cXm/vFRltzZh9/4ozQHPn6pzoVmvy4CaIONtKYUNNNus96q6QzYc4Qi7Tmw1nqNIFU
         /HI/RCWBFcED4Cdp5IqJrGnjgfo01Bvavr1UdlGnQPajlgr63HYHL1lmrNYE2NJYjhYN
         BVqfAHzLCCfB0qAZB4tyWJbu3qPFHQLusBJr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547086; x=1718151886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFzIDtydxqVVGN3IYfhfbW6uYn49tP8HLCeKu1mdxF0=;
        b=lWoeeHOuLcfjA8qvB9t/Hx7zO9Uxc03Wrr0H9axDagtv80Wbi9ThAHHvwYk3RVfzp3
         o5z3EybSPEyuKKdkLtW4U8KllZMuWhmA+z86g8PIwCfHhbbLxt75NK+2S8MvKrUJ7qTt
         r52+g13CDOo3SjurZgAzlTpeh6bxUQHEn1HtDb7QW936PxoRBHN15124/jag/TM83m9O
         hlNbj/JPmg4sduzPwzU61uwirkKrRgUl0mblmhfTCZ5GpOqjHd852QGqMpzeTv9FgFJI
         l02UmYRFqY57ReZNyctnho9Xr7ZHxp06mnBZC2k+m066qsiNdOfwmctRv9J+OoLOrctX
         KLxA==
X-Forwarded-Encrypted: i=1; AJvYcCWT+4VR1HVtqHwVHegNgoWawL9v6j23pBGLe35VUCi0pl832GY/fZJFm6nr1rnT7zCG7PQCLtHdVGU4i19EboRK3ThHbss6mFG7DKbY
X-Gm-Message-State: AOJu0YxdVJ9ZobszQZOFvVdZx6oWlP3sLYPF+333kMnZjS7bk8hSbWUf
	xX/z84bJHPPUs0ITyZyFTjNPMTZPa8kPxvpRKmCOgGi9rGorfHXbtJG9VGxFQWwhcyzNLA4blo0
	=
X-Google-Smtp-Source: AGHT+IFm27+/fauZ3nMgvWWl74IN5ajXU9Ol2WKo4tVnIcK0hz7JGfbfsPcOkqAdhqR5nLRbBIMn9g==
X-Received: by 2002:a17:902:e54f:b0:1f6:7fa4:e064 with SMTP id d9443c01a7336-1f6a5a83917mr13819875ad.61.1717547085853;
        Tue, 04 Jun 2024 17:24:45 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Marco Franchi <marco.franchi@nxp.com>,
	Fabio Estevam <festevam@denx.de>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/24] drm/panel: seiko-43wvf1g: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:23:01 -0700
Message-ID: <20240604172305.v3.15.Idda91d310ca2e4f5a4ab4ca6eaf1afdaf14eeb51@changeid>
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

Cc: Marco Franchi <marco.franchi@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: imx@lists.linux.dev
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c | 40 ---------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 658c7c040570..98480904126c 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -44,8 +44,6 @@ struct seiko_panel_desc {
 
 struct seiko_panel {
 	struct drm_panel base;
-	bool prepared;
-	bool enabled;
 	const struct seiko_panel_desc *desc;
 	struct regulator *dvdd;
 	struct regulator *avdd;
@@ -122,25 +120,10 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel,
 	return num;
 }
 
-static int seiko_panel_disable(struct drm_panel *panel)
-{
-	struct seiko_panel *p = to_seiko_panel(panel);
-
-	if (!p->enabled)
-		return 0;
-
-	p->enabled = false;
-
-	return 0;
-}
-
 static int seiko_panel_unprepare(struct drm_panel *panel)
 {
 	struct seiko_panel *p = to_seiko_panel(panel);
 
-	if (!p->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 
 	regulator_disable(p->avdd);
@@ -150,8 +133,6 @@ static int seiko_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(p->dvdd);
 
-	p->prepared = false;
-
 	return 0;
 }
 
@@ -160,9 +141,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 	struct seiko_panel *p = to_seiko_panel(panel);
 	int err;
 
-	if (p->prepared)
-		return 0;
-
 	err = regulator_enable(p->dvdd);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to enable dvdd: %d\n", err);
@@ -180,8 +158,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	p->prepared = true;
-
 	return 0;
 
 disable_dvdd:
@@ -189,18 +165,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int seiko_panel_enable(struct drm_panel *panel)
-{
-	struct seiko_panel *p = to_seiko_panel(panel);
-
-	if (p->enabled)
-		return 0;
-
-	p->enabled = true;
-
-	return 0;
-}
-
 static int seiko_panel_get_modes(struct drm_panel *panel,
 				 struct drm_connector *connector)
 {
@@ -228,10 +192,8 @@ static int seiko_panel_get_timings(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs seiko_panel_funcs = {
-	.disable = seiko_panel_disable,
 	.unprepare = seiko_panel_unprepare,
 	.prepare = seiko_panel_prepare,
-	.enable = seiko_panel_enable,
 	.get_modes = seiko_panel_get_modes,
 	.get_timings = seiko_panel_get_timings,
 };
@@ -246,8 +208,6 @@ static int seiko_panel_probe(struct device *dev,
 	if (!panel)
 		return -ENOMEM;
 
-	panel->enabled = false;
-	panel->prepared = false;
 	panel->desc = desc;
 
 	panel->dvdd = devm_regulator_get(dev, "dvdd");
-- 
2.45.1.288.g0e0cd299f1-goog


