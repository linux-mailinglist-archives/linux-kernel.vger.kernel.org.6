Return-Path: <linux-kernel+bounces-377117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F69ABA15
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE231C22E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCC1CEEAE;
	Tue, 22 Oct 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="U+FJoJOH"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F51CEADF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639790; cv=none; b=SGtEI8X0Bzj7Lvf4rEJhtppwkSMWnuacHTXiGHCFU48Za1X2KLEXpB3bvTBXqqDcE25AnB1RfCJYZz/OnPAhSslRba+y3MZXO2oP1l+LJ1ew4tDBQ71dU/cVqY68Sw3OSWupsjlXUAniTs7t35MVUJ2k+Z0+kyhqGJBwq+k7ogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639790; c=relaxed/simple;
	bh=mJJP4NFMgpUIHLmDof5C/WQkxSL1vtNV830l4pHYEAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxOWlKd9VkAsdjvYXuzAR4fanzZahHRV0rmsXfWmRjJALpwrMqohi43FT0Y8XIGhBghfcdbM2J1fZ5Up+Sp01iuLc6TBoJE+vK6qklBAHycB1Mvsh9CmHATNkzZOe/8AMPPxJqWYK/CQkdd1xEYFDOqo+gUOXkDL4FdUMGjcrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=U+FJoJOH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=a+8B/W4nG6OVt83hHSuwJrLKhvYzazktOCgXNngg1nM=; b=U+FJoJOHQBa9nRMK
	DzALhTBUhFAFmpvg8P8B236pJJ8rU3jux/O+0G33KHQFZJbnhlPOC1SJATJt6+95U6QVKUJwfGSKo
	nxh0QS4W7C/ize28lIduJPBFLybQV9er78QYrVvkUEShf3ycFd9Wl5/UOw0+RgkRlUCfTHgpKct+C
	oUWHAjxIN45F8h+c8B+bUPNqzEMj23r9NVP3hhGchh/9IURou9DXbVdRA9jGDAcecbjijNsXO0F/w
	2/kM4PW8W3+NhPz/1UJ8T44CIFZaQpJoPhNEvWR54eHwc7QZSVCvz7SupukWTOk1SMFx6U/2ogLn3
	92dDz5R6A4FYt+qOuw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJm-00CtGr-2D;
	Tue, 22 Oct 2024 23:29:38 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/5] drm/sysfs: Remove unused drm_class_device_(un)register
Date: Wed, 23 Oct 2024 00:29:31 +0100
Message-ID: <20241022232934.238124-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022232934.238124-1-linux@treblig.org>
References: <20241022232934.238124-1-linux@treblig.org>
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


