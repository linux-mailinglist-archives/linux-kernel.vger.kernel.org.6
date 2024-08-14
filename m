Return-Path: <linux-kernel+bounces-286159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41964951763
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424931C212BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78914533C;
	Wed, 14 Aug 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="avj3XkD8"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630B14373B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626544; cv=none; b=jyEWlKUAgrFcg15DDyDPLK71kEEmvO+K5QRZkDLqA49N8S0snf9rJxuewmzswWj4EGnUg9zJki7r3mO0JWhCYHreiTnUF7QClLOjeeLgdK/yg9qWy/Fw7I7FqT0El8CHH5gqDeVNlMH7ulOuiBevlNSZnHje/lBIMyjY5RaJQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626544; c=relaxed/simple;
	bh=fnG8pGOeJLMxmn04io3JIQ0+cXQo2UouKDjQL6gXcyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sqhCHFFlz5F2Wih5jInzujJp0Sojvuz6J7Wzx4ECecIkjbWzC9aBqJpYZ1cV7UEXMGrZZ1rtX/dcfBXbj4ptg93P21BVpyZ/kH/QDeIQ+bGd9hjjHfKrrttzqQHXJ0VQA6SjRrP0UnOkziIZFr+2ABmb7oSvn8eWN8cSacA1geI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=avj3XkD8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEB98E0009;
	Wed, 14 Aug 2024 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723626540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMyLkRGQhKcP4c3c0598fLvU0CW/sowhcsEn8e+aUBU=;
	b=avj3XkD8sxmz7jvZL6kdKjwcnbF8+qp9sZSWKEMDv+ysGbKqNwKTPCBlHEPF+XzSsUL8PV
	5lbK3JzzLWi5RPLsBu44nX8uu0ClgTnWV3kCgrOYp3tN2t4lILIgXwJqwgc2Hw6VD5yNjs
	2l3mrtUrtx9SBvFPS+0CMrg4ISdirKN/qJvbGRhPO1WNIOs6IyVuENxdck3fB2Y/98Wt3i
	+SKwO5OH4SK/FsG3b/PadGK4uez+Ao9Me4Gf/xl9pvgsKNx3Hg0JnD4u37E+e/gQRlGeYB
	hMSkewZ6nc+A3dRuuQO4aqkRQFBHGd6XFQsdIwBWkKL3n0/j7KXv0vF3W/7dQg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 11:08:55 +0200
Subject: [PATCH RFC 2/6] drm/vkms: Extract vkms_writeback header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-split-headers-v1-2-51712f088f5d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3863;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=fnG8pGOeJLMxmn04io3JIQ0+cXQo2UouKDjQL6gXcyc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvHQoa//98A+yCJRJ7UobkdsmAqg5qclS2rDC1
 2Mgge5m9bKJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrx0KAAKCRAgrS7GWxAs
 4vP9D/9UrEwRUGijYD8URsz+RGG7Cgs4rMPsVOaHktAmO0zrOQ7UCkfBk402eMztG8dCGCrZRtG
 wbuvGiWccThGXJQJSxFyx0GCTTKKGBGYBsz5UnZAscSZG/LWRpbOPAGeWppa5agFwvecB1C9oAz
 2PG0uq4ryPRXNAGNoChMfrys8rWcaMutjwwrGNXn8CYauvmEAa0UeVBOW2PeEGSiw0tlnOV0Yo1
 oN3DN/nlg6mx+Ej2nXQIZQJLKxPal9ax9JgGx38dxfyi9jCkD3zvKtpU7b/ELBw8+Qyi0NJSwlw
 OcIP/RQXFWr/JGlnaVTq1gwgU1FXeLc1/cGNXMSiSwCzqjFSMEzIWxPcADBzN8qH/K8uynQDwmV
 4lAT2Ef2i7C/RwgDKCeTwBNgjjVvgkveZPbqGnyS9SOqfQsvMmNcmIq28EO6TstUCEfLOycU/4S
 plVuSSryKUtPYkxdTK9KquI/a/JBlidLZUk/4Lb9MLE0EixozX1WJJ5kZhBfV7K73kP1s5Xz7FN
 4jU1FBd8b1QUpiKzXzi8x5PyXRuRgulrFt6l14dgHTaZ8xg8upb0za0er/KOwp/FbUQSqLysoWJ
 9BXpAbMhJ7iF+4NDYHrQw0Ub2FSsXcuzX31Q9NCVaS1bidqdZCWPUEpdkQuNxZ1c4ef5Vwt3May
 py+nO9+T83eRu4g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The vkms writeback functions are defined in a different .c, so
make the same thing for the function declaration in the headers and create
vkms_writeback.h.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  |  1 +
 drivers/gpu/drm/vkms/vkms_drv.h       | 10 ----------
 drivers/gpu/drm/vkms/vkms_formats.c   |  2 +-
 drivers/gpu/drm/vkms/vkms_output.c    |  2 ++
 drivers/gpu/drm/vkms/vkms_writeback.c |  2 ++
 drivers/gpu/drm/vkms/vkms_writeback.h | 20 ++++++++++++++++++++
 6 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index f0cae142ac22..825011f696ee 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -12,6 +12,7 @@
 #include <linux/minmax.h>
 
 #include "vkms_drv.h"
+#include "vkms_writeback.h"
 
 static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0db443924a15..46daa2fab6e8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -46,13 +46,6 @@ struct vkms_frame_info {
 };
 
 
-struct vkms_writeback_job {
-	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
-	struct vkms_frame_info wb_frame_info;
-	pixel_write_line_t pixel_write;
-};
-
-
 struct vkms_plane_state;
 
 
@@ -225,7 +218,4 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
 
-/* Writeback */
-int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
-
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 5ab84801d8da..cbfa7943e948 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -11,7 +11,7 @@
 
 #include <kunit/visibility.h>
 
-#include "vkms_drv.h"
+#include "vkms_writeback.h"
 #include "vkms_formats.h"
 
 /**
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 36db2c8923cb..0c55682337a4 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -5,6 +5,8 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
 
+#include "vkms_writeback.h"
+
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 7e0302c0830c..4a830a4c4d64 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -10,8 +10,10 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_framebuffer.h>
 
 #include "vkms_drv.h"
+#include "vkms_writeback.h"
 #include "vkms_formats.h"
 
 static const u32 vkms_wb_formats[] = {
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.h b/drivers/gpu/drm/vkms/vkms_writeback.h
new file mode 100644
index 000000000000..70f0c4c26c23
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_writeback.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _VKMS_WRITEBACK_H
+#define _VKMS_WRITEBACK_H
+
+#include "vkms_drv.h"
+#include "vkms_formats.h"
+
+struct vkms_crtc;
+
+struct vkms_writeback_job {
+	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
+	struct vkms_frame_info wb_frame_info;
+	pixel_write_line_t pixel_write;
+};
+
+/* Writeback */
+int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
+
+#endif //_VKMS_WRITEBACK_H

-- 
2.44.2


