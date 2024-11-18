Return-Path: <linux-kernel+bounces-413381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D9A9D185B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B399BB23F56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1941E7643;
	Mon, 18 Nov 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UaBD0gR6"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6071E571B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955411; cv=none; b=VxeXnhihx5IGYUG0e9LtsvOei6wpQRYjLTyX5hPpFxBcu9H+qW4tpLCBuzznfECMQwTtk/HKL20ewSOgJCSQrK0jaUD2ImYgSEnZqBPAtu1VsuQobGwhUt7hkSvNx9B+MmRIvvpn8TRVSrT9iCCjOgDGA6LR6s8FISx7SftcjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955411; c=relaxed/simple;
	bh=pdIaunJJF4CWVPOnG7K6niTRKEbjlEEe4erWjuMuFRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bs9OvCqzB7G1zerrx7x9URs5dJ5dMuDGcFoVARnTXr8vEAAqIV09ZO4MTkbPPOhTqcJ6W46hg7Kp3hDPvW/nrhf2qhmSF9qkeHLvyhatKQk1Sqhj3zs95hRBhDEp96N7HlwCLi+2akQOgCXZ9QK7Dj0Iqd/WCxDX1Lc+Al1G/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UaBD0gR6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7442D1BF213;
	Mon, 18 Nov 2024 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731955407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvsXl9pw709fdtnCyN0TWV5ZnrmwtIlJKpLd27O+Wnk=;
	b=UaBD0gR6XvkUJAwWKTDxNdrJf6Vv0zNBo2xxpm7jriJnMM73ay3PiY5ZsMNsAz/VNei8xI
	dRee9iTplQm3JqZmFyCSG/kPbBW+BoJR7R5DOyUnQiXagGcmW241rc8dxb1A+DEzOb7arH
	QLDTHOkCQPq+FI+B4XlIYQc4BL1MAQdOCeWjfC+1vHKlDbTX47WybAAVoxeRwwO14HmKHA
	9KrbByCqIffRFTCOM+EgXSzT1xTOkH/w3rPcFeRo7iQhMg6OAzfyWZ1f2dv27qlvdDaJpc
	sV+I6G1NmyT5cJawDou+eu+7lkHvW5v9LM30pM4/jw36B/sveAAJNAG3Lxr/kA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 18 Nov 2024 19:43:20 +0100
Subject: [PATCH v13 7/7] drm/vkms: Add support for DRM_FORMAT_R*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-yuv-v13-7-ac0dd4129552@bootlin.com>
References: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
In-Reply-To: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6494;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=pdIaunJJF4CWVPOnG7K6niTRKEbjlEEe4erWjuMuFRo=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4rFHmCNdC1pCX4g4A4JekvZ5fmECPV9U0g/B
 VVY4cgZB0eJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuKxQAKCRAgrS7GWxAs
 4j54D/0fDbqIy3QQA6GzMCoqG1Hzkb2DSQ9O2DnC4aGMazcoJrx1wfFek4MVOd91V5kqXrOS8v/
 NtdaxUEXMgRlTuUa3mGe6LBoGqEqTUyFca3oql1ozAceT3z2MmzcTGnJSnPfr9HHfLx95Nxc4FR
 tkeA9bKRaHOuPHwB+WYewfy6qhQMKUrg1xSvBicinH5rCdgEj9bhqiilSM4gR0QW1Toqb47AJOi
 h1vIHbjL6D+3l9JjrKyLGDtMgH5nbRVEFPmjWZ3l9N8PP1Fbv8fhUWWnfYGICjmqrGrJNHbHA3J
 cEBycwtoA5ZiNzlSEjpEQCdPuYrLtdwbXwt50QKX3Y8nhaKlkJXCbfBaxHazrum9PpJZrTAYoJA
 lfI8SwqIgK0Ux5x/OlacD6GnY8Oa4eZ9IFgwmJGEZrhO6W6Yqz98F062TZpQse8y1/+58+Sga+y
 QyA94H6kmz8aROP27ZHcjNOkpTxtqUC4qfxy26rZ0oi1EjEUshGafIDLDON1ylxWUcG5rtH4X77
 OOsQktk/ZEhmF9j8ZDBA1vQzUHY0AunTOYG8zXOXmZswIA2cqrXHY3TxWTGPhaYfUpA+tVYG22j
 gubp8fqiL/OuE2/l9WtCS4t6pIXg5UbOQoQIwtJ0BNJemdxlgWPpADnsGgXNyLr57XXJRG/zuuP
 Ppfzk6Am66KwwMw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This add the support for:
- R1/R2/R4/R8

R1 format was tested with [1] and [2].

[1]: https://lore.kernel.org/r/20240313-new_rotation-v2-0-6230fd5cae59@bootlin.com
[2]: https://lore.kernel.org/igt-dev/20240306-b4-kms_tests-v1-0-8fe451efd2ac@bootlin.com/

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 110 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_plane.c   |   4 ++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 0b867444999105262c855a24bf03bc66d9ebea1b..2edf1ceccd37ad3a2f9f6d2dcf2044c98d9e10f0 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -249,6 +249,16 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
 	return out_pixel;
 }
 
+static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
+{
+	return argb_u16_from_u8888(255, gray, gray, gray);
+}
+
+static struct pixel_argb_u16 argb_u16_from_grayu16(u16 gray)
+{
+	return argb_u16_from_u16161616(0xFFFF, gray, gray, gray);
+}
+
 VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
 							    const struct conversion_matrix *matrix)
 {
@@ -286,7 +296,7 @@ EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
  * The following functions are read_line function for each pixel format supported by VKMS.
  *
  * They read a line starting at the point @x_start,@y_start following the @direction. The result
- * is stored in @out_pixel and in the format ARGB16161616.
+ * is stored in @out_pixel and in a 64 bits format, see struct pixel_argb_u16.
  *
  * These functions are very repetitive, but the innermost pixel loops must be kept inside these
  * functions for performance reasons. Some benchmarking was done in [1] where having the innermost
@@ -295,6 +305,96 @@ EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
  * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
  */
 
+static void Rx_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	struct pixel_argb_u16 *end = out_pixel + count;
+	int bits_per_pixel = drm_format_info_bpp(plane->frame_info->fb->format, 0);
+	u8 *src_pixels;
+	int rem_x, rem_y;
+
+	WARN_ONCE(drm_format_info_block_height(plane->frame_info->fb->format, 0) != 1,
+		  "%s() only support formats with block_h == 1", __func__);
+
+	packed_pixels_addr(plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
+	int bit_offset = (8 - bits_per_pixel) - rem_x * bits_per_pixel;
+	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+	int mask = (0x1 << bits_per_pixel) - 1;
+	int lum_per_level = 0xFFFF / mask;
+
+	if (direction == READ_LEFT_TO_RIGHT || direction == READ_RIGHT_TO_LEFT) {
+		int restart_bit_offset;
+		int step_bit_offset;
+
+		if (direction == READ_LEFT_TO_RIGHT) {
+			restart_bit_offset = 8 - bits_per_pixel;
+			step_bit_offset = -bits_per_pixel;
+		} else {
+			restart_bit_offset = 0;
+			step_bit_offset = bits_per_pixel;
+		}
+
+		while (out_pixel < end) {
+			u8 val = ((*src_pixels) >> bit_offset) & mask;
+
+			*out_pixel = argb_u16_from_grayu16((int)val * lum_per_level);
+
+			bit_offset += step_bit_offset;
+			if (bit_offset < 0 || 8 <= bit_offset) {
+				bit_offset = restart_bit_offset;
+				src_pixels += step;
+			}
+			out_pixel += 1;
+		}
+	} else if (direction == READ_TOP_TO_BOTTOM || direction == READ_BOTTOM_TO_TOP) {
+		while (out_pixel < end) {
+			u8 val = (*src_pixels >> bit_offset) & mask;
+			*out_pixel = argb_u16_from_grayu16((int)val * lum_per_level);
+			src_pixels += step;
+			out_pixel += 1;
+		}
+	}
+}
+
+static void R1_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
+}
+
+static void R2_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
+}
+
+static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
+}
+
+static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	struct pixel_argb_u16 *end = out_pixel + count;
+	u8 *src_pixels;
+	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+
+	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
+
+	while (out_pixel < end) {
+		*out_pixel = argb_u16_from_gray8(*src_pixels);
+		src_pixels += step;
+		out_pixel += 1;
+	}
+}
+
 static void ARGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
 			       enum pixel_read_direction direction, int count,
 			       struct pixel_argb_u16 out_pixel[])
@@ -606,6 +706,14 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	case DRM_FORMAT_YVU422:
 	case DRM_FORMAT_YVU444:
 		return &planar_yuv_read_line;
+	case DRM_FORMAT_R1:
+		return &R1_read_line;
+	case DRM_FORMAT_R2:
+		return &R2_read_line;
+	case DRM_FORMAT_R4:
+		return &R4_read_line;
+	case DRM_FORMAT_R8:
+		return &R8_read_line;
 	default:
 		/*
 		 * This is a bug in vkms_plane_atomic_check(). All the supported
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8f764a108b00a00e06370db1fc8a90163c8532bc..67f891e7ac585c8406c40b4dd22c2297b3c52766 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -30,6 +30,10 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_YVU420,
 	DRM_FORMAT_YVU422,
 	DRM_FORMAT_YVU444,
+	DRM_FORMAT_R1,
+	DRM_FORMAT_R2,
+	DRM_FORMAT_R4,
+	DRM_FORMAT_R8,
 };
 
 static struct drm_plane_state *

-- 
2.47.0


