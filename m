Return-Path: <linux-kernel+bounces-413359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB049D1821
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8482D1F22385
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B01E102A;
	Mon, 18 Nov 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UkWcFQnG"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03F1E0DF0;
	Mon, 18 Nov 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954513; cv=none; b=OGr1xxzlJ37qow7XkZsxXvkNnEoo2mmWPadW/MquZNXI3cWnuMTPnDgw7Hlw1cwoimD4dzUA2O+eU6/fgQNfmk5BOUdjT9ti3QjEJ4oRkUTEn3D9crlwtPFJSCDxg2fCgSYbS9wWzbTwM5HDTSzeyKsacPI+9ghyX/lz/LkON3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954513; c=relaxed/simple;
	bh=c+521gWmleKYABh5f8YcpwubLVO5Tnc20Il3tE0BqE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YC7P7Ph9uNIEmPakmRPdSrlUd99eUnPwuklwQNz873gb+xAop0EMuJwPuHvxgpIqgR8DVCNB3bzI8r+e2Oo3Oun87KTdbn0E2Hk38CVIgJRbzRR8ecYMBCNQXr2sH0UTBXYrgfzJu6mDbJ7h+swFt+zWgZHt8m3Yn0n5OWK4gaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UkWcFQnG; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9DD5E000A;
	Mon, 18 Nov 2024 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731954509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tx86Se0JzmN2wSkI9tFn0o5J/f8HMRA8ufnfCJfwK4=;
	b=UkWcFQnGIwb7eTPJwAvMUxgFAVzrDmbLcUjHAeA8Fz+HIr7A7B/aT7zMV3qIHmx3eqEKTU
	blQOCfLM0F3QfLPbI/kaPTHSV9wPrChWv8wkujBpqGfdo7j5kXT+SramCV+NZKhlcwIU7h
	JqBZhY3DSLQHqKg7PsAM4zHyknV7u8CpQP6CtSEKeacMh/sfzIRdlP5oMb0UNiREBEhUAt
	yP8Cend90nLrEBC+dAYuiQPuYlkXMAF8DTxchnlyl8a+xlT2ZOfHuEhYtoV+a+uPmKlqLg
	+mNSNQf2SUFHJ5l/8J7h615eSt0Gh74tT7NIkQK0HC8ti+G/6SrM8+6mLXwsaA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 18 Nov 2024 19:28:17 +0100
Subject: [PATCH v14 2/9] drm/vkms: Use drm_frame directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-yuv-v14-2-2dbc2f1e222c@bootlin.com>
References: <20241118-yuv-v14-0-2dbc2f1e222c@bootlin.com>
In-Reply-To: <20241118-yuv-v14-0-2dbc2f1e222c@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/DceU0FhaHM8eO1eSHLkINqQHmSp53P75JRctvnQQIA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnO4dFDJZsaHFe4r+M6Q0QuujjfglOTw+R4mFty
 dviIiCPICKJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZzuHRQAKCRAgrS7GWxAs
 4hwAEADABpAQvIzknPdzDYb+z1ak+cZUTvfsO9ZMDvE97uCQc5Fp4Hd5hWMBL2sRCOjyhh7aNiR
 KGFCu5nOwzegZU4Zg18TCcVMVSSk6oSNSBiLeArj7XBVEcyui+CWHQ3bhtuB4++xSp1OQ9GLQlG
 j1CzBhlHl1aDZuwKpbji7hR4kml0+xjDAFAbztYpiMwiYAae2OZ5uzia5SZkWdYutJtV6it2hHh
 +gfemWzljUV1yAMP+OCbUQyCNALT/ig3dgidrdywlk1S9F3FuvX1Rxkb39gDGkQPseA4abOYuVj
 Z3lWqwzuvS1qOPCDvXRH+GM5FORMboOjrl0mHLTAqeDMCWDP1XJSovUooM9394BktFg4I63sq2t
 0FIdCxzcOXTTftD+YiIFu0b8/XYcyhN/ac/62hHAKTb3B0/tj8wYFERlhLGi/g3rz+aLg8MP9QO
 kU2HngcDWV6C/ax6N80IemAnEYGE+RxJADPk3S1Mv10bn1v1ArR5uSrTwtqLavL7Swje8PqidzN
 VarZwmGAEuMGT+IYySh4A6Epl/e7Niundh6KXLkj9TPp0dr4jwJAh6UvAeacF/dOAcGqeNU+zy/
 0Rz4deR1huFKjuA9MmuSQix9nD2GrPUL5zzN+ehIEjWI8NKLUYEOVo05iApJnOeyie2+GmHsUVU
 0VnJDXLvuPMj2Rw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Remove intermidiary variables and access the variables directly from
drm_frame. These changes should be noop.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>
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
index 672fe191e239c03e7358d43eb19215361417a781..fcb5a5ff7df7123073f027d4773f1a515480441a 100644
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
index e8a5cc235ebb7195340292ce71efed8435ff2748..2a0fbe27d8b28e7e9e8a12ad08a2cac4ba7277e7 100644
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
index 5a8d295e65f28cac821e4e51916c4dd242705780..21b5adfb44aa584e1acd6697954aabeb4e905c3c 100644
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
index 999d5c01ea8116b2f3de285a79a8922901d82a7d..79918b44fedd7ae2451d1d530fc6d5aabf2d99a3 100644
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
2.47.0


