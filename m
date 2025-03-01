Return-Path: <linux-kernel+bounces-540055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEBA4AD09
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCCD3B32D4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD91E5B8A;
	Sat,  1 Mar 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC1MP5NP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5A1E51EB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740849068; cv=none; b=k8GKptqy+imsHgf/B58ksqfHFh29HVFKhGALPhPF22VNxjunWCTYZExSFJ/Xg8cWPYZoeI0EVEcKwKkvDS90N9m7dXFzCI394Disu3gEKTiHKTTDjUFO3cDp/hNMs3TyYc/W84wS2VuXPvpPVJn+Ok1YTcq0Iej4mMitWltcfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740849068; c=relaxed/simple;
	bh=0KZ6BjD9kkbPOzEapQgVo4Pi20+SxI1Up4046oJIkmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJpyrcLHVr4NAyoYZnTDLq7qmNtLFjUDvfNSDd0A++OPOnSoqup5UCLh7hcD9kM7ADl2L+5DS6Bfi7R5gFgZsvUjsF/i29d0NK6D8RVBxQs7yZLU3gx4vu4jKn3eAZVqzTrknSsz5TFZKW77il3CPa85dTxYpjX02MMOiRNE30Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SC1MP5NP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-546210287c1so3181899e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740849062; x=1741453862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sa7U0X8/8uGLoVtUTqFfyP06cJiyIzwQdCxGbYAjt0=;
        b=SC1MP5NPBbb8Lq1rpKM+YCHZ76cZSondpPmbbVlzoYDVhSIHGTxXmQmsRIH0J5mTy2
         5b06sbQrNnyc8KDi4Y5HAzhzw1Dqlslcma6QY8ozZJi9slzYYZkvbqVXnEW1Y56j8Pv9
         dhR6c8b575SGlchj+n1RcyJq10pGp4y+1RCxj4059waG6IeoFEBi9TE8+EcpYpNIzXs2
         F8AFkYv8QR5jOtnT+3geVqfexEg3yCQkMZF3a/UeWwqvoTzBsBasksGq9cjqMueeSIWC
         SXe48DrnyiTUjeRnxKLNWxKtrEN4Ibci7Hq1Xz4QzKINk7m8qAUxsDcErnHn6cjsUNA1
         LGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740849062; x=1741453862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sa7U0X8/8uGLoVtUTqFfyP06cJiyIzwQdCxGbYAjt0=;
        b=aBjo9KJ1nBe8skWUkcYgWMCXICrZ/q6K72deHNJ/A9aQ+f2RwftcbT6xfUpSeXnVkS
         B0uNnUJxljAsmjju6xoKZNGbq6ZTM1wMxKcL+JEna+XCP/ud+n40NUa06eUVBQ+HlZgi
         WyRO9/TJRyOTj+4S6Wkube9ZKn9/j8GdgFdMrpJN2jsQTEZV6sVG6kQEWiWzNu34uojl
         IgGBtD3xoOf94C4VBFvzVpgGGGK2o9OG4mk9aBBAq4I4MOeZpzHFm1J+7K+jr3C+1nI/
         zl5jFuqT2AyfnZjPGctruJ4XuwnxZa1Y/Ma2+WsmZc6FM+j79UfuTi+DZGIlJ240Er0F
         o3mA==
X-Forwarded-Encrypted: i=1; AJvYcCX72RonRdWPa6FqEQEoUYzLljsgb/T6rNRq+rwYZVDwn+jkskDRdFAGBLeB609jiJB6Zq+jwwFQqZA/Tsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dxMdL5cgcNIOhDzjxTG+NecCTaKFf0wAglwYPqT/KiJVobGi
	kXR+GZ7IuqI4OeYiitI8xqL49mnNgFr6lXluoqrmWRyWNZlU/v3vdPwSj13CUrI=
X-Gm-Gg: ASbGncvpA4LwxdOfoC8RvRZFtrrMRazREKeXzEF6DPwXKPs6mj8IacP1/UXWkH28xps
	yXUDdbo3MfjBFsRxF0R/Pwgwi0OLurUr+UH9CdPmAMVIrFJW6JxdYe8AqemHqftRXHoM0gIKcZu
	srcLW5bdqEBoZ8/EebrUiMTGX4usYp4yfzbke9bjpnH8tU+qFKrsrmWVl4QblGxMytbJ/YbK379
	8aXqoGRmwTOA+yoi4Q9sBQjg6TCILJPjKoXes76NWCVpboxd1MUuo0/ZQ5sCMtDRyKgclUtlTha
	XzBAXDIdtY3Rd00D8IIQJSpL7cAK4FFBtu37i55B7UTWlh8vMGxL
X-Google-Smtp-Source: AGHT+IFxIXblk0CUDHV/yH7CE+lnvUp/SJ1Wd8GqjybtF+Fd2Y66utDGKzIurb7EJSyE7nUZ41ll3Q==
X-Received: by 2002:a05:6512:3405:b0:545:f90:2753 with SMTP id 2adb3069b0e04-5494c330b64mr2950721e87.30.1740849062429;
        Sat, 01 Mar 2025 09:11:02 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494e52a47asm585313e87.152.2025.03.01.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 09:11:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 19:10:55 +0200
Subject: [PATCH v4 1/2] drm/bridge: split HDMI Audio from
 DRM_BRIDGE_OP_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-dp-hdmi-audio-v4-1-82739daf28cc@linaro.org>
References: <20250301-dp-hdmi-audio-v4-0-82739daf28cc@linaro.org>
In-Reply-To: <20250301-dp-hdmi-audio-v4-0-82739daf28cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7863;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0KZ6BjD9kkbPOzEapQgVo4Pi20+SxI1Up4046oJIkmw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwz+hENQvH7EidVBdkgsOS79KdtpCG34RB1aMs
 AVQ4tEAaOqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8M/oQAKCRCLPIo+Aiko
 1SK8B/4z89l+bCMrMDQuC6cu924PldQq2McK5X25hBugFH2juIuFb0QPhsv4fHFSwYLBieGSDAl
 TVrinDM0a8VuzciuiCm/3ipGVPC1IC27BzNACngigGt8kjGorG28k8v+QaHCteLXOb0SNf5mxrZ
 O/ovhaCnmTQjGnSDQt/SeYKHEskKnRSo4JAS3N+vAqpbBM/mYeS2RpuKCnQDDyufHMgWKR0KUSU
 fEGigT3Hgcu/+qlq6uQymZ4RZiGZg+PAqyhxX0EiCnNBJxM7wsYilu2CV2AQ5PzZWiLrpTk2d2K
 WhHTXeLiMIRkgfRDvaCNCQgLzH9NH4yRm+JoUxwiIvK+MHUX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As pointed out by Laurent, OP bits are supposed to describe operations.
Split DRM_BRIDGE_OP_HDMI_AUDIO from DRM_BRIDGE_OP_HDMI instead of
overloading DRM_BRIDGE_OP_HDMI.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c        |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   |  1 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 59 +++++++++++++++++---------
 include/drm/drm_bridge.h                       | 23 ++++++++--
 4 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 026803034231f78c17f619dc04119bdd9b2b6679..3b93c17e25c18ae0d13e9bb74553cf21dcc39f9d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1130,7 +1130,7 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.of_node = client->dev.of_node;
 	lt9611->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
 			     DRM_BRIDGE_OP_HPD | DRM_BRIDGE_OP_MODES |
-			     DRM_BRIDGE_OP_HDMI;
+			     DRM_BRIDGE_OP_HDMI | DRM_BRIDGE_OP_HDMI_AUDIO;
 	lt9611->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	lt9611->bridge.vendor = "Lontium";
 	lt9611->bridge.product = "LT9611";
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 6166f197e37b552cb8a52b7b0d23ffc632f54557..5e5f8c2f95be1f5c4633f1093b17a00f9425bb37 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1077,6 +1077,7 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
 			   DRM_BRIDGE_OP_EDID |
 			   DRM_BRIDGE_OP_HDMI |
+			   DRM_BRIDGE_OP_HDMI_AUDIO |
 			   DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 30c736fc0067e31a97db242e5b16ea8a5b4cf359..030f98d454608a63154827c65d4822d378df3b4c 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -98,6 +98,13 @@ struct drm_bridge_connector {
 	 * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HDMI).
 	 */
 	struct drm_bridge *bridge_hdmi;
+	/**
+	 * @bridge_hdmi_audio:
+	 *
+	 * The bridge in the chain that implements necessary support for the
+	 * HDMI Audio infrastructure, if any (see &DRM_BRIDGE_OP_HDMI_AUDIO).
+	 */
+	struct drm_bridge *bridge_hdmi_audio;
 };
 
 #define to_drm_bridge_connector(x) \
@@ -433,7 +440,7 @@ static int drm_bridge_connector_audio_startup(struct drm_connector *connector)
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = bridge_connector->bridge_hdmi_audio;
 	if (!bridge)
 		return -EINVAL;
 
@@ -451,7 +458,7 @@ static int drm_bridge_connector_audio_prepare(struct drm_connector *connector,
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = bridge_connector->bridge_hdmi_audio;
 	if (!bridge)
 		return -EINVAL;
 
@@ -464,7 +471,7 @@ static void drm_bridge_connector_audio_shutdown(struct drm_connector *connector)
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = bridge_connector->bridge_hdmi_audio;
 	if (!bridge)
 		return;
 
@@ -478,7 +485,7 @@ static int drm_bridge_connector_audio_mute_stream(struct drm_connector *connecto
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = bridge_connector->bridge_hdmi_audio;
 	if (!bridge)
 		return -EINVAL;
 
@@ -576,6 +583,21 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				max_bpc = bridge->max_bpc;
 		}
 
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
+			if (bridge_connector->bridge_hdmi_audio)
+				return ERR_PTR(-EBUSY);
+
+			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
+			    !bridge->hdmi_audio_spdif_playback)
+				return ERR_PTR(-EINVAL);
+
+			if (!bridge->funcs->hdmi_audio_prepare ||
+			    !bridge->funcs->hdmi_audio_shutdown)
+				return ERR_PTR(-EINVAL);
+
+			bridge_connector->bridge_hdmi_audio = bridge;
+		}
+
 		if (!drm_bridge_get_next_bridge(bridge))
 			connector_type = bridge->type;
 
@@ -611,22 +633,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       max_bpc);
 		if (ret)
 			return ERR_PTR(ret);
-
-		if (bridge->hdmi_audio_max_i2s_playback_channels ||
-		    bridge->hdmi_audio_spdif_playback) {
-			if (!bridge->funcs->hdmi_audio_prepare ||
-			    !bridge->funcs->hdmi_audio_shutdown)
-				return ERR_PTR(-EINVAL);
-
-			ret = drm_connector_hdmi_audio_init(connector,
-							    bridge->hdmi_audio_dev,
-							    &drm_bridge_connector_hdmi_audio_funcs,
-							    bridge->hdmi_audio_max_i2s_playback_channels,
-							    bridge->hdmi_audio_spdif_playback,
-							    bridge->hdmi_audio_dai_port);
-			if (ret)
-				return ERR_PTR(ret);
-		}
 	} else {
 		ret = drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
@@ -635,6 +641,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
+	if (bridge_connector->bridge_hdmi_audio) {
+		bridge = bridge_connector->bridge_hdmi_audio;
+
+		ret = drm_connector_hdmi_audio_init(connector,
+						    bridge->hdmi_audio_dev,
+						    &drm_bridge_connector_hdmi_audio_funcs,
+						    bridge->hdmi_audio_max_i2s_playback_channels,
+						    bridge->hdmi_audio_spdif_playback,
+						    bridge->hdmi_audio_dai_port);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
 	if (bridge_connector->bridge_hpd)
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d4c75d59fa12be1bd7375ce3ea56415235781b28..dff8cf035b30d5c7e00bfdf5d6e12802559823ba 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -693,8 +693,10 @@ struct drm_bridge_funcs {
 	/**
 	 * @hdmi_audio_prepare:
 	 * Configures HDMI-encoder for audio stream. Can be called multiple
-	 * times for each setup. Mandatory if HDMI audio is enabled in the
-	 * bridge's configuration.
+	 * times for each setup.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_AUDIO flag in their &drm_bridge->ops.
 	 *
 	 * Returns:
 	 * 0 on success, a negative error code otherwise
@@ -707,8 +709,10 @@ struct drm_bridge_funcs {
 	/**
 	 * @hdmi_audio_shutdown:
 	 *
-	 * Shut down the audio stream. Mandatory if HDMI audio is enabled in
-	 * the bridge's configuration.
+	 * Shut down the audio stream.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_AUDIO flag in their &drm_bridge->ops.
 	 *
 	 * Returns:
 	 * 0 on success, a negative error code otherwise
@@ -814,6 +818,17 @@ enum drm_bridge_ops {
 	 * drivers.
 	 */
 	DRM_BRIDGE_OP_HDMI = BIT(4),
+	/**
+	 * @DRM_BRIDGE_OP_HDMI_AUDIO: The bridge provides HDMI audio operations.
+	 * Bridges that set this flag must implement the
+	 * &drm_bridge_funcs->hdmi_audio_prepare and
+	 * &drm_bridge_funcs->hdmi_audio_shutdown callbacks.
+	 *
+	 * Note: currently there can be at most one bridge in a chain that sets
+	 * this bit. This is to simplify corresponding glue code in connector
+	 * drivers.
+	 */
+	DRM_BRIDGE_OP_HDMI_AUDIO = BIT(5),
 };
 
 /**

-- 
2.39.5


