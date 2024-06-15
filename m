Return-Path: <linux-kernel+bounces-215799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCF909721
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B3D28344B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D71C280;
	Sat, 15 Jun 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpcVQRfi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3C179A8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441620; cv=none; b=HVqdLgUoV/dggUi8Z3vh3Xzpk4D3PUszuSr9shMxqMkUul9w1LQKSJS/d9OwBMIOwF8Jc5GodsRh7izilfAFWzjVKx+4faLBptGNui6Rf9erS4F6fhBam7wbCA3Tp4QqVBmEXxOFjFdHm7ksRzMY8+q1Ez3Ds6RO3xHbf6rTKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441620; c=relaxed/simple;
	bh=A5denq1MtVmoWdMWyF7FXRXEb8dy8ohP7Moy1rmAyd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aD+rD/ZzrfUq3kHXquzohJZTEnGp7MxVEpdAJ49jUImwzvOI/sjl+lfxhuUD8L5DzknKlHYcZhXZqt0PaqUT30P4m1efHYbf5hWlVzo7iyaquAGqtU9zLccaxN500Aedayj4BQQBDMo1aEKo++a3CpPt3Xlhk+mgbLMvuIwUVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpcVQRfi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718441617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4KAnLuJK5ca8N90TBc5SqAtDvhbdQGO+rCBjODh2EaA=;
	b=dpcVQRfiy/KyaFTic7PhDEd1VlrCnbJQIdhctat/MwaB7o6TuLPM146nLfsXeEiIusfU0K
	1hRgXGjoDJy26nYh67O89kLpGfMmMrrWxEByWHyl6ytsRgXboJ9N0tu8B03qWY4b3i5pmX
	I4eQk0uROHVRmKhVpg7YdlCtfEt4aOY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-W-ApX0idMwOFd74Cr-DREQ-1; Sat, 15 Jun 2024 04:53:35 -0400
X-MC-Unique: W-ApX0idMwOFd74Cr-DREQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c844aec2eso2257843e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718441613; x=1719046413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KAnLuJK5ca8N90TBc5SqAtDvhbdQGO+rCBjODh2EaA=;
        b=F2qy7AmTs78+t3arBDjIdIgwYlmgqR/0q3ES770Ny8DEzcCDD0KQBHMPRopfHfSnmh
         vjxrh+TBOW5TgbYBn3ufR8Z24/BzN29UaPkWPVgP9XkGCwPmzPFtyW8kwo1Cd7rSWt3j
         z2kTnoANETcD4EVQ8YS2zYch/HYjcSe+IhpUdvd4zZJT7Jv97+jnGqSWa4oKa9uXzm7c
         0KjFye8GIc3sGFo2btmFipMipZS4gJHiEoE6KAkxM0OdYQnNg5Hf6MpsdHAU9BKEtjC6
         1fZeMpK9xp+HSmaZxgF/o7XKH9aNXhFixqckKRf7uxvvSAWtgUnQSHMDE1FVrCK+LAQQ
         JEIA==
X-Gm-Message-State: AOJu0Yyh3vnu5kQnZbG38tn2P3XDWdK+WmcX+Df36XEy40L26Eqh0FXO
	y4xd1O8VyEthytArIaPu/DBeKvFXE/YB7iRGNAj6Nnt+WdZqUXPjBomx/zUoP8zgq4puo9nos8o
	8b5NH2B1krAGgVW5d59Fx79cRa5OL6D0qzIfNNqwmkYeKqtjaVJba+gkzZHLCGa4oFgDhnaQouO
	jrt2J6cGuAb9XxaoLQS5600h3V4+R4gZHOug8mfIjN9Np+
X-Received: by 2002:ac2:5931:0:b0:52c:8a37:6cf4 with SMTP id 2adb3069b0e04-52ca6e56394mr3070364e87.14.1718441613179;
        Sat, 15 Jun 2024 01:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgscFiGF51kdQUAooo17serhr9s1595/yp1C5TX0wDDST4aYfIyM2irfok4qUH81+JMvDnQA==
X-Received: by 2002:ac2:5931:0:b0:52c:8a37:6cf4 with SMTP id 2adb3069b0e04-52ca6e56394mr3070344e87.14.1718441612540;
        Sat, 15 Jun 2024 01:53:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42285574e33sm55265715e9.1.2024.06.15.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 01:53:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/tidss: Add drm_panic support
Date: Sat, 15 Jun 2024 10:53:18 +0200
Message-ID: <20240615085326.1726262-1-javierm@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the drm_panic module, which displays a pretty user
friendly message on the screen when a Linux kernel panic occurs.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Tested on an AM625 BeaglePlay board by triggering a panic using the
`echo c > /proc/sysrq-trigger` command.

 drivers/gpu/drm/tidss/tidss_plane.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 68fed531f6a7..a5d86822c9e3 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -166,6 +167,14 @@ static const struct drm_plane_helper_funcs tidss_plane_helper_funcs = {
 	.atomic_disable = tidss_plane_atomic_disable,
 };
 
+static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
+	.atomic_check = tidss_plane_atomic_check,
+	.atomic_update = tidss_plane_atomic_update,
+	.atomic_enable = tidss_plane_atomic_enable,
+	.atomic_disable = tidss_plane_atomic_disable,
+	.get_scanout_buffer = drm_fb_dma_get_scanout_buffer,
+};
+
 static const struct drm_plane_funcs tidss_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -211,7 +220,10 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 	if (ret < 0)
 		goto err;
 
-	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		drm_plane_helper_add(&tplane->plane, &tidss_primary_plane_helper_funcs);
+	else
+		drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
 	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
-- 
2.45.1


