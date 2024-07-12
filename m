Return-Path: <linux-kernel+bounces-250904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65192FE53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B711F2369E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB0175545;
	Fri, 12 Jul 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYZFlM0J"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0D16F8F5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801060; cv=none; b=GrYn6CUBIC6BG/KRjzANfXuK9Y5wTu34xfHFRKQtXOOgNhPApjReO+e9V6hhezO4gOVC6o6FQZC/4Ho1S7H4jHCV27tBs+9oOiaIjee7i2jRhKGVhnJGk70bJRWBIUj/6S4Dz8qoVG9g5pZQoP8p0OEmPY0kxbPC1E7w+Qe0guU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801060; c=relaxed/simple;
	bh=+BuxBqLkeYknLpgwiO7RECh7lc6o9xlgcLK4jpb35o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsNmhgiFppRA1WpIrGo9aoTlwu/L7Ug6oEA0YI6s6RVCcoZ8vF/ELG0YwiRbOxdDJTPMURha2ATokeJ90m9H+av7VJNmWF3U2zOsKBn3YERItU/w7IHUr7kmXCkjWP0UcAg0cfHKx8xmtlZWVS32jdFSVQq5FzEjtW8pL4yKYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYZFlM0J; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso1259918f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720801057; x=1721405857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbJoy2m5aoNCDq8f3t+gfMSoffEHVypJP0uEKVRuHxA=;
        b=lYZFlM0JoaoYoGhGTZ1kV2lmyV9uiIAW2tl7boVnLc8W6hHD8d7dUyQ69o9Fo6dCex
         iu/019hO73IrqLe/+wokySZoftYBViFRupJIhgQoq8XRTb4UcQtEeqIpZ0QnNSDbotJz
         Kzqt1AD3GGCVIAgauq3MTq6SQq9oGD15obw2oBIrahhx98CvD767G4zJd8fBM+VVs3GN
         0KXrpLZD8Qg54g/z/ty8Lwq9upD3fhifRHpLnu1Ku+FSkwp2yR4YlBu7bZI4/pHDZ2Y9
         JrXI5lwhj1EY185Ff9wYaIUMi5+8QIQ3uENLcOqGph/cTzfSaFDfuc/dleR1gQG6K4X9
         kkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801057; x=1721405857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbJoy2m5aoNCDq8f3t+gfMSoffEHVypJP0uEKVRuHxA=;
        b=NwetOu+MCaL5QWzsOSvej5GhxAm+2EcA3gxd44HLtbGhmlRekMwS/WOe6tywRj4dAD
         sXYFNAhWcoLJzEO8uF95gJf6GY6vDFNnwtKS9wdiOAn7D+WHVWWBVG/qNH3djQQbsZCe
         ksvsK3x4B31eRDh+/o0iiMHJ25i8DGCVRWKoBbOqnxylwF6mrEmLC7BaQQQUMNTByFnv
         YZ7wi67NyjftiDbrWHlJZAA2cyQrJhuuZhy11hiq6EQjk3rIDWyi3e8w/SN1FHRgBYIa
         y6v2dL3Yb5cMQW+r+yhWvbVflEW3qHB1qwF9uH26Wv7pMOMnf1r4p4coNyDPiKf5zBHb
         7MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpogfe49p5/GyPe0ToGVUWotMPh9maMNK5rjOZQ1xoAifuRfJuYlmSq/22m9YtWI8vHxOTlhYFATOyIakJhZ0lcqkq1Bs5fehpYh80
X-Gm-Message-State: AOJu0Ywv+dXT2qTgo/t0rkJmuSB00Kjfel7K5sYoy4Vzxs1A3kqr1cMf
	Cl2rwZm6tWe6rKq0v+2l8z7gZATIEKTABuN8lGUU8yMfpRxIeFNI
X-Google-Smtp-Source: AGHT+IFWxN4rabKRUz5jKXIs3M8YQGe2GEQUzwOkpeAL4/186T7kLbwYdXf5FMtAiaktuiwnfpiNqA==
X-Received: by 2002:a05:6000:2c3:b0:367:f281:260e with SMTP id ffacd0b85a97d-367f2812acamr4537665f8f.3.1720801057085;
        Fri, 12 Jul 2024 09:17:37 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0650sm10568385f8f.69.2024.07.12.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:17:36 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Date: Fri, 12 Jul 2024 18:16:56 +0200
Message-ID: <20240712161656.7480-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building with Sparse enabled prints this warning for cpu_to_le16()
calls:

    warning: incorrect type in assignment (different base types)
        expected unsigned short [usertype]
        got restricted __le16 [usertype]

And this warning for le16_to_cpu() calls:

    warning: cast to restricted __le16

Add casts to fix both warnings.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 36046b12f296..053fa6ce41a9 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -77,10 +77,10 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 {
 	u16 *pixels = (u16 *)src_pixels;
 
-	out_pixel->a = le16_to_cpu(pixels[3]);
-	out_pixel->r = le16_to_cpu(pixels[2]);
-	out_pixel->g = le16_to_cpu(pixels[1]);
-	out_pixel->b = le16_to_cpu(pixels[0]);
+	out_pixel->a = le16_to_cpu((__force __le16)pixels[3]);
+	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
+	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
+	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
 }
 
 static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
@@ -88,9 +88,9 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 	u16 *pixels = (u16 *)src_pixels;
 
 	out_pixel->a = (u16)0xffff;
-	out_pixel->r = le16_to_cpu(pixels[2]);
-	out_pixel->g = le16_to_cpu(pixels[1]);
-	out_pixel->b = le16_to_cpu(pixels[0]);
+	out_pixel->r = le16_to_cpu((__force __le16)pixels[2]);
+	out_pixel->g = le16_to_cpu((__force __le16)pixels[1]);
+	out_pixel->b = le16_to_cpu((__force __le16)pixels[0]);
 }
 
 static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
@@ -100,7 +100,7 @@ static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
 
-	u16 rgb_565 = le16_to_cpu(*pixels);
+	u16 rgb_565 = le16_to_cpu((__force __le16)*pixels);
 	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
 	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
 	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
@@ -180,10 +180,10 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
 {
 	u16 *pixels = (u16 *)dst_pixels;
 
-	pixels[3] = cpu_to_le16(in_pixel->a);
-	pixels[2] = cpu_to_le16(in_pixel->r);
-	pixels[1] = cpu_to_le16(in_pixel->g);
-	pixels[0] = cpu_to_le16(in_pixel->b);
+	pixels[3] = (__force u16)cpu_to_le16(in_pixel->a);
+	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
+	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
+	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
 }
 
 static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
@@ -191,9 +191,9 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
 	u16 *pixels = (u16 *)dst_pixels;
 
 	pixels[3] = 0xffff;
-	pixels[2] = cpu_to_le16(in_pixel->r);
-	pixels[1] = cpu_to_le16(in_pixel->g);
-	pixels[0] = cpu_to_le16(in_pixel->b);
+	pixels[2] = (__force u16)cpu_to_le16(in_pixel->r);
+	pixels[1] = (__force u16)cpu_to_le16(in_pixel->g);
+	pixels[0] = (__force u16)cpu_to_le16(in_pixel->b);
 }
 
 static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
@@ -211,7 +211,7 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
 	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
 
-	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
+	*pixels = (__force u16)cpu_to_le16(r << 11 | g << 5 | b);
 }
 
 void vkms_writeback_row(struct vkms_writeback_job *wb,
-- 
2.45.2


