Return-Path: <linux-kernel+bounces-353858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C29933C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADADB23B61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E71DC18A;
	Mon,  7 Oct 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MgSmnZ4d"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DB1DC050
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319589; cv=none; b=S4kwgG+8rruJCOXsDers8N/B1YanyLtBCTyCv7nIO+Jb4iktNudUj9KF+IEHugU7WJsJnd+be4lB1yKSBZSVZris7EpfA7qpYNrquR4RIKq7V+2R2a6Az+fPZvMdldgyDzMIysvNTnURLGucs2SLax31lGc3NVHcNXb7vMax7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319589; c=relaxed/simple;
	bh=zdHnGJBg2gP3BAEgoKBrBRx3cyjqQ8zdv+fP4kauhLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiDebGI73e+NXCoZ1IsOvl/YXUHUb0rS3thjvRglXY2osDUmkJHQcznFLPxiuCrikPx5ppUeCQReBknIFnkbcPwTBco2n2WRVBAxC6CM3Pc2qI6ZWjpaOUnnCZ8Yd4b/Wi62ewxInfyIN2FkadVrjkcRkzTJv4vrKi2iJZsvX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MgSmnZ4d; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B14E340006;
	Mon,  7 Oct 2024 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqs1bnGU69W3MzIr9W+ombCvohHuBY06BkZDRKmcIuo=;
	b=MgSmnZ4dhd+3pzxjaFYMBittt8SY7IeyV6HGo/Z4rvlskd6jAX0GofFfokPWfV0wHd5i6U
	IspZWuSw4ooRQNATZKUO0wl+Pdc5HXX6f7aVEyr3WgG64zDF+ytIvTHG9EKrMGBYtRns/S
	8lfLW8uU1rd/SVm4IkOWXXWoX33ayZqNLGPPJl/KV24jMtiXE8y8wF+Yd7OrA3QWWDJFkQ
	ZgHq+5vkXu/M3SVUpLrk/nwprvUOMHTthHT0PvTceQG1FCQjFb3WecNWA+ShXy6cSLjA0X
	OcgvbQzUz8l8lGBV+skXIw/2A2DItfdXE848QtNsOHbebS7+Teer+PpKLldcfw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:08 +0200
Subject: [PATCH RESEND v2 3/8] drm/vkms: Add support for ARGB16161616
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-3-d47da50d4674@bootlin.com>
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
In-Reply-To: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=zdHnGJBg2gP3BAEgoKBrBRx3cyjqQ8zdv+fP4kauhLY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBbKbyLLXf+LJn9L+NsDKkiEJ2LQyk0JoXT3
 8vwKaregTaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQWwAKCRAgrS7GWxAs
 4jF+EACQR7XDx5gzKvA2WfRDMQmql0nS0hZWCMaVPI2vRhQYXUgTf0tW6SBxR1gpqLVtkgstHRy
 k7FQffSHVR732mP5iyhoUXsGfigCq7lf3eHzl5abbCDUEXw8ftcZ0I2MbjMlgRgPZG96CAIx8QU
 depnF1ZODQgnROhm6HNCfKbmH1zkO8PB7b3tsMoGBo3sBQiVaiFUqoKSljzY9d+w/hhe0DQrU2p
 NXzrFtATjkWK+gsHo0ZQTv6316gpvs+n/6usZUF93njsp+GG3DLb93HZcegHLWVCDukzSjAcJ/G
 zPg8pFI0NeH9QOHS16TWyFVFaWA/g/sg1RewShxqahjjIin2+/OY8YeVJsRt11Wgh0Jeyh/dK/G
 IFcWAK8PGGV/L956J9p/ewbpR7NbI3s1b9vlBsrRXfxp1sLfkItpq/VTw+JVJ1TxvwK74hq3Bbp
 L510CODtMbTL7D3k/A8NgsABcl4TOHuWPGPVJdh3hzByfZ8uqsQzpM0Di5f+UU9WCl+aRtj/a4s
 JgXYvqUBFVHdN4GAQxXFgnq7JcEol4uzsFBdeOqPdpNIwzVtWllFXaN1R7BwhpGZ6CjeurCB7t9
 fi4rK1gdMQsnd/Lw0xu6o1DtX4/oNel/NhR0vU3OUE9wHOZw3mjyzflAoEYQvX7IYdVAURg9W36
 HM4kUYP9zCcKHVw==
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
index b5a38f70c62b..c03a481f5005 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -441,9 +441,10 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
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
 
@@ -659,8 +660,12 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
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
2.46.2


