Return-Path: <linux-kernel+bounces-246517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DD92C301
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975081C223FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD5155389;
	Tue,  9 Jul 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkR9RbrW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464941B86E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548092; cv=none; b=KxmpT46O1mUGpnLJjVRERsFVSAonw8R0aV5Y1hxMay4JUmq6UFy9uXjY1GvfOluGtj/CXmCf4zg3KG4tonrzwUhGd+M089nPWXiE+c4tnDptwITIATfnEgcxQABLpfsf2nqLMw0kqWKJwMFdavFux29gZ2bH7cYtA0ihH3ZC1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548092; c=relaxed/simple;
	bh=VkI9rA1lJsDWEKZW7lvbqWyq2552AVimk9MYPHylWiM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RV1RTPtB+9LpOV8JWQell7xEzZNL9UM73VYAGipEuD0KU/PERmlXb8RHhuCcc1o0UvVM3ZuHpRM09Rwdvg8C7VEWi2onx9UU+a69U7ajFJ0HH9YBe6VDpGlxVArJpAd7rFRiR92HHUZSEYlG2gLRrqBZdtlLCB940OJvLEpEGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkR9RbrW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c080b521so610844266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548089; x=1721152889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHcM64Au+uukg6AKO5/ac3ojku0QylaKpSDeXCzgSS0=;
        b=SkR9RbrWrjxNLjPlHHGFeN3lEMob/gqGR5o06AdvfU6W/pLHkFWDf6YOEddPCf6ByU
         YpjCjrF16I7PQmYdQRlwVBGKIa4FDkciOicZG4DKYBvfxu/lthTZQepNr8cc7M1OVy3c
         S733n4HEcvjukOEZTxV7/kRsihQ6KQuk60Bh5FqXiEbuy/BjTd9gD/Xi3QyraWE26gYA
         0IeKfiBoDExjmGGaF4Aic4SY9VwMDjZOIWoy46wfFD4/erPEj4a4SmNFoaYSFppH27qx
         7hpbKDqyINazY3yYKLHlk3Tnx1SQowABrrVqC2Wzaoq+1Wm9nfRvbf5NRDRycm4Jw+sD
         jvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548089; x=1721152889;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lHcM64Au+uukg6AKO5/ac3ojku0QylaKpSDeXCzgSS0=;
        b=RRd5BCQf3K52c0eOPzZG/AmpSPrF+asFFv28SRmhfhv6Wxisn2klQFdNdVaLMfKVwP
         vA4s56nikWSEmleO6DTKNgTLP5xoTYW2PLjV1j1y0b9AAI/hM1wCvuKPS3LO0K3/dTXO
         vw1XY70nVMR0k5AyzrPvDYRtsxYj/deQs100sRAep0SG6UF6b/qyVhnD8Cf80Gyugj0s
         cbT393/Tgsv1W8js0s9p6QkB9/etZ5nUfELESyNzmRehhlfUjdDc/3oHjPYKTXSNvXgt
         TeDBBuV86ui8zZx9I7hca9ZvmMwvV1D+JT2PTHnCGBNJxMRgqKkwfPU/jG0I7NXBtA3l
         3f/w==
X-Forwarded-Encrypted: i=1; AJvYcCW33g7rbYt6VABT9n7PzTcpYI6kO4DCnC8ShpgxhlmGe32St1Cqs1rtoxVsnp+BYvqTsK+dxVFDjWKPSynjCVBrxwFFBxZofjvoRcfA
X-Gm-Message-State: AOJu0YwHb2hdTep3ROkXUFdeuOaJuMQW3efdCmvzWdznMxZdw2y9n5d6
	4Z/JCt/wtAhJar51c6Q+QCzD9sJUWlnfcSEhkSjilZ2qRhQkxVIo
X-Google-Smtp-Source: AGHT+IGHnxUIy3UqvjM1PIAFlH6BhOsBrwOgYKayKYOWy9A1UhFCbK+GgVdUKoX1SN0bbqF8JK0xwA==
X-Received: by 2002:a17:906:3497:b0:a72:7b86:5bfc with SMTP id a640c23a62f3a-a780b89c98amr203946766b.64.1720548088145;
        Tue, 09 Jul 2024 11:01:28 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fefaasm96509666b.140.2024.07.09.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 11:01:27 -0700 (PDT)
Message-ID: <08fc2878-722e-4884-94f3-19ec4717cccd@gmail.com>
Date: Tue, 9 Jul 2024 20:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] drm/rockchip: rk3066_hdmi: change to bridge driver mode
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, hjc@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Change rk3066_hdmi.c to bridge driver mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Apply after:
[PATCH v10] drm/rockchip: rk3066_hdmi: add sound support
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 293 ++++++++++++++-----------
 1 file changed, 161 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index e3b8faf89ae2..905610a10549 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -5,12 +5,15 @@
  */

 #include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>

 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -53,7 +56,8 @@ struct rk3066_hdmi {
 	struct clk *hclk;
 	void __iomem *regs;

-	struct drm_connector connector;
+	struct drm_bridge bridge;
+	struct drm_connector *connector;
 	struct rockchip_encoder encoder;

 	struct rk3066_hdmi_i2c *i2c;
@@ -75,11 +79,6 @@ static struct rk3066_hdmi *encoder_to_rk3066_hdmi(struct drm_encoder *encoder)
 	return container_of(rkencoder, struct rk3066_hdmi, encoder);
 }

-static struct rk3066_hdmi *connector_to_rk3066_hdmi(struct drm_connector *connector)
-{
-	return container_of(connector, struct rk3066_hdmi, connector);
-}
-
 static inline u8 hdmi_readb(struct rk3066_hdmi *hdmi, u16 offset)
 {
 	return readl_relaxed(hdmi->regs + offset);
@@ -208,8 +207,7 @@ static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
 	union hdmi_infoframe frame;
 	int rc;

-	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
-						      &hdmi->connector, mode);
+	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi, hdmi->connector, mode);

 	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
 		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
@@ -347,7 +345,7 @@ static int rk3066_hdmi_audio_hw_params(struct device *dev, void *d,
 				       struct hdmi_codec_params *params)
 {
 	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
-	struct drm_display_info *display = &hdmi->connector.display_info;
+	struct drm_display_info *display = &hdmi->connector->display_info;

 	if (!display->has_audio) {
 		DRM_DEV_ERROR(hdmi->dev, "no audio support\n");
@@ -380,7 +378,7 @@ static void rk3066_hdmi_audio_shutdown(struct device *dev, void *d)
 static int rk3066_hdmi_audio_mute_stream(struct device *dev, void *d, bool mute, int direction)
 {
 	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
-	struct drm_display_info *display = &hdmi->connector.display_info;
+	struct drm_display_info *display = &hdmi->connector->display_info;

 	if (!display->has_audio) {
 		DRM_DEV_ERROR(hdmi->dev, "no audio support\n");
@@ -515,8 +513,7 @@ static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
 	return 0;
 }

-static void
-rk3066_hdmi_phy_write(struct rk3066_hdmi *hdmi, u16 offset, u8 value)
+static void rk3066_hdmi_phy_write(struct rk3066_hdmi *hdmi, u16 offset, u8 value)
 {
 	hdmi_writeb(hdmi, offset, value);
 	hdmi_modb(hdmi, HDMI_SYS_CTRL,
@@ -572,7 +569,7 @@ static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
 static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 			     struct drm_display_mode *mode)
 {
-	struct drm_display_info *display = &hdmi->connector.display_info;
+	struct drm_display_info *display = &hdmi->connector->display_info;

 	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
@@ -644,15 +641,16 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 	return 0;
 }

-static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder,
-				       struct drm_atomic_state *state)
+static void rk3066_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
+					     struct drm_bridge_state *bridge_state)
 {
-	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
+	struct drm_atomic_state *state = bridge_state->base.state;
+	struct rk3066_hdmi *hdmi = bridge->driver_private;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	int mux, val;

-	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	conn_state = drm_atomic_get_new_connector_state(state, hdmi->connector);
 	if (WARN_ON(!conn_state))
 		return;

@@ -660,7 +658,7 @@ static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder,
 	if (WARN_ON(!crtc_state))
 		return;

-	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
+	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, bridge->encoder);
 	if (mux)
 		val = (HDMI_VIDEO_SEL << 16) | HDMI_VIDEO_SEL;
 	else
@@ -674,10 +672,10 @@ static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder,
 	rk3066_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 }

-static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder,
-					struct drm_atomic_state *state)
+static void rk3066_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *bridge_state)
 {
-	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
+	struct rk3066_hdmi *hdmi = bridge->driver_private;

 	DRM_DEV_DEBUG(hdmi->dev, "hdmi encoder disable\n");

@@ -693,148 +691,146 @@ static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder,
 	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
 }

-static int
-rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_connector_state *conn_state)
+static enum drm_connector_status rk3066_hdmi_bridge_detect(struct drm_bridge *bridge)
 {
-	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
-
-	s->output_mode = ROCKCHIP_OUT_MODE_P888;
-	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+	struct rk3066_hdmi *hdmi = bridge->driver_private;

-	return 0;
+	return (hdmi_readb(hdmi, HDMI_HPG_MENS_STA) & HDMI_HPG_IN_STATUS_HIGH) ?
+		connector_status_connected : connector_status_disconnected;
 }

-static int rk3066_hdmi_encoder_late_register(struct drm_encoder *encoder)
+static enum drm_mode_status rk3066_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
+							  const struct drm_display_info *info,
+							  const struct drm_display_mode *mode)
 {
-	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
+	if ((mode->flags & DRM_MODE_FLAG_DBLCLK) ||
+	    (mode->flags & DRM_MODE_FLAG_INTERLACE))
+		return MODE_BAD;

-	return rk3066_hdmi_audio_codec_init(hdmi);
-}
+	if (mode->clock < 25000)
+		return MODE_CLOCK_LOW;

-static void rk3066_hdmi_encoder_early_unregister(struct drm_encoder *encoder)
-{
-	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);
+	if (mode->clock > 148500)
+		return MODE_CLOCK_HIGH;

-	platform_device_unregister(hdmi->audio_pdev);
+	return MODE_OK;
 }

-static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
-	.destroy          = drm_encoder_cleanup,
-	.late_register    = rk3066_hdmi_encoder_late_register,
-	.early_unregister = rk3066_hdmi_encoder_early_unregister,
-};
-
-static const
-struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
-	.atomic_check   = rk3066_hdmi_encoder_atomic_check,
-	.atomic_enable  = rk3066_hdmi_encoder_enable,
-	.atomic_disable = rk3066_hdmi_encoder_disable,
-};
-
-static enum drm_connector_status
-rk3066_hdmi_connector_detect(struct drm_connector *connector, bool force)
+static int rk3066_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
+					   struct drm_bridge_state *bridge_state,
+					   struct drm_crtc_state *crtc_state,
+					   struct drm_connector_state *conn_state)
 {
-	struct rk3066_hdmi *hdmi = connector_to_rk3066_hdmi(connector);
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct rk3066_hdmi *hdmi = bridge->driver_private;
+	struct drm_display_info *display = &hdmi->connector->display_info;

-	return (hdmi_readb(hdmi, HDMI_HPG_MENS_STA) & HDMI_HPG_IN_STATUS_HIGH) ?
-		connector_status_connected : connector_status_disconnected;
+	s->output_mode = ROCKCHIP_OUT_MODE_P888;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return  rk3066_hdmi_bridge_mode_valid(bridge, display,
+				&crtc_state->adjusted_mode) == MODE_OK ? 0 : -EINVAL;
 }

-static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
+static const struct drm_edid *rk3066_hdmi_bridge_edid_read(struct drm_bridge *bridge,
+							   struct drm_connector *connector)
 {
-	struct rk3066_hdmi *hdmi = connector_to_rk3066_hdmi(connector);
+	struct rk3066_hdmi *hdmi = bridge->driver_private;
 	const struct drm_edid *drm_edid;
-	int ret = 0;

 	if (!hdmi->ddc)
-		return 0;
+		return NULL;

 	drm_edid = drm_edid_read_ddc(connector, hdmi->ddc);
-	drm_edid_connector_update(connector, drm_edid);
-	ret = drm_edid_connector_add_modes(connector);
-	drm_edid_free(drm_edid);
+	if (!drm_edid) {
+		dev_dbg(hdmi->dev, "failed to get edid\n");
+		return NULL;
+	}

-	return ret;
+	return drm_edid;
 }

-static enum drm_mode_status
-rk3066_hdmi_connector_mode_valid(struct drm_connector *connector,
-				 struct drm_display_mode *mode)
+#define MAX_INPUT_SEL_FORMATS	1
+
+static u32 *rk3066_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+							 struct drm_bridge_state *bridge_state,
+							 struct drm_crtc_state *crtc_state,
+							 struct drm_connector_state *conn_state,
+							 u32 output_fmt,
+							 unsigned int *num_input_fmts)
 {
-	u32 vic = drm_match_cea_mode(mode);
+	u32 *input_fmts;

-	if (vic > 1)
-		return MODE_OK;
-	else
-		return MODE_BAD;
-}
+	*num_input_fmts = 0;

-static struct drm_encoder *
-rk3066_hdmi_connector_best_encoder(struct drm_connector *connector)
-{
-	struct rk3066_hdmi *hdmi = connector_to_rk3066_hdmi(connector);
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	*num_input_fmts = 1;

-	return &hdmi->encoder.encoder;
+	return input_fmts;
 }

-static int
-rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
-					 uint32_t maxX, uint32_t maxY)
+#define MAX_OUTPUT_SEL_FORMATS	1
+
+static u32 *rk3066_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
+							  struct drm_bridge_state *bridge_state,
+							  struct drm_crtc_state *crtc_state,
+							  struct drm_connector_state *conn_state,
+							  unsigned int *num_output_fmts)
 {
-	if (maxX > 1920)
-		maxX = 1920;
-	if (maxY > 1080)
-		maxY = 1080;
+	u32 *output_fmts;

-	return drm_helper_probe_single_connector_modes(connector, maxX, maxY);
-}
+	*num_output_fmts = 0;

-static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_unregister(connector);
-	drm_connector_cleanup(connector);
-}
+	output_fmts = kcalloc(MAX_OUTPUT_SEL_FORMATS, sizeof(*output_fmts),
+			      GFP_KERNEL);
+	if (!output_fmts)
+		return NULL;

-static const struct drm_connector_funcs rk3066_hdmi_connector_funcs = {
-	.fill_modes             = rk3066_hdmi_probe_single_connector_modes,
-	.detect                 = rk3066_hdmi_connector_detect,
-	.destroy                = rk3066_hdmi_connector_destroy,
-	.reset                  = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
-};
+	output_fmts[0] = MEDIA_BUS_FMT_FIXED;
+	*num_output_fmts = 1;
+
+	return output_fmts;
+}

-static const
-struct drm_connector_helper_funcs rk3066_hdmi_connector_helper_funcs = {
-	.get_modes    = rk3066_hdmi_connector_get_modes,
-	.mode_valid   = rk3066_hdmi_connector_mode_valid,
-	.best_encoder = rk3066_hdmi_connector_best_encoder,
+static const struct drm_bridge_funcs rk3066_hdmi_bridge_funcs = {
+	.atomic_duplicate_state     = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state       = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset               = drm_atomic_helper_bridge_reset,
+	.atomic_check               = rk3066_hdmi_bridge_atomic_check,
+	.atomic_enable              = rk3066_hdmi_bridge_atomic_enable,
+	.atomic_disable             = rk3066_hdmi_bridge_atomic_disable,
+	.atomic_get_input_bus_fmts  = rk3066_hdmi_bridge_atomic_get_input_bus_fmts,
+	.atomic_get_output_bus_fmts = rk3066_hdmi_bridge_atomic_get_output_bus_fmts,
+	.mode_valid                 = rk3066_hdmi_bridge_mode_valid,
+	.detect                     = rk3066_hdmi_bridge_detect,
+	.edid_read                  = rk3066_hdmi_bridge_edid_read,
 };

-static int rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
+static int rk3066_hdmi_encoder_late_register(struct drm_encoder *encoder)
 {
-	struct drm_encoder *encoder = &hdmi->encoder.encoder;
-
-	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
-	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
-
-	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);

-	drm_connector_helper_add(&hdmi->connector,
-				 &rk3066_hdmi_connector_helper_funcs);
-	drm_connector_init_with_ddc(drm, &hdmi->connector,
-				    &rk3066_hdmi_connector_funcs,
-				    DRM_MODE_CONNECTOR_HDMIA,
-				    hdmi->ddc);
+	return rk3066_hdmi_audio_codec_init(hdmi);
+}

-	drm_connector_attach_encoder(&hdmi->connector, encoder);
+static void rk3066_hdmi_encoder_early_unregister(struct drm_encoder *encoder)
+{
+	struct rk3066_hdmi *hdmi = encoder_to_rk3066_hdmi(encoder);

-	return 0;
+	platform_device_unregister(hdmi->audio_pdev);
 }

+static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
+	.destroy          = drm_encoder_cleanup,
+	.late_register    = rk3066_hdmi_encoder_late_register,
+	.early_unregister = rk3066_hdmi_encoder_early_unregister,
+};
+
 static irqreturn_t rk3066_hdmi_hardirq(int irq, void *dev_id)
 {
 	struct rk3066_hdmi *hdmi = dev_id;
@@ -863,7 +859,8 @@ static irqreturn_t rk3066_hdmi_irq(int irq, void *dev_id)
 {
 	struct rk3066_hdmi *hdmi = dev_id;

-	drm_helper_hpd_irq_event(hdmi->connector.dev);
+	if (hdmi->bridge.dev)
+		drm_helper_hpd_irq_event(hdmi->bridge.dev);

 	return IRQ_HANDLED;
 }
@@ -1074,9 +1071,8 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 	hdmi_writeb(hdmi, HDMI_INTR_MASK4, 0);
 	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);

-	ret = rk3066_hdmi_register(drm, hdmi);
-	if (ret)
-		goto err_disable_i2c;
+	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);

 	dev_set_drvdata(dev, hdmi);

@@ -1085,15 +1081,47 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 					dev_name(dev), hdmi);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to request hdmi irq: %d\n", ret);
-		goto err_cleanup_hdmi;
+		goto err_free_encoder;
+	}
+
+	hdmi->bridge.driver_private = hdmi;
+	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
+	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
+			 | DRM_BRIDGE_OP_HPD;
+	hdmi->bridge.interlace_allowed = false;
+	hdmi->bridge.ddc = hdmi->ddc;
+	hdmi->bridge.of_node = pdev->dev.of_node;
+	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+
+	drm_bridge_add(&hdmi->bridge);
+
+	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to attach bridge: %d\n", ret);
+		goto err_remove_bridge;
+	}
+
+	hdmi->connector = drm_bridge_connector_init(drm, encoder);
+	if (IS_ERR(hdmi->connector)) {
+		DRM_DEV_ERROR(dev, "failed to initialize bridge connector: %pe\n", hdmi->connector);
+		ret = PTR_ERR(hdmi->connector);
+		goto err_remove_bridge;
+	}
+
+	ret = drm_connector_attach_encoder(hdmi->connector, encoder);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "failed to attach connector: %d\n", ret);
+		goto err_free_connector;
 	}

 	return 0;

-err_cleanup_hdmi:
-	hdmi->connector.funcs->destroy(&hdmi->connector);
-	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
-err_disable_i2c:
+err_free_connector:
+	drm_connector_cleanup(hdmi->connector);
+err_remove_bridge:
+	drm_bridge_remove(&hdmi->bridge);
+err_free_encoder:
+	drm_encoder_cleanup(encoder);
 	i2c_put_adapter(hdmi->ddc);
 err_disable_hclk:
 	clk_disable_unprepare(hdmi->hclk);
@@ -1106,8 +1134,9 @@ static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
 {
 	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);

-	hdmi->connector.funcs->destroy(&hdmi->connector);
-	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
+	drm_connector_cleanup(hdmi->connector);
+	drm_bridge_remove(&hdmi->bridge);
+	drm_encoder_cleanup(&hdmi->encoder.encoder);

 	i2c_put_adapter(hdmi->ddc);
 	clk_disable_unprepare(hdmi->hclk);
--
2.39.2


