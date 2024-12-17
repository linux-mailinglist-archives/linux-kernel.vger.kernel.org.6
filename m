Return-Path: <linux-kernel+bounces-448356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0ED9F3F05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E9C188F1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A571474B7;
	Tue, 17 Dec 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHpf6Bu4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB201459F6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396049; cv=none; b=r9VGtRNWfr0NhxP5G07LAxnZ7PJKFvGLhIBsW0R7W5KtF5nJBm3yjqGE570xqFA6ORDy06P5XmiZjex300NeJJJhSLxXbNK5voPCjdXd1B+hdbS5HzBy85uH1SAZVSp1m83q4dUHQ2vjF3CpiHdK1Lpw02Fejv6fbBFwwEJI5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396049; c=relaxed/simple;
	bh=pAvR5YZJCNBmhdGZoqKZfJpmIHLV5ppYUTPIUoiUc9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2E0gWZAyNNhnolJbFaa0Jje3kMzXPV76J3EHusnZnqkcMHPwFlcSENHmtXGoDSmag0e6XSLoMnK2yhFBhDR7NSHwOnRqV6ULRL0499EmSoXaBaaHZaxN+LEdnPPkZM/WECyZI7/cx+9l/boIQIe0QEMdSWlk66noNJOX5Tc/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHpf6Bu4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso4967645e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734396046; x=1735000846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kk1NgVU9MqJJyiCuMa+6xWyC5169sd0WY/Qbv8YeNNg=;
        b=xHpf6Bu4YAZUWn4twa4NKfEK4XvU/XFm074+OHpljCFCJ3uowhyLJvFkL4vYLa5OAJ
         QRbAibJ501S1zFbr8neZrxaElRV9fbyh9k1Q84COp/XLD65iJzT+N73mQUZii9m9ZiYw
         XfvsR3h47MHyKLHJCGpKCgH7Baj7CyzeD+lVGTQpNx/3gJodoOIIJHNOjnzSFIvOYlFl
         skL1vrl9Ul4snF4bJltnwlqDv4i/O4AUl7H+1wgHUQx5qDpY0E6KbVzbU3pDxMQikQrH
         vDIkVNiBVVlyRuMIhcYPj0WyvyuZc8XKOVN9LBrZ9q4a35fXmotwZHKJ+O+Yyq9Lkpv+
         iBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734396046; x=1735000846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk1NgVU9MqJJyiCuMa+6xWyC5169sd0WY/Qbv8YeNNg=;
        b=w9uvW3Zpocebcd1tNE9JvJAMzSXilWxBBXd6QZSkoSyE1YCjPwt3juzb7V0bhQ8Xsz
         jbAGaOdrKFRwXOjDiizLU4xDUXGqgeNbW4O5kKDu9TUJA9llWVl8ivhPU82MaoVbpNIa
         7dEg0kp7/uHoHjnA4860fTcnH5M81BsZ6m9ZWJS4wCghUhN0RXJ2rJNI5ujDVzSZr/O5
         cADQePt0mbn2ECRRkYvrzMmrvfKVcx+vNgY/aAtsDJAAtuI4faCvxszXD4FcNm1SKoGj
         xUuoQoJVU1DmmjdTjNBsn6sBoLZPhUoswo5B0VsKYjQniJhEWEI3X7dQuGt6XQa9b+lP
         z/mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1PF8HU1YRrEk56TL//5XvTk1onQCjwcxbt7lnAgKysTsdKXKIoeSiQSGu+0lZLHbkFB3OHV/KTQG33JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3YMocuy3qd8oMLOni0SypdMeE81ZJu1BPgtONnmuX7/y6a7w
	VKslvUJ9gtWwPga3PthD13yJ9okmW+ad2OWQMRRLH10uA0n8S6DnyoBohO5wu6M=
X-Gm-Gg: ASbGncvCqSEyR5Q3kyVOhdcuREAhSQYCma4gxdN+Cei+IrficTF2q2A1qUo+ec+FlR8
	eSsItdrMhoX+G33NeOC6KYx8VU11MIa6X7XJ5gGh2UGsPSbDm155UHvEIGj8xewc9Ie9Y495/1k
	rrCp2zLv3tDBuInk9IiJMFThqStqQBVrzKZf15UbbZBe+ZqO1UpRaclqjy17Eays/qedOoZEqco
	WFogHEptdLFRkdOJVimRsJIt4rpdMO3SCCO3SPbZrokodR8sB1efu2p2sQdjNsc
X-Google-Smtp-Source: AGHT+IET2hsK0OXoi9N+0DoJgdc3STTzo/Y1LCeRb61WgG4K30Ajpfu7jwJe7zMdAQ8z86I/brROdw==
X-Received: by 2002:ac2:4c49:0:b0:540:357a:a0e9 with SMTP id 2adb3069b0e04-54090560c03mr5833698e87.31.1734396045638;
        Mon, 16 Dec 2024 16:40:45 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9ab2sm1009122e87.74.2024.12.16.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:40:45 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 17 Dec 2024 02:40:29 +0200
Subject: [PATCH v7 07/10] drm/bridge_connector: hook
 drm_atomic_helper_connector_hdmi_hotplug()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-drm-bridge-hdmi-connector-v7-7-cb9df2b6a515@linaro.org>
References: <20241217-drm-bridge-hdmi-connector-v7-0-cb9df2b6a515@linaro.org>
In-Reply-To: <20241217-drm-bridge-hdmi-connector-v7-0-cb9df2b6a515@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4204;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pAvR5YZJCNBmhdGZoqKZfJpmIHLV5ppYUTPIUoiUc9U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnYMh5ja5pCrotWtSWn+8ziDDwUoBX/oLBj0chS
 dbg/ZRFEfaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ2DIeQAKCRCLPIo+Aiko
 1Qq2B/0VnneaHJMvRwVb6YfJDzbyhliurPCaV/7H2ECjfBfZWIQuk0ftoOjwQ7d1PkhHnMUFXDK
 PmRMZ1NGkdME6oKsNuQMEwkmbCcy7AAfAGKBD+xa1xscEqY2pRGjlEy/h7QYT7d9OaCe23peZb2
 uGnH9NHBgiuSLQZt7gTSqFHQMPhbO5wJ5O8KCXfVAqD6h4aePy8j9TZU8W6nP9qlnyG6WMGcEEW
 HaVKeKuY3bjcRA/2ADaF6YAUjAsz/s/4i8S8LfTLfJwk1IUwsEnYSuI3R1ZWc8Ig8My7GZiHTfL
 LdoDZoLu/0eJ4k2FMRY/9Gv3Hw0M5jkk0fMkbYEf3v6whYxA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend drm_bridge_connector code to read the EDID and use it to update
connector status if the bridge chain implements HDMI bridge. Performing
it from the generic location minimizes individual bridge's code and
enforces standard behaviour from all corresponding drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index be46d2e7cb5cec262ca5dd6f42f8f31b0187a0f7..4bc044e73fbd8c9fa32ea11f54f268acf024f55f 100644
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
@@ -180,11 +181,15 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 	struct drm_bridge *detect = bridge_connector->bridge_detect;
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
 	enum drm_connector_status status;
 
 	if (detect) {
 		status = detect->funcs->detect(detect);
 
+		if (hdmi)
+			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
+
 		drm_bridge_connector_hpd_notify(connector, status);
 	} else {
 		switch (connector->connector_type) {
@@ -203,6 +208,16 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 	return status;
 }
 
+static void drm_bridge_connector_force(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
+
+	if (hdmi)
+		drm_atomic_helper_connector_hdmi_force(connector);
+}
+
 static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 					      struct dentry *root)
 {
@@ -231,6 +246,7 @@ static void drm_bridge_connector_reset(struct drm_connector *connector)
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
+	.force = drm_bridge_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -276,6 +292,14 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
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
@@ -368,10 +392,25 @@ static int drm_bridge_connector_write_infoframe(struct drm_connector *connector,
 	return bridge->funcs->hdmi_write_infoframe(bridge, type, buffer, len);
 }
 
+static const struct drm_edid *
+drm_bridge_connector_read_edid(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_edid;
+	if (!bridge)
+		return NULL;
+
+	return drm_bridge_edid_read(bridge, connector);
+}
+
 static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
 	.tmds_char_rate_valid = drm_bridge_connector_tmds_char_rate_valid,
 	.clear_infoframe = drm_bridge_connector_clear_infoframe,
 	.write_infoframe = drm_bridge_connector_write_infoframe,
+	.read_edid = drm_bridge_connector_read_edid,
 };
 
 static int drm_bridge_connector_audio_startup(struct drm_connector *connector)

-- 
2.39.5


