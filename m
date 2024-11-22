Return-Path: <linux-kernel+bounces-418002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329139D5BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64A9288334
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AF1DFDAF;
	Fri, 22 Nov 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aReSrTav"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0B1DE2CF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266818; cv=none; b=odVGRistxP+GAvK5fzah9YAGtAHw8HzkSIAD0g3ZYQfDpIcjhtFmRN08TajDLc6DnzODe78ZN3dEbEaN97NFEuy+FMTN3kVVqzBE6MKfyauYM+tAC8Oi5JssknsXlBAbtWW7SM+MLClEAzCdl0iCEdgu7kzrRH+30VF96OQCqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266818; c=relaxed/simple;
	bh=NRpLumrdDZhSXCJcusWkwzHsBkwvkTsOwVSCIyGYQBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlaJ/IwWFO1O4K0tVlYuyp/QCvLVbLpaVHVn465XYGZKh+j3QD9MToxSDIOZlPzUdW/Z6hs3kRLoc5JY/uWd11etl4ibep54TNX5qQmPmRl/aWl+Vm+zcQH6xU3tLuoFpV+MTCIhcZautn+9MtmaPJW+L+Gjt0air4RJHmYFFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aReSrTav; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a007743e7so2078685e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266814; x=1732871614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+pN3XKvVFmetq3YJbHAkykp748W6pEN5H4vcdcbZbk=;
        b=aReSrTavPmefqiJJxzteHzuaZq2g26wDGcOsg2opcPSdbAgbuEfJI38+quBcGr9wgB
         3hoBoliJzrVSEIQJTNTbJU1Zbz3p2Bv05mN71RhBYLXqdzSazeMmMgxaJwZagZL+7jZc
         Mq0PXfXDY6mfVwDtMafnYPWZKIwOvR2dvymn8dxWCgioKgTflL2JVThbrG9nRAEgp7sH
         B9ckTVWzSK7sG145LlXik+oUf76t5PbGYoF4lfkN330WrQxZw6b1+5TU78RqNOQ4PvvA
         vGUxCXnelI8DNGjMViJsGAE7ANDk1v2PL//ZitaEMlzP13qzYjKCUWu6taljJJ7PtyrA
         aCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266814; x=1732871614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+pN3XKvVFmetq3YJbHAkykp748W6pEN5H4vcdcbZbk=;
        b=hJlNj+ekQpOZrRe+Ccow02r2xxc3JZmawAdAUe/dg9EullxzoP3/1NsKobZEq64YYh
         DgUSwtR3AlGdN/PJ0WekxS8+j32rdVhLtQFesezDIH7OQ1q+BsB0AkuhbONXHeL/Zb29
         ogi6Sv+QhyNKCkdCuBwNrfopbnonk6s6l2ylQ2nuZUZTUk3Pq6RRAGYzfCJhjPikNfmu
         6EmOHGzgNCE0cM9VHbKOWm31XlfLSbqihDfM/CuWPD2mUu61d0bDKnCRhb+3Pn5qrpDF
         M+Ttlu3BJC7v6bmmLwUO0y0VJ9L3kgX2tbflv1zjuRFHKRseRGD9H8w6kra14jB0r4PX
         ivNA==
X-Forwarded-Encrypted: i=1; AJvYcCXBgOMmNb8NsBWKrqZjMYdwRxbtJQbTHLK5WeVjZNYzvmiMoFxhTQqikUQwFYvlgWRv55deXSNVv8U4Qf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyIk2IVQuh8QID+KDxzWpz4mkKv+Ju4YiuKBDVZXzptXfqqzO
	mgsg3NZMh1TisC13Q63AWP2TcUvG0y2+fsWo7SkuLqDbF9622pXBA7N6ne15Gyot/TU2Fz2ul8e
	Z
X-Gm-Gg: ASbGncung0df3phqcO58+Ey0v9aioHE5z2xYl0622Jm0BaMoX92syGV1xQ8S1W2VDNJ
	nF7rowOf+FP5wcLlQXh3d+pzPlQyoQDCzTsfWiSwnZPV3FJ7YjmbKNK+d9O66ns3LfZ4+GqFumo
	yv1MFsXHXxYdhvO4H7MO8uJy6oAiRtWXseCnkCchvJJE/cSwTF7Rf2XtR5rep6WCuA4vJPnLCOT
	yq0WP/Gkuf9T2+ErgLN6IJVFGxaS6GpvAqpfOGz+Xp/k2a2m92JcPrD0A==
X-Google-Smtp-Source: AGHT+IFuPDVVeiIBHBx+sqGVLigoH/J3FctzJhynNILKoVJRUYGgovyLxnstEYxyEorm8Lhl1P2kvQ==
X-Received: by 2002:a05:6512:230b:b0:539:f6c4:c29d with SMTP id 2adb3069b0e04-53dd39b4d2bmr879301e87.54.1732266814401;
        Fri, 22 Nov 2024 01:13:34 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:06 +0200
Subject: [PATCH v4 10/10] drm/sun4i: use
 drm_atomic_helper_connector_hdmi_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-10-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEsiTDOV2BoHyoyOts+0adMkGX+r4MYsJsnPa
 Far8OQb/72JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIgAKCRCLPIo+Aiko
 1UrVB/4mHUMcziWq1wY32ABnFkVrTROOJMHkHk+6+aK4dszHbnC762R/MtVLV2lOqnA6MnxSNW0
 EVuY2bQWv4PVDAZe+RPKyAm1fyLq9OizOUvRo1l12zL/O2139m41O4x3tI0r6uFqif8Pn4rZMCk
 t2ZMyaLmzPC6ufRtblUgk+VXVLehNTanDBHYRGga0siqsAnC662tRVl9Nf7/u1NOCILS6qYcKel
 P1sPNcHJSvULZIp9OJpXG/FZB4M7PHg/tR5MlTQzjrj0PWaj0798D+vDyF6eDysiUqnzifGcaGx
 giuaughGqZtani8SvGv0/wuVrNdnUepnAPAPfoATeqV2sc3E
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


