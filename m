Return-Path: <linux-kernel+bounces-359639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23561998E72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70819B253DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB419D89E;
	Thu, 10 Oct 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O0c+ilKA"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EF19C540
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581955; cv=none; b=cyF3JZG82ap7QFbWqtSXAdQkrYlsKKtaIjDeLYleUw7+nvaVX1bFHaNXWPZeHxflrV8LcH2SDqB65Dq3rqXbD5K3dWEEoMp6Is/Q4WjRl0ymapUA8YlZi+8xZ3wyXWEm70Bj9jyZ0Hb8h+lgPCQD/t49NdItXePu5jkfxLs555s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581955; c=relaxed/simple;
	bh=yGT7SN06dK+D20p7SLaCpw1NfHZP91hoKUuigEH3q/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaI/1SxSVJEBQAjzg6oe6oO3dmTYj0sRdtFyaH9vjx+nFonG92bX5Q+MpJG+W5tUeozaAEjm03fIfgugtitoNEeON/uzZTm2/fP52xwYpGdT66QJeZftUn5BBoycBww8LSut8RDjOpyl/dKToOSYQ3nFyMsrGX2Hrtj3WyQQq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O0c+ilKA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64E3F60008;
	Thu, 10 Oct 2024 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728581950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PipLqVj5xkPyoetI+WW+1rh6cTZU8H1AKdi1jQjRa5M=;
	b=O0c+ilKAYO2EoXB1uSLrU/N3TfLGIVCeIHqsiZOFnhpSvzvj1GTfBE4DuBG0Q1SX1vXuEb
	EhZPtRKn9a1bgw2WQ8CFtFfp2nUK7GaomWUKHX5c1da7Y8mAxJhRCHzy/cc8HD4SYV00Uq
	umZqCmM/DeMTQTlCZjyc2cbvAXQlVapFH22yOiIDpgjuRZVLBBkcT4wLIc8f5LImFTjzem
	iYOqbR+DxmP2zx00M9V44Bg1OikZlU6iu/Cx71d+WREgJmHEFPG6H010mgSR6h5Iggw4jb
	cGP1z3rXvAjUtPtisuPgnUDdiIhJOxmKvdxdvJRSARs2ZcbPfOqLDt6DBJ0GZQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 10 Oct 2024 19:39:03 +0200
Subject: [PATCH v4 1/5] drm/vkms: Switch to managed for connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-google-vkms-managed-v4-1-ed04a62ad2e3@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=yGT7SN06dK+D20p7SLaCpw1NfHZP91hoKUuigEH3q/E=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnCBE6tqLjj+hV77ppmvzkLCGJ9MGEV00I36IHd
 JTVOpsiIKWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwgROgAKCRAgrS7GWxAs
 4mhYEAC4BNUA2uE9CRw4E6NhdyIzgoE8pbSNx0a2/8CWVs+PwFq7xFfhLiYbie5lzQoqCG7MZhd
 qyuCzlu3nI1S8UvqCna17vnWI4Mb8NApJC5HF6/7QUb1M/apzMaez/BxAocBB5e6F/PS6XsXkvs
 VJWE9wkdznY3YazzQrQzKQariO7TFZhqmvHSQlaelNz9M/PFXj2UfUJd9W7BinUbvxhnZkyOeQl
 gVRPTctHYbKecPBBCgab4tNHUcYBW/LP914KhetGUJcXkO/7dRel4VFOUfJQVEaKBxeFtWjFu9R
 bhONIHzuheAHcxv4GEFUjiqdnAm5xIA0u5nl9w378zOxM/fNBkyr++cf58yrluqevg0AB1ugNIr
 8USzW+/n30jU8wpaaTGs2nNH/McCerTB/EX2rNffIhKUDY8phMgH51elPD5rXgX00lQVdDVM8i4
 2ykZQlK6SD6VbC8DmXgPmyIYuf8uFQzp+EEzmo2Uv3LwBcSty5M56e+RVS0OJH0QN2LPMfutnq5
 LzX+IZKrPakAYMv9SPf+i5NDS0HeLS+TNyTRAbeR//OfL3vNah/Oaig2/8ZXW5AgDSuqu+hjBqr
 5LjnyACYMjsbA4srYBevPj7YTQWNVRnsv4HWIqTE6D1IsNZqMWmtGr7YaA0kyEegXjwF5/gj+3b
 tWcYzLwrh/wDrvA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create connectors. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 5128aa3b2eb6..8f7a05b73e1d 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -3,11 +3,11 @@
 #include "vkms_drv.h"
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -70,17 +70,17 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			if (IS_ERR(overlay)) {
 				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
 				ret = PTR_ERR(overlay);
-				goto err_crtc;
+				goto err_connector;
 			}
 			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
 		}
 	}
 
-	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
-				 DRM_MODE_CONNECTOR_VIRTUAL);
+	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
-		goto err_crtc;
+		goto err_connector;
 	}
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
@@ -89,7 +89,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		goto err_encoder;
+		return ret;
 	}
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
@@ -111,12 +111,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 err_attach:
 	drm_encoder_cleanup(encoder);
-
-err_encoder:
-	drm_connector_cleanup(connector);
-
-err_crtc:
+err_connector:
 	drm_crtc_cleanup(crtc);
-
 	return ret;
 }

-- 
2.46.2


