Return-Path: <linux-kernel+bounces-224831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3791275E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C071F24425
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273341C6BD;
	Fri, 21 Jun 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Hnd+wH"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA4125C1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979422; cv=none; b=WZCpIZ3I+rPIUd0eKC0R9lDZ8GrTJBUnmYVf5mCzbPt2nh9HyE9VMylHzOX55Yx6Kx4UjGmi8SneVXVY+hFtxnNoL3JTxHrTdfZmxN97EYT3f1O+Za51fgOZJmciJxWF1rBazHRiJisByz9Nf3uYR9poREk6yLn99j8rhwp+RtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979422; c=relaxed/simple;
	bh=R58iYbMpOI5Vn2Sg6WtJYjV3VtZugTkhYeHmTzuly2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APQ4wK64hP5DkGqVVNodQzagIn11AXODaxX/SAQkMKnHbAqeLamrlPApvfXu8qMMNa3nlBXd1cI4PbxRCb+m6BdXbfUB6IpQvOuzKVkyOWIKAfQDBEpFWZy+Eh7GO///67hA5/cx1BMfotIMXZ0dOxUFI4Av9Eex/wwOSQQVjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Hnd+wH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f97a4c4588so1201780a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718979420; x=1719584220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Esapyh4sEYZ9iUxizwPARzP2FysvGIktBy8oVxqC0Cw=;
        b=m0Hnd+wHF3wGNuV8N+CZMOExfyvMSMIQBjH2twNIsaue3SOQnLbCZVAr7c8CKS0qkA
         VC+Lbs0zYwI1/SaW7aazIzXa4SpYUS+yvFSY8r9iFrGF+Vv6q+ig9sLLQa1cb1jw/pbR
         zzkkeusXKYoLyztZ/2GRMGG+tzFhlBmHXFGjz+LS2leGgK6M4AHVLchK1N/AhinoKlgw
         +Cz+YP3j3I9MgdE6lUDdAmxgXUEJVR5F3bW9+4nkr5kT5I3u+jzcSyaV9QJwC5U8im2t
         ACdWcTuUJdPENhVbwP9oDvhAgCmJMVYSd1qPVmYlTanhhMKTnuvoRVoaD/lo+dty4SyT
         vGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979420; x=1719584220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Esapyh4sEYZ9iUxizwPARzP2FysvGIktBy8oVxqC0Cw=;
        b=UMn0aWhU8dnYULfFFxBll1mbugAiyfe7Sb3Ts5ZjVQ24zZPGlcXSGzzRCvb4GxWYIg
         aY/iyQXI5np52Q8ssQchCU+hicvV9ceMvJNy7xXD38VswAWjbBcorphZH+wJVK2Xhzgo
         nTRLYFfy3yGAFlRR/rQ4Q3UFxem+5BGHWaWvmthHNHizLiyjlO98CK0sKaAOSsfPPPHE
         hWJ5q1ITE4Kj3+VFAzOhak5QZXQhIjA9rCSghwMtPuVB1Mb8sIZT0ZIJFkbAlNDisSbn
         AAw5CUVqoM2ErqsFBoC1NyZR8QRqziWMlzll+Ncpcbj6jNdRHqCuTZKU+hkafTiXZW7K
         FUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVykmva5h5iVOs/ODfzjr3qB1lQuY6YKPcEeEZIn2O4wJDCVayGbXTk4FiYF7gY2EuU/+6LnkFw5/Spjrfoc1jrQVFugM9b9klOrKUD
X-Gm-Message-State: AOJu0YxY3X9qt74AA8Iq3jetzsZ9spzFkG9dZasMuDbMfAYOwZPQZJjY
	jzt8j4NC7lfyKjDPJCZY+Ka/n7ec87rRz4GdVumlCsqMB6NFpgRc
X-Google-Smtp-Source: AGHT+IHB9Q1J37kAuSt0w6qEbVtcrjIXCCwTuAGNeZVLBZz8uneDHbm725GPvvSy6CUL/a7gavHGOg==
X-Received: by 2002:a05:6830:20cb:b0:6f9:edf5:6374 with SMTP id 46e09a7af769-7007682cc4amr9214565a34.34.1718979419623;
        Fri, 21 Jun 2024 07:16:59 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed4aa5asm9090346d6.55.2024.06.21.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:16:59 -0700 (PDT)
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
Subject: [PATCH v2 1/7] drm/radeon: remove load callback
Date: Fri, 21 Jun 2024 10:15:37 -0400
Message-ID: <20240621141544.19817-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is "drm/radeon: remove load callback" v2, the only changes
were made are adding "ddev->dev_private = rdev;", right after
the allocation of "struct radeon_device". Patch v2 2-7 mostly
describes simple "rdev->ddev" to "rdev_to_drm(rdev)" to suit
Patch v2 1/7.

Please be aware that these 7 patches depends on each other.

Thank you.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h     | 11 ++++++++---
 drivers/gpu/drm/radeon/radeon_drv.c | 27 ++++++++++++++++++---------
 drivers/gpu/drm/radeon/radeon_drv.h |  1 -
 drivers/gpu/drm/radeon/radeon_kms.c | 18 ++++++------------
 4 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 0999c8eaae94..69bb30ced189 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2297,7 +2297,7 @@ typedef void (*radeon_wreg_t)(struct radeon_device*, uint32_t, uint32_t);
 
 struct radeon_device {
 	struct device			*dev;
-	struct drm_device		*ddev;
+	struct drm_device		ddev;
 	struct pci_dev			*pdev;
 #ifdef __alpha__
 	struct pci_controller		*hose;
@@ -2440,10 +2440,13 @@ struct radeon_device {
 	u64 gart_pin_size;
 };
 
+static inline struct drm_device *rdev_to_drm(struct radeon_device *rdev)
+{
+	return &rdev->ddev;
+}
+
 bool radeon_is_px(struct drm_device *dev);
 int radeon_device_init(struct radeon_device *rdev,
-		       struct drm_device *ddev,
-		       struct pci_dev *pdev,
 		       uint32_t flags);
 void radeon_device_fini(struct radeon_device *rdev);
 int radeon_gpu_wait_for_idle(struct radeon_device *rdev);
@@ -2818,6 +2821,8 @@ struct radeon_device *radeon_get_rdev(struct ttm_device *bdev);
 
 /* KMS */
 
+int radeon_driver_load_kms(struct radeon_device *dev, unsigned long flags);
+
 u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc);
 int radeon_enable_vblank_kms(struct drm_crtc *crtc);
 void radeon_disable_vblank_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..ae9cadceba83 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -259,7 +259,8 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	unsigned long flags = 0;
-	struct drm_device *dev;
+	struct drm_device *ddev;
+	struct radeon_device *rdev;
 	int ret;
 
 	if (!ent)
@@ -300,28 +301,37 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	dev = drm_dev_alloc(&kms_driver, &pdev->dev);
-	if (IS_ERR(dev))
-		return PTR_ERR(dev);
+	rdev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*rdev), ddev);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	rdev->dev  = &pdev->dev;
+	rdev->pdev = pdev;
+	ddev = rdev_to_drm(rdev);
+	ddev->dev_private = rdev;
 
 	ret = pci_enable_device(pdev);
 	if (ret)
 		goto err_free;
 
-	pci_set_drvdata(pdev, dev);
+	pci_set_drvdata(pdev, ddev);
+
+	ret = radeon_driver_load_kms(rdev, flags);
+	if (ret)
+		goto err_agp;
 
-	ret = drm_dev_register(dev, ent->driver_data);
+	ret = drm_dev_register(ddev, flags);
 	if (ret)
 		goto err_agp;
 
-	radeon_fbdev_setup(dev->dev_private);
+	radeon_fbdev_setup(ddev->dev_private);
 
 	return 0;
 
 err_agp:
 	pci_disable_device(pdev);
 err_free:
-	drm_dev_put(dev);
+	drm_dev_put(ddev);
 	return ret;
 }
 
@@ -569,7 +579,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
 static const struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_GEM | DRIVER_RENDER | DRIVER_MODESET,
-	.load = radeon_driver_load_kms,
 	.open = radeon_driver_open_kms,
 	.postclose = radeon_driver_postclose_kms,
 	.unload = radeon_driver_unload_kms,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.h b/drivers/gpu/drm/radeon/radeon_drv.h
index 02a65971d140..6c1eb75a951b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.h
+++ b/drivers/gpu/drm/radeon/radeon_drv.h
@@ -117,7 +117,6 @@
 long radeon_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg);
 
-int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags);
 void radeon_driver_unload_kms(struct drm_device *dev);
 int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
 void radeon_driver_postclose_kms(struct drm_device *dev,
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index a16590c6247f..d2df194393af 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -91,7 +91,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 /**
  * radeon_driver_load_kms - Main load function for KMS.
  *
- * @dev: drm dev pointer
+ * @rdev: radeon dev pointer
  * @flags: device flags
  *
  * This is the main load function for KMS (all asics).
@@ -101,24 +101,18 @@ void radeon_driver_unload_kms(struct drm_device *dev)
  * (crtcs, encoders, hotplug detect, etc.).
  * Returns 0 on success, error on failure.
  */
-int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
+int radeon_driver_load_kms(struct radeon_device *rdev, unsigned long flags)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	struct radeon_device *rdev;
+	struct pci_dev *pdev = rdev->pdev;
+	struct drm_device *dev = rdev_to_drm(rdev);
 	int r, acpi_status;
 
-	rdev = kzalloc(sizeof(struct radeon_device), GFP_KERNEL);
-	if (rdev == NULL) {
-		return -ENOMEM;
-	}
-	dev->dev_private = (void *)rdev;
-
 #ifdef __alpha__
 	rdev->hose = pdev->sysdata;
 #endif
 
 	if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
-		rdev->agp = radeon_agp_head_init(dev);
+		rdev->agp = radeon_agp_head_init(rdev_to_drm(rdev));
 	if (rdev->agp) {
 		rdev->agp->agp_mtrr = arch_phys_wc_add(
 			rdev->agp->agp_info.aper_base,
@@ -147,7 +141,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	 * properly initialize the GPU MC controller and permit
 	 * VRAM allocation
 	 */
-	r = radeon_device_init(rdev, dev, pdev, flags);
+	r = radeon_device_init(rdev, flags);
 	if (r) {
 		dev_err(dev->dev, "Fatal error during GPU init\n");
 		goto out;
-- 
2.45.2


