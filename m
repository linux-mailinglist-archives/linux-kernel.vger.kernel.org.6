Return-Path: <linux-kernel+bounces-281344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0794D5D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE9E281A63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743177117;
	Fri,  9 Aug 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RmfChdJq"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4013A260;
	Fri,  9 Aug 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226109; cv=none; b=DDRaRNs6XC5HstSQ8/N8eb5MEzzI+ac/qZTyh9Gl0jeregTOENY/KEyycYc3EGjW3TwFz1nI0vm3mBH3Cn/5s8TgUYxaJ7JQzMp2uQ3OAsVILk0861ITft98OMqoz8ViVpq2QHUS+ExtmnYB8+QQFr7E6miKAa1GBQPeNWreikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226109; c=relaxed/simple;
	bh=ic2La7o17seVheB1q+5Kf/polYpqYSfSD6kqzqalc+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuFt0kbk4P/6cjAqPR1/6y0AUwPszaRS4ke34I67y4RiUm/k1ZRA2gZa3DTt/WGnTz4CP87LNVb0fCAGJ/EF+ooVoKVYpgloIm7VUoklwXuWRsh8tWR01G+6Bpl14mxGrwDNv9b0PG5wvAcw4A4RQr6bpLQ0jPKL4O4Wwzuvbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RmfChdJq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FE96FF809;
	Fri,  9 Aug 2024 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aaRiY9oMPPtXcg03bwF+5a8QEuOrg0mbmpGOcXWoNI=;
	b=RmfChdJqQP4ZmU7D7sLjWKNXVWHP/adX2s7AhisICDzhik2ibIvx39RgMFeW34SfadlRDJ
	7aVNg5e7yg2QN6OycYe1sNvEXtcNrilbK0Q6/a9Ru2/st+aTF7DvPhACT9/kaDO+xkG4O8
	M+p7Ya+39t3rNSjFA935eY5+YkNE7r6qZ12r2QN6vnNlCAAnvRcgaoGSUPfR01bI/lNGYp
	EHPn/ijJehczUWdO/oR2GZOFHcDl5HK0SDCRxodLVnXOATY9ZhiK+j4fc+e7S3/DFyvTiy
	0QiOcgMHAMb8Jc2C0JigwqCjGD/93dguYwd7qEbQ5pZxWQPAkcAGlNtKoBusFw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:48 +0200
Subject: [PATCH v10 07/16] drm/vkms: Avoid computing blending limits inside
 pre_mul_alpha_blend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-7-1a7c764166f7@bootlin.com>
References: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
In-Reply-To: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4075;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ic2La7o17seVheB1q+5Kf/polYpqYSfSD6kqzqalc+I=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfqQuvLImmJ7oqhWfk7KmxlP0PME2ylsiXoS
 O5HAG6xKOqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6gAKCRAgrS7GWxAs
 4n3DEAC9tPHcKrAGZ0Wc/Nj+vQB25CYNDlGQLd8zQBoXOvi3NHVt0WleiPj6+LS+/igGPMJv9qb
 h4l0YkZpq1lT3jruQfZUY9padFTjFIvMQwND8uv11i1OWqheHy28husmTaHVBH0vwWrBnDC6rc5
 oEj+mgbp5ExTwUbi8wRxl0Z+1REni+3bhd0l3Cqh82mPvxaf2/ciFVukVbnDB4Egb1ugPNGweub
 HtX4W2lFRWGM8HqyPR2CpDMBWQfHjwMxMgz59KefwSobxAXRi2vWVyU/8VbKehgFeeFby5v6Ywz
 glYFAIWk1jZhG20RyqNEWpOhjZhHBwHBEPG/e3Vm/R4bLMPKnn3CkN7VaXjFEIayqT4FoB16e8Z
 LcY4gOQ6iVWvT5k3I0VqonjyjjkO+XtJQQ8e0wcbhN505lQEO/Lb6+lpPgRrAe8LoWA7c3RbGvz
 ecmPIXtCp+Ie2MbSNCsq23o3LbGlvPcj5rtbepLITHMzYJozfeFmPQydOuirg5riMdps81rRw08
 3qGrpKNyo7Gd2ctkHe5EkKoEJjwbq6YQHUVhTabNzOBWsQXql1nBDycrL1owXoDEy+Vlpz2bLh9
 ESihK85q12PU8c+ZnsjdCTgNhBuAuQeC/S4FDmwVDIzUlRwvuyGPq0FESZYT3b7ai8rhYdxsPU8
 IjAFNEvV0oyLN4w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
different concepts (coordinate calculation and color management), extract
the x_limit and x_dst computation outside of this helper.
It also increases the maintainability by grouping the computation related
to coordinates in the same place: the loop in `blend`.

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 931e214b225c..4d220bbb023c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
 
 /**
  * pre_mul_alpha_blend - alpha blending equation
- * @frame_info: Source framebuffer's metadata
  * @stage_buffer: The line with the pixels from src_plane
  * @output_buffer: A line buffer that receives all the blends output
+ * @x_start: The start offset
+ * @pixel_count: The number of pixels to blend
  *
- * Using the information from the `frame_info`, this blends only the
- * necessary pixels from the `stage_buffer` to the `output_buffer`
- * using premultiplied blend formula.
+ * The pixels 0..@pixel_count in stage_buffer are blended at @x_start..@x_start+@pixel_count in
+ * output_buffer.
  *
  * The current DRM assumption is that pixel color values have been already
  * pre-multiplied with the alpha channel values. See more
  * drm_plane_create_blend_mode_property(). Also, this formula assumes a
  * completely opaque background.
  */
-static void pre_mul_alpha_blend(struct vkms_frame_info *frame_info,
-				struct line_buffer *stage_buffer,
-				struct line_buffer *output_buffer)
+static void pre_mul_alpha_blend(const struct line_buffer *stage_buffer,
+				struct line_buffer *output_buffer, int x_start, int pixel_count)
 {
-	int x_dst = frame_info->dst.x1;
-	struct pixel_argb_u16 *out = output_buffer->pixels + x_dst;
-	struct pixel_argb_u16 *in = stage_buffer->pixels;
-	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
-			    stage_buffer->n_pixels);
-
-	for (int x = 0; x < x_limit; x++) {
-		out[x].a = (u16)0xffff;
-		out[x].r = pre_mul_blend_channel(in[x].r, out[x].r, in[x].a);
-		out[x].g = pre_mul_blend_channel(in[x].g, out[x].g, in[x].a);
-		out[x].b = pre_mul_blend_channel(in[x].b, out[x].b, in[x].a);
+	struct pixel_argb_u16 *out = &output_buffer->pixels[x_start];
+	const struct pixel_argb_u16 *in = stage_buffer->pixels;
+
+	for (int i = 0; i < pixel_count; i++) {
+		out[i].a = (u16)0xffff;
+		out[i].r = pre_mul_blend_channel(in[i].r, out[i].r, in[i].a);
+		out[i].g = pre_mul_blend_channel(in[i].g, out[i].g, in[i].a);
+		out[i].b = pre_mul_blend_channel(in[i].b, out[i].b, in[i].a);
 	}
 }
 
@@ -183,7 +179,7 @@ static void blend(struct vkms_writeback_job *wb,
 {
 	struct vkms_plane_state **plane = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
-	int y_pos;
+	int y_pos, x_dst, pixel_count;
 
 	const struct pixel_argb_u16 background_color = { .a = 0xffff };
 
@@ -201,14 +197,16 @@ static void blend(struct vkms_writeback_job *wb,
 
 		/* The active planes are composed associatively in z-order. */
 		for (size_t i = 0; i < n_active_planes; i++) {
+			x_dst = plane[i]->frame_info->dst.x1;
+			pixel_count = min_t(int, drm_rect_width(&plane[i]->frame_info->dst),
+					    (int)stage_buffer->n_pixels);
 			y_pos = get_y_pos(plane[i]->frame_info, y);
 
 			if (!check_limit(plane[i]->frame_info, y_pos))
 				continue;
 
 			vkms_compose_row(stage_buffer, plane[i], y_pos);
-			pre_mul_alpha_blend(plane[i]->frame_info, stage_buffer,
-					    output_buffer);
+			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, pixel_count);
 		}
 
 		apply_lut(crtc_state, output_buffer);

-- 
2.44.2


