Return-Path: <linux-kernel+bounces-286127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C939516F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99D11F23E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B31442E3;
	Wed, 14 Aug 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p470ImzA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4661428E0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625226; cv=none; b=ebBgFM8cMiINbiBCZSecYdMDfPgANS7vkvWYM5ew1g1R0+0mLjvbGuSR7ClLnW4fLzytt4k4IWDQKaRPX0sE+VEjdK0rNi+k79NNqkrVghxXpCF5zMI4CUDlICwaFyt7hMUwBkTosB/1Bba5I06jb+awgdb88RKOFLSAfWnM3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625226; c=relaxed/simple;
	bh=DlA2BwdMh4xiCAsPDy0jpunVjQO6N3fFDS0bdUg8TA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iF+yS074tUwhk/vICvbAak1dZOp7igF7Uki6fiNlT27Bu7ZkouWfxoOCG8FwG2dZeZnMCSLNKKVob6xEIcKGQetJMbJMYtnlYlw9es/G6Rdz61WWA7olkNhhzi7YFhxd9iRgFJPHZjJZL3XhMECkCYKFol64tEBgHl7hNWOce1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p470ImzA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 141CEFF803;
	Wed, 14 Aug 2024 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723625223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCbZFQpDigD7WSa2TjFhEt/sfpOTKH+Lsi3n9wSaV8M=;
	b=p470ImzAw2ZhnIm3N+lAz66nYEIdqTab2rBMmEyxKZWNIdqD5E8lxPBlkTlBPDYvmeAnkj
	6P8DEjX3gUg0iic7fmR0FB97ArgW0FPYpFuRmPnnc/IhBY41NClk22+k7PSpQUOAIkw/KE
	hYR8VjCOykSpY3DXS22ynTfcbsJDG2FuO34IAWjFBBDo4XGlN9I/Bg3mald5yosS9ZIzNg
	3KPDsolTqgvpL69vzAUH7YPQMjVfqB46hITFa4BQ3ppupHU8GbVDZALG/Os2Mhw3Blmyl7
	DHUb/dzaujM9t3aAhDm9xLxill4xc3Y1oaT6lXeQjAys6uZtigmzkRNzxc3fyQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:46:59 +0200
Subject: [PATCH 2/3] drm/vkms: Rename index to possible_crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-clarifications-v1-2-3ee76d7d0c28@bootlin.com>
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
In-Reply-To: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3991;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=DlA2BwdMh4xiCAsPDy0jpunVjQO6N3fFDS0bdUg8TA8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvG8DzRFMIHt4BD+5tZFQRjnrYEKUllntFQx62
 eKsZWaspsiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxvAwAKCRAgrS7GWxAs
 4r92D/94SEGxQxE2Xl0//T8uKzRU1+8Pt5CEqpINZ4xNCUyCbU0ffTB2rW3GRS30sg9bo4VRZGl
 5gmWAHLTjHK2pnpc1v8hxd+ABdqefmw8kAXCgBbleS+DSD7Qc600eDfMUTelmk7/cSRdemBk1xA
 EtnzEN+Zk5zOQnGceGLpFAU/ARLMvkTykx/X7zq0GceQAwIGuXkxVRofmKZVVvLubKfr0PFpXqP
 doG/D7hvBVO0Gp9tw8zR+xZ3y0aV8AOcuUQvwZrw93emtFx5a7Rd+zxN5sIYhlkw8ud4Asr8hU5
 iu0pSqHkW53WsFsG9NHyNn1Nd13D6F2whukysTze8zjPL1o7uoVa6FL+U2R6uVcub4eYeGIkQU6
 A2gZSHkjRHF/baCV+PstlSPhsieEJXDNAEkqoYP/PmeN4gCNYIrxt47fFzlVo8pVF3nFwYAhSqL
 NwWQ0+T/Ui2d8zMmQO1W6Hhde/4sg2wCNNWaCz+lkPsTu3L8iroqhaUft6hxvXqynPArCatuZnD
 6DzhmcHkAFa2EtfLEO0Dr3GGN/rwjLvGL2FZd+gBFx5nF0Ku/IEYq0yJCP3MLAOyqd5p8+Aetna
 ZHAgEDHRnEl8GaGWov4h489rQrWPKHRAh8XtJbnUByy32/pDC1AmCyHHJwXQdKN986O1zhzzXA8
 lppjtFterqfgNcw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The meaning of index was not clear. Replace them with crtc_index to
clearly indicate its usage.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    |  4 ++--
 drivers/gpu/drm/vkms/vkms_output.c | 13 +++++++------
 drivers/gpu/drm/vkms/vkms_plane.c  |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 526bf5207524..3028678e4f9b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -222,10 +222,10 @@ struct vkms_device {
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor);
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index);
+int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int index);
+				   enum drm_plane_type type, int possible_crtc_index);
 
 /* CRC Support */
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 5ce70dd946aa..d42ca7d10389 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -31,12 +31,12 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes    = vkms_conn_get_modes,
 };
 
-static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
+static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int possible_crtc_index,
 				  struct drm_crtc *crtc)
 {
 	struct vkms_plane *overlay;
 
-	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
+	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, possible_crtc_index);
 	if (IS_ERR(overlay))
 		return PTR_ERR(overlay);
 
@@ -46,7 +46,7 @@ static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
 	return 0;
 }
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index)
+int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
@@ -58,20 +58,21 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	int writeback;
 	unsigned int n;
 
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
+	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, possible_crtc_index);
+
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
 	if (vkmsdev->config->overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
-			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
+			ret = vkms_add_overlay_plane(vkmsdev, possible_crtc_index, crtc);
 			if (ret)
 				return ret;
 		}
 	}
 
 	if (vkmsdev->config->cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
+		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, possible_crtc_index);
 		if (IS_ERR(cursor))
 			return PTR_ERR(cursor);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 03716616f819..9d85464ee0e9 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -219,12 +219,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
 };
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int index)
+				   enum drm_plane_type type, int possible_crtc_index)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
 
-	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
+	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << possible_crtc_index,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, type, NULL);

-- 
2.44.2


