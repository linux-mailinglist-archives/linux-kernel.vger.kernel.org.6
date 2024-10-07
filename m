Return-Path: <linux-kernel+bounces-353861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0AB9933C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07D9B24B92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD91DC050;
	Mon,  7 Oct 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gq/68D/T"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B021DC196
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319592; cv=none; b=gJbckPN58BwEqFgKOPjEmpdNT/K2RoKoqxOXj2OBPDASkjPDWMMypb0eFYac6gNeUXWb3f8AB+VNZhjCYUlbT9i0dE840jU8lWczm+GcPkiTkgnUVPVR7BKV9KNOKNGCxY375hNlj26sbSaQDm0oZd7LHNrqC7iwW2l/HHWHf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319592; c=relaxed/simple;
	bh=ZeyGQ9NKZuaIVfDwqPXIBSpa015LI97ViIOjeVCzOqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKCG8VO6y4w+bWc94ifznNDLzD55JRjPoORhWZ+Pf5dDlZCqNF1tNfyk2ZlgCXwTzOjAF2METIQVdkjIU9bnXokpzhiuU6vgPnWp+ZuH6E/NOdENbA9k/0gLxm+drP6gVGy9YFNUsqoDWhrsumYuvorngm3fvfF+sLkIIxdKpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gq/68D/T; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AACBE4000B;
	Mon,  7 Oct 2024 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxNnUl0/K3ZNU7G+bCMDMwqFMAtqMIbVXdpL0QRUP+4=;
	b=gq/68D/TU34/bPcQepZTB+p0jQ+ImXx+XX9RP7aJnjOuzLzPkJc+sHpoSM3TRyeX0jqBEQ
	aS+q62JkH+fxE8zC/Gtfhb7bL2D2gm5839fYTh8k1ZuPVJi0Tjq8na+W9k9dDdMpztewjs
	fvbJTQeUVeVxF5uAEOlG1pIt83VxBRldPNwkhIBjo0B4pYAXbuB4K62unWnFNyrYWaiVBi
	5X/hKbYU4lYxlXAlSiw+m//PHMFJY7BjnMsgs30wZp0vIZ7fYTb9zgZwjAQ2zhQU04HKdo
	uas2fKqMXujI5vSQeoIY6RKZJuY0M9cJ26z0wLbejlRVG9DqiE4ZC5+rlOVlzA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:11 +0200
Subject: [PATCH RESEND v2 6/8] drm/vkms: Change YUV helpers to support u16
 inputs for conversion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-6-d47da50d4674@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ZeyGQ9NKZuaIVfDwqPXIBSpa015LI97ViIOjeVCzOqw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBczYh4vY/qRK7y2bBKipT+L4mvGcq6VuROg
 kj9PRs97vOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQXAAKCRAgrS7GWxAs
 4kKxEACmLrduErsaBL9VLAo0CLffOrNb4cHT2OXmuDSacrLCNoTXN7of/5mQZ2qW3igmCzmU+Wz
 KFg+PRAia60UeDYfrOITEp/2p1Dtz+eb4rsc+WLf+htEFuMHzssxqnxRrSo08c9/thKClqCiAbx
 WeV2fQW9CE+skUuSRsY8QWDphixj8ufmHdcbM31SncpzmpKHB1vRpUXOq4xBX4nU3K71ubxiPt1
 fxjgnE6nCccvK6XXjFaQNmMLdM6KHCev7chGSzEGMJWiocR2PDWQGf2sI+lwke64Z2AS3qnb/mv
 tgU3GsC6V6pFXgtXt7uVHouN2Z8X6PM4BM+plVg/JWRz2iL801TkGobJH5xlzNfo4nh60yHdseQ
 mZp0rScOo6AAF0Z5l4e91RPxu+/2sfKFMBXTl5eZKTU1w4O+ZbYKhnoWKsdZijegtXnQl+qXmyU
 ZcXafcie0o7SmFSiYQc/bTmI8oah+cA1vTJQ5qCF6IjhYtg5Ba0QFwIrP04hHRBdQs/R7SWotE8
 etIetjvwICA6AWxdG2F7KCehQ64tSLgtXTGtFFabcqauOJNVuvTTYMh0gOc4wBsx+Br8iHZPf4K
 dMQyWM/03G7jqBVQRVqoK8y8GGY2gboPRNeuAvRA47nXozO7b8j+6Tnb6VDPS7XZTBjuOy5Mm0v
 5u66bBI0ySPqoJA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Some YUV format uses 16 bit values, so change the helper function for
conversion to support those new formats.

Add support for the YUV format P010

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c |  3 ++-
 drivers/gpu/drm/vkms/vkms_formats.c           | 22 ++++++++++++----------
 drivers/gpu/drm/vkms/vkms_formats.h           |  4 ++--
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 351409897ca3..e3a77954e6dc 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -188,7 +188,8 @@ static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
 		get_conversion_matrix_to_argb_u16
 			(DRM_FORMAT_NV12, param->encoding, param->range, &matrix);
 
-		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, &matrix);
+		argb = argb_u16_from_yuv161616(&matrix, color->yuv.y * 257, color->yuv.u * 257,
+					       color->yuv.v * 257);
 
 		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.a, color->argb.a), 257,
 				    "On the A channel of the color %s expected 0x%04x, got 0x%04x",
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 2376ea8661ac..95ff15051fb7 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -279,16 +279,17 @@ static struct pixel_argb_u16 argb_u16_from_BGR565(const __le16 *pixel)
 	return out_pixel;
 }
 
-VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
-							    const struct conversion_matrix *matrix)
+VISIBLE_IF_KUNIT
+struct pixel_argb_u16 argb_u16_from_yuv161616(const struct conversion_matrix *matrix,
+					      u16 y, u16 channel_1, u16 channel_2)
 {
 	u16 r, g, b;
 	s64 fp_y, fp_channel_1, fp_channel_2;
 	s64 fp_r, fp_g, fp_b;
 
-	fp_y = drm_int2fixp(((int)y - matrix->y_offset) * 257);
-	fp_channel_1 = drm_int2fixp(((int)channel_1 - 128) * 257);
-	fp_channel_2 = drm_int2fixp(((int)channel_2 - 128) * 257);
+	fp_y = drm_int2fixp((int)y - matrix->y_offset * 257);
+	fp_channel_1 = drm_int2fixp((int)channel_1 - 128 * 257);
+	fp_channel_2 = drm_int2fixp((int)channel_2 - 128 * 257);
 
 	fp_r = drm_fixp_mul(matrix->matrix[0][0], fp_y) +
 	       drm_fixp_mul(matrix->matrix[0][1], fp_channel_1) +
@@ -310,7 +311,7 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1,
 
 	return argb_u16_from_u16161616(0xffff, r, g, b);
 }
-EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv161616);
 
 /**
  * READ_LINE() - Generic generator for a read_line function which can be used for format with one
@@ -505,8 +506,8 @@ static void semi_planar_yuv_read_line(const struct vkms_plane_state *plane, int
 	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
 
 	for (int i = 0; i < count; i++) {
-		*out_pixel = argb_u16_from_yuv888(y_plane[0], uv_plane[0], uv_plane[1],
-						  conversion_matrix);
+		*out_pixel = argb_u16_from_yuv161616(conversion_matrix, y_plane[0] * 257,
+						     uv_plane[0] * 257, uv_plane[1] * 257);
 		out_pixel += 1;
 		y_plane += step_y;
 		if ((i + subsampling_offset + 1) % subsampling == 0)
@@ -550,8 +551,9 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
 	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
 
 	for (int i = 0; i < count; i++) {
-		*out_pixel = argb_u16_from_yuv888(*y_plane, *channel_1_plane, *channel_2_plane,
-						  conversion_matrix);
+		*out_pixel = argb_u16_from_yuv161616(conversion_matrix,
+						     *y_plane * 257, *channel_1_plane * 257,
+						     *channel_2_plane * 257);
 		out_pixel += 1;
 		y_plane += step_y;
 		if ((i + subsampling_offset + 1) % subsampling == 0) {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index b4fe62ab9c65..eeb208cdd6b1 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -14,8 +14,8 @@ void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encod
 				       struct conversion_matrix *matrix);
 
 #if IS_ENABLED(CONFIG_KUNIT)
-struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
-					   const struct conversion_matrix *matrix);
+struct pixel_argb_u16 argb_u16_from_yuv161616(const struct conversion_matrix *matrix,
+					      u16 y, u16 channel_1, u16 channel_2);
 #endif
 
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.46.2


