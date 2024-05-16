Return-Path: <linux-kernel+bounces-181099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC68C776F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B68282B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC4145FE0;
	Thu, 16 May 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I1LzdYmY"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478F6BB4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865515; cv=none; b=W944j6KbgKIvonXC4T3puLx+/xYjWyuTg5unahxN2H3lbK2cJzTNbW1l3qmuMt1uOSCvihHsS1SAmO2EgPw8qJH7aMVXtDVNmPxQTHrhTcd08ulWHEVzkRZ8SL2W/7PLUuHilbeSZtAFjOnjdC9n+3EYYGOjq/nIgdcX3548aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865515; c=relaxed/simple;
	bh=rUDBc7Fls6lB9g+/LJ7W6Vq5BjE+64XKjkh6cy3am8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/Yagf7u0Te/UoV4g+FDmysmb9pv3IO3WahnHAjNV/lw2yjkc2JOF697nJo4fe4ycxRI+5XSWvty7yStc6TtX/L/U5IMg3p/QPFatIhjx/oEkVq0T70Mi3EZJvEeAV2fMQoxiv5r2jvEuJVuxAQpIry19qOaY+davRooAlS0GNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I1LzdYmY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 060E960010;
	Thu, 16 May 2024 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nA+RQr2o0RUIm9d018DCVym4lDDnhOksBWUi79w7y4=;
	b=I1LzdYmYzaRC0cv+59KZRCiIJ0g4Ar7BcQyMWkVGdp2/pUbzejOfQIfqbUn9QQJmLspuNL
	OCnEng3h32eM2H8Krx03mvoe7kRQqV30opv1wAdzOdY35N/xZt9Pu+Nvldj5qKuAPjxd2p
	VDA8LPW88HIa507xA8koASLl1krwLLiNUTbVS8k1X6u8/yg1P79dKd1h8DYcuDoqauR770
	9QD7hBA09KnsB8jypzJVI7WIEOP5t8KX2JGBWZXfCiSEZvmaKdSyczHriT1JkUsMCz7Xcc
	Fb+uT1lt1HpTxRYdARkpTPrMlRZ+HFdFwO+ueq0o6kIM3s/HXkJ6cs2fz1OYWw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:18:20 +0200
Subject: [PATCH 4/5] drm/vkms: Add support for RGB565 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-b4-new-color-formats-v1-4-74cf9fe07317@bootlin.com>
References: <20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com>
In-Reply-To: <20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=rUDBc7Fls6lB9g+/LJ7W6Vq5BjE+64XKjkh6cy3am8k=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgefrJqPnNpEN07KqfPNMcxemb5nNOPRNgpHN
 I/EojP6AxmJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYHnwAKCRAgrS7GWxAs
 4uJxEADYJS3QytMjXrQJWf4ZDKKIYti7sQB82/dWKm6lJySdBI9iJuvI9oea0MvkoDiZ3OT5tsu
 fjDRVo+4tB4i0ebimHN2ySUtoblF5Q45K1gMjrHHSHDa9uiQ1HPkOrmTBUccQPFNLgEQQYuOCtv
 G9HXw1mQPWCyJWlkdnEQB2oD2Dp26Kkvf7wuD1HFRWwzDg5V6hMW2SFhsUsMAUp60SUxkgdq3fD
 B2S1nvOTaoD5ZYjBS1uzMXqoLDnHdoSP8hWMujWCMXqaSJw5u6X4XyjlyXp49aAazBv8a3f6jXJ
 upbO99iYrW4ejd/GGccPvjXgHb7G3fQpO2x+09V3gLYocP8kpHkwwJwMfMkf6B3Uw4gvk07tyot
 8QmwRbD1n37J+1oIM0liM+hoPqvr3GqkJoeHqBDv4N5pn9A3wleBbUtnLmpBDI9i8s8lpiR4HSh
 p+OHJ0FgaGm+iTbcUmf87zYeXJFzQn+2ltEVgyBNMYDmY4iy1UO2FcMbyu/X5EUFmkAGdYjrwTj
 hs0KsvRHXTR1KoUFjszxlJMppCHN3rm15BJ6wdakkOAK6o/V6nHenSd0sWvVfnCLoXO58UZICc+
 9hgaW7Ro/YcOMF5OKLnsQrgF/4iWvhImXz3hWL8OOAADZUVCrjJLn60JCNcg+0v91/D83pPWlLN
 wO0XWyZzAshUXDg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The format RGB565 was already supported. Add the support for:
- BGR565

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 25 ++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_plane.c   |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index e9cca5ae57bc..4d7af36aa28a 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -241,7 +241,7 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const u16 *pixel)
 	return out_pixel;
 }
 
-static struct pixel_argb_u16 argb_u16_from_gray8(u16 gray)
+static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
 {
 	return argb_u16_from_u8888(255, gray, gray, gray);
 }
@@ -251,6 +251,26 @@ static struct pixel_argb_u16 argb_u16_from_gray16(u16 gray)
 	return argb_u16_from_u16161616(255, gray, gray, gray);
 }
 
+static struct pixel_argb_u16 argb_u16_from_BGR565(const u16 *pixel)
+{
+	struct pixel_argb_u16 out_pixel;
+
+	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
+	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
+
+	u16 rgb_565 = le16_to_cpu(*pixel);
+	s64 fp_b = drm_int2fixp((rgb_565 >> 11) & 0x1f);
+	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
+	s64 fp_r = drm_int2fixp(rgb_565 & 0x1f);
+
+	out_pixel.a = (u16)0xffff;
+	out_pixel.b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
+	out_pixel.g = drm_fixp2int_round(drm_fixp_mul(fp_g, fp_g_ratio));
+	out_pixel.r = drm_fixp2int_round(drm_fixp_mul(fp_r, fp_rb_ratio));
+
+	return out_pixel;
+}
+
 VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
 							   const struct conversion_matrix *matrix)
 {
@@ -458,6 +478,7 @@ READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
 READ_LINE_16161616(XBGR16161616_read_line, px, 0xFFFF, px[0], px[1], px[2]);
 
 READ_LINE(RGB565_read_line, px, u16, argb_u16_from_RGB565, px)
+READ_LINE(BGR565_read_line, px, u16, argb_u16_from_BGR565, px)
 
 READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
 
@@ -690,6 +711,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 		return &XBGR16161616_read_line;
 	case DRM_FORMAT_RGB565:
 		return &RGB565_read_line;
+	case DRM_FORMAT_BGR565:
+		return &BGR565_read_line;
 	case DRM_FORMAT_NV12:
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV24:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 1e971c7760d9..a243a706459f 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -26,6 +26,7 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_ABGR16161616,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV16,
 	DRM_FORMAT_NV24,

-- 
2.43.2


