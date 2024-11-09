Return-Path: <linux-kernel+bounces-402822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEE9C2D22
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8472829E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F11993AF;
	Sat,  9 Nov 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwpGjrZ/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D419923D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731155736; cv=none; b=EVunrs8IChn9Xe/uAVghrsvx6g/ZnioVGEIp01LdJmmGF0Zh3dHng7bwAMFwv75TPdo/uftDp+Lz/nXvv0hSfGGSqT3ycoi1eRCiQlHh+AXaPkLfFGNCpbo3zk5MnA0WyeA5OM0XLasVe0jAsEbPTCIjUxG4toEqmAPd4txKjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731155736; c=relaxed/simple;
	bh=NRpLumrdDZhSXCJcusWkwzHsBkwvkTsOwVSCIyGYQBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l24CpSl/GcKgLVdLQ0J/MTtl/eFt1UUAaWgdEUggswUDJtShQyDSEHhkF8AjBA7n8BuFaku62WG6Da6uShzD/Tr9T5XeuIu70ApSkqac6zxUps+dyibMqxRtkKXjBFZ5bZ8DUDWnoe6uX7ZuAekLtaLzweCR5isiBX+PRRDOcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwpGjrZ/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e13375d3so3656335e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731155733; x=1731760533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+pN3XKvVFmetq3YJbHAkykp748W6pEN5H4vcdcbZbk=;
        b=AwpGjrZ/Xli1KfI1NYatJxUoEVMfsxo0ri6sU46Oti+kati5y0CRv3WuInXhdIi9lo
         yDhxf+E/dQ3f/0mL+EdzLTY8P3OLY912zUfmO2osEEVodoKOYK9MPZBDt+h0rpKJNlRI
         WR/irWlV+0UJGQnMwqWhOWmM1aIjQwVcQ0vkN1u3wxXBD0O5kytxuwCpgqmpn//oD6Ue
         5MooNeQl7VnSrA0w24wa31WEgACWbuZEo4Z55AlNv3o+78Jp7lpsAlfR6JwL2F6bnhxQ
         9p6imSyNIaiXMtxdE8I5PHOotFHm/6Pylxg2jH79UX11DUNtsDoEHKL8wTl01VvMgZQ3
         kqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731155733; x=1731760533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+pN3XKvVFmetq3YJbHAkykp748W6pEN5H4vcdcbZbk=;
        b=Mp5ZmwTj1HFLRZ2hw+MZ+AYdtte/20aBAXZxuHzKiql3AJZCEOybm/ozEpPlXOXtZ9
         UuFcqWmjlBjtS4a6bwqtM/YsEPIHLcxKwRCx9ZzKsj3xrMa5oGLKTnsSTquOmMRkVoPb
         b6l0r5nCHNGBoKGGhhdOvL690H/sI/4gip6fkEqSCLCoSL178aXWs7X7c3tIV693MnjT
         ZwzHes+oUkklfV2rPIF53a9EIYE3R4xE2V7Ca4D5n5YOnQDZNBsLn+dmcXVRq/RWN1tl
         TYcs2pdr3jeRhBsM57aCknvwmazbL2RCDZRgGCDbAb8Vtz1vGAPjuga6P3htMI0wUvP+
         1stA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3bwpr31EQGCoYv56wvLd3tx6dKv36md5d7r5wYVgUuSzyCstXjHIuN18rPA9t7OtyyyUB4yJ8S40yGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6gpLoUAfMYQwokXRU3d/WCrGwOiSfgnTinH5a5fiGv2hQGDW
	g9qAf5pUJU55bbrO85DpR7aoOuFAqbWV5Q1gjm7yJ8C+RgxpIm16Zj12tfeVIQ8=
X-Google-Smtp-Source: AGHT+IHYy8a0Jl0t4eXfYO7d1FqKeWB0bC8cvUQRPjyNFzEV2jihfF3Am0WWkBzVwoqL1QUMEqIP1A==
X-Received: by 2002:a05:6512:3f16:b0:539:d9e2:9d15 with SMTP id 2adb3069b0e04-53d8623fffcmr3082722e87.29.1731155732594;
        Sat, 09 Nov 2024 04:35:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784dbsm922899e87.15.2024.11.09.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:35:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 14:35:11 +0200
Subject: [PATCH v3 7/7] drm/sun4i: use
 drm_atomic_helper_connector_hdmi_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-hdmi-mode-valid-v3-7-5348c2368076@linaro.org>
References: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
In-Reply-To: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NRpLumrdDZhSXCJcusWkwzHsBkwvkTsOwVSCIyGYQBU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7p+2P/UnAP/1lS+cTe5zqq05k8zk9jJ3/kFf9hFefyer
 PvILuvWyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJ3H/JwTBByj1Gq3qN6AeP
 o7aBh83EfpQelbE2PxPHwSrQtOXuzpWWAdPL7V20fHnmPSgJPae4eu0jF4EvzSKi1hf6GBqMq/4
 eeLB96THGoJQfpepc7ku0Iy8Ei4RpMyhoFiceTbF5wJibpHuC37Nlnvn6xLlRhfOuScz40LdLMj
 vuZ1muq9PZ27M9+CN3C812ttdTdP+R/3jN9uAWG57HW0rPH+E1e3pukty3ZXZbUv4ylJ2/dyD3X
 MeLJPnAnaIOsusKL33yPnrZioPv9o+bP3ZYrlLsjS+/aRWZ2L1002uP9vgHx24wz2hv6qjrv/ih
 oTtM/MHPrSUulTmRUXP+1LEGMK7ck3dy07HdEs8aPB04AQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace sun4i_hdmi_connector_atomic_check(), which performs just TMDS
char rate check, with drm_atomic_helper_connector_hdmi_check(), which
performs additional checks basing on the HDMI Connector's state.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 54b72fe220afacc208b3fd48d5160031127ea14a..b05fd77870b00aac97d003f3fb9c2b98cb73abc0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -187,24 +187,6 @@ sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	return MODE_NOCLOCK;
 }
 
-static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
-					     struct drm_atomic_state *state)
-{
-	struct drm_connector_state *conn_state =
-		drm_atomic_get_new_connector_state(state, connector);
-	struct drm_crtc *crtc = conn_state->crtc;
-	struct drm_crtc_state *crtc_state = crtc->state;
-	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
-	enum drm_mode_status status;
-
-	status = sun4i_hdmi_connector_clock_valid(connector, mode,
-						  conn_state->hdmi.tmds_char_rate);
-	if (status != MODE_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -258,7 +240,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
 };
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
-	.atomic_check	= sun4i_hdmi_connector_atomic_check,
+	.atomic_check	= drm_atomic_helper_connector_hdmi_check,
 	.mode_valid	= drm_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };

-- 
2.39.5


