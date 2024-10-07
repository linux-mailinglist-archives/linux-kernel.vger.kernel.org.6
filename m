Return-Path: <linux-kernel+bounces-353553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9054D992F66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F5D1F22F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5C1D86FF;
	Mon,  7 Oct 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RuVNuCMi"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C41D86E1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311302; cv=none; b=bE8IfxZ8K4l4Jg7u75oDUGGF05uTee2RMGdho2vHnD/uC32+2hS0OPFW81jhrQgnsYvZhrbrfVgyT1tNp+XGN3e5Dby12jj8eo7vQObjtwCDUXOWX8FSCA9T2wnj3jUjUcO6HO95BB72cOvRtZN+d1Zsy3pYruTDkeVU1oSps9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311302; c=relaxed/simple;
	bh=sC2ZfiNDY4xgECTqPd+AKYmSo+DcTkb0JClsb2O3t5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm6zlXCQM9TmQwRK/r2biPCbxkDBleA6NbJ2GD54nv5XIu/B55le3epjiHfW/Uzt5xMURvVH1dBuGrwJdtCZkLV/5PolZ5Aye0AlEgMKoKzoJ7mGN9oJe7YhHTUV5Gs7fz42pAMUMU0SnSULAoHyxJVIQVE3koSBEplo1KmREvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RuVNuCMi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9c3a4e809so380330185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728311299; x=1728916099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LA5wp7wY9EnYR0wffKkFRyZlwphXjrwb9T4JcZsBRE=;
        b=RuVNuCMiPlpNb5i9tRuu403+j0xQKmyHKvaPJgKaSPEiUbaW6DLs1MNy6tUOfVHMGb
         s+8nF4ZLlD6sBzw5jcpTgIAbfasQnrpsymVBarHaZd/mpjWl4f5ALjVorugazIEVuHgs
         GCBp7TasynzH4aGapZR0dZ+oNhU0VICOzQLTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311299; x=1728916099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LA5wp7wY9EnYR0wffKkFRyZlwphXjrwb9T4JcZsBRE=;
        b=Do3kgt0F69Etj9fEyyLVeGKMUM0ls/Nyd6hF7/ipMF9K+9GUsxdw7ZT/r6Ma2dqUG8
         GZ7KcEpigRMsvZu6qTya1kU1GFqP1DBEhF+MOq1wv+PdGMIDAXGFyJKtNeZOsmplWE7E
         t9fmUGEpeSZ/p3HDOiEShyhe60MyVPuUVzhDFuecm/Q1sIDaIJWOaCo8sIJIl/hR966F
         LTq8ElyhNkinS97tv6RJCeowAzsBej+zoCf3e5VtEMZp5l8VrhSPvaVARVU2jPwZ1TsQ
         PVJWQwAqNXxlyS1KGE+V+Sb76EAIWrJSmzoYRXAQRDx1kD7ooxOcLEFWlJ34ET42h71Y
         1rOw==
X-Gm-Message-State: AOJu0YxEW86ll0SlfgsClzOcuv+erSe0TEf4Cpm7fsve4wFQPVG2F4UZ
	JEe0PX0vFc9aMgsLp3OgnmNClKHVS4OYjQbu+JZt51QcHOgh4IbGue4uO70G3U2iWXlKiJTEyV7
	mt+A5
X-Google-Smtp-Source: AGHT+IF7NTCYDPLXALTaPLn1Gd4+/LPhLdFUnQc2796Ur6c8+if5rFGbd6etZoBpy3kFJvhzHTDLdg==
X-Received: by 2002:a05:620a:414c:b0:7a9:c333:c559 with SMTP id af79cd13be357-7ae6f4864c9mr2054356685a.48.1728311298917;
        Mon, 07 Oct 2024 07:28:18 -0700 (PDT)
Received: from pazz.c.googlers.com.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562ad09sm260355885a.28.2024.10.07.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:28:18 -0700 (PDT)
From: Paz Zcharya <pazz@chromium.org>
X-Google-Original-From: Paz Zcharya <pazz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paz Zcharya <pazz@google.com>,
	Paz Zcharya <pazz@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: Add support for ABGR8888 pixel format
Date: Mon,  7 Oct 2024 14:27:58 +0000
Message-ID: <20241007142814.4037157-1-pazz@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for pixel format ABGR8888, which is the default format
on Android devices. This will allow us to use VKMS as the default
display driver in Android Emulator (Cuttlefish) and increase VKMS
adoption.

Signed-off-by: Paz Zcharya <pazz@chromium.org>
---

 drivers/gpu/drm/vkms/vkms_formats.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c     |  1 +
 drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 040b7f113a3b..9e9d7290388e 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -73,6 +73,14 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
 	out_pixel->b = (u16)src_pixels[0] * 257;
 }
 
+static void ABGR8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+{
+	out_pixel->a = (u16)src_pixels[3] * 257;
+	out_pixel->b = (u16)src_pixels[2] * 257;
+	out_pixel->g = (u16)src_pixels[1] * 257;
+	out_pixel->r = (u16)src_pixels[0] * 257;
+}
+
 static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	__le16 *pixels = (__force __le16 *)src_pixels;
@@ -176,6 +184,14 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
 	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
+static void argb_u16_to_ABGR8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
+{
+	dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
+	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
+	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
+	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
+}
+
 static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
 	__le16 *pixels = (__force __le16 *)dst_pixels;
@@ -234,6 +250,8 @@ void *get_pixel_conversion_function(u32 format)
 		return &ARGB8888_to_argb_u16;
 	case DRM_FORMAT_XRGB8888:
 		return &XRGB8888_to_argb_u16;
+	case DRM_FORMAT_ABGR8888:
+		return &ABGR8888_to_argb_u16;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_to_argb_u16;
 	case DRM_FORMAT_XRGB16161616:
@@ -252,6 +270,8 @@ void *get_pixel_write_function(u32 format)
 		return &argb_u16_to_ARGB8888;
 	case DRM_FORMAT_XRGB8888:
 		return &argb_u16_to_XRGB8888;
+	case DRM_FORMAT_ABGR8888:
+		return &argb_u16_to_ABGR8888;
 	case DRM_FORMAT_ARGB16161616:
 		return &argb_u16_to_ARGB16161616;
 	case DRM_FORMAT_XRGB16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e5c625ab8e3e..8efd585fc34c 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -15,6 +15,7 @@
 static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_RGB565
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index bc724cbd5e3a..04cb9c58e7ad 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -17,6 +17,7 @@
 static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_RGB565
-- 
2.47.0.rc0.187.ge670bccf7e-goog


