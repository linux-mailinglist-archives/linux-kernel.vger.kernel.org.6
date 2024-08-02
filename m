Return-Path: <linux-kernel+bounces-272813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE50946189
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5F1C20A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6211E4859;
	Fri,  2 Aug 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZzGaXTk"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF811537C7;
	Fri,  2 Aug 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615021; cv=none; b=PGZPA7zrr5HRepzdIDPOUtBFEL3bsXdoknw+YrRSDe/2tm90+2WEDFA+UvuqvXiQYKu90k4J8KcZmzweAn32OnoA/PV9ugcKS6Ug9xHBG9DEzsIwkax6yNTKbyWAxPS/LgIPwX9npT2l0YvDzfkDlt1o8CXql9jC2awZp1DRQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615021; c=relaxed/simple;
	bh=pV2w7SYIDQgdzic3YpD5B0l1HAwEAzOJk1TnYgQZ7YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZzqOacMBNsYn9GsZcjb5hdN7gfZgw6agzo2TPvJWEnMo7NvcEzcf9k2la0hue0dAqXG+Je+nRDVWznbn658uJRCdEIOdBw+z1uVMovPH2tmCFSLS+UaXApEYRc/PfOKt5XCCqMs8JBi9cxTwzMN1l9c8FPjBMinJU7SLqwkXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZzGaXTk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C60B1C000D;
	Fri,  2 Aug 2024 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRD/yUCJyHWj+8lgH1LtiDRldYrv7N1Ih+rRVAnGEa8=;
	b=KZzGaXTkaikLNvkj+ZDvHA+5BnOadhanYNMlclop44JbEPl+BrsWDDIMlQfRmp7ZZefVS8
	qeuL6OYSblSlr5QHG7eL/rjOeBF2OHQEB+cDoS+EzpRqBoZgUCjY3BOSw2hZib0Oz6s96b
	VB0vJxC5CWyKGZF7b9EwL3ggMXV1leiljGs1oXyDhAiTqIUy07TlUY2eBEEfR9XogKU7p9
	Z4xwMHK337EdN7Avv2SxWT71AwTqdab1fbOSiuTatNkolNMHWUpzf1IW2SULyAbkiKAsKt
	p0wWdWmogVUQFufKqhyPSAlLFbs0t3m5fG4rA8R9IpZTBshoUiuRdBjF7wSvaQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:54 +0200
Subject: [PATCH v9 09/17] drm/vkms: Introduce pixel_read_direction enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-9-08a706669e16@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5177;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=pV2w7SYIDQgdzic3YpD5B0l1HAwEAzOJk1TnYgQZ7YQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTaBFPE82MwdFmDgFesXbWrOinJHyDr1vQAA
 0hLrWUxg8eJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2gAKCRAgrS7GWxAs
 4jd0D/0TQwlKE8ahvHxuFEeFBrea6lwf07AtFB5DhQ7ERo9WhtzE8BaqDloAUKpIm4oVwl1uqNm
 G4HUxcpAnDmt5Ca4gJP0/cnhGT0kEBUBxYwUAt65CRbmBlGqAd3mZPttOfoSXA6OsHAqazcoue6
 QIRbax2S5jbdi0TYxBTla5+zi/gOFyx2/uUng2n+jN2iAVPC7yMdkBnxhkZ44uGHnrdiMmegxda
 1rbJtaFZjmd927mAsD627zbkCUxdkt7OZE9L4OF166AMzTIwgk8cBDbQHooG7gaOV+mwzutUBny
 YLFo3udRdMzg9lWYbvfeh/fgF/3VL6nhU9DRHG2W+U1sdiNgYUaPQoI4Xz/sWU242m5X6ONbTmw
 91LVXi+VnaQmKgZ4QrFPm1ab9eWuf4/ClAEt8tgsMjKPBcDLBTEyKM2+5gEk7FgIeaZHs0k6CZv
 XgCHf8AnXGvd4cJMg03z4lfKmZH4ZcTVzUAqRh3EA4FF7gslvC1IKb1iEZ0HYimczardsUKq4Rd
 lIYFOiAOVSEg3CrWmZUjeUJgK2qeKy2u5tHaW5KT2bQHDy3LYERgtnmTaGEruA74XCx0+mdfE8n
 9whj+DKTpSyAiIQ8XiElC9EpfMm1YeksZ4eOPuPbrup9mtbebtfOb/PB6OdreBoASThYMstt7op
 QiASVxvOmsyhZ7w==
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
index 4d220bbb023c..98da4dff2d40 100644
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
index 8edbf44a6896..857e7ce1fb9f 100644
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
index d11f977d0abe..335f8c58c7bc 100644
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
2.44.2


