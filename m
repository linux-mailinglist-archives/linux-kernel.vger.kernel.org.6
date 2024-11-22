Return-Path: <linux-kernel+bounces-418493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BA9D6237
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D9A16066D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745351DF759;
	Fri, 22 Nov 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UQ2WTsKl"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E1A0B08
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292716; cv=none; b=RPT2DpoWzILKILRh7XP/G3rMU9mwnZrJIr9cI+A3LG17zXBV/fcMuMUV/21aZW6frK518eVddL3kxSTqI7DW1or9TR05soLHN0SpkZL1p0LYtQhQ97jYq+yNieeoGBQW6LQrAsF5t/bR+VPqaOtbeCByGUyBjqbFBrPtPEl3lQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292716; c=relaxed/simple;
	bh=RoqCewqT3TKP7Wxmp1Mjkb0PcZ0QIg4QsOF4CrLNhpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOdv59a6jmehMk9USL5a2eVytNuerEddWdqazJFe2WVE6ml+Ocyv50sZQeBCoLO/tBS5v0oTGA+08IMl9syUDTRlLlpLU1K9SvdwrLDlXGGNzQRxcDKfT+L+9h8PxGKIDY5lTwSNMF0my6ByrMFoYg5i76u/1dS+dObTNf1jpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UQ2WTsKl; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F971E0003;
	Fri, 22 Nov 2024 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5utM+I0xu1pJxGdU34PkZq3EfroSNhCwpZdApnApPr8=;
	b=UQ2WTsKlocKhCCwTpHxuYJfyeR+eM3hnzBuxCgvVClD1dxx1o1HBZ0sjK7Ow/Vc+X9zusL
	jU2JThv738KNc+EyFYMTAssPOLtueI1VISk+ISUZLCycCV9woxMDppNDb2XNowFIw+MMKA
	JF8LgNXqbba4rHQoZTTO/XSapC4Bvh0Y+pUliaX0xzVXrRz+nwA4PqZqUl4fXN3AYwJ9VH
	sAx+fy6DavT1l13i0c/Ek1RG3mXzbnm4zEIzxFdt6c1yTxMNX51Bwj51RyrNt/1GCGzqsn
	vyaKadvvEAH357o9d3ubA+btPfnRZqLT+v75Qj0W4lWXS0QARr0VPeA10S94bA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:25:01 +0100
Subject: [PATCH v3 2/3] drm/vkms: Add a macro for write_line functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-writeback_line_by_line-v3-2-085d5810f6e3@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4631;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=RoqCewqT3TKP7Wxmp1Mjkb0PcZ0QIg4QsOF4CrLNhpU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLBeACDzwdeoBJbvpctDZylawm/HIGbJFpIhB
 wiT0YTZUMSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CwXgAKCRAgrS7GWxAs
 4m4PD/4voNKH3JH8lHhjExaoTKBR2+H4WnUu8oaNV+e2NsLNnz2+SmjOfWm7ekMpD0T4eCpYvl7
 FSI0ap7y4HJ2zU8XVQA0lYr1NlxoOu4pp/pbO4bJyWT+hXg8zyDW8MF6wDL3AYDJeRmdWP3037L
 DyKOrVBg6RDxaRKe4+sSQd1CUs9dc5zuCEz8ds2Ovs01g/6iGjU8Yw9mX209oxBfIexoOrTzbkE
 i7xFvsDVWOGxnoduOoa7cKbl6oldf27ucwugpOnpctZMLoqSx7YK4lyKwwYaxIdEUW7TsI+1TTX
 mxceuOOX7WAChRQx/QHKCzxJq/cxBVkr5g3BpABj1EVYIrWLNLp9xJkjbCzOyq+1YwQQpuUVHcS
 UfRIXYKQFxxRxH64KAMiek2OpDJoOWGsmRzbOGXrOYzZu2pZTzF+3l1rB0kT3+o2pjls2Rsr4aG
 JKEVaL4CkBOApoH7popUBdgNjsguETowSfP8DB2hQLh0XEQItQG4Nz4bJb+4xZIn4oiJ9VdOscT
 jtbJ+drvanXyo/6R1MkcYikvCc9z7BoG3YRJzWOLOG5LGkqp+3urT6R73FxGPZB/HFZ0JdkKQjs
 He05uPSK9EbsxyND6Aw1C5gR/XZnzbHD4NziSCawnqmFybMpJkxeMqOFRjx9lkfL+/ukV/UDNHb
 8UJnkv/NSK9EeHA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The write_line functions are very similar and force code duplication. This
patch add a macro to avoid code repetition.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 105 ++++++++++--------------------------
 1 file changed, 28 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index f6d0b71a05084a7f57dc8f0600ba2a2b654c4ec0..6a50a86291e50edab2058cf7d40c7efc8fcb4c12 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -656,6 +656,29 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * WRITE_LINE() - Generic generator for write_line functions
+ *
+ * This generator can only be used for format with only one plane and block_w == block_h == 1
+ *
+ * @function_name: Name to use for the generated function
+ * @conversion_function: Function to use for the conversion from argb_u16 to the required format.
+ */
+#define WRITE_LINE(function_name, conversion_function)					\
+static void function_name(struct vkms_writeback_job *wb,				\
+			  struct pixel_argb_u16 *src_pixels, int count, int x_start,	\
+			  int y_start)							\
+{											\
+	u8 *dst_pixels;									\
+											\
+	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);	\
+											\
+	for (; count > 0; src_pixels++, count--) {					\
+		(conversion_function)(dst_pixels, src_pixels);				\
+		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];		\
+	}										\
+}
+
 /*
  * The following functions are write_line function for each pixel format supported by VKMS.
  *
@@ -669,85 +692,13 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
  * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
  */
 
-static void ARGB8888_write_line(struct vkms_writeback_job *wb,
-				struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				int y_start)
-{
-	u8 *dst_pixels;
+WRITE_LINE(ARGB8888_write_line, argb_u16_to_ARGB8888)
+WRITE_LINE(XRGB8888_write_line, argb_u16_to_XRGB8888)
 
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
+WRITE_LINE(ARGB16161616_write_line, argb_u16_to_ARGB16161616)
+WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
 
-	while (count) {
-		argb_u16_to_ARGB8888(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void XRGB8888_write_line(struct vkms_writeback_job *wb,
-				struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_XRGB8888(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void ARGB16161616_write_line(struct vkms_writeback_job *wb,
-				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				    int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_ARGB16161616(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void XRGB16161616_write_line(struct vkms_writeback_job *wb,
-				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
-				    int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_XRGB16161616(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
-
-static void RGB565_write_line(struct vkms_writeback_job *wb,
-			      struct pixel_argb_u16 *src_pixels, int count, int x_start,
-			      int y_start)
-{
-	u8 *dst_pixels;
-
-	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
-
-	while (count) {
-		argb_u16_to_RGB565(dst_pixels, src_pixels);
-		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
-		src_pixels += 1;
-		count--;
-	}
-}
+WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
 
 /**
  * get_pixel_read_line_function() - Retrieve the correct read_line function for a specific

-- 
2.47.0


