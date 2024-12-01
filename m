Return-Path: <linux-kernel+bounces-426514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634619DF44A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D292815CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719041C79;
	Sun,  1 Dec 2024 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apCIiU9r"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DF4D8A3
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733013875; cv=none; b=mkLdSEHaJpuLumQiFXyMooy0DuH1e2rUJOCLNxQ/NOQ548/X4/HimUJwJxt91K28yoY08wLkR+nWTnYQfWwO5UJAOg8rWa9DQ47YHdfEJtMGHOSdZE6fbNeX4wWrAtvKFVH7/UqZyw4jV8YDcIKCTjDflo82s8FMqY6/CBjASb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733013875; c=relaxed/simple;
	bh=h4SDlLdLeTf2M3phGYhMa3icgLWVQxFU2Yi+KA0yVFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZK00CvZWR93+J7zC+QRg/dwGSmRcMQy7H6LKfSkiTKESDWQYPilpN3XEh/Kp+/BPqs94nwvQXlBQSlHnsQw3wPge6N1G8nYXJnE9VZS+lBXWCaKBS5vmmOwS829jpB7XLdGAYwWND+QG3ysPgLJUHO9iuQvION3sBy7rHOUgk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apCIiU9r; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa52a5641f8so428099966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733013872; x=1733618672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AekznUw/DJYmSVBNFKXzyv34fWwrWZN8k5LwtkQDlbE=;
        b=apCIiU9rurOO4UqNAKBO63Q5xrzwW3FHiVCAIzIY5LbeZJBiX4HU4OOBfG67zlQf8a
         k7Au+Epn2Ow0Zov1X01JW7/d0x8ftBuaNyH1KE7wk8TfRXUsA0Z42anLlvMnG0nYgITl
         9at9Gi4hR5jDjUUFYkiD0EeDl2CalHQj/m9qa93rRCYoRSVHduELsRgMtYedGf8oH4mb
         wkiT6FCqmQ4UtMVjd/JjRwpSE+glkZu2Sjjm7ATzXIfOmW288xlDLwU4YwHjoUvd0uOw
         ED8lHQcX7b/wLVx7myZ705U8zVEnG/BbV122Z8ALb64uJ1n5IjBKXDWJ4s86Qa+lz+3+
         l8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733013872; x=1733618672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AekznUw/DJYmSVBNFKXzyv34fWwrWZN8k5LwtkQDlbE=;
        b=nlB3slTgCHy84t9sjQYtGmOFXLXvgEJFWhUyk8J01XT4T6Z3zTz2I/no4fIIYYcxq+
         pD3q/TyF7Jf2BPgqt+oPYY3V19qC+g9oX50josRFJQM/3dFEzgBUc9djZRiGIFfruaXS
         vRZ/l/CRAiYjYkuy96+zKwlVFV/cueQo5XGNZvkJJ06YSMKA7w1ooGx3JALH2BwYIOO1
         YRNacyc3pMgIhjPtTyfrT4ffv/kfW3WGhu+Ps2T51o7qdi4eCJHfuBwqbhV9zFqNtNTj
         feRZs5wcQSZ1Y2PN5PAteyDwG79e7w6Fk8bfkbpT36T+MSCRWi4lR5aqAEANmaxIX06F
         qNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsUOFLY1j12UMvOHnhgqLWzOFG9fJ2DRkyGaftwCPWA6ORSFnVHE+WkBhosrvpAKHcepJGmgQYPJ5M8qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdw91YFUwWsEgMo4dAXJfioaymwbQJuekxFQzAb/Dx1oApJds
	vuBCdEwg3QDgizI4ZGBA6lc4a9kBBHKAKHYSKbMjQbVqEbrqkdhBApbOCI337gM=
X-Gm-Gg: ASbGncvEy9tGEeChh6tMz2wueeepVkfYaNPGsYXDD+qVDBq0P4zpEg8TU5RQRMShPvg
	foYabICHaWtC6wN6Hs/xQ0kIszNjLnLQuv0nnc1cxdy92xavoU7fZF8gNGdKiWZcijzjab9vEhT
	sbnuAeULXSPgeA+UsRmM6yzLLoJv88GciC+5gtUN8vYLIYiFgVP/6t18X8YoDD6W6Ay2xWpiA5M
	yJ0HB/cfIOUeeEPEpnIsIH2XNdXiRru19YvDL3f08ncgJEmecigM1Czxw==
X-Google-Smtp-Source: AGHT+IF0K77MkwwvldGVr80BjUwOmELL9E07KeKBaGPCRtOUdN8bdaAj3EzrCh/1BXcCeTTEMCnHgA==
X-Received: by 2002:a17:906:23ea:b0:a9e:b281:a212 with SMTP id a640c23a62f3a-aa581073993mr1476511666b.51.1733013872041;
        Sat, 30 Nov 2024 16:44:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8d817sm3400359a12.63.2024.11.30.16.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 16:44:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 02:44:10 +0200
Subject: [PATCH v5 6/9] drm/display/hdmi: implement connector update
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-bridge-hdmi-connector-v5-6-b5316e82f61a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4091;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h4SDlLdLeTf2M3phGYhMa3icgLWVQxFU2Yi+KA0yVFA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7r3xggGN//LkX2OGwV+txgy3vuXMVki+fujBVtzTye9y
 q9pS1zVyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFN4eIUgBt9joOh27iqbFpIUtNcDtZZ
 E+VVG5nEZcsFbRfqPXNbWnZNvPuYgbuBgYfj2QflllV+25J428zve53mfPtNiu2apdg+hYVyKu3
 tDnuf/9SNNzN6aPNWhd3pxJxr2pmXj5/bpHLHW6lDU/vHgkkTfUu8+FxbDGf9emDpc7VG9oRJgO
 ocyb/JNx6LTnOwza+17atl/3Ph/LIwkwVyoQ5RUTO0I5ru/ubcv44l812kxC82CeP93+oLlmT4/
 VST2sex6/TfE8yXfjw7+idpwjOV2Rd1nDpmLZNKjVnwvGrat0L7O7m3whMOPIrufzLpqaN3167E
 gKWqSpybPTTdG+zz2zYmPj2q82lhYu9bwzXv6g2WsQAA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The HDMI Connectors need to perform a variety of tasks when the HDMI
connector state changes. Such tasks include setting or invalidating CEC
address, notifying HDMI codec driver, updating scrambler data, etc.

Implementing such tasks in a driver-specific callbacks is error prone.
Start implementing the generic helper function (currently handling only
the HDMI Codec framework) to be used by driver utilizing HDMI Connector
framework.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 59 +++++++++++++++++++++++++
 include/drm/display/drm_hdmi_state_helper.h     |  5 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index feb7a3a759811aed70c679be8704072093e2a79b..2230b7fc92cfee46a9cad2479edce71822d30934 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -748,3 +748,62 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
+
+/**
+ * drm_atomic_helper_connector_hdmi_update_edid - Update the HDMI Connector basing on passed EDID
+ * @connector: A pointer to the HDMI connector
+ * @drm_edid: EDID to process
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * and .force() callbacks, updating the HDMI-specific connector's data. Most of
+ * the drivers should be able to use @drm_atomic_helper_connector_hdmi_update()
+ * instead.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int
+drm_atomic_helper_connector_hdmi_update_edid(struct drm_connector *connector,
+					     const struct drm_edid *drm_edid)
+{
+	drm_edid_connector_update(connector, drm_edid);
+
+	if (!drm_edid) {
+		drm_connector_hdmi_codec_plugged_notify(connector, false);
+
+		// TODO: also handle CEC and scramber, HDMI sink disconnected.
+
+		return 0;
+	}
+
+	drm_connector_hdmi_codec_plugged_notify(connector, true);
+
+	// TODO: also handle CEC and scramber, HDMI sink is now connected.
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_edid);
+
+/**
+ * drm_atomic_helper_connector_hdmi_update - Update the HDMI Connector after reading the EDID
+ * @connector: A pointer to the HDMI connector
+ *
+ * This function should be called as a part of the .detect() / .detect_ctx()
+ * and .force() callbacks, updating the HDMI-specific connector's data.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int
+drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector)
+{
+	const struct drm_edid *drm_edid;
+	int ret;
+
+	drm_edid = drm_edid_read(connector);
+	ret = drm_atomic_helper_connector_hdmi_update_edid(connector, drm_edid);
+	drm_edid_free(drm_edid);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 2d45fcfa461985065a5e5ad67eddc0b1c556d526..61c43e744051886ba5f2024197fcc90688670ebe 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -6,6 +6,7 @@
 struct drm_atomic_state;
 struct drm_connector;
 struct drm_connector_state;
+struct drm_edid;
 struct hdmi_audio_infoframe;
 
 void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
@@ -20,4 +21,8 @@ int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_state *state);
 
+int drm_atomic_helper_connector_hdmi_update_edid(struct drm_connector *connector,
+						 const struct drm_edid *drm_edid);
+int drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector);
+
 #endif // DRM_HDMI_STATE_HELPER_H_

-- 
2.39.5


