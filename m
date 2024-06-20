Return-Path: <linux-kernel+bounces-223621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B579115AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39029B234A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDDD14291E;
	Thu, 20 Jun 2024 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0ixRRID"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448079949
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922162; cv=none; b=ea4RLubC8EP7HgPd2RA41x9YDKF6vz0Lt8E48FQr0B99gv+ad5aXbkImjyGl9zCslghelsP+dtH1FXZsIFx+Gt2cIyXSby4Q+R6LDHF72kF9OFVjQpMQJI0Eek05cClD6gd6DtR/BVPxkoUB1GJpVGCTpIsHyVEzT1hHValVtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922162; c=relaxed/simple;
	bh=fSs2wuvgp++8OZuCCgLTePc/Q9AlGCBLh8ozGF+rsJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0KN5cFDSvmzTVSEHBEbaVvnXotSPe39QVhd23dRnyiFycB5wCHk49aUMQplCVWtVHHMY5NNHIvRCZitGY6OEU5658mNeLmy15XOYf7SB+dOMG/kzXs7yvxbJ1TSC+H8eCvELxV3bggSk8QxtvZ4njefoBHOQo9KoQyMt8jDUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0ixRRID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718922159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tUSKu5yoE2oDKyklqI6xQEXezvoLd1vxGEsotZZ2hLI=;
	b=c0ixRRIDXO+mZdlyZ1+E6k8BfkZtdlipGHhSqy0hAQR7k2wHfjqajlKBWFKDQvIly5oGRK
	luv+ppfcu0OC9+WE4apMUeJBW5aSy8c3OPRE2ISrkR86twWxBfUoeqdIYJHfxNH3obkVy1
	p/nk9d8HlAbqbWkFWLQEDR/SJoO0Y8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZBmFmsziOJiaaBimRvskeg-1; Thu, 20 Jun 2024 18:22:37 -0400
X-MC-Unique: ZBmFmsziOJiaaBimRvskeg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-364be6c2468so572463f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922156; x=1719526956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUSKu5yoE2oDKyklqI6xQEXezvoLd1vxGEsotZZ2hLI=;
        b=i2Mi0+dZC1iSsv43knNr2ZgCzfnWstEXrrUq1XW2C46C5LZyAp/vVwkzudE4ijqiJM
         8LK+g6jmmZWFD3cSYzLG+EBK2hC4Pqmc8CsvnouB/sVKS8sm7NQ7evx9L6JaymszCb9l
         R9TrtvQvRRyPUT+PAniBTYB/ggEtgfA3GMY3pTHo5qsoz2Di0+1Nj9lNlegTZw8fWFkc
         LLicSHGOU5K7osJSYd0I0qeaaHweBi4oMWxdf5XwF5FyUtq5cErYgs26cH7Mf2PZSzh5
         /y6Tj9YlWvsWJVj23XNidliAwghc1jF722BHD5XNYe95U13C/WlsvDOYFsUYm1sSOdiA
         tuCQ==
X-Gm-Message-State: AOJu0YybvdmENS9teVEoGBD7oZMCqnxV5MfTGEPuRBBh1AigA3p97O21
	yKQykr7oELKhFUIsOKV5SphNU5cwRCZ2I8c+ODBk7rrmSymgaBzPyxVwbAx33+u7v/1A2sT7TpG
	ro0JRGTaU4B8szzMk1kv3e3jKDNsZafBnTK+43DAQBmPt1RgUQteHCA6u1wAJzIYT/aZaPpC0nD
	eAPxzC1ef64pr9Guyl7iARhQzP0rj2M/M/94cU6udAYhh/
X-Received: by 2002:a05:6000:1108:b0:360:9c4f:1fe with SMTP id ffacd0b85a97d-363193c6376mr4975809f8f.43.1718922155921;
        Thu, 20 Jun 2024 15:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcr7BSscA9WVORAeOG6Ti0XGGWuSfyV7L9iwJsVVVKPQm49qFce+vH/jcri9ZqNmEamqB97w==
X-Received: by 2002:a05:6000:1108:b0:360:9c4f:1fe with SMTP id ffacd0b85a97d-363193c6376mr4975790f8f.43.1718922155343;
        Thu, 20 Jun 2024 15:22:35 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be818sm41577315e9.15.2024.06.20.15.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:22:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Add drm_panic support
Date: Fri, 21 Jun 2024 00:22:16 +0200
Message-ID: <20240620222222.155933-1-javierm@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the drm_panic infrastructure, which allows to display
a user friendly message on the screen when a Linux kernel panic occurs.

The display controller doesn't scanout the framebuffer, but instead the
pixels are sent to the device using a transport bus. For this reason, a
.panic_flush handler is needed to flush the panic image to the display.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 6f51bcf774e2..0bac97bd39b9 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -32,6 +32,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_rect.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_probe_helper.h>
 
 #include "ssd130x.h"
@@ -1386,6 +1387,63 @@ static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static int ssd130x_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
+							   struct drm_scanout_buffer *sb)
+{
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_shadow_plane_state *shadow_plane_state;
+
+	if (!plane_state || !plane_state->fb || !plane_state->crtc)
+		return -EINVAL;
+
+	shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+
+	sb->format = plane->state->fb->format;
+	sb->width = plane->state->fb->width;
+	sb->height = plane->state->fb->height;
+	sb->pitch[0] = plane->state->fb->pitches[0];
+	sb->map[0] = shadow_plane_state->data[0];
+
+	return 0;
+}
+
+static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *plane_state = plane->state;
+	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
+
+	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
+			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
+			     &shadow_plane_state->fmtcnv_state);
+}
+
+static void ssd132x_primary_plane_helper_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *plane_state = plane->state;
+	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
+
+	ssd132x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
+			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
+			     &shadow_plane_state->fmtcnv_state);
+}
+
+static void ssd133x_primary_plane_helper_panic_flush(struct drm_plane *plane)
+{
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
+
+	ssd133x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
+			     ssd130x_crtc_state->data_array, &shadow_plane_state->fmtcnv_state);
+}
+
 /* Called during init to allocate the plane's atomic state. */
 static void ssd130x_primary_plane_reset(struct drm_plane *plane)
 {
@@ -1442,18 +1500,24 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
 		.atomic_check = ssd130x_primary_plane_atomic_check,
 		.atomic_update = ssd130x_primary_plane_atomic_update,
 		.atomic_disable = ssd130x_primary_plane_atomic_disable,
+		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
+		.panic_flush = ssd130x_primary_plane_helper_panic_flush,
 	},
 	[SSD132X_FAMILY] = {
 		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 		.atomic_check = ssd132x_primary_plane_atomic_check,
 		.atomic_update = ssd132x_primary_plane_atomic_update,
 		.atomic_disable = ssd132x_primary_plane_atomic_disable,
+		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
+		.panic_flush = ssd132x_primary_plane_helper_panic_flush,
 	},
 	[SSD133X_FAMILY] = {
 		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 		.atomic_check = ssd133x_primary_plane_atomic_check,
 		.atomic_update = ssd133x_primary_plane_atomic_update,
 		.atomic_disable = ssd133x_primary_plane_atomic_disable,
+		.get_scanout_buffer = ssd130x_primary_plane_helper_get_scanout_buffer,
+		.panic_flush = ssd133x_primary_plane_helper_panic_flush,
 	}
 };
 
-- 
2.45.1


