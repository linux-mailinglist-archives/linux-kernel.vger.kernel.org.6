Return-Path: <linux-kernel+bounces-418546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA039D62E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB812826B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B61DF257;
	Fri, 22 Nov 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i2yKyxRN"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841D14C588
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296025; cv=none; b=Fn0VUbkmiV1GRQdzEgKX66071MKW9ckU3ABSg8d6hgjnMqQ7bq9vlnoTaQKJ48Gm1Z1fTylExdy2JNxu06lbcIUn5kRh8ortral/0rJF3WTn0UbayOmTddcauE+vXfC2Ih/djPIknDRQ/VjzcjrCqQ49BmvdAKgzZiZ5wNx/Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296025; c=relaxed/simple;
	bh=O3J5NrNzQvmEMPf1LtkrT4Rjj+8JjoV8IYUZ6CL3lbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCW1euAbRZMid28SiigPxe/1X6xCfirTxF6W2XjPwOPGwkHP7PJN7mho8POfmAry3HQkm5b4bUOgFIwDVfEjFVG+GUTedrESCwYW9KsFl/HZSfkXvmSg9beOi+1Mnwf+bGMGeHYaoZKILH2F0mMq/oRZyfypnEiBXrUAjIhGY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i2yKyxRN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 363CF1C0008;
	Fri, 22 Nov 2024 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVbsawSCI+cNQQUSUvFQ3M/hXSyx3BQzl3u4EwEAYsM=;
	b=i2yKyxRNkA8zlgpt4Vx9R5HYP124E8d8qOwRY9DJj3oX4TBsdPQOQWuM5SZTtBEpVKWXCR
	DN5MAFz+KUCJM/mim1hb2C5EwABjyiy2mHwIaJlQd3BjAQURiJUGmilHnZxv1plyhG8qQD
	YmPwDPRolcBpaTwFvooSPrfCNSiNyxZjO78MyyOJaOstJRFFsgIvzoTwRJWy+YH1dx4Q2E
	7ZHUFHokQWEQ1dvWuB7uobKoiK0cmw/Ghxypc76fJq1NvGL7FImUppPRKcGBYkAKMMGJ8T
	oyN1oVAkwNhvQSrBTZGvZqbx1K/EkLWWpC1MIWKD3VbcuQnJwrJBQX+yer2ZuQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:06 +0100
Subject: [PATCH RFC v2 02/18] drm/vkms: Add a validation function for vkms
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-2-81540742535a@bootlin.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=O3J5NrNzQvmEMPf1LtkrT4Rjj+8JjoV8IYUZ6CL3lbA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1MnCxUSxlqHgS2+RV+OlFmTNtbD4x5DjcG2
 CHAzu9HNz2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9TAAKCRAgrS7GWxAs
 4sIcD/47MVc2OXG42yiTwonKS1y4FWPhPH2tqUeYs6tc9adNIDB6yxBSOAk3okR6Y351kiT6ftx
 ILcIrn0nsd1/LwCPusB6srTwSwR89iubAlka4IAkhkpSy3xYKYgB0H5vvkbjaPLcu0Ld3IQkr1E
 hQRakfEXiFWZxioqcOfxKnbxYzCc1jrS170TPwbFrCCFIGSKSHNAftA4TsD2n1kQCUt6qCoucKT
 jAGC8Xoi95FFJLeRzbuVJaWd3xG8SXco38vJ3JOieYkCKV/66F/ictu8m7GwYEv9LiC+LRSvIQy
 VPLTGX3ilRRkvhYjmpjFVfas3fHTV7jr6pGRQ+Id6x7VYOGlV3pQyCtbXybMHQkietb0HAJyU12
 2hazC5R7qKzbVIUGAqtxAdbn517gSGvjGpmJ4yDzphT++4pVx8QjRsCKu+yiX5Ldtyjfyo7SwP8
 OVnfBnNimOH1tvskjVpvnYVNpfVNiID6J8jPb79C0ll77mnnHcBb13o7Blj/zzP2BNc1uH8A9W3
 FEVfJCQzW3hVRyLf3BDJolPGsok7bmS5VDu6RmdvzrjFIE8xGGEGNJzknAMotqoPgnqW4vFQUGk
 R23l8PqO/uF3F8TKmSUJtg7I4iFIjQxTDsk1WBoSKe+buaesLy9F2vFaGxjon4e28NWJ+C9QlIb
 Zuggc+RP2dS4Osg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As the configuration will be used by userspace, add a validator to avoid
creating a broken DRM device

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c |  6 ++++++
 drivers/gpu/drm/vkms/vkms_config.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 76355174a6ca54b880218c2bd458c8339a3dabaa..8d5c1429e6e196ef46c95c6ae73330bc4be2be39 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -24,6 +24,12 @@ void vkms_config_destroy(struct vkms_config *config)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
 
+bool vkms_config_is_valid(struct vkms_config *config)
+{
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
+
 static int vkms_config_show(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index b284831738743f6d7c452be03f917a7d3975d173..df571dd67352ca90fb47bd937fb9f11ceb95fcb2 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -29,4 +29,17 @@ void vkms_config_register_debugfs(struct vkms_device *vkms_device);
 struct vkms_config *vkms_config_create(void);
 void vkms_config_destroy(struct vkms_config *config);
 
+/**
+ * vkms_config_is_valid() - Validate a configuration
+ *
+ * Check if all the property defined in the configuration are valids. This will return false for
+ * example if:
+ * - no or many primary planes are present;
+ * - the default rotation of a plane is not in its supported rotation;
+ * - a CRTC don't have any encoder...
+ *
+ * @vkms_config: Configuration to validate
+ */
+bool vkms_config_is_valid(struct vkms_config *vkms_config);
+
 #endif //_VKMS_CONFIG_H

-- 
2.47.0


