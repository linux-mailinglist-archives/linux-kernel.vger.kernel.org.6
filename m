Return-Path: <linux-kernel+bounces-521568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C013A3BF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CA3ADE49
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BAC1E5732;
	Wed, 19 Feb 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoO1vllZ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2081E0DDF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970041; cv=none; b=KkWnqPjbIepFsSoV0Lq4WvT0o+qZFka+ElZG8Nrh44rhXaKG25oMHwllhXaTpZaVqMwLrQeUOpmu0HPTke6IJFEBnNOftfMQkxb/nPKG1l+gOXMF5366uyTso9sS0df+4tGKAE5NaxPeLAx5rmOUOoNNpciWqTVy8V0fdwXKt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970041; c=relaxed/simple;
	bh=5tKH69LPnXtw2g2lgp5pOEeBRn775Kcy79G0bglGhPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxxOUHXW2Fsk7N8MH9/Jor8gtsjpBWhbcK6v70D6DwNXiltZ9gpR6WfKwk2lmvaZhYI1ZLyMQI148v/OIP2YRazi+8HupJKln0YRX1TczOlfaFbIoLNJ9V1p6kc022QhssG8j20DrVIevcj++sOzEMqKsUJMOWMERTd9oxyVW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GoO1vllZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452efeb87aso5306329e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739970037; x=1740574837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyt2aJC9WtTbvDjyGKTp5US9Ym/jYLQQ/Fi2KJapvfQ=;
        b=GoO1vllZxPvYCww9gfs3dsQ7rXOfKkPxeXrPF/Ccc3nKJtfVTnLLLot5jbNfpre4l9
         7DP/VCsyBv/mI4y3ykW5frAD/umzfGaanDW+qkv75B6TlP+4X/po851pfkpj64tKSv7A
         rzJVuuvCXklaEHTJrNzT7EFMxuvCya+qFSqVj0OYvmZ4kOUwjUKPyXQ4AElVXMcH7WlP
         q118TFcHpK2jnqucsKQnUbRNHXKf1Y4bogxEwlM2dh/ZwUlLuJEIlNRJqeLNhRAieEe3
         36bbqvxqQjemGPFCH/Oau/Z2ZrVJ7GfF0KkYPcbBnpix/HPDpie2858isacNMt2p3etF
         Xx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970037; x=1740574837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hyt2aJC9WtTbvDjyGKTp5US9Ym/jYLQQ/Fi2KJapvfQ=;
        b=HSSgEGnL60/IyfAFVs8um4LtU6Vc08UGcWsuy1r7Y7TCSVD4vEAgwhQSV2zUv2giqn
         hJQYtAtde4XFqDPCEtZDAdIQUY85HgnWZ1ZRl5LCDSR5h9esmIn27GU6fh6Y4cbeRSUG
         SHZntq8ZZRuV1dmUyAL0IYk2CsA18Cfip+ovTwhErM/f97fxgOFOxdiGBVxva43hWGBZ
         /NhSc05a9LBNDUwbkIp+UbvV1WhfKguufBW8xssXSHd+sUywXD3V6Vf0nD+Ft1vZBcZh
         hmyAyE66fKHHc3tHLA6QVu49n5grE6RiSCHnEpBehQfMZJgQ4+KOo1ZbYi24MY22edYd
         9r2g==
X-Forwarded-Encrypted: i=1; AJvYcCXEgJhK0BafTY0HrEw3oexr797LtteSI1ZtAaj8TWnTB6XPAVDKKAKL4qhb47w+RHPF7WZulmx/eL3LhE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eeq6Bk9geQjBLBwsCY4gZ7f4aam0R6gUA2fMjEmp4g86xyII
	a7NAK/QbeQ7VpzZvJ25JITQHQftBp3gvUD9lqMUr2Il+nxJFvp0rK1fXeD0SuXY=
X-Gm-Gg: ASbGncvZ6EhONu7FagxsPyoTlNm03bYSRQ5qry0Bq/FGMZ4QUDlrh1u5NtjeY7pglJJ
	/0VnKEkwsF6D560VqJ82qRsbZ8Nm7HlT+nu/ZKv+2/nPKBD1+2ymNJ+zrSB+pY7JUzgSryeUYlQ
	F55xcMDe3qqx6vuA2WKMjHdarEsynNACWkXOig9YwwhY7jkvVyZD3eGKBlIPcGqU7mt/VUy8RMg
	aV1uYwaQlRp1YgrbkXuZhjV8RweWvkUmK+vuYH9Rz8PCgVmmdHCWfEA5kofPvru6V4PMfE0VM6F
	t9aEv6zr0IRx3xBsWV6P1EQ=
X-Google-Smtp-Source: AGHT+IFSjOqhEeeXiJV4CZUukFLud+LZ+cKhSxvBhcfJdaf32GIRFicOUEbicv7Ah7Zu6MZXOndIpw==
X-Received: by 2002:a05:6512:2398:b0:545:ee3:f3c7 with SMTP id 2adb3069b0e04-5462eef4e56mr1422130e87.30.1739970037101;
        Wed, 19 Feb 2025 05:00:37 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105a3dsm2179515e87.144.2025.02.19.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:00:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 19 Feb 2025 15:00:30 +0200
Subject: [PATCH v3 1/2] drm/bridge: split HDMI Audio from
 DRM_BRIDGE_OP_HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-dp-hdmi-audio-v3-1-42900f034b40@linaro.org>
References: <20250219-dp-hdmi-audio-v3-0-42900f034b40@linaro.org>
In-Reply-To: <20250219-dp-hdmi-audio-v3-0-42900f034b40@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7153;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5tKH69LPnXtw2g2lgp5pOEeBRn775Kcy79G0bglGhPo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntdXx5Rfpjs7QrSW5Sqc27lyKyEYdNlobBgrno
 dH0zn3wNMGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7XV8QAKCRCLPIo+Aiko
 1faVCACwzQ+HmZRWj9pVGQ0FxDqNILIlaX1r5rQYmr/5OkHPuBlFez/H2reFj80/208eWC3Jt/F
 4w/dszTC6Mavd98pVxDwG4uLrBN4WRB0vz01gg2HJ8A5HflmMSVkzyTKKi3zYgPdL7qbHdTjfKL
 7CBu5YlwG2xFNiph1dNcADSY1oOjWZSXDKm5haeaxq6OMz/TLcuRa/72FlA27hrbopzWxhAydDh
 nP4mmhmTtUhD1ow/wTNud8BRWS7PJ5nLHJ7Gmz43lxg0uKcJ3vS+HorkhfSSmXT1J3rddFOOHpx
 aMrbBOlYFaZIm7QchyZUQ9R763/xbRGymttkFBrrrv8ir15h
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As pointed out by Laurent, OP bits are supposed to describe operations.
Split DRM_BRIDGE_OP_HDMI_AUDIO from DRM_BRIDGE_OP_HDMI instead of
overloading DRM_BRIDGE_OP_HDMI.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c        |  2 +-
 drivers/gpu/drm/display/drm_bridge_connector.c | 59 +++++++++++++++++---------
 include/drm/drm_bridge.h                       | 23 ++++++++--
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index e650cd83fc8d880012edb8a85c69b2f1d378f64c..6cb9039ee7c4720b3512adb5a591b1b84ee32107 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1134,7 +1134,7 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.of_node = client->dev.of_node;
 	lt9611->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
 			     DRM_BRIDGE_OP_HPD | DRM_BRIDGE_OP_MODES |
-			     DRM_BRIDGE_OP_HDMI;
+			     DRM_BRIDGE_OP_HDMI | DRM_BRIDGE_OP_HDMI_AUDIO;
 	lt9611->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	lt9611->bridge.vendor = "Lontium";
 	lt9611->bridge.product = "LT9611";
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
index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..90b7b8070748a104ffca021e669f78e4d4b993e7 100644
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


