Return-Path: <linux-kernel+bounces-426509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7889DF43B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3775162EB7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD22C147;
	Sun,  1 Dec 2024 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnk+pp+s"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9D79C8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733013859; cv=none; b=gvE3Jjz/zS0hkpCUVoQc84Yc9ev6zypbA9WdEXY3jNdtRuo0DD5FXfBp9Os0mTm9o3/yQLAvv7bsJuVvnIiA24hnMlkhAW+zGgMC2u/jnaiP/+1ncFNafsM6RLy3XJ9UfSTicS1VWBwhU8RZgdBrKqaGQ5LMTWGTLhEsXoQJCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733013859; c=relaxed/simple;
	bh=xKXgCzbJKZ6UUdReZlG7GRuNQSsdN/VrnC+8Pdwptd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T28ogN/vLmMYYNAL+QEjOKAYJJat/Ma22Q4fFvcF/gnOSS3WPZ5IpnW1BNpDs1ul/s6YYqvNEKS/0QfR/fn5pmw9bp02hWVTnxHKafL61VJjjV/pEcYqn4jh99qY3HMBx1jdSzW2L75G52F/9UUORVlaPyK9jIl7Jkms0SJu3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lnk+pp+s; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so2276254a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733013856; x=1733618656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Knx2vF/XV6x3WtvG+CxxtwnkZCT4oFDg0nDSk74X/xk=;
        b=Lnk+pp+s6JHCc2ixXh44HhEbRSnHBgepaETKYA7HkV4Ab5LvokLmeYAP1cO3BZs61O
         jvy+2+pvvhNGSd1ajN7GOUGRzGZ59JYVmlvPnXfF2CYopLIr7CCUz8qwfUz9QvTvaRxb
         Ce1lOWkhoDbO9ok+IMIBTUgk2MOqije1psIWdaRB7tqC1tLJZoFl8hcAgUYGFl8Rrb6U
         H9DAERhpECVEqIv+vHyl3FsUzJSv3piQ2lN0zRrKKH9uIwS342W6/8KQRNDnZP+gAeBQ
         xn4G6Y74roP1Ye6fKlqZoRfbKRJK7fGotLYOnFIEU89di6BQDD/8suWNaqAOSNU9aepl
         CN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733013856; x=1733618656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Knx2vF/XV6x3WtvG+CxxtwnkZCT4oFDg0nDSk74X/xk=;
        b=HE6zMKJ0e/EeDlPffy6rU3DwNVDEkTEvbM8Uo58IpH59VDswFpSwdYXR1KLCjZV+Bp
         OEOVJZOV5AV+YHTkrmrtJWLUKWOX1sL5K0jlfpI6ykO42M5Ayg0smpuXsgCi9AbckapN
         OQwH9eXnyxALD4ZTIK/Qkp22f+3atLgi5xyrFsYj1XiW+1/NYU51RorU+QUzu1eplsoO
         fetkUWfrYNJFfQInjF6phUU+nfZF+lZ6FV0Pc+VfDEx85Ma+WkvYLZFhysDhwt1VRSck
         Ji9km6o0o6BmEbNwIKbV7wx2aYoNa98frpabWnSQDtdceozdfyILGDPQDcghFKvgAtWE
         98JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb3Bwjr+LlnzqY4hHGCm1csp/l3GZUYZCFSH6Bl+EM2NcPzB+Pe1H/MvMeumJ1sjfevxyGpy4C8+gTqiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipMQPv+UlcDQg9CkB6PfL+lTB4Eqc1F2L51ooR8SM4X/AoVV7
	2S3A7nLTcler3XruIYlcklR8lJ5WHjM+6rzYhMmZx5c7OgaN89a/EJtKQq5821c=
X-Gm-Gg: ASbGnctixMQVHtULQNgbWxBXK4BS7qJvMO03J5ulaHKWn0iZhjcikrvdcmGJ0TGn7Ea
	m+ZusBzv4xn2vgciENXH/uBTQsn7VO4E2eaQQLl92MGq8L04TYgP9YilvJsoVArBPahBrPwQ8dk
	jVmeG1HNcsTrqFpjpVBl78oPKpOkIP72iJFxhkR7N+xRQpxmx7nRLo8xhEDE31GKDDZDhV7dnQa
	Jl2kdpSdMVLY5Wpne8Ux7TDujesjneYBblifLcmPB0GdCaHnqEbT084fQ==
X-Google-Smtp-Source: AGHT+IG2vkfheouE1mPbocWXKym9yPXudTpq4FYXRE1GdSbbteSVJqBbXoSoXaZUoVfFrUgKdHkWWQ==
X-Received: by 2002:a05:6402:51ca:b0:5d0:8606:9b92 with SMTP id 4fb4d7f45d1cf-5d08606cd3amr13223060a12.5.1733013856266;
        Sat, 30 Nov 2024 16:44:16 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8d817sm3400359a12.63.2024.11.30.16.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 16:44:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 02:44:05 +0200
Subject: [PATCH v5 1/9] ASoC: hdmi-codec: pass data to get_dai_id too
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-bridge-hdmi-connector-v5-1-b5316e82f61a@linaro.org>
References: <20241201-drm-bridge-hdmi-connector-v5-0-b5316e82f61a@linaro.org>
In-Reply-To: <20241201-drm-bridge-hdmi-connector-v5-0-b5316e82f61a@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5692;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xKXgCzbJKZ6UUdReZlG7GRuNQSsdN/VrnC+8Pdwptd4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS7FXH/RpG/BjQasdBLhNln9hjEHbp3mQ9vf3t
 EW2Nf56OKuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0uxVwAKCRCLPIo+Aiko
 1QCuCACR5F9ArBiXX9UAqJoDRn+pFNJYOtdo3Ix28zrT5Ot32SBfkj+oBkksDinkFfP9qDcghsF
 +9DrlANcyvHqQxPLRZDGCbdW/ozVyJJxp6SVHq5eUZ/BNr2hdTx63IvJ9ULYZW1sUlQy7lA+qX8
 DtWJ0KLYNtJK7Q6OJ/wruc+tH1Ps/gRkpeYMLzfeyufJhuLnE9ZIgvsQuJrH+cnHqeqJ2j1rn+D
 BYpByJ8Xo2Mi6oN6B9Dn2juhhYluEZrxH4gc7+4kINUTvRKBN1+/f9comTbBgr4RDwV/w62HfyS
 8ka5Cv33H7fZ/JZLnCljjcGlVgs6klKVpgAsUIio7qvbFQZm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The upcoming DRM connector HDMI codec implementation is going to use
codec-specific data in the .get_dai_id to get drm_connector. Pass data
to the callback, as it is done with other hdmi_codec_ops callbacks.

Acked-by: Mark Brown <broonie@kernel.org>
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
index 61f4a38e7d2bf6905683cbc9e762b28ecc999d05..51fb9a574b4e28450b2598a92e2930ace5128b71 100644
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
index c036bbc92ba96ec4663c55cca091cd5da9f6d271..943dd3cf57738d8c232d57d793756eb2e3bf1c5a 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1952,7 +1952,8 @@ static void anx7625_audio_shutdown(struct device *dev, void *data)
 }
 
 static int anx7625_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-				       struct device_node *endpoint)
+				       struct device_node *endpoint,
+				       void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 8f25b338a8d8f95dc0691735ac6343675098f7f7..6bc1b2476847c3bccbbf9874bb384c1f60674da6 100644
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
index f89af8203c9d67cb05b629b27f66cf996baedd16..77bc09b875323d88f7346db9d24ea89a355c99b1 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -522,7 +522,8 @@ static void lt9611uxc_audio_shutdown(struct device *dev, void *data)
 }
 
 static int lt9611uxc_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-					 struct device_node *endpoint)
+					 struct device_node *endpoint,
+					 void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 9be9cc5b902594ebe6e1ac29ab8684623e336796..f0be803cc2274ca2199ed7661cf752b0a91434b6 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -815,7 +815,8 @@ static int sii902x_audio_get_eld(struct device *dev, void *data,
 }
 
 static int sii902x_audio_get_dai_id(struct snd_soc_component *component,
-				    struct device_node *endpoint)
+				    struct device_node *endpoint,
+				    void *data)
 {
 	struct of_endpoint of_ep;
 	int ret;
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 26c187d20d973dc65801a3baa59ecf57d20072eb..86c412e9cbc80bb82bad5db3aa0263a7acd9c2d7 100644
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
index 5e1a9eafd10f5d4f831abbb6f4c0fff661909584..b3407b47b4a7878532ecf3b08eeecd443d6fdb07 100644
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
index 74caae52e1273fda45ab8dd079ae800827f0231f..abd7c9b0fda9ee6fa6c4efde1f583af667716611 100644
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
2.39.5


