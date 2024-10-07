Return-Path: <linux-kernel+bounces-353788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686869932BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAF91C20B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C71DB54A;
	Mon,  7 Oct 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nIiMDKNS"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377E1DA2F7;
	Mon,  7 Oct 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317453; cv=none; b=LU+utPmlCOjDVcF0UgdvFyucZBtNLpTEMaG8rXUT+YGg4PLQmEQEgBuHZLM7p4iq+tYoNMRMwCkGS+XSKQuPgr6n1Jp6N+YM0AT5hsBClEk/Ekdij2pKaOoSPCJFtd0uuIBIIPQHrFLxfg4oK4Gi28irwKn0OBFAdJfbjukQhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317453; c=relaxed/simple;
	bh=ZCZchl8YXaJKXMTOIfi3f6uTp8wXE1eZQ6XB+/K8JTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VT9Dj9x7HlXlVeQkzHz9KjfQEV1rgw/caGhwueJFCMnuyMSJ+FzoEJwVwED75HPyafPtAT2SNdbJjnkqsBFkinhSzBq0ZMkaXp9lk1SYDy3HJKNqN+tIyYJ4bqBbV4dS557Xrk1ULkeQGdWahXml2emRNCZue0iG2ttTNr+WBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nIiMDKNS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00BD240003;
	Mon,  7 Oct 2024 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2C5hZ/knWBtoOPrBC9CFpCsHQ2ytwSQQLFNkYLaAoVE=;
	b=nIiMDKNSXPjLENoWFvf7nGWZpNMHYGSKU4MdZx1UcvnVmc2ZmdJ/sax4fvVceE1z7pQ0BQ
	a/ZR7Yvs7ZaPB82HDxob8h2WA8DWlIK4pR46KmkAhyLfscQWY2f+VR3/LDYQM9LRKErxqx
	MCILXwPkisR5Ef3s4QrpTA1OtGbySm1jViofeWwMiKmXi9gtTM+wQ9Tr4O95FUGzDr5p4P
	IWP7uO47MgqZqd1Cub4QfaX1ckJdazHsV6aVOYBlG6HJEHbysodHF3GjKlS8kM02zH1aS+
	hCowh9gQ+FScEa0MAVugUZSIx2romL1JuFGa7OSZ+8tOfmxiH1XOJh7R2hkLXg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:36 +0200
Subject: [PATCH v12 02/15] drm/vkms: Use drm_frame directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-yuv-v12-2-01c1ada6fec8@bootlin.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
In-Reply-To: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4276;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=2sG3hL92AI5p05ggDfRLdPBFv95vU35OetchXGlRuB8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgA3AwRhLY5aLn473Sx8ZXdKWRZ8o44y7ObA
 VYIUsdcFHiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIAAAKCRAgrS7GWxAs
 4spvD/9h5T4Grq0Y74dZVWsHrNWA7hfk7B1T1lnbUoQU5Y+qLWKBiCrqW+f9CftJ95Z4Seo2urs
 u87ShtepIAi7lbCL6cC+N9AsviHEXp8Y78a5aEQShr9wVpSkVf2AlQLGBEFNII12k6m2J/FGr4g
 iYL2Svn13Tsw8jNd7lU2TJd2IBw7YZ/TwPqTOh7WyrNt4+xniL9UJ5MmJI171qcZxgBDfjlDxfH
 V+AP4yboMno18tImeUCLvzzE2V3qweAVqXIqRStkPL4V2aZ9aIIzUwSlnZVc5uSWmMM3suYIIOa
 85P/r1doUgjos/YLYLagtbu/LS1n1Jv2Fr+5Y+zGNTuo7bcbCOMm4BGQY+bvzfr4d6FWitcF/+1
 wgFqRBFUo+GHzdDugBG4l1s7SREsD6nrgRpj0z2Ij4UDfnOPFut4HWaZne/VeyEMa5SbAC/CdDn
 aArN+XXUYXCX2G4IFo/7j47SxgkRlKxXUe5mLIq9cMR4e5uLdEB/WDxY49SntgD/Ikd8tLyOCuu
 +d40bQiT5Muwfez+dtO/XRnJc3pSHmeMyoShcN+8XQZ2b2BeMoCSYDp9p+jXauKkbu9+3bcvrfO
 bfT8urQIdf/Wodju9s7trcdSQWRP7qsWop/XTQPoWCJ2tjMwx2S4mYeB4zbWRZRkvAZqQ0X/m+c
 BZZlUav74Rdy73g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Remove intermidiary variables and access the variables directly from
drm_frame. These changes should be noop.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
[Louis Chauvet: Applied review from Maíra]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h       |  3 ---
 drivers/gpu/drm/vkms/vkms_formats.c   | 11 ++++++-----
 drivers/gpu/drm/vkms/vkms_plane.c     |  3 ---
 drivers/gpu/drm/vkms/vkms_writeback.c |  5 -----
 4 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 672fe191e239..fcb5a5ff7df7 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -42,9 +42,6 @@ struct vkms_frame_info {
 	struct drm_rect rotated;
 	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
 	unsigned int rotation;
-	unsigned int offset;
-	unsigned int pitch;
-	unsigned int cpp;
 };
 
 struct pixel_argb_u16 {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index e8a5cc235ebb..2a0fbe27d8b2 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -23,8 +23,9 @@
  */
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
-	return frame_info->offset + (y * frame_info->pitch)
-				  + (x * frame_info->cpp);
+	struct drm_framebuffer *fb = frame_info->fb;
+
+	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
 }
 
 /**
@@ -154,12 +155,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 	u8 *src_pixels = get_packed_src_addr(frame_info, y);
 	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
 
-	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->cpp) {
+	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
 		int x_pos = get_x_position(frame_info, limit, x);
 
 		if (drm_rotation_90_or_270(frame_info->rotation))
 			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
-				+ frame_info->cpp * y;
+				+ frame_info->fb->format->cpp[0] * y;
 
 		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
 	}
@@ -253,7 +254,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
 	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
 
-	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->cpp)
+	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->fb->format->cpp[0])
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 5a8d295e65f2..21b5adfb44aa 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -125,9 +125,6 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);
 
-	frame_info->offset = fb->offsets[0];
-	frame_info->pitch = fb->pitches[0];
-	frame_info->cpp = fb->format->cpp[0];
 	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index bc724cbd5e3a..c8582df1f739 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -149,11 +149,6 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	crtc_state->active_writeback = active_wb;
 	crtc_state->wb_pending = true;
 	spin_unlock_irq(&output->composer_lock);
-
-	wb_frame_info->offset = fb->offsets[0];
-	wb_frame_info->pitch = fb->pitches[0];
-	wb_frame_info->cpp = fb->format->cpp[0];
-
 	drm_writeback_queue_job(wb_conn, connector_state);
 	active_wb->pixel_write = get_pixel_write_function(wb_format);
 	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);

-- 
2.46.2


