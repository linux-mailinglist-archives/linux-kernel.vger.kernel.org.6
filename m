Return-Path: <linux-kernel+bounces-254073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87348932E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7ACB213BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DA19E7D3;
	Tue, 16 Jul 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBPP0vW8"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FA198A3D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146678; cv=none; b=ir9SrmZxqN9ddPRoqwWCpyRBHC8lMSE3kH5K/m/IxNx0LGt3C0cSpWFFe82AjwWyDyY01U1cnbpdszNPjDsk9+ef6QiQkWzgTzmOlX3UZ1mEc+CSuct+h/DzHq82Wq+x/S6PrJO0aquQQXTCMmfzgVmSqt8a1yBjFnqzvZLkHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146678; c=relaxed/simple;
	bh=T0CVoDRm26bnnNjwj66+8ICVxx4gUeP9yxlWsjLgCbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mD57YbLuvNJr1l2Y2tz7Piim7UwClFcgWdCkOX/kRc4lSw9BXdOnvEuV/GgEFofj/jZGSnE/D7x7AvWoXb/fXWtLZueHgjwd7TEZOp2AIgW7H2A+/JXm3jok5UxALcaxtrVjonkx4sBbx8zR1/joqzo8xdt7oLM1lHhaa82sUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBPP0vW8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367993463b8so3212468f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721146675; x=1721751475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZeN1JKbn+6j0alFZ89rnlW6N1xknefS8N93zgRlvMA=;
        b=XBPP0vW8+gEsncQyauF+R0UJo1F68uAUaTGSZjJnUsFekxKXcaccvgeRgcXJPtthLc
         4zKFSLmYw11nTrJvgscpMZ3JzXzF2flE9PSw2F5q6Vr+DG7ECA5FGBuxxWRHujeXCmIO
         fblvV/JHlGs57eJjU2yG9616BXx+WJBmvXWZM9yDiEyY4iopKOU4xSzyO++bbt9ZKvuf
         TkkL5AsefvadmDsQsiRyzeJAfKa50FE4fwW5Y7O5zSVidO3QPocH/toJavq9Ikb2fxJP
         z3t8ljBwpDm+dRxJzCtkP7QnznD/JbKvYARYPGegUPuzVX1NeCufjFpTB3mhMVdIcbpc
         LRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721146675; x=1721751475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZeN1JKbn+6j0alFZ89rnlW6N1xknefS8N93zgRlvMA=;
        b=A967WxkIeHn4PecaP+wedpwEDevunDW1nMpNOyl6xup6duuN07vdkar4sLxQLZ0SaQ
         ibK4qp+a81tm7Ujot83YDLFAA0rJS0odMbu9upya907tD9XW3CuNb4DkOw6wN0h2ghD4
         /W+Ud9xqsJSsugEbbDAcyL4ClpfBN97Y+6p8zix5BSpWWahS+qhTyXtc8Mnm+k1XFR9J
         AbOx8ZOMksUQUKbnBZrxlO0iM9JTgj8rEtFlsvhRNLyDhJBkMP5QqfT8+5PrEQbAWA+p
         cfGnZoOu+5DG08wLRVKAuC3MVRAgJM5bluKBTHcpbmR3DEr9uDUFxJ4DmNoDVjUm/3k2
         3VLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX65XZ6oFj//3zRF5BdxHm55jI/xu43c0ltPYZglDjdvCsflURQvJ8zP53JTKfuYo9V/WUl0vQFnvV0YSoeUzLDjZH/RHdQs9g2ed82
X-Gm-Message-State: AOJu0YzZ44ubsUuqs6iyc9KtoGbfE4VAUA6+YTLE7w6lSOXYo7nX3s8x
	+P4zHSMdZEuZvnt5YlUdk19K9n8YDtfPDRWxcSC/qnYjIpdsPOmtNuxLrZn4
X-Google-Smtp-Source: AGHT+IFJsyBz4QKVZoFptOjpM7uP5mZ4dQVmHAesj63IFhfw0ksphWWFLeYKa7hneCDC3CLTZqPyCA==
X-Received: by 2002:adf:e64d:0:b0:367:83ea:9a6c with SMTP id ffacd0b85a97d-368261029d5mr1959246f8f.24.1721146674423;
        Tue, 16 Jul 2024 09:17:54 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccc9csm9457846f8f.57.2024.07.16.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:17:53 -0700 (PDT)
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
Subject: [PATCH v3] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
Date: Tue, 16 Jul 2024 18:17:26 +0200
Message-ID: <20240716161725.41408-2-jose.exposito89@gmail.com>
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

v1 -> v2: https://lore.kernel.org/dri-devel/20240712161656.7480-1-jose.exposito89@gmail.com/T/

 - Thomas Zimmermann: Declare "pixels" cariable as __le16 instead of
   multiple casting.

v2 -> v3: https://lore.kernel.org/dri-devel/20240715151625.6968-2-jose.exposito89@gmail.com/

 - Thomas Zimmermann: Use cpu_to_le16() instead of casting 0xffff
 - Reviewed-by Thomas and Louis
---
 drivers/gpu/drm/vkms/vkms_formats.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 36046b12f296..040b7f113a3b 100644
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
+	pixels[3] = cpu_to_le16(0xffff);
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


