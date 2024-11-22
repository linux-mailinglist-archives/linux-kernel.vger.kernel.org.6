Return-Path: <linux-kernel+bounces-418471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A59D6203
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A7C28108F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774C1DF75E;
	Fri, 22 Nov 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FunLCrRV"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D61A0B08
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292352; cv=none; b=NPVqPiNS5TmQyTbklHAXXH6FJevepJikwu7JuEcmyeRlELgT0s0BU11xykQj6RzgxvE1UvLnxpqQvkA7Dawbr++M/SPQ7MB5ksn0co9eSq6oeohBblR2axewtDVr+hWdbq4E7El1SOoyayUIJ+ykO0X8QfTbOo5D3HRAaYJRrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292352; c=relaxed/simple;
	bh=P5nW6CStss6XBXJFB4mg63UIwOzvzkPZvmY9VNXeEMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVhEbuHljKRP3BJMPPAA7ozokd64IENKES6fIYGa6LPQB/FaTHCkJRUIntW0FobKKN8Cde/JXBTrXNRC6ETYTsEjirI4O/HpUr7y8aV3/8aapq1QY5zf3LDpO5hCprpTMdfZYEcuHWTP7fh1U7uqmq2EU1xUBC0WpZRQw7qrCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FunLCrRV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539686000B;
	Fri, 22 Nov 2024 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkFP2awiNhVE1SbicVB5Ya1gxVAKEjnrfHxgO70L7sM=;
	b=FunLCrRVY2b3jvn54EHv3FHXebghYZG0RKEaBYmIYapDUx+SoDzsULp9BC/Dc78bleWBZt
	kadeaBAkaPyb6853Qr68l+A25H/f9pKX4o5gdnIt+Nf1x+ut1tWL6de+UICSifcuRdS2DN
	g39Ue14fOgW0xMd6ZQbR6glqPuE1vYOGzhl8nvNDC6XzC5fRtrVSte5/Cvc+X92q6yFncI
	gUOYXvZz4uTC06jHYkO0cwv8VqNyr2ewhhr4JaVQX92gA46X0+AVPOvS2VkUG0WmMNzSP4
	C5+2LhUQcDFf4lbshx44aNln4Y8ltgc6AIZmxBp0YSqnlGJPVrfmxhkFR2vn2g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:19:03 +0100
Subject: [PATCH v3 3/8] drm/vkms: Add support for ARGB16161616 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-new-color-formats-v3-3-23f7776197c9@bootlin.com>
References: <20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com>
In-Reply-To: <20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P5nW6CStss6XBXJFB4mg63UIwOzvzkPZvmY9VNXeEMU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK72SKwWS6t/hvcDxOfnDTmQbN0sxqCu3Ra1M
 pHMChROovuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0Cu9gAKCRAgrS7GWxAs
 4oeIEACBGWAC1xr5fq6T0d2MtpKpPqxqOU4jlC0Xg5p+CdQqzx38roaFuO9cXVegMwpgRuYWzsv
 heOp6IpNLjF8KZcUAzb2uhHYV/tdJcHOoWLxQK9fQjuTU5XDfbwWqbU/A3SZrrII18dYzShZudq
 +7T7BhuuE2J9Ns1MYpNyQTdq4PTeFthY5J/j4yjO32zYncl0AI6zE1y6j37LiB4amd63+PyMCh7
 G0LeIuNW1goUrgXJUaXKUtUPQeOgRexkGU12tSWy0hlA2vs4pq0RAYmyEAvqzlL/eth1FMQLKG/
 e9Lb3jbUyZcDfqzuQfJK3KyX+o94/PoUAxK87ZWFY4rmIeTWISl1CVbrgl7O5wWLfJEpvZSwg+2
 n1B9HrH2tSf9XFIHxuL5Qjy38APME/HuYhAAqBQ3qfYQc9RFeepNJaZEFk7+qyrQlVGvgR0Yir2
 w+nKPyzmKn6FIDM+nXQ2HCHILJq1T0qKZaMwNK0UvhDpjl5E12hmyMdZ3gshG+4VWicZTsIm7d0
 HppAIsJxdoOmxhOy4BrhlSPgkWcSHqwahz2xz3lvZD8IJwgLkWEka6HznFdBZaGywfObNIIVLkI
 HVVnF/4a4tCp66yHJuAcq8uLJ+DviglGRyhNrL25GptuZQD4auEKwO8Mru4vEDL9BFmNR6f2XjK
 60OLQOsnZX8wdDw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The formats XRGB16161616 and ARGB16161616 were already supported.
Add the support for:
- ABGR16161616
- XBGR16161616

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 6 ++++++
 drivers/gpu/drm/vkms/vkms_plane.c   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 520298fc74a1e24cded8d192efbaa84041e6339d..1f12607c9009643c5749611a5001ece2b775e099 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -442,7 +442,9 @@ READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
 READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
 READ_LINE_le16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
+READ_LINE_le16161616(ABGR16161616_read_line, px, px[3], px[0], px[1], px[2])
 READ_LINE_le16161616(XRGB16161616_read_line, px, cpu_to_le16(0xFFFF), px[2], px[1], px[0])
+READ_LINE_le16161616(XBGR16161616_read_line, px, cpu_to_le16(0xFFFF), px[0], px[1], px[2])
 
 READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
 
@@ -658,8 +660,12 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
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
index b7f498944c506631f9eb237bf56000bae4f86a1c..505847ec850855ee5c047985b0811416ff94e51f 100644
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
2.47.0


