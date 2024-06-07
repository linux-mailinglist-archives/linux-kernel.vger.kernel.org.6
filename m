Return-Path: <linux-kernel+bounces-206128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A29004A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786531F229CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124B18F2C9;
	Fri,  7 Jun 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyaGnPEU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FA194A49
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766592; cv=none; b=UjmN2UWNOyhDC3+3ye2nZa53he9exZxZndyJ09ZWpWJPxlMlYMpE+gIICp+ixn/e7XjsG89/K5JNg/eiIYJN0vNqEWMNirAQDNNbZ0Vku5nzvAeeHDiAnqCSdFeH8lWs+6fw1judaDgkAHNkGZGsFcCssqP2SqR79J5MtGLc9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766592; c=relaxed/simple;
	bh=q7d4WPEa5GdCsRctIQMjtDo9wt1M5AQaev+03cz0EHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAMq7iKiuDvGsaBkjRxLAYxtyveoxZY4VYz0haHCKgUIfSuEQSdDCFgmH/cXRszptEHFHe9cJm9j4x380bfGQu6G3F0CicxHzzQJ3OVbZyAyM0ephD+rRbzykjJJO+7SlbQgQ/cNZAOJGytMmFdJjE9RFQ5I01GRncUMQYEKcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyaGnPEU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc274f438so437764e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766589; x=1718371389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFLpao8lXVnpqLacJaIW38fnXT4yNr9NSglb0CNyDOg=;
        b=nyaGnPEUGrXCetCZt7iTisSgk6yn8NeuUrUbSMk/mj6B2XUzzsV9+jLPl9OVUZqP99
         OPW3LJ7rGq5qfcLlhYe+55tAjde+ViSCYaOjYMuC82SDPTBjh0jDCBiTA3X1RaHw2GuO
         ZRTZoOcOFObn3Tvzfxun+QsB9aENxFC0RV6j4QhlIzQ4/k5gSpztflm4x5jSxpzGjV0H
         UWvvGb4Ye9VQWiKh+QVuccaq0yYU1OpZW4s1EWlbFJG0fqUvYFXBdJKJmk/06otwOCvY
         XUx+XGGQYRGHc6NP38tn5F7JQPnZCdiN+68WvCAOpX5Kzf1mzA4OCjLFnNxrmjrytv9g
         LrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766589; x=1718371389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFLpao8lXVnpqLacJaIW38fnXT4yNr9NSglb0CNyDOg=;
        b=lgnPhxQX/TjTA03/ZgLSerYh5ut7HG70ChLNdujz4eGuqXLZQw/+6pcfHDtf6kvbsI
         rwMcR62nSfZRCQnIlCGpeUd3wOU8datE9gaJ3z9TphJZXg34UWAwFKdGMi3jV0hA513K
         n7UEyup1tRh5/+u7greOM1zkd2PxkovY4tFZuMkdNH8V1S+XMH3+Qpyex0qO90xKqSMS
         88JUf9m97J/v7+lk34uzUh/RPDgf5/QOL8KI3N8Ped/Gj0rL1n/BtQZKZuXkHvrZk8Fr
         Lq/mkoT5u+HqCQo+rKQ2Q3imuylRXbbJ6O45iGszOyJsdNws+mXsJTQfv1h7SViWQrHC
         zE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+OxaQtT5g4mHc9dpmGTCPf5dMRawqrYHrzmVftJFyNlG0dW0KYl3vLhi6Hg5xjh3kVayi3Va2kXCFQAIZEWDd0cGoBoB3cP9iTw6
X-Gm-Message-State: AOJu0YygCjBaxaegBRAHj1it6au2ESfS3gt8Sl1NIwEKsb/VrfkrM8/8
	Zoq1B+wTq4HK7e5WgNPF8ooTUmkVGIun38UVH31eVpGjgZN32MZrDehAHZmGrkw=
X-Google-Smtp-Source: AGHT+IFwbCnkEttOX7Sj43f6XgZ+FrGjlJOw5VScJE8gXyX02Vm6NGSQvPT3847b3ujM3X6JFDYoGg==
X-Received: by 2002:ac2:4daf:0:b0:52a:d87f:60e3 with SMTP id 2adb3069b0e04-52bb9fd29b6mr1599625e87.57.1717766588996;
        Fri, 07 Jun 2024 06:23:08 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:23:02 +0300
Subject: [PATCH v5 5/9] drm/msm/hdmi: turn mode_set into atomic_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-5-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=q7d4WPEa5GdCsRctIQMjtDo9wt1M5AQaev+03cz0EHU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm2FehfWZH7hrOSzXh+wQjgiGhRZOnSWf0p8
 h6EXhtCIeCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtgAKCRCLPIo+Aiko
 1YbgB/9oufFN9Cke5yMN4dRGnuGaFtH83zlgZqe1vA46MbXbxQ3xDNS09nm7k4pN9MevYR20acx
 z26y2Ip4LSnD/YO1IBfNAHyuY9HF3uiI1I1BAsXGVWrJ/NSOe8M19s2LBg7xCGLCLjwd6u8rTk0
 e25yIfzfj3Q5PIYR0RYbqPGXgRvtzXflyDWL3SviRo6KhOWU0LoSOdPak+oy/dogDToTr0cJyDv
 gqalGyvpta4XA14hFaKVcBEb+6lfZLyDWoVsfRJkrRx86kA5+4kckPhHrCHiPIrEBoYwtM6A9Hg
 m9jUkM6b1lMsZK3grSIjdKGQ0CkAw6zsKu4lMu5wFRgqKFnk
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The mode_set callback is deprecated, it doesn't get the
drm_bridge_state, just mode-related argumetns. Turn it into the
atomic_enable callback as suggested by the documentation.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index d839c71091dc..f259d6268c0f 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -129,12 +129,25 @@ static void msm_hdmi_config_avi_infoframe(struct hdmi *hdmi)
 static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					      struct drm_bridge_state *old_bridge_state)
 {
+	struct drm_atomic_state *state = old_bridge_state->base.state;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	struct hdmi_phy *phy = hdmi->phy;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	const struct drm_display_mode *mode;
 
 	DBG("power up");
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	mode = &crtc_state->adjusted_mode;
+
+	hdmi->pixclock = mode->clock * 1000;
+
 	if (!hdmi->power_on) {
 		msm_hdmi_phy_resource_enable(phy);
 		msm_hdmi_power_on(bridge);
@@ -177,18 +190,24 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	}
 }
 
-static void msm_hdmi_bridge_mode_set(struct drm_bridge *bridge,
-		 const struct drm_display_mode *mode,
-		 const struct drm_display_mode *adjusted_mode)
+static void msm_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
+					  struct drm_bridge_state *old_bridge_state)
 {
+	struct drm_atomic_state *state = old_bridge_state->base.state;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	const struct drm_display_mode *mode;
 	int hstart, hend, vstart, vend;
 	uint32_t frame_ctrl;
 
-	mode = adjusted_mode;
-
-	hdmi->pixclock = mode->clock * 1000;
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	mode = &crtc_state->adjusted_mode;
 
 	hstart = mode->htotal - mode->hsync_start;
 	hend   = mode->htotal - mode->hsync_start + mode->hdisplay;
@@ -305,8 +324,8 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
+	.atomic_enable = msm_hdmi_bridge_atomic_enable,
 	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
-	.mode_set = msm_hdmi_bridge_mode_set,
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,

-- 
2.39.2


