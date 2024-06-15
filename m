Return-Path: <linux-kernel+bounces-215970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28B909973
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6576D283342
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BEB60DEA;
	Sat, 15 Jun 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAYckJ/H"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5664502B2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474019; cv=none; b=pHGSzYiP7YhK60+UJOHKM0Cg8Eh9ojvGRuFwHd/IgF2KVlzJDOJha3VIDNx3/mNXcChfL4MvbIlQMDiEsCoWfX53+ABvvsGj4HJgTq3Plf60rBOkajmm4z4h3t2XpniJmKsl0w0BihXHprLNVuEjXdTSQoBCF3AofWwE4JdRpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474019; c=relaxed/simple;
	bh=pn2geVII/7Eo49RZTSaWQ/BY5SCV/YSpXIUmvyJMH0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6ROG6oN9XU7s43WdTtkPdbWyK9EsCtvWdsn08zQQWObTOWrV1FbKwgGdZ9Hu03QTtAGv+pk5i23NEL2IUOLPUxgXLBB7x1gRcvkc9+Te8J1OOKEA4zH5Crq5HxdPX/UgqeSQtlVWWSp01tf3CqgZZ3i99Mqq6Yo7f94DkCuU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VAYckJ/H; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52caebc6137so1242352e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718474016; x=1719078816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSmIEAIcnC5msdB38vTdYnwra4YbtdBczjpwQBiMsUo=;
        b=VAYckJ/H0io7WrI8vriTAYUCw18L5sUHKb3XVoNCmn0wQurr7PO/HISYJ0c2ZeRho8
         10P+uRzVUWjHntCCbAuvhkQTh/cxBEtIgbUHkxztt+ORU/31tPYVKpI3S1GmfVbea2XT
         zXjv5ijc/k3K1TCQ7dFbQb2jLxPVJP2L1pQmd1WxsmSmHcfMY3/ffxLzPKghEaZZr6pU
         5shfWuqeX4OHuOMLU9RgD3BJIgjaqzOgKwqL8R4gPoHucj6qDrJJvCou9lFyM+pWXg1J
         taGFZsur1SUqopd93B5z8z31/u5+rVUcV618LA9QaeSB3OxJWC9hEhNKrCxPQ4DtJSlC
         rPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718474016; x=1719078816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSmIEAIcnC5msdB38vTdYnwra4YbtdBczjpwQBiMsUo=;
        b=UP8oY/wRE1Vxn9S3lGK/FVoZZ8rnVVdYKjbd6vdkJzwWIxuwUcRINylkuoCFPZc24k
         cqKL37Ic/XabKgFeI9ILNlzta/je7PIK5rtBTNEtvgkMJPn7cS3uUJY1gsrclFPekJNP
         jaU8nD3dp+oAPFOa/5tRiJtb/CkOfQmmoIXZlGfHerM0GYocAzJw5pQUsRjHTLAiKVkv
         LKyR6ccBQ4lEdFOzhMwfYpkl3CJJB3RjZ1qrvfMmmanDCxWoK59Vmk8XmNR5h/CkMh7h
         TBzciJU7lW+JlHjREEd1uAAVpTQI+eKuZ0/KN2pdrQnBYYOEQiioBrae11wzgwPuWagu
         H16g==
X-Forwarded-Encrypted: i=1; AJvYcCXXvbT7CAuRduSBn4lHZJpNiVKdoy8PalsbZIWYmJjxJzLmFj7x3kxz/5vDBOxiK6MHl+Kl9ZWmkTFUTyliTsqa9JpCnv+iZ3R/cuMd
X-Gm-Message-State: AOJu0YxfuzA2TKtP0qkM0SiY3sVFlMisMruU2Vi96bHukpK+8UgVrevu
	MCz+k6U/T8hW3xXAaqhIwHJJ6VXuaGjlHU2Oh6+1Od4lWl7RS5PkDSYCHeYWHCc=
X-Google-Smtp-Source: AGHT+IFFYHgBPLlADC7SeWWeSUbYhyXls9nx5aYDUbEVtXba3FK5dU/UdVl0LGd0s9vqqrTQ+6kMww==
X-Received: by 2002:ac2:4d84:0:b0:52c:859f:f4f0 with SMTP id 2adb3069b0e04-52ca6e55b9dmr3329487e87.1.1718474015617;
        Sat, 15 Jun 2024 10:53:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287affcsm799209e87.232.2024.06.15.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 10:53:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 15 Jun 2024 20:53:31 +0300
Subject: [PATCH RFC 2/5] ASoC: hdmi-codec: pass data to get_dai_id too
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-drm-bridge-hdmi-connector-v1-2-d59fc7865ab2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5201;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pn2geVII/7Eo49RZTSaWQ/BY5SCV/YSpXIUmvyJMH0Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbdUcJ8IWkUmCcVBgeC3Vg+4kMPVLklqkCSo8t
 dwBDiKMur6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZm3VHAAKCRCLPIo+Aiko
 1TujB/9qMk4FvPARfIqiMMGapz1hICXprHpD56e2wjfXzSdlFR1jrjFrv6a9LcgotCtgzcV2MpJ
 ftnGmikXtNHqYanoz+ECPMv7dQSvXoJ7tjsQ8TuqMgbKXMlyZWHsjPSjeoJ7rVT9BK4VZ6X9uBE
 EvDhcHjkpNi9govajrxDXoeeHtyaapmizdRwSNHrVyC6Fdl3YS4gps7Fn2ig8b88Z4vKNSHL9ZF
 HEXHBUGPyqwQf5ikQPo3+Ceb1S9QCYCPmkEUdSWD98XX1mWWNlej5C7RMckzPk5rx87fdeVv5W0
 Vs04wHXP3k8ekcQE5RW1sst75DpC5YGVc01V/SW2yawCH5ju
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The upcoming DRM connector HDMI codec implementation is going to use
codec-specific data in the .get_dai_id to get drm_connector. Pass data
to the callback, as it is done with other hdmi_codec_ops callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c      | 3 ++-
 drivers/gpu/drm/bridge/analogix/anx7625.c           | 3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611.c             | 3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c          | 3 ++-
 drivers/gpu/drm/bridge/sii902x.c                    | 3 ++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 3 ++-
 include/sound/hdmi-codec.h                          | 3 ++-
 sound/soc/codecs/hdmi-codec.c                       | 2 +-
 8 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 61f4a38e7d2b..51fb9a574b4e 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -204,7 +204,8 @@ static void audio_shutdown(struct device *dev, void *data)
 }
 
 static int adv7511_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-					struct device_node *endpoint)
+					struct device_node *endpoint,
+					void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 88e4aa5830f3..f18cf79a292b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1962,7 +1962,8 @@ static void anx7625_audio_shutdown(struct device *dev, void *data)
 }
 
 static int anx7625_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-				       struct device_node *endpoint)
+				       struct device_node *endpoint,
+				       void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1b31fdebe164..4fa0dfc5539a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1059,7 +1059,8 @@ static void lt9611_audio_shutdown(struct device *dev, void *data)
 }
 
 static int lt9611_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-				      struct device_node *endpoint)
+				      struct device_node *endpoint,
+				      void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 4e802b54a1cb..54c528fa168e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -601,7 +601,8 @@ static void lt9611uxc_audio_shutdown(struct device *dev, void *data)
 }
 
 static int lt9611uxc_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-					 struct device_node *endpoint)
+					 struct device_node *endpoint,
+					 void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 7f91b0db161e..1883df5fd5c1 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -798,7 +798,8 @@ static int sii902x_audio_get_eld(struct device *dev, void *data,
 }
 
 static int sii902x_audio_get_dai_id(struct snd_soc_component *component,
-				    struct device_node *endpoint)
+				    struct device_node *endpoint,
+				    void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 26c187d20d97..86c412e9cbc8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -148,7 +148,8 @@ static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
 }
 
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-				  struct device_node *endpoint)
+				  struct device_node *endpoint,
+				  void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 5e1a9eafd10f..b3407b47b4a7 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -105,7 +105,8 @@ struct hdmi_codec_ops {
 	 * Optional
 	 */
 	int (*get_dai_id)(struct snd_soc_component *comment,
-			  struct device_node *endpoint);
+			  struct device_node *endpoint,
+			  void *data);
 
 	/*
 	 * Hook callback function to handle connector plug event.
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d3abb7ce2153..afad402122cb 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -981,7 +981,7 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	int ret = -ENOTSUPP; /* see snd_soc_get_dai_id() */
 
 	if (hcp->hcd.ops->get_dai_id)
-		ret = hcp->hcd.ops->get_dai_id(component, endpoint);
+		ret = hcp->hcd.ops->get_dai_id(component, endpoint, hcp->hcd.data);
 
 	return ret;
 }

-- 
2.39.2


