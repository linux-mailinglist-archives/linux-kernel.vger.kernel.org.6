Return-Path: <linux-kernel+bounces-272808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5694617F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064761F22333
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC601537C4;
	Fri,  2 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jxqMtiBX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A861A34B1;
	Fri,  2 Aug 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615018; cv=none; b=q6WDrl+DJg1fQ4cNPn+dHVRRWPfxfGiEzxcRPOPn7Ccjf9jGjoYkq1wUP+rRiY0+CQeANbfyLra3opk3Kp+R0dvcMVZr6i3zC7+fdOBVqVadNabGmj1+3g7x9EGD69AOPeEw4BAmo1sx42Zqh3yorSCaZBpmL8ffvvCjCDUofp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615018; c=relaxed/simple;
	bh=MxX0YaTAT9e9vpWcMDCekH41mpoeJYk6h7fwnJTb1wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SB6l4VTREGJR54KfROR6RXSK2/rC6KryWkg7/zEIpZAFQWfN8y5d9+VALmvPkONcbpi5dfUaIhxyB2JTDr4aY5vGicBPLpAkIG/r0OpCud6x0V6aUiKFPqqrubz/9QJD7CVnsIJRI5ijlyj7brakksMMMduprEco3Hny7jBF3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jxqMtiBX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4015D1C000B;
	Fri,  2 Aug 2024 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y26vY5rJXiaqt/+hkO52Cwrvp6nvufYHin9NUiEIKoA=;
	b=jxqMtiBXe8F7dQfXxyIzwTLFwf7fXO22e+Mef7Z+G1de3V6LVbo4XNJ2v+9bAaLq9KQhyT
	W7RVmJWNHD0qJrTmBkJtlRrc6NqY2Di4w6mTnqu26Ql/HYjI9WnW0tOdfXUKkchI3tpXOG
	SZtJNyMfewHDUxi10draw3+od/vYxuk4pm5mRqfy9FoTJ9+yA5aecOLSs2ldVV9ckZ1g1w
	JrTUfPVS9N8tdAPUQXDv3j5iLnKPNbmBOC03uQ7GgHcwtGrCCigRdSlufxZLNNO/x1K+1G
	oXnhlAnfzU5NJc/Hg+Pz4edGQThp8zL7NlYcLAIlRtVevCtN/o6YhFaWTsCN4g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:51 +0200
Subject: [PATCH v9 06/17] drm/vkms: Use const for input pointers in
 pixel_read an pixel_write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240802-yuv-v9-6-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
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
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=MxX0YaTAT9e9vpWcMDCekH41mpoeJYk6h7fwnJTb1wI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTa5ep3BGTS9S7r4UKmlbgGHo1Pbud52oBGi
 NO26k6yu6+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2gAKCRAgrS7GWxAs
 4udDD/9d0A0w2YUVIbmzAXFfTtNIvII6WEKjeqWGOpzXnGeBembGidgJhQgSjw3vbZEvVWAisn4
 Jt75IImF6rYpkLmQ0suAzU5XtEBIP6UOSZ61sn/v2UrpRS66RSzSRWwzN9fDHHDghT3FR2SwFjn
 93zZEQNzWyL2UATwiAD+2uWzwmQ9ctawFoge9kGf5Ir2EQsIWpnlB9lMnTGLwLXq+cwV9HFBj7r
 pmXQaNicP0Vy9ueEwS2xFZltap1jYmUsc1r761QkFMpXlMOFEcZMMXI08Kn642tJ6mFglg4VEG1
 OITNkX1dyW/SCJnq7++MJa4Q26dmYoO4QgMo8uekePqg4h7tpYinXlAn4JPVrckHaIMQfN7N4L/
 jYT5VcSLvNZXxNdn1W3Ep6CQgEVX5hTFxgXO9Y54N/0QThZE+WCJ27pDcEw5vU/YRH9dPxYE7k+
 JR7KTRyh+3NE3faImNyu3USTFsC1XsffIIu2tqyyCui3qGJSZh8GMuOMRcXctQmXhtiLBxlrIRP
 OtEmmCgNAijgMU2hc0LoG8ymCNUWKNgJKz3Ky5Kbd1bWVKTJRXf9KAVIJpJPPt2ue8nHLyUB12m
 5bTQEJsupcncgIP5NcAVETanvVs4RHUhZ3GSmO0zdQu6AgFDV2yYe0KK9Sfte/BzgreYfrhoOdE
 wX1x/xxkSRLkfzw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As the pixel_read and pixel_write function should never modify the input
buffer, mark those pointers const.

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h     |  4 ++--
 drivers/gpu/drm/vkms/vkms_formats.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 7148d46d36b7..8edbf44a6896 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -61,7 +61,7 @@ struct line_buffer {
  * @out_pixel: destination address to write the pixel
  * @in_pixel: pixel to write
  */
-typedef void (*pixel_write_t)(u8 *out_pixel, struct pixel_argb_u16 *in_pixel);
+typedef void (*pixel_write_t)(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel);
 
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
@@ -76,7 +76,7 @@ struct vkms_writeback_job {
  * @in_pixel: pointer to the pixel to read
  * @out_pixel: pointer to write the converted pixel
  */
-typedef void (*pixel_read_t)(u8 *in_pixel, struct pixel_argb_u16 *out_pixel);
+typedef void (*pixel_read_t)(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel);
 
 /**
  * struct vkms_plane_state - Driver specific plane state
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index ecbe79f8dfdc..76f20e08107b 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -75,7 +75,7 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
  * They are used in the vkms_compose_row() function to handle multiple formats.
  */
 
-static void ARGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+static void ARGB8888_to_argb_u16(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	/*
 	 * The 257 is the "conversion ratio". This number is obtained by the
@@ -89,7 +89,7 @@ static void ARGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 	out_pixel->b = (u16)in_pixel[0] * 257;
 }
 
-static void XRGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+static void XRGB8888_to_argb_u16(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	out_pixel->a = (u16)0xffff;
 	out_pixel->r = (u16)in_pixel[2] * 257;
@@ -97,7 +97,7 @@ static void XRGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 	out_pixel->b = (u16)in_pixel[0] * 257;
 }
 
-static void ARGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+static void ARGB16161616_to_argb_u16(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	__le16 *pixel = (__le16 *)in_pixel;
 
@@ -107,7 +107,7 @@ static void ARGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pi
 	out_pixel->b = le16_to_cpu(pixel[0]);
 }
 
-static void XRGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+static void XRGB16161616_to_argb_u16(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	__le16 *pixel = (__le16 *)in_pixel;
 
@@ -117,7 +117,7 @@ static void XRGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pi
 	out_pixel->b = le16_to_cpu(pixel[0]);
 }
 
-static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+static void RGB565_to_argb_u16(const u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 {
 	__le16 *pixel = (__le16 *)in_pixel;
 
@@ -174,7 +174,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
  * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
  * the writeback buffer.
  */
-static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	/*
 	 * This sequence below is important because the format's byte order is
@@ -192,7 +192,7 @@ static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	out_pixel[3] = 0xff;
 	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
@@ -200,7 +200,7 @@ static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB16161616(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 
@@ -210,7 +210,7 @@ static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pi
 	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB16161616(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 
@@ -220,7 +220,7 @@ static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pi
 	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 

-- 
2.44.2


