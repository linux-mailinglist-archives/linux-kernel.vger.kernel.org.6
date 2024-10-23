Return-Path: <linux-kernel+bounces-377996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C289AC9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D0CB2144F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B61AC43A;
	Wed, 23 Oct 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNTArFO/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512F1ABECF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685531; cv=none; b=m+ATKHFOBiB2D858ysQrt1Wh/IZCM4ZlJa5WzDMWSjjIzEBLnjmf1G5eYWYGPOr6dfKE4UAye7mxfz6/+64c/erhPNs9QTvJlfC+9BzrfWIscASCdQgBg56Xj7TwrOo1pbcVfJ6c7Ui5+JoEpZelqo/mzGdJJ45KiiCTAc3rJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685531; c=relaxed/simple;
	bh=/Gf2LIqNexLzu30+4xn2vJdcOtdpuJZPBuBdL1Thgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGSmUuJgv95PJzkeUs4H0PMrVcvbdDPgz9O3nRgSmVniQcTiKJSba1wSg+36WvI5AWWGtcL6MIo2G5C0f2eljWwa7fusdTsV5Fm2UO6m6OA6UyisbfDs6lgc6rghKlOM6r8qcZAzzK3mO9xhPH1Ams3lRgmK0hhFZUCkN1i+ZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNTArFO/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729685527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIpYBuXyD6MCN4VdRQGpnc2Gpnpeu3hdLsiBcTP25+I=;
	b=QNTArFO/TcTBSdWQxuvQ3J7E32CCN35dAIGuSluAdi56Qvz+fEasTq6mKrkTaCN0crb7DH
	i3J4yxlfJ30xFOtjcg3Fq7rqD/gCbLgpmEyvD7uOKdeHFRoatY4knzKiw4UtL6CTaYT/3W
	NTUk9chkTQx6UZnkva0LQTl+h3PiLN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-pngqWbe2Pzia-vs0HfrgUg-1; Wed,
 23 Oct 2024 08:12:04 -0400
X-MC-Unique: pngqWbe2Pzia-vs0HfrgUg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FDA1955F3F;
	Wed, 23 Oct 2024 12:12:02 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25B77300018D;
	Wed, 23 Oct 2024 12:11:57 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v5 1/6] drm/panic: Move drawing functions to drm_draw
Date: Wed, 23 Oct 2024 14:00:09 +0200
Message-ID: <20241023121145.1321921-2-jfalempe@redhat.com>
In-Reply-To: <20241023121145.1321921-1-jfalempe@redhat.com>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move the color conversions, blit and fill functions to drm_draw.c,
so that they can be re-used by drm_log.
drm_draw is internal to the drm subsystem, and shouldn't be used by
gpu drivers.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v5:
 * Export drm_draw symbols, so they can be used if drm_client_lib is built as module.


 drivers/gpu/drm/Kconfig     |   5 +
 drivers/gpu/drm/Makefile    |   1 +
 drivers/gpu/drm/drm_draw.c  | 223 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_draw.h  |  56 ++++++++
 drivers/gpu/drm/drm_panic.c | 247 ++++--------------------------------
 5 files changed, 308 insertions(+), 224 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5504721007cc1..3f16dca0b6643 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -102,10 +102,15 @@ config DRM_KMS_HELPER
 	help
 	  CRTC helpers for KMS drivers.
 
+config DRM_DRAW
+	bool
+	depends on DRM
+
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
 	depends on DRM
 	select FONT_SUPPORT
+	select DRM_DRAW
 	help
 	  Enable a drm panic handler, which will display a user-friendly message
 	  when a kernel panic occurs. It's useful when using a user-space
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 463afad1b5ca6..68a0a679a7b93 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -91,6 +91,7 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += \
 	drm_privacy_screen_x86.o
 drm-$(CONFIG_DRM_ACCEL) += ../../accel/drm_accel.o
 drm-$(CONFIG_DRM_PANIC) += drm_panic.o
+drm-$(CONFIG_DRM_DRAW) += drm_draw.o
 drm-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_qr.o
 obj-$(CONFIG_DRM)	+= drm.o
 
diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
new file mode 100644
index 0000000000000..13b9760bdb632
--- /dev/null
+++ b/drivers/gpu/drm/drm_draw.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/*
+ * Copyright (c) 2023 Red Hat.
+ * Author: Jocelyn Falempe <jfalempe@redhat.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/iosys-map.h>
+#include <linux/types.h>
+
+#include <drm/drm_fourcc.h>
+
+#include "drm_draw.h"
+
+/*
+ * Conversions from xrgb8888
+ */
+
+static u16 convert_xrgb8888_to_rgb565(u32 pix)
+{
+	return ((pix & 0x00F80000) >> 8) |
+	       ((pix & 0x0000FC00) >> 5) |
+	       ((pix & 0x000000F8) >> 3);
+}
+
+static u16 convert_xrgb8888_to_rgba5551(u32 pix)
+{
+	return ((pix & 0x00f80000) >> 8) |
+	       ((pix & 0x0000f800) >> 5) |
+	       ((pix & 0x000000f8) >> 2) |
+	       BIT(0); /* set alpha bit */
+}
+
+static u16 convert_xrgb8888_to_xrgb1555(u32 pix)
+{
+	return ((pix & 0x00f80000) >> 9) |
+	       ((pix & 0x0000f800) >> 6) |
+	       ((pix & 0x000000f8) >> 3);
+}
+
+static u16 convert_xrgb8888_to_argb1555(u32 pix)
+{
+	return BIT(15) | /* set alpha bit */
+	       ((pix & 0x00f80000) >> 9) |
+	       ((pix & 0x0000f800) >> 6) |
+	       ((pix & 0x000000f8) >> 3);
+}
+
+static u32 convert_xrgb8888_to_argb8888(u32 pix)
+{
+	return pix | GENMASK(31, 24); /* fill alpha bits */
+}
+
+static u32 convert_xrgb8888_to_xbgr8888(u32 pix)
+{
+	return ((pix & 0x00ff0000) >> 16) <<  0 |
+	       ((pix & 0x0000ff00) >>  8) <<  8 |
+	       ((pix & 0x000000ff) >>  0) << 16 |
+	       ((pix & 0xff000000) >> 24) << 24;
+}
+
+static u32 convert_xrgb8888_to_abgr8888(u32 pix)
+{
+	return ((pix & 0x00ff0000) >> 16) <<  0 |
+	       ((pix & 0x0000ff00) >>  8) <<  8 |
+	       ((pix & 0x000000ff) >>  0) << 16 |
+	       GENMASK(31, 24); /* fill alpha bits */
+}
+
+static u32 convert_xrgb8888_to_xrgb2101010(u32 pix)
+{
+	pix = ((pix & 0x000000FF) << 2) |
+	      ((pix & 0x0000FF00) << 4) |
+	      ((pix & 0x00FF0000) << 6);
+	return pix | ((pix >> 8) & 0x00300C03);
+}
+
+static u32 convert_xrgb8888_to_argb2101010(u32 pix)
+{
+	pix = ((pix & 0x000000FF) << 2) |
+	      ((pix & 0x0000FF00) << 4) |
+	      ((pix & 0x00FF0000) << 6);
+	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
+}
+
+/**
+ * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
+ * @color: input color, in xrgb8888 format
+ * @format: output format
+ *
+ * Returns:
+ * Color in the format specified, casted to u32.
+ * Or 0 if the format is not supported.
+ */
+u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_RGB565:
+		return convert_xrgb8888_to_rgb565(color);
+	case DRM_FORMAT_RGBA5551:
+		return convert_xrgb8888_to_rgba5551(color);
+	case DRM_FORMAT_XRGB1555:
+		return convert_xrgb8888_to_xrgb1555(color);
+	case DRM_FORMAT_ARGB1555:
+		return convert_xrgb8888_to_argb1555(color);
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_XRGB8888:
+		return color;
+	case DRM_FORMAT_ARGB8888:
+		return convert_xrgb8888_to_argb8888(color);
+	case DRM_FORMAT_XBGR8888:
+		return convert_xrgb8888_to_xbgr8888(color);
+	case DRM_FORMAT_ABGR8888:
+		return convert_xrgb8888_to_abgr8888(color);
+	case DRM_FORMAT_XRGB2101010:
+		return convert_xrgb8888_to_xrgb2101010(color);
+	case DRM_FORMAT_ARGB2101010:
+		return convert_xrgb8888_to_argb2101010(color);
+	default:
+		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
+		return 0;
+	}
+}
+EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
+
+/*
+ * Blit functions
+ */
+void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u16 fg16)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+				iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, fg16);
+}
+EXPORT_SYMBOL(drm_draw_blit16);
+
+void drm_draw_blit24(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			u32 off = y * dpitch + x * 3;
+
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
+				/* write blue-green-red to output in little endianness */
+				iosys_map_wr(dmap, off, u8, (fg32 & 0x000000FF) >> 0);
+				iosys_map_wr(dmap, off + 1, u8, (fg32 & 0x0000FF00) >> 8);
+				iosys_map_wr(dmap, off + 2, u8, (fg32 & 0x00FF0000) >> 16);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(drm_draw_blit24);
+
+void drm_draw_blit32(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+				iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, fg32);
+}
+EXPORT_SYMBOL(drm_draw_blit32);
+
+/*
+ * Fill functions
+ */
+void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, color);
+}
+EXPORT_SYMBOL(drm_draw_fill16);
+
+void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			unsigned int off = y * dpitch + x * 3;
+
+			/* write blue-green-red to output in little endianness */
+			iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
+			iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
+			iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
+		}
+	}
+}
+EXPORT_SYMBOL(drm_draw_fill24);
+
+void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u32 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, color);
+}
+EXPORT_SYMBOL(drm_draw_fill32);
diff --git a/drivers/gpu/drm/drm_draw.h b/drivers/gpu/drm/drm_draw.h
new file mode 100644
index 0000000000000..b14752e4c4acf
--- /dev/null
+++ b/drivers/gpu/drm/drm_draw.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/*
+ * Copyright (c) 2023 Red Hat.
+ * Author: Jocelyn Falempe <jfalempe@redhat.com>
+ */
+
+#ifndef __DRM_DRAW_H__
+#define __DRM_DRAW_H__
+
+#include <linux/font.h>
+#include <linux/types.h>
+
+struct iosys_map;
+
+/* check if the pixel at coord x,y is 1 (foreground) or 0 (background) */
+static inline bool drm_draw_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, int x, int y)
+{
+	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
+}
+
+static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
+						 char c, size_t font_pitch)
+{
+	return font->data + (c * font->height) * font_pitch;
+}
+
+u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
+
+void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u16 fg16);
+
+void drm_draw_blit24(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32);
+
+void drm_draw_blit32(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32);
+
+void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color);
+
+void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color);
+
+void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u32 color);
+
+#endif /* __DRM_DRAW_H__ */
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 74412b7bf936c..27fe83cfc854b 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -31,6 +31,7 @@
 #include <drm/drm_rect.h>
 
 #include "drm_crtc_internal.h"
+#include "drm_draw.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM panic handler");
@@ -139,171 +140,8 @@ device_initcall(drm_panic_setup_logo);
 #endif
 
 /*
- * Color conversion
+ *  Blit & Fill functions
  */
-
-static u16 convert_xrgb8888_to_rgb565(u32 pix)
-{
-	return ((pix & 0x00F80000) >> 8) |
-	       ((pix & 0x0000FC00) >> 5) |
-	       ((pix & 0x000000F8) >> 3);
-}
-
-static u16 convert_xrgb8888_to_rgba5551(u32 pix)
-{
-	return ((pix & 0x00f80000) >> 8) |
-	       ((pix & 0x0000f800) >> 5) |
-	       ((pix & 0x000000f8) >> 2) |
-	       BIT(0); /* set alpha bit */
-}
-
-static u16 convert_xrgb8888_to_xrgb1555(u32 pix)
-{
-	return ((pix & 0x00f80000) >> 9) |
-	       ((pix & 0x0000f800) >> 6) |
-	       ((pix & 0x000000f8) >> 3);
-}
-
-static u16 convert_xrgb8888_to_argb1555(u32 pix)
-{
-	return BIT(15) | /* set alpha bit */
-	       ((pix & 0x00f80000) >> 9) |
-	       ((pix & 0x0000f800) >> 6) |
-	       ((pix & 0x000000f8) >> 3);
-}
-
-static u32 convert_xrgb8888_to_argb8888(u32 pix)
-{
-	return pix | GENMASK(31, 24); /* fill alpha bits */
-}
-
-static u32 convert_xrgb8888_to_xbgr8888(u32 pix)
-{
-	return ((pix & 0x00ff0000) >> 16) <<  0 |
-	       ((pix & 0x0000ff00) >>  8) <<  8 |
-	       ((pix & 0x000000ff) >>  0) << 16 |
-	       ((pix & 0xff000000) >> 24) << 24;
-}
-
-static u32 convert_xrgb8888_to_abgr8888(u32 pix)
-{
-	return ((pix & 0x00ff0000) >> 16) <<  0 |
-	       ((pix & 0x0000ff00) >>  8) <<  8 |
-	       ((pix & 0x000000ff) >>  0) << 16 |
-	       GENMASK(31, 24); /* fill alpha bits */
-}
-
-static u32 convert_xrgb8888_to_xrgb2101010(u32 pix)
-{
-	pix = ((pix & 0x000000FF) << 2) |
-	      ((pix & 0x0000FF00) << 4) |
-	      ((pix & 0x00FF0000) << 6);
-	return pix | ((pix >> 8) & 0x00300C03);
-}
-
-static u32 convert_xrgb8888_to_argb2101010(u32 pix)
-{
-	pix = ((pix & 0x000000FF) << 2) |
-	      ((pix & 0x0000FF00) << 4) |
-	      ((pix & 0x00FF0000) << 6);
-	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
-}
-
-/*
- * convert_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
- * @color: input color, in xrgb8888 format
- * @format: output format
- *
- * Returns:
- * Color in the format specified, casted to u32.
- * Or 0 if the format is not supported.
- */
-static u32 convert_from_xrgb8888(u32 color, u32 format)
-{
-	switch (format) {
-	case DRM_FORMAT_RGB565:
-		return convert_xrgb8888_to_rgb565(color);
-	case DRM_FORMAT_RGBA5551:
-		return convert_xrgb8888_to_rgba5551(color);
-	case DRM_FORMAT_XRGB1555:
-		return convert_xrgb8888_to_xrgb1555(color);
-	case DRM_FORMAT_ARGB1555:
-		return convert_xrgb8888_to_argb1555(color);
-	case DRM_FORMAT_RGB888:
-	case DRM_FORMAT_XRGB8888:
-		return color;
-	case DRM_FORMAT_ARGB8888:
-		return convert_xrgb8888_to_argb8888(color);
-	case DRM_FORMAT_XBGR8888:
-		return convert_xrgb8888_to_xbgr8888(color);
-	case DRM_FORMAT_ABGR8888:
-		return convert_xrgb8888_to_abgr8888(color);
-	case DRM_FORMAT_XRGB2101010:
-		return convert_xrgb8888_to_xrgb2101010(color);
-	case DRM_FORMAT_ARGB2101010:
-		return convert_xrgb8888_to_argb2101010(color);
-	default:
-		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
-		return 0;
-	}
-}
-
-/*
- * Blit & Fill
- */
-/* check if the pixel at coord x,y is 1 (foreground) or 0 (background) */
-static bool drm_panic_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, int x, int y)
-{
-	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
-}
-
-static void drm_panic_blit16(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u16 fg16)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
-				iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, fg16);
-}
-
-static void drm_panic_blit24(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u32 fg32)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++) {
-		for (x = 0; x < width; x++) {
-			u32 off = y * dpitch + x * 3;
-
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
-				/* write blue-green-red to output in little endianness */
-				iosys_map_wr(dmap, off, u8, (fg32 & 0x000000FF) >> 0);
-				iosys_map_wr(dmap, off + 1, u8, (fg32 & 0x0000FF00) >> 8);
-				iosys_map_wr(dmap, off + 2, u8, (fg32 & 0x00FF0000) >> 16);
-			}
-		}
-	}
-}
-
-static void drm_panic_blit32(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u32 fg32)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
-				iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, fg32);
-}
-
 static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 				 const u8 *sbuf8, unsigned int spitch, unsigned int scale,
 				 u32 fg_color)
@@ -312,7 +150,7 @@ static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect
 
 	for (y = 0; y < drm_rect_height(clip); y++)
 		for (x = 0; x < drm_rect_width(clip); x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
 				sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, fg_color);
 }
 
@@ -344,15 +182,15 @@ static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 
 	switch (sb->format->cpp[0]) {
 	case 2:
-		drm_panic_blit16(&map, sb->pitch[0], sbuf8, spitch,
+		drm_draw_blit16(&map, sb->pitch[0], sbuf8, spitch,
 				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 3:
-		drm_panic_blit24(&map, sb->pitch[0], sbuf8, spitch,
+		drm_draw_blit24(&map, sb->pitch[0], sbuf8, spitch,
 				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 4:
-		drm_panic_blit32(&map, sb->pitch[0], sbuf8, spitch,
+		drm_draw_blit32(&map, sb->pitch[0], sbuf8, spitch,
 				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	default:
@@ -360,46 +198,6 @@ static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 	}
 }
 
-static void drm_panic_fill16(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u16 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, color);
-}
-
-static void drm_panic_fill24(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u32 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++) {
-		for (x = 0; x < width; x++) {
-			unsigned int off = y * dpitch + x * 3;
-
-			/* write blue-green-red to output in little endianness */
-			iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
-			iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
-			iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
-		}
-	}
-}
-
-static void drm_panic_fill32(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u32 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, color);
-}
-
 static void drm_panic_fill_pixel(struct drm_scanout_buffer *sb,
 				 struct drm_rect *clip,
 				 u32 color)
@@ -432,15 +230,15 @@ static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 
 	switch (sb->format->cpp[0]) {
 	case 2:
-		drm_panic_fill16(&map, sb->pitch[0], drm_rect_height(clip),
+		drm_draw_fill16(&map, sb->pitch[0], drm_rect_height(clip),
 				 drm_rect_width(clip), color);
 	break;
 	case 3:
-		drm_panic_fill24(&map, sb->pitch[0], drm_rect_height(clip),
+		drm_draw_fill24(&map, sb->pitch[0], drm_rect_height(clip),
 				 drm_rect_width(clip), color);
 	break;
 	case 4:
-		drm_panic_fill32(&map, sb->pitch[0], drm_rect_height(clip),
+		drm_draw_fill32(&map, sb->pitch[0], drm_rect_height(clip),
 				 drm_rect_width(clip), color);
 	break;
 	default:
@@ -448,11 +246,6 @@ static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 	}
 }
 
-static const u8 *get_char_bitmap(const struct font_desc *font, char c, size_t font_pitch)
-{
-	return font->data + (c * font->height) * font_pitch;
-}
-
 static unsigned int get_max_line_len(const struct drm_panic_line *lines, int len)
 {
 	int i;
@@ -491,7 +284,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
 
 		for (j = 0; j < line_len; j++) {
-			src = get_char_bitmap(font, msg[i].txt[j], font_pitch);
+			src = drm_draw_get_char_bitmap(font, msg[i].txt[j], font_pitch);
 			rec.x2 = rec.x1 + font->width;
 			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
 			rec.x1 += font->width;
@@ -523,8 +316,10 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 
 static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
 	unsigned int msg_width, msg_height;
@@ -590,8 +385,10 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  */
 static void draw_panic_static_kmsg(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
@@ -781,8 +578,10 @@ static int drm_panic_get_qr_code(u8 **qr_image)
  */
 static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
 	unsigned int max_qr_size, scale;
@@ -868,7 +667,7 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 {
 	if (format->num_planes != 1)
 		return false;
-	return convert_from_xrgb8888(0xffffff, format->format) != 0;
+	return drm_draw_color_from_xrgb8888(0xffffff, format->format) != 0;
 }
 
 static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
-- 
2.47.0


