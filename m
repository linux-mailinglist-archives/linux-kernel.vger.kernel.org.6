Return-Path: <linux-kernel+bounces-215972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12453909975
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC31F21FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAF51021;
	Sat, 15 Jun 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlFTU/q1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9666535A4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474021; cv=none; b=KInLAAJW4lG4ilE1l3x1Eoaq3/M/+pG7awEMapGkbZafpPloTaQT6ahZFez1D1VU2+s0y+D/5VpuSTATvcIl8Ih3nC9ubQf6eW0qO/L1yKnXpNrCZAw5T3W6HjEDj2OovnLhjEzafAlyE+GBT4SIBBHFWlE8UvwohzuJFLNJZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474021; c=relaxed/simple;
	bh=9qyJ3spGDjMnMxvSzQbD6SgbbMB2IHj4AFz00AeF73Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hos+7GNz7QRhnfRkMtjUohoFksul7ApiwZsYe1T0zKxdIP3sHwP6H7WuIGIupmXDGC/9TpCqxfg4EmhGhYjS4x4v+RxWdERv2hp8x0bdW1FxAN16NEfKLD42Rnah/bIdOD0NUv2ZKZAGeXrLQmP2mIQRk5r1bJdkcbfeqtB942E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlFTU/q1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c32d934c2so3526908e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718474017; x=1719078817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zagial1Hqf0gQMJ4r3bBETUYdf9xoObT6u8X513CE/c=;
        b=RlFTU/q1uywMr6Dt1bLJQxh7RKmpmnS/QdmL9mCeI5TtCiFDnDpcZ3Of3/q/p7K26u
         715w48qmLK7rCr6XOj1Sv+s9FKSbqcky1Jcner77oohAM/aX4BqVqA57GoXLIz2Zut/Z
         /tQtnWqsSZzhowoLPkM6FDjpnxR37mkEzcU7SDdYn7kTAcMwCFQHNNLoIIGPmj3kvEV0
         gJCLoRek7/lhTriRq9WBkBHsZ6Et3yatrHrhnPIpx110EXmuo21YH7Yh0pcgodx5Rsdm
         BH+tRuMMBTWipaeEl5kwyAwF2eBZG3qEbDhs7XIBRlH25MCy2EvhtkTVoGCTU+8WG5YU
         zQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718474017; x=1719078817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zagial1Hqf0gQMJ4r3bBETUYdf9xoObT6u8X513CE/c=;
        b=uVBhGORV8MhkOjqpBp9i0b2kEJfkXoWCt4cDbDfpouhyevyO8Bo12maZq5MGpMFmgq
         RbGQNoNRr0Dg+D5janlzqvDzBSpx0VuTwE44K0n9SrVJXOZ/yKHigeV/Xq8tptmVzCAM
         +ytgI8Gwb9wC8guANoHTNvR4OOvoC2VdlJPzt5DJ1+wIQKr5+1rzIPdcA6eqCb427rVp
         MsUKQQWsHQfmlQTJice6EbhjY7YlTX6wYv8EqZgpr41+BoxWDvnEIa1AHZawaYEzlAMz
         t0o4mlJcwWFq2W0/CovLiR+t89zoUFno3HmhsvIcLEAXLuE3Es285RbWlxA5Zit4XM2x
         5nHg==
X-Forwarded-Encrypted: i=1; AJvYcCX9yQ6A+B4np1POgZz1DfQF10lTh+1C61kZuBtjAGAYkIVtLYL4M1I2FBlIkKDf224hqy87eLyMaGcbNDWtLmwsjs4PPQDKo66g1lwl
X-Gm-Message-State: AOJu0YzISjYwKJTaBB/HN/QyzuDxysyU27gxD7lJSnF1Zrm1J88ys51G
	aMwJn+/alkGV48c9iVYNZYgCxtedl1B3lkYq0rtDZfH1ayH4VyPuzRjqEkc4g8I=
X-Google-Smtp-Source: AGHT+IGEa6fYbnm8utLHEy/SZhPk/cQQ3mFskFXipOhkauxiVqiW0GWVOkOCWGj8UKZuDXRIYXPRdQ==
X-Received: by 2002:a19:ac03:0:b0:52c:4cfa:c5a6 with SMTP id 2adb3069b0e04-52ca6e6d56dmr2918061e87.34.1718474017042;
        Sat, 15 Jun 2024 10:53:37 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287affcsm799209e87.232.2024.06.15.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 10:53:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 15 Jun 2024 20:53:33 +0300
Subject: [PATCH RFC 4/5] drm/bridge: connector: add support for HDMI codec
 framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-drm-bridge-hdmi-connector-v1-4-d59fc7865ab2@linaro.org>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9543;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9qyJ3spGDjMnMxvSzQbD6SgbbMB2IHj4AFz00AeF73Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbdUcWcZAmhsCIb/4ABEiX4VMbOdSHnfRGXU8u
 fYxUsRmrqKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZm3VHAAKCRCLPIo+Aiko
 1Wn7B/9NCdiqRayjQzUJ96ROIBhJzPiJOV57jaUlAdNu3hJjoZ5puOTfUggvMYIEAX5A1COiTij
 EDJ3SGQOfuShfl4KDkAQ1aBYHcH6ixE51266YpAPZiXZk/pz2Ooz4WL5S5KnHyYQ1Pcox0SI2KA
 Cn45B1QSWmYRGU6p5iIA5/Fh9QktxJp/TLrD7y7nriECTfmQrfu3MGIeU7E1WyIjfEx5j2sjhBn
 h2xtHgqRE2HUxmD9Fpjo6kDbIGMOiH01hNDdR8UNvSBapRJdsNGlIs+SMzenqdu7xjB8nLDHb6X
 EF2B2Axwv6XTFp+BfFlA0OnJTZBJJc9qufqHHmHjGlOULXbJ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add necessary glue code to be able to use new HDMI codec framework from
the DRM bridge drivers. The drm_bridge implements a limited set of the
hdmi_codec_ops interface, with the functions accepting both
drm_connector and drm_bridge instead of just a generic void pointer.

This framework is integrated with the DRM HDMI Connector framework, but
can also be used for DisplayPort connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 130 ++++++++++++++++++++++++++++++++-
 include/drm/drm_bridge.h               |  46 ++++++++++++
 2 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 0869b663f17e..71d6fdc2391f 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -20,6 +20,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
+#include <sound/hdmi-codec.h>
+
 /**
  * DOC: overview
  *
@@ -95,6 +97,14 @@ struct drm_bridge_connector {
 	 * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HDMI).
 	 */
 	struct drm_bridge *bridge_hdmi;
+	/**
+	 * @bridge_hdmi_codec:
+	 *
+	 * The bridge in the chain that implements necessary support for the
+	 * HDMI Audio Codec infrastructure, if any (see
+	 * &DRM_BRIDGE_OP_HDMI_CODEC).
+	 */
+	struct drm_bridge *bridge_hdmi_codec;
 };
 
 #define to_drm_bridge_connector(x) \
@@ -343,10 +353,104 @@ static int drm_bridge_connector_write_infoframe(struct drm_connector *connector,
 	return bridge->funcs->hdmi_write_infoframe(bridge, type, buffer, len);
 }
 
+static int drm_bridge_connector_audio_startup(struct device *dev, void *data)
+{
+	struct drm_connector *connector = data;
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi_codec;
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->funcs->hdmi_codec_audio_startup)
+		return bridge->funcs->hdmi_codec_audio_startup(dev, connector, bridge);
+	else
+		return 0;
+}
+
+static int drm_bridge_connector_prepare(struct device *dev, void *data,
+					struct hdmi_codec_daifmt *fmt,
+					struct hdmi_codec_params *hparms)
+{
+	struct drm_connector *connector = data;
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi_codec;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_codec_prepare(dev, connector, bridge, fmt, hparms);
+}
+
+static void drm_bridge_connector_audio_shutdown(struct device *dev, void *data)
+{
+	struct drm_connector *connector = data;
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi_codec;
+	if (!bridge)
+		return;
+
+	bridge->funcs->hdmi_codec_audio_shutdown(dev, connector, bridge);
+}
+
+static int drm_bridge_connector_mute_stream(struct device *dev, void *data,
+					    bool enable, int direction)
+{
+	struct drm_connector *connector = data;
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi_codec;
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->funcs->hdmi_codec_mute_stream)
+		return bridge->funcs->hdmi_codec_mute_stream(dev, connector, bridge,
+							     enable, direction);
+	else
+		return -ENOTSUPP;
+}
+
+static int drm_bridge_connector_get_dai_id(struct snd_soc_component *comment,
+					   struct device_node *endpoint,
+					   void *data)
+{
+	struct drm_connector *connector = data;
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi_codec;
+	if (!bridge)
+		return -EINVAL;
+
+	if (bridge->funcs->hdmi_codec_get_dai_id)
+		return bridge->funcs->hdmi_codec_get_dai_id(connector, bridge, endpoint);
+	else
+		return -ENOTSUPP;
+}
+
+static const struct hdmi_codec_ops drm_bridge_connector_hdmi_codec_ops = {
+	.audio_startup = drm_bridge_connector_audio_startup,
+	.prepare = drm_bridge_connector_prepare,
+	.audio_shutdown = drm_bridge_connector_audio_shutdown,
+	.mute_stream = drm_bridge_connector_mute_stream,
+	.get_dai_id = drm_bridge_connector_get_dai_id,
+};
+
 static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
 	.tmds_char_rate_valid = drm_bridge_connector_tmds_char_rate_valid,
 	.clear_infoframe = drm_bridge_connector_clear_infoframe,
 	.write_infoframe = drm_bridge_connector_write_infoframe,
+	.codec_ops = &drm_bridge_connector_hdmi_codec_ops,
 };
 
 /* -----------------------------------------------------------------------------
@@ -427,6 +531,23 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				max_bpc = bridge->max_bpc;
 		}
 
+		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CODEC) {
+			if (bridge_connector->bridge_hdmi_codec)
+				return ERR_PTR(-EBUSY);
+			if (!bridge->funcs->hdmi_codec_prepare ||
+			    !bridge->funcs->hdmi_codec_audio_shutdown)
+				return ERR_PTR(-EINVAL);
+
+			bridge_connector->bridge_hdmi_codec = bridge;
+
+			connector->hdmi_codec.parent_dev = bridge->parent;
+			connector->hdmi_codec.i2s = bridge->hdmi_codec_i2s;
+			connector->hdmi_codec.spdif = bridge->hdmi_codec_spdif;
+			connector->hdmi_codec.max_i2s_channels = bridge->max_i2s_channels;
+
+			bridge->hdmi_codec = &connector->hdmi_codec;
+		}
+
 		if (!drm_bridge_get_next_bridge(bridge))
 			connector_type = bridge->type;
 
@@ -448,7 +569,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (bridge_connector->bridge_hdmi)
+	if (bridge_connector->bridge_hdmi) {
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       bridge_connector->bridge_hdmi->vendor,
 					       bridge_connector->bridge_hdmi->product,
@@ -457,10 +578,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       connector_type, ddc,
 					       supported_formats,
 					       max_bpc);
-	else
+	} else {
 		ret = drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
 					  connector_type, ddc);
+		if (!ret && bridge_connector->bridge_hdmi_codec) {
+			ret = drmm_connector_hdmi_codec_alloc(drm, connector,
+							      &drm_bridge_connector_hdmi_codec_ops);
+		}
+	}
 	if (ret) {
 		kfree(bridge_connector);
 		return ERR_PTR(ret);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 75019d16be64..c4a95c489b00 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -41,6 +41,8 @@ struct drm_display_info;
 struct drm_minor;
 struct drm_panel;
 struct edid;
+struct hdmi_codec_daifmt;
+struct hdmi_codec_params;
 struct i2c_adapter;
 
 /**
@@ -676,6 +678,29 @@ struct drm_bridge_funcs {
 				    enum hdmi_infoframe_type type,
 				    const u8 *buffer, size_t len);
 
+	int (*hdmi_codec_audio_startup)(struct device *dev,
+					struct drm_connector *connector,
+					struct drm_bridge *bridge);
+
+	int (*hdmi_codec_prepare)(struct device *dev,
+				  struct drm_connector *connector,
+				  struct drm_bridge *bridge,
+				  struct hdmi_codec_daifmt *fmt,
+				  struct hdmi_codec_params *hparms);
+
+	void (*hdmi_codec_audio_shutdown)(struct device *dev,
+					  struct drm_connector *connector,
+					  struct drm_bridge *bridge);
+
+	int (*hdmi_codec_mute_stream)(struct device *dev,
+				      struct drm_connector *connector,
+				      struct drm_bridge *bridge,
+				      bool enable, int direction);
+
+	int (*hdmi_codec_get_dai_id)(struct drm_connector *connector,
+				     struct drm_bridge *bridge,
+				     struct device_node *endpoint);
+
 	/**
 	 * @debugfs_init:
 	 *
@@ -761,6 +786,20 @@ enum drm_bridge_ops {
 	 * drivers.
 	 */
 	DRM_BRIDGE_OP_HDMI = BIT(4),
+	/**
+	 * @DRM_BRIDGE_OP_HDMI_CODEC: The bridge provides HDMI Audio Codec
+	 * operations. Bridges that set this flag must implement the
+	 * &drm_bridge_funcs->hdmi_codec_prepare and
+	 * &drm_bridge_funcs->hdmi_codec_audio_shutdown callbacks and set the
+	 * relevant field in the &drm_bridge structure.
+	 *
+	 * This framework can be used by both HDMI and DisplayPort bridges.
+	 *
+	 * Note: currently there can be at most one bridge in a chain that sets
+	 * this bit. This is to simplify corresponding glue code in connector
+	 * drivers.
+	 */
+	DRM_BRIDGE_OP_HDMI_CODEC = BIT(5),
 };
 
 /**
@@ -771,6 +810,8 @@ struct drm_bridge {
 	struct drm_private_obj base;
 	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
+	/** @parent: device corresponding to the bridge, required only for HDMI codec */
+	struct device *parent;
 	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
@@ -854,6 +895,11 @@ struct drm_bridge {
 	 * @DRM_BRIDGE_OP_HDMI is set.
 	 */
 	unsigned int max_bpc;
+
+	int max_i2s_channels;
+	unsigned int hdmi_codec_i2s : 1;
+	unsigned int hdmi_codec_spdif : 1;
+	struct drm_connector_hdmi_codec *hdmi_codec;
 };
 
 static inline struct drm_bridge *

-- 
2.39.2


