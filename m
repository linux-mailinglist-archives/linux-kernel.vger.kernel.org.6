Return-Path: <linux-kernel+bounces-252731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA993176C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9215D1F22643
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611BA18733D;
	Mon, 15 Jul 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GigUuN3t"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814D5258
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056619; cv=none; b=V87ogwha60JyFBXhCIArMunmraZkD7RgzxGDhpeOvqV44fA4rYUoPh+AwqR1uD5FIqfWPcbAB+DxZQvA4chbTcs3/IhYHs45MT2PvCpKlcGLe6+gUT/qQecMwQ5aJcSkmIpDzLfVfXIFmm1kJEqDdVl4LQie0JdLfd295B3ChR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056619; c=relaxed/simple;
	bh=WpNVOzh8WbA6AOhGN4gtNNfbRJ7ysNepFFUTVIwugHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KD6UfmsxgxNvkCcEmJVBP3kwLD51SQmtYzrbcWUWogK9sKpBDLbte3mwwp+TYr0J0KMvTTpH+aVkHU3Sj3AyIgx8UqyKf/EFXm0RZkFz9njExf/1YjRNZ+bMm3QzbqZw0vknQSl6IVsFM57rSKaOEcEExtBoTkHiRL5WnL1Zck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GigUuN3t; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso30262595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721056616; x=1721661416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1CAVNEyp708piBojRejIUPpryPK1bcTc+oCowoUiFI=;
        b=GigUuN3tnZyV28JS5KRxV3MRXtn2lxdXTwyqsCdFsofJP3YiKjGgk6TR37l1VdkRaf
         8+IZyoSqa72OuJe4m8zeUa48wdKISGRIFZHCQ1fc4PrHYMRJMmHp+O0WJ/+gmuKPj7X3
         UHezoanAGuDhK1gJIu5kR4pwiHe6UqvjwS4QCyIhJy2JwPP8/cKkXlBkeweZ/ACUg/x+
         eY8lgkIuYSAzBiHUkpL/gUJQ4kFiw0fL57OtGBhZTkEVJhPJae23Jqe/2DkfSpQBVKT2
         WpojCmCk+g48oIxAn2GJwah1NEy4P4dPUBD2xwWD5eq7Vvf95UInJxSRJXMeQAtGKSZo
         ENcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056616; x=1721661416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1CAVNEyp708piBojRejIUPpryPK1bcTc+oCowoUiFI=;
        b=S9SYsJm6HbYkV8Ku7EV8mwsHbwDNduJdyFHF/3/GTH5blV4QbKG06WnWeK8XdZ9elf
         T8WZ5bodq18Unt+/XhTvOqznDLD0n2blYmJPy5+FVf2wMs/lfe9EQ0DJ7GAnBsYS4KUm
         C6dAVbiBWb4GnUsLCikQrCl2iJ+b8cDdl6F2mMHDO3F6GpNZC4/vdjx3b9JjcREmJ2AT
         1PMzV0NYCqHeT0BbSIn5M9SgycS2cva3+SMtqfOaSAl5/aiT6noV03ef0/to4b5Njzqf
         d5fZUOBqVMAZCBQrEbBAYvesydKrSKdpU8G+hxY/xk26gHka+OG5zkIB+3ujLAuHa1sg
         sA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXj+ONbowjtcqjxL2KOFJsWMM258R2+xZS/OVAx1ILzJF/Y2m2Y5ZDsn07z240G/cY35aVTLCcLAKTAgYeRuJskShlBEEb3/PoKRxhp
X-Gm-Message-State: AOJu0Ywg7YJGIp1RFcvGW5ZfAwTEbqWfGuYKFr9yhgu+0uJJDbj0g56l
	E9UIri4G0vDnuqd67JhBLu02xD5A/y64l/VOQKpqFI8OY0HlLWe6
X-Google-Smtp-Source: AGHT+IE6oyJsVTFtqaV2gPzN+u1hsmchNLkDokd4ODWbDPstYtty4GVvCL/XAkJKsqO+gZ8MF3CXbg==
X-Received: by 2002:a05:600c:5129:b0:426:62c5:473e with SMTP id 5b1f17b1804b1-426707f7db0mr128603205e9.26.1721056616120;
        Mon, 15 Jul 2024 08:16:56 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc42esm125799335e9.32.2024.07.15.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:16:55 -0700 (PDT)
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
Subject: [PATCH v2] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Date: Mon, 15 Jul 2024 17:16:26 +0200
Message-ID: <20240715151625.6968-2-jose.exposito89@gmail.com>
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

Declare the target buffer as __le16 to fix both warnings.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v1 -> v2: https://lore.kernel.org/dri-devel/20240712161656.7480-1-jose.exposito89@gmail.com/T/

 - Thomas Zimmermann: Declare "pixels" cariable as __le16 instead of
   multiple casting.
---
 drivers/gpu/drm/vkms/vkms_formats.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 36046b12f296..1ff535222bd4 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -75,7 +75,7 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
 
 static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	__le16 *pixels = (__force __le16 *)src_pixels;
 
 	out_pixel->a = le16_to_cpu(pixels[3]);
 	out_pixel->r = le16_to_cpu(pixels[2]);
@@ -85,7 +85,7 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 
 static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	__le16 *pixels = (__force __le16 *)src_pixels;
 
 	out_pixel->a = (u16)0xffff;
 	out_pixel->r = le16_to_cpu(pixels[2]);
@@ -95,7 +95,7 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 
 static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	__le16 *pixels = (__force __le16 *)src_pixels;
 
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
@@ -178,7 +178,7 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
 
 static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
-	u16 *pixels = (u16 *)dst_pixels;
+	__le16 *pixels = (__force __le16 *)dst_pixels;
 
 	pixels[3] = cpu_to_le16(in_pixel->a);
 	pixels[2] = cpu_to_le16(in_pixel->r);
@@ -188,9 +188,9 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
 
 static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
-	u16 *pixels = (u16 *)dst_pixels;
+	__le16 *pixels = (__force __le16 *)dst_pixels;
 
-	pixels[3] = 0xffff;
+	pixels[3] = (__force __le16)0xffff;
 	pixels[2] = cpu_to_le16(in_pixel->r);
 	pixels[1] = cpu_to_le16(in_pixel->g);
 	pixels[0] = cpu_to_le16(in_pixel->b);
@@ -198,7 +198,7 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
 
 static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
-	u16 *pixels = (u16 *)dst_pixels;
+	__le16 *pixels = (__force __le16 *)dst_pixels;
 
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
-- 
2.45.2


