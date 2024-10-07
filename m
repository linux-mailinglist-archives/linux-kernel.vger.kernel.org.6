Return-Path: <linux-kernel+bounces-353860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E99933C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154321C23EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90781DC734;
	Mon,  7 Oct 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ERjIjuH5"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C11DC067
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319591; cv=none; b=ltvbCY+Fl3o/VbcU34PLJbqBrndkWMNGC+zK+uv7iFj4HA/Zy21bta5O+0uy8N26Cov3k0AtSLoupl/GLRuSKDJlhv+wQCNayOAGhjIeV3pdRCBUykhRxhqRKqpV7ZgY0g4YFfl7u/1jH4Is5vIa6Ss0zGGdbotfczmVsFq32GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319591; c=relaxed/simple;
	bh=ejUk7GS/wHj27mDvtIilIsC3ld6QfwwuT6b3J+l/QQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5ifSGC/Qj2UbQft4jpc2dHSJaVQMYMphukcY+FA/i8I7cDZ2HQfVQDzFNL6PRqr2Glp5V3mXIqgcyIdc1AhiSmF83sAU7saIq/MwCEXKpNYHFOf0H5jo48IJW6k5yxlkCKRSJtyeeRyehNpa+ZTN+3ANqfS0CCKibQrmbyKocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ERjIjuH5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A29A24000A;
	Mon,  7 Oct 2024 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUZtJbmneGZ+YDYKXPZlJ4H5daa7MYGpaeYcet1yA+4=;
	b=ERjIjuH5kcpOrHg1MTdA66XBy+TseV6GZ6uvCl2j3JBeJo6OJ+zywCV8P4Uosmj55MExsu
	4IDy0v0oKnmeQMNTnfzzFxdW6isLctvguOCXcysEwTpqhyLOaqSnp+IpHyw7JcVTciDuBv
	s5lxP8+H/TlCuG11Kx/MSmNPBrvBicaAGGHecyJTKDr1Zl1a54/IYeXg67VNq7MTrae8cf
	OpWRP50nYAQtrTNhw1YsIw6UXYJsDA/zyZJeBOJA8K5e1QLWYp4VylAISOUqf8WDRMhdLX
	Mf00eHnWMW8NU0AMrdjyehlOAV0O1Xxvvj6ykV46ITsicqWVB8hAf4qzg/cA6w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:10 +0200
Subject: [PATCH RESEND v2 5/8] drm/vkms: Add support for RGB888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ejUk7GS/wHj27mDvtIilIsC3ld6QfwwuT6b3J+l/QQU=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGcEEFygqa2gVvD5i+nmBNcpxWN/U03jKrNmhXVHpTSf19r72
 okCMwQAAQgAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJnBBBcAAoJECCtLsZbECziChcQAL7w
 8HuxKW9q2+67I8twrwe1h6QjV3qnWmcFrUK0CASynJmlxBwJz5b8SoazK0CYMySXYmIFrq/njHz
 k2QlZc7gmIoaS//6z2qHrD7eGFD++3Ycc2wikRxOpeWRI21lrXMPkUnotL+u/EvHi6YJa7aHFWC
 wHWR1cpbRmtwjtQcE7GAbGwi5qzY0w1Ho9nHh6srt80LFZ7J7vWovJn7LdnxnJ/sq3Eq06DitbI
 lAiLhzJPNyUy5Hz69F6xWSGtAtdmvIgN5JSE7at+97me/pDTYTT3DeeaK3MVhJSqp7fwhAzzTuE
 9RANWHUKVkhtEaHmkeUYC4Yk7V7NJ56NcGSXa1ipMXNyqs3BhY2EEt0OybiNFsnexI06J0d5jt3
 PqgKvS1xmsYMr80v0qYeuV4lNAS5oQqrK0L0MlGeEbrngdG/LD6pxRCFK83fGD+MR6LA0RiCJ0R
 SxzIdoRJQqZ+SgTmx/NC2if6e89vj7SZ0tFUuhO75yk2cGwhqWWnHJbhkgGT5AFnmsgV5L2ow2U
 SI1LArOfS4RxRh4p6nxx13E+Zmk0VIqakho1oqBFmI3tFsk8sjn0p88UbqJxjgvOVOaB6n/EeAr
 kGyZWiousOy2E4TLNmy4DJczrP3CYySnmfH8B1Qn85AF70AoyAdnAFTTvpdyBEZzBFxaysOx/fP
 5L0Gt
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
index e34bea5da752..2376ea8661ac 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -461,6 +461,9 @@ READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
+READ_LINE_ARGB8888(RGB888_read_line, px, 255, px[2], px[1], px[0])
+READ_LINE_ARGB8888(BGR888_read_line, px, 255, px[0], px[1], px[2])
+
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
 READ_LINE_16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0])
@@ -679,6 +682,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
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
2.46.2


