Return-Path: <linux-kernel+bounces-224844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D491278B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5ED28BB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED9383A2;
	Fri, 21 Jun 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOaPYgKY"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E42C1AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979677; cv=none; b=Ft6e+DkVP4zp7BoYAYSXTk954QgUcYmNe+dIbX2bdnfpzfIBXuZQEJCvxzPVEkfseXZr/YTBDZdvBPAKl68SxJffg8t+SA8/Tw+3dQRyGEw30NlbBoDgd47SZXlr544avDLt+Cyp8rv1gW9K92RbOo8sRdMjMxAUi63J7Y7MNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979677; c=relaxed/simple;
	bh=6BHMiMoKVlkooZFbv08vvmarKLf4j1ryhKjpdh7OWlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXZsmxq1R9VfjXqgfYpbCkBWWgUskkbGJu2FIk65WwiSoFbYdqYTNlt9cUBQwvvkyz44FkaPOLCzkBl7bmJNUx7aWbPuXof2Zql5s/TiXGzBlq29fdNfdK7wEbEpwJIaz7CPUFEeq2RYBKRIte2lwJqkVPesG+t+JhUxwfl0Otc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOaPYgKY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b4fc2b5277so8244136d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718979675; x=1719584475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjXMle0rO8XpaOjdtO6Igck9jzTHjsyq0tjq0iKq+6k=;
        b=MOaPYgKYFc+cdxDRiQLsuoRSK0NRXa5G+lX0C9sZZHOMTTjL3US+5ZIUN471AM7jR0
         /Fr4FAkDdwP5eQRJO/8xhCFw0aRFVVgMGCfJ/dLVWg6pEVUpk7cdKC7NNLFnFjwg8zSR
         fowNkbJIeHK0zq+aGCxPJfMlvPyZbDXv+lMK5NSQ0my9tRxyCO0ihh2X6T9NiiN8AsCP
         SvctC0a/BxTmjbdZXFn/aEW+4a46kJvM+QFnCmSg6MerCHhPuhV9K6pzMZLIDOyW4fDQ
         U7SigSG/pYiY1HkoZtEPpDpoKJGQwBrrtLEtJ90URcJYYNyl4xoXccU//BqJpEgb3H4j
         K7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979675; x=1719584475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjXMle0rO8XpaOjdtO6Igck9jzTHjsyq0tjq0iKq+6k=;
        b=Pc3xEcDFF7WEhrIIXCZK+bW+UFuXiIvy1tDiTgkFs+x3UIB9MJ9Vq06GWMeZaVWgct
         JxWxUjd111tTUV8U/9tf4Ri3tiYk1KlU0r+pfuOsGgHbMpgtzFYLM/pcxZ+tVfHHvWLz
         vj5czporXrl0Ji55yAwOFwGKv5Wyrz10nKhWg03PotD2US7M5/OILi2xIGBNtYmHmSui
         btaRIRFHQyVA5RNIhNyEJ3FUe7U7sPx+AENUheW5jnyY56fngE/XO+W1zVLX6BGXFSKl
         2EBZ3at50i/J0zOq4BqnrljKjm5x8eWhj1OHO2rf7e3MNz+r0yVi8SEVw8SdR3+clmH+
         HGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNPw6EiFuTp1/mzze8GxBbJf3B9bYLldwr8JnL0BmTJEVJRkDGYpBxwdYVaCZ0da0iz3wpUwwLod7r3zsLrhblKbpnxBCi1p1xntpl
X-Gm-Message-State: AOJu0YzGPIDq+cSmg8qStHWYnJR9ObKPMKsXBa0gdT7ltqD2CTZnDhIP
	0A0IyO/5l+HgR+fSxV7o52urT34sgcb4CkWMxbulQPxCRmTQOdma
X-Google-Smtp-Source: AGHT+IHTsm5qtIMJT3X14t/FfwytBP6BI2xShJWE3XRYqnh+pQytGVZUlvy0RxH7ZCq8cqLXQDvjJw==
X-Received: by 2002:ad4:5cc2:0:b0:6b2:a333:2abf with SMTP id 6a1803df08f44-6b50d8e18d8mr83165976d6.51.1718979675153;
        Fri, 21 Jun 2024 07:21:15 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef312b3sm9164736d6.88.2024.06.21.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:21:14 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 6
Date: Fri, 21 Jun 2024 10:20:49 -0400
Message-ID: <20240621142052.20152-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please see Patch v2 1/7 for details.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/rs400.c |  6 +++---
 drivers/gpu/drm/radeon/rs600.c | 14 +++++++-------
 drivers/gpu/drm/radeon/rs690.c |  2 +-
 drivers/gpu/drm/radeon/rv515.c |  4 ++--
 drivers/gpu/drm/radeon/rv770.c |  2 +-
 drivers/gpu/drm/radeon/si.c    |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index d4d1501e6576..d6c18fd740ec 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -379,7 +379,7 @@ DEFINE_SHOW_ATTRIBUTE(rs400_debugfs_gart_info);
 static void rs400_debugfs_pcie_gart_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rs400_gart_info", 0444, root, rdev,
 			    &rs400_debugfs_gart_info_fops);
@@ -474,7 +474,7 @@ int rs400_resume(struct radeon_device *rdev)
 			RREG32(R_0007C0_CP_STAT));
 	}
 	/* post */
-	radeon_combios_asic_init(rdev->ddev);
+	radeon_combios_asic_init(rdev_to_drm(rdev));
 	/* Resume clock after posting */
 	r300_clock_startup(rdev);
 	/* Initialize surface registers */
@@ -552,7 +552,7 @@ int rs400_init(struct radeon_device *rdev)
 		return -EINVAL;
 
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize memory controller */
 	rs400_mc_init(rdev);
 	/* Fence driver */
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 5c162778899b..88c8e91ea651 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -321,7 +321,7 @@ void rs600_pm_misc(struct radeon_device *rdev)
 
 void rs600_pm_prepare(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -339,7 +339,7 @@ void rs600_pm_prepare(struct radeon_device *rdev)
 
 void rs600_pm_finish(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -408,7 +408,7 @@ void rs600_hpd_set_polarity(struct radeon_device *rdev,
 
 void rs600_hpd_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned enable = 0;
 
@@ -435,7 +435,7 @@ void rs600_hpd_init(struct radeon_device *rdev)
 
 void rs600_hpd_fini(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned disable = 0;
 
@@ -797,7 +797,7 @@ int rs600_irq_process(struct radeon_device *rdev)
 		/* Vertical blank interrupts */
 		if (G_007EDC_LB_D1_VBLANK_INTERRUPT(rdev->irq.stat_regs.r500.disp_int)) {
 			if (rdev->irq.crtc_vblank_int[0]) {
-				drm_handle_vblank(rdev->ddev, 0);
+				drm_handle_vblank(rdev_to_drm(rdev), 0);
 				rdev->pm.vblank_sync = true;
 				wake_up(&rdev->irq.vblank_queue);
 			}
@@ -806,7 +806,7 @@ int rs600_irq_process(struct radeon_device *rdev)
 		}
 		if (G_007EDC_LB_D2_VBLANK_INTERRUPT(rdev->irq.stat_regs.r500.disp_int)) {
 			if (rdev->irq.crtc_vblank_int[1]) {
-				drm_handle_vblank(rdev->ddev, 1);
+				drm_handle_vblank(rdev_to_drm(rdev), 1);
 				rdev->pm.vblank_sync = true;
 				wake_up(&rdev->irq.vblank_queue);
 			}
@@ -1133,7 +1133,7 @@ int rs600_init(struct radeon_device *rdev)
 		return -EINVAL;
 
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize memory controller */
 	rs600_mc_init(rdev);
 	r100_debugfs_rbbm_init(rdev);
diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
index 14fb0819b8c1..016eb4992803 100644
--- a/drivers/gpu/drm/radeon/rs690.c
+++ b/drivers/gpu/drm/radeon/rs690.c
@@ -845,7 +845,7 @@ int rs690_init(struct radeon_device *rdev)
 		return -EINVAL;
 
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize memory controller */
 	rs690_mc_init(rdev);
 	rv515_debugfs(rdev);
diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv515.c
index bbc6ccabf788..1b4dfb645585 100644
--- a/drivers/gpu/drm/radeon/rv515.c
+++ b/drivers/gpu/drm/radeon/rv515.c
@@ -255,7 +255,7 @@ DEFINE_SHOW_ATTRIBUTE(rv515_debugfs_ga_info);
 void rv515_debugfs(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rv515_pipes_info", 0444, root, rdev,
 			    &rv515_debugfs_pipes_info_fops);
@@ -636,7 +636,7 @@ int rv515_init(struct radeon_device *rdev)
 	if (radeon_boot_test_post_card(rdev) == false)
 		return -EINVAL;
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 9ce12fa3c356..7d4b0bf59109 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -1935,7 +1935,7 @@ int rv770_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
 	/* initialize AGP */
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 15759c8ca5b7..6c95575ce109 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6277,7 +6277,7 @@ int si_irq_process(struct radeon_device *rdev)
 				event_name = "vblank";
 
 				if (rdev->irq.crtc_vblank_int[crtc_idx]) {
-					drm_handle_vblank(rdev->ddev, crtc_idx);
+					drm_handle_vblank(rdev_to_drm(rdev), crtc_idx);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -6839,7 +6839,7 @@ int si_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
-- 
2.45.2


