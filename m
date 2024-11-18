Return-Path: <linux-kernel+bounces-413362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766639D1827
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C9F1F224EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DC1E1C2A;
	Mon, 18 Nov 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NC5gycjj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459B1E1045;
	Mon, 18 Nov 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954517; cv=none; b=hSVt/6NCZwzSghfkGKzyY3SLUkrZOEtyrVOzUNpN8Kafi853ViuWI9gcQmZbE9yQf6zqr8XvEVRk7xwjjKP3OvZbxEL60kxMvNCAm5AQvx6M9E3yG7NaJWOaK8Lt46QitBirhAM7VNTE60iQoooFwb8HExHaLJuUKFD7dLDLL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954517; c=relaxed/simple;
	bh=1Kj960b4ZdpGhGT0z0Y0xoNuaNBh0bRjc5MLBWSl4RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkBFSLsb5lYQBk91grI6xHSVW3imjF51fHyN2L/P8DLyZXY+NGfGx2ul3q0z5+mveB7Hp3lIdS6l7vmn8fk45badsHN4GRFPk6z3/DSufcpDgs+Od8Vbgdmi8SBERkzd9xtLPWlLw8wt0TNPEX25vjW+smNyEqIyZx0NJlyWDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NC5gycjj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A0FAE000D;
	Mon, 18 Nov 2024 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731954513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8vi7d1yJfeVlVH8r9QdmAldZszanwqP5SwlTzGZcXg=;
	b=NC5gycjjILEACgEWA8PQWetfxpyxzlVBhiLjkt4cx1m4MuGNtGY5v65Z4o1B/Tg3SCk6Vp
	rfdgDD4LZwn6BGnQTlj9s97S0k9xQbRElf9jbmco+VmBJxcJ+uoqag67OfnSzM6SR1VJQg
	GNYXRayj+FNj+atYSXai9w668BRmXGpPlDWMXW3/n9hWwDyW0H3GgnICGbdeB2i8kEDGyK
	zUi0SpwlfwphZePAn7q5QaUcwR/Kiec1604wNgGOOL4TYxrq8DQZWzQ6MfkrOjB6XDzo5d
	fA5ZUWXhL2nI2QIzNVly8tuFADrYGNCOEwrkXh1w9iazPSdeXW+rFA2UnI/0PQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 18 Nov 2024 19:28:20 +0100
Subject: [PATCH v14 5/9] drm/vkms: Update pixels accessor to support packed
 and multi-plane formats.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-yuv-v14-5-2dbc2f1e222c@bootlin.com>
References: <20241118-yuv-v14-0-2dbc2f1e222c@bootlin.com>
In-Reply-To: <20241118-yuv-v14-0-2dbc2f1e222c@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8956;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=1Kj960b4ZdpGhGT0z0Y0xoNuaNBh0bRjc5MLBWSl4RQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4dGlvxvhoLib3V29k5nJ7H84oPUhzw3lGaeU
 QxmM5/c09KJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuHRgAKCRAgrS7GWxAs
 4hqXD/9MOmzTy1fQ621mx4B9LwJm+3rsnrwnCf+/0ktMKd7xz/6vCw4cwoLG4piDatLChh2iKwX
 ho4qIjskeQQHCe1OW1sA1UZMcUpND/jK0skSaXXCv0v7RIq/ESf+qIanA3MNXs6F+5CFXVCjM+N
 eXAikpfjNofOrndV6yfgQMdAULdqXDIyW58EDOl53MXEW+NXnwf5FcCohN4cZpA+UMZVKR2rXLT
 GmhhUYhl2Vp1hbqs7H/f/wn6SF/d0Xn1eiJ/5V2gme1A8gse3fzZayTeffmvKmUdKC0Apkvbss5
 w/cDOjTT+FNP+i3GPFPMkOffuH0YdWFs9AGYaqCiE8BvwozdqCSngGmvfumrhHbkwxtorwAyIVQ
 xCMTxsNiGqsi4RlVwRjJg/u3KDj6Pj/xZlcRU1L2WHelFNT+X4ZIXIm2WaYY1b5mMnYSHrh2npj
 jS2MSY5X0WLAitGMMm8hCwan/RIYGRfBwF4TxoxAkMBal4LCIL+hMNQNRLq5r3LnF4Zyw+vKRD0
 QFmw/3eGbuR67BFJBW1qD8YTf6JdOFeTdzlaGCFz0kiFg1Zx1tlalmN9a9Wqk1yvcCNvFMN8Vnq
 PKdw3MyHjVjvUu1x3PpQ/gI8i1iQPU0/oYsAOpRUocJAaqioYuOgH9ixNPhivqMtmyEHADB5RRy
 f5vX8mLiRB5RFNg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce the usage of block_h/block_w to compute the offset and the
pointer of a pixel. The previous implementation was specialized for
planes with block_h == block_w == 1. To avoid confusion and allow easier
implementation of tiled formats. It also remove the usage of the
deprecated format field `cpp`.

Introduce the plane_index parameter to get an offset/pointer on a
different plane.

Acked-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 114 ++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 06aef516252956eb43e111c0e169f21c1ab5b482..f9045a80aceba941568db014fecf548d59e14a5a 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -10,22 +10,46 @@
 #include "vkms_formats.h"
 
 /**
- * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
+ * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
  *
  * @frame_info: Buffer metadata
  * @x: The x coordinate of the wanted pixel in the buffer
  * @y: The y coordinate of the wanted pixel in the buffer
+ * @plane_index: The index of the plane to use
+ * @offset: The returned offset inside the buffer of the block
+ * @rem_x: The returned X coordinate of the requested pixel in the block
+ * @rem_y: The returned Y coordinate of the requested pixel in the block
  *
- * The caller must ensure that the framebuffer associated with this request uses a pixel format
- * where block_h == block_w == 1.
- * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
- * outside of the buffer.
+ * As some pixel formats store multiple pixels in a block (DRM_FORMAT_R* for example), some
+ * pixels are not individually addressable. This function return 3 values: the offset of the
+ * whole block, and the coordinate of the requested pixel inside this block.
+ * For example, if the format is DRM_FORMAT_R1 and the requested coordinate is 13,5, the offset
+ * will point to the byte 5*pitches + 13/8 (second byte of the 5th line), and the rem_x/rem_y
+ * coordinates will be (13 % 8, 5 % 1) = (5, 0)
+ *
+ * With this function, the caller just have to extract the correct pixel from the block.
  */
-static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
+static void packed_pixels_offset(const struct vkms_frame_info *frame_info, int x, int y,
+				 int plane_index, int *offset, int *rem_x, int *rem_y)
 {
 	struct drm_framebuffer *fb = frame_info->fb;
+	const struct drm_format_info *format = frame_info->fb->format;
+	/* Directly using x and y to multiply pitches and format->ccp is not sufficient because
+	 * in some formats a block can represent multiple pixels.
+	 *
+	 * Dividing x and y by the block size allows to extract the correct offset of the block
+	 * containing the pixel.
+	 */
 
-	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
+	int block_x = x / drm_format_info_block_width(format, plane_index);
+	int block_y = y / drm_format_info_block_height(format, plane_index);
+	int block_pitch = fb->pitches[plane_index] * drm_format_info_block_height(format,
+										  plane_index);
+	*rem_x = x % drm_format_info_block_width(format, plane_index);
+	*rem_y = y % drm_format_info_block_height(format, plane_index);
+	*offset = fb->offsets[plane_index] +
+		  block_y * block_pitch +
+		  block_x * format->char_per_block[plane_index];
 }
 
 /**
@@ -35,30 +59,71 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
  * @frame_info: Buffer metadata
  * @x: The x (width) coordinate inside the plane
  * @y: The y (height) coordinate inside the plane
+ * @plane_index: The index of the plane
+ * @addr: The returned pointer
+ * @rem_x: The returned X coordinate of the requested pixel in the block
+ * @rem_y: The returned Y coordinate of the requested pixel in the block
  *
- * Takes the information stored in the frame_info, a pair of coordinates, and
- * returns the address of the first color channel.
- * This function assumes the channels are packed together, i.e. a color channel
- * comes immediately after another in the memory. And therefore, this function
- * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
+ * Takes the information stored in the frame_info, a pair of coordinates, and returns the address
+ * of the block containing this pixel and the pixel position inside this block.
  *
- * The caller must ensure that the framebuffer associated with this request uses a pixel format
- * where block_h == block_w == 1, otherwise the returned pointer can be outside the buffer.
+ * See @packed_pixels_offset for details about rem_x/rem_y behavior.
  */
-static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
-				int x, int y)
+static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
+			       int x, int y, int plane_index, u8 **addr, int *rem_x,
+			       int *rem_y)
 {
-	size_t offset = pixel_offset(frame_info, x, y);
+	int offset;
 
-	return (u8 *)frame_info->map[0].vaddr + offset;
+	packed_pixels_offset(frame_info, x, y, plane_index, &offset, rem_x, rem_y);
+	*addr = (u8 *)frame_info->map[0].vaddr + offset;
 }
 
-static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y)
+/**
+ * packed_pixels_addr_1x1() - Get the pointer to the block containing the pixel at the given
+ * coordinates
+ *
+ * @frame_info: Buffer metadata
+ * @x: The x (width) coordinate inside the plane
+ * @y: The y (height) coordinate inside the plane
+ * @plane_index: The index of the plane
+ * @addr: The returned pointer
+ *
+ * This function can only be used with format where block_h == block_w == 1.
+ */
+static void packed_pixels_addr_1x1(const struct vkms_frame_info *frame_info,
+				   int x, int y, int plane_index, u8 **addr)
+{
+	int offset, rem_x, rem_y;
+
+	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format,
+					      plane_index) != 1,
+		"%s() only support formats with block_w == 1", __func__);
+	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format,
+					       plane_index) != 1,
+		"%s() only support formats with block_h == 1", __func__);
+
+	packed_pixels_offset(frame_info, x, y, plane_index, &offset, &rem_x,
+			     &rem_y);
+	*addr = (u8 *)frame_info->map[0].vaddr + offset;
+}
+
+static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y,
+				 int plane_index)
 {
 	int x_src = frame_info->src.x1 >> 16;
 	int y_src = y - frame_info->rotated.y1 + (frame_info->src.y1 >> 16);
+	u8 *addr;
+	int rem_x, rem_y;
+
+	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format, plane_index) != 1,
+		  "%s() only support formats with block_w == 1", __func__);
+	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format, plane_index) != 1,
+		  "%s() only support formats with block_h == 1", __func__);
 
-	return packed_pixels_addr(frame_info, x_src, y_src);
+	packed_pixels_addr(frame_info, x_src, y_src, plane_index, &addr, &rem_x, &rem_y);
+
+	return addr;
 }
 
 static int get_x_position(const struct vkms_frame_info *frame_info, int limit, int x)
@@ -152,14 +217,14 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 {
 	struct pixel_argb_u16 *out_pixels = stage_buffer->pixels;
 	struct vkms_frame_info *frame_info = plane->frame_info;
-	u8 *src_pixels = get_packed_src_addr(frame_info, y);
+	u8 *src_pixels = get_packed_src_addr(frame_info, y, 0);
 	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
 
 	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
 		int x_pos = get_x_position(frame_info, limit, x);
 
 		if (drm_rotation_90_or_270(frame_info->rotation))
-			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
+			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1, 0)
 				+ frame_info->fb->format->cpp[0] * y;
 
 		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
@@ -250,7 +315,10 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 {
 	struct vkms_frame_info *frame_info = &wb->wb_frame_info;
 	int x_dst = frame_info->dst.x1;
-	u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
+	u8 *dst_pixels;
+	int rem_x, rem_y;
+
+	packed_pixels_addr(frame_info, x_dst, y, 0, &dst_pixels, &rem_x, &rem_y);
 	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
 	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
 

-- 
2.47.0


