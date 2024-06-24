Return-Path: <linux-kernel+bounces-227468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ABD9151B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CDF28667B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326A19ADBE;
	Mon, 24 Jun 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZylxdIu"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC319B5B0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241964; cv=none; b=PHCfEh0QLGMnVtKREF+mt3lmMLWlERURYxck6wAUPMxklnDXNA0zdepkRbu+FfE4IHo777fZ7A56ARSDSLZvRNCBKl2G+xGbDMp630DjhhNi7n4H8nYuvF1Yeca713xNg7wqxndZkHIuCvNm/XI7T4S2A0fjT+KlmJZtl1KkLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241964; c=relaxed/simple;
	bh=HUUByk0DJZztso08IM0S+v7LViXOLUvI91fhluWlZhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcEBS3tYTEcsDrclaLZEQMFzzT+uUzAV7i14r+WbzsHnnQhapKxBWM9jT6Wvtxf4hlavtM1tlTnSzO9E1JQ04g5LLv+J+T/qFIWaaBZW7WCPvOZ1kks2mJfl0U4wCmp52Sn4HrflHPE7cvqJH1PRwdhVs2uHxK9CIFtZzfrGDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZylxdIu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b4ffc2a7abso35740236d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241962; x=1719846762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GABY2nvouUZjfeGwOTIxOkPVykOPUX3bq4LbbVyRoM=;
        b=PZylxdIutwpCH3pjnusOl84V/DXq1m9h7/k6eD651IMQ0VXRXct/QBmlf+4vg7trBW
         2CGQfECnFVud/+HOIGLpXTb67/9S/+HMZhJ7I0S131S+FvysqMmIw9CvUg6EzBJwty7O
         3lSrGOKSehJdb3CsjdMZWEzoMJMM5j4cPV+YL9QlxEWSAaAsYLRWyRTgqxfL1y9SynHf
         jfFkyG61uNW+kn4H7poq59xw9/N0jP/8CZHY2soX5223zBztFcQWriytg3MOC+fRX17h
         WUEdCt6XtMszPIY8TvGTVB8TlQsbmhf/48TzpZ6gHaNC/U6nByFPem5Aixw9avHvFXJZ
         8F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241962; x=1719846762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GABY2nvouUZjfeGwOTIxOkPVykOPUX3bq4LbbVyRoM=;
        b=URXkXFyNjbAs3cSxF+myq/Yg14RKo3H5CoorkEcPBQkXq5BCP1W85ybHgekMF6IGgv
         Q8RK9ihbCHsUNG6kLZy+49Br5OFjQnl+bUdVo+HHBop/8AblaWycUBySmcOf1DC8y/va
         fxGGxhuAacNJbCdftwB0QoR9orJe4ba/nBMxxKdTgNJoxkat1mgwLaz6YjhI3y0Qi1GK
         fpi/OQ7AGb13U8MBfLVY39V1Pyeu687H0wxX2173GhQS7G8Kl+dD/27ZB2W6IGP45otR
         7Oo7LLzUlzUuGfUT4pK1DFKdwgtPDaZRjc7SYF87oa87N9VSJDkqUYSG7qABboAgEu14
         tckw==
X-Forwarded-Encrypted: i=1; AJvYcCXeTetqs8IWmwVq83JcQVJFCPFwfMogMaja8riWBNpg/KW/dmM0Qxz0f59xH9TNlzSUA92gfc1yXzPIUZEzdW5TUtvhrgVj0RyRep2x
X-Gm-Message-State: AOJu0YwHPfoha1cbccOR6pNHuWewNoPjEZUwDiZQG65vzfL0wCTUl9ti
	B5UnM+B9hIBeJaKgN82bK7XgL3EF8pVNY6zW7gF5k1c5KrtvBbvh
X-Google-Smtp-Source: AGHT+IFuVCQIMxGLsEodTOfH3eyC8ePGTJrcOWZgS2npTRXBH4SIi8n4cZ2nFvHwh8J8UOMRC8+4tg==
X-Received: by 2002:ad4:418d:0:b0:6b5:2f57:1a63 with SMTP id 6a1803df08f44-6b56360996amr12300036d6.21.1719241961650;
        Mon, 24 Jun 2024 08:12:41 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:12:41 -0700 (PDT)
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
Subject: [PATCH v3 1/7] drm/radeon: remove load callback
Date: Mon, 24 Jun 2024 11:10:45 -0400
Message-ID: <20240624151122.23724-2-wuhoipok@gmail.com>
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

Remove ".load" callback form "kms_driver", and move "struct drm_device"
into radeon_device. Patch 2 to 7 follows up with changing the way of
accessing drm_device, from "rdev->ddev" to "rdev_to_drm(rdev)" which is
"&rdev->ddev".

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


