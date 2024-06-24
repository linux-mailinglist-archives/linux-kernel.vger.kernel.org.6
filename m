Return-Path: <linux-kernel+bounces-227469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0E9151B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF921F23E91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3919D06A;
	Mon, 24 Jun 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn+KDODd"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E919D09F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241970; cv=none; b=FHAB2I5/PsfVFY/kcFyzrTxu2YLyuA8r8Jg/fUwPA2+JyGRNvzHT94n6vwfHc1Z830LjkftxkaPsAr9qCM1atN7rInfvHFGjsfHX8OuuHPMXfeC8Ghq/dPljX1P395T1m9k1Cyn7s8NGv5yPL6uVe52no2GoSfbO3m2ld3FtPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241970; c=relaxed/simple;
	bh=rQ255jo/0R2Fgl2xJezPDOxpdyhC25KATHsXN3lzip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7ebSlibMEhiX+kR1ky78c7JekXclb/HB3oZ5IAgbeIODNYcyoARBsppXRcOzznzK8tGCD9eoBIq5IiGZu22Ag0FxOwhAmrXsXa+lPSNPOy45/KgdwaUHGAkdKH/JboPoXkG++PY3z17T8K4O32bItsh9fixXW/1ZQMhMHGmquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn+KDODd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7960454db4fso318007785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241967; x=1719846767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRx/eEU8NJWLVz1z5MnvNgmh5VYj9CW+G0+gtbI+FdU=;
        b=Gn+KDODdWFA449FcomAwpkpm6f910pEYmruV1iD8kAkccjY1h1BzmJv/l9w79d69wW
         KvdrNYPTRpgn40SxD0Vz3S5tQtttB9pn6qgDJ2jgIVKLT0bGTIuOso43oARTYOW61h2C
         r9rSwOIeSRZVpb0vgUVXXYDK955Je8OoCqbXvkGKwC4rXDQ2oSXHcgJDqvLi9TGJ4ws5
         3AQOzSoxSNX9hmvpReY+YvGEJenWAwyPDjXKyWbc+dqeFLe0uSotBHL5Ps8fvf+IzH0P
         3OP1JcVnHVJ6m9TTkhnHyQXVTo669idTzSd/S5XOAmpWBSfffqwJpym/8JqNpfpilJ7o
         rJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241967; x=1719846767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRx/eEU8NJWLVz1z5MnvNgmh5VYj9CW+G0+gtbI+FdU=;
        b=bOXSwlw38KNcHm9I9Rki79e+SI/3s1J4VNxBJGucL9I56sRvLiftqdpXMj3tfjBkhS
         92gwaanP/NXRygQeYCsIlfWOoVQtha1wCbbQRr4vvzssBNw2qgmGI2l6nAJasogBXC/n
         GnLHoo8KDtLG/78ADnhWVZ6UsMMzLYhtOTsUYZ1Xmuj37P0Zm7cw1bdTywfouKo6Nb3z
         0guGBc+Uq/wZ/mL8cWocGkxQNRIQ44ddQ0Fc1xPbvK9GIs9sXYbk3uMt6eAtSRg3Ceds
         jv1YHLn87E8JrOwokNJtDFYbaFlgftrizKOnm5cdxZ3qv1PZc0p0gs6y5ys5pp4puk4h
         jXfg==
X-Forwarded-Encrypted: i=1; AJvYcCXHBOPY67k8dxBsV9pLbqMYoQiByqMJo77YqwKVxT0Q8TnKvJJoovu4YmwKNyRLIrCPe3myf1hABRhu15Fzh2z1ubpPjFNPtAS3hStF
X-Gm-Message-State: AOJu0Yy1OsN1jFrb4IL6eFO15Y0ahnnbjV2io0PsbgWnVWtvAVhDp0K7
	uq8NAHvqVZhrPdX02l4IzCNF0nVnnDDGjUf7ctGHjEAuSXR1EQPv
X-Google-Smtp-Source: AGHT+IGJbCvsCnoKaU58U8z9Z8j/l7ioDzlcso5e8SqAsL6lBwZWy4cbsRw4dddwwJbTVLqWmgqNfA==
X-Received: by 2002:a0c:f584:0:b0:6b0:930a:8d4b with SMTP id 6a1803df08f44-6b53653ade1mr67415296d6.55.1719241967068;
        Mon, 24 Jun 2024 08:12:47 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:12:46 -0700 (PDT)
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
Subject: [PATCH v3 2/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 1
Date: Mon, 24 Jun 2024 11:10:46 -0400
Message-ID: <20240624151122.23724-3-wuhoipok@gmail.com>
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
 drivers/gpu/drm/radeon/atombios_encoders.c |  2 +-
 drivers/gpu/drm/radeon/cik.c               | 14 ++++++-------
 drivers/gpu/drm/radeon/dce6_afmt.c         |  2 +-
 drivers/gpu/drm/radeon/evergreen.c         | 12 +++++------
 drivers/gpu/drm/radeon/ni.c                |  2 +-
 drivers/gpu/drm/radeon/r100.c              | 24 +++++++++++-----------
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 03e6871b3065..c82e0fbc49b4 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -2179,7 +2179,7 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 void
 radeon_atom_encoder_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_encoder *encoder;
 
 	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index b5e96a8fc2c1..11a492f21157 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -7585,7 +7585,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[0]) {
-					drm_handle_vblank(rdev->ddev, 0);
+					drm_handle_vblank(rdev_to_drm(rdev), 0);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -7615,7 +7615,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[1]) {
-					drm_handle_vblank(rdev->ddev, 1);
+					drm_handle_vblank(rdev_to_drm(rdev), 1);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -7645,7 +7645,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[2]) {
-					drm_handle_vblank(rdev->ddev, 2);
+					drm_handle_vblank(rdev_to_drm(rdev), 2);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -7675,7 +7675,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[3]) {
-					drm_handle_vblank(rdev->ddev, 3);
+					drm_handle_vblank(rdev_to_drm(rdev), 3);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -7705,7 +7705,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[4]) {
-					drm_handle_vblank(rdev->ddev, 4);
+					drm_handle_vblank(rdev_to_drm(rdev), 4);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -7735,7 +7735,7 @@ int cik_irq_process(struct radeon_device *rdev)
 					DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
 				if (rdev->irq.crtc_vblank_int[5]) {
-					drm_handle_vblank(rdev->ddev, 5);
+					drm_handle_vblank(rdev_to_drm(rdev), 5);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -8581,7 +8581,7 @@ int cik_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
diff --git a/drivers/gpu/drm/radeon/dce6_afmt.c b/drivers/gpu/drm/radeon/dce6_afmt.c
index 4c06f47453fd..d6ab93ed9ec4 100644
--- a/drivers/gpu/drm/radeon/dce6_afmt.c
+++ b/drivers/gpu/drm/radeon/dce6_afmt.c
@@ -91,7 +91,7 @@ struct r600_audio_pin *dce6_audio_get_pin(struct radeon_device *rdev)
 			pin = &rdev->audio.pin[i];
 			pin_count = 0;
 
-			list_for_each_entry(encoder, &rdev->ddev->mode_config.encoder_list, head) {
+			list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.encoder_list, head) {
 				if (radeon_encoder_is_digital(encoder)) {
 					radeon_encoder = to_radeon_encoder(encoder);
 					dig = radeon_encoder->enc_priv;
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index c634dc28e6c3..bc4ab71613a5 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -1673,7 +1673,7 @@ void evergreen_pm_misc(struct radeon_device *rdev)
  */
 void evergreen_pm_prepare(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -1698,7 +1698,7 @@ void evergreen_pm_prepare(struct radeon_device *rdev)
  */
 void evergreen_pm_finish(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -1763,7 +1763,7 @@ void evergreen_hpd_set_polarity(struct radeon_device *rdev,
  */
 void evergreen_hpd_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned enabled = 0;
 	u32 tmp = DC_HPDx_CONNECTION_TIMER(0x9c4) |
@@ -1804,7 +1804,7 @@ void evergreen_hpd_init(struct radeon_device *rdev)
  */
 void evergreen_hpd_fini(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned disabled = 0;
 
@@ -4753,7 +4753,7 @@ int evergreen_irq_process(struct radeon_device *rdev)
 				event_name = "vblank";
 
 				if (rdev->irq.crtc_vblank_int[crtc_idx]) {
-					drm_handle_vblank(rdev->ddev, crtc_idx);
+					drm_handle_vblank(rdev_to_drm(rdev), crtc_idx);
 					rdev->pm.vblank_sync = true;
 					wake_up(&rdev->irq.vblank_queue);
 				}
@@ -5211,7 +5211,7 @@ int evergreen_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
 	/* initialize AGP */
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 77aee99e473a..3890911fe693 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -2360,7 +2360,7 @@ int cayman_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* Fence driver */
 	radeon_fence_driver_init(rdev);
 	/* initialize memory controller */
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 0b1e19345f43..d7d7d23bf9a1 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -459,7 +459,7 @@ void r100_pm_misc(struct radeon_device *rdev)
  */
 void r100_pm_prepare(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -490,7 +490,7 @@ void r100_pm_prepare(struct radeon_device *rdev)
  */
 void r100_pm_finish(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	u32 tmp;
@@ -603,7 +603,7 @@ void r100_hpd_set_polarity(struct radeon_device *rdev,
  */
 void r100_hpd_init(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned enable = 0;
 
@@ -626,7 +626,7 @@ void r100_hpd_init(struct radeon_device *rdev)
  */
 void r100_hpd_fini(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_connector *connector;
 	unsigned disable = 0;
 
@@ -798,7 +798,7 @@ int r100_irq_process(struct radeon_device *rdev)
 		/* Vertical blank interrupts */
 		if (status & RADEON_CRTC_VBLANK_STAT) {
 			if (rdev->irq.crtc_vblank_int[0]) {
-				drm_handle_vblank(rdev->ddev, 0);
+				drm_handle_vblank(rdev_to_drm(rdev), 0);
 				rdev->pm.vblank_sync = true;
 				wake_up(&rdev->irq.vblank_queue);
 			}
@@ -807,7 +807,7 @@ int r100_irq_process(struct radeon_device *rdev)
 		}
 		if (status & RADEON_CRTC2_VBLANK_STAT) {
 			if (rdev->irq.crtc_vblank_int[1]) {
-				drm_handle_vblank(rdev->ddev, 1);
+				drm_handle_vblank(rdev_to_drm(rdev), 1);
 				rdev->pm.vblank_sync = true;
 				wake_up(&rdev->irq.vblank_queue);
 			}
@@ -1471,7 +1471,7 @@ int r100_cs_packet_parse_vline(struct radeon_cs_parser *p)
 	header = radeon_get_ib_value(p, h_idx);
 	crtc_id = radeon_get_ib_value(p, h_idx + 5);
 	reg = R100_CP_PACKET0_GET_REG(header);
-	crtc = drm_crtc_find(p->rdev->ddev, p->filp, crtc_id);
+	crtc = drm_crtc_find(rdev_to_drm(p->rdev), p->filp, crtc_id);
 	if (!crtc) {
 		DRM_ERROR("cannot find crtc %d\n", crtc_id);
 		return -ENOENT;
@@ -3059,7 +3059,7 @@ DEFINE_SHOW_ATTRIBUTE(r100_debugfs_mc_info);
 void  r100_debugfs_rbbm_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_rbbm_info", 0444, root, rdev,
 			    &r100_debugfs_rbbm_info_fops);
@@ -3069,7 +3069,7 @@ void  r100_debugfs_rbbm_init(struct radeon_device *rdev)
 void r100_debugfs_cp_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_cp_ring_info", 0444, root, rdev,
 			    &r100_debugfs_cp_ring_info_fops);
@@ -3081,7 +3081,7 @@ void r100_debugfs_cp_init(struct radeon_device *rdev)
 void  r100_debugfs_mc_info_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("r100_mc_info", 0444, root, rdev,
 			    &r100_debugfs_mc_info_fops);
@@ -3947,7 +3947,7 @@ int r100_resume(struct radeon_device *rdev)
 			RREG32(R_0007C0_CP_STAT));
 	}
 	/* post */
-	radeon_combios_asic_init(rdev->ddev);
+	radeon_combios_asic_init(rdev_to_drm(rdev));
 	/* Resume clock after posting */
 	r100_clock_startup(rdev);
 	/* Initialize surface registers */
@@ -4056,7 +4056,7 @@ int r100_init(struct radeon_device *rdev)
 	/* Set asic errata */
 	r100_errata(rdev);
 	/* Initialize clocks */
-	radeon_get_clock_info(rdev->ddev);
+	radeon_get_clock_info(rdev_to_drm(rdev));
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
-- 
2.45.2


