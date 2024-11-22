Return-Path: <linux-kernel+bounces-418472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F09D6204
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F7A283139
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C611148FF3;
	Fri, 22 Nov 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N+tHvqXE"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075C1DF260
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292354; cv=none; b=rWHw6opsuOXp+6B7ze/xN9jqzijDTDVVznWi73IMkICXblxX5lXPeJZfU9ewyHccGSXdzobE0J61HqdLvMv+YGM51tQiO3QKiX+VGEYGiVuAihvPH67R7+R+qvfJy5BmaEM81rzfuvrFsDbKjFiPB9Xc2PS1NnOxlFLVUFJRrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292354; c=relaxed/simple;
	bh=dbQqGdgqZ8VAgEmYe7A7eY51kRR6HJWf8pH66nmoElg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1CVybpBpkUCIkGu+BjMgj5GLsIDlZevYPPBGNe70XHn3buwtixb7uImnxwV2AUyiNTzL3bnJmG4IADp7q2M/okyKoXIdiwMlr4M/+M0XDUzPH/gkiusGoDz2oEAszdBBgwijoJbt2hX44eDXNu/2FJetSISt2lrYGUrgzxLPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N+tHvqXE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5367D6000C;
	Fri, 22 Nov 2024 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIvwz0pMdTQMLcy9cYC3AU7RkUEZgto8FvismTkIrSs=;
	b=N+tHvqXEcPO2gO44inl2Xg/nQfAKdUUuVfCV+1VOGbRWAyNvZbjg/E0V/JpBf73eP6CIV/
	NFaVooEZ/gJlBZWSzTa4Djd3wGwJjmRan5J4MBsj8v0YUSAacML88U5uZYzGOaHn4M41Eu
	MY6rZeRNJfNJqYkJHyRuqMZSYWRVGYxSZ13C1oJAzqX7jnyoal4W4qsoRM7Mm85xoD0VvJ
	Y/hhtFHER//UWDpOYxUIvQGWWsI0dPbNYuRPie93PX6paKKP6USyTudZN2Xb+uKNLm6kJv
	wN9nJhWrTdkjZvWgXuaEE5l3szl0BdnPx0SwIqaezWsNQS3RZGh06HgZC40HrQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:19:04 +0100
Subject: [PATCH v3 4/8] drm/vkms: Add support for RGB565 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-new-color-formats-v3-4-23f7776197c9@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=dbQqGdgqZ8VAgEmYe7A7eY51kRR6HJWf8pH66nmoElg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK72EuhD3HojzcS++/C2YbSlXeLXoG/xKpIBV
 XS+qw8okLCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0Cu9gAKCRAgrS7GWxAs
 4lG8D/40yM3aDRWaUpIrbrAqJM0w1MFLA45iwaBfyU9VX1eskpGbUal7x/rThqEEqJ6Wm+GiMKu
 sJUgpZhrH/fIl91y46tcpRt2spt0E9C4VpSh7QjEMuSuyM+pHPialeNb9z8994ZYuHiClzjIaU3
 o6tscy0CDIeNrX12suphMMKfOzyWrDUPDWyV+X++O4eW9IFW+4aIrI8RyAuWqgmPl9XLQd/eQG3
 tsupLT23EAHJLEJLtLHjlGV3vDbOlrTwNQSbIEm2+DlJyOztDk21W0bMxfhstQWYp2YSB0gkCy4
 QUGcJQmT/Sazir6JJEQgDT4iTx2QpviRbYwrHbBe9inu+MMzlyI8qRkcZLxl4sgm9w5HvfHIkyC
 6HtuoGmEcgys5XWA+pUQrJPwfJSfrL8O3hNuyUo+q7TB8Hr3NZtroNaVP5JmNCzeGCl1yJu2En4
 8S0XI5lDoUCr4BYt0eSrGLT8UxJEc1Xi2QB3S1dtG+FXE5YLBXVu+JdKYGaulzri4om0eWu4Hjd
 BJdasn66JG2TkThqDKdeafj34zOh+WOdfFMwo201swMqZmB6sefntianFNxO+minq3XPFfqrNAb
 6lr1GGjQovnk/JAToLF4TRqQylHhlavdNjjlS2yalxfz+WK0WngA1CCsCMyiecRnZqULZdhwQsj
 JbjxVvANrcQ6QGA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The format RGB565 was already supported. Add the support for:
- BGR565

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c   |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 1f12607c9009643c5749611a5001ece2b775e099..7af6c5c048d5c482f47e4bd7954b765bc2d13b9d 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -259,6 +259,26 @@ static struct pixel_argb_u16 argb_u16_from_grayu16(u16 gray)
 	return argb_u16_from_u16161616(0xFFFF, gray, gray, gray);
 }
 
+static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
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
@@ -447,6 +467,7 @@ READ_LINE_le16161616(XRGB16161616_read_line, px, cpu_to_le16(0xFFFF), px[2], px[
 READ_LINE_le16161616(XBGR16161616_read_line, px, cpu_to_le16(0xFFFF), px[0], px[1], px[2])
 
 READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
+READ_LINE(BGR565_read_line, px, __le16, argb_u16_from_BGR565, px)
 
 READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
 
@@ -668,6 +689,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 		return &XBGR16161616_read_line;
 	case DRM_FORMAT_RGB565:
 		return &RGB565_read_line;
+	case DRM_FORMAT_BGR565:
+		return &BGR565_read_line;
 	case DRM_FORMAT_NV12:
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV24:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 505847ec850855ee5c047985b0811416ff94e51f..d3783a8f84c203dcf772ccf84dc32a6ddd4fc573 100644
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
2.47.0


