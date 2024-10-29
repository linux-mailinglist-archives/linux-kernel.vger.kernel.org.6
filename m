Return-Path: <linux-kernel+bounces-387920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0259B5802
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EE41F215F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0756120E02F;
	Tue, 29 Oct 2024 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DKnuj4ZS"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805420C013
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245641; cv=none; b=RhJ8vHQW2JXcOdZ2Ooab9BTmRrRF3C/yxcQ8vNgrTdWTnvH+/J0Pe8/dPrybgOJM1m8NyfV0KWXpX1HauIu16d8SC+mCCNVMSY/P/gE0CJWB0cgMZH3LlkCuSvbU7RgpdKPeY9Y5tWG+RR5AJQgILQ4AA1jJySBT+znbNu767w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245641; c=relaxed/simple;
	bh=gnbO7UilrQ70cWyDiAILaS709A7egGlfp6vCNriH9EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpLaVhswIiP2RfS4RC2mVmWHXqXupDo/e07jxmesP/ub2CIpmLFQ6KKtLDBO1YGqbKYh46QdhJhU/iDopaiJNfD67SOGX8oIHl2Qr36NHzexPnrHVq3x1WQLRG+IYyRsC8nqUbWkMavKyXU0ouI8LddawS93cBxb45Sf+cy1MhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DKnuj4ZS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=LC9oDJnN6kZ4N2r0wYkvLK4l047d103spGwC2xW8urY=; b=DKnuj4ZSPCZJ7dwY
	SSvTfgPhvo6RSEBo1I+GWqXzb15GR1b7tdqHL2yGNQmxQa6hqNqYjl3eIKuODD8sANfUY69SsNMxv
	nfmXtwqIhFpqPcFhV2GFSEZmXa6KeVrb1zemEFGxI5Er5GACONoNjFvNtPQUKxOkEuSPiw1v/b3AN
	amJEmiQ1isOkA6qv1XSypYCAapuJVbQovSZ+ZkKVLHUJpWFvTCxm3jS1DcToeRq4+v0VYioqAuESq
	s2xPt7lC6mC0B4Z18Tu2fo8nqNZQkTHXthK7QD6zNWfLGQpOxuuHuUIAGyDakr1eXTl0aLM3cZ6OI
	ORdAh9XTcFXvgjWfTw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5vvY-00EMNX-2O;
	Tue, 29 Oct 2024 23:47:08 +0000
From: linux@treblig.org
To: dmitry.baryshkov@linaro.org,
	ville.syrjala@linux.intel.com,
	jfalempe@redhat.com,
	tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 2/3] drm/sysfs: Remove unused drm_class_device_(un)register
Date: Tue, 29 Oct 2024 23:47:04 +0000
Message-ID: <20241029234706.285087-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029234706.285087-1-linux@treblig.org>
References: <20241029234706.285087-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

drm_class_device_register() and drm_class_device_unregister() have been
unused since
commit ed89fff97382 ("drm/ttm: drop sysfs directory")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_sysfs.c | 32 --------------------------------
 include/drm/drm_sysfs.h     |  4 ----
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index fb3bbb6adcd1..3bc90fe5cea3 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -548,35 +548,3 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 	put_device(kdev);
 	return ERR_PTR(r);
 }
-
-/**
- * drm_class_device_register - register new device with the DRM sysfs class
- * @dev: device to register
- *
- * Registers a new &struct device within the DRM sysfs class. Essentially only
- * used by ttm to have a place for its global settings. Drivers should never use
- * this.
- */
-int drm_class_device_register(struct device *dev)
-{
-	if (!drm_class || IS_ERR(drm_class))
-		return -ENOENT;
-
-	dev->class = drm_class;
-	return device_register(dev);
-}
-EXPORT_SYMBOL_GPL(drm_class_device_register);
-
-/**
- * drm_class_device_unregister - unregister device with the DRM sysfs class
- * @dev: device to unregister
- *
- * Unregisters a &struct device from the DRM sysfs class. Essentially only used
- * by ttm to have a place for its global settings. Drivers should never use
- * this.
- */
-void drm_class_device_unregister(struct device *dev)
-{
-	return device_unregister(dev);
-}
-EXPORT_SYMBOL_GPL(drm_class_device_unregister);
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 96a5d858404b..7695873a9456 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -3,13 +3,9 @@
 #define _DRM_SYSFS_H_
 
 struct drm_device;
-struct device;
 struct drm_connector;
 struct drm_property;
 
-int drm_class_device_register(struct device *dev);
-void drm_class_device_unregister(struct device *dev);
-
 void drm_sysfs_hotplug_event(struct drm_device *dev);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_property_event(struct drm_connector *connector,
-- 
2.47.0


