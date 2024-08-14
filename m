Return-Path: <linux-kernel+bounces-286163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B18951767
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645BA1F2241E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2E14A090;
	Wed, 14 Aug 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bVYNJZgJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28416146A8A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626548; cv=none; b=kUaKFjpjwKTS+LBkAJXFCuipIep9Byo/PCzJpeMzMALdPHvNTE+aY2Niobzl8XLRhlGZnSu0UZXpSjw4li0nLoNefjG068LOq1SjffoFybZfyKJiz5RFiR9SCYTyZDh+1wGjgETtycMXihfnFR5iquze0dKwi0dchiT5mCAY+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626548; c=relaxed/simple;
	bh=EtMwyYObUMMt6YZytBOJHS/AQ/ejyKw1fpw/ux2RB2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMAI1rxV1ClnOpIEzC8CXlAks5d8Lo+bcSHNMQ1PVVanQiTIy8r62mO1qDRWkoWC0IeYjPIM5d5+177+7GpI4IEw0tHcAGdwLaK3TjtCprKAoJyBYTwlNsHAR9kcQ4PdrbdXCUl7BEf59aGNRRC4rflPiPLl0d+NiV0TCxcFR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bVYNJZgJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4ABFE000F;
	Wed, 14 Aug 2024 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723626544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED+HOeGmnmUkq6frZqCsTOUYHpHML93Xa2aQzTI/HIc=;
	b=bVYNJZgJIA5TT4IFdWcnD+Mj1HiEl1W6mFFrkVaC7AylwWoMguJg9uqT0Fww4XBU3KQdjC
	PriVFsvkt50A4VHXzMSpTIPO8G4u184OpfCYb31bas5Wf3oBIupe39oDljJQkhkxYwykse
	ZRMXJsqbRNf4NYyAYhAgZX+DwmHu1Pv5huMuXZTUggo2EKEQ/jUnRcdwG2+kFg/g5or2RX
	ME1XD/ok/DqAMfAgqpM13bBihoeEtZX9jTGb4M0yTxbvq/8/FjRW08lR6o9W/D+mz/uMau
	BnqxartjqCQXkCMSuXlSjOytsij692CISyA76+YWuwZHVrFOSzVCwy0rOsK4zQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 11:08:59 +0200
Subject: [PATCH RFC 6/6] drm/vkms: Extract vkms_composer header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-split-headers-v1-6-51712f088f5d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=EtMwyYObUMMt6YZytBOJHS/AQ/ejyKw1fpw/ux2RB2A=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvHQoS4mVVH+Y4GF0oDaeXFl+TGNQYB9N1GoWg
 qMODdsmgF+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrx0KAAKCRAgrS7GWxAs
 4tnKEACIPsado9TgqNkuND6BhB0kJj9Q9QPUjU1v1KmUcCPCp42peWtI5jDISuaIltcZTiQYvmN
 6S/RNJPseVpToo/C6NAwoIX1XSNaOx7VW8jrA6CmxHHG1KfY5Jfchsk+alunSh/bMjLGVaumdoB
 kOh9BvxkyZzAldsQjcEzQyQYE4aP4JTW91aanEcnq4orFsyFopQModvVO50hg2UcRMz83ooIxH+
 WZACswhy9zb7FxKWLzTv+HYAo4ws7NPgopjU9eb9dz/ZzTbLfdWVdz0phCo+QsNbBi+0yKJugw5
 8qwlOuadeDRNuKtR3xFx+uC18zQ1h/AAqAyzvXV3LmrdxD/KPQ/21CONjN200Ct5JTYs5Eytg2Z
 3SFLY4QcHb5xt4nHEM81DQaE+Q8enUREwhrxkrH+Ea8B6lLphmMttPFPzWrTMYaP8AiIR2pn5d7
 4YV8Dirp09L/5WwbwEEv4R6Xg7vHPZpe5t3Yh5lM78CNOHtvGacV+ZjSHPm+OACohgSNzMIZ4ao
 EnvsgZospmZC4gqpeTHvN4sf2RL2iCXFmi3XmCwMDXSdutrt2jjuxjUCCOPZNVOo0lKIXkfGy8O
 P+O0USZliKxzjCXnAWS+ty4CQX3PSeTbxqmLm7b2iF8d2xeVT/rhO7hCgkxtXTjy0hh3qnM8B6q
 8EncGhDKXzukx/A==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The vkms composer functions are defined in a different .c, so make the
same thing for the function declaration in the headers and create
vkms_composer.h.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c  |  2 ++
 drivers/gpu/drm/vkms/vkms_composer.h  | 18 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c      |  1 +
 drivers/gpu/drm/vkms/vkms_drv.h       | 11 -----------
 drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 139d249454c4..15ef07ed304e 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -10,7 +10,9 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 #include <linux/minmax.h>
+#include <drm/drm_print.h>
 
+#include "vkms_composer.h"
 #include "vkms_crtc.h"
 #include "vkms_writeback.h"
 
diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
new file mode 100644
index 000000000000..91b33af1e013
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_composer.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _VKMS_COMPOSER_H
+#define _VKMS_COMPOSER_H
+
+#include "vkms_drv.h"
+#include "vkms_crtc.h"
+
+void vkms_composer_worker(struct work_struct *work);
+void vkms_set_composer(struct vkms_output *out, bool enabled);
+
+/* CRC Support */
+const char *const *vkms_get_crc_sources(struct drm_crtc *crtc, size_t *count);
+int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
+int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
+			   size_t *values_cnt);
+
+#endif //_VKMS_COMPOSER_H
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index cb6e49a86745..6fae43932b60 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -9,6 +9,7 @@
 #include <drm/drm_print.h>
 
 #include "vkms_crtc.h"
+#include "vkms_composer.h"
 #include "vkms_plane.h"
 
 static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 943ad55e0172..f74a5c2045f9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -106,15 +106,4 @@ struct vkms_device {
 
 int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
 
-/* CRC Support */
-const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
-					size_t *count);
-int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
-int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
-			   size_t *values_cnt);
-
-/* Composer Support */
-void vkms_composer_worker(struct work_struct *work);
-void vkms_set_composer(struct vkms_output *out, bool enabled);
-
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 48f3f7f2e2a4..5e75880a5845 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -15,6 +15,7 @@
 #include "vkms_writeback.h"
 #include "vkms_crtc.h"
 #include "vkms_formats.h"
+#include "vkms_composer.h"
 
 static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_ARGB8888,

-- 
2.44.2


