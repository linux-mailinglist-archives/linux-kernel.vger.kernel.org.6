Return-Path: <linux-kernel+bounces-224835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94B912766
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80DA2884A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DE1D55D;
	Fri, 21 Jun 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUlkHe9e"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499631C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979518; cv=none; b=L1j4jWFra7rTBl7UC5PDuTL0MV/SAO9xPTRwfMrTjXB7FET6a3/TYJtcp07evjUmLvVO65brs+hPn4CjPof7SB8tjeVv94sJMh8u6nv+lwzNGyoq1MAMeTsLD2cxejWQR4jFeqJvWjgT8Z7H9pwRaUl+AgvDksZRqCNYympk6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979518; c=relaxed/simple;
	bh=UHbPsxSUPCcvat6x6uNlUR19md2kOXItdY0264QL1UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUgnP9/OPhRftSx4eqT3QjVOXpaFwhL8xBRsmcUdDUBcU+Q9lHpHO0ensFntd420WqjYlHl/lC5lRgF07OLrVDsXShBxLy+6fxrkHzWwBaFW7W+3+WQKKUerCh5JCVK5o1bWbVH++WdMkJtj2wYcYlx2wf9ZHJ3LSiusVmwkY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUlkHe9e; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5052defa6so10263866d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718979516; x=1719584316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQFKOyIb/X2A62XAtBgt1V7e2XMdzNyMO4HKZbrKe/w=;
        b=MUlkHe9ekRBU92eMh2YsBlJyN4RQex+R0SOAQiSTsO6j08ItOIJpZb2+2dlMKjw7yc
         qWRtN8Z9Xo7JRNUa/OVvtfmIi13uP6wLGYL+sYjeBQao1XNAPcXkfY3E1qzEPuDp905T
         uGyh2A7JCeLt/y7ChufKKkVi+btHV8BVc94nKNpLqj5ShbV9AQZ1aoGJ7bZt99ykWIxh
         fXLSmJVRAzncGolDlsAbdkf/S2fJEZYtaDL2s9U/iqn8ZP/HjaCrdOQu9zmOwCSaBqEe
         sj0dh4nisjH3IN10RQX78OFCn6XUSzn7aKR73aO3g+l3x/oQRBBG8HbnKQdx0izPQVx0
         gvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979516; x=1719584316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQFKOyIb/X2A62XAtBgt1V7e2XMdzNyMO4HKZbrKe/w=;
        b=Im93r8tLDsF+aSnxzTtGHKU8H5n/hEm87NE9xAZdsp5WNJJjYJ1bwOt/W3xgVtQR5M
         H5ZMN/qe2dMciEEUd+A863ODkODmOO+A2W4M/FDB3Vo1SDDYqoUZEUoV7xs7kJuW/N3B
         EZL2GIeSAg0HWxP+iEQX9sGd+NXCVm2+qgSkzklKmEheG47G5EgXGt6+t2c24LS5POJE
         Oc/sDWM7YcksPeLe7kpHYQUu8xen6urDKO+zZxUHUVlcol3AqQSsgook0zOXaI9ufJE0
         fRtWBFlYSO9Pq1JakSVCMTOx8rxmzQd8gAKe9W/cNogYF44dSfvVTNiTPqblZyE2OWLf
         vl6w==
X-Forwarded-Encrypted: i=1; AJvYcCW+r2x/O1/uZdXonOeHzAYcsIIQl0yHTPjsXW6kl+txF/VoICAw70HTAG75CPqWNusWSsaUjKB1iVmTpInJbsp3SYKnvAvvx9L8Ipwy
X-Gm-Message-State: AOJu0Yx9EqzhMIEjzYmL2GsAjb8n2jk1GlyAZ/lb8syNw2BIDGv3MPSO
	yb/H4GY15jnBCWeh2CWFPpAJZ1jg8+HrX4wq6qVuis1MEtsqDXrVe55vUoGB
X-Google-Smtp-Source: AGHT+IHZnnPlI9o4pC/Z8FM/FcaBV7b+8mx98jpca2U98Rn+X9TW18nxm5KfxBo9jqScZ5kYTcZQSw==
X-Received: by 2002:a0c:ed50:0:b0:6b5:2763:5f7c with SMTP id 6a1803df08f44-6b52763600amr9743036d6.63.1718979515982;
        Fri, 21 Jun 2024 07:18:35 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef67021sm9143186d6.128.2024.06.21.07.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:18:35 -0700 (PDT)
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
Subject: [PATCH v2 3/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 2
Date: Fri, 21 Jun 2024 10:18:08 -0400
Message-ID: <20240621141810.19964-1-wuhoipok@gmail.com>
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


