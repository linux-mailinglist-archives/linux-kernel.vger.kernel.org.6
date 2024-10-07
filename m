Return-Path: <linux-kernel+bounces-353862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0C9933C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E671F24649
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2371DC73B;
	Mon,  7 Oct 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W3j0pvXu"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9441DC721
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319593; cv=none; b=iDhFqR49GnP0UnysbnkhBtojQdMk5F+Jomkxl53JfQ0PNxijYSyxbLL+RqgeFbM9f6M9bVIG/r7a8BC06WgbTgjZ0nY6xqJtOfCMlHpA+EBF/1RGbs6djm1P4Tmo3HzFj23/vxYsNxgQR7UzW3sFIRIZCj5JYTyAdYwnXqcZ8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319593; c=relaxed/simple;
	bh=iDCATnOisVW9AbADbs15OqvAQPMoCXX9E/U8YNafD+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRkjzjodtGNB3KDrM+KXgQ49cW+yC8F+IJfz5ROgVRiLNzsGfj1rWmzqC0+GUhunHPNswgQv5ZzvW7Fa1nOtCpWtm8zDwUnTteUWgURVn7szNwuIKlm9GMkOczgcVBshVyr3EvqgvjZNmJRvKRtE5cUBvkM4OHe3O32tJ+LxSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W3j0pvXu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 911724000D;
	Mon,  7 Oct 2024 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBFkqUw6qRPpemUWIy6XE7WDsmixV5/4fP6ZTYrwH4g=;
	b=W3j0pvXu1hIVHrJLz6tHa60A4Jy9fzQvVlZglMXt0ZR/Ge/SJKcSdUyf2TaowwxtHweDvO
	9vCC2XawoeiAAfXHO6IMJsAUGo2vgCowJtQnLEQKFg35R5yiQyNyQo4EWnaCyWdYOGiqSq
	W/NDN8OoDdmpBa2TUdti2BnjLNhdFMOEHtJLAspVIWzYIG6KEuUEm+5zuoi4ez2mf8JgdA
	L+vfq+elhgWzY5u4kMXJy/UpSOWcXrYhdglrpwf8PSNxf8IRxsKpOYTxsWkIP4tBEgL6j1
	WI0M0P1dQGvF9W4K6WZmKi4wLQaFDth0/jgNS5nBfx+tC60ZkrR3onjHrq3jPw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:12 +0200
Subject: [PATCH RESEND v2 7/8] drm/vkms: Create helper macro for YUV
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-7-d47da50d4674@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5213;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iDCATnOisVW9AbADbs15OqvAQPMoCXX9E/U8YNafD+k=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBc+tcYiQrFaWKfFBUucGoc4yU/6SBk/Quqv
 BZiRL5YWIqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQXAAKCRAgrS7GWxAs
 4t25EADPB0Jok1ppASoCiZ129LoRHGkE3skBtw83KaivTvnFqnqhOPSFrm/97iP25vLmxQ64WBL
 wBkz+8FPfiaurDIrG4dkRn4dgaoRoY15VJyHR2gtBDiRzwlUid1ZqrHpryakd1KAi7T3vjGJq0M
 7sn/I+RoiDzP0/fYbymYvygQEOkCokFQMXT0WHkKcI0X84WuOMDKVY7helgATUcMF2UP2y6pLcN
 Bw6QOPpu6SBIG7LAn/cMo25e6NWY4i8lHn70qA1Q3H9staHP2S8Q46GNpTkJhlYo5Mp/29QBb3v
 qo+G50dS+IN+WkDbZofFSnkICo56qeXrNQJRScjOuDwlWk8hd5m58o+Ff0m8vhDjDRoAuk1e1Ya
 XP8wQq93g+fwht6exFMs0gwJgEVb+nE3qg/IqzMpT4zTZoAKVV5zQqR2lX5cwMPhjywOTWM2xUS
 MDtBR7BBneuIBwHn2yW0nSimdkNXzZiBdMb9SB+y84MJgVbK9cOfMUCsN5UbR5ZIZC1NXiiJU8X
 3//TIxJkMQS5LO9xLL8IaTUj6iTs7rQM8GKB8pKmg4BT6kGSa9ZPnJ0R54hLNhfH8m6WmjjUQTa
 qJ01F2p6OUpd92vcCPOjxNtBV5zQoXHcl8IfqWSap4CtOv/V0DtaCs7sTS/c8tVYipcAW5U2ClX
 v37HZ1t04jFtW4Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The callback functions for line conversion are almost identical for
semi-planar formats. The generic READ_LINE_YUV_SEMIPLANAR macro
generate all the required boilerplate to process a line from a
semi-planar format.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 75 ++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 95ff15051fb7..1cc52320475d 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -486,35 +486,56 @@ READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
  * - Convert YUV and YVU with the same function (a column swap is needed when setting up
  * plane->conversion_matrix)
  */
-static void semi_planar_yuv_read_line(const struct vkms_plane_state *plane, int x_start,
-				      int y_start, enum pixel_read_direction direction, int count,
-				      struct pixel_argb_u16 out_pixel[])
-{
-	u8 *y_plane;
-	u8 *uv_plane;
-
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,
-			       &y_plane);
-	packed_pixels_addr_1x1(plane->frame_info,
-			       x_start / plane->frame_info->fb->format->hsub,
-			       y_start / plane->frame_info->fb->format->vsub, 1,
-			       &uv_plane);
-	int step_y = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-	int step_uv = get_block_step_bytes(plane->frame_info->fb, direction, 1);
-	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);
-	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);
-	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
 
-	for (int i = 0; i < count; i++) {
-		*out_pixel = argb_u16_from_yuv161616(conversion_matrix, y_plane[0] * 257,
-						     uv_plane[0] * 257, uv_plane[1] * 257);
-		out_pixel += 1;
-		y_plane += step_y;
-		if ((i + subsampling_offset + 1) % subsampling == 0)
-			uv_plane += step_uv;
-	}
+/**
+ * READ_LINE_YUV_SEMIPLANAR() - Generic generator for a read_line function which can be used for yuv
+ * formats with two planes and block_w == block_h == 1.
+ *
+ * @function_name: Function name to generate
+ * @pixel_1_name: temporary pixel name for the first plane used in the @__VA_ARGS__ parameters
+ * @pixel_2_name: temporary pixel name for the second plane used in the @__VA_ARGS__ parameters
+ * @pixel_1_type: Used to specify the type you want to cast the pixel pointer on the plane 1
+ * @pixel_2_type: Used to specify the type you want to cast the pixel pointer on the plane 2
+ * @callback: Callback to call for each pixels. This function should take
+ *            (struct conversion_matrix*, @__VA_ARGS__) as parameter and return a pixel_argb_u16
+ * @__VA_ARGS__: Argument to pass inside the callback. You can use @pixel_1_name and @pixel_2_name
+ *               to access current pixel values
+ */
+#define READ_LINE_YUV_SEMIPLANAR(function_name, pixel_1_name, pixel_2_name, pixel_1_type,	\
+				 pixel_2_type, callback, ...)					\
+static void function_name(const struct vkms_plane_state *plane, int x_start,			\
+		 int y_start, enum pixel_read_direction direction, int count,			\
+		 struct pixel_argb_u16 out_pixel[])						\
+{												\
+	u8 *plane_1;										\
+	u8 *plane_2;										\
+												\
+	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,				\
+			       &plane_1);							\
+	packed_pixels_addr_1x1(plane->frame_info,						\
+			       x_start / plane->frame_info->fb->format->hsub,			\
+			       y_start / plane->frame_info->fb->format->vsub, 1,		\
+			       &plane_2);							\
+	int step_1 = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
+	int step_2 = get_block_step_bytes(plane->frame_info->fb, direction, 1);			\
+	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);		\
+	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);		\
+	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;		\
+												\
+	for (int i = 0; i < count; i++) {							\
+		pixel_1_type *(pixel_1_name) = (pixel_1_type *)plane_1;				\
+		pixel_2_type *(pixel_2_name) = (pixel_2_type *)plane_2;				\
+		*out_pixel = (callback)(conversion_matrix, __VA_ARGS__);			\
+		out_pixel += 1;									\
+		plane_1 += step_1;								\
+		if ((i + subsampling_offset + 1) % subsampling == 0)				\
+			plane_2 += step_2;							\
+	}											\
 }
 
+READ_LINE_YUV_SEMIPLANAR(YUV888_semiplanar_read_line, y, uv, u8, u8, argb_u16_from_yuv161616,
+			 y[0] * 257, uv[0] * 257, uv[1] * 257)
+
 /*
  * This callback can be used for YUV format where each color component is
  * stored in a different plane (often called planar formats). It will
@@ -706,7 +727,7 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	case DRM_FORMAT_NV21:
 	case DRM_FORMAT_NV61:
 	case DRM_FORMAT_NV42:
-		return &semi_planar_yuv_read_line;
+		return &YUV888_semiplanar_read_line;
 	case DRM_FORMAT_YUV420:
 	case DRM_FORMAT_YUV422:
 	case DRM_FORMAT_YUV444:

-- 
2.46.2


