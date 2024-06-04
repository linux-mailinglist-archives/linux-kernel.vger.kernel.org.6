Return-Path: <linux-kernel+bounces-200695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F71D8FB371
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66DE281344
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6F1474A0;
	Tue,  4 Jun 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVwz2L8P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898B14659B;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507239; cv=none; b=nAMS005oCqXfk+Ifh46hawVQOw53z5igccwlLMS0XWJ3m3hmad/WXWHQGbsb1wzLIllH3Uo5ARp2/KuUrf7/8DN0jyOTROrXXB5TZDRq+Z62d4rBEn0zkpYUDu+76Ov7bB/aUF7X0QzlwrkjxHms/YfrenTwO7Cx5fuVm4RO1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507239; c=relaxed/simple;
	bh=8YntGuIrO4BZZ0ZxPUzDTcK33MQ+uAf5uTa92b0BriM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA4iq+rAcFAGN0rLGgMvqMokY4XS+/j3gyRBKSi+Y1bHZJFYnPDH//bErca0hdVKzT+W0F7BxKeZsOyQkpj0V6jgZl4ABqoAwztcF+ldME6D8d/6qiHJ7Nifab14gk8IsV3q54syXl/4722L8xSQ4+8h7lkSSklRePLSIc+jm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVwz2L8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80570C4AF10;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717507239;
	bh=8YntGuIrO4BZZ0ZxPUzDTcK33MQ+uAf5uTa92b0BriM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uVwz2L8PAAFNRD66YajtALxH2YS6DgRiCGIlHvcUyVSGSU+djK3R39o4UBqp3lMZM
	 GGlqHy7OxX9+3m5jzhRjlaCa0ifAwufd/FDkcp0PM9sYqL7rvjWjBUuuWT8+TvOQ5+
	 v3GpD1QpthmPVlavGRKjj49aWoRMzOm+77wja/W0/s8ZQvDLFC/0iyckNnmsXHW2ha
	 IRPHjTFSeeXpJy7ETubAr08Newfjd6gaZHRZHFBgjHgnB12boSsU0vHfVyyS/+Y1tH
	 x5QTrHzOLFS3xq8fF8218FbzrrG7QJ5Lcv1myB/5Wwz7mqPG0qDtEkRDFmJECvI0+E
	 lxELxnPYWJ1NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C08C27C55;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 04 Jun 2024 15:20:31 +0200
Subject: [PATCH v4 4/5] drm/mipi-dbi: Add support for DRM_FORMAT_RGB888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-panel-mipi-dbi-rgb666-v4-4-d7c2bcb9b78d@tronnes.org>
References: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
In-Reply-To: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717507238; l=5029;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=9oZ/CTA5q4N/L6mVFGvQ1ZFxA3+wT85GeDr61IpDHdc=;
 b=xNPf0SbhGVTKNX198jZcKZ8gVKMHL9msGR0tSDwyPoZbCchdoCxtcPOELMj4s2Plu3j9DNT1A
 SI8r8v8PzymCFA+8N4hw3hClRgtDKZRVMbu7ti4yqmdMGkTYU2lADuc
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

DRM_FORMAT_RGB888 is 24 bits per pixel and it would be natural to send it
on the SPI bus using a 24 bits per word transfer. The problem with this
is that not all SPI controllers support 24 bpw.

Since DRM_FORMAT_RGB888 is stored in memory as little endian and the SPI
bus is big endian we use 8 bpw to always get the same pixel format on the
bus: b8g8r8.

The MIPI DCS specification lists the standard commands that can be sent
over the MIPI DBI interface. The set_address_mode (36h) command has one
bit in the parameter that controls RGB/BGR order. This means that the
controller can be configured to receive the pixel as BGR.

RGB888 is rarely supported on these controllers but RGB666 is very common.
All datasheets I have seen do at least support the pixel format option
where each color is sent as one byte and the 6 MSB's are used.

All this put together means that we can send each pixel as b8g8r8 and an
RGB666 capable controller sees this as b6x2g6x2r6x2.

v4:
- s/emulation_format/pixel_format/ (Dmitry)

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 29 +++++++++++++++++++++++++----
 include/drm/drm_mipi_dbi.h     |  5 +++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 77f8a828d6e0..1661190c29a2 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -206,6 +206,7 @@ int mipi_dbi_buf_copy(void *dst, struct iosys_map *src, struct drm_framebuffer *
 		      struct drm_rect *clip, bool swap,
 		      struct drm_format_conv_state *fmtcnv_state)
 {
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
 	struct drm_gem_object *gem = drm_gem_fb_get_obj(fb, 0);
 	struct iosys_map dst_map = IOSYS_MAP_INIT_VADDR(dst);
 	int ret;
@@ -222,8 +223,18 @@ int mipi_dbi_buf_copy(void *dst, struct iosys_map *src, struct drm_framebuffer *
 		else
 			drm_fb_memcpy(&dst_map, NULL, src, fb, clip);
 		break;
+	case DRM_FORMAT_RGB888:
+		drm_fb_memcpy(&dst_map, NULL, src, fb, clip);
+		break;
 	case DRM_FORMAT_XRGB8888:
-		drm_fb_xrgb8888_to_rgb565(&dst_map, NULL, src, fb, clip, fmtcnv_state, swap);
+		switch (dbidev->pixel_format) {
+		case DRM_FORMAT_RGB565:
+			drm_fb_xrgb8888_to_rgb565(&dst_map, NULL, src, fb, clip, fmtcnv_state, swap);
+			break;
+		case DRM_FORMAT_RGB888:
+			drm_fb_xrgb8888_to_rgb888(&dst_map, NULL, src, fb, clip, fmtcnv_state);
+			break;
+		}
 		break;
 	default:
 		drm_err_once(fb->dev, "Format is not supported: %p4cc\n",
@@ -260,9 +271,11 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
 	unsigned int height = rect->y2 - rect->y1;
 	unsigned int width = rect->x2 - rect->x1;
+	const struct drm_format_info *dst_format;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	bool swap = dbi->swap_bytes;
 	int ret = 0;
+	size_t len;
 	bool full;
 	void *tr;
 
@@ -283,8 +296,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
 				    rect->y2 - 1);
 
-	ret = mipi_dbi_command_buf(dbi, MIPI_DCS_WRITE_MEMORY_START, tr,
-				   width * height * 2);
+	if (fb->format->format == DRM_FORMAT_XRGB8888)
+		dst_format = drm_format_info(dbidev->pixel_format);
+	else
+		dst_format = fb->format;
+	len = drm_format_info_min_pitch(dst_format, 0, width) * height;
+
+	ret = mipi_dbi_command_buf(dbi, MIPI_DCS_WRITE_MEMORY_START, tr, len);
 err_msg:
 	if (ret)
 		drm_err_once(fb->dev, "Failed to update display %d\n", ret);
@@ -572,7 +590,7 @@ static const uint32_t mipi_dbi_formats[] = {
  * has one fixed &drm_display_mode which is rotated according to @rotation.
  * This mode is used to set the mode config min/max width/height properties.
  *
- * Use mipi_dbi_dev_init() if you don't need custom formats.
+ * Use mipi_dbi_dev_init() if you want native RGB565 and emulated XRGB8888 format.
  *
  * Note:
  * Some of the helper functions expects RGB565 to be the default format and the
@@ -631,6 +649,9 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
 	drm->mode_config.max_height = dbidev->mode.vdisplay;
 	dbidev->rotation = rotation;
+	dbidev->pixel_format = formats[0];
+	if (formats[0] == DRM_FORMAT_RGB888)
+		dbidev->dbi.write_memory_bpw = 8;
 
 	DRM_DEBUG_KMS("rotation = %u\n", rotation);
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index b36596efdcc3..f45f9612c0bc 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -101,6 +101,11 @@ struct mipi_dbi_dev {
 	 */
 	struct drm_display_mode mode;
 
+	/**
+	 * @pixel_format: Native pixel format (DRM_FORMAT\_\*)
+	 */
+	u32 pixel_format;
+
 	/**
 	 * @tx_buf: Buffer used for transfer (copy clip rect area)
 	 */

-- 
2.45.1



