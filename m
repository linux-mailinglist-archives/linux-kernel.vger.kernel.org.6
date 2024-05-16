Return-Path: <linux-kernel+bounces-181078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B638C7736
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430121F224E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60D14E2E9;
	Thu, 16 May 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gVZaYWo7"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D26146D6B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864735; cv=none; b=G1VZa0Ke41JodU5FVjXI6D+yLkuaPd1veS65N87pmxl91jFNwx0HRG8On+DD8E7GL38mivvy+vXth1UPHwFUrFf/0FxEi/Tp/MiThghO513onhTAD54AjSvMg+vOZeAqJi54V6RD5n1uUQAeM6f7osCH813BMY4fIC3wnDd+OPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864735; c=relaxed/simple;
	bh=Xka9lszlPd+b3dwumLg+7lvQxk/Cdt0OW/yXGQoV0gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYoRV7nb3THvXUqrNpARwbr9BO6mKmGeyyFP0IH+A3rI1Hp0VllZblvwU0ibiuxdqcu9F96k4SdF8jfUKxZEz+BYx/SM16op7FzRQvyjjUBgO+hU80bfNPXN/YTJLaTX09fNG2fb6zV0PDwQ81P7myJT518GVo7oGHWiiOFRWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gVZaYWo7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F4A7C0003;
	Thu, 16 May 2024 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CGHYclRUATEtz6nTI4ILUcfiZlmoTjHWGWX9MIfVmI=;
	b=gVZaYWo7x3keNpiYEvidUD/3Sn6r5/zAqC1Zt2DiG8+WnAsZDtsIhucZ0gXa7jPkScy1IA
	V1savOZL/fmKSNU3xs64G9gmfMM4rcqUM4ZNPE7MshbeSMgwh/duYA5SdtMyPeKwvtUom+
	ufqi8OQ7Vp77tZuo9T5TctsAAFb2YY8D/uzWQglBkHlCo1grkYNikXeIF/b7ypVv5ghcfk
	O7W0vT5gtpNXrL3K1fJkF5FiDOWyeV1gGVhjZH75QHJYKnQZHzRHKOJVLrFIXNWgc8etqB
	8U38Cn87qc4zFcGbywTl43Vn8BQt2vGturLewCfQnaG1udRduFGqr3tg4sxOoA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 16 May 2024 15:04:54 +0200
Subject: [PATCH v8 09/17] drm/vkms: Introduce pixel_read_direction enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-yuv-v8-9-cf8d6f86430e@bootlin.com>
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
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5177;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Xka9lszlPd+b3dwumLg+7lvQxk/Cdt0OW/yXGQoV0gc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgSBejNKB+CWCxnruCb7sdfLNgK4afvXnBlOk
 35I0ZEZabaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYEgQAKCRAgrS7GWxAs
 4phAD/4tXYctKQoO7usKVa0nDc0/jAyNEGaM0ygDJmC2hB8DIw60lX+7zMmy8RoPDdsWyfrZboL
 4mX/pUUl/hipLHbqM2o8Y9ESPI64Mbz8mpvhE4aP2oUIld/AihTX+rdjx4rG7TtZX/KvFAgNjR6
 dIHsK2Nl9ADokGd9ibpS9AuVQTENRabIuHC9tjr8M/NdlFsQmN/14WEIyx/B1yIoR3Wx9zcvRhH
 E3PJFbwTNN/8wSeuJxb3rjObpthUbS1kJwkbRe1h4ofoSO5TJieg/rMiR4NJpsYOBYZGFQj6Gyk
 tvJTr7XPV8t4khVD2RZJBvQeB/kaPs5aS6779ZPbDhlOgzauGoYr37LMGzX8Xemi04fOSBj1hbP
 KLrvy8SFfZnSEKUIPdZjdCK0JPMY6IrKTy3fRyb/EXpc2Ln697Ro7cKxaWJWSL69XqQdiLdgO0r
 wol6Hbe0KzsFdZF2eqXduxoi7CCA6I78glNRmO8uGCjSSr/h4Vo89bS1kCGuRuFbiyLoKKuOe4s
 WTJFhl1rgZ1IdYEXI7tG+6WcHTGUAOdEZxaZFLovhwuuZ4M8UxgCY/NWEJyTpUy/NW4mYPCGiuz
 dCUsqRIJ3F0+NYnhHw5ES1zeEgTWfrRF7WCC/Nw/qjMGpKI8nxl5tfiplkRol9NnjQRcepBmuWt
 6kAyG7CZ4uHOzwA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The pixel_read_direction enum is useful to describe the reading direction
in a plane. It avoids using the rotation property of DRM, which not
practical to know the direction of reading.
This patch also introduce two helpers, one to compute the
pixel_read_direction from the DRM rotation property, and one to compute
the step, in byte, between two successive pixel in a specific direction.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 46 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++
 drivers/gpu/drm/vkms/vkms_formats.c  | 32 +++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 45b111c74884..fb4967a00398 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -159,6 +159,52 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
 	}
 }
 
+/**
+ * direction_for_rotation() - Get the correct reading direction for a given rotation
+ *
+ * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
+ *
+ * This function will use the @rotation setting of a source plane to compute the reading
+ * direction in this plane which correspond to a "left to right writing" in the CRTC.
+ * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
+ * to be written from left to right on the CRTC.
+ */
+static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
+{
+	struct drm_rect tmp_a, tmp_b;
+	int x, y;
+
+	/*
+
+	 * Points A and B are depicted as zero-size rectangles on the CRTC.
+	 * The CRTC writing direction is from A to B. The plane reading direction
+	 * is discovered by inverse-transforming A and B.
+	 * The reading direction is computed by rotating the vector AB (top-left to top-right) in a
+	 * 1x1 square.
+	 */
+
+	tmp_a = DRM_RECT_INIT(0, 0, 0, 0);
+	tmp_b = DRM_RECT_INIT(1, 0, 0, 0);
+	drm_rect_rotate_inv(&tmp_a, 1, 1, rotation);
+	drm_rect_rotate_inv(&tmp_b, 1, 1, rotation);
+
+	x = tmp_b.x1 - tmp_a.x1;
+	y = tmp_b.y1 - tmp_a.y1;
+
+	if (x == 1 && y == 0)
+		return READ_LEFT_TO_RIGHT;
+	else if (x == -1 && y == 0)
+		return READ_RIGHT_TO_LEFT;
+	else if (y == 1 && x == 0)
+		return READ_TOP_TO_BOTTOM;
+	else if (y == -1 && x == 0)
+		return READ_BOTTOM_TO_TOP;
+
+
+	WARN_ONCE(true, "The inverse of the rotation gives an incorrect direction.");
+	return READ_LEFT_TO_RIGHT;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 17081effe99a..5d0e87fe50c0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -69,6 +69,17 @@ struct vkms_writeback_job {
 	pixel_write_t pixel_write;
 };
 
+/**
+ * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
+ * plane.
+ */
+enum pixel_read_direction {
+	READ_BOTTOM_TO_TOP,
+	READ_TOP_TO_BOTTOM,
+	READ_RIGHT_TO_LEFT,
+	READ_LEFT_TO_RIGHT
+};
+
 /**
  * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
  * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 3874c8fe4f84..09883550b4aa 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -77,6 +77,38 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
 	*addr = (u8 *)frame_info->map[0].vaddr + offset;
 }
 
+/**
+ * get_block_step_bytes() - Common helper to compute the correct step value between each pixel block
+ * to read in a certain direction.
+ *
+ * @fb: Framebuffer to iter on
+ * @direction: Direction of the reading
+ * @plane_index: Plane to get the step from
+ *
+ * As the returned count is the number of bytes between two consecutive blocks in a direction,
+ * the caller may have to read multiple pixels before using the next one (for example, to read from
+ * left to right in a DRM_FORMAT_R1 plane, each block contains 8 pixels, so the step must be used
+ * only every 8 pixels).
+ */
+static int get_block_step_bytes(struct drm_framebuffer *fb, enum pixel_read_direction direction,
+			       int plane_index)
+{
+	switch (direction) {
+	case READ_LEFT_TO_RIGHT:
+		return fb->format->char_per_block[plane_index];
+	case READ_RIGHT_TO_LEFT:
+		return -fb->format->char_per_block[plane_index];
+	case READ_TOP_TO_BOTTOM:
+		return (int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
+										   plane_index);
+	case READ_BOTTOM_TO_TOP:
+		return -(int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
+										    plane_index);
+	}
+
+	return 0;
+}
+
 /**
  * packed_pixels_addr_1x1() - Get the pointer to the block containing the pixel at the given
  * coordinates

-- 
2.43.2


