Return-Path: <linux-kernel+bounces-418501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F79D624C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A31116066D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D151DF973;
	Fri, 22 Nov 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P3HKZDtA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2B15ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292893; cv=none; b=iAkS6rZC674GFFNZvhuqbI/bdwW67FbyYZSja73S9D9kzid57GDOaqX2KjvWZqUAbnCGz/myF68ScU2OwmN2vFn5EOz1P2tWddIo0aQv19iQdNm9bod8u3aIZqeJ9iq3QWKDD3U7KmtXL9J05wUX2D7b2os+K25Ng2G/ZnsN9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292893; c=relaxed/simple;
	bh=IeQtyAkoL+fPJOYGNUGaUHbisJKJpYsSLjkQcRf+0qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUbP3CiIqQ/Ai1+OY8Msmh4K/7TxAsSe6U4FpbrYmjtLWjo4nRHAbaJPut/2eK+9NbbXom+nm9PqdgmU8AS5MF1zbhK7uVN4wIsmomv50awDyyvC9B0SsWVNIvn0/Ei/ifk1xKYbSBb31C0itZK8v4lRULlxOcLLdaMU7W4x+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P3HKZDtA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 759B1FF80D;
	Fri, 22 Nov 2024 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+R80H/JRGfBTVoDp2ktoWF3096dmo8Cz+WCKV/JNeI=;
	b=P3HKZDtAeF3p73ttTBvl7KN37/DgmHEjydvoPZBobuDHBDecrd26TAWNVLTMxAgk71cDWy
	N2JRUuqE0VAcBdh3IJJG3ZsLW+0ojTFBSjJ7iTONVjRHkL3hIXEP+LvS8g5oGENqmaGwdz
	k81oMDRK1sv9zwWk9NHKKfAyHr+exKwapFyZfZTqgJMg4UzwI2Uk2XxnIgGFM1OIfwAg53
	hrZxiEcXngWM8Ujn/qqkEwA3IaUmmKJFyZ4Hss//cJzGwU6+q8RGT7tWPvGCHX2gGt6D3/
	EaOCghLG5jhACc3Jjm86bnkLK/B+dnPjzs+nfj8p/IRD9KuDS4xa3HXbn5gMJA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:27:58 +0100
Subject: [PATCH v5 3/5] drm/vkms: Switch to managed for crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-vkms-managed-v5-3-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
In-Reply-To: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=IeQtyAkoL+fPJOYGNUGaUHbisJKJpYsSLjkQcRf+0qY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLEO7iec3QJLdf/6qBQy+AY+D3nvFCKHNjV66
 tOUMP8oH4KJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CxDgAKCRAgrS7GWxAs
 4mt3EADBKFj4a+geowtri1oJYj52IoFc11iL+oCYV+m7llgPtlZm0TRcqn21AKU6KBLiwYyr2Ap
 ImnZA2LS0jq8YhbULBbstgaaS7cfIo7nL20mlxaK4NP7RUO/cjGGKh3iyks0PUuo8oEzUW5FuX/
 tiKVB5s6VDXsVa+rJrhZAM+NeFFblW3F1Lna1QsyoVF9FD6xpgowUs4VfFPK0hhqx+VKwwGEm+m
 VBsPApdT/x9XIeayK7UaMtoYEGckEChQl7j8Q6iuGZOlC3PP28KqMtY00XMAWsX4Y5RLGDGg4CP
 sxtbYaJ42FKC8BywcXiux+eLtl36lXhQzB9ZvTj0HtlszEmldNNM1WwtJyWHEJtmTBxhJBftacm
 U06rS4nxI9d2uCASJZ/oTrLS6NkkX/VMuA1GTcc47tG//ygBNXifuuaQOY7U2ZiYnIzAzivTAXB
 5PuIhHV4ENh22Umq17godTkyTy8698AJBF3wXChDe3coLCo0tCl2HXKuPIoOhyp7SGEFae/LXpQ
 brwzRXyVy2iSVaYtNzVsrAETd06+HhtzVha6rKCWBUsIAerw267+3sc62+qUnCnvWchPrOvxLWq
 gwqXMVAmho4aS2RMe5JF1WnbCurlXm1wyOvhRzE0kvygnXQvLtTwJ5UIWvcQo8EGeyt6WpTJGBb
 thH22oxbI2EDcyA==
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
index 28a57ae109fcc05af3fe74f94518c462c09119e3..ace8d293f7da611110c1e117b6cf2f3c9e9b4381 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -6,6 +6,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "vkms_drv.h"
 
@@ -270,6 +271,14 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
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
@@ -300,5 +309,10 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
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
index fa3331f612e34e0a48cef34effc169dea46d77df..c54504e590a18ae8af07cc1cc48179c38c4e6c0f 100644
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
@@ -109,7 +101,6 @@ static const struct drm_debugfs_info vkms_config_debugfs_list[] = {
 
 static const struct drm_driver vkms_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
-	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 	DRM_FBDEV_SHMEM_DRIVER_OPS,

-- 
2.47.0


