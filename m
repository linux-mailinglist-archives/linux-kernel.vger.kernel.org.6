Return-Path: <linux-kernel+bounces-201593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64458FC08B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE8C284612
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE81DFC7;
	Wed,  5 Jun 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQ+bGA4S"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74D199A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547073; cv=none; b=TOuuihjKK/W1m9pnZr13ayLq+DDPwvPmd+5yvTlCPxu0SkI+pKfRCRd5AXNjnqG7OHTkDnx3ZZfJmY4FNJfhUE5PKoPHRApXIK2uy4Lxtggtzx4dsOSuyKkm14ujBy5kexXW/+QV2SwzqfMiXZ7GrZaq88CP/B2d3RoG0d6ETO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547073; c=relaxed/simple;
	bh=bu8UuiVKJJOpwyvAQ8P16JcDitoUEWsEMbHVsjKpPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqfzSncSMdCIo3OFxkyjOtDhXNkeYO49n5aGHGdyMSD3qHQCIBiL4H3rIvfa6nrDo4OxOskFrBL6f7O/ItUTB1URgMc6VaMrXCQtpCEls/7Z1/VTLDe0lDWgS/ehpVC+vKHkeowunWHa1tqXNk1jJxlMk+uFUsWRVJsnq2872q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQ+bGA4S; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70244776719so1425183b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547071; x=1718151871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEmfWhNTcTb41jQU/gR81e0SjfT4byydDoGYn2r0lOw=;
        b=IQ+bGA4S2QBIJ9MuKi4r9LOFNUq8IZHj2oBcD3YPBD69ZSGLI+d6+w/baAp7kKehUE
         gqhXbp/MWNYdg8VSQbvOtmiuKX1wlYw3rT4WT3CpPwrHZ/KyGDWNCcc8v2KFkXid/0Bg
         8rJ1VGe+nUROhSzG3+Y8AkijaArjCyU0VOFeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547071; x=1718151871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEmfWhNTcTb41jQU/gR81e0SjfT4byydDoGYn2r0lOw=;
        b=lf+1I2Bq1XmvWUSEYRMAbWPo6PJwONTYd8NvNq+ebM1qar494ASy7/IKmhGm/cpE2Z
         DHJXkqXZXqrDPXpmzrXXyCTwF5FONXGiJOCEb3TlcuC4/YZVq0LpH9OGKegMPvt+/Vyu
         n2KJ6pemCnV5SGgrPPphA7LXgTfN8p7LehIaLFVSMNpbnAKV0yuQqzVtJJDU3j+Xxx5m
         cVCpGce9KmrztRiqs/iVkMUJIp1A7pcN2Uu/0hZQ534cGj87niNUVrGv7TEvHn95mM2n
         aGfy0OaxelnJdK5JqEyglioUFNqJ+9KnpHxdsmQJuddaCd7BAvT/UYdHbsw2vp37RwgH
         wtPg==
X-Forwarded-Encrypted: i=1; AJvYcCXWW/gDgtcyyw8mkC0CWbBvFH5jIwKkj5yPdEpmBbR9R/Kz4tZRFgX7nFrGZ7IqBJMvjjMpkqzVZ/DXkL0gCiW3KXsDmHpWxlOz049x
X-Gm-Message-State: AOJu0YzpzN9KLrFec+b1i6YZD4jDLzNkrSu4iUNZ4EENz3Yb7FuoADsb
	W8+GKRozPXMH2ui0zsW+ydJTB8tO1HLLoJ97dOs2Liz8VUWxgCfNdeco6UluyA==
X-Google-Smtp-Source: AGHT+IGrcYOLi8G0eH6ZEIWKdmcS2aKK/kOX+omU7O4LuSX64QDzn3W99H3vl2K8F4dPXhpgCaMlcA==
X-Received: by 2002:a05:6a20:2588:b0:1b0:2b96:5f9 with SMTP id adf61e73a8af0-1b2b7025eb1mr1451478637.36.1717547071596;
        Tue, 04 Jun 2024 17:24:31 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:30 -0700 (PDT)
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/24] drm/panel: tdo-tl070wsh30: Stop tracking prepared
Date: Tue,  4 Jun 2024 17:22:55 -0700
Message-ID: <20240604172305.v3.9.I5025ab14adc2efeef1be1843648547fb725106be@changeid>
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

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index d8487bc6d611..36f27c664b69 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -24,8 +24,6 @@ struct tdo_tl070wsh30_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *reset_gpio;
-
-	bool prepared;
 };
 
 static inline
@@ -39,9 +37,6 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
 	int err;
 
-	if (tdo_tl070wsh30->prepared)
-		return 0;
-
 	err = regulator_enable(tdo_tl070wsh30->supply);
 	if (err < 0)
 		return err;
@@ -74,8 +69,6 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 
 	msleep(20);
 
-	tdo_tl070wsh30->prepared = true;
-
 	return 0;
 }
 
@@ -84,9 +77,6 @@ static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
 	int err;
 
-	if (!tdo_tl070wsh30->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
@@ -103,8 +93,6 @@ static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(tdo_tl070wsh30->supply);
 
-	tdo_tl070wsh30->prepared = false;
-
 	return 0;
 }
 
-- 
2.45.1.288.g0e0cd299f1-goog


