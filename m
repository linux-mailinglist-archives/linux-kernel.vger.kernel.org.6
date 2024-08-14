Return-Path: <linux-kernel+bounces-286100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC495167E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B121C21E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A214264C;
	Wed, 14 Aug 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aMPF8Iqd"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FB13D2A4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623592; cv=none; b=o14/VDJ9dv/32vIqCcZQBTR6zzW1qdxOH/od0LV0rxSctmQA0kBMqzH/1BTTEHKQ8uu4aCgpqEWo6FVoKWm9rTor4w7pIkkNvUdSJKQzCZqJ4ZgPePfQ9+HZeEzv2PKjDUMNixIzdPv1w2mt5NQHiGEvQZezAKaXZFKFljz4gQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623592; c=relaxed/simple;
	bh=U8nQOSe6mzeM/r34Hu9pqa7sb6HD4D0ZQFRXh+EiNmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=By8kEs6EyYrO7RKSxBFFRBJzv34z9MYvVdhekrMigqhL8U1apm1u5G24NS0uagu7R4YtlGnmFwHcpmGTjrdQZINblTFC9lVWLWd+MP8tnan2dzG3vE7N+ZohsBtnOcEaWaXL+sMkQ7LI9qrw61Yfi0a1hsMwY894UJzcNUpIkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aMPF8Iqd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFF6FC0004;
	Wed, 14 Aug 2024 08:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723623589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bQW4w2sqK2bHnvmD4jLbo5BQQSO4DNCwJ4IoRox5zE=;
	b=aMPF8IqdYCWqFKcc4+pX5obOXr3ZmBA/OAxDA4LQWdOVwvQpTxP8K1tkZOQZwByxneueZp
	QkZdlxe536LyzIOLThMwmAUnNsNYn7BKqiw0a4+6ZJKELHg4KS5zg9b0RMDqN0xFthcC9c
	ScYOujjq42byXzL0Rs/HDKd4C131sw+bjtUHbLcoG10Ceq6++iIZUIacBsKceWCc4UsmUc
	2oGqR/zuIX7yZmP3dnhCqeAehABX6A2ZVO7/8Ev3wjha4NQXfUwmyYpw+y4ISUnPjF0q1T
	17VuXmhQ6mydWvumhQPd6kiI7SQTJNmsJTFTPzglr/f2qkrjZ5xj/0uzHUoYjQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:19:36 +0200
Subject: [PATCH v2 3/8] drm/vkms: Add support for ARGB16161616 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-new-color-formats-v2-3-8b3499cfe90e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=U8nQOSe6mzeM/r34Hu9pqa7sb6HD4D0ZQFRXh+EiNmY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvGieA3Ipv89pfkoRjeeZqCGXtL9ep99nU5qiU
 MIx8L8Xws2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxongAKCRAgrS7GWxAs
 4oOTD/4trJka3DwIkcfr0vmGkAt32XYzAGxEM/bqz+X2ADeW30QnAOdBr8M4LPSfqPTDIQZXOul
 BWx/6RK0TbGaMrWl6mDfXWu/ZI1tXXrWD5dq+Jh1Rl1sBc0WrscKTXgQ+pO/I6HUcdyDE8X3dbx
 aHLLv4Was0F3MRHRrNDX+NIQn/EVfoN7Q5A4vKB9PToQ5rJMEXBex7Jxjupi2WXwSrMIrrPxkBx
 HL22SfK6AW9aVjvH8tk4Ou1LPov5DpvQWCIUD8RLzrStUGu2NRHW6yhvR6y69BMvBmXyMQu7ZT+
 eGAq5AsFHiJHDSLgtj9o+XfSanec2UOGEfeO+pVumXOXpLNbfVBRRORVNAtIK5Ro9aUSXSsziPB
 4SfGyMPGX+tb/n5wkRDl5BMlBZmoJKUMvpM0dSdlx5e9jA9YxsT774rbcq/nZ82DlUAjcpS0/Hl
 rdtRg9l15JW4EH2KamrOnsuNznVa7I7RHmpsLzzBeknHtIsqP5MZ34CGNCkurkh5b18sIZMwPf9
 2SbxCvQlXmPZQx3ZN3xZ2i+RWAq1RFVgH5/0Bh4xLOIXq9Vo1Ypldc0IM/tcmucvOWvQIg3iBMp
 Tb+6J6OFC2dk7g2Yoyj0ptdPP+yf7VxyYxbwMIP+1wmamjSqHJ4vpb6TfqSD7g/Nl4p0nIcV1ES
 VrdqIza5hs5YbQA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The formats XRGB16161616 and ARGB16161616 were already supported.
Add the support for:
- ABGR16161616
- XBGR16161616

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 11 ++++++++---
 drivers/gpu/drm/vkms/vkms_plane.c   |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 894c83c31f97..691fd8275f14 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -439,9 +439,10 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
-
-READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
-READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
+READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
+READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
+READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
+READ_LINE_16161616(XBGR16161616_read_line, px, 0xFFFF, px[0], px[1], px[2])
 
 READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
 
@@ -657,8 +658,12 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 		return &BGRX8888_read_line;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_read_line;
+	case DRM_FORMAT_ABGR16161616:
+		return &ABGR16161616_read_line;
 	case DRM_FORMAT_XRGB16161616:
 		return &XRGB16161616_read_line;
+	case DRM_FORMAT_XBGR16161616:
+		return &XBGR16161616_read_line;
 	case DRM_FORMAT_RGB565:
 		return &RGB565_read_line;
 	case DRM_FORMAT_NV12:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 941a6e92a040..1e971c7760d9 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -22,7 +22,9 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_XRGB16161616,
+	DRM_FORMAT_XBGR16161616,
 	DRM_FORMAT_ARGB16161616,
+	DRM_FORMAT_ABGR16161616,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV16,

-- 
2.44.2


