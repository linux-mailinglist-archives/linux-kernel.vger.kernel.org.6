Return-Path: <linux-kernel+bounces-359638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A66B998E71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD5C1C23176
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D919D09C;
	Thu, 10 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oMI/eq4k"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFC19C57D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581955; cv=none; b=crAMNhAElfTamCLzpZtpadfiH1ETqbv6/XI5iHUA5W55Ifyoo+37shRzsW1s+FQ/zczVS7AQGhadAx7Z7WwsLiu0iMSm9xAKvhTXV04cF8pFXGax1sClyikKbJ2kSPlHaGXpMNckpNGAH4nL0U75X3mf8TY+Guqo+2Z03PVjcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581955; c=relaxed/simple;
	bh=mhiDPGhfqrZUTw+u0l+InZGIFZ2Tudq0ZIqg2HTKL88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKsiLV4SQhzR+Ge0itp3Q8VUB5JSbUN4DC4mDo1CH0AO31+dMxS8/bVA9NzIhWbkYk8HMSrMg4/AoP8k7GEaUDLtNrSO0/yaFSti7vLFmiRMeVPUO6BfAi605Ls7eB3PS74vPkDH52U5DjD3oCHEjgfV4h08I/gB4M/vX/BTCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oMI/eq4k; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E44060007;
	Thu, 10 Oct 2024 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728581951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjqHkT9IVEOJZ1uSyhzJbsiqfoK7bqwM7inCqaTi0g8=;
	b=oMI/eq4kRM/Y305f54zMQsV9xROVNOm/5HHKXYp/Bn4sqqe2aorG5GKR3GaXUYOncCU3am
	WFOyCrZM5hY5dj8BCuvrEH1a2xmg0cE0X/Xe5pailD5W7e/E5DyTJYDhtCIKs1CDSDYUPy
	A91uiYaPq1AVwtcSVERfv0NpkYStYE2GPv96YTCv5s40R9NlTzhE20Ay0xcevPGnrfWBhP
	YOkb5xTc5a3h0KrEZVp2YMr/U+J6mnYFQAw2iX8UM+y8uunCXI/v+qr7Jvom8w9Sj8zJfK
	YW3gC+rBoIn4R8s9nnusVoHUv63OfoYWg6GNy9luxdzd9dudQ/s7+sXw/GleGA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 10 Oct 2024 19:39:04 +0200
Subject: [PATCH v4 2/5] drm/vkms: Switch to managed for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-google-vkms-managed-v4-2-ed04a62ad2e3@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=mhiDPGhfqrZUTw+u0l+InZGIFZ2Tudq0ZIqg2HTKL88=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnCBE6rhwAbsn3Aq7NZbw28q7NmcApSw0KPn5q1
 eg8qhN/jpGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwgROgAKCRAgrS7GWxAs
 4rn/EADAX0SkwsxcvfzMRLwSP3AtuRTvVUt5ftggSW6KZVW1vyDUPDZo1126msRZ7UTpOpwSf6L
 Ym03n+ycyoXdQ5vepCE/63VJ2T+hIHgxqJhGSb3TZNfD0v90uMT4FRNJP3/ul9m1bzP0gQx+IyS
 T1niFn4YNjAcn1tDVTMRCFGcvV3e3ZVwumaGwa2Jx1OhT8kxXs7wu7ApSNlPzL4qE8VQxq1ub+C
 L2Bewv97AWz+j78HRFdVJaNprGoLCAsC7h9WUzht4o2dJEFI5SnE/pkRoGX9mj488fi4Xibx6sx
 OkaNwcOQX/mIFiUPcLc7lBxbUcq9yPLZdSsSmJA2e08NSKrnksRVNdDHXzyO7bN1J/BfkkYO4Sp
 ZeY/BkkIfqKkvpvtasuDeh49Iqbf0R39Y2LZ5kvAipz7BRcOfY9L4aLn/Ip0z3v8IY6B/T824z4
 qzXJYYL1WUb12J58+ZsKzQTL25fHsDRhvx2oashFwo2k31a6pJRAQ6pHypfjK7yOQR33yHEjgEA
 15VLYYTdj3M943EukYRlRcBXhnYuG3tJwzEB7RH7eQggHGqsDKO5gWqdReImnOpzmgo29D+uqXc
 u4WRv6CwogR9Hcjj9fRl8tT0pULMjT/pQRhGbhMfmk3pFrqsZBq1q2nUvPJThQAz2GUcv6Hayg8
 o8sFcLWvkCa4LaA==
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
index 8f7a05b73e1d..c878b2843d05 100644
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
@@ -85,18 +81,18 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
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
@@ -109,8 +105,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	return 0;
 
-err_attach:
-	drm_encoder_cleanup(encoder);
 err_connector:
 	drm_crtc_cleanup(crtc);
 	return ret;

-- 
2.46.2


