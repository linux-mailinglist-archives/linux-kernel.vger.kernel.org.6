Return-Path: <linux-kernel+bounces-286099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446895167D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAA01F233E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B513F454;
	Wed, 14 Aug 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bfp13Y4g"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B862BB1C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623592; cv=none; b=AkYTeNEmY7ho/XmhRVxhc8B6E7GGRoxhX5C0oNJfgHcixsKIbvEokI0/IcR1hjPIkatn767PHSXRw1jAqNVf7tp/Z+VUwf5fmPNz/Ph6GyRdRFR+hYx72NitPAuVgle+fjHal/oQbV+pQBrtAv6nr947njAysxpQHmOAn6sghhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623592; c=relaxed/simple;
	bh=tHOYCwndCrcrYZ2J3sSlvyKyS5INO3/s+AeO+x2ugxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvjVLh3uglXq5XNNGPUzjH0ct5E2o7BRx2IapUMMCDErFfJATlb7E0UvMGYGcqIZEIkENR+ztLsau6SshG+ltuxNYmccP2/RRV/AnZedMJ1xs20QjzlwcU5XDnNjAy4yMETvN2MOlGB6jCHNd520fRFfbkUxUwz67U1poDIjtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bfp13Y4g; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C25F8C000A;
	Wed, 14 Aug 2024 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723623587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBWf54lXumZ+hhRHe3Mk0Bk6xMn84yJ+slIW6jLvcVE=;
	b=Bfp13Y4gmWOZpIY/pOiBq/9ZYw9xik1bz1wnQJuZwN7IAmxUYSFxZ8wx2P7RGmUhi2g+Wo
	MLfMDTSGHHToc4jwE5Rf3YaQcc7I3JL3dhEv0sqH8TcSP0nedOVpJCQjh18/Q8gkTmZg8P
	z9I1ktq+KKWvr+gNF/AX7Hw++0FzHpyh8JqaK+UYNt0enG8GNbKHXKu+bdZo9QAchqaXyj
	DFSxu1wccj4wFLIBVQLOtrlxsFg1w3A8qp7OKhWCRxx4oNWuxJnWY/uBlzdFxTgMyt3xvq
	sEvvLcHybuccOHwRMrnhti8yg6LpTgzOhxTKL/H6tZOEo+qzFua16qRLLxUm1g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:19:35 +0200
Subject: [PATCH v2 2/8] drm/vkms: Add support for ARGB8888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-new-color-formats-v2-2-8b3499cfe90e@bootlin.com>
References: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
In-Reply-To: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20240809-yuv-v10-0-1a7c764166f7@bootlin.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tHOYCwndCrcrYZ2J3sSlvyKyS5INO3/s+AeO+x2ugxQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvGiezmnsdW2O+kYA7nkoemaW2L5qDmqBOQaD3
 9cNCzDVnf2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxongAKCRAgrS7GWxAs
 4juuD/9TswEtuzCen3eUtDa9j5+pr0ZezfmHrtvWczfey3mHOkL/VnZi1gZ1mMNeCVllgwwgCOk
 JsjsVII2v5fjC2HfV6/7n1Y86hrq23cMf0muzGYmh83mipaE64T/VIffTMmZldxy41p6ObE9i0K
 iDGt44QopKdncR63CElehTtbqmfoEUCDkFv3ko468B8OeDV40df7oKBitirD1FQgBSbFWOzmQmN
 pPMvFYF6lK8lsBJ5Mjt2NY7SetHq+1vsf9HeihlMFHkkYZvLzgqCvlAAT9Bd01DkbhQJA1tH+U+
 qfhuTZDglyZKDyTRcB00Mv5z2Wi9svjZh7q8Zv2U+QRTgJ2+FjU3R65QjGgCbRlBPtpTQW8ogv9
 lnuivB7JicKJqRZyin3KrXSx+/70tUN+poFQX9Ff5KvbKuJyyjko7ga+tRTcV8g0UJqHmZAl1Hs
 ch/gfLoGc4Nre0RAFBhWIqT8kq1yw8BkJxfkedfYt0WeEJLMEEaEyKu6u1KGD17AlQecSc9xaO/
 kDCycqGYSvNxBeU83/lxbIMM+XRQNPRcdSRzyA2a8M2iccWzOnnO7oykVRyCVjk+mYHYSWU6ihK
 iRScHNhdGQ1zfuVH7dBuImR1SFJx8Emj9KleAEGQnrFv2AZ+vIEtGZRcYGGaQ927fNJ5eM2YXDx
 Kdq+ujnLy3LH5FQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The formats XRGB8888 and ARGB8888 were already supported.
Add the support for:
- XBGR8888
- RGBX8888
- BGRX8888
- ABGR8888
- RGBA8888
- BGRA8888

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 18 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c   |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index a03e07874b9f..894c83c31f97 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -430,8 +430,14 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
 
 
 READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
+READ_LINE_ARGB8888(XBGR8888_read_line, px, 255, px[0], px[1], px[2])
+READ_LINE_ARGB8888(RGBX8888_read_line, px, 255, px[3], px[2], px[1])
+READ_LINE_ARGB8888(BGRX8888_read_line, px, 255, px[1], px[2], px[3])
 
 READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
+READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
+READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
+READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
 
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
@@ -635,8 +641,20 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
 		return &ARGB8888_read_line;
+	case DRM_FORMAT_ABGR8888:
+		return &ABGR8888_read_line;
+	case DRM_FORMAT_BGRA8888:
+		return &BGRA8888_read_line;
+	case DRM_FORMAT_RGBA8888:
+		return &RGBA8888_read_line;
 	case DRM_FORMAT_XRGB8888:
 		return &XRGB8888_read_line;
+	case DRM_FORMAT_XBGR8888:
+		return &XBGR8888_read_line;
+	case DRM_FORMAT_RGBX8888:
+		return &RGBX8888_read_line;
+	case DRM_FORMAT_BGRX8888:
+		return &BGRX8888_read_line;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_read_line;
 	case DRM_FORMAT_XRGB16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 67f891e7ac58..941a6e92a040 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -14,7 +14,13 @@
 
 static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_RGB565,

-- 
2.44.2


