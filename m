Return-Path: <linux-kernel+bounces-418492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054AF9D6234
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CB728390E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CE1DF720;
	Fri, 22 Nov 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mHYw6goM"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A829A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292715; cv=none; b=pTB7MO5peUk40FakjuoD0q848BHEWt8iXPorQpha5j/l/9MQqPrEvvCMP8pf95I8uQpDrGav5hkXl5pUcVM6vwjGI2yHLFqEWl391Cyd3ePZY/4yysZ7uWeIRtHwchSp11OJpxVywzB5+HVItmx2svzfXB9qL8uRgvdnoln2g1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292715; c=relaxed/simple;
	bh=kvBuXYPDgNffAIVnvaafBaanKc2jQF6V8JhgmRV44/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw0ykZQ8kr3S2+35yIvfFQ9JIMA4CmbzruIdHVueY85J34jurK2NxzFd5mdj3sqvQq1PjZfh/erbT6wF9UzG7KQhx1GZFZGw9yNPxQBgS98z+b+WxIh1cZnEEc4EFG+e2i+UI1AzPgHkKOdTyLtDXreu5YH7QFLJ1/31jhpiXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mHYw6goM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B231E0007;
	Fri, 22 Nov 2024 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrph+lbrmkDjH3XLZYWrCy0AJRMEXLYnrJDeKfCnYw0=;
	b=mHYw6goMMboI06Tyjqparj+e4/1DXCzkIzKE8fII49onb17Y4F6dKIe13e6pIx6aXaPyg8
	bGSovXd2YEBwq16M7LubSn6ox8QgiB1UqeD4g4A6sTk+xUrid5FeMZ5JNTyWZPK5ihY1R1
	G/xYOg7lzoXulNT98rAanLVOdjPa5wAuCeSo9XZeu0ZMeaX27Gx1NNIdA1nzqdJSZerVGJ
	UC6BjErlGxvpAANTSysOKIHiiBtEmsY4MF/DRvXXQn4fz9u/+XvvFMqr8Zu1rN2HWWi1Cd
	/GTQiNBPtF7Aq6lEpyRd6JUvbILw24r5qV4edAHwukpYI0hBJb1/5CFrPPJ2zA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:25:00 +0100
Subject: [PATCH v3 1/3] drm/vkms: Re-introduce line-by-line algorithm for
 writeback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-writeback_line_by_line-v3-1-085d5810f6e3@bootlin.com>
References: <20241122-writeback_line_by_line-v3-0-085d5810f6e3@bootlin.com>
In-Reply-To: <20241122-writeback_line_by_line-v3-0-085d5810f6e3@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11596;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=kvBuXYPDgNffAIVnvaafBaanKc2jQF6V8JhgmRV44/I=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGdAsF2h4PW7X5QyKrlhxTuFa27f8fbwyZ0I4jWAblYU44ToB
 okCMwQAAQgAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJnQLBdAAoJECCtLsZbECziNgYQAMuH
 AonLShQXfr/lx7G//NDW63oxl3Ii7NU7XhS7kioxvOgdNhi07BcXsiQOFD8qNb/01w1RqqCeGEu
 TxrVehHwVpYEA3TX+v5SnTIawLpIoruRjyyYqHTDvEoqQQ4lftBo//ZraxY8VWgbg1btuye3eOE
 LGBizdFOOQnY+QyIuht8yjPX4qnZzbKB+VnT+Swyvlh6UASWoZdy+Rso2JvzwKxi3uKUtpa5+7V
 ioU4RXQt5EqGcHvOpkPqW6T7rAiYKtd1MMVCTWrkhJKFjVgPIm5tQfzsJbGNknuuVozgvxtHBxT
 wHKsHnZQ5QZr2nCekDyaB2tcuoQagZiTkG1dtJ/5YfMkfWb6pYD1OZgUvVKerlOrlATabAmwSB+
 u2ax0M8KbIq/Vtml1Iu7GyFknRCgaJXHgs8sqUbj1ZuX52Jsi8KWesTHyrKTAU2MNgsgs0dbXXL
 rDGpgmd5/dyrZP9MLA8zqYJG/ra6Ie+Pis01lWWi2DMgnU+qzArWmiVAcdbk9jbIBvt8+6/OGO2
 dQLEq2f6wQ1PFLRXFxFaqAZTiOh3UvFxkY1qM1ope5W8YmL6PufJEI5Gc+bVSASvx0m6W3sjiRz
 owL3N56Kl6rQI6RAcbe56H5XRXhoBZ2S33vbvTMBtVU0l/PcAdeGPU7hDTE8WxbO37PURuc5OEC
 U0jLe
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Re-introduce a line-by-line writeback algorithm for each pixel format.
This allows more performance by not requiring an indirection per pixel
write.

Line-by-line writeback was introduced by [1] but rewritten back to
pixel-by-pixel algorithm in [2]. At this time, nobody noticed the impact
on performance, and it was merged.

This patch is almost a revert of [2], but with some effort to avoid code
duplication. Now only the loop is repeated, but it is required to have
good performances.

The performance gain is around 5 to 10%.

[1]: https://lore.kernel.org/all/20211005201637.58563-7-igormtorrente@gmail.com/
[2]: https://lore.kernel.org/all/20230515135204.115393-4-mcanal@igalia.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  |  17 +++++
 drivers/gpu/drm/vkms/vkms_drv.h       |  17 +++--
 drivers/gpu/drm/vkms/vkms_formats.c   | 119 +++++++++++++++++++++++++++-------
 drivers/gpu/drm/vkms/vkms_formats.h   |   2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |   2 +-
 5 files changed, 125 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index b20ac170572622b34ba76b1a9c5dd626ca5da6fa..6d58ba47c2a401a1235d04e8eb21cf95904d8fc2 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -176,6 +176,23 @@ static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
 	return READ_LEFT_TO_RIGHT;
 }
 
+/**
+ * vkms_writeback_row() - Write a line to the writeback buffer
+ *
+ * @wb: Job where to insert the final image
+ * @src_buffer: Line to write
+ * @y: Row to write in the writeback buffer
+ */
+static void vkms_writeback_row(struct vkms_writeback_job *wb,
+			       const struct line_buffer *src_buffer, size_t y_start)
+{
+	struct vkms_frame_info *frame_info = &wb->wb_frame_info;
+	int x_start = frame_info->dst.x1;
+	int count = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
+
+	wb->pixel_write(wb, src_buffer->pixels, count, x_start, y_start);
+}
+
 /**
  * clamp_line_coordinates() - Compute and clamp the coordinate to read and write during the blend
  * process.
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index ae721d998c7d381b9e4105c41dec90b7b0ce2dc0..c806055151cd909beb454df1a256d97464b6614f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -52,20 +52,26 @@ struct line_buffer {
 	struct pixel_argb_u16 *pixels;
 };
 
+struct vkms_writeback_job;
 /**
- * typedef pixel_write_t - These functions are used to read a pixel from a
+ * typedef pixel_write_line_t - These functions are used to read a pixel from a
  * &struct pixel_argb_u16, convert it in a specific format and write it in the @out_pixel
  * buffer.
  *
- * @out_pixel: destination address to write the pixel
- * @in_pixel: pixel to write
+ * @wb: the writeback job to write the output of the conversion
+ * @in_pixels: Source buffer containing the line to convert
+ * @count: The width of a line
+ * @x_start: The x (width) coordinate in the destination plane
+ * @y_start: The y (height) coordinate in the destination plane
  */
-typedef void (*pixel_write_t)(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
+typedef void (*pixel_write_line_t)(struct vkms_writeback_job *wb,
+			      struct pixel_argb_u16 *in_pixels, int count, int x_start,
+			      int y_start);
 
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
-	pixel_write_t pixel_write;
+	pixel_write_line_t pixel_write;
 };
 
 /**
@@ -290,7 +296,6 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 /* Composer Support */
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
-void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index c895126e9136bff7820ac7dfc1a3b6418c9ca2b1..f6d0b71a05084a7f57dc8f0600ba2a2b654c4ec0 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -589,7 +589,7 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
  * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
  * The result is stored in @out_pixel.
  *
- * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
+ * They are used in the `write_line` functions to convert and store a pixel from the src_buffer to
  * the writeback buffer.
  */
 static void argb_u16_to_ARGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
@@ -656,28 +656,97 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
-/**
- * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
- * after the blending to write a line in the writeback buffer.
+/*
+ * The following functions are write_line function for each pixel format supported by VKMS.
+ *
+ * They write a full line at index y. They must read data from the line src_pixels.
+ *
+ * The caller must ensure that count is not larger than the framebuffer and the src_pixels.
+ *
+ * Those function are very similar, but it is required for performance reason. In the past, some
+ * experiment were done, and with a generic loop the performance are very reduced [1].
  *
- * @wb: Job where to insert the final image
- * @src_buffer: Line to write
- * @y: Row to write in the writeback buffer
+ * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
  */
-void vkms_writeback_row(struct vkms_writeback_job *wb,
-			const struct line_buffer *src_buffer, int y)
+
+static void ARGB8888_write_line(struct vkms_writeback_job *wb,
+				struct pixel_argb_u16 *src_pixels, int count, int x_start,
+				int y_start)
 {
-	struct vkms_frame_info *frame_info = &wb->wb_frame_info;
-	int x_dst = frame_info->dst.x1;
 	u8 *dst_pixels;
-	int rem_x, rem_y;
 
-	packed_pixels_addr(frame_info, x_dst, y, 0, &dst_pixels, &rem_x, &rem_y);
-	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
-	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+
+	while (count) {
+		argb_u16_to_ARGB8888(dst_pixels, src_pixels);
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
+		src_pixels += 1;
+		count--;
+	}
+}
+
+static void XRGB8888_write_line(struct vkms_writeback_job *wb,
+				struct pixel_argb_u16 *src_pixels, int count, int x_start,
+				int y_start)
+{
+	u8 *dst_pixels;
+
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+
+	while (count) {
+		argb_u16_to_XRGB8888(dst_pixels, src_pixels);
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
+		src_pixels += 1;
+		count--;
+	}
+}
+
+static void ARGB16161616_write_line(struct vkms_writeback_job *wb,
+				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
+				    int y_start)
+{
+	u8 *dst_pixels;
+
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
 
-	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->fb->format->cpp[0])
-		wb->pixel_write(dst_pixels, &in_pixels[x]);
+	while (count) {
+		argb_u16_to_ARGB16161616(dst_pixels, src_pixels);
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
+		src_pixels += 1;
+		count--;
+	}
+}
+
+static void XRGB16161616_write_line(struct vkms_writeback_job *wb,
+				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
+				    int y_start)
+{
+	u8 *dst_pixels;
+
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+
+	while (count) {
+		argb_u16_to_XRGB16161616(dst_pixels, src_pixels);
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
+		src_pixels += 1;
+		count--;
+	}
+}
+
+static void RGB565_write_line(struct vkms_writeback_job *wb,
+			      struct pixel_argb_u16 *src_pixels, int count, int x_start,
+			      int y_start)
+{
+	u8 *dst_pixels;
+
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+
+	while (count) {
+		argb_u16_to_RGB565(dst_pixels, src_pixels);
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
+		src_pixels += 1;
+		count--;
+	}
 }
 
 /**
@@ -939,25 +1008,27 @@ void get_conversion_matrix_to_argb_u16(u32 format,
 EXPORT_SYMBOL(get_conversion_matrix_to_argb_u16);
 
 /**
- * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
+ * get_pixel_write_line_function() - Retrieve the correct write_line function for a specific
+ * format.
+ *
  * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
  * pointer is valid before using it in a vkms_writeback_job.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
-pixel_write_t get_pixel_write_function(u32 format)
+pixel_write_line_t get_pixel_write_line_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
-		return &argb_u16_to_ARGB8888;
+		return &ARGB8888_write_line;
 	case DRM_FORMAT_XRGB8888:
-		return &argb_u16_to_XRGB8888;
+		return &XRGB8888_write_line;
 	case DRM_FORMAT_ARGB16161616:
-		return &argb_u16_to_ARGB16161616;
+		return &ARGB16161616_write_line;
 	case DRM_FORMAT_XRGB16161616:
-		return &argb_u16_to_XRGB16161616;
+		return &XRGB16161616_write_line;
 	case DRM_FORMAT_RGB565:
-		return &argb_u16_to_RGB565;
+		return &RGB565_write_line;
 	default:
 		/*
 		 * This is a bug in vkms_writeback_atomic_check. All the supported
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index eeb208cdd6b1be9676b4706e0e3cbb2ad7efe067..852ab9a4cee5a8684592200f81f66afaf4873101 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -7,7 +7,7 @@
 
 pixel_read_line_t get_pixel_read_line_function(u32 format);
 
-pixel_write_t get_pixel_write_function(u32 format);
+pixel_write_line_t get_pixel_write_line_function(u32 format);
 
 void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 				       enum drm_color_range range,
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 79918b44fedd7ae2451d1d530fc6d5aabf2d99a3..0b31628e1b532367cc79cd7432aa070661f41a57 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -150,7 +150,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	crtc_state->wb_pending = true;
 	spin_unlock_irq(&output->composer_lock);
 	drm_writeback_queue_job(wb_conn, connector_state);
-	active_wb->pixel_write = get_pixel_write_function(wb_format);
+	active_wb->pixel_write = get_pixel_write_line_function(wb_format);
 	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
 	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
 }

-- 
2.47.0


