Return-Path: <linux-kernel+bounces-359640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA4998E73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3415DB25624
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35081C8FB9;
	Thu, 10 Oct 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZrAk3ji+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6719D06B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581956; cv=none; b=k0o+oi477OI0rIJZbhsDgY0K17bE4TMB6NkHO+FdiUuLU6TXjSKH65+rmRVcsjeaZiRlvgWJxBrW7w2HtyNWrLeRaI3c2rZ5mSTOgo2O6ayG8CGpIllacnWTZrR46eezNjdMyEupMS3YBiO/RFmoRJ7OgRORf6pOQhJdxRNakxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581956; c=relaxed/simple;
	bh=PQ87QRrHXXBxQiWqyj4h93dY9Re2kRrb505r5//jqMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YByYbH5LjbkumNEMsmYTYpTky1hBhlRrpt490u8tQGzDDodKb2F7Yi4uX3zNjsAtFhc64EsyLdXZM2AAmhCLUa4y8RoUpFqmj9vuVC7CB1OAC3vtSopVO0+C+VEnO0CIMhObMZrjzoE8VMjZtl0QmVjejDkb9i5T2r+RivvPp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZrAk3ji+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B57F6000A;
	Thu, 10 Oct 2024 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728581952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdDg8pgo6hxWE8qqCsve/ZQum9OXZmVcmDbzpy+h8Pg=;
	b=ZrAk3ji+jOXeFc3tXSg3rJJgXDgGWzmbaB4fvjO8VMgTE2NSoU0bM5v0YZ8Kesc2gHZF6n
	GK1ZzLpGurlcEpMFEOVH7gSikB7cilX9IPWlPa3gpxXpWvcLUyrF1JMH0+AoRCHOdD36En
	HTe8Yd1ugM58/Qhj2X3W4umfUbUX2cN229B7QNSbm+gBkPeU9DbV5WI2U3hWB0tfxNG9Ix
	z8j6KhdZ1ESHA8wrENDP0Tu7LYpuVjytSMnKUxbsnQFoflOCItvLVMKLpblc5l82E5lKS8
	oSVlUOOp/DxcyCclJtbodCwitwUDq+jb0TZAi6rHDq2gU0gAPGZsyTlgamAsGQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 10 Oct 2024 19:39:05 +0200
Subject: [PATCH v4 3/5] drm/vkms: Switch to managed for crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-google-vkms-managed-v4-3-ed04a62ad2e3@bootlin.com>
References: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
In-Reply-To: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=PQ87QRrHXXBxQiWqyj4h93dY9Re2kRrb505r5//jqMg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnCBE6rkwcXhC0wI4yvPydsQ7G04/qbmhQNnmDa
 aJkIqgfSSyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwgROgAKCRAgrS7GWxAs
 4k2FEADVySM/u59SKXvJ/mNkpg1otkqm1srqB1zrYRlxmAZwe2SoemXQMC7apI55CTX01W7aUvt
 nY/ZqXCjvEI/+1Ayk9Q00OsCGDY+GhpPl18TmFWwYg7iCEbZuWmnuekIuE50mb8EN4zITuJHqss
 HqNXfPJcDVd5B66pvsKkywy1MQdnHi8UvBrU609jpWBKcQlW7DSicIxBiwybhe/oSFQkANYMBlR
 6X31IBsqbaUlCbvOBfNFeNK4OnH57lJWSLZnyR1FqrUJhj/WyKtxSQhl0XbjP3xxeG4NaPUUk2G
 jiUg9YNe9qoXsCBGo773zNpqvhlRzIQcZUz92TMmst3Uw75NUdr8OXMI3VetIYXe8F2mR42C+FH
 Kqqk0/t6mutFcN70uxxDncWu3xUFC5+ycHhSkjVoEzyej8IJ445+IDFUeQJCIeO0lG4Q9xWPwb2
 d0b4tCF0Goo8NORQCx2SQb0o5Rv5sb4cTX6gv7eR9fK6PmQPBujQLFSZ/fCylKiOr8hkbczmG8V
 vWHgita0ApMpzxuQP8ce2kktAYRaNVMw/+m9w0N1jPYV+fkvG3Fjr9AXgptfBqLcn31Ru8llwT2
 tHrP0f0kDtiOghx6UzKit6DNDg4tbqwmW/b8/EV3h4NOekjwjWWvSsJxF9dOiRmPBHpqctLg7R4
 svcQao/vqc0GgEQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses managed function to create crtc, but
don't use it to properly clean the crtc workqueue. It is not an
issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 14 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c  |  9 ---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index a40295c18b48..877877dc0af1 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -6,6 +6,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "vkms_drv.h"
 
@@ -274,6 +275,14 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.atomic_disable	= vkms_crtc_atomic_disable,
 };
 
+static void vkms_crtc_destroy_workqueue(struct drm_device *dev,
+					void *raw_vkms_out)
+{
+	struct vkms_output *vkms_out = raw_vkms_out;
+
+	destroy_workqueue(vkms_out->composer_workq);
+}
+
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor)
 {
@@ -304,5 +313,10 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	if (!vkms_out->composer_workq)
 		return -ENOMEM;
 
+	ret = drmm_add_action_or_reset(dev, vkms_crtc_destroy_workqueue,
+				       vkms_out);
+	if (ret)
+		return ret;
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 0f6805b9fe7b..eede3b8c70ef 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -54,14 +54,6 @@ MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
-static void vkms_release(struct drm_device *dev)
-{
-	struct vkms_device *vkms = drm_device_to_vkms_device(dev);
-
-	if (vkms->output.composer_workq)
-		destroy_workqueue(vkms->output.composer_workq);
-}
-
 static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
@@ -110,7 +102,6 @@ static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
 
 static const struct drm_driver vkms_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
-	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 	DRM_FBDEV_SHMEM_DRIVER_OPS,

-- 
2.46.2


