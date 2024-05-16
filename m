Return-Path: <linux-kernel+bounces-181072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640678C772B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BD91F21F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4356514A4E1;
	Thu, 16 May 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="omqmxcrZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4B146D7F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864724; cv=none; b=i/gcTMEm6SZsKiExq8krwkoVnjtpEuhEA5AhrUR5AX4+zdU5knOBVjDZjA/f6ZnQC35xeucTf6+5eQm6Q5tnqOiYg6dZB1iSmYOzMOeq96Ler+ANlheOfdjT08MGL58KwTq4XJRJKV9fU8fWTzpDl2N4OoeaXG+a/FRdMvGUEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864724; c=relaxed/simple;
	bh=bT1G8LWr2IimTuL0YxgiME9uLh/6aEqP5bz7OvLnPf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGRqi1Sj47/sBs4jE1HAvvSThpgxHNkRnn68TImTRwWTQUSwooxHDneo2CRBNU0KLfksQhEeDMF3AmSB+/VbvHkjtJczcHxFTsVD1fWAzAafxlXlQqzM7yKO/mzMXcTi1Mg948NqtVBxLAriUIlC9YJvtJy/m8QHmJTpd3YThis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=omqmxcrZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A835DC0006;
	Thu, 16 May 2024 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ts2EpXThl3nXsJSW9vyYMRG21WpU3LICzzmklCSjoA=;
	b=omqmxcrZZNtWPsdk49vGu+cUJlVQfJhexGFgAIcsMUAn0SQLjw4eqB8owM/ZL1NvPjmnPH
	9+vdfhiXEOlB04na7LtsPcplwXXnRgBn4Ux+TbOUXo1LGmdUY9d881ELs8F6rajmSvBS8B
	kQdRgrZTlo16ly9awV9rDoF8GITuv0RvCsLHfO25MXMLB/ofMNYzLb8e24dCBb9vmRJWPc
	mnQ+lvHtx5CK8u0jEul6h66poKDxCuvzuGLRyp0/8+g++1vrcPY4DAfKYsrA4FtEkDqG86
	J8F8pt0KCX+1QoL9pQcS5Y0bTnb6zTfQYOPEfXxP2E4jo4ZvSsf7+GlP0W+HVA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:04:47 +0200
Subject: [PATCH v8 02/17] drm/vkms: Use drm_frame directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240516-yuv-v8-2-cf8d6f86430e@bootlin.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
In-Reply-To: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/0OICzEuaRr2mcioEBkDg2hESLGHmXOasKimpqPkZLQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgR/aZNauKPABWG2woGdoOMlrhKvKblyWQ7O7
 Ma4qT+SOrGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEfwAKCRAgrS7GWxAs
 4v8DEAC6DecY0RF39Q1GnHrFMabMc1DZ1vn1rP83m9hZMIdJz+77LuFiBEfcTjwsok2sYkyk6Cm
 rD4S9KB00RjTbWV34I7L5/F3SNfJ08Os4z9Q7PwEl0ff6ZJ1AIxiumdQmqeA6flQP0MFgoieLam
 3ZOTsvWd/WtNLPwrWcXRIP1JxuRfa8L2r/BjjBSDfx/6TWfxojDms2ebZkQ+NkKSfzSvguUvb5P
 XGvOYKPyj5ooW7q1nY5JytfTwVeVo3IB8o0cVdCeo39/3+qpPfEniGZ+NA4K+SEzE5USYAnMHgm
 ZrBrLPsRqr19PO5YCLutgDV9LgipMieADDENjDPN7GAhJhxYt9zNz1orgMR7X7GXgJEuV+CpzXQ
 raDjI9DUjNTp1S+vVRo21ijdCNaYa5NZg7AY1GtZhgC9YGgc2vo1T5KXERfKPOjax9dea9ImNiO
 J3IuSs3muVRXofxnRI11bfONHIXySGFtAebrZfO8ZsKXEt0p4Gqcf9iJtF8sKi60pRXzxqU6fOH
 DbX1B0njgMg91sBnNgTfIMrtzgNMYx6+oRKWE0QSQ8ha7X5PtNA8n6G8vC+gjLdfCO14UpsMOuK
 FDUsSMgLSNJ042pHbjbaK+woR3FXzjxeHX8LoJemoB7SqA8jEbLowc3Zntoec7M3UUI1/jGHyvE
 BLc658iM2TZV1Ww==
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
index 8f5710debb1e..b4b357447292 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -31,9 +31,6 @@ struct vkms_frame_info {
 	struct drm_rect rotated;
 	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
 	unsigned int rotation;
-	unsigned int offset;
-	unsigned int pitch;
-	unsigned int cpp;
 };
 
 struct pixel_argb_u16 {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 36046b12f296..d597c48452ac 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -11,8 +11,9 @@
 
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
-	return frame_info->offset + (y * frame_info->pitch)
-				  + (x * frame_info->cpp);
+	struct drm_framebuffer *fb = frame_info->fb;
+
+	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
 }
 
 /*
@@ -131,12 +132,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
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
@@ -223,7 +224,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
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
2.43.2


