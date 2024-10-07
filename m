Return-Path: <linux-kernel+bounces-353856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A79933BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CB6285E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910231DBB19;
	Mon,  7 Oct 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jpu+anjT"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE91DBB11
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319587; cv=none; b=hbXrb53CavMwoWD86HiyXmUL5bb6igPbE1vdVCQ5g4burXH9kUS4RPdXaoNyPK8vFxd7iRcyi5qkgCL4y5eRnzXPa+gkdBqdQsSqN6qrw2/WrO5nqLGosWel15Mhv9zrrXYcjx0lYJMeOiGbG9KgzxzTjjLYcgpI6NBf+Ww0TVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319587; c=relaxed/simple;
	bh=9mGB556rofW06HSalIfd4eO0p9rQZ2+EOUY99ZbyD8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjtaHSz0LronpKKYpnLRW+ll+d+wrneC7daddHmCd/s85XT3ymCR5JtoxvRkm0xlR3hFSkhBQMqp77HeSP+9H8kI/1XBweCpMQWZDinqCXhxVMbV8IRDYInFfgnIn8pbHSFRyhPU85lgTJc/B2iuUgHmCmVOJuFWU1cOfw9NzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jpu+anjT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE60040005;
	Mon,  7 Oct 2024 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rS9nUQWZiV3e0foKLhEBRgWJnsWmMc+J3tidmd0VNVc=;
	b=jpu+anjTB0lNSBgpA2bgJcHfap7Z2uHKyDNbD4py18AQw5JZNTvM01q/OKpav6skySIjmf
	PnjiUmI2hO5YseQXHzFk7h96WUoPw88BJwsLvcUDsfOY8U36VLx3dJcDqm9UX225gtCKUB
	MUanKa1ms3E5bqt1p5i7M0KOZF829Ec+QkMszHxAA7DVuvseLLEQjSfnYZtgt7GKe3lHhE
	bV9EcGKIBfmVhRcrmUmgHjtB+VFiAKyhGolg61NvLOGdVBm5CSro/p/JUvbJD50Xvho+GX
	K+civ1sOwvoeqZUBXJDMduxDWNQYVYG+2zu/63hCX9DRIOLDuYxsCds2oJO2rg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:06 +0200
Subject: [PATCH RESEND v2 1/8] drm/vkms: Create helpers macro to avoid code
 duplication in format callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-1-d47da50d4674@bootlin.com>
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
In-Reply-To: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7762;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=9mGB556rofW06HSalIfd4eO0p9rQZ2+EOUY99ZbyD8Y=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBarxLpfmhIzLwhk4o9TlgXf2JGbylgRdixC
 8jcc5r183KJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQWgAKCRAgrS7GWxAs
 4lVGEACU37A2MEWTRnvC5j+mqrD6zirqJTkOuKOuy0Foq9R2Idr2L3KYIkH14KaUouxe8PgCmxp
 oYh0PQ8v1uFIvV+JscDGkc004yiKdZGrZRz+0KlkOBCwpZA0abNva93JDgZf2RE5DxOpcV0RDT/
 eTjRBnbli4QyjpKxo1nZKnUJsVLko5rK5pCHVN4NNnc9Kpo9hey8RbG0gfj/bxFZX23TOAPQjZc
 qbpF6W3R9SiFq810PJ24ttcG2WaSeLHhDfFBMiN1VcdFbB+3Mq8Z4H7r0zwBHnkvTM0674PQAUq
 1uehLR69r7Tii4BAjU6LXTzMsonn8KlyxkcU1q7zqpW5ONngaa7M/FyFUr23hQwLQK6O5+9jCto
 lFQ3tKExvawPSIFPIXvrIFnuMNN87nM3/NkCylSRE+DKzmWj+aCtZ5HMX/GBsLg3aDFrJBvyWPI
 vr9Mh95autUIuRg5ZBwQBxrQUNfr6jFV7rxkht5PNsnumFkLVtWcvMfS8z2ci7LPxg/G0Er/tQ8
 844rDpdDW8+0U6oL/P/p3spB6fIHg8iN2I7fqc5yGbxhpWnvQCuvwrJpmjNMXQQ086HIX7l/X+G
 kxjKf2GHMDyGunpgWBT3Km+S1n9qTN3ZJMvu5UR9bXeUQhXOIVbJcIlM2YbsYlPWwDRdVp29iXt
 boogOoEfVB39YgA==
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
 drivers/gpu/drm/vkms/vkms_formats.c | 163 +++++++++++++-----------------------
 1 file changed, 58 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index f9841b8000c4..8f1bcca38148 100644
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
+ * @pixel_name: temporary pixel name used in the @__VA_ARGS__ parameters
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
+ * READ_LINE_ARGB16161616() - Generic generator for ARGB16161616 formats.
+ * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
+ *
+ * @function_name: Function name to generate
+ * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
+ * @a, @r, @g, @b: value of each channel
+ */
+#define READ_LINE_16161616(function_name, pixel_name, a, r, g, b) \
+	READ_LINE(function_name, pixel_name, u16, argb_u16_from_u16161616, a, r, g, b)
+
 /*
  * The following functions are read_line function for each pixel format supported by VKMS.
  *
@@ -378,118 +430,19 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
 	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
 }
 
-static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
-			 int y_start, enum pixel_read_direction direction, int count,
-			 struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
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
-
-	while (out_pixel < end) {
-		u8 *px = (u8 *)src_pixels;
-		*out_pixel = argb_u16_from_u8888(px[3], px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
-
-static void XRGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
-			       enum pixel_read_direction direction, int count,
-			       struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
-
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-
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
 
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
 
-	while (out_pixel < end) {
-		__le16 *px = (__le16 *)src_pixels;
-		*out_pixel = argb_u16_from_le16161616(cpu_to_le16(0xFFFF), px[2], px[1], px[0]);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
+READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
 
-static void RGB565_read_line(const struct vkms_plane_state *plane, int x_start,
-			     int y_start, enum pixel_read_direction direction, int count,
-			     struct pixel_argb_u16 out_pixel[])
-{
-	struct pixel_argb_u16 *end = out_pixel + count;
-	u8 *src_pixels;
 
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
+READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
+READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
 
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
 
-	while (out_pixel < end) {
-		__le16 *px = (__le16 *)src_pixels;
+READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
 
-		*out_pixel = argb_u16_from_RGB565(px);
-		out_pixel += 1;
-		src_pixels += step;
-	}
-}
 
 /*
  * This callback can be used for YUV formats where U and V values are

-- 
2.46.2


