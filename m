Return-Path: <linux-kernel+bounces-181098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F085A8C776E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57DF1F2210A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979B146D63;
	Thu, 16 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCxgHYG1"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC1146D51
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865514; cv=none; b=WEz+8neFNPXEqKv7DoR34gb3R0iC2FLGyPpNjG4XiaTTsrcJbQmLuq47XfXR+A48146FvxqyZixqvafUVeQP46mafZISTW3b2UizYX72bDyNf3xu5d+lKM8+rXPQuxnKz0cIBi0atyAlwRpVESiZUs+8euXbpdQTI7G7cBH9JBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865514; c=relaxed/simple;
	bh=5IfsKnI5XKfHej2TaJx8ofttFTvbQESKWNRUCYM4Rus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1ZFkR7u1HYUOG6gR+ZA9/DEFFargyL+F0fRr+VCb4RjEkIaEA01pKuP8fGw8EkeRU0f9A0B47kUZn/aPyGjjQomUou2E1OC3UIAWMfLYtr3KLldJ1yNWjd862bIa/XQ/ihpbA0AnfedYTGAsd9b/yWjw97ggGO6a3gVZ+D2a4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCxgHYG1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 968976000E;
	Thu, 16 May 2024 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx9t+d+xMex2ioN1WTpmWd+/kN+q1C09EL0d7wxjZ4k=;
	b=fCxgHYG1dygL6ueJKKJN56gVjqp8TKyyyeBCdnIaPdQWADUurPsmtis68T8/gDRf4jNdy8
	7rL4tAZegrJWdX8Fbic7tm9jptky80owYdFZsOgeDSf4/VAYrBidwQBh5jNMUhxYNr4ayq
	oHKsOzy1WWspgULPFMOkACIm6G8XqJ9619ZSGF6DTDB3eEMs7Td++hUm1V9rlrnIqp+Ydh
	AEpGFG8Tf5V+MCP0GsVbxrRdOHRXJ+mxcRkP5P9DhAiFEJphumfpuVdjp3BoSGXu9KPPBL
	IHJJBPTNaquJL8xRA9YPDr2u4k/XS7s+mu4SgtBCYszJZu0+c61lkBDeYXFfnQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:18:19 +0200
Subject: [PATCH 3/5] drm/vkms: Add support for ARGB16161616 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-b4-new-color-formats-v1-3-74cf9fe07317@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=5IfsKnI5XKfHej2TaJx8ofttFTvbQESKWNRUCYM4Rus=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgefF7k6Gb5WPbAEh8zZMhkeUPPMY1wQQjcqw
 S77aopCS/SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYHnwAKCRAgrS7GWxAs
 4kmAEACd7vRpuKPf1Megwk67Wm8GePKaPZILvyzIf2YY9DY91ZuC0QRYAy4EK5k8SkSWvBB4PwA
 E5IWFgeWjJljW5UHQPRLuwtqGy4/t5CckKxdRw/Nm9+ymBbw0H24RiRMGgZf+i+itbBxrHCjByR
 w06MOtdQfPBB0gxalHPLeVX347ki7L5omQn7T5Bo3dO+Blv7fD50SkOztHMoFQtJ3VD3Nvu3RhO
 A6ruvmbynzCT+MO04IP8z+OX0ojJ0rRfe4LLiOAGozbRfeiJNd8I6jL/AUqVRdeJrhHs5Z06Wfh
 g4/9qMGS2PyfGF0yW4+LG+bgh7StlqmqX5BIwWQkI+HCAhOQ8WYvLCiJXdWjLQYksXkTsvwiP43
 Kn+evdQ3H5uJ2Aq2CwgFti1KSuyAy21GzpqO4JLWWxl02EN3IZAc2g8Typa7WXjU45MG9+8AXFi
 +hNQh13m0yNM9nhLdE5yI62FWsufXYD4WVuyAV134Fllvjrw5gzNJo4kx2tzWE80PFYUX03G0oH
 HlpeknjTlcbyAWRQe8EV68+sCx1LO68TI9DWgPPmT/PXnuXhUkHYkuyxkcHzHj63m24O6MMk8Yi
 TCzPbPK0ilCNVqTeYitArhSBmIzQ0HQDkwJ76ccaBtFUVL//2YIymiItmls/f3BTtictEQL+NIi
 Wsl107/fRd2UPnw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The formats XRGB16161616 and ARGB16161616 were already supported.
Add the support for:
- ABGR16161616
- XBGR16161616

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 7 ++++++-
 drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 54fe03c2616d..e9cca5ae57bc 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -452,9 +452,10 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
-
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
+READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2]);
 READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
+READ_LINE_16161616(XBGR16161616_read_line, px, 0xFFFF, px[0], px[1], px[2]);
 
 READ_LINE(RGB565_read_line, px, u16, argb_u16_from_RGB565, px)
 
@@ -681,8 +682,12 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
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
2.43.2


