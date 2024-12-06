Return-Path: <linux-kernel+bounces-434842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C879E6BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D628F1887F55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13F20E333;
	Fri,  6 Dec 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWmtt1Mt"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD20C032
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480223; cv=none; b=rtBqABwUa8NUx9MsC08w6Jqzt0tHhHFxsHilH5DgXFmAK+ZpwRkpcqgLHsiSArt1DhAK9He+sMuzSjTkhXmUw5bNPlYWi+R0eMMjaryvJai5DeS9TRH7kpJTbGFxyWHaXyC66vEFABpuG6cSWV8zYYDY/vxEURT3OMJAaLLV+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480223; c=relaxed/simple;
	bh=mWpkFqjp1yyO8iD77i9han60egAD/evnvMAnr5hrOdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAqDemg8kw7flMaxnQnySKIC4hrP5KVGkpz1qUs3o1Hb+gClR8+GsWgFZdUya0uRsytiBX7JMM3X8t9QGPMjHXI3X/9gRhlhaW7EBoKUN2U3f3AMH1jwk8wiPEGqsJG1uVB5brIS31MByovKHtg/M0joZel6S98E9Uhyt5nGOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWmtt1Mt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e3778bffdso220593e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733480219; x=1734085019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unYAkXaFAf42yLsiWl79k+U7AAWsXSetaGBwV9Nyen4=;
        b=dWmtt1Mt/ZF1LYcQpHG9u1Xo7Kdnso3Fw9+fbGy8Urs7m0oMYyyBklV9z8mdChoE+v
         QtrVnb529YmnsWBoJmxWvMdmtOyM3NY4SvUz8Ntsv2Q1m6boM0bgN7QTZ0r23ePP9NSy
         q80asJ6g6XJOgeDcPDqIradsE6GLp/C7AeqRHXF2gniy5y7DW1dKRomh4OH0wm2hJoeh
         7/XmAR0FKhIbhR/6Am+xRGZudUWjgQ2HGCmmTIDGqAIQfogtFW8xCg+KPy7CKpBxFfQ3
         gM3yE+BZI96m4DHwzs3vH6pSgAsPFOR2G+agualgpiMMb7jx3J+uoVjxWoQKjIEwYiWh
         XgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733480219; x=1734085019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unYAkXaFAf42yLsiWl79k+U7AAWsXSetaGBwV9Nyen4=;
        b=RUOTsDd1U2VLuJHTLJjG1kz7qz1TJOjkYcye1r0fbugpPI5WqBHBX9ARtjttOBu4xF
         AEIcwuAO6M6v7W6gSBgoYZzK0BHnTWtU9LIpfaR8ljUze1P+z+qfsCF95JPWy851/o/E
         SXo1mJijXj31UCe0Wkn9qPQ5cp6jHe9YJgzsn6BuAOEu8Qgy5EHLhx5XF0sLuLHAz7/X
         DZfuEB7yckO9pmHcSqdvARbGrIk1XEOFtVs0OKRPOLAJ8lWaJu9ar42Sz7s2V2+Gk49A
         affHdtI24xRYCjqvzDvSmuddiC2ErBMeM/ueBQ9A9etbtCCeWlJy+00Zpdha27X+olHL
         2xJw==
X-Forwarded-Encrypted: i=1; AJvYcCXQRxsYxXuCAkxHjuGHVKwDEJURcmKg5d10mAEIvpOWwueUBcSxtEVW1oDWfTfcIJnvvvxmb4SMPkambL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VMI+0wCuS8UDzRoWyMdgRuRph/qkVDPHy0Gd6HrnBo1UgYVb
	qQ9YZ9tstvbsCWljqm0i5e5EZ0tZmy0wI+fy+upxH1cNRdOQ7DtO+eKpgq7OrlA=
X-Gm-Gg: ASbGncsQqY3/T6J+53YfR5TzMxAOdhGZV1KB6gMO3qpCloWCDEYXdNEZV4JE/AVoEmO
	UqWNG68t7bJJOO1VDp7c/J17cjzSeJm9MMCJxIy3pMnpA8ghFrBIm81GyJ5LOKz2XLGuztI58SV
	pBxueLQbLYKzCyXMA0Kximb0X6qEeYpBFTh4GkIhsihEoBmctdIwZfnrhCwsH0ksnp9hWpPZNGr
	ZXB1YegZumB1sMwjbPp9nR1tNaHXT8yT4kcRB0af0vR8lkzEWoAF7ZBvQ==
X-Google-Smtp-Source: AGHT+IH8kc6+cltsERv2tTI87w9RpzrI/Uxd36n75mjO1x7LsaWpJdqUf3dwGEmcu3AmNY3dvipvnQ==
X-Received: by 2002:a05:6512:3c82:b0:53e:1bb7:588b with SMTP id 2adb3069b0e04-53e2c303797mr785196e87.44.1733480219213;
        Fri, 06 Dec 2024 02:16:59 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2294738fsm462355e87.52.2024.12.06.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:16:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 12:16:01 +0200
Subject: [PATCH v6 07/10] drm/bridge_connector: hook
 drm_atomic_helper_connector_hdmi_hotplug_edid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-bridge-hdmi-connector-v6-7-50dc145a9c06@linaro.org>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
In-Reply-To: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mWpkFqjp1yyO8iD77i9han60egAD/evnvMAnr5hrOdc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUs8JXoJleVeXT84oS2M6AvDZrSRqHGCIJXg/5
 lKSomHX+x6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LPCQAKCRCLPIo+Aiko
 1f/YB/41OkBVU1XNEzkbG3DFY23S7DFi6wn2p8ZEfwQDqQLsyhZyNih+ddfBVpgTUXQvmrBZq8m
 jEoBlwO6SyUFPTywjLRGEna/tCKshIaqoAP8bnj8L6rSMqfhmrLqUH66F7UYeIjwGGE0uE2JGRy
 f+WlCpQUacATeokiK7MFZVVHK4lACJtBnqABGrh1qEuBurO2OPyoDaHl8qncLNKcFYORUqQGUDF
 5v7R06MJ22XXDshojT4piLRisvT1R3QxDA5xO6/+mZScp0e6U306TQvzKyV0Z034+8I07KtdgIZ
 lmUAoiLMZF2w/xvIwsLBKtV6o/962J/nSm2NMiY85RFQDbNh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend drm_bridge_connector code to read the EDID and use it to update
connector status if the bridge chain implements HDMI bridge. Performing
it from the generic location minimizes individual bridge's code and
enforces standard behaviour from all corresponding drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 4fa1bb73d430d02d5b79a1a184c203ec9e9c66e7..0ff82900bd07933e292948446b9637ebf2076694 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -17,6 +17,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
@@ -182,11 +183,29 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *detect = bridge_connector->bridge_detect;
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
 	enum drm_connector_status status;
 
 	if (detect) {
 		status = detect->funcs->detect(detect);
 
+		if (hdmi) {
+			const struct drm_edid *drm_edid;
+			struct drm_bridge *bridge;
+			int ret;
+
+			bridge = bridge_connector->bridge_edid;
+			if (!bridge)
+				return status;
+
+			drm_edid = drm_bridge_edid_read(bridge, connector);
+			ret = drm_atomic_helper_connector_hdmi_hotplug_edid(connector, status, drm_edid);
+			if (ret)
+				drm_warn(connector->dev, "updating EDID failed with %d\n", ret);
+
+			drm_edid_free(drm_edid);
+		}
+
 		drm_bridge_connector_hpd_notify(connector, status);
 	} else {
 		switch (connector->connector_type) {
@@ -278,6 +297,14 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *bridge;
 
+	/*
+	 * If there is a HDMI bridge, EDID has been updated as a part of
+	 * the .detect(). Just update the modes here.
+	 */
+	bridge = bridge_connector->bridge_hdmi;
+	if (bridge)
+		return drm_edid_connector_add_modes(connector);
+
 	/*
 	 * If display exposes EDID, then we parse that in the normal way to
 	 * build table of supported modes.

-- 
2.39.5


