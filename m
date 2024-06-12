Return-Path: <linux-kernel+bounces-212317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA18905E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28301C227EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC1B84D11;
	Wed, 12 Jun 2024 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdwsM3Zf"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076012C54D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231090; cv=none; b=S4JDtVgnbgBqBi+dxlwkoT1Chw4Ne7sBvyFTLerMig6TmwH5cx63oy+VmlVbJF6t4HwvKe2N4V+K/sly4vBeYCO2DPU7zZVWRkryY+TdBA7mJmVJl1Il86MsG4d3w4icB9Q62nP2wsIeHDTYkBb9gidKuFqRiLEslBYl2+8CiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231090; c=relaxed/simple;
	bh=HGzIge+7bnjQiHBPTYl+Omvw6qwV6Fo+vN9k3Ffj8do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6ixbcpULQm8KePtQfmHdt5iw4CpJfFZvN8nao3qVKd3TECJCFp8mV6enDGrelx8NTzclPDgVR56ggdua8gI8NUzeN8e0WigD8yP3PZx+KLfZtUDpi5v5ackiF89f+yBXVjeRBXpDOz0bO6oVMPHCyEDLivkS1YtL4Zck3sOu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZdwsM3Zf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d0fso3206925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231088; x=1718835888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR6S2QVtzFM/jxymlLuEpObYuJIES6ks6qhmMWCUZhU=;
        b=ZdwsM3ZffKSb+D2bPVWgsjXOXZlyPWbzv6FWa+z0JGNXx4cXKHg4Dl2Qx2tss8fe7a
         GvzoPEIksvTvO9aoCaLWaXWlg5Pwi3Bpxv+kvWpdIjHBEBFaO/lZZ39gpROB8RbOtCBs
         4ShbWEBpUTpi13AfJMCx45mJz82GnFTHSpfLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231088; x=1718835888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR6S2QVtzFM/jxymlLuEpObYuJIES6ks6qhmMWCUZhU=;
        b=G8Q9E8Spyef+YrHQ85OIpjQ7r0c0H7rzrajP5xQMvuW7BkJL3LDQXJQ5pKWteZOz6B
         ms0IRRJKeL1UHwGLpVV6SpGIXxStUcaW2xj2AAc/BONkha8sfcZubKraIC2wTEsWCmZq
         kCFPRdhjSo01MT0W6clazrH05KvUqBGbYLwblIWOt1inWd+AryTK++Nni8z3J0o+1FPU
         BbcvqIImR3rC8Sa54VrYUZFZJEXIaLIwcPTEhzdNUCRMX8BQrWY/qc+M/FaDtBUQsPVe
         JLgz3/3D1gBbSI8oBTZGpjoitahfJg/P+8U38iP1vfih4OCMNViBVFWUr2qwyhnrUw3m
         LRMg==
X-Forwarded-Encrypted: i=1; AJvYcCW0fAjrR0gndKT1W+iSljVujMYNKuXKy3xf9bIWiBixMtJpkaWpY1YAczvfYtmhduGWIVfsgwk1bQKomsDRUdVKMscxnbJe8gy7WYmA
X-Gm-Message-State: AOJu0YzmRar5OoFXR39h3mdfJin4rSWJRGqfyksitC3ofXB9OMS7N9Vh
	BG8SUE2hYWfCuKGW2q8WrRYzM9qfS6oGWwn9q+Uvtu45t1zH1I0AhFquh0IpJA==
X-Google-Smtp-Source: AGHT+IHKCE/3t+anxzcGR/vWhd2u/e5A1hvjZyotl4hoC22LuX9W+2G5IFPLfxJ6lZv8cQy/absvjg==
X-Received: by 2002:a17:902:e844:b0:1f6:225e:67a1 with SMTP id d9443c01a7336-1f83b70eaa3mr34942835ad.56.1718231088645;
        Wed, 12 Jun 2024 15:24:48 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:47 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH v2 2/8] drm/nouveau: Call drm_atomic_helper_shutdown() or equiv at shutdown time
Date: Wed, 12 Jun 2024 15:23:42 -0700
Message-ID: <20240612152336.v2.2.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() (or
drm_helper_force_disable_all() if not using atomic) at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested. I made my best guess about
how to fit this into the existing code. If someone wishes a different
style, please yell.

(no changes since v1)

 drivers/gpu/drm/nouveau/nouveau_display.c  |  9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_display.h  |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c      | 13 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h      |  1 +
 drivers/gpu/drm/nouveau/nouveau_platform.c |  6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index d4725a968827..15da55c382f1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -645,6 +645,15 @@ nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime)
 	disp->fini(dev, runtime, suspend);
 }
 
+void
+nouveau_display_shutdown(struct drm_device *dev)
+{
+	if (drm_drv_uses_atomic_modeset(dev))
+		drm_atomic_helper_shutdown(dev);
+	else
+		drm_helper_force_disable_all(dev);
+}
+
 static void
 nouveau_display_create_properties(struct drm_device *dev)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
index 2ab2ddb1eadf..9df62e833cda 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -47,6 +47,7 @@ void nouveau_display_destroy(struct drm_device *dev);
 int  nouveau_display_init(struct drm_device *dev, bool resume, bool runtime);
 void nouveau_display_hpd_resume(struct drm_device *dev);
 void nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime);
+void nouveau_display_shutdown(struct drm_device *dev);
 int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
 void nouveau_display_resume(struct drm_device *dev, bool runtime);
 int  nouveau_display_vblank_enable(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a947e1d5f309..b41154c9b9cc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -894,6 +894,18 @@ nouveau_drm_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+void
+nouveau_drm_device_shutdown(struct drm_device *dev)
+{
+	nouveau_display_shutdown(dev);
+}
+
+static void
+nouveau_drm_shutdown(struct pci_dev *pdev)
+{
+	nouveau_drm_device_shutdown(pci_get_drvdata(pdev));
+}
+
 static int
 nouveau_do_suspend(struct drm_device *dev, bool runtime)
 {
@@ -1361,6 +1373,7 @@ nouveau_drm_pci_driver = {
 	.id_table = nouveau_drm_pci_table,
 	.probe = nouveau_drm_probe,
 	.remove = nouveau_drm_remove,
+	.shutdown = nouveau_drm_shutdown,
 	.driver.pm = &nouveau_pm_ops,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 25fca98a20bc..78a91686006b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -327,6 +327,7 @@ struct drm_device *
 nouveau_platform_device_create(const struct nvkm_device_tegra_func *,
 			       struct platform_device *, struct nvkm_device **);
 void nouveau_drm_device_remove(struct drm_device *dev);
+void nouveau_drm_device_shutdown(struct drm_device *dev);
 
 #define NV_PRINTK(l,c,f,a...) do {                                             \
 	struct nouveau_cli *_cli = (c);                                        \
diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index bf2dc7567ea4..511f3a0c6ee9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -49,6 +49,11 @@ static void nouveau_platform_remove(struct platform_device *pdev)
 	nouveau_drm_device_remove(dev);
 }
 
+static void nouveau_platform_shutdown(struct platform_device *pdev)
+{
+	nouveau_drm_device_shutdown(platform_get_drvdata(pdev));
+}
+
 #if IS_ENABLED(CONFIG_OF)
 static const struct nvkm_device_tegra_func gk20a_platform_data = {
 	.iommu_bit = 34,
@@ -93,4 +98,5 @@ struct platform_driver nouveau_platform_driver = {
 	},
 	.probe = nouveau_platform_probe,
 	.remove_new = nouveau_platform_remove,
+	.shutdown = nouveau_platform_shutdown,
 };
-- 
2.45.2.505.gda0bf45e8d-goog


