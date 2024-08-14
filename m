Return-Path: <linux-kernel+bounces-286645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C555D951D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5C28CAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D61B5804;
	Wed, 14 Aug 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AoG8OPrO"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DD1B32AD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646201; cv=none; b=bOGlPBqvd3YBNOOHHjCIa6Dv0gB5x76GfRzP7rh3rGPr2oRSCcNJe77rSRlp6QI/yDmwW0a72yemN4Af/BiUnQVBsqaJdR99o6Cc5aqxGi9T533um7g196eMvJSxmiB2zS2/+qs3g6FokTUWGrrlfSGVFGrZ5JFsxLepJvBNWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646201; c=relaxed/simple;
	bh=MfhwABS17LHUoJ+jq0vYojOPf4se4zR6qFsIZKDDr88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVd+NYtE33W26zmJzLaUdd2l+Kp/Xj4cRFOMTNccQ6vCIBwAUESsarrYWKL1t+fG7rku/z8LJc9ktD81tTgTR+45/1N0If8BnsnMFi5V6YPrWPNL+jrWm7oZnR5o+Yje++Io9Y/Ril7O5tEmKdn0ZNSlPckCGJotW6eKjDYcyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AoG8OPrO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0EA51C0005;
	Wed, 14 Aug 2024 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjT0T1cDM1LYJFW8u10bh1Tm6iF9xcPCR84CrhIb5P0=;
	b=AoG8OPrOjndHgrPiSdy/9sdp+9BXVKUVWznI+EIuGNARGRB81pD8ZYvaihBEvnZY1adU/J
	csQq11NhRrAhS9FxX/soLqMC+kLiI/3gvOB/F0yPPEyX8tcRupzncuLKHCsrigAZNzxRCh
	4BlVLF7ue7a+vcuslOvDoXAtOY3RXGJBUm0CQiq3DrmQjldmoQK8Ua9+FR4yGSkddclGMu
	EZ7XBi96wybIwiOD1d5auHxrgkxq9qucC/38ScZdtQJUdpUh5G2ZgRoP5/t9x+5jKjYiGy
	DQwMa+vwRsT9tYGzlOZ0L2AnadDqDq4CzFGJ34mtneTlM13EOBEy7Sd6R2Rx0g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:24 +0200
Subject: [PATCH RFC 02/15] drm/vkms: remove possible crtc from parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-2-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=MfhwABS17LHUoJ+jq0vYojOPf4se4zR6qFsIZKDDr88=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDquZQ5+AoQGUj3+2cFFoN4u9cdx+UkSdRXs
 xj7OCwvdhGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6gAKCRAgrS7GWxAs
 4stqD/9mwWDPROPr03dSkdO8YCxBmJEv6IrxBZtDYGxCC8RyLOaghd59KJYilvHzepIsw1xTTQk
 cees94xvHFZaHmaeKQAFfh8VKE0wr1cMBz1+z1Efy8/Xta9QFR1mXYjlztblF196GSeBHZoftLD
 8GYYLMfkR1SVACsxCx3nHJTK81YB39F5J8CypeKtObWtAC2Isk1GK1a2nqQygAAUM/HjRsgCDKu
 NJjtmkGwdJ5bGKC1+iLO52MVP9KWEHpZURHy/vj4Mt4VotJLpfwz1yf9wDMVZZpr7A1HiMI7Z7p
 3NbPmFZkvpEw/ojKhq33nR2EJ10vNxjy9u0WYCqQJSvEzWXNr7IpR00+PKDO54VcXeNIL0pQ44Z
 2CGL3wvSKYg3k0+BxYukfVpcq2X7pN3T0lle/GyCbQAPZQfuMlPazy9ofw/jgVMCM8CvCXdlV/r
 s/oJXAFeC6lpKkXNINH64F2id+My4Uo9yayyFuG4cyKb06T9EJ29JzAMybvZNTBgztfZY6UdaHY
 f8qAm/9cMuDijz5zQlXS4p5jVqrPfKgwZR/NmlTcn0U9bdQvMffuP31iAdOnL4IpJM62IEwXENs
 NnrKoScH6Kzei++w3GlFKkm1orxiiWQGQ/opVz2lXb4Kfdz/3mqc0X/RN/c/TMbL85J++iZ/gTs
 mWbH+Y9Jx/2kyCQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As the crtc mask is dynamic, avoid hardcoding it. It is already computed
once all the planes are created, so it should be a no-op

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c   | 10 +++++-----
 drivers/gpu/drm/vkms/vkms_plane.c |  5 +++--
 drivers/gpu/drm/vkms/vkms_plane.h |  4 +---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 7ac3ab7e16e5..e71b45fcb9b8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -166,7 +166,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.get_modes = vkms_conn_get_modes,
 };
 
-static int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc)
+static int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector;
@@ -184,20 +184,20 @@ static int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc)
 	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
 	 * composition.
 	 */
-	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, possible_crtc);
+	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
 	if (vkmsdev->config->overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
-			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, possible_crtc);
+			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
 			if (IS_ERR(overlay))
 				return PTR_ERR(overlay);
 		}
 	}
 
 	if (vkmsdev->config->cursor) {
-		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, possible_crtc);
+		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
 		if (IS_ERR(cursor))
 			return PTR_ERR(cursor);
 	}
@@ -284,7 +284,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-	return vkms_output_init(vkmsdev, 0);
+	return vkms_output_init(vkmsdev);
 }
 
 static int vkms_create(struct vkms_config *config)
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e549c9523a34..b5740c27180b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -5,6 +5,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_plane.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -222,12 +223,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
 };
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int possible_crtc_index)
+				   enum drm_plane_type type)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
 
-	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << possible_crtc_index,
+	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, type, NULL);
diff --git a/drivers/gpu/drm/vkms/vkms_plane.h b/drivers/gpu/drm/vkms/vkms_plane.h
index 90554c9fe250..95b2428331b8 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.h
+++ b/drivers/gpu/drm/vkms/vkms_plane.h
@@ -52,11 +52,9 @@ struct vkms_frame_info {
  *
  * @vkmsdev: vkms device containing the plane
  * @type: type of plane to initialize
- * @possible_crtc_index: Crtc which can be attached to the plane. The caller must ensure that
- * possible_crtc_index is positive and less or equals to 31.
  */
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type, int possible_crtc_index);
+				   enum drm_plane_type type);
 
 #define drm_plane_state_to_vkms_plane_state(target) \
 	container_of(target, struct vkms_plane_state, base.base)

-- 
2.44.2


