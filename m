Return-Path: <linux-kernel+bounces-272812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F26946186
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2814E1F235F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6D166F3E;
	Fri,  2 Aug 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eBgOnI8m"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B81A34DD;
	Fri,  2 Aug 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615020; cv=none; b=bsgdQC3kmZwtueF1vejej9sZJfPdzCzbs6gyLbEOggpoUt36Anq9NIDG7OQY0l1tP5q29PmfoQ7VYMsuHIF4R4Xjl/swY+tpRHEOKIncPoUrjP/A9ir66DQHlay+QeLWq5n0mq1ZhbCT0Ugz0rBWIl05uAStuK5SojzpGMdSKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615020; c=relaxed/simple;
	bh=ic2La7o17seVheB1q+5Kf/polYpqYSfSD6kqzqalc+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLNXCBr/iFFEkMkSJb5OnO8SNJi4dm62oLK/3dfFJ7/gzdX+ArUMIm5fXBtzk2yl17L+WcChnzS6SeGyPKOXoWP3pcE4Mg0qzigHWM76Le6G7oe6QFIDD8VOgOVVPfJP3tT62fwuZc6g284zUt4yoCn65KhGQr2URDe4xP1DaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eBgOnI8m; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B918C1C0010;
	Fri,  2 Aug 2024 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aaRiY9oMPPtXcg03bwF+5a8QEuOrg0mbmpGOcXWoNI=;
	b=eBgOnI8mMyiZFerz5uv/Grlrj1T3JAsVKlvLuv/pDizHfbBEKwBz5Hr9rZbaov36+P7Z26
	JfagLpCiiO/YHbEPZgfJ5dkEsjh2wanN/Su0s2VjDpjIaDBYbjyWeHEKR5z/B8tgq9Gls9
	aXJJRryEREcUwZlnlxhx7mBkV5FIvp0ay0Tavwijt2bjhH2yg4zXZQw/3cpY4fTRrW1P3e
	xn0QAkyeGOs3/Vhg8KlpmaHjeRTjwWVjo4YTgzreo+5spNnwDAnuuEh4G0ioTJgE5yy35H
	Cfmpdp0GquHsaGvIR8ovNZzGcHZuO+Ghu41v0HKXmw+IJsCWfbGYN1AW86rE3w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:53 +0200
Subject: [PATCH v9 08/17] drm/vkms: Avoid computing blending limits inside
 pre_mul_alpha_blend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-8-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTalLRPYBPSaKuDP2q6+2GNWpTYV3ypn7CS7
 xQS5ydnx5GJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2gAKCRAgrS7GWxAs
 4iV2D/93/Pv9hP2AOdEwgCOMd8DfxYVnCrAiQlzbEl1Ohr5t/+88Z3d5ACgBF57bWt/Koga5GIS
 jFb75aizOLYlgHIRqTNobysP+rtuYYkTfyeThThi1FNA5KywKcSGCxpVHjf6+skjVzFBVUssplO
 vv/vWilG5hhjGPWzOkAccX7hShfIjQkHLjJdrX3Zqm4bd0ZztU7Yk7ICg82ygUxIBmUSXOloQWg
 7qB+uFqcjRAfS+iqsb43x8J5vy128S0OJqIf1asO4rISaRyiEhgpi4FAikfzgHhIqYA7MaoV81e
 WY7Q6+i/ad5cA57niC2zh5TTF5uGoX3DX6jcZWw10qQWth8c4PsIS0511LSFtJuBMozMXbzR/9U
 MnNngcByloEqpct634DJgVvxH4zI7BMQxQIkM6EEe8yhFeXI2uMHGbtZJZEPfmo1tDceql/gKQe
 hF/+N+SHbF4oR0nUbuqRF2EQtZJu7FNoZUy0LaBVz4PTQFfViYrWDgcelhWiB11BRbJTSABT07P
 xBE5K8djWcRJjYkG81cv+bxuPCcxRqKcT0S5nzklPJFJ5qtdX0z2mnlWh6xGyn6N7GK09iDcyUP
 HN1baqY+O5++j8DtaCHiQy88xz63FcTmm2UhdOr230pqYfAhX8H0TiH6yJlIifAQ3FMMNHKc08W
 eKQlfrX6pnHO9Yw==
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


