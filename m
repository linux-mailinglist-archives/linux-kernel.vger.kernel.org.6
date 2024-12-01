Return-Path: <linux-kernel+bounces-426515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C819DF44C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA13B219ED
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58E67083D;
	Sun,  1 Dec 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9LAqa8L"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426B7080F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733013879; cv=none; b=AuerKQxEJesr3pz3LE4pK0kD44JIAXQCltSOAR5DGO+NPwG+R4R2WlA1X6+gxnLpmoAnhLZFAqrDkje7xrR7kQqe6b2zCA0XHUs0+D34ZbdEvl5ueXSnrbexQnHLRLXSbwe8+Cm/Usp9f6oVK8KzOj0eFslAkMt7it7U/BYUiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733013879; c=relaxed/simple;
	bh=yRmYAaGG5FuJnzbiAwK+r8Wa4ofx1aRyHEGe3Ks/gxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrUi+UuN4n1BNrqe8uV3dNn/D+bE7G5z9O46gi3PvZEkD0+2SyWGwMDEzEwNpXBglhDRB7OQ/UpyWXNCYNk/DTMX4M9bdXTFnr3UXb7hI94cpfaiE/CGfyCCiNwG+eov0uazUJmcE26zhpokEoWxhCh/x1EIjeZKNioaABEnh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9LAqa8L; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso3550664a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733013875; x=1733618675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+2GniAkdmp4BwJcsCVeiFyEwNMIk2x1tb1O8W07KrE=;
        b=Q9LAqa8L4qcYeXDVC3cLyrRM4FN50xDTRozZlsjZ5iA1UiUYztTbGd5lVbC71EIBcH
         YLEHW7j1aI8f/H+C9gmTnG20JiETjCC65QbW9koUCcDr1t74gBaDDQ3u6rewyLNIV0JN
         R6yOux0GljRJdXVHkgUliVggCU/hz2BVzuQLJZGeLCtomaoerqy2ae1DeckSFLa/IaME
         wM11Iw0VA2VCje9MaUJJOvomoof7Fc648QSpRohB+Myt7sLjByYF+nuQybaceK4NyPUO
         raYUUI+IzO+lBWFhmp3P1K1XcmUQ/HJ5Bi5Bd8/GvdWZpuvtZWngd0xwU8yadu+rBDzq
         uU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733013875; x=1733618675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+2GniAkdmp4BwJcsCVeiFyEwNMIk2x1tb1O8W07KrE=;
        b=Fkanz615nf2EYx1/oS9uBKimrjWx7H7qa0xvDfWGN424/hWBkhC/UpztYVKck8Pivo
         o6xayAG+0DX6RVyJqd9FfGxxi2DreikGvysiz7BYTybBHb7S89TwqexE38xB2SLaUymM
         ZlOBi6DXS4IEI/nwhj/BuU27hmNPlsck5jfhAtXhCsRc5Ih2N7s+3NY+6j6JR8/dDr9e
         ahsj9DrbXhrbYC6OreucGIgD4d67O7kkFt2Byejpae3o2qy/AniTPQFF6vgClodD8KMR
         /nVrVtpf9NRWX7NL8x7IcsaUwFvi7cH+pg4BjEKU/D0VGFFOr+vLnLX7bDTw6eHpXSys
         PlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQLprVmCiQKMYHnms6UMRjMxPaiz6RhVO/pqaMmoFu9iKkLqOYah+LW8dDhtkd9DY2su5uDwQ7aHKgQrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMhEJohkIXjQbCRNk5VHQArA4KHYBjCMSo3yOugkNVvZIFtN9
	tDU627hivxEwjpR49yR2xl9+GTrgQjtdTXP+s2ObOS1jiXwqvom7mrYC33hEibw=
X-Gm-Gg: ASbGncvuSEGh7IBAv1qD4NOkZcDchLB4e3M1Z4PzIm+YTRurMpfIIFBObLQb6qXFVxz
	gKsnJaUScuwvqTG5atJ/Yp+cLbsC3rPsBsYR2ZXchsPKU8ntPdHBcUtWYo7qf/mmghbrS1dXEo4
	nJzW0jLhFYLTcaLv9B3UV0/kREI+IAJE5HwLHaougRBuaEt/iIG6rxwM63FtNZxTRhYHKtHk0HS
	Wla5nNFiYoEYeJeSSvtwdlJ9YubcrOXi98lfgGlt7SHOx0Cra0BLqcUtw==
X-Google-Smtp-Source: AGHT+IEQE3aFNcx/37qoHBi5BMr3sqVY3NtBCKtfjfV7wHKGekaptxA3m+vL9XUBY/7vfCR2ueAcgA==
X-Received: by 2002:a05:6402:3225:b0:5d0:b7c5:c3fc with SMTP id 4fb4d7f45d1cf-5d0b7c5c655mr10108773a12.3.1733013875542;
        Sat, 30 Nov 2024 16:44:35 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8d817sm3400359a12.63.2024.11.30.16.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 16:44:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 02:44:11 +0200
Subject: [PATCH v5 7/9] drm/bridge_connector: hook
 drm_atomic_helper_connector_hdmi_update_edid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-bridge-hdmi-connector-v5-7-b5316e82f61a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=yRmYAaGG5FuJnzbiAwK+r8Wa4ofx1aRyHEGe3Ks/gxw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS7FY195bWef1JWzfBClWB4oHD1yzTC9EFWMzD
 80mNHc4qGeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0uxWAAKCRCLPIo+Aiko
 1WzCB/9dbK/ZL6sq0Z7J3uaSWrvo3v868opAAukc6WNxiaV18XuCxz1ddbnDi63j79YdQb5B8GP
 D0KYTNeGLC5UNMe6kDdKQJdRdGu7ziyexcz8z0ahYZ9B7SzemDlaGs9gLyk0P9W5R368lIIu/Se
 Bn49wArWPZi4BhJHy1u6QiBWJM9uNBWvGsUqnu329vDvgUYww9US9Iuif3+7YTjhkYVtT8N7avI
 woTrJfPaHazIr/m+2iKsIgFy6NXIiGqDUgLWv80FAnpxXW5sX25muyz7cAXbC28cNDik6ZPCIYy
 pgiATl7OmZDXqwI8VuDxI8l378ZDecWH//5U6eNsb1he4Mh6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend drm_bridge_connector code to read the EDID and use it to update
connector status if the bridge chain implements HDMI bridge. Performing
it from the generic location minimizes individual bridge's code and
enforces standard behaviour from all corresponding drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 67 ++++++++++++++++++++------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 12ab9f14cc8a8672478ae2804c9a68d766d88ea5..71ae3b2c9049016d1cc0d39a787f6461633efd53 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -17,6 +17,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
@@ -175,17 +176,55 @@ static void drm_bridge_connector_disable_hpd(struct drm_connector *connector)
  * Bridge Connector Functions
  */
 
+static const struct drm_edid *
+drm_bridge_connector_read_edid(struct drm_connector *connector,
+			       enum drm_connector_status status)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	const struct drm_edid *drm_edid;
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_edid;
+	if (!bridge)
+		return NULL;
+
+	if (status != connector_status_connected)
+		return NULL;
+
+	drm_edid = drm_bridge_edid_read(bridge, connector);
+	if (!drm_edid_valid(drm_edid)) {
+		drm_edid_free(drm_edid);
+		return NULL;
+	}
+
+	return drm_edid;
+}
+
 static enum drm_connector_status
 drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *detect = bridge_connector->bridge_detect;
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
 	enum drm_connector_status status;
 
 	if (detect) {
 		status = detect->funcs->detect(detect);
 
+		if (hdmi) {
+			const struct drm_edid *drm_edid;
+			int ret;
+
+			drm_edid = drm_bridge_connector_read_edid(connector, status);
+			ret = drm_atomic_helper_connector_hdmi_update_edid(connector, drm_edid);
+			if (ret)
+				drm_warn(connector->dev, "updating EDID failed with %d\n", ret);
+
+			drm_edid_free(drm_edid);
+		}
+
 		drm_bridge_connector_hpd_notify(connector, status);
 	} else {
 		switch (connector->connector_type) {
@@ -246,29 +285,29 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 static int drm_bridge_connector_get_modes_edid(struct drm_connector *connector,
 					       struct drm_bridge *bridge)
 {
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
 	enum drm_connector_status status;
 	const struct drm_edid *drm_edid;
-	int n;
 
 	status = drm_bridge_connector_detect(connector, false);
 	if (status != connector_status_connected)
-		goto no_edid;
+		return 0;
 
-	drm_edid = drm_bridge_edid_read(bridge, connector);
-	if (!drm_edid_valid(drm_edid)) {
+	/* In HDMI setup the EDID has been read and handled as a part of .detect() */
+	if (!hdmi) {
+		drm_edid = drm_bridge_connector_read_edid(connector, status);
+		if (!drm_edid) {
+			drm_edid_connector_update(connector, NULL);
+			return 0;
+		}
+
+		drm_edid_connector_update(connector, drm_edid);
 		drm_edid_free(drm_edid);
-		goto no_edid;
 	}
 
-	drm_edid_connector_update(connector, drm_edid);
-	n = drm_edid_connector_add_modes(connector);
-
-	drm_edid_free(drm_edid);
-	return n;
-
-no_edid:
-	drm_edid_connector_update(connector, NULL);
-	return 0;
+	return drm_edid_connector_add_modes(connector);
 }
 
 static int drm_bridge_connector_get_modes(struct drm_connector *connector)

-- 
2.39.5


