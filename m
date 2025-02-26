Return-Path: <linux-kernel+bounces-533377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D7A4594B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E2B7ABBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D924DFE7;
	Wed, 26 Feb 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URpMX+A0"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE32459D9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560389; cv=none; b=qQoraCeFU0DgYkazdEIczdzW4+zukXDi0Zs+Qes8slzyr9AknSpi0ivSnYeb+8iJlftQvmR49elDwuVTWW8uKr01XKmuieefl5iuzQ8m7noM2TqdQIw/H51y1HlxLqfG2IXipt6vv571K8+M/3rheFWuZQzwDlOKjGDPTfbIX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560389; c=relaxed/simple;
	bh=jCnB9nRWDX2Sto2qyIJmSafVo3Vaxjg8eV0IBfZcuDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSlzgOpjQas1DYxajTuPeJq0mLK1X4hGJAUrle65cRn0UuUdCiPoifJgM62k4wDobpKSuqDEgHnRglmNSbECwWtoSs1a9NPeMqROJ9Hr20JGJd9UswEv4Dfe3L5F1HwzJ8geTUX/886SsxJGLYOORoODZihiUTvAQ6hBTQF33ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URpMX+A0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so60995681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740560385; x=1741165185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL+D8qDRnHL8DVLPlIP7FF7uRot9P+Ldg7WswD3BRiU=;
        b=URpMX+A0nes2ZDL05C9h19z6CMmXm9eqb7yaP5oVBmucMCYZRf8lQP0rZhcO7KZlDj
         nVWidHz95AjFshiU/++ZYEj2vSDB13RQe/EWIr/eMsk+jLa7NUFF+Nlj3fgEcHQb0rFK
         HFJHdmuIDnY2/UFBoGCYMSL22ZWnfAhkrcr89c3L5A44DQHxxJXCzGE8PUv0yf53Mzgv
         9LGGmcCy10OJ6SguF1wN5xulNaPPN/Hoj3HD/UVPOjB4J84U5SuEelAhAz9Y2+WlgJHS
         OdJup9P0MUBTI4PyiuT5g/OripnEHaYKG3XMO9MND3J7xk3YAp/mUpGUWgWnhlSNgaur
         M0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560385; x=1741165185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL+D8qDRnHL8DVLPlIP7FF7uRot9P+Ldg7WswD3BRiU=;
        b=Jqm+wPiuh5kQEkuMh81TnwY/tNHkIx1gf/0+lFyzYMRxuW97o7ZzH6SSaFc2tnxNuY
         DphOzgph9vS6FjrT8/NSPro55QW6zzUalF+mxWNpGh+aUkYfIR3fry/2OX/ZKM78Xfan
         9TOh4yPb9jeiY/ODZxrDIi5V7BHQaCObhiao6/NZD03A65o10BhiMz7QIm9EwRGy3wLA
         OOJiYKYYjPNzfiLlAXFAI0kLhe3nbtUNJHjY8TR2iNJD/wGs/fB4iLvjK6OHFuHmQPA5
         /9ogmOhYBrZqVdM7Nwc9jqaggWEFiTyRT3JQ0v0uYmHSa8ujsBkpR6Ok9hD8NvPDiTzK
         sIqg==
X-Forwarded-Encrypted: i=1; AJvYcCX/vXj5TnU/DBiKuEnpqIbQnj3tazMLGUnXRK6hrZl4uQPEbA19Hqz6mmeWwRTk9XR6v2ShS6hGJ3+k5B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMbn7vpF0Y21WWPGPE5115iJBYqy6g0UUbrCWqUn0LViP6TuO
	cNYcgpcJfYSguvPK5TzYFO07Ahl3gkju7w05a64HJk4qXO/SvZwyq1L+wsUn1Zd1PrJG++9/jbe
	MMNE=
X-Gm-Gg: ASbGnctWRnufWki9J7q4AQVwws0onjPY8aKO/3u6FhIohv329OjbQmwTIiPsyuXTb0u
	AMC+eYQ8ClLAZcEOR2QGj3Qu76xLHatSUoFpZDqdYiWtxJV97xk0WZv4unqQPR3SgLwGiNDBFZU
	SkzVSA3DRXwZHvSBoRzHepUWkcIrWlu8UPDMN5D/MRU6xM/Z9RxRpSkhxprWTyy62zhWnvVyFiS
	9rM9BqvUkSbFU5ha8TOcxLhrM5UVVDgM44FLt3wo0Ly/jGfq9OEw5ILecveg550rkYWbkaAus1I
	Vx83yYsh2SqwzARdkObPmm+q96C3hDf4fg==
X-Google-Smtp-Source: AGHT+IE4CZCG624luysY8QDGSj/e+AcLpGvZaiAptFBQEJEe8XJs4qoydl6YsrRoUijs3EUGi94bkA==
X-Received: by 2002:a2e:8e8c:0:b0:309:2012:cc5d with SMTP id 38308e7fff4ca-30a59970308mr85221661fa.24.1740560384896;
        Wed, 26 Feb 2025 00:59:44 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c49sm4556641fa.10.2025.02.26.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:59:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:59:30 +0200
Subject: [PATCH v8 7/7] drm/msm/hdmi: use DRM HDMI Audio framework
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-bridge-hdmi-connector-v8-7-340af24b35cc@linaro.org>
References: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
In-Reply-To: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9824;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jCnB9nRWDX2Sto2qyIJmSafVo3Vaxjg8eV0IBfZcuDw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtftdD3IqWq+CTQLWloYFRJ87Ia/M+sufsRp1
 gBXQGO6Z8eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77X7QAKCRCLPIo+Aiko
 1YZdB/9/2HWVKa/vpHUDYz2NdMq7UbWPPKoQW0INmMZlqTUWtSpl67gtnRqLfgXffBHZ5+o0RuL
 zhgNcpcMZ6W5cwXk0mSpikFAJUx6wt9hR2/4tn/llsYBT4RfEPqgXafWHBAXzEQQIzVhh5hB0uu
 L0KauDe702jDY0xaWhOchMCrzSxwzigND5bnxRrx+4pTI20Ixep++n3fyc8LpK1S9KE0MApHIO6
 tLK7Rz5MyGtG5gcPTsQE+rlhAktBvXnjjNz1hlZYJqVf2RukceuvBPiF1/FuafX/7m6wWaSNNG+
 uibSLLq9EAmfYTxnGNzl9oyJeYoF1GtGf04G7QfDomTYbCic
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to simplify the driver even further and to remove the
boilerplate code, rewrite the audio interface to use the DRM HDMI Audio
framework.

Audio InfoFames are controlled centrally via the DRM HDMI framework.
Correct InfoFrame data is programmed at the atomic_pre_enable() time (if
it was set before, drm_atomic_helper_connector_hdmi_update_infoframes()
takes care of writing all InfoFrames, including the Audio one.) or
during msm_hdmi_bridge_audio_prepare() when the new stream is started.

All audio data frame management is deferred to
msm_hdmi_bridge_audio_prepare() and msm_hdmi_bridge_audio_shutdown().

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        | 91 ----------------------------------
 drivers/gpu/drm/msm/hdmi/hdmi.h        | 18 +++----
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c  | 68 +++++++++++++++++++++----
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |  5 ++
 4 files changed, 71 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 6b77e0fb8d5ec218dfbf58215e2e12ad1dfb1b85..248541ff449204c72cd444458dadb9ae4a0a53d1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -14,7 +14,6 @@
 #include <drm/drm_of.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
-#include <sound/hdmi-codec.h>
 #include "hdmi.h"
 
 void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on)
@@ -245,87 +244,6 @@ static const struct hdmi_platform_config hdmi_tx_8974_config = {
 		.hpd_freq      = hpd_clk_freq_8x74,
 };
 
-/*
- * HDMI audio codec callbacks
- */
-static int msm_hdmi_audio_hw_params(struct device *dev, void *data,
-				    struct hdmi_codec_daifmt *daifmt,
-				    struct hdmi_codec_params *params)
-{
-	struct hdmi *hdmi = dev_get_drvdata(dev);
-	unsigned int rate;
-	int ret;
-
-	DRM_DEV_DEBUG(dev, "%u Hz, %d bit, %d channels\n", params->sample_rate,
-		 params->sample_width, params->cea.channels);
-
-	switch (params->sample_rate) {
-	case 32000:
-		rate = HDMI_SAMPLE_RATE_32KHZ;
-		break;
-	case 44100:
-		rate = HDMI_SAMPLE_RATE_44_1KHZ;
-		break;
-	case 48000:
-		rate = HDMI_SAMPLE_RATE_48KHZ;
-		break;
-	case 88200:
-		rate = HDMI_SAMPLE_RATE_88_2KHZ;
-		break;
-	case 96000:
-		rate = HDMI_SAMPLE_RATE_96KHZ;
-		break;
-	case 176400:
-		rate = HDMI_SAMPLE_RATE_176_4KHZ;
-		break;
-	case 192000:
-		rate = HDMI_SAMPLE_RATE_192KHZ;
-		break;
-	default:
-		DRM_DEV_ERROR(dev, "rate[%d] not supported!\n",
-			params->sample_rate);
-		return -EINVAL;
-	}
-
-	ret = drm_atomic_helper_connector_hdmi_update_audio_infoframe(hdmi->connector,
-								      &params->cea);
-	if (ret)
-		return ret;
-
-	msm_hdmi_audio_info_setup(hdmi, rate, params->cea.channels);
-
-	return 0;
-}
-
-static void msm_hdmi_audio_shutdown(struct device *dev, void *data)
-{
-	struct hdmi *hdmi = dev_get_drvdata(dev);
-
-	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(hdmi->connector);
-	msm_hdmi_audio_disable(hdmi);
-}
-
-static const struct hdmi_codec_ops msm_hdmi_audio_codec_ops = {
-	.hw_params = msm_hdmi_audio_hw_params,
-	.audio_shutdown = msm_hdmi_audio_shutdown,
-};
-
-static struct hdmi_codec_pdata codec_data = {
-	.ops = &msm_hdmi_audio_codec_ops,
-	.max_i2s_channels = 8,
-	.i2s = 1,
-};
-
-static int msm_hdmi_register_audio_driver(struct hdmi *hdmi, struct device *dev)
-{
-	hdmi->audio_pdev = platform_device_register_data(dev,
-							 HDMI_CODEC_DRV_NAME,
-							 PLATFORM_DEVID_AUTO,
-							 &codec_data,
-							 sizeof(codec_data));
-	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
-}
-
 static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(master);
@@ -337,12 +255,6 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return err;
 	priv->hdmi = hdmi;
 
-	err = msm_hdmi_register_audio_driver(hdmi, dev);
-	if (err) {
-		DRM_ERROR("Failed to attach an audio codec %d\n", err);
-		hdmi->audio_pdev = NULL;
-	}
-
 	return 0;
 }
 
@@ -352,9 +264,6 @@ static void msm_hdmi_unbind(struct device *dev, struct device *master,
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 
 	if (priv->hdmi) {
-		if (priv->hdmi->audio_pdev)
-			platform_device_unregister(priv->hdmi->audio_pdev);
-
 		if (priv->hdmi->bridge)
 			msm_hdmi_hpd_disable(priv->hdmi);
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index cdd3bd4f37831f9a606a4c3627a48364f5d4025f..a5f481c39277631b7a19d294b086d6208be26511 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -33,7 +33,6 @@ struct hdmi_hdcp_ctrl;
 struct hdmi {
 	struct drm_device *dev;
 	struct platform_device *pdev;
-	struct platform_device *audio_pdev;
 
 	const struct hdmi_platform_config *config;
 
@@ -205,17 +204,16 @@ static inline int msm_hdmi_pll_8998_init(struct platform_device *pdev)
 /*
  * audio:
  */
-#define	HDMI_SAMPLE_RATE_32KHZ		0
-#define	HDMI_SAMPLE_RATE_44_1KHZ	1
-#define	HDMI_SAMPLE_RATE_48KHZ		2
-#define	HDMI_SAMPLE_RATE_88_2KHZ	3
-#define	HDMI_SAMPLE_RATE_96KHZ		4
-#define	HDMI_SAMPLE_RATE_176_4KHZ	5
-#define	HDMI_SAMPLE_RATE_192KHZ		6
+struct hdmi_codec_daifmt;
+struct hdmi_codec_params;
 
 int msm_hdmi_audio_update(struct hdmi *hdmi);
-int msm_hdmi_audio_info_setup(struct hdmi *hdmi, int rate, int channels);
-int msm_hdmi_audio_disable(struct hdmi *hdmi);
+int msm_hdmi_bridge_audio_prepare(struct drm_connector *connector,
+				  struct drm_bridge *bridge,
+				  struct hdmi_codec_daifmt *daifmt,
+				  struct hdmi_codec_params *params);
+void msm_hdmi_bridge_audio_shutdown(struct drm_connector *connector,
+				    struct drm_bridge *bridge);
 
 /*
  * hdmi bridge:
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
index 0b91ed5eabd234ff3bca0c2dfaa159dd2e6a9df5..8bb975e82c17c1d77217128e9ddbd6a0575bb33d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_audio.c
@@ -4,7 +4,12 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <drm/display/drm_hdmi_state_helper.h>
+
 #include <linux/hdmi.h>
+
+#include <sound/hdmi-codec.h>
+
 #include "hdmi.h"
 
 /* Supported HDMI Audio sample rates */
@@ -192,29 +197,72 @@ int msm_hdmi_audio_update(struct hdmi *hdmi)
 	return 0;
 }
 
-int msm_hdmi_audio_info_setup(struct hdmi *hdmi, int rate, int channels)
+int msm_hdmi_bridge_audio_prepare(struct drm_connector *connector,
+				  struct drm_bridge *bridge,
+				  struct hdmi_codec_daifmt *daifmt,
+				  struct hdmi_codec_params *params)
 {
-	if (!hdmi)
-		return -ENXIO;
-
-	if ((rate < 0) || (rate >= MSM_HDMI_SAMPLE_RATE_MAX))
+	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
+	struct hdmi *hdmi = hdmi_bridge->hdmi;
+	unsigned int rate;
+	int ret;
+
+	drm_dbg_driver(bridge->dev, "%u Hz, %d bit, %d channels\n",
+		       params->sample_rate,
+		       params->sample_width,
+		       params->cea.channels);
+
+	switch (params->sample_rate) {
+	case 32000:
+		rate = MSM_HDMI_SAMPLE_RATE_32KHZ;
+		break;
+	case 44100:
+		rate = MSM_HDMI_SAMPLE_RATE_44_1KHZ;
+		break;
+	case 48000:
+		rate = MSM_HDMI_SAMPLE_RATE_48KHZ;
+		break;
+	case 88200:
+		rate = MSM_HDMI_SAMPLE_RATE_88_2KHZ;
+		break;
+	case 96000:
+		rate = MSM_HDMI_SAMPLE_RATE_96KHZ;
+		break;
+	case 176400:
+		rate = MSM_HDMI_SAMPLE_RATE_176_4KHZ;
+		break;
+	case 192000:
+		rate = MSM_HDMI_SAMPLE_RATE_192KHZ;
+		break;
+	default:
+		drm_err(bridge->dev, "rate[%d] not supported!\n",
+			params->sample_rate);
 		return -EINVAL;
+	}
+
+	ret = drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector,
+								      &params->cea);
+	if (ret)
+		return ret;
 
 	hdmi->audio.rate = rate;
-	hdmi->audio.channels = channels;
+	hdmi->audio.channels = params->cea.channels;
 	hdmi->audio.enabled = true;
 
 	return msm_hdmi_audio_update(hdmi);
 }
 
-int msm_hdmi_audio_disable(struct hdmi *hdmi)
+void msm_hdmi_bridge_audio_shutdown(struct drm_connector *connector,
+				    struct drm_bridge *bridge)
 {
-	if (!hdmi)
-		return -ENXIO;
+	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
+	struct hdmi *hdmi = hdmi_bridge->hdmi;
+
+	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 
 	hdmi->audio.rate = 0;
 	hdmi->audio.channels = 2;
 	hdmi->audio.enabled = false;
 
-	return msm_hdmi_audio_update(hdmi);
+	msm_hdmi_audio_update(hdmi);
 }
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index aee75eee3d4244cd95e44df46d65b8e3e53de735..c6659e62594558b3c0c25de36aa8c459aa253834 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -478,6 +478,8 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.hdmi_tmds_char_rate_valid = msm_hdmi_bridge_tmds_char_rate_valid,
 	.hdmi_clear_infoframe = msm_hdmi_bridge_clear_infoframe,
 	.hdmi_write_infoframe = msm_hdmi_bridge_write_infoframe,
+	.hdmi_audio_prepare = msm_hdmi_bridge_audio_prepare,
+	.hdmi_audio_shutdown = msm_hdmi_bridge_audio_shutdown,
 };
 
 static void
@@ -515,6 +517,9 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
 		DRM_BRIDGE_OP_DETECT |
 		DRM_BRIDGE_OP_HDMI |
 		DRM_BRIDGE_OP_EDID;
+	bridge->hdmi_audio_max_i2s_playback_channels = 8;
+	bridge->hdmi_audio_dev = &hdmi->pdev->dev;
+	bridge->hdmi_audio_dai_port = -1;
 
 	ret = devm_drm_bridge_add(hdmi->dev->dev, bridge);
 	if (ret)

-- 
2.39.5


