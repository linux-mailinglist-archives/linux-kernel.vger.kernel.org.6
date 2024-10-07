Return-Path: <linux-kernel+bounces-353857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E54779933BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC28B242B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5B1DBB20;
	Mon,  7 Oct 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+HA0GgJ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FF1DBB3E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319588; cv=none; b=VkN1Xky0iQTso75SuG9+Yq6HpFQJt9guTweIQvacUij83hfvOziAwAxVPJqu7J260ToyQJctqzez3DHIea18B7GB9uOTBL5aB/fNJ5A+usgnw5z1mJP8p0tEOcQxSvIju6crdo2NqLJW5R7T53FT9G4gyvco85WBA5iWT749IlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319588; c=relaxed/simple;
	bh=gdPmVx5gF0p9G7Is+ZemThuXnezaEwBJJ2Nq9GqmioI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iH0VZPDM3tNi2Vl6ibf1VkKBgDa51w2QKG6uFBTZGTyS1x99Z1ho4HAjrIEijEKn1Y6fsniKXJSCtKstIvPO0q1YJFH5s+fk2caaD2LFAQL9CBG3S5xjiUWsXELkQ6ptSX26ehUvgKr7QBK5swZ4yX8QwuzBY+KeP2pwoXjZ8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+HA0GgJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7DF540007;
	Mon,  7 Oct 2024 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsoIMQdz4wDrKoGlEaJ6v8bPFcpjT0jVjkTFUPasYok=;
	b=Z+HA0GgJi9aukoEaEoIHq15lDIlZ2Ir7f3wP7TttCQ7jLb1A3q22dWdHyIms8YOwus8vrw
	DyXtxxeU2TniX3o9X81kXyYmlGu3LVIScyJLakrug19Pw4lz1kPCOhVTd445nu7DWIG4uf
	TcjyJNBiJBEeyTy3snB32Q/Zpg8NiA68d1Wkp68jRrrpwEtwuqg4XUVbK0hauLuto6pEMc
	eAUDb4CApYf/7jcQ0UzHtgde17RiggUJlpLElEUIPrX4+vifN9zoBpAIWO6ptv2I1bCyNE
	x9SNudPBwaID2jDRp2rX3d1MnB3pYCWCWzw9oMbKO+a37mor22B7DdrFIuxZ9g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:07 +0200
Subject: [PATCH RESEND v2 2/8] drm/vkms: Add support for ARGB8888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-2-d47da50d4674@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gdPmVx5gF0p9G7Is+ZemThuXnezaEwBJJ2Nq9GqmioI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBbGctjHAB+1xzKIPMJi6GLs3ax8ph26aT9Z
 C0y/kEZ9TKJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQWwAKCRAgrS7GWxAs
 4hw5D/9xwAmNKH9SjFGaYfaRf5MlYlKnW89W23FxkC+pRJzv+/oOasp0GJQPzUuN9p3pwtvgGjU
 ld+KiO0HcadOvDdViq9ef4j5RPZIUy+/dpu/9RmsBki+ICVBhCoQ9yLtB4TLekJgzWGludJlPiN
 6+Dt1S3TqJuhtpPlBL+gqtE06cbom+Oehn6uXrAsJB/meO4zlS9mRGy2XnMPY7ZZGWA1EoMtPGk
 CQTYN8lqYRgR6scwf2tQokGpboDr4NPUD+v8ZKs+/IDS9r6Cmv5sXx/F6pjsyaEfyRjP7bscusb
 umLBxDjb78JJQaBrUCVZ/+cezlrPJ6C20z2Nl1qWFGPU/cdIXCyuOY5NOAgboBmEL1cl/863oKx
 Si5ziIGegSs8F7HCWEHEPsVcc9HX9GEv93pe9IrCe2pIl27IB6e8lLsTqoJCEeTDFOlnGRk7U0o
 e980P1Q9Qrt6bzikRAcgurUTft2LCpmaQ+SV3URZ1uwBVK9kIYAy6dtH2nUjDF4NxmFD6M2+ipi
 zC3F+txRtDwV94lDFlT8wHPfkZHxWh6qVHQVgyjhTPnce1zr9LRkmHRu2EIYCWNppnMKvhon04w
 qBIrdNZI8u5d8Xo3ZwnhApjPsxjp8IzNOFzL0evAr8XedMpJxBaSaUzCAAQ7GwGYI4caIxl7hAQ
 N3uwZVBLSBlylsg==
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
index 8f1bcca38148..b5a38f70c62b 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -432,8 +432,14 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
 
 
 READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
+READ_LINE_ARGB8888(XBGR8888_read_line, px, 255, px[0], px[1], px[2])
+READ_LINE_ARGB8888(RGBX8888_read_line, px, 255, px[3], px[2], px[1])
+READ_LINE_ARGB8888(BGRX8888_read_line, px, 255, px[1], px[2], px[3])
 
 READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
+READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
+READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
+READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
 
 READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
@@ -637,8 +643,20 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
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
2.46.2


