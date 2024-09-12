Return-Path: <linux-kernel+bounces-326587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2ED976A78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FF9B21E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C951AD251;
	Thu, 12 Sep 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pE4xfwPS"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DB1A76BC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147529; cv=none; b=eH2mP0HZyjJeJE6yHoi8mYykAMSFUOCs6EGMTkt3Kw39d5gRi6dCQMJL21KxBxm36f3ZEVnQN7iBeZVQRIo8tX9ro8EKT9yxZdpFa6Ia0L06/p2RpriyGiZoSUjQkGKCCqxNJiyk6iuqG5KpRh4TU3TXcN7Y/CmwPinXNIC6fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147529; c=relaxed/simple;
	bh=bM44tHCPJrHTE+kJWXIrV417+Q33Eyk1EOPqV9M8sYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kz+7hIKDZM/I+qqhVvhaWOSBt7MmDRjyaPQX84coBhJYBLzXFFJmTX3gQN9F9UVtJo/wzsNwdRKpxf/euKPl3dXE5GPF9HJ0HAsXlNfssHQDS22zRroqrA6LKjNG3Vl8HbhF6s0gvnyiCgO5TBm/xMzlrSB60R/zR4qnLEvy558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pE4xfwPS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EBA04000D;
	Thu, 12 Sep 2024 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726147519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZU22e0/TQ7MJ3yFJWCIrZsJEcPRhtvo7WlcHoOwghGA=;
	b=pE4xfwPSWQF8+5sKIWJgXqjsCbLhf6rHdkZk8qWEKLU7WXh3tYVHhUDuWjYnXTUrCeQyQK
	FKgaEja6Wd0heGeHtCapItx6LQMiuYmIm1rRlN2wkf4FGjIDXiNhwDsa/ZvkPkXeI4N7PJ
	a+idTvgnN/mgOfy/qIRi0uAz+n9eQxMFUK492Toz8dNM18WvZkT0m41ID9Xnqx9zSs15x5
	MkLzRp0qfWXFE2RbrzCwwAhx0/O+AJtzvdN8E3sM3uc43El7WYv4LNO8eT1Tv3zfNEf/Aw
	jPiWMSLj2efTiz9N9BZvEKyb8V7RLJdkrQKcksIcRs6SjETvqCs1gZ+Sp2B7Zg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 15:25:15 +0200
Subject: [PATCH v3 2/4] drm/vkms: Switch to managed for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-google-vkms-managed-v3-2-7708d6ad262d@bootlin.com>
References: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
In-Reply-To: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=bM44tHCPJrHTE+kJWXIrV417+Q33Eyk1EOPqV9M8sYw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4uu8MZi6SumIboPrHUhfYXcn7YAGOwxchgcz7
 j88asy8FWeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuLrvAAKCRAgrS7GWxAs
 4lfoD/4vF8usdGpAQ8dBZlkeDh22CqCZHZWgese9ruXdDPEPx66ojjzG6ml0/JqSRQbUYhfMGmp
 1fqEUKWnzzM1+HluGxIJMX7HWwpKxtQwAeHNJ8taFYHf4FnVrUum6btIGh7JCVGWOfLk+wSPBrU
 8c9u6kwVq0A1IftCfxjCFr2Jq5bNBH/cRcRKxyxnZRpzdEs9hjaz9kpggK6/z054hV9LwhJP6ww
 8vVojV95V2qfTMyEqQ6raC4phBi0tNJGBywS1IYLxL93KsW+67L3HZzvkeMNP38NpnvnhWoH5PY
 BevSUh+/P1I/YXUAjOGND19Ng1eCy00x4xlUs/qmEogjCI8vgiYyNLVjkyzz23IVXikh31aYIeP
 aHxtkn7i/HydMXgF5ld/vl+VxunsDAdm+VK9HNVFA1qNkdHt7Fm+muYYF2hQmwwrxjXerbTx7IP
 5ojlHZ3lnZiMTV2A+MAiefLR63MkotXw2xp2+EIbSuBIaJHStZKtEjdRijADs6hLkD6P6kX1KXp
 KZBfgkto5YvnL/CkNtC2m5/kcy9nOPwzm6py6mrfq4gdf3DZjNPw+9p1zSXsewmE8qQ5pGBPtkE
 zsHFzqORqw9alw3MDqPiem5nvw+9PwjIpQ7Aj5PYlSakJVXkTSrrRsCD7G9goHgjs0H+gvO8v4j
 LmqG50vr6K4MpMw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create encoders. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 1a445a4ff6ffb023a1c1ef7e141c771277146251..2226ba1972f3ff51483abacac45ee8914be0c94a 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -13,10 +13,6 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static const struct drm_encoder_funcs vkms_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
@@ -75,18 +71,18 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	ret = drmm_encoder_init(dev, encoder, NULL,
+				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		return ret;
+		goto err_connector;
 	}
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
-		goto err_attach;
+		return ret;
 	}
 
 	if (vkmsdev->config->writeback) {
@@ -99,8 +95,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	return 0;
 
-err_attach:
-	drm_encoder_cleanup(encoder);
 err_connector:
 	drm_crtc_cleanup(crtc);
 	return ret;

-- 
2.44.2


