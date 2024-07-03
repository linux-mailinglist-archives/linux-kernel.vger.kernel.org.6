Return-Path: <linux-kernel+bounces-239626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4492633F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224C61C20FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792517A5BB;
	Wed,  3 Jul 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGATveDQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD21DA31C;
	Wed,  3 Jul 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016433; cv=none; b=QeIC+TYTg5dzDLl50ExvOxZ8RLvFx/ec7W/cBXXOERvrEjV5Paatg14T64cEhq2hvBTbOpEmuBRBgtrWeEtDZW9WlQaaL2vNsZX/Gua/lR3DA8+ETslWvFPkZT+z8+/fajpIhvnAMG4MDuSQs+dW2c4i/uVvQNlRE/tkcZcgenQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016433; c=relaxed/simple;
	bh=K9jm7xM/YkfIxjg6xtysmikLTC+pdy71S7xCBt7aLyo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=en8GVoJrUWJPZeZpG4Fn4/HPBzON2c8/fraiJXGTQof1zyVNiefx/BqQUh7f3TRQ9otjEeTKJu5Q7Pb1gPJGPNBOK4pLlqmdmbRfYBJn+giaCGN4uO5pLPGThPgok4xchaXrMX33akdhOy7ZG5kb5e16K4Yp3/Fncktv8i4mIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGATveDQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so554179666b.3;
        Wed, 03 Jul 2024 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720016429; x=1720621229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny8W4aA5Tso2C+7h1F8CjQuXEYBmcLsryPxVrQdHovg=;
        b=GGATveDQTIu/0gXK8zgTKnmMYTUsL8J7PMPzqSb9c+ge4fb9I9nN38SROgztI/n9Be
         YqoOacRkqapFcboqCLtbjpNz9O120MfdKMtC76V9xn2CY6jV1Ku2V+L6/UPlF4ZgR3Fo
         J5b3O/rXROy/6xMiHnMEzzpax36tim89kgGL8RkRzSfx+FOXZc0wiT4BXfcnFqwouOtX
         1DKH61XNR99h+x5YexA6fpMtnzg3+Ug1PBm9TrFH9K3kaFtlCEVN965SNv96UJjS9j0c
         A5tHIsmzpSLfLoE3ggdReGi7lOhRkczKsn+pHAhlh9Y8JRTSTXlYWPu1PxWwhIujR+ZJ
         bEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016429; x=1720621229;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ny8W4aA5Tso2C+7h1F8CjQuXEYBmcLsryPxVrQdHovg=;
        b=q+yE4j39pXkvOe1az/ZLWpjiGjmt4dHWiWMsjpflbeXTEsGwibFwqRtU/93fmq/Jz1
         Z0OUWiE///bKFIhxpSxNZsXmwlRskyTWgbZaDbY79y8/uko5CLQXXBJjKrdQGg7S+2G4
         8/uymx+klKZxmIMbyjScUhOrJTrMy8eAotsUfrXLexMGtIgBktu9gzRBIyFHlvP0x2YF
         9cpR8dNIGp4/DQmR1d8nGX5l+HEWi/jO/SOgPdRQrT7sF2ywBuVjfTS/h181+pBLTjuI
         UURhALvUlc3Zz4jb9pGK3YRL0hhJB9Khi1cdx96NkyADA1QVJuJxaOnvYGCnrLTGZlN8
         xXvw==
X-Forwarded-Encrypted: i=1; AJvYcCXyV468MzIt95SgR5TsaDrK4GAJxwItc2k4yvDjPxHupWW8mhU04itbs7ihNPs3QSaRYDMqVURFdFmpVlzu5rly1OaJOqbubdei6dMJmQ/0Kz9+214v0A2BCkwGJG9D3ZhVPiEIIJo3jJw=
X-Gm-Message-State: AOJu0YwYjTeViobzA6hRsEdg7JJa3rWd1V9l/Q3Zbpjbsf3NkZcPisH4
	GkhN70aTp9iVqDUuYEVC1jRy5sRyA2J9Z8ZUOZ6LEul8GjSNwniS
X-Google-Smtp-Source: AGHT+IExGZLNW4rjQfNX/hHpeqp9/yy7ktTYAuJ/veJLQblXOlGkeo7YGjFT1TIEyE4vJm3o8M0S+Q==
X-Received: by 2002:a17:906:6b91:b0:a72:690d:a177 with SMTP id a640c23a62f3a-a7514438b07mr678462066b.17.1720016428985;
        Wed, 03 Jul 2024 07:20:28 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf5a585sm513050766b.52.2024.07.03.07.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:20:28 -0700 (PDT)
Message-ID: <feaad47f-c85b-4fd9-a63f-cdda1d621b70@gmail.com>
Date: Wed, 3 Jul 2024 16:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v9] drm/rockchip: rk3066_hdmi: add sound support
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

Add sound support to the RK3066 HDMI driver.
The HDMI TX audio source is connected to I2S_8CH.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V9:
  Use late_register and early_unregister hooks to
  (un)register the "hdmi-audio-codec" driver.
  restyle

Changed V8:
  return -EPROBE_DEFER as early as possible
  move rk3066_hdmi_audio_codec_init() function after rk3066_hdmi_register()
  restyle

Changed V7:
  rebase
---
 drivers/gpu/drm/rockchip/Kconfig       |   2 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 320 +++++++++++++++++++++++--
 2 files changed, 300 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 1bf3e2829cd0..a32ee558408c 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -102,6 +102,8 @@ config ROCKCHIP_RGB
 config ROCKCHIP_RK3066_HDMI
 	bool "Rockchip specific extensions for RK3066 HDMI"
 	depends on DRM_ROCKCHIP
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	select SND_SOC_ROCKCHIP_I2S if SND_SOC
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the RK3066 HDMI driver. If you want to enable
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 784de990da1b..6081e1e062f2 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -15,12 +15,20 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>

+#include <sound/hdmi-codec.h>
+
 #include "rk3066_hdmi.h"

 #include "rockchip_drm_drv.h"

 #define DEFAULT_PLLA_RATE 30000000

+struct rk3066_hdmi_audio_info {
+	int channels;
+	int sample_rate;
+	int sample_width;
+};
+
 struct hdmi_data_info {
 	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
 	unsigned int enc_out_format;
@@ -40,7 +48,6 @@ struct rk3066_hdmi_i2c {

 struct rk3066_hdmi {
 	struct device *dev;
-	struct drm_device *drm_dev;
 	struct regmap *grf_regmap;
 	int irq;
 	struct clk *hclk;
@@ -54,9 +61,16 @@ struct rk3066_hdmi {

 	unsigned int tmdsclk;

+	struct platform_device *audio_pdev;
+	struct rk3066_hdmi_audio_info audio;
+	bool audio_enable;
+
 	struct hdmi_data_info hdmi_data;
 };

+static int rk3066_hdmi_audio_config(struct rk3066_hdmi *hdmi);
+static int rk3066_hdmi_audio_codec_init(struct rk3066_hdmi *hdmi);
+
 static struct rk3066_hdmi *encoder_to_rk3066_hdmi(struct drm_encoder *encoder)
 {
 	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
@@ -214,6 +228,22 @@ static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
 					HDMI_INFOFRAME_AVI, 0, 0, 0);
 }

+static int rk3066_hdmi_config_aai(struct rk3066_hdmi *hdmi)
+{
+	union hdmi_infoframe frame;
+	int rc;
+
+	rc = hdmi_audio_infoframe_init(&frame.audio);
+
+	frame.audio.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
+	frame.audio.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
+	frame.audio.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
+	frame.audio.channels = hdmi->audio.channels;
+
+	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
+					HDMI_INFOFRAME_AAI, 0, 0, 0);
+}
+
 static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
 					   struct drm_display_mode *mode)
 {
@@ -364,6 +394,7 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK,
 			  HDMI_VIDEO_MODE_HDMI);
 		rk3066_hdmi_config_avi(hdmi, mode);
+		rk3066_hdmi_audio_config(hdmi);
 	} else {
 		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK, 0);
 	}
@@ -380,9 +411,20 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 	 */
 	rk3066_hdmi_i2c_init(hdmi);

-	/* Unmute video output. */
+	/* Unmute video and audio output. */
 	hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
 		  HDMI_VIDEO_AUDIO_DISABLE_MASK, HDMI_AUDIO_DISABLE);
+	if (hdmi->audio_enable) {
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2, HDMI_AUDIO_DISABLE, 0);
+		/* Reset audio capture logic. */
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK,
+			  HDMI_AUDIO_CP_LOGIC_RESET);
+		usleep_range(900, 1000);
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK, 0);
+	}
+
 	return 0;
 }

@@ -431,6 +473,7 @@ static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder,
 			  HDMI_AUDIO_CP_LOGIC_RESET);
 		usleep_range(500, 510);
 	}
+
 	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
 }

@@ -518,39 +561,260 @@ static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }

+static int rk3066_hdmi_connector_late_register(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = connector_to_rk3066_hdmi(connector);
+
+	return rk3066_hdmi_audio_codec_init(hdmi);
+}
+
+static void rk3066_hdmi_connector_early_unregister(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = connector_to_rk3066_hdmi(connector);
+
+	platform_device_unregister(hdmi->audio_pdev);
+}
+
 static const struct drm_connector_funcs rk3066_hdmi_connector_funcs = {
-	.fill_modes = rk3066_hdmi_probe_single_connector_modes,
-	.detect = rk3066_hdmi_connector_detect,
-	.destroy = rk3066_hdmi_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes             = rk3066_hdmi_probe_single_connector_modes,
+	.detect                 = rk3066_hdmi_connector_detect,
+	.destroy                = rk3066_hdmi_connector_destroy,
+	.reset                  = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state,
+	.late_register          = rk3066_hdmi_connector_late_register,
+	.early_unregister       = rk3066_hdmi_connector_early_unregister,
 };

 static const
 struct drm_connector_helper_funcs rk3066_hdmi_connector_helper_funcs = {
-	.get_modes = rk3066_hdmi_connector_get_modes,
-	.mode_valid = rk3066_hdmi_connector_mode_valid,
+	.get_modes    = rk3066_hdmi_connector_get_modes,
+	.mode_valid   = rk3066_hdmi_connector_mode_valid,
 	.best_encoder = rk3066_hdmi_connector_best_encoder,
 };

-static int
-rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
+static int rk3066_hdmi_audio_config(struct rk3066_hdmi *hdmi)
 {
-	struct drm_encoder *encoder = &hdmi->encoder.encoder;
-	struct device *dev = hdmi->dev;
+	u32 rate, channel, word_length, N, CTS;
+	struct rk3066_hdmi_audio_info *audio = &hdmi->audio;
+	u64 tmp;
+
+	if (audio->channels < 3)
+		channel = HDMI_AUDIO_I2S_CHANNEL_1_2;
+	else if (audio->channels < 5)
+		channel = HDMI_AUDIO_I2S_CHANNEL_3_4;
+	else if (audio->channels < 7)
+		channel = HDMI_AUDIO_I2S_CHANNEL_5_6;
+	else
+		channel = HDMI_AUDIO_I2S_CHANNEL_7_8;
+
+	switch (audio->sample_rate) {
+	case 32000:
+		rate = HDMI_AUDIO_SAMPLE_FRE_32000;
+		N = N_32K;
+		break;
+	case 44100:
+		rate = HDMI_AUDIO_SAMPLE_FRE_44100;
+		N = N_441K;
+		break;
+	case 48000:
+		rate = HDMI_AUDIO_SAMPLE_FRE_48000;
+		N = N_48K;
+		break;
+	case 88200:
+		rate = HDMI_AUDIO_SAMPLE_FRE_88200;
+		N = N_882K;
+		break;
+	case 96000:
+		rate = HDMI_AUDIO_SAMPLE_FRE_96000;
+		N = N_96K;
+		break;
+	case 176400:
+		rate = HDMI_AUDIO_SAMPLE_FRE_176400;
+		N = N_1764K;
+		break;
+	case 192000:
+		rate = HDMI_AUDIO_SAMPLE_FRE_192000;
+		N = N_192K;
+		break;
+	default:
+		DRM_DEV_ERROR(hdmi->dev, "no support for sample rate %d\n",
+			      audio->sample_rate);
+		return -ENOENT;
+	}
+
+	switch (audio->sample_width) {
+	case 16:
+		word_length = 0x02;
+		break;
+	case 20:
+		word_length = 0x0a;
+		break;
+	case 24:
+		word_length = 0x0b;
+		break;
+	default:
+		DRM_DEV_ERROR(hdmi->dev, "no support for word length %d\n",
+			      audio->sample_width);
+		return -ENOENT;
+	}
+
+	tmp = (u64)hdmi->tmdsclk * N;
+	do_div(tmp, 128 * audio->sample_rate);
+	CTS = tmp;
+
+	/* Set_audio source I2S. */
+	hdmi_writeb(hdmi, HDMI_AUDIO_CTRL1, 0x00);
+	hdmi_writeb(hdmi, HDMI_AUDIO_CTRL2, 0x40);
+	hdmi_writeb(hdmi, HDMI_I2S_AUDIO_CTRL,
+		    HDMI_AUDIO_I2S_FORMAT_STANDARD | channel);
+	hdmi_writeb(hdmi, HDMI_I2S_SWAP, 0x00);
+	hdmi_modb(hdmi, HDMI_AV_CTRL1, HDMI_AUDIO_SAMPLE_FRE_MASK, rate);
+	hdmi_writeb(hdmi, HDMI_AUDIO_SRC_NUM_AND_LENGTH, word_length);
+
+	/* Set N value. */
+	hdmi_modb(hdmi, HDMI_LR_SWAP_N3,
+		  HDMI_AUDIO_N_19_16_MASK, (N >> 16) & 0x0F);
+	hdmi_writeb(hdmi, HDMI_N2, (N >> 8) & 0xFF);
+	hdmi_writeb(hdmi, HDMI_N1, N & 0xFF);
+
+	/* Set CTS value. */
+	hdmi_writeb(hdmi, HDMI_CTS_EXT1, CTS & 0xff);
+	hdmi_writeb(hdmi, HDMI_CTS_EXT2, (CTS >> 8) & 0xff);
+	hdmi_writeb(hdmi, HDMI_CTS_EXT3, (CTS >> 16) & 0xff);
+
+	if (audio->channels > 2)
+		hdmi_modb(hdmi, HDMI_LR_SWAP_N3,
+			  HDMI_AUDIO_LR_SWAP_MASK,
+			  HDMI_AUDIO_LR_SWAP_SUBPACKET1);
+	rate = (~(rate >> 4)) & 0x0f;
+	hdmi_writeb(hdmi, HDMI_AUDIO_STA_BIT_CTRL1, rate);
+	hdmi_writeb(hdmi, HDMI_AUDIO_STA_BIT_CTRL2, 0);
+
+	return rk3066_hdmi_config_aai(hdmi);
+}
+
+static int rk3066_hdmi_audio_hw_params(struct device *dev, void *d,
+				       struct hdmi_codec_daifmt *daifmt,
+				       struct hdmi_codec_params *params)
+{
+	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_display_info *display = &hdmi->connector.display_info;

-	encoder->possible_crtcs =
-		drm_of_find_possible_crtcs(drm, dev->of_node);
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
+	return rk3066_hdmi_audio_config(hdmi);
+}
+
+static void rk3066_hdmi_audio_shutdown(struct device *dev, void *d)
+{
+	/* Do nothing. */
+}
+
+static int rk3066_hdmi_audio_mute_stream(struct device *dev, void *d, bool mute, int direction)
+{
+	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
+	if (!display->has_audio) {
+		DRM_DEV_ERROR(hdmi->dev, "no audio support\n");
+		return -ENODEV;
+	}
+
+	hdmi->audio_enable = !mute;
+
+	if (mute)
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_DISABLE, HDMI_AUDIO_DISABLE);
+	else
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2, HDMI_AUDIO_DISABLE, 0);

 	/*
-	 * If we failed to find the CRTC(s) which this encoder is
-	 * supposed to be connected to, it's because the CRTC has
-	 * not been registered yet.  Defer probing, and hope that
-	 * the required CRTC is added later.
+	 * Under power mode E we need to reset the audio capture logic to
+	 * make the audio setting update.
 	 */
-	if (encoder->possible_crtcs == 0)
-		return -EPROBE_DEFER;
+	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_E) {
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK,
+			  HDMI_AUDIO_CP_LOGIC_RESET);
+		usleep_range(900, 1000);
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK, 0);
+	}
+
+	return 0;
+}
+
+static int rk3066_hdmi_audio_get_eld(struct device *dev, void *d, u8 *buf, size_t len)
+{
+	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
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
+static const struct hdmi_codec_ops rk3066_hdmi_audio_codec_ops = {
+	.hw_params       = rk3066_hdmi_audio_hw_params,
+	.audio_shutdown  = rk3066_hdmi_audio_shutdown,
+	.mute_stream     = rk3066_hdmi_audio_mute_stream,
+	.get_eld         = rk3066_hdmi_audio_get_eld,
+	.no_capture_mute = 1,
+};
+
+static int rk3066_hdmi_audio_codec_init(struct rk3066_hdmi *hdmi)
+{
+	struct hdmi_codec_pdata rk3066_hdmi_codec_data = {
+		.i2s = 1,
+		.ops = &rk3066_hdmi_audio_codec_ops,
+		.max_i2s_channels = 8,
+	};
+
+	hdmi->audio.channels = 2;
+	hdmi->audio.sample_rate = 48000;
+	hdmi->audio.sample_width = 16;
+	hdmi->audio_enable = false;
+	hdmi->audio_pdev = platform_device_register_data(hdmi->dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_NONE,
+							 &rk3066_hdmi_codec_data,
+							 sizeof(rk3066_hdmi_codec_data));
+
+	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
+}
+
+static int rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
+{
+	struct drm_encoder *encoder = &hdmi->encoder.encoder;

 	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
 	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
@@ -740,6 +1004,7 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
+	struct drm_encoder *encoder;
 	struct rk3066_hdmi *hdmi;
 	int irq;
 	int ret;
@@ -748,8 +1013,19 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
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
-	hdmi->drm_dev = drm;
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdmi->regs))
 		return PTR_ERR(hdmi->regs);
--
2.39.2


