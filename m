Return-Path: <linux-kernel+bounces-391044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C59B81C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47D7B22511
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A951C9EC0;
	Thu, 31 Oct 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y+K8cH1K"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925B1C3F0E;
	Thu, 31 Oct 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397228; cv=none; b=o5VhfT6owo8wKa9A9yxXgoHy4mHPySgDf8BmX78x+1my3g3/bSLENHQ4AiT14iF4nspF1zNRiFhRjDikOd2yBCzj+xm7tkGpnApNfe9KvTKTHJM/wP/y2REj1EDgBCQa7uUiLmatpmeh1jphTVGDsGGCdGXi2ywrD+72Sr+Qq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397228; c=relaxed/simple;
	bh=NJQ4BIoIQIoJWPyFV3ltFmfTqTQcgWJGwPuIgUylwt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsGuNzGyYzvxG6MMmnO8254HDX7ZtMaqnb9l6vcqaIWea/EHY/LpPhKvflu1A0GIVqCK3ZSOl5b16WuPx9bJhBwoiMSsKzd6IJ4yG2/7RImstl9JJaMyceeWuUzFD1exkFkiFL1/Cyea2rqaSQgBJWVIqfashdAhVoWCo6VD8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y+K8cH1K; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1ECB7E0007;
	Thu, 31 Oct 2024 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SzheK38TqKTamJuQO4NjG5/hQD5MrdB/SoQUKg3juA=;
	b=Y+K8cH1KSwmXOkiE3Ynp1wiglW6nXpH/+2WgWwOUpScpQifIFY1iVvLMekm9g8rFcF4uef
	bh784O11BTgud70EVOE4CGvkSvCsFXNbx23MDQdBkJdPQRIHEGscJ4Ww8DXtpMaQ6VrJ8F
	eTHlwn7EDgCKTJAsNoJQCpxtJwqqvXvXzx5jCofBP3YdM+HKXidyHvIkb0uMXXHfAocdjq
	vysWl8AW1O37j3He4TjmPkcapSDcGU/yF5+lUq1DvFNjoH12xK8UsHRKzfxpDr0XVUrDgO
	PjoZoZq/YtvHDQ5p60syL2ufajUukh0WzRy6yCLpOfNr8WUJGNwylod8uDAhLA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 18:53:28 +0100
Subject: [PATCH v13 4/9] drm/vkms: Use const for input pointers in
 pixel_read an pixel_write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-yuv-v13-4-bd5463126faa@bootlin.com>
References: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
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
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=NJQ4BIoIQIoJWPyFV3ltFmfTqTQcgWJGwPuIgUylwt4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8QcS2CqoRfghJPDC8hC1IaAkNyoJE3tRRKcA
 y3vVRBd2fSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPEHAAKCRAgrS7GWxAs
 4qdGEAC6OUsIuPHAjsX1iJre+YpRxcxsb4mRBaWN8TLubToWGD2s0fh9JdmChUH5bqBqbdPtiX+
 cpdF+cSC5GHjwSQX9g1DoGESBj+UsX/T3NLCHTJ4XQBw22qw0QMlrQ03B7q1lGdPwwklEn1MMIz
 e6uut6KUSI2T/hvNnRZFjlgpaILseSZgv5e9Mv33BR8YwIIW6nppZWw4a3kpK/2/22rnwi8fg+m
 iOEfbUsTnJhDjz1Ou5Oz9nybPDgtdfzBLM82o1ZUgHTvXXxl6zmaJ2PEDitWGLphZ22yCYVrLsd
 ACs+/0GkkoKx+FMYB7S3kFIcXAe17FGhro/2g7Q4xo9EfqnAtF2CfvPSJdFmKc6Mj7OA+m6fvLH
 0Olp/tHUoOMsR4YnvA2Kw9GMnD6JKwmbEJEFJHGCsQbdtkBI9Niqoos+RFLF39Yq7QaYOceDekF
 aOltRH+CeNwgN0nW6BvIQomvxbfjZ0JlaxjTEw78vZu3UqFUvySVP3pWe/nbwOOgSb/HIkI3yKc
 AlN3Mm/L7POFaKl5kkGEYv9TUqfLW0gxEBd9rBSuJTxdu4NQPjeNk6MADPH45EdMB0bQKQB6Sv2
 DDZDrK+mG6duiaR5QM46Br9k8g+PcpwviAVL8LYUdc0GaiBVbowAklaRu1F0fzJXiCtfBGIzh8d
 P/tzZngEli0z6pg==
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
index e0d46defed83..3f45290a0c5d 100644
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
index b9544e67cd4f..06aef5162529 100644
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
 
@@ -173,7 +173,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
  * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
  * the writeback buffer.
  */
-static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	/*
 	 * This sequence below is important because the format's byte order is
@@ -191,7 +191,7 @@ static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	out_pixel[3] = 0xff;
 	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
@@ -199,7 +199,7 @@ static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
-static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_ARGB16161616(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 
@@ -209,7 +209,7 @@ static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pi
 	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_XRGB16161616(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 
@@ -219,7 +219,7 @@ static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pi
 	pixel[0] = cpu_to_le16(in_pixel->b);
 }
 
-static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixel = (__le16 *)out_pixel;
 

-- 
2.46.2


