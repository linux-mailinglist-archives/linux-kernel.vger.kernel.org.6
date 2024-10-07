Return-Path: <linux-kernel+bounces-353793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969379932C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C111F23F60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51021DC189;
	Mon,  7 Oct 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C1yJQJDI"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EDC1DBB28;
	Mon,  7 Oct 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317458; cv=none; b=U94u1xptU9Mz27/vckpwNIzoP7TZ21yVU81FpkukEuVDIid40D6OQYNWkyYGL7j9qm4KPfURak6g4Wb23nirdOqOixPRrxvDvobzApz0ZP//sSC7EU+9q14qU79cPStbxq9CUFXLbQaTXKpEvqC7gASJH3WqudVQeg5phZwYkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317458; c=relaxed/simple;
	bh=Vb06RFIRfonrOTvoMJ7RFvbtWNOyLYGq/naTy6kIeM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvwszQKdFSKgC6shlXSFZTTQskePXRhOKnHI0fcNTXmr1EE3kQI0OKMPEOdkmii2iB00wAdXJXdKfesERqR6aSYyPhk1OVdDlBXOZfHuACGukj31o0ctTiLG6jtERvGQtH/jgOenDJMfCjvf/5C2YwctmF7k2U/dHRMJl7ulLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C1yJQJDI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F13614000A;
	Mon,  7 Oct 2024 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HS73Q9u/CO9V5UFHw6JF8KtX8PR0vVMp8vVwY3wchRg=;
	b=C1yJQJDImHiieGPxrxMjfi7S9crbuLPn+DA1hXGyq7Ie/ZFOY4jUIoNiBDheuHl2GZF0Dc
	Okvtik3DoHrcIgb4sEmXntIYnmkTrXAqsyupDC99ke3Puv1B3SxodjqmuV2zng0e6XZnX/
	zLfY/9b3wtrGz0fKQ6ujRXKVv8F9rzSsoJBnN68uKQHV0rB7wF7sedNk9MAobsFKo+N+1c
	RiO40yNygVYbNvu5bLe0hu78yIcZLHu7l2+zdK/7GfVsJ13IBDQ3TP7R0U4/iybeplElDb
	7oiCX8pchDAnNc7vt5dF7KrWMPm3+dI6gU8pA0bwBv13remb0qeh3VXNbXHpNA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:41 +0200
Subject: [PATCH v12 07/15] drm/vkms: Introduce pixel_read_direction enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-yuv-v12-7-01c1ada6fec8@bootlin.com>
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
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5166;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Vb06RFIRfonrOTvoMJ7RFvbtWNOyLYGq/naTy6kIeM4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgB4zXCbdOc9WWJjcOJYrxkU90zFOtCJMmcN
 zX4xAw3mUuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIAQAKCRAgrS7GWxAs
 4hRVD/9Kqx86wzBAkLM6sA/l2Rhy1sl2eE/c2KHO4YbNFI3i7dZtnxhkVKdkE2xwM1yAd1PUtnf
 sJJ1rpaqIvIlElM8JcpEDcrTGKsBqAa2cpzyXVNWB0QZ4NX7bV/veex07QznRCw+z5sTW1WIb+i
 YAcWIycHDaXO9bD4SmEEnMDgzihNQyspUrshcM9CMd+SreGHY4E4vdgD06dNBbWDcI9ky3y5RjS
 R+pMpEyrHmPKZvvfladccn6sMb5PVHXUoerPO9YXfsiZdTQUeUBONtZXZLA+Q7JQTSEdo/GzBYp
 CBPLcz+Ovkz7kC+yZpbpByDT6RlSkABSQ0iAbALdR36wRv8GkuEnCa2V+SefU6gpMfJNeEFGgPh
 DZCgZNyIZ/nLJtzDMKgzg6K+9P14+P3e3+yk50OcrJp+73ido1zML8V/N7AeMNZ+zmIgrdVtpjN
 zD0Biw2VntM6Zi/mm6S2TF3aVFcs/11gsU59+GOnkfDURC+mAfRZcX8p83cEaWhr6hkRVrld6Cj
 LclLralpKDDzPMtgGyHeFzBcjHRHd19ElB9TMnaboUYi0j7fRKNgtZKJnKiFYWXV4qqtPxjwNmc
 z6lyeTVwlO+XtOjRSqZ3GRmo7VVXKKMzIiQkwhJU5YZA7X+Qobb2UTbHgJmTODsvPeg5aAogRQH
 KCGbkLrV4stspYw==
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
 drivers/gpu/drm/vkms/vkms_composer.c | 44 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++
 drivers/gpu/drm/vkms/vkms_formats.c  | 32 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index ecac0bc858a0..601e33431b45 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -159,6 +159,50 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
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
+	WARN_ONCE(true, "The inverse of the rotation gives an incorrect direction.");
+	return READ_LEFT_TO_RIGHT;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 3f45290a0c5d..777b7bd91f27 100644
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
index 7f932d42394d..d0e7dfc1f0d3 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -79,6 +79,38 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
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
+				int plane_index)
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
2.46.2


