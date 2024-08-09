Return-Path: <linux-kernel+bounces-281347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0E94D5D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F60E1C216FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B2168492;
	Fri,  9 Aug 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWsAKSC3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E314F9F9;
	Fri,  9 Aug 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226112; cv=none; b=iNuDuyhZRZUwADpe7t4rFAkc1hZqp8bO7+qeVo5+k0hTfion0pNFuj0w+2ZBacYUGMm9GNQP4+qxQ9uzIDeaMt89gP36FYgBBUIm/p1xfxxYnYIAkbeFN4Ne7Sawu7HLouaQuvIkIZpZRavut9ZAfngPT61uPwPwFA4vNidX6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226112; c=relaxed/simple;
	bh=BUep/GOiS4Y1+c0Tx+oZ3zsNRJsz3SiVVGgFWjdm00o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC2Ga5J0PAMY4ccW10j7nOHxiUkGdvuRIpUm5G7tNuBswMHTOCfcM489LytDDntPtMJnHT2iS8Uc8scyOJDc7A/LO5yq/Xz2jQ8bPJyWdzQp2AYWxSG29Dwa17y5ds6oP4ezrhycHoU46lWvtr4SeVCFk0222+xzHilt3NN3/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWsAKSC3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C606DFF807;
	Fri,  9 Aug 2024 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pyKNOQQCYipN4xrpDr5V8A6u2QLD2UuIbS9MU3dALQ=;
	b=lWsAKSC3Q2MZE2BwlV9wRnwF8/wbbc9ylCABv/Akw6gf359UB19vJwAUQhoqtF11JkJwAN
	UiXCz7LmzO1Fbj1iGy+O5J/2IrkaBQRsT1p5sPdyMEEtgER2VzwtL3eWdHJfh+fC1Pz+8o
	S1dyjRJFT1H349wG1V8n/ULFvDBzRBQ4ZXy1NiV5oSLTkjNVqKmv49ZMt3ZxgZJRDKnWY1
	XbnG4fHbJCs8q5/SHQGvEN9vOyxY6YLCPiIDinqjmPncKu9antpDvzsar82zyQk6yf207c
	SYjPC9z7wrLATLV5jT+U3bAIaeZHymbdlG/qhOqEz/KIrPwK3qZTGAeb0/Cr7Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:45 +0200
Subject: [PATCH v10 04/16] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-4-1a7c764166f7@bootlin.com>
References: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
In-Reply-To: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12819;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=BUep/GOiS4Y1+c0Tx+oZ3zsNRJsz3SiVVGgFWjdm00o=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfpK6FOL/bfDohXzU4n8bddEAS6yowPNpcvQ
 bOHTPqjl5GJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6QAKCRAgrS7GWxAs
 4uS3EAC606w2SPIe7WUh0RAkZqN4JMsu1BS5+j5Uc8MawexUjYW3dA179cuEX/j7Dfq0pUIr2UT
 0vvhkQvov/eRbiM+p0sfuM+ZBVJCciqYFXI/NrbMG4zBprIGq3dxZsIIL8sLrCbdU75TcYKlUnL
 TlEoQ1STLozR0K6fedZcqMmIaRKGg1aZungoylV3PLaAdpKcsAIANFEct+PL6rgGIc+Pys/sthq
 EP15EzyvqEH8T5FqEEJ/hB3beCRN0lGZiXGVvnt94kEKfpJIAYtiNDpMj0+MrJgDXkO4YLztYRt
 VyNsuTok1JwTaS9v3YuTTPgmHLOzShSN/0kfObhG0OXg3Kt6vUgzTQPiemNHHSB9VlKAHt+d5T9
 7n7cX1rd1zCXWh79YPagskRfiSHQ+FD1a+2V9KKEZSZinxFffV9/gsEbUJyMDzaFwVDn3krEsia
 wnsESaJC/AwCsnsA3ZDjaD8l923Qxt0x5RWrbFanS1uX6brll1N/P3dtDApkYieF5kXtVLvoisu
 QI6JFNtw5eZToD4b8O7zNh7d+/F3iCiV8ghYwjhRueCBhlGTWo5cGdIWr+2RCiqbbnRkeh6SS8A
 6KiD3HKjtqVPUbZ8+gN6VcZmEYLgBM2lp1lIRfCdalt1hZ0OZWSC2AomFb7lw/Ka3m/Md2TOAPx
 piiOkP61WUN1jQw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
compiler to check if the passed functions take the correct arguments.
Such typedefs will help ensuring consistency across the code base in
case of update of these prototypes.

Rename input/output variable in a consistent way between read_line and
write_line.

A warn has been added in get_pixel_*_function to alert when an unsupported
pixel format is requested. As those formats are checked before
atomic_update callbacks, it should never happen.

Document for those typedefs.

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h     |  23 ++++++-
 drivers/gpu/drm/vkms/vkms_formats.c | 122 ++++++++++++++++++++----------------
 drivers/gpu/drm/vkms/vkms_formats.h |   4 +-
 drivers/gpu/drm/vkms/vkms_plane.c   |   2 +-
 4 files changed, 93 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index d6851f1f9c38..7148d46d36b7 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -53,12 +53,31 @@ struct line_buffer {
 	struct pixel_argb_u16 *pixels;
 };
 
+/**
+ * typedef pixel_write_t - These functions are used to read a pixel from a
+ * &struct pixel_argb_u16, convert it in a specific format and write it in the @dst_pixels
+ * buffer.
+ *
+ * @out_pixel: destination address to write the pixel
+ * @in_pixel: pixel to write
+ */
+typedef void (*pixel_write_t)(u8 *out_pixel, struct pixel_argb_u16 *in_pixel);
+
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
-	void (*pixel_write)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
+	pixel_write_t pixel_write;
 };
 
+/**
+ * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
+ * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
+ *
+ * @in_pixel: pointer to the pixel to read
+ * @out_pixel: pointer to write the converted pixel
+ */
+typedef void (*pixel_read_t)(u8 *in_pixel, struct pixel_argb_u16 *out_pixel);
+
 /**
  * struct vkms_plane_state - Driver specific plane state
  * @base: base plane state
@@ -69,7 +88,7 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 *src_buffer, struct pixel_argb_u16 *out_pixel);
+	pixel_read_t pixel_read;
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 2a0fbe27d8b2..5ebc691656bc 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -75,7 +75,7 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
  * They are used in the vkms_compose_row() function to handle multiple formats.
  */
 
-static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	/*
 	 * The 257 is the "conversion ratio". This number is obtained by the
@@ -83,48 +83,48 @@ static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
 	 * the best color value in a pixel format with more possibilities.
 	 * A similar idea applies to others RGB color conversions.
 	 */
-	out_pixel->a = (u16)src_pixels[3] * 257;
-	out_pixel->r = (u16)src_pixels[2] * 257;
-	out_pixel->g = (u16)src_pixels[1] * 257;
-	out_pixel->b = (u16)src_pixels[0] * 257;
+	out_pixel->a = (u16)in_pixel[3] * 257;
+	out_pixel->r = (u16)in_pixel[2] * 257;
+	out_pixel->g = (u16)in_pixel[1] * 257;
+	out_pixel->b = (u16)in_pixel[0] * 257;
 }
 
-static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	out_pixel->a = (u16)0xffff;
-	out_pixel->r = (u16)src_pixels[2] * 257;
-	out_pixel->g = (u16)src_pixels[1] * 257;
-	out_pixel->b = (u16)src_pixels[0] * 257;
+	out_pixel->r = (u16)in_pixel[2] * 257;
+	out_pixel->g = (u16)in_pixel[1] * 257;
+	out_pixel->b = (u16)in_pixel[0] * 257;
 }
 
-static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
-	__le16 *pixels = (__force __le16 *)src_pixels;
+	__le16 *pixel = (__le16 *)in_pixel;
 
-	out_pixel->a = le16_to_cpu(pixels[3]);
-	out_pixel->r = le16_to_cpu(pixels[2]);
-	out_pixel->g = le16_to_cpu(pixels[1]);
-	out_pixel->b = le16_to_cpu(pixels[0]);
+	out_pixel->a = le16_to_cpu(pixel[3]);
+	out_pixel->r = le16_to_cpu(pixel[2]);
+	out_pixel->g = le16_to_cpu(pixel[1]);
+	out_pixel->b = le16_to_cpu(pixel[0]);
 }
 
-static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
-	__le16 *pixels = (__force __le16 *)src_pixels;
+	__le16 *pixel = (__le16 *)in_pixel;
 
 	out_pixel->a = (u16)0xffff;
-	out_pixel->r = le16_to_cpu(pixels[2]);
-	out_pixel->g = le16_to_cpu(pixels[1]);
-	out_pixel->b = le16_to_cpu(pixels[0]);
+	out_pixel->r = le16_to_cpu(pixel[2]);
+	out_pixel->g = le16_to_cpu(pixel[1]);
+	out_pixel->b = le16_to_cpu(pixel[0]);
 }
 
-static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
-	__le16 *pixels = (__force __le16 *)src_pixels;
+	__le16 *pixel = (__le16 *)in_pixel;
 
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
 
-	u16 rgb_565 = le16_to_cpu(*pixels);
+	u16 rgb_565 = le16_to_cpu(*pixel);
 	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
 	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
 	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
@@ -168,12 +168,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 
 /*
  * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
- * The result is stored in @dst_pixels.
+ * The result is stored in @out_pixel.
  *
  * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
  * the writeback buffer.
  */
-static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 {
 	/*
 	 * This sequence below is important because the format's byte order is
@@ -185,43 +185,43 @@ static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
 	 * | Addr + 2 | = Red channel
 	 * | Addr + 3 | = Alpha channel
 	 */
-	dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
-	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
-	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
-	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
+	out_pixel[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
+	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
+	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
+	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 {
-	dst_pixels[3] = 0xff;
-	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
-	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
-	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
+	out_pixel[3] = 0xff;
+	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
+	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
+	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 {
-	__le16 *pixels = (__force __le16 *)dst_pixels;
+	__le16 *pixel = (__le16 *)out_pixel;
 
-	pixels[3] = cpu_to_le16(in_pixel->a);
-	pixels[2] = cpu_to_le16(in_pixel->r);
-	pixels[1] = cpu_to_le16(in_pixel->g);
-	pixels[0] = cpu_to_le16(in_pixel->b);
+	pixel[3] = cpu_to_le16(in_pixel->a);
+	pixel[2] = cpu_to_le16(in_pixel->r);
+	pixel[1] = cpu_to_le16(in_pixel->g);
+	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 {
-	__le16 *pixels = (__force __le16 *)dst_pixels;
+	__le16 *pixel = (__le16 *)out_pixel;
 
-	pixels[3] = cpu_to_le16(0xffff);
-	pixels[2] = cpu_to_le16(in_pixel->r);
-	pixels[1] = cpu_to_le16(in_pixel->g);
-	pixels[0] = cpu_to_le16(in_pixel->b);
+	pixel[3] = cpu_to_le16(0xffff);
+	pixel[2] = cpu_to_le16(in_pixel->r);
+	pixel[1] = cpu_to_le16(in_pixel->g);
+	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 {
-	__le16 *pixels = (__force __le16 *)dst_pixels;
+	__le16 *pixel = (__le16 *)out_pixel;
 
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
@@ -234,7 +234,7 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
 	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
 
-	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
+	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
 /**
@@ -265,7 +265,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
-void *get_pixel_conversion_function(u32 format)
+pixel_read_t get_pixel_read_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -279,7 +279,15 @@ void *get_pixel_conversion_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &RGB565_to_argb_u16;
 	default:
-		return NULL;
+		/*
+		 * This is a bug in vkms_plane_atomic_check(). All the supported
+		 * format must:
+		 * - Be listed in vkms_formats in vkms_plane.c
+		 * - Have a pixel_read callback defined here
+		 */
+		pr_err("Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
+		       &format);
+		BUG();
 	}
 }
 
@@ -290,7 +298,7 @@ void *get_pixel_conversion_function(u32 format)
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
-void *get_pixel_write_function(u32 format)
+pixel_write_t get_pixel_write_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -304,6 +312,14 @@ void *get_pixel_write_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &argb_u16_to_RGB565;
 	default:
-		return NULL;
+		/*
+		 * This is a bug in vkms_writeback_atomic_check. All the supported
+		 * format must:
+		 * - Be listed in vkms_wb_formats in vkms_writeback.c
+		 * - Have a pixel_write callback defined here
+		 */
+		pr_err("Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
+		       &format);
+		BUG();
 	}
 }
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index cf59c2ed8e9a..3ecea4563254 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -5,8 +5,8 @@
 
 #include "vkms_drv.h"
 
-void *get_pixel_conversion_function(u32 format);
+pixel_read_t get_pixel_read_function(u32 format);
 
-void *get_pixel_write_function(u32 format);
+pixel_write_t get_pixel_write_function(u32 format);
 
 #endif /* _VKMS_FORMATS_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 21b5adfb44aa..10e9b23dab28 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -125,7 +125,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);
 
-	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
+	vkms_plane_state->pixel_read = get_pixel_read_function(fmt);
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,

-- 
2.44.2


