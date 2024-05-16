Return-Path: <linux-kernel+bounces-181100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0AA8C7770
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE78B1C20BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053AA14D2A5;
	Thu, 16 May 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pNftCPQq"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98514B071
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865517; cv=none; b=m4EH1DUgK+L5cobDd/qXj+1GS8HL5StYQ7HI7j6DAvLlO+J+xOnGFvI4OuDOK+uMqA8tfjz+rCyybDqoPTmh0ONSGOYNWhnqeTUAkZzT9RABRmoUHP2I2uzC9dRdxssdIhzwAwb2euFjRWEcbJoIdx9ITyiF0SQr1WKBs7MNOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865517; c=relaxed/simple;
	bh=/vrxMtadDQYtqI4w4rk5sueAQ3y7eapu4/8W4sRdUvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kv59fEmOvyrYJZ00K45NTe7f6IbmhQvEbTOw6tZskpaxl+P8PrrPJy9xTxIWUrQplWTtWExFfRcqmYIZwz9t+8K2h+3XL1a0HapZFgXiKDc+ybY4qY2o6vLf7AVj+cKsMa0JlgJpXVDdH7ds9xz8XTdVWM4OPn7pnYsK3XAyXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pNftCPQq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7233E60002;
	Thu, 16 May 2024 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrS8b39rxDfx4oFYW2S/d2LnfHxde+rqsW+6XOgTsco=;
	b=pNftCPQqP1awGmnbstlU4DBekkFnYGGJX4eQo4moAulGT9IEZ3+zKZqfcaQTelHwi0KsMW
	Kq7HlJ4hOgjgQFC1uETzmgb6oMo6kQZJ4Bupmw8o0KFP9QkRFgLrUJEujd8imEkSTe0YOT
	HWAJ+ZnEerm3SAeb5vRmCsWuWBZRpgHJvGixgODkOhF3V91VdatIgkod6FbHcPcJ8beQD0
	R2qkAPNYjXliq8GyfAYZs2zjJbYLgTb/LoWT+95p87pQfuz7P8o/+4qa/5vBDaYhEX7hxt
	ITOWb+5inqTZs+VaqagW0NakMXANfAGNUjulzug9UaEqVeATcpFrQDMjanPfwg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:18:21 +0200
Subject: [PATCH 5/5] drm/vkms: Add support for RGB888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-b4-new-color-formats-v1-5-74cf9fe07317@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/vrxMtadDQYtqI4w4rk5sueAQ3y7eapu4/8W4sRdUvQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgef1emOyzGd/IpJLMvz4AbwKcC66NGrRXEYu
 fm92wBcRNCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYHnwAKCRAgrS7GWxAs
 4pHgD/9sniUJ7rD+ib4ar88c6BG1CbRJPURj6hQsJe6PoC2U89A8L5a5LP2WvC+nZoVV10o8uIP
 mw9Da72ZgX4lv7TYhypzYTZd0fZ/geoto3+VbH2tumKEqmDqt9NeaTJbalrSp1bKt9F25IbYv2B
 AW6xYtLZXK7b6+QxpgR+/3z1Y575yJZqifkl/aL+tS2s+F5nynMnFT0bwfNySAhKDk27zmJB99v
 3oYbEww9IgqW8QBnqmJz/cWHcTLidA5mvy9dlZgoD9GelFGlQHFmrFXCGwSIujYUNAzlNvP0sna
 /Z7ZaTUR6El4PwzvYfIKgdnIYKXo7aGg2mU8Jj4Kx+w/4bCbuVZe3k+r8ZuA3yNJu/ZqOkS/2U8
 7ECns5imI6lLC7b42LJRZqgpC7bULaSsp/uvV8n0czNmst4TySs87wlxUQKnqgaSx+14ntgoRXz
 yliUKFIyRrLnNphIjRT7fBC+0hBWh04nDXY+lFuw41K2C76rOmVqUgdcmrg0H1DK4pQKyruoUoB
 uv4HPcxsQC3jGFDSfFAtYekwXbLcDL+vgYH1XN/WxHITdgl6CT1Tl0vLQdP120Raeqg08x3/lIV
 PpZ59a8AkbBDaaf1oGmkK3FNOxxXXzwRCTC34aR2umd9JppRB+rqAbupsj243TvlEkW7Be6YW6X
 KIPpvsKCQ3pAxsg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add the support for:
- RGB888
- BGR888

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 7 +++++++
 drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 4d7af36aa28a..6e651f7e6997 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -472,6 +472,9 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
+READ_LINE_ARGB8888(RGB888_read_line, px, 255, px[2], px[1], px[0])
+READ_LINE_ARGB8888(BGR888_read_line, px, 255, px[0], px[1], px[2])
+
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
 READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2]);
 READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
@@ -701,6 +704,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 		return &RGBX8888_read_line;
 	case DRM_FORMAT_BGRX8888:
 		return &BGRX8888_read_line;
+	case DRM_FORMAT_RGB888:
+		return RGB888_read_line;
+	case DRM_FORMAT_BGR888:
+		return BGR888_read_line;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_read_line;
 	case DRM_FORMAT_ABGR16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index a243a706459f..0fa589abc53a 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -21,6 +21,8 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_XBGR16161616,
 	DRM_FORMAT_ARGB16161616,

-- 
2.43.2


