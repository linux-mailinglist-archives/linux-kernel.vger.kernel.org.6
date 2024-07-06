Return-Path: <linux-kernel+bounces-243422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C8929605
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D80D1C20AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323F6D1C1;
	Sat,  6 Jul 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB8NJ53r"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF23741;
	Sat,  6 Jul 2024 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720310365; cv=none; b=myZ4HUoJOj/Vlc3Dq4HxKoesPXBgiPNexTZR8ZogGpixelQQ/asw3tQy8ezQcMYoXJhmGbgTXvTInlE18DR6t6W7RcuP/J/Dh+flUygYrIgcYg2ChGiQ4ZTHEtItfqWhHVJHQboz+hi3rsSI8083sjali3AHBTseIOQ3HqozVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720310365; c=relaxed/simple;
	bh=gGYaPF3RA2tlLtNpii1B2hI/IS5aTuzT3I2PeKd5DTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=sih5y+svDRavvmuZztUlEL8L08qwxqhSIp3zkSpbqEq4bPudVbBAdYIbX3e9uSox27mlfU3HKQbw3K1Qij7KRdNZdNCl3K0Or/BpVGpfPZd+7LqKjIx/RM9TyvTBmJSAtiiruJ5QQboE1XGl39i7D/hlc7GQKNyOQe6Qm4NWXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB8NJ53r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so240668866b.0;
        Sat, 06 Jul 2024 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720310361; x=1720915161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNZ9iBZQ210M7WVot+ZdRFe+tyFsVSy9bBritfukgnI=;
        b=TB8NJ53rxevgPoYIuKD/SZHHAxoSQDKFUiiXLWprCS/j+075N0xdOD30+RVYV9YZba
         B4BOl7IGG/kxaBVDdu+dVqH6YwwC9DnTFXlV3GR7NauSAdJGRrZWYdfvpzh21d9aLPJI
         ymgHwGZbC48AZjE2R3DKYCGkaXT8W+6eEHk5VTVyyoyLhbdgh70wvNmhBHa8d1cfrMnJ
         QCaPNpILLw5ONbbidd+jiRbOo3GHA0ku1xV/+KUVFXPr49B+GDgKDj+VggwVhmR6+Wpq
         ESQ69/35V0j4anRzlhQbihhM0G+WvH2VPo6Kul1IB2yNHOurK4DSZOhCkeOwFVRwp4Vl
         wKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720310361; x=1720915161;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNZ9iBZQ210M7WVot+ZdRFe+tyFsVSy9bBritfukgnI=;
        b=M4INtGDjQ1ZNPNjFrHwJ5I+lbFSscrlxRW9CP7lb2JIdFPseMOi3GwjtHstYAp0APj
         EMhHvoMd9Q97PzsAZGI/LbYUSctgaYPVuQg/WVogdEouS2H0yYwok35moGWZD7uS6Q7m
         T/0zg37FXua2UJaowVtC7Zl1LQNCofSMEHp092JZk53kw5S7k2jsxwuG8LOj8b4CglTh
         AgYXE6s1uq5D1y0sXHhuOSIEf6hEHu9+sJQg6BeblBRo+9+o0YVWApXNE1jRLq7kUxlA
         o4E6w4cIrPdYWGxOvP1xWpQ0ttahRdoBG2Ds6Uv/dprzSBCVWo7nv1HAVlN3PoD/hLiT
         luGg==
X-Forwarded-Encrypted: i=1; AJvYcCVwdztxZKXVUBz4AUN0o5LjZKWnKN8MG9/Lrdg/vK3g0i+zCOVg51TRSe8zJ9rJ5Xe2iIQOUeoT1FSGU/DPU11vdy1eOIImxNkgyEbkdttr9foGD1pAKdeR8alK5p3pg3e4+86/mlyC/3M=
X-Gm-Message-State: AOJu0YwSCAHGQulLORoTJdOvY4smykvUubII4+g8gILcP/zp0a7y7WF6
	8Ax6IQwXkwQfE/tqPRBOh3nAJWR/3Aou7Bg8A2WyCXPfci6eKp4z
X-Google-Smtp-Source: AGHT+IHAwbWprN8cNIggazy2qsmEc4v2QwwxuON1fQEUFT/EiNzeA4kIq3zxUDmz+y6RVfOqIX9wAQ==
X-Received: by 2002:a17:906:e218:b0:a72:9ebe:29da with SMTP id a640c23a62f3a-a77bdae479emr505599066b.35.1720310361167;
        Sat, 06 Jul 2024 16:59:21 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77db963ee4sm138118066b.154.2024.07.06.16.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 16:59:20 -0700 (PDT)
Message-ID: <5dae5aa1-99a4-4509-87b8-b8fd1a599065@gmail.com>
Date: Sun, 7 Jul 2024 01:59:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] drm/rockchip: inno_hdmi: add audio support
To: heiko@sntech.de
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, lgirdwood@gmail.com, broonie@kernel.org,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add sound support to the INNO HDMI driver.
The HDMI TX audio source is connected to I2S.
Using the common hdmi-codec driver to support hdmi audio function.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

NOT TESTED WITH HARDWARE

Changed V2:
  rebased
  hook to encoder->funcs->late_register
  return -EPROBE_DEFER as early as possible
  rename and update inno_hdmi_disable_frame() function
  avi and aai frames can not be disabled (See TRM)
  restyle
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 295 ++++++++++++++++++++++++---
 drivers/gpu/drm/rockchip/inno_hdmi.h |   2 +
 2 files changed, 263 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 3df2cfcf9998..9c28080a0e27 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -22,12 +22,20 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>

+#include <sound/hdmi-codec.h>
+
 #include "rockchip_drm_drv.h"

 #include "inno_hdmi.h"

 #define INNO_HDMI_MIN_TMDS_CLOCK  25000000U

+struct inno_hdmi_audio_info {
+	int channels;
+	int sample_rate;
+	int sample_width;
+};
+
 struct inno_hdmi_phy_config {
 	unsigned long pixelclock;
 	u8 pre_emphasis;
@@ -62,6 +70,10 @@ struct inno_hdmi {
 	struct inno_hdmi_i2c *i2c;
 	struct i2c_adapter *ddc;

+	struct platform_device *audio_pdev;
+	struct inno_hdmi_audio_info audio;
+	bool audio_enabled;
+
 	const struct inno_hdmi_variant *variant;
 };

@@ -257,34 +269,35 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	inno_hdmi_standby(hdmi);
 }

-static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
-				    enum hdmi_infoframe_type type)
+static void inno_hdmi_set_frame_index(struct inno_hdmi *hdmi,
+				      enum hdmi_infoframe_type type)
 {
 	struct drm_connector *connector = &hdmi->connector;
-
-	if (type != HDMI_INFOFRAME_TYPE_AVI) {
+	u32 frame_index;
+
+	switch (type) {
+	case HDMI_INFOFRAME_TYPE_AVI:
+		frame_index = INFOFRAME_AVI;
+		break;
+	case HDMI_INFOFRAME_TYPE_AUDIO:
+		frame_index = INFOFRAME_AAI;
+		break;
+	default:
 		drm_err(connector->dev,
 			"Unsupported infoframe type: %u\n", type);
 		return;
 	}

-	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_AVI);
+	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, frame_index);
 }

 static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
 				  union hdmi_infoframe *frame, enum hdmi_infoframe_type type)
 {
-	struct drm_connector *connector = &hdmi->connector;
 	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
 	ssize_t rc, i;

-	if (type != HDMI_INFOFRAME_TYPE_AVI) {
-		drm_err(connector->dev,
-			"Unsupported infoframe type: %u\n", type);
-		return 0;
-	}
-
-	inno_hdmi_disable_frame(hdmi, type);
+	inno_hdmi_set_frame_index(hdmi, type);

 	rc = hdmi_infoframe_pack(frame, packed_frame,
 				 sizeof(packed_frame));
@@ -312,7 +325,6 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 						      &hdmi->connector,
 						      mode);
 	if (rc) {
-		inno_hdmi_disable_frame(hdmi, HDMI_INFOFRAME_TYPE_AVI);
 		return rc;
 	}

@@ -338,6 +350,197 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_AVI);
 }

+static int inno_hdmi_config_aai(struct inno_hdmi *hdmi)
+{
+	union hdmi_infoframe frame;
+	int rc;
+
+	rc = hdmi_audio_infoframe_init(&frame.audio);
+	if (rc < 0)
+		return rc;
+
+	frame.audio.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
+	frame.audio.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
+	frame.audio.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
+	frame.audio.channels = hdmi->audio.channels;
+
+	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_AUDIO);
+}
+
+static int inno_hdmi_audio_config(struct inno_hdmi *hdmi)
+{
+	struct inno_hdmi_audio_info *audio = &hdmi->audio;
+	int rate, N, channel;
+
+	if (audio->channels < 3)
+		channel = I2S_CHANNEL_1_2;
+	else if (audio->channels < 5)
+		channel = I2S_CHANNEL_3_4;
+	else if (audio->channels < 7)
+		channel = I2S_CHANNEL_5_6;
+	else
+		channel = I2S_CHANNEL_7_8;
+
+	switch (audio->sample_rate) {
+	case 32000:
+		rate = AUDIO_32K;
+		N = N_32K;
+		break;
+	case 44100:
+		rate = AUDIO_441K;
+		N = N_441K;
+		break;
+	case 48000:
+		rate = AUDIO_48K;
+		N = N_48K;
+		break;
+	case 88200:
+		rate = AUDIO_882K;
+		N = N_882K;
+		break;
+	case 96000:
+		rate = AUDIO_96K;
+		N = N_96K;
+		break;
+	case 176400:
+		rate = AUDIO_1764K;
+		N = N_1764K;
+		break;
+	case 192000:
+		rate = AUDIO_192K;
+		N = N_192K;
+		break;
+	default:
+		dev_err(hdmi->dev, "[%s] not support such sample rate %d\n",
+			__func__, audio->sample_rate);
+		return -ENOENT;
+	}
+
+	/* Set audio source I2S. */
+	hdmi_writeb(hdmi, HDMI_AUDIO_CTRL1, 0x01);
+	hdmi_writeb(hdmi, AUDIO_SAMPLE_RATE, rate);
+	hdmi_writeb(hdmi, AUDIO_I2S_MODE, v_I2S_MODE(I2S_STANDARD) |
+		    v_I2S_CHANNEL(channel));
+
+	hdmi_writeb(hdmi, AUDIO_I2S_MAP, 0x00);
+	hdmi_writeb(hdmi, AUDIO_I2S_SWAPS_SPDIF, 0);
+
+	/* Set N value. */
+	hdmi_writeb(hdmi, AUDIO_N_H, (N >> 16) & 0x0F);
+	hdmi_writeb(hdmi, AUDIO_N_M, (N >> 8) & 0xFF);
+	hdmi_writeb(hdmi, AUDIO_N_L, N & 0xFF);
+
+	/*Set HDMI NLPCM mode to support HDMI bit stream. */
+	hdmi_writeb(hdmi, HDMI_AUDIO_CHANNEL_STATUS, v_AUDIO_STATUS_NLPCM(0));
+
+	return inno_hdmi_config_aai(hdmi);
+}
+
+static int inno_hdmi_audio_hw_params(struct device *dev, void *d,
+				     struct hdmi_codec_daifmt *daifmt,
+				     struct hdmi_codec_params *params)
+{
+	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
+	if (!display->has_audio) {
+		DRM_DEV_ERROR(hdmi->dev, "no audio support\n");
+		return -ENODEV;
+	}
+
+	if (!hdmi->encoder.encoder.crtc)
+		return -ENODEV;
+
+	switch (daifmt->fmt) {
+	case HDMI_I2S:
+		break;
+	default:
+		DRM_DEV_ERROR(dev, "invalid format %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	hdmi->audio.channels = params->channels;
+	hdmi->audio.sample_rate = params->sample_rate;
+	hdmi->audio.sample_width = params->sample_width;
+
+	return inno_hdmi_audio_config(hdmi);
+}
+
+static void inno_hdmi_audio_shutdown(struct device *dev, void *d)
+{
+	/* Do nothing. */
+}
+
+static int inno_hdmi_audio_mute_stream(struct device *dev, void *d, bool mute, int direction)
+{
+	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
+	if (!display->has_audio) {
+		DRM_DEV_ERROR(hdmi->dev, "no audio support\n");
+		return -ENODEV;
+	}
+
+	hdmi->audio_enabled = !mute;
+
+	if (mute)
+		hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_AUDIO_PD,
+			  v_AUDIO_MUTE(1) | v_AUDIO_PD(1));
+	else
+		hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_AUDIO_PD,
+			  v_AUDIO_MUTE(0) | v_AUDIO_PD(0));
+
+	return 0;
+}
+
+static int inno_hdmi_audio_get_eld(struct device *dev, void *d, uint8_t *buf, size_t len)
+{
+	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_mode_config *config = &hdmi->encoder.encoder.dev->mode_config;
+	struct drm_connector *connector;
+	int ret = -ENODEV;
+
+	mutex_lock(&config->mutex);
+	list_for_each_entry(connector, &config->connector_list, head) {
+		if (&hdmi->encoder.encoder == connector->encoder) {
+			memcpy(buf, connector->eld,
+			       min(sizeof(connector->eld), len));
+			ret = 0;
+		}
+	}
+	mutex_unlock(&config->mutex);
+
+	return ret;
+}
+
+static const struct hdmi_codec_ops audio_codec_ops = {
+	.hw_params      = inno_hdmi_audio_hw_params,
+	.audio_shutdown = inno_hdmi_audio_shutdown,
+	.mute_stream    = inno_hdmi_audio_mute_stream,
+	.get_eld        = inno_hdmi_audio_get_eld,
+};
+
+static int inno_hdmi_audio_codec_init(struct inno_hdmi *hdmi)
+{
+	struct hdmi_codec_pdata codec_data = {
+		.i2s = 1,
+		.ops = &audio_codec_ops,
+		.max_i2s_channels = 8,
+	};
+
+	hdmi->audio.channels = 2;
+	hdmi->audio.sample_rate = 48000;
+	hdmi->audio.sample_width = 16;
+	hdmi->audio_enabled = false;
+	hdmi->audio_pdev = platform_device_register_data(hdmi->dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_NONE,
+							 &codec_data,
+							 sizeof(codec_data));
+
+	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
+}
+
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 {
 	struct drm_connector *connector = &hdmi->connector;
@@ -479,8 +682,10 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,

 	inno_hdmi_config_video_csc(hdmi);

-	if (display->is_hdmi)
+	if (display->is_hdmi) {
 		inno_hdmi_config_video_avi(hdmi, mode);
+		inno_hdmi_audio_config(hdmi);
+	}

 	/*
 	 * When IP controller have configured to an accurate video
@@ -588,6 +793,26 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 				&crtc_state->adjusted_mode) == MODE_OK ? 0 : -EINVAL;
 }

+static int inno_hdmi_encoder_late_register(struct drm_encoder *encoder)
+{
+	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+
+	return inno_hdmi_audio_codec_init(hdmi);
+}
+
+static void inno_hdmi_encoder_early_unregister(struct drm_encoder *encoder)
+{
+	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+
+	platform_device_unregister(hdmi->audio_pdev);
+}
+
+static const struct drm_encoder_funcs inno_hdmi_encoder_funcs = {
+	.destroy          = drm_encoder_cleanup,
+	.late_register    = inno_hdmi_encoder_late_register,
+	.early_unregister = inno_hdmi_encoder_early_unregister,
+};
+
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check	= inno_hdmi_encoder_atomic_check,
 	.atomic_enable	= inno_hdmi_encoder_enable,
@@ -687,37 +912,26 @@ inno_hdmi_connector_duplicate_state(struct drm_connector *connector)
 }

 static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = inno_hdmi_connector_detect,
-	.destroy = inno_hdmi_connector_destroy,
-	.reset = inno_hdmi_connector_reset,
+	.fill_modes             = drm_helper_probe_single_connector_modes,
+	.detect                 = inno_hdmi_connector_detect,
+	.destroy                = inno_hdmi_connector_destroy,
+	.reset                  = inno_hdmi_connector_reset,
 	.atomic_duplicate_state = inno_hdmi_connector_duplicate_state,
-	.atomic_destroy_state = inno_hdmi_connector_destroy_state,
+	.atomic_destroy_state   = inno_hdmi_connector_destroy_state,
 };

 static struct drm_connector_helper_funcs inno_hdmi_connector_helper_funcs = {
-	.get_modes = inno_hdmi_connector_get_modes,
+	.get_modes  = inno_hdmi_connector_get_modes,
 	.mode_valid = inno_hdmi_connector_mode_valid,
 };

 static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
 {
 	struct drm_encoder *encoder = &hdmi->encoder.encoder;
-	struct device *dev = hdmi->dev;
-
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
-
-	/*
-	 * If we failed to find the CRTC(s) which this encoder is
-	 * supposed to be connected to, it's because the CRTC has
-	 * not been registered yet.  Defer probing, and hope that
-	 * the required CRTC is added later.
-	 */
-	if (encoder->possible_crtcs == 0)
-		return -EPROBE_DEFER;

 	drm_encoder_helper_add(encoder, &inno_hdmi_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, encoder, &inno_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);

 	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;

@@ -911,6 +1125,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
+	struct drm_encoder *encoder;
 	struct inno_hdmi *hdmi;
 	const struct inno_hdmi_variant *variant;
 	int irq;
@@ -920,6 +1135,18 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	if (!hdmi)
 		return -ENOMEM;

+	encoder = &hdmi->encoder.encoder;
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
 	hdmi->dev = dev;

 	variant = of_device_get_match_data(hdmi->dev);
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.h b/drivers/gpu/drm/rockchip/inno_hdmi.h
index a7edf3559e60..0d108d3578fa 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.h
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.h
@@ -91,10 +91,12 @@ enum {
 #define HDMI_AV_MUTE			0x05
 #define m_AVMUTE_CLEAR			(1 << 7)
 #define m_AVMUTE_ENABLE			(1 << 6)
+#define m_AUDIO_PD			(1 << 2)
 #define m_AUDIO_MUTE			(1 << 1)
 #define m_VIDEO_BLACK			(1 << 0)
 #define v_AVMUTE_CLEAR(n)		(n << 7)
 #define v_AVMUTE_ENABLE(n)		(n << 6)
+#define v_AUDIO_PD(n)			(n << 2)
 #define v_AUDIO_MUTE(n)			(n << 1)
 #define v_VIDEO_MUTE(n)			(n << 0)

--
2.39.2


