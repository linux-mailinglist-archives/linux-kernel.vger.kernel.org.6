Return-Path: <linux-kernel+bounces-171050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE618BDF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13146281DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3D14F123;
	Tue,  7 May 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqxzONOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC114E2E2;
	Tue,  7 May 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075868; cv=none; b=hmo6qUOS3Gt0yLgcTHb8PPCRcdAmw2OnL59aT9bHKD96JiJe4SrcJ6VM0+jvthYKYgDRKMZ0gTVD4sURJj7ict9jsgmBiahsma8KPdIzjahNBHPzbtsgJ/XCqCPj8XVTvVfHpA1+eGiSy1jIihMWIfT0gX3Dztbj4LpuGwXiRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075868; c=relaxed/simple;
	bh=3dqNGvZkC+MMnGTynjmV0t4nfsy//bK88jV+fDke0Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWeLqUWkVcWb5bXvOnDLwhPwRYNhq0XEAWBZt8Wh6qbQw1idOpe7e1GVcmgeeEw0zRWotefhvtTfqaF5N8HQTMZz/P2nZlLxh3c00krGTKRKJcGYkjyOWYw3AfA5TJzgoQqFIuIAGRBPd5jyiHeKxPMZEC5LumV9pXTxomXN/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqxzONOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC21C4DDE2;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715075868;
	bh=3dqNGvZkC+MMnGTynjmV0t4nfsy//bK88jV+fDke0Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AqxzONOUu4WH25ipybKItDTNM5j/5ZoM5z+3pVPXZ8hHe/n3RP0vc71NB1T1Ae175
	 MAqi4ZNPpZJWBE0ym1eipb04gIkO2LMrCVZdFaKj97DopAstk8FPhUpsaWygkI49Sm
	 e4E9EUbtZohk32FXNg46tNxjCyen4ic0YtT2pJ2lMmIDK0Mem53+uM1gA1EIw7R9AX
	 Sr3gqWM1vhMTuDQlsWuRIgqt6VFsllttBGp6Yp4I7AoOQc7gijyakqD6+GHV21MSsA
	 LOYFjtrXlmlMpEMdXh3RLmqLxYylaPnGYzpFXF0fPRS0xpC3AeQ+8CPLuZRKjt5xFW
	 hVieaTiqXM3dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2E1C10F1A;
	Tue,  7 May 2024 09:57:47 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 07 May 2024 11:57:29 +0200
Subject: [PATCH 4/5] drm/mipi-dbi: Add support for DRM_FORMAT_RGB888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-panel-mipi-dbi-rgb666-v1-4-6799234afa3e@tronnes.org>
References: <20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org>
In-Reply-To: <20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075866; l=5004;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=W6oL0rQmok4cxorsnLB3NONNFaDQoJFHpq/k5uI9z9M=;
 b=xrWtja3b0161skYUntf8/RPOgtpzqoEcXXFwLi3CxtVwl+QJrX77tm1Jg9hCMIcUQ2w7MxdKD
 hUddiMWrJ7zBzTad2pjLnediyIIR4sMVgUX6hU0ntTcNEfU35kbxxsP
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

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 29 +++++++++++++++++++++++++----
 include/drm/drm_mipi_dbi.h     |  5 +++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 77f8a828d6e0..eb330676857c 100644
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
+		switch (dbidev->emulation_format) {
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
+		dst_format = drm_format_info(dbidev->emulation_format);
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
+	dbidev->emulation_format = formats[0];
+	if (formats[0] == DRM_FORMAT_RGB888)
+		dbidev->dbi.write_memory_bpw = 8;
 
 	DRM_DEBUG_KMS("rotation = %u\n", rotation);
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index b36596efdcc3..85bf19b98cee 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -101,6 +101,11 @@ struct mipi_dbi_dev {
 	 */
 	struct drm_display_mode mode;
 
+	/**
+	 * @emulation_format: Pixel format to use when emulating XRGB8888
+	 */
+	u32 emulation_format;
+
 	/**
 	 * @tx_buf: Buffer used for transfer (copy clip rect area)
 	 */

-- 
2.45.0



