Return-Path: <linux-kernel+bounces-235290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5591D2FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80838B20C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B4155CBA;
	Sun, 30 Jun 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG9dgFwj"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E2155C95
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766858; cv=none; b=YV+58AhyHVe5UQM8RySTk2giWraYr3seiIVujrR635pRfMJ9KxfqkWQEf+RCB4ePxLvXvYE5rTzKBVALqqPW/0Uzg/nYhBAnV8PevS3QzP3OngbTy7fZL1BrL29yzmaw8n+nnVuQm2LTAYOeWwj3vZNPHefBXBw/BoMqUt2q6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766858; c=relaxed/simple;
	bh=ZCp5CV1hVSoB2TB0mtSm+dzqvtA1HPlMxyojPG9ZVTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYNP5X+ESXeQRiqKBb2uiz5KrusCNMkrlama07vM+ccyMyVt3tRLrD2k4QgYLy11B0w5m7fXtGTVTCOp7za+EOUfrzkfu2420dFjAHkKF6xot+X8LbSB/RKa2emPdSv+bFwMpUHGk43y5fpxM/1QIbVSPWAqBepXok6CiLp/tyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG9dgFwj; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48f5b8cde8cso760046137.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766856; x=1720371656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlhaFNhfAx0+KHxeTlQ2k5JPN6j1xoSeVgNpNKUjC6k=;
        b=mG9dgFwjKtW6ZOxIrF3Cbij/tvQHUpZcQk1vyNX1SKneC+TnP4mm/K7Fi88ytkTy2c
         /Z7eKVeaBpZZB/rdCFfun1zxOlMg14/QS5Hpz4jMHa24R34TpEf0f+PfUCPg/zx+NMfQ
         prVba6bleqhfQRAP7m2b1VWPwTT6AWNbNeyncwv3e1nBzcTyAwZx8ieHy+R8GEdDIp59
         D2b0m5qjQdX4tLByILcWR3vpOwxKTUOEeyzc9SwA/b8WCAsWgVAcfq3FJCiGalRVh+76
         Wr3GtyfU3Xa4DQBww8SqwtvFTssyG1kzrlVwrizHyWCmGwUtV2xw6up42PnTmJ1+cxmf
         0Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766856; x=1720371656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlhaFNhfAx0+KHxeTlQ2k5JPN6j1xoSeVgNpNKUjC6k=;
        b=SIzri9RkngjOzQpHpGVkkB78OgleBhXPdOSYj1IOhrzjl69zSffF0rxYaPgUo8QNLr
         Bz+vrkcBGybjJ5V57vOrPfK95cmKTab6aUNbP8gl91Huw6u40QRFG7D97ffQ1NSBmzMU
         SuTP0c4LlcwudybPJnrrBSTxip84Ir+zSLQ5Sch7bwu//gixtvZTjmfFutoCsLGNnfwW
         6q/6OVkIofXvwOA+T2n0PPNX5KSi3YjOlEJUtfqfWYyL1uiuUYx9+5SppX8B5RjuBs4t
         pcVcKsMh0hsbxsDQPSlRoNvdmKZuZJnxYH3H8bqBKLhmwMTVqVXi0WY5xrWAOWaW4HsM
         yJCg==
X-Forwarded-Encrypted: i=1; AJvYcCXmLcSt7FVCIGY/y1rQ0mJWdzVhf5uWEz7THmxGtsQ8sbAQUkUuQtQZxPbIdGoaAuTJmri/uk6HUJo3sX7PJuSmGTscCVwq4ma9+Dhj
X-Gm-Message-State: AOJu0Yz1SU7XV8ethHnpZjHldr2BqqPMcK77cF0cyGsL2OCqRqmejq5s
	+X/QwhRHw22CsDehyLDfzkjca/8Cbbmbu08GqVUj1DC5aPiP/A9k
X-Google-Smtp-Source: AGHT+IGr3xK4iR6mDCCPUhjjys3YyHdCiX4Ihwv6WPfrUP+aK8l7ib9jc6QMcFospdyQcQZlG8qHDA==
X-Received: by 2002:a05:6102:3a13:b0:48f:2afe:88f1 with SMTP id ada2fe7eead31-48faf0cf479mr4714159137.16.1719766855731;
        Sun, 30 Jun 2024 10:00:55 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:55 -0700 (PDT)
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
Subject: [PATCH v3 6/6] drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc
Date: Sun, 30 Jun 2024 12:59:22 -0400
Message-ID: <20240630165949.117634-7-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240630165949.117634-1-wuhoipok@gmail.com>
References: <20240630165949.117634-1-wuhoipok@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"drm_dev_alloc" is deprecated, in order to use the newer "devm_drm_dev_alloc",
the "drm_device" is stored inside "radeon_device", by changing "rdev_to_drm(rdev)"
other functions still gain access to the member "drm_device". Also, "devm_drm_dev_alloc"
is now allocating "radeon_device", allocation inside "radeon_driver_load_kms" has to be
removed.

In "radeon_device_init", it originally assigned "rdev->dev" etc. However it is already
done right after "devm_drm_dev_alloc" as you can see down below. It is better remove them.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h        |  4 ++--
 drivers/gpu/drm/radeon/radeon_device.c |  3 ---
 drivers/gpu/drm/radeon/radeon_drv.c    | 12 +++++++++---
 drivers/gpu/drm/radeon/radeon_kms.c    |  8 +-------
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index ae35c102a487..fd8a4513025f 100644
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
@@ -2478,7 +2478,7 @@ void cik_mm_wdoorbell(struct radeon_device *rdev, u32 index, u32 v);
 
 static inline struct drm_device *rdev_to_drm(struct radeon_device *rdev)
 {
-	return rdev->ddev;
+	return &rdev->ddev;
 }
 
 /*
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 32851632643d..554b236c2328 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1285,9 +1285,6 @@ int radeon_device_init(struct radeon_device *rdev,
 	bool runtime = false;
 
 	rdev->shutdown = false;
-	rdev->dev = &pdev->dev;
-	rdev->ddev = ddev;
-	rdev->pdev = pdev;
 	rdev->flags = flags;
 	rdev->family = flags & RADEON_FAMILY_MASK;
 	rdev->is_atom_bios = false;
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7b8aa8406751..f36aa71c57c7 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -260,6 +260,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 {
 	unsigned long flags = 0;
 	struct drm_device *ddev;
+	struct radeon_device *rdev;
 	int ret;
 
 	if (!ent)
@@ -300,9 +301,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ddev = drm_dev_alloc(&kms_driver, &pdev->dev);
-	if (IS_ERR(ddev))
-		return PTR_ERR(ddev);
+	rdev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*rdev), ddev);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	rdev->dev = &pdev->dev;
+	rdev->pdev = pdev;
+	ddev = rdev_to_drm(rdev);
+	ddev->dev_private = rdev;
 
 	ret = pci_enable_device(pdev);
 	if (ret)
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index a16590c6247f..645e33bf7947 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -104,15 +104,9 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	struct radeon_device *rdev;
+	struct radeon_device *rdev = dev->dev_private;
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
-- 
2.45.2


