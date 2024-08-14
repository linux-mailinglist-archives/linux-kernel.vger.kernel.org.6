Return-Path: <linux-kernel+bounces-286158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E8951762
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217331C21576
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68621448CD;
	Wed, 14 Aug 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k8XgZP6S"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A936134
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626543; cv=none; b=uscAU9Cp2iEu7jKXenwfnZDKkwzG9lp+zXCZwgk43hq5FxewZ7y3MCFV/mRPqL+gIf49Y11I1s6Ag0cTrxkIi1D5lN+PTl7acekjhEMtzLTMmS8O6KbIVnDM66Y7P183QYlpyFgDfw1+hsO3IfxZtYyI1abYkPVGuPbVB+vAa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626543; c=relaxed/simple;
	bh=wcn5rhlykOkvmwik/0bRg72AOmiKANLOex5UmwYu3Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGiR/woXyRqXY4KrPmEe7roYgxbUpSrF2/V5TAP3v2Ldbpc3RgDKX4lDJwr5iqxtBOi9Njof5JXqJVKWHARJeq7xzk3EKVMOoSw/V3PfNY1jwEDFjWoaVL8RqXDbUsHlOCp/+E3c7NezoGc7wpFVPyFyZOzsUHh/Lxypds/Wi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k8XgZP6S; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2AE1E0002;
	Wed, 14 Aug 2024 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723626539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOZFHW+W/DVmEYqLRNmRdAR4MlZjPTzw/O+T3sV03RE=;
	b=k8XgZP6SMwBrFMhCZAbcTGaM/z8hgEN4JrPtL9ijO5frLiUydr/5Aq2Di2tmlSgSQXhIM4
	iYUENN3GA2lBScBFT3x6EHP/aGdVyZto95bL42qgWwYzAKX+EPecm+y3xnKlRxo2vEs8NL
	sFORunG6yAXm2J+creeoIl+G0ABPlyq/dJnGBdJZSkOGPciX92wBdI/I5A220acoxuBL8Y
	/QtY+aSl6SGklzYPtlGG0B3E2xlSygxnCkOV3WMtvTCSbI4bH23fzAh+bSeN0viyF5xu9n
	O+bh0xgtZh2XYUmolKHnmS/160ksW0dQNeTH7uE8QuLSU4dZVPzIBXUIcV/jKg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 11:08:54 +0200
Subject: [PATCH RFC 1/6] drm/vkms: Properly extract vkms_formats header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-split-headers-v1-1-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-0-51712f088f5d@bootlin.com>
In-Reply-To: <20240814-google-split-headers-v1-0-51712f088f5d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8030;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=wcn5rhlykOkvmwik/0bRg72AOmiKANLOex5UmwYu3Ag=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvHQoqC6pywi1DFW1PbPfhsqUFJGOQ9t9E9B5h
 w3qXXFZGweJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrx0KAAKCRAgrS7GWxAs
 4gZJD/4sBFGVdOB/71UDrLopJkJUxFhcSOW/90xJKjReMnMHSzUaw3LAEM6BGlexyICZyQbcZWg
 6VQh/gUb87V05kCUxItGNeJlbbIErTHYOvlindlKPp0+m3pZGDzSPiJrTVMrdxUlNDyDhUjZxwM
 4xwfzA2QeYf0bhCZ65GDbEKSzZSPkUOlTLQWwgOhvVppsYcU8u5TkCVwL6jNzSkETK7NiexDJZF
 V5hmV1BlrU0N2AjJnariOlAFdnq4PDJ1Cte3W5ImgCbmuTGTwQ25xdQUixpEi8u0X0kWuiGdFe7
 SmEebxBD6DaZWG0sb2zLlwTUj2uOL6zmnfMGq+APSrBOPUkEI/R95vVFBO3Gc1gGWA1IAW/cjq6
 T3+5FapIsGQ4ah3wEb3h9I4Nv566qwLGET+SE3oam9zogqkMWzLLgfof5cHPgH2Ju7MOGyYpTH+
 Qr5bM35HbteFlBa9DDTVIYEkdLpjt0LlDaBfT+Lt/wOFeCQiGx8VYgtUKtoBJsZBW3BJ5CVWfak
 uMxgNHf7hWMviLHHxJQ0Gq/ZrNWxjSryp2eDnKxI30UeXUXOYbhA4yd8BOux3x2reH5SbM3iqGV
 +iFX+GQvl4Wnmotfiv9q5PETgmUFH/pwC6eaflYiLDSzpNXY9rgXoyngOnAdP00g8Y0Va2EAyqL
 89rpxsfBrJkFEyw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The vkms_format.h header was already separated from vkms_drv.h, but some
function were missing. Move those function in vkms_format.h.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h     | 74 +---------------------------------
 drivers/gpu/drm/vkms/vkms_formats.c |  3 ++
 drivers/gpu/drm/vkms/vkms_formats.h | 80 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8f6c9e67e671..0db443924a15 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -12,6 +12,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 
+#include "vkms_formats.h"
+
 #define XRES_MIN    10
 #define YRES_MIN    10
 
@@ -43,29 +45,6 @@ struct vkms_frame_info {
 	unsigned int rotation;
 };
 
-struct pixel_argb_u16 {
-	u16 a, r, g, b;
-};
-
-struct line_buffer {
-	size_t n_pixels;
-	struct pixel_argb_u16 *pixels;
-};
-
-struct vkms_writeback_job;
-/**
- * typedef pixel_write_line_t - These functions are used to read a pixel line from a
- * struct pixel_argb_u16 buffer, convert it and write it in the @wb job.
- *
- * @wb: the writeback job to write the output of the conversion
- * @in_pixels: Source buffer containing the line to convert
- * @count: The width of a line
- * @x_start: The x (width) coordinate in the destination plane
- * @y_start: The y (height) coordinate in the destination plane
- */
-typedef void (*pixel_write_line_t)(struct vkms_writeback_job *wb,
-			      struct pixel_argb_u16 *in_pixels, int count, int x_start,
-			      int y_start);
 
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
@@ -73,53 +52,10 @@ struct vkms_writeback_job {
 	pixel_write_line_t pixel_write;
 };
 
-/**
- * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
- * plane.
- */
-enum pixel_read_direction {
-	READ_BOTTOM_TO_TOP,
-	READ_TOP_TO_BOTTOM,
-	READ_RIGHT_TO_LEFT,
-	READ_LEFT_TO_RIGHT
-};
 
 struct vkms_plane_state;
 
-/**
- * typedef pixel_read_line_t - These functions are used to read a pixel line in the source frame,
- * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
- *
- * @plane: plane used as source for the pixel value
- * @x_start: X (width) coordinate of the first pixel to copy. The caller must ensure that x_start
- * is non-negative and smaller than @plane->frame_info->fb->width.
- * @y_start: Y (height) coordinate of the first pixel to copy. The caller must ensure that y_start
- * is non-negative and smaller than @plane->frame_info->fb->height.
- * @direction: direction to use for the copy, starting at @x_start/@y_start
- * @count: number of pixels to copy
- * @out_pixel: pointer where to write the pixel values. They will be written from @out_pixel[0]
- * (included) to @out_pixel[@count] (excluded). The caller must ensure that out_pixel have a
- * length of at least @count.
- */
-typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_start,
-				  int y_start, enum pixel_read_direction direction, int count,
-				  struct pixel_argb_u16 out_pixel[]);
 
-/**
- * struct conversion_matrix - Matrix to use for a specific encoding and range
- *
- * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a row-major manner and is
- * used to compute rgb values from yuv values:
- *     [[r],[g],[b]] = @matrix * [[y],[u],[v]]
- *   OR for yvu formats:
- *     [[r],[g],[b]] = @matrix * [[y],[v],[u]]
- *  The values of the matrix are signed fixed-point values with 32 bits fractional part.
- * @y_offset: Offset to apply on the y value.
- */
-struct conversion_matrix {
-	s64 matrix[3][3];
-	int y_offset;
-};
 
 /**
  * struct vkms_plane_state - Driver specific plane state
@@ -140,12 +76,6 @@ struct vkms_plane {
 	struct drm_plane base;
 };
 
-struct vkms_color_lut {
-	struct drm_color_lut *base;
-	size_t lut_length;
-	s64 channel_value2index_ratio;
-};
-
 /**
  * struct vkms_crtc_state - Driver specific CRTC state
  *
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 65fdd3999441..5ab84801d8da 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -6,9 +6,12 @@
 #include <drm/drm_blend.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_fixed.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
 
 #include <kunit/visibility.h>
 
+#include "vkms_drv.h"
 #include "vkms_formats.h"
 
 /**
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index 852ab9a4cee5..62b06bc26e79 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -3,7 +3,85 @@
 #ifndef _VKMS_FORMATS_H_
 #define _VKMS_FORMATS_H_
 
-#include "vkms_drv.h"
+#include <drm/drm_color_mgmt.h>
+
+struct vkms_plane_state;
+struct vkms_writeback_job;
+
+struct pixel_argb_u16 {
+	u16 a, r, g, b;
+};
+
+/**
+ * typedef pixel_write_line_t - These functions are used to read a pixel line from a
+ * struct pixel_argb_u16 buffer, convert it and write it in the @wb_job.
+ *
+ * @wb: the writeback job to write the output of the conversion
+ * @in_pixels: Source buffer containing the line to convert
+ * @count: The width of a line
+ * @x_start: The x (width) coordinate in the destination plane
+ * @y_start: The y (height) coordinate in the destination plane
+ */
+typedef void (*pixel_write_line_t)(struct vkms_writeback_job *wb,
+				   struct pixel_argb_u16 *in_pixels, int count, int x_start,
+				   int y_start);
+
+struct line_buffer {
+	size_t n_pixels;
+	struct pixel_argb_u16 *pixels;
+};
+
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
+/**
+ * struct conversion_matrix - Matrix to use for a specific encoding and range
+ *
+ * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a row-major manner and is
+ * used to compute rgb values from yuv values:
+ *     [[r],[g],[b]] = @matrix * [[y],[u],[v]]
+ *   OR for yvu formats:
+ *     [[r],[g],[b]] = @matrix * [[y],[v],[u]]
+ *  The values of the matrix are signed fixed-point values with 32 bits fractional part.
+ * @y_offset: Offset to apply on the y value.
+ */
+struct conversion_matrix {
+	s64 matrix[3][3];
+	int y_offset;
+};
+
+struct vkms_color_lut {
+	struct drm_color_lut *base;
+	size_t lut_length;
+	s64 channel_value2index_ratio;
+};
+
+/**
+ * typedef pixel_read_line_t - These functions are used to read a pixel line in the source frame,
+ * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
+ *
+ * @plane: plane used as source for the pixel value
+ * @x_start: X (width) coordinate of the first pixel to copy. The caller must ensure that x_start
+ * is non-negative and smaller than @plane->frame_info->fb->width.
+ * @y_start: Y (height) coordinate of the first pixel to copy. The caller must ensure that y_start
+ * is non-negative and smaller than @plane->frame_info->fb->height.
+ * @direction: direction to use for the copy, starting at @x_start/@y_start
+ * @count: number of pixels to copy
+ * @out_pixel: pointer where to write the pixel values. They will be written from @out_pixel[0]
+ * (included) to @out_pixel[@count] (excluded). The caller must ensure that out_pixel have a
+ * length of at least @count.
+ */
+typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_start,
+				  int y_start, enum pixel_read_direction direction, int count,
+				  struct pixel_argb_u16 out_pixel[]);
 
 pixel_read_line_t get_pixel_read_line_function(u32 format);
 

-- 
2.44.2


