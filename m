Return-Path: <linux-kernel+bounces-227470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA49151B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF11F21A01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6319B59D;
	Mon, 24 Jun 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGvARhMW"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847B19B3E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241979; cv=none; b=MS+6aAzOLi8ugPF23MuF9kJ1iT6li5wzOE66ftfhKA3TW6SQBl0IvqvoL5ANrq/Xu/Oy/xQP+LeW1psc5TNioUSG2NMdC90WDaSL4ujwTPNuFpAN8WsHhFw0wtfTFstwr8/Rd2M1H8XOZ53CUKwXTEV3aEZEFyvZxXNzYR67/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241979; c=relaxed/simple;
	bh=5Ik5Ldm2VEiywGG52hUFELe12Ts18tFZ1LPfaZaSWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUiQdQPXAA+4K7Fw3SUSe4Uel10Fotpd4FiFrhXe7CsszrQ7XwaLe5Of5AggzFUh+jli/CYtPZlN19npJ7+9puhJrBbujNYzUHawzo1tED0NIgLDFxgInWmz8lKpWPzLvG7XjabfhojFzoaVoINNG3NyiG6L9cG774z0gqgVr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGvARhMW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b05c9db85fso17483146d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241977; x=1719846777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLmHj2pUu5XP8F0s810g8Xhldx4Sthnl+H5OURakYZM=;
        b=eGvARhMWHt9AEpd5U/c4L9sgG+AKRPAnkrmDqRNLgqXKIvp0Fw9OOQNs1sP9ZRvGfY
         yrj1rT27eaJ3FTKd2cBdSL7AfajEL3Pwe6ocx8Ma1meyBmiZT1CU8ioIE7i6fexJAm2j
         uTkfITKbgJHeeE3SDb2EZ5hDk5hrwdLaxlqHKWfYzD3TK7VFf3UIYkNVlGQl1F/8Z0RF
         eXVas6ZK2WwBi6rnA3dqoH/BxH2JrVe3UhagswK/TbdFjuZP1jFFs62IpunGDm+kGwpZ
         20MO9TeDb2bb0pT7uSs6ME/yyTtj5znVzE/r6a6c4n0coYOdwpxy3lsgTD/KYMKo2Mbc
         yx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241977; x=1719846777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLmHj2pUu5XP8F0s810g8Xhldx4Sthnl+H5OURakYZM=;
        b=l5ypjyaM7WElbq5S5TwbJ+039Ic/xpJamEKcc9pcmRKQZn6KJRLiXl8TBw1lD2MOfd
         Y2FBLF7oHJCojDBhWejUdCqEYw7NEl+dBOHPIrme/ohaP9SFWzmWcsv3dXyhEFyy4pjR
         mTRb8DRTf2uOXKbFTCLrNZ4EBjn/cNHoBXHgVxWuA9izUnE5+c/6y9t5ytbwYXc621EA
         OzersVZjX98C9+uUk/EIvMTJOO8rFjaJ5H+6IZZ/xc64AA/AJ+1JS6YR4ErxkXawNGKs
         aWwOkWJ5ZvFGiqd/BGfv99+Of/kR4xVaijSb7cIs6AEsrXNp2skgvEVwOv9ThcvuBkJJ
         RwvA==
X-Forwarded-Encrypted: i=1; AJvYcCUagEgd+5YSF0D2uKzRmXOYLoY/YuxKh0Xdzp9DEtubalt+iCjEMLmr4lRST5YndGljEz9VHkQBoKYPoGlVjS7ch3arbzupG499gzBT
X-Gm-Message-State: AOJu0YwsNw5Wn7du77+QjGpY0qHtxvLnW3f9JMWtrK7p72PWZhZBxb9Z
	dEO8ZSl1BvzH6LqL5SjY3e1ZFVW5tKa/jkUAg/A9PP/hNcrZ8uVt
X-Google-Smtp-Source: AGHT+IFUfBd/+3kNGqHk10Aqjryw//X8bb+Dpk6x3wTmMH4jNZ1dE5lkgBKeoVI4kYI4H8zisQYpbw==
X-Received: by 2002:a05:6214:e89:b0:6b4:fe1a:eeee with SMTP id 6a1803df08f44-6b540a96127mr64169856d6.46.1719241977035;
        Mon, 24 Jun 2024 08:12:57 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:12:56 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 2
Date: Mon, 24 Jun 2024 11:10:47 -0400
Message-ID: <20240624151122.23724-4-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624151122.23724-1-wuhoipok@gmail.com>
References: <20240624151122.23724-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please refer to patch 1.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/r300.c     |  6 +++---
 drivers/gpu/drm/radeon/r420.c     |  6 +++---
 drivers/gpu/drm/radeon/r520.c     |  2 +-
 drivers/gpu/drm/radeon/r600.c     | 12 ++++++------
 drivers/gpu/drm/radeon/r600_cs.c  |  2 +-
 drivers/gpu/drm/radeon/r600_dpm.c |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 1620f534f55f..05c13102a8cb 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -616,7 +616,7 @@ DEFINE_SHOW_ATTRIBUTE(rv370_debugfs_pcie_gart_info);
 static void rv370_debugfs_pcie_gart_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("rv370_pcie_gart_info", 0444, root, rdev,
 			    &rv370_debugfs_pcie_gart_info_fops);
@@ -1452,7 +1452,7 @@ int r300_resume(struct radeon_device *rdev)
 			RREG32(R_0007C0_CP_STAT));
 	}
 	/* post */
-	radeon_combios_asic_init(rdev->ddev);
+	radeon_combios_asic_init(rdev_to_drm(rdev));
 	/* Resume clock after posting */
 	r300_clock_startup(rdev);
 	/* Initialize surface registers */
@@ -1538,7 +1538,7 @@ int r300_init(struct radeon_device *rdev)
 	/* Set asic errata */
 	r300_errata(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.c
index a979662eaa73..9a31cdec6415 100644
--- a/drivers/gpu/drm/radeon/r420.c
+++ b/drivers/gpu/drm/radeon/r420.c
@@ -322,7 +322,7 @@ int r420_resume(struct radeon_device *rdev)
 	if (rdev->is_atom_bios) {
 		atom_asic_init(rdev->mode_info.atom_context);
 	} else {
-		radeon_combios_asic_init(rdev->ddev);
+		radeon_combios_asic_init(rdev_to_drm(rdev));
 	}
 	/* Resume clock after posting */
 	r420_clock_resume(rdev);
@@ -414,7 +414,7 @@ int r420_init(struct radeon_device *rdev)
 		return -EINVAL;
 
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
@@ -493,7 +493,7 @@ DEFINE_SHOW_ATTRIBUTE(r420_debugfs_pipes_info);
 void r420_debugfs_pipes_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r420_pipes_info", 0444, root, rdev,
 			    &r420_debugfs_pipes_info_fops);
diff --git a/drivers/gpu/drm/radeon/r520.c b/drivers/gpu/drm/radeon/r520.c
index 6cbcaa845192..08e127b3249a 100644
--- a/drivers/gpu/drm/radeon/r520.c
+++ b/drivers/gpu/drm/radeon/r520.c
@@ -287,7 +287,7 @@ int r520_init(struct radeon_device *rdev)
 		atom_asic_init(rdev->mode_info.atom_context);
 	}
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 087d41e370fd..8b62f7faa5b9 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -950,7 +950,7 @@ void r600_hpd_set_polarity(struct radeon_device *rdev,
 
 void r600_hpd_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned enable = 0;
 
@@ -1017,7 +1017,7 @@ void r600_hpd_init(struct radeon_device *rdev)
 
 void r600_hpd_fini(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned disable = 0;
 
@@ -3280,7 +3280,7 @@ int r600_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
 	if (rdev->flags & RADEON_IS_AGP) {
@@ -4136,7 +4136,7 @@ int r600_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: D1 vblank - IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[0]) {
-					drm_handle_vblank(rdev->ddev, 0);
+					drm_handle_vblank(rdev_to_drm(rdev), 0);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -4166,7 +4166,7 @@ int r600_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: D2 vblank - IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[1]) {
-					drm_handle_vblank(rdev->ddev, 1);
+					drm_handle_vblank(rdev_to_drm(rdev), 1);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -4358,7 +4358,7 @@ DEFINE_SHOW_ATTRIBUTE(r600_debugfs_mc_info);
 static void r600_debugfs_mc_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r600_mc_info", 0444, root, rdev,
 			    &r600_debugfs_mc_info_fops);
diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 6cf54a747749..1b2d31c4d77c 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -884,7 +884,7 @@ int r600_cs_common_vline_parse(struct radeon_cs_parser *p,
 	crtc_id = radeon_get_ib_value(p, h_idx + 2 + 7 + 1);
 	reg = R600_CP_PACKET0_GET_REG(header);
 
-	crtc = drm_crtc_find(p->rdev->ddev, p->filp, crtc_id);
+	crtc = drm_crtc_find(rdev_to_drm(p->rdev), p->filp, crtc_id);
 	if (!crtc) {
 		DRM_ERROR("cannot find crtc %d\n", crtc_id);
 		return -ENOENT;
diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r600_dpm.c
index 64980a61d38a..81d58ef667dd 100644
--- a/drivers/gpu/drm/radeon/r600_dpm.c
+++ b/drivers/gpu/drm/radeon/r600_dpm.c
@@ -153,7 +153,7 @@ void r600_dpm_print_ps_status(struct radeon_device *rdev,
 
 u32 r600_dpm_get_vblank_time(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 vblank_in_pixels;
@@ -180,7 +180,7 @@ u32 r600_dpm_get_vblank_time(struct radeon_device *rdev)
 
 u32 r600_dpm_get_vrefresh(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 vrefresh = 0;
-- 
2.45.2


