Return-Path: <linux-kernel+bounces-269591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6094349D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CD61C2385D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A61BD4E4;
	Wed, 31 Jul 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="En1ua2B4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4EA12B8B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445256; cv=none; b=Icm8SHV+xhm10g2wL+ova+p/doVQBtOl4Iky4oxBpB6ZRIC5k+eNaYKbZBLEw+/Ds52ylHWJeqIa4DX4VYcGxf8YgXjNMQTynSqVrkK8tdpiiaF52mhLtE3ZC0H32yeWJRhopjicS25gCjH14kC2vnD9fnTJFpkvYcelDvxMWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445256; c=relaxed/simple;
	bh=rQaVG/O25AerGy2gOaY8XL7CTvpz0JJwpNoEJXB80TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skDMXbC2UWw+0xYQtoBpoZyMlqRVeoBt05FVAvXl946HHiDOWbFuErgewczc1ypjIHb8PQRU5amrqD23AR0/PL0ifZl6BncmYe51g40Lw95gJI8LVQeyGqFIDZiT+wZcBRneTsJ7JHAJ4xJpb82WUSKR5KOdk/iSi0MUD8Xoq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=En1ua2B4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722445249;
	bh=rQaVG/O25AerGy2gOaY8XL7CTvpz0JJwpNoEJXB80TY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=En1ua2B4t6o6KKMCIr8w5/9rTs4IM6+m6dhQ9SqHfnN/VORWqNLMG7PhKj6AEHHz8
	 v1tyRP8rJrHDd/ttf/dbtIZ+h1nFtAb9aTY1DjWUi84h3eU3QTclIHQWPFaHyNijVZ
	 mYN2fFcgl6A3r8Qj4SWE6UeEnEgAaR7cb6vvUxQA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 31 Jul 2024 19:00:46 +0200
Subject: [PATCH v3 1/2] drm/connector: add
 drm_connector_get_cmdline_min_brightness_override()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-amdgpu-min-backlight-quirk-v3-1-46d40bb21a62@weissschuh.net>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
In-Reply-To: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445249; l=2611;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rQaVG/O25AerGy2gOaY8XL7CTvpz0JJwpNoEJXB80TY=;
 b=+3iwRZMLJ9s+ZBHbrf2ZfwWi7C4r4hwIkIIf9rLDxZtzQq2crujBBzQA4QtGx8HvF/5LqHJiQ
 d85gOQcvIjHDNLs7/0/Fyigf5g5FkDZlTmISEHV/A31ZHoqBbmD2xTk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a helper which can read a overridden minimum backlight value from the
kernel cmdline.
This is useful if the minimum backlight as reported by machines VBT
does not match the user expectations.

As an example, the minimum backlight brightness on the Framework 13
matte panel is too high.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/drm_connector.c | 34 ++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ab6ab7ff7ea8..d0b3d5d6c7c2 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -34,6 +34,7 @@
 #include <drm/drm_utils.h>
 
 #include <linux/property.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #include <video/cmdline.h>
@@ -3399,3 +3400,36 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 	return tg;
 }
 EXPORT_SYMBOL(drm_mode_create_tile_group);
+
+/**
+ * drm_connector_get_cmdline_min_brightness_override - read an overridden
+ * minimum brightness value from the cmdline
+ * @connector: connector to query
+ *
+ * Read an minimum brightness override from the kernel cmdline if present.
+ * The parameter takes the form "video=CONNECTOR_NAME:min-brightness=VALUE".
+ *
+ * RETURNS:
+ * negative error or override value in the range [0, 255]
+ */
+int drm_connector_get_cmdline_min_brightness_override(struct drm_connector *connector)
+{
+	const char *option, *value_str;
+	int err;
+	u8 val;
+
+	option = video_get_options(connector->name);
+	if (!option)
+		return -ENOENT;
+
+	value_str = option + str_has_prefix(option, "min-brightness=");
+	if (value_str == option)
+		return -EINVAL;
+
+	err = kstrtou8(value_str, 10, &val);
+	if (err)
+		return err;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(drm_connector_get_cmdline_min_brightness_override);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c754651044d4..64d86604cc6e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2357,6 +2357,8 @@ bool drm_connector_has_possible_encoder(struct drm_connector *connector,
 					struct drm_encoder *encoder);
 const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
+int drm_connector_get_cmdline_min_brightness_override(struct drm_connector *connector);
+
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
  * @connector: &struct drm_connector pointer used as cursor

-- 
2.46.0


