Return-Path: <linux-kernel+bounces-326585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C6976A76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B392B1C23846
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FF1ACDE3;
	Thu, 12 Sep 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CDPxMND5"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20421A76A4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147529; cv=none; b=Znwj0d36p3pCBAjohq0oGaBa3M+/tS7LgwAdVVxA+1KD6iFVvw+9+IUFPyeedvzBE0f3NNCJuqAZ8hlbDpwmiv268airCVqG5rtnPI/U/aYk776JZMyDu7d1tng5P/MZb8QOA8TaWEVcrd5FTWpkCloOnk51/nRGkF2jW9eMbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147529; c=relaxed/simple;
	bh=tR2Pek6p+Z1Y/CCm8gFsRbPMfMtJuv7bIWglOMvOdFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANFhyeW1HSqOzAlGsgWQFevg4yohByRkq8mXebojq6jwRmc/VxuOCiOZBeBDbfeeZrVgR/Nc0lzc7WSk8Xkmx8UWE3c5iQCISMWvhqxbtWgGNyfmIUhi64p5bUwTTea18FgN82uspPlOxJS/btnt3EadswNA9eGrxy7ohgRoPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CDPxMND5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C4DB4000E;
	Thu, 12 Sep 2024 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726147519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g34sFbJmZ8FTG/UCaYFEJPYIDmiuCfsWD/gVjbMaAdU=;
	b=CDPxMND5j0TvekZ7GfQb6Q4eErc9oQOrKXBMi5VzM/nUFPkNvszOHgroEjeaeXKnRljvum
	gliUHLfJFJv25uBKyXu3VhLovVOVFU1mqU8C+SjABaZdH+P2KyC75JnUSMup8WjAsTtl5g
	Fi06l5V5mc2s+xB+SplE1VbCblfkbMgwgbMKNYsh2eR2Su430qE9prZeb+hAcUTBpIwDJ9
	u/Cz1ArUw255ldp+H7NZUFCQpYYjPsBksNdvn/ubwhBpLLfj5GGzIVlY82bkeIxVd7Jnhp
	wRtfSVGaZvvVigDQ47YuqnDmfC4N2Ho7wladFa+rJuMBvDAXCYAimCqVyf6mSw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 15:25:14 +0200
Subject: [PATCH v3 1/4] drm/vkms: Switch to managed for connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-google-vkms-managed-v3-1-7708d6ad262d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tR2Pek6p+Z1Y/CCm8gFsRbPMfMtJuv7bIWglOMvOdFY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4uu8q0Cm3Vmu3KFO5KNH6YiN/uDaU+NLuFMQc
 NUoLZjbQTCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuLrvAAKCRAgrS7GWxAs
 4j3RD/wML80ppF2mUtV6BVZUfH2mypdVpWRaTp5b/JqWTEolEgkZV0LbwOwtv/PWEK3UU32fF5J
 5rrUB+YTUUBS5fopmSyuAn7opZJd/2fJB3hdjbQkT6953w33W/1eXloXVPj/Xn7tKQUzWW562EK
 ggYuwvQyd0H6VbxNC9aiHI4/OEopWmu8KgiL9lM5Pk/S5v57jNo+E7TQN5zGkWL5rLZKWTZMHzs
 oFlkY1zTrjJRtJxI2pEeLfmPkQvCFm7hEX3wKaXF7CZpbSS0MiosC1AUcRp8sw80zmZFBmxIhXc
 jqS8zzEuxuxTykQ0QG2hjtGTPKkadLM+VatZokFrx3yJNg79+vIFdFIA75Auw0rZNU8t0s97MYT
 OF9uecZRmTYKyMcr4Wzothk5HeCjozFLELP+SWyme+KbQZWtDwb5ZqM/HGtWrM8MBmvn7D2t5RD
 SK9Q0fFnWFmvULwqM7fxVPYk/nn9TjXOXS6VdaXs1IX0y4lYow38mxRR8tGJXhIwmDqXcLKTEg4
 gZqC+dha2m52bX7qSWpbaesXnIFm4wN/HtFxP+Pm9Ty/oiQUfDA45pgxb2ueC9Jfi8dk2bDLL61
 8EWQZ6ymBwHKfCvYnJ+kl5TAb4hUI7BcV9ueSYNtlBnhA4Uz1m53se+5N4KzZ07taUfltpm+g0V
 3yRS5euMZ/qeARA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create connectors. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index a6a942b4f84f0caffe1e9e1523edb262e1b7bcfb..1a445a4ff6ffb023a1c1ef7e141c771277146251 100644
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
@@ -66,8 +66,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
-				 DRM_MODE_CONNECTOR_VIRTUAL);
+	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
+				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
 		goto err_connector;
@@ -79,7 +79,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		goto err_encoder;
+		return ret;
 	}
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
@@ -101,12 +101,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 err_attach:
 	drm_encoder_cleanup(encoder);
-
-err_encoder:
-	drm_connector_cleanup(connector);
-
 err_connector:
 	drm_crtc_cleanup(crtc);
-
 	return ret;
 }

-- 
2.44.2


