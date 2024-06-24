Return-Path: <linux-kernel+bounces-227475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DD9151C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0DC1F2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3419DFA1;
	Mon, 24 Jun 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtjHui11"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B719B59A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242000; cv=none; b=tqMp+Ym0eDPqm4WzSiOFWx8+BI40GloC90iC8EtHK/aKcQq2/uuTxjWHSnw6lUdhaJ+I5YojEst/fhot2oZCRAZ1YJDyuGrslaYFJsjIQuwHO1jH+3aXe8H1x3+OKv5TiJ7LB8f5zdK/mmKK1gH6nTcsAiRpUXoL2Aie9Tcv3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242000; c=relaxed/simple;
	bh=qfXs+kkhAooij6bggnb4t89DDknkHMh3vckE9AGippM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqNy0zvDdz0TUs0OHV9xrfTD7ILk2YskS1XR2/MmTr9tsec68bV42yHi+WFSTfvcav288hug1XvvMhfJb86znvuNn/djfIHMwOLdM6mKL3bYGMs5wpMckAFxdXFhvrfDQPM8WTcrbX4jG2cfGTwn0XIaBhUaRk54RVRKyRTuqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtjHui11; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-795482e114cso401274485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241998; x=1719846798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etIk1t7xwF8U2fX330UeuA5bc53bbuVw/GGdUgl3Jaw=;
        b=dtjHui11HYSzkqPZZAftZsWUj+KEys3Jua9C5EebbzrF2cMsk65iFOFr62n+Z3Hcnn
         RTfGAL7hRvuTKR7Ns63CwCsy1zWKxZe5p7v30koI+uXjbPtzYV/mnQ08u/pgqBRcxfes
         HGQrUg/J18nFbK7/9KpqtGozae9JXWHv06vRQ6FX2h/9MZnBvLgqJtLhXouunpkS+ON6
         YsZwJWHcfgMIaR2yCpQY1zzoPaSlwefmajSjSx9/lcyVGiUPDEhxpKWnZI4HAp7/O2vK
         GFcqwxQ5dlDpSoxmNRpxrgXQD/msQUB9TmibRWfkmGLNLp3D1sGzmrlONXoOn6obiFbQ
         eGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241998; x=1719846798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etIk1t7xwF8U2fX330UeuA5bc53bbuVw/GGdUgl3Jaw=;
        b=aU0inpknIX6hJm0qqNX1j6mXhj9eO3m5CRPTM7RLSjJWL53nikPVKKnlGg78rBE2cK
         X+DkI3OpOIeVyqC4Ay3IW1SqyMvAw6RCLTx0l2vVMu8lDxhTDNeRrJth4j+SHswZVIYt
         DABHZe2pNyKrkf9GWRSvGeqSqNUeKdmmd9dg+9rnEUCBMbBTwqXjQLSdcuTHo6CIuJSA
         oyWXqPetAhmNCtE/Mv+l+c3U/wRHDyp0ro1n1fXvxTa3nwHI9n+jJ2+yQOKIoogn+1Rp
         qtxEvQvucs6u/prq8DR0oTezSdyz1hui5GcTLmuf4Y0ESKWJdJgakZBGvVMlmbAGDnRo
         VrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8rLV/KFVI0XIPFO973BMRb460NBf8wiMqLEeO8nbKIdXYiareGR4Slkl/o0Gdlny4X1AoCntC+Nd8buJENQDA+6yay81uzUiUMfI
X-Gm-Message-State: AOJu0YwZ9D/YhlrUrMOMFA6f5sdB2sS6cv202UecTJBfecN5FDz+eNQl
	IS/la7YrQY4CMvsWVym1wYTVad+e+R5ofHw9+G/Xkll8pgx4tXPYMSjp17H+
X-Google-Smtp-Source: AGHT+IGk8sdltoK4CMZcc6ZsHT7/YkIkoE47OHcxu3b57yqSNBejms53caZQFrYB5DsGvPCwcx0/4g==
X-Received: by 2002:a05:6214:d06:b0:6b5:49c9:ed51 with SMTP id 6a1803df08f44-6b549c9ef51mr50964256d6.31.1719241997594;
        Mon, 24 Jun 2024 08:13:17 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:13:17 -0700 (PDT)
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
Subject: [PATCH v3 6/7] drm/radeon: rdev->ddev to rdev_to_drm(rdev) 5
Date: Mon, 24 Jun 2024 11:10:50 -0400
Message-ID: <20240624151122.23724-7-wuhoipok@gmail.com>
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
 drivers/gpu/drm/radeon/radeon_ib.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 12 ++++++------
 drivers/gpu/drm/radeon/radeon_object.c  |  2 +-
 drivers/gpu/drm/radeon/radeon_pm.c      | 20 ++++++++++----------
 drivers/gpu/drm/radeon/radeon_ring.c    |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     |  6 +++---
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/radeon_ib.c
index 63d914f3414d..1aa41cc3f991 100644
--- a/drivers/gpu/drm/radeon/radeon_ib.c
+++ b/drivers/gpu/drm/radeon/radeon_ib.c
@@ -309,7 +309,7 @@ DEFINE_SHOW_ATTRIBUTE(radeon_debugfs_sa_info);
 static void radeon_debugfs_sa_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_sa_info", 0444, root, rdev,
 			    &radeon_debugfs_sa_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index c4dda908666c..9961251b44ba 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -80,7 +80,7 @@ static void radeon_hotplug_work_func(struct work_struct *work)
 {
 	struct radeon_device *rdev = container_of(work, struct radeon_device,
 						  hotplug_work.work);
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
 
@@ -101,7 +101,7 @@ static void radeon_dp_work_func(struct work_struct *work)
 {
 	struct radeon_device *rdev = container_of(work, struct radeon_device,
 						  dp_work);
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
 
@@ -197,7 +197,7 @@ static void radeon_driver_irq_uninstall_kms(struct drm_device *dev)
 
 static int radeon_irq_install(struct radeon_device *rdev, int irq)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
@@ -218,7 +218,7 @@ static int radeon_irq_install(struct radeon_device *rdev, int irq)
 
 static void radeon_irq_uninstall(struct radeon_device *rdev)
 {
-	struct drm_device *dev = rdev->ddev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	radeon_driver_irq_uninstall_kms(dev);
@@ -322,9 +322,9 @@ int radeon_irq_kms_init(struct radeon_device *rdev)
 	spin_lock_init(&rdev->irq.lock);
 
 	/* Disable vblank irqs aggressively for power-saving */
-	rdev->ddev->vblank_disable_immediate = true;
+	rdev_to_drm(rdev)->vblank_disable_immediate = true;
 
-	r = drm_vblank_init(rdev->ddev, rdev->num_crtc);
+	r = drm_vblank_init(rdev_to_drm(rdev), rdev->num_crtc);
 	if (r) {
 		return r;
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index a955f8a2f7fe..450ff7daa46c 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -150,7 +150,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	bo = kzalloc(sizeof(struct radeon_bo), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(rdev->ddev, &bo->tbo.base, size);
+	drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size);
 	bo->rdev = rdev;
 	bo->surface_reg = -1;
 	INIT_LIST_HEAD(&bo->list);
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 2d9d9f46f243..b4fb7e70320b 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -282,7 +282,7 @@ static void radeon_pm_set_clocks(struct radeon_device *rdev)
 
 	if (rdev->irq.installed) {
 		i = 0;
-		drm_for_each_crtc(crtc, rdev->ddev) {
+		drm_for_each_crtc(crtc, rdev_to_drm(rdev)) {
 			if (rdev->pm.active_crtcs & (1 << i)) {
 				/* This can fail if a modeset is in progress */
 				if (drm_crtc_vblank_get(crtc) == 0)
@@ -299,7 +299,7 @@ static void radeon_pm_set_clocks(struct radeon_device *rdev)
 
 	if (rdev->irq.installed) {
 		i = 0;
-		drm_for_each_crtc(crtc, rdev->ddev) {
+		drm_for_each_crtc(crtc, rdev_to_drm(rdev)) {
 			if (rdev->pm.req_vblank & (1 << i)) {
 				rdev->pm.req_vblank &= ~(1 << i);
 				drm_crtc_vblank_put(crtc);
@@ -671,7 +671,7 @@ static ssize_t radeon_hwmon_show_temp(struct device *dev,
 				      char *buf)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	int temp;
 
 	/* Can't get temperature when the card is off */
@@ -715,7 +715,7 @@ static ssize_t radeon_hwmon_show_sclk(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	u32 sclk = 0;
 
 	/* Can't get clock frequency when the card is off */
@@ -740,7 +740,7 @@ static ssize_t radeon_hwmon_show_vddc(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	u16 vddc = 0;
 
 	/* Can't get vddc when the card is off */
@@ -1692,7 +1692,7 @@ void radeon_pm_fini(struct radeon_device *rdev)
 
 static void radeon_pm_compute_clocks_old(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 
@@ -1765,7 +1765,7 @@ static void radeon_pm_compute_clocks_old(struct radeon_device *rdev)
 
 static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
 {
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
 	struct radeon_connector *radeon_connector;
@@ -1826,7 +1826,7 @@ static bool radeon_pm_in_vbl(struct radeon_device *rdev)
 	 */
 	for (crtc = 0; (crtc < rdev->num_crtc) && in_vbl; crtc++) {
 		if (rdev->pm.active_crtcs & (1 << crtc)) {
-			vbl_status = radeon_get_crtc_scanoutpos(rdev->ddev,
+			vbl_status = radeon_get_crtc_scanoutpos(rdev_to_drm(rdev),
 								crtc,
 								USE_REAL_VBLANKSTART,
 								&vpos, &hpos, NULL, NULL,
@@ -1918,7 +1918,7 @@ static void radeon_dynpm_idle_work_handler(struct work_struct *work)
 static int radeon_debugfs_pm_info_show(struct seq_file *m, void *unused)
 {
 	struct radeon_device *rdev = m->private;
-	struct drm_device *ddev = rdev->ddev;
+	struct drm_device *ddev = rdev_to_drm(rdev);
 
 	if  ((rdev->flags & RADEON_IS_PX) &&
 	     (ddev->switch_power_state != DRM_SWITCH_POWER_ON)) {
@@ -1955,7 +1955,7 @@ DEFINE_SHOW_ATTRIBUTE(radeon_debugfs_pm_info);
 static void radeon_debugfs_pm_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	debugfs_create_file("radeon_pm_info", 0444, root, rdev,
 			    &radeon_debugfs_pm_info_fops);
diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 8d1d458286a8..581ae20c46e4 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -550,7 +550,7 @@ static void radeon_debugfs_ring_init(struct radeon_device *rdev, struct radeon_r
 {
 #if defined(CONFIG_DEBUG_FS)
 	const char *ring_name = radeon_debugfs_ring_idx_to_name(ring->idx);
-	struct dentry *root = rdev->ddev->primary->debugfs_root;
+	struct dentry *root = rdev_to_drm(rdev)->primary->debugfs_root;
 
 	if (ring_name)
 		debugfs_create_file(ring_name, 0444, root, ring,
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5c65b6dfb99a..69d0c12fa419 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -682,8 +682,8 @@ int radeon_ttm_init(struct radeon_device *rdev)
 
 	/* No others user of address space so set it to 0 */
 	r = ttm_device_init(&rdev->mman.bdev, &radeon_bo_driver, rdev->dev,
-			       rdev->ddev->anon_inode->i_mapping,
-			       rdev->ddev->vma_offset_manager,
+			       rdev_to_drm(rdev)->anon_inode->i_mapping,
+			       rdev_to_drm(rdev)->vma_offset_manager,
 			       rdev->need_swiotlb,
 			       dma_addressing_limited(&rdev->pdev->dev));
 	if (r) {
@@ -890,7 +890,7 @@ static const struct file_operations radeon_ttm_gtt_fops = {
 static void radeon_ttm_debugfs_init(struct radeon_device *rdev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	struct drm_minor *minor = rdev->ddev->primary;
+	struct drm_minor *minor = rdev_to_drm(rdev)->primary;
 	struct dentry *root = minor->debugfs_root;
 
 	debugfs_create_file("radeon_vram", 0444, root, rdev,
-- 
2.45.2


