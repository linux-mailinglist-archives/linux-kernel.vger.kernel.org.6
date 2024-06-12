Return-Path: <linux-kernel+bounces-212321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E0905E75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC33A2848E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DF12E1D3;
	Wed, 12 Jun 2024 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2twhUfI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21112DD92
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231099; cv=none; b=IIen62yDJWuuSv+VF1Py8MomRQT8gWcxCWWE4BlaJ35acLQitEU1HwSfUdcG7mY6qDRu1XjkNU56miRXkbzeOG5EfcshUbSb30TXoSU85cgw009p1uwBvDkFqa4DKT+1Kx+kFM2l4tWfohlCi+qkrpqUVajiaDDgCr82G/yp/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231099; c=relaxed/simple;
	bh=2wkzVnCDA5HjRFr52Hnwqtvv2KLUsgP9ff53wxCjhiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+xJjcpz5vio2fVCBivuQtj3i4A++Jy7ErWyK+Ogpxci1zOWbGNygxtTM8ikjPbDbd569QrbdvJxTcuJ9etkgm9cXl/fj/IM6sFqcL+x+4a8J+W0kQPSJ/BeHOWk0fhvnpoRMPrJgHSqy6ep3xwgHAM7oZiihro5/oG0n5tZgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E2twhUfI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so3402155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231098; x=1718835898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCLxsF8rhWGGZr+97E/MrTNjYe+fnMrZ7mNGuOaWySo=;
        b=E2twhUfI3UXvTzABAPalO9ey+rGv7+WluUm849XY25JKXhidHjEG5oX1UmK8i46xs0
         O7KZhiz56+jMrpQ8Q1LkHLKawH3Ep7vt/8F7Rkk/SFCM1T9iR8ftXNnPK+d/BkxV4ytm
         6rrzcUJEQ1czsItMzX3oKy6pXAiUV6hOS7BBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231098; x=1718835898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCLxsF8rhWGGZr+97E/MrTNjYe+fnMrZ7mNGuOaWySo=;
        b=dd6b8CzSFHVa5FyfFgsxTzPAtqFwNnQs3JK3Cl3D9l2on3ckvcxJrIOvzF5/Rg1qf0
         bhT35SIET4vPP+QP6MM0mVvCti4YcKRJVEGqQmm+1VXsx3rmW9ppVepgW4uGSG2+I9+4
         iAq/RFQFWNvotwjpbBkElti0x4PFjdmz+SoAF/Dxc6ky4NiXLN63d9ft8qd+H0GjPxnm
         bfM7Uj0awFxhGsQiaw993sTFwBeK9xt/dByPea6GrMucroYVsVH1rZ1k0045e/lSF+Il
         RiOR+/KLIw4K+wA6vet4C7q9DBotEpJAQlAK40y5vFHxnDqotwhp09tYUKp3nOxlJ8nC
         +xZw==
X-Forwarded-Encrypted: i=1; AJvYcCWmy2b2dqe1JVxqE8u0lhIVp9pehEWzrLXmWZb9Md9sMJCcg5UiYYE/8F4sf2A856Fxk73HvIS1uPAOyOeDyTpVeBrOCQn6hGOLJNPq
X-Gm-Message-State: AOJu0YyKxNcKC88M7IcINw4yugnxNyCme3+fR9SeiyGuzVNmHBpK5Iog
	6zKJOBQluMJi4tLfZ2kW+p/910SXDPXDbYrGfAXVtev16etE4ZGx/EQVMdOe4g==
X-Google-Smtp-Source: AGHT+IFXmBDxj4j5xao5roMZtZUT3z8AsYTNgifgJ+RUUK1gO4l9UAxZFVxYo9uWh5aBe2pfsNj1Pg==
X-Received: by 2002:a17:903:2307:b0:1f7:1ca3:d0d3 with SMTP id d9443c01a7336-1f83b565d56mr34307215ad.4.1718231097634;
        Wed, 12 Jun 2024 15:24:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:56 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] drm/gma500: Call drm_helper_force_disable_all() at shutdown/remove time
Date: Wed, 12 Jun 2024 15:23:46 -0700
Message-ID: <20240612152336.v2.6.I1be622999c3b23f28f077fc75bb0319396a216e9@changeid>
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

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown(), or in this case the
non-atomic equivalent drm_helper_force_disable_all(), at system
shutdown time and at driver remove time. This is important because
drm_helper_force_disable_all() will cause panels to get disabled
cleanly which may be important for their power sequencing. Future
changes will remove any custom powering off in individual panel
drivers so the DRM drivers need to start getting this right.

The fact that we should call drm_atomic_helper_shutdown(), or in this
case the non-atomic equivalent drm_helper_force_disable_all(), in the
case of OS shutdown/restart comes straight out of the kernel doc
"driver instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/gma500/psb_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..a5a399bbe8f5 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -20,6 +20,7 @@
 #include <acpi/video.h>
 
 #include <drm/drm.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
@@ -485,6 +486,12 @@ static void psb_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
+	drm_helper_force_disable_all(dev);
+}
+
+static void psb_pci_shutdown(struct pci_dev *pdev)
+{
+	drm_helper_force_disable_all(pci_get_drvdata(pdev));
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(psb_pm_ops, gma_power_suspend, gma_power_resume, NULL);
@@ -521,6 +528,7 @@ static struct pci_driver psb_pci_driver = {
 	.id_table = pciidlist,
 	.probe = psb_pci_probe,
 	.remove = psb_pci_remove,
+	.shutdown = psb_pci_shutdown,
 	.driver.pm = &psb_pm_ops,
 };
 
-- 
2.45.2.505.gda0bf45e8d-goog


