Return-Path: <linux-kernel+bounces-418469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3699D61FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D028210B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CB1DEFFD;
	Fri, 22 Nov 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0rcMQRZ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14876F30C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292350; cv=none; b=gzcuGZaYITLSRJmSzEwLTnVwQM5QNYETP4QOqi4hrFnjGg4VSfT61NKzkPVaic/1Fq/e+q13QTOYAxCw2xlId/bLvjQtm/kyNrW2di6aaLqNpCnd73dNTtAVJzBbCDqoqBqA2Gmy5F/AvVrFKeP4kI7uqwbnc4jXlqH8T5n3AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292350; c=relaxed/simple;
	bh=DCSX226vwuqHCnEOZmjENkcyjWmhEEVjaWFvKST7rQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXrQ5Jg4eu47j3EpY+B8onmsIgwbULs71q27eWUy5H4ljkwSd1r4NE476VH6cB/fOxB/nW2mVPEo3oo4rBoNHScP3O5ZTy27PJrUL1mJSRVESWEr+OlERvxWopYH+mOQDSYq6KEgB00Xmc8lH25oWEMupn1skqzbmYxsnqPGP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0rcMQRZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ABF760002;
	Fri, 22 Nov 2024 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKPlLz9ZC/4CRqq8g5QxpCOYxnAFDUMpkF+GuYmvk1M=;
	b=Y0rcMQRZ87KOYYj7QFPuC805fGXo7mDiUEK08eJhLub5cGgQwQ6g3qogT4Y7IIXzDgwwIa
	bAZqaFAin2TjsKpJDLIDQs5bqMAhT+5pgKv9cXXKs9R1DCLlDdd6ooV09TD3sc98qi3gNy
	tXHnPTyAYhmbdBtLFESRoMjC/qVOshaZZLtcb4nhfzC9PvMSJXodqlfXKDXDTRbpxHxVwe
	MD7K/19DVQxStdKIDMzjHjaPY/Yy9IyIax6T1A6++r5ojIoPlhipQu5my7CYh5s3pLYZn9
	X0VAsTWwHuzq+PeEk0E/QvoFBYVJ74zUifxfk9GXFgcqNz5p296jk6DHbGXCaw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:19:01 +0100
Subject: [PATCH v3 1/8] drm/vkms: Create helpers macro to avoid code
 duplication in format callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-new-color-formats-v3-1-23f7776197c9@bootlin.com>
References: <20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com>
In-Reply-To: <20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com>
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
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7839;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=DCSX226vwuqHCnEOZmjENkcyjWmhEEVjaWFvKST7rQA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK722R/bG0K6WvwaRwCUYT/w1exnxyDqkxYoS
 KZAhjrNluKJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0Cu9gAKCRAgrS7GWxAs
 4hvlD/0eRnqUgUxXeZE0S4l61LADGbz8ze6ecWrwWuBggsKiV95RyiCUzadelagBjKTsTPk0p0r
 49ha4Q2txnEXIk1ttBm9RYanew1LPukbkMXfrLVWHPDrc0/w9UmoGV1HJKrmxtitgg4RMpeiT4S
 vurgOEWtjaSqVYeVwbuAOeCd7a8JVML+ZJQEaHYKpJLtWBB64S9VoMKvJDAmgHYoQHncWRvKmun
 88wS6WzEKIkZx/zq5bOXx9hBy4+Y7LXqeE+igIorKtcIXoo+4pY/YR2a7B60AIyNThyhjF+Z32p
 XmwCyD1nxPUYGU3hJF2e6sURHELneUFgJQkcsMhrZmLd4a/NNTqkTq8snBNPDrf0tIMEmJ/l/5j
 azIBbTgPmGJcjKCRBLa0fhZPY3jla3Ji2ufPse+LjOr1Cy6G3QfnDnhbDRfOiQZTlQOQamIb5er
 zmxdHjRFR/EgrpU1pjGBWdglIxkhx93d7hgrsBkzNnlfRnzkHUR1zg5ePk/stIz5mfr0bJd8RuZ
 Xr4cVykeSnwc4KyyfDRHLoRd98YdJTTblkxHt8f3cSAHNqnMcAJzcjIvMI+lPR8UMOAa1t2By8x
 Dy+xIsbdxsD/Ko+eGJtBptDbzH4aOwvmVI18GxM930yu96DCOypsaCaLtCJW6c3zLvplk3qV24I
 78tWYdMN7NyPPdw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The callback functions for line conversion are almost identical for
some format. The generic READ_LINE macro generate all the required
boilerplate to process a line.

Two overrides of this macro have been added to avoid duplication of
the same arguments every time.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 164 +++++++++++++-----------------------
 1 file changed, 58 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 2edf1ceccd37ad3a2f9f6d2dcf2044c98d9e10f0..9c4aaca7853102b86dcfd8e39a8f70392d019aed 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -292,6 +292,58 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1,
 }
 EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
 
+/**
+ * READ_LINE() - Generic generator for a read_line function which can be used for format with one
+ * plane and a block_h == block_w == 1.
+ *
+ * @function_name: Function name to generate
+ * @pixel_name: Temporary pixel name used in the @__VA_ARGS__ parameters
+ * @pixel_type: Used to specify the type you want to cast the pixel pointer
+ * @callback: Callback to call for each pixels. This fonction should take @__VA_ARGS__ as parameter
+ *            and return a pixel_argb_u16
+ * @__VA_ARGS__: Argument to pass inside the callback. You can use @pixel_name to access current
+ *  pixel.
+ */
+#define READ_LINE(function_name, pixel_name, pixel_type, callback, ...)				\
+static void function_name(const struct vkms_plane_state *plane, int x_start,			\
+			      int y_start, enum pixel_read_direction direction, int count,	\
+			      struct pixel_argb_u16 out_pixel[])				\
+{												\
+	struct pixel_argb_u16 *end = out_pixel + count;						\
+	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
+	u8 *src_pixels;										\
+												\
+	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
+												\
+	while (out_pixel < end) {								\
+		pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
+		*out_pixel = (callback)(__VA_ARGS__);						\
+		out_pixel += 1;									\
+		src_pixels += step;								\
+	}											\
+}
+
+/**
+ * READ_LINE_ARGB8888() - Generic generator for ARGB8888 formats.
+ * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
+ *
+ * @function_name: Function name to generate
+ * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
+ * @a, @r, @g, @b: value of each channel
+ */
+#define READ_LINE_ARGB8888(function_name, pixel_name, a, r, g, b) \
+	READ_LINE(function_name, pixel_name, u8, argb_u16_from_u8888, a, r, g, b)
+/**
+ * READ_LINE_le16161616() - Generic generator for ARGB16161616 formats.
+ * The pixel type used is u16, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
+ *
+ * @function_name: Function name to generate
+ * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
+ * @a, @r, @g, @b: value of each channel
+ */
+#define READ_LINE_le16161616(function_name, pixel_name, a, r, g, b) \
+	READ_LINE(function_name, pixel_name, __le16, argb_u16_from_le16161616, a, r, g, b)
+
 /*
  * The following functions are read_line function for each pixel format supported by VKMS.
  *
@@ -378,118 +430,18 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
 	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
 }
 
-static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
-			 int y_start, enum pixel_read_direction direction, int count,
-			 struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
 
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
+READ_LINE_ARGB8888(XRGB8888_read_line, px, 0xFF, px[2], px[1], px[0])
 
-	while (out_pixel < end) {
-		*out_pixel = argb_u16_from_gray8(*src_pixels);
-		src_pixels += step;
-		out_pixel += 1;
-	}
-}
-
-static void ARGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
-			       enum pixel_read_direction direction, int count,
-			       struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
 
-	while (out_pixel < end) {
-		u8 *px = (u8 *)src_pixels;
-		*out_pixel = argb_u16_from_u8888(px[3], px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
+READ_LINE_le16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
+READ_LINE_le16161616(XRGB16161616_read_line, px, cpu_to_le16(0xFFFF), px[2], px[1], px[0])
 
-static void XRGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
-			       enum pixel_read_direction direction, int count,
-			       struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
+READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
 
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
 
-	while (out_pixel < end) {
-		u8 *px = (u8 *)src_pixels;
-		*out_pixel = argb_u16_from_u8888(255, px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
-
-static void ARGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
-				   int y_start, enum pixel_read_direction direction, int count,
-				   struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-
-	while (out_pixel < end) {
-		u16 *px = (u16 *)src_pixels;
-		*out_pixel = argb_u16_from_u16161616(px[3], px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
-
-static void XRGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
-				   int y_start, enum pixel_read_direction direction, int count,
-				   struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-
-	while (out_pixel < end) {
-		__le16 *px = (__le16 *)src_pixels;
-		*out_pixel = argb_u16_from_le16161616(cpu_to_le16(0xFFFF), px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
-
-static void RGB565_read_line(const struct vkms_plane_state *plane, int x_start,
-			     int y_start, enum pixel_read_direction direction, int count,
-			     struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-
-	while (out_pixel < end) {
-		__le16 *px = (__le16 *)src_pixels;
-
-		*out_pixel = argb_u16_from_RGB565(px);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
 
 /*
  * This callback can be used for YUV formats where U and V values are

-- 
2.47.0


