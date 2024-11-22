Return-Path: <linux-kernel+bounces-418555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193EF9D62F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEDB21483
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504D1E0B67;
	Fri, 22 Nov 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="guAscFtj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498B1E0087
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296034; cv=none; b=ct6z2rktL7GlcV1GVrI3sJo+lBoa+Uw7NDaC5NkHwhvcw7ZoYMu6npC6ypkxxUnJqabx0dK/hlhERKUce0hapSigo3QFVWGWUinrMZctvuIHrEig/zk3fIlyoNgXJWlhFBMxDZ9zP56HVBRVa4CBcB8rFkOHmgyCqAIfmeIP/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296034; c=relaxed/simple;
	bh=XPH7g+AmIjMlHLLHQSbiTuo8nFUzQItzE3jlEy5xM9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6ZikKSjiEHNB3ANsn1MlFVXVfXADD4beAzeO2adc+oBEaAMxH3ZKc7cMVklRfQK3vbuPoUbKT/dwLq+wAX1CTtSG07E+YeZf4kGSaXtwUzZHIGP4Gb2FYgth2DUyaFqNCgn/WUES1y4UYQq27fqPTn/I67PLD0g/5so3/Q4y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=guAscFtj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26CB11C000C;
	Fri, 22 Nov 2024 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPjoDbbnyRr8NB8CQTYsw04Lz1RI3/dvKXG1g5TXNeU=;
	b=guAscFtjUM5GWTCaMvjH05hO+2BPd06hoQ3+8ckboIHNlY2LvEyzyKH7C3+0NDzAQ9/zCt
	uLD4gLQmo1HcSODPFcZDsVavZ1NxeGhBCGr5wNGv4gfw2x44k4JTcoS/n9CLWmNwiZsdxg
	ajK0L6ON9e2ABBdnRB0tazulxjak8BoAZ6snqWRHouXQ4SriP0dtXrn9P+8yFwvXh6Co60
	AU2Kml+rrJZwxeargv6oHabLKpG3PNpWuz4fipuVJTfy23Fy4kQUKgOysh1rXcuMfKjtms
	CUNM/RS3fjMXSfT4mdrlFb8tJcz4HtyzOgPt2LJtb39wWDC15cXBBh0ghWkmuw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:15 +0100
Subject: [PATCH RFC v2 11/18] drm/vkms: Introduce config for CRTC name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-11-81540742535a@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=XPH7g+AmIjMlHLLHQSbiTuo8nFUzQItzE3jlEy5xM9M=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1PdImx4wMcOGyY7gXf+uKLYlrrpEEym4oWq
 P349JzMu6OJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9TwAKCRAgrS7GWxAs
 4rmBEACowjbfGf2hpsh6W6gtRuxg7jRi9OFoNB49utSwzHIu9NQeCdubJ5A+j9lDEPoGxEA/0Zv
 NIhMzd/6pY5OZeTZs0LkDFV/QzsmbRkcEoy9yr2emPy3xgcYEEoCjK3R2Mtv1UXt68O2S7RwaYe
 YlOkB51CjGzLY0s9eEFFQNKEE0TsGGymiLRxwqJ2XfDlC5yOmpCh901ZJ515S3nEsM0pEimMuj/
 c1m43ptqyLLng0ekpSHN+GgW7jcp+/BBEz+FOrNxmw7/269Xjxcj3Bt1O01ZEAxKyfHOt/Z7tq9
 DLtqZb9TJDaRRqJbGJyuwVDuvjOEoo32e4i3K8puhF4iL7T3IXQ9rOFNR73J0JvmeLLZrvezxXM
 cbqMP5LqfJ9QYQ0gOle46mP15NUb2OA8aE7rDzFxdh2yXlMJn6Dp5HR4AV3rWAVr62zrkAOsqD2
 ne9nQ2Si/iTvD26SP1UZh7qteb9L866opG8eysqtSlqiYnqLl//w1BislyXhDQPXQXkW/AHnz7+
 M6KIdEVqB142N7yb2VJBJlu56Pzo7lA9pN3zkEOZ5pRFSm2jo90zXG6Hp674qGj7Y3SJyUsvJwv
 20XTQQL22fYZ6XvREZBS1eiD5w4OSatuDigDnUpnWA1TybGG0Us9y91v6aF+BQ56/VtGhAd3xU+
 VClVQRKcvHk0OIA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As a CRTC will be a directory in ConfigFS, add the name configuration for
CRTC name so we will be able to reflect the configfs directory name in the
drm name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++++
 drivers/gpu/drm/vkms/vkms_config.h | 2 ++
 drivers/gpu/drm/vkms/vkms_crtc.c   | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a2539fb56b602569b75748fdf9c4784f104b0bff..3252f657ce515c0193a8c0e709bfe861feba0aca 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -37,6 +37,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 	if (!crtc)
 		goto err_alloc;
 	crtc->writeback = enable_writeback;
+	crtc->name = kzalloc(sizeof("Main CRTC"), GFP_KERNEL);
+	if (!crtc->name)
+		goto err_alloc;
+	sprintf(crtc->name, "Main CRTC");
 
 	encoder = vkms_config_create_encoder(vkms_config);
 	if (!encoder)
@@ -219,6 +223,7 @@ void vkms_config_delete_crtc(struct vkms_config_crtc *vkms_config_crtc,
 		}
 	}
 
+	kfree(vkms_config_crtc->name);
 	kfree(vkms_config_crtc);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 4223edd94ec270915dd658c0b5efd489554d33a5..4a4c16dea7855cf36060986ef247be698974fafc 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -29,6 +29,7 @@ struct vkms_config {
  * struct vkms_config_crtc
  *
  * @link: Link to the others CRTCs
+ * @name: Name of the CRTC
  * @possible_planes: List of planes that can be used with this CRTC
  * @possible_encoders: List of encoders that can be used with this CRTC
  * @crtc: Internal usage. This pointer should never be considered as valid. It can be used to
@@ -38,6 +39,7 @@ struct vkms_config {
 struct vkms_config_crtc {
 	struct list_head link;
 
+	char *name;
 	bool writeback;
 	struct xarray possible_planes;
 	struct xarray possible_encoders;
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 3825fba57c012f84cbe67114e053dcd7fcfa283d..25a3d97a362afd0d40f3e023d9cce985d447a880 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -292,7 +292,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkms_device,
 
 	vkms_crtc = drmm_crtc_alloc_with_planes(dev, struct vkms_crtc, base,
 						primary, cursor,
-						&vkms_crtc_funcs, NULL);
+						&vkms_crtc_funcs, config->name);
 	if (IS_ERR(vkms_crtc)) {
 		DRM_DEV_ERROR(dev->dev, "Failed to init CRTC\n");
 		return vkms_crtc;

-- 
2.47.0


