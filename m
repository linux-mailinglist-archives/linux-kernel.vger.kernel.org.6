Return-Path: <linux-kernel+bounces-418562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD369D62FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F0BB23FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044681E200E;
	Fri, 22 Nov 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AlQpVBJj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B261E105F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296041; cv=none; b=YoEe6kdKfV5gJ+dMt7h1z/xgZa8JWuV2eGRy24zsOu6PCjgqwPWfypjmzqMDJbiLh/9h0iG8d2L81Ug89Fe9YZnTATGwh30ygnWkB/oIKY6ytw7dJs2JG2/4bAsNsIWjZcRD7droHnuaQnzRzMO8xq1M7uzy+KQf/d+91hz5tV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296041; c=relaxed/simple;
	bh=M7OgKbAdZgFO249hi2gxd30GoPTFZoLXWvm7U1pXG+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VONQ3Vq9xLTPRbOtT6hW64idlu8mm0j6mAMpcY0+2BVmabPNcfFcS5n/18sk9eFu++PdlebikpLu1D0hlEHsOjmc5abtdeOWq7GYX+E1OjTTngPI4NWmQQKYUByLQdB84jU0lv8KABvYKAxzcSt3mzGS8eeL3uKJzyUIocREbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AlQpVBJj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C14871C000B;
	Fri, 22 Nov 2024 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAYdQPQtzh0gV8wVAo7qgs3QH7T2hO6Bm9p3RfcWbfs=;
	b=AlQpVBJj8b/EqgHli+UQ7eFaHxoDvFgf/s7CF08nV/g1hWoOCMJYRooE9E7aHaYxZHYmx0
	8PCQpBwHiCPNVTAd12imQWPZ6JKrzXOxGA/WUkj+wajoKbQ9JQfggG94pes2alMCxMVPdo
	YRaRSZL2SWb90OsSl30JNE8MtJWT0vRVXqrlE8i33S4gkfhQf2S3SZ7ONh0iiYagLPhenI
	CsxcKQ1VuL9G0b7NDC7jTmKuP4UV+cCT7ftp3rkFXZS1bmrZ8hF94IUTlMio7gXCz43JLy
	yCjwNAIBKQ21rCVnkDbHdr7MY/Z0nd+eaVDSAy9FoxJkN2DmPMLrGBX0ho59Mw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:22 +0100
Subject: [PATCH RFC v2 18/18] drm/vkms: Introduce config for encoder type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-18-81540742535a@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=M7OgKbAdZgFO249hi2gxd30GoPTFZoLXWvm7U1pXG+M=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1RktCDzrK7xLIUWST0RT3iZxjH/j5M6TjTU
 8IQg2w3V4SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9UQAKCRAgrS7GWxAs
 4k40D/0X96OevF8YTgDp6mfrO1u3L+J0lO4dC5KgyLl50KzpiR3bdh2zjlKnOuky/jAoN0OmQZ8
 joAtgkUCjOtQ4WHhNo59O33wPE3+6v14pugtyPfFFOdS4lu7kaVvcqZoSTYg+F35rCP4iXL+JQc
 jzlywI2OZ8m33jAC/wbk5a8hdz+YNxoITPbnRa1rPvKCLOxPD57On94LYPE9vEGcjWVRD5ds5oY
 /pNyMxMxMyK/zPsBbQV1FKRzMN+0fziu6j8Q8FtHk/3tKaZwfOBCSwxBy/m6sOseJbHldmvLVJL
 KK5oOeb1M4yD+ta1kRpqQ7s7EPssJObn+GYhM2RB290Us1PiIL6FbvVBg8QgqgqWkoMYluaLG90
 XHsllHXZYncrf+ryAWKguPkRK8vFRl+ZR3x9s5dmAcn5LgJ5TCTt6qqVF8abeIIr/4HFcuhpTFO
 HP83sRBFH7WXn5fiOfq71ul9gzv0S9Uik5OjKH9kOptweTur83JsKuzjM5p1YEau5074ZXevEPV
 G8XvO+6mBwBxeIupunq54xlRIi7t8X8+g2DDypLPGyMuMGfzpq6SkXxxxqQ1DCw3Hl4WVTYOzJy
 fGN7ZijUWVrTlAJMjW+HnEKXIxQoch2vP6Ix8DzCEAbpeNJnJ8ni9VK5QMa9UAG09d1tAM6hLzp
 bQPltUJQ3dR3QBg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 1 +
 drivers/gpu/drm/vkms/vkms_config.h | 2 ++
 drivers/gpu/drm/vkms/vkms_output.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 1a1234d4f10fa8e5ea6bd649139ecc10c991f875..26280ad223208a978c44ef9c6c6eaadf1756818d 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -242,6 +242,7 @@ struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *vkms_
 	if (!vkms_config_encoder)
 		return NULL;
 
+	vkms_config_encoder->type = DRM_MODE_ENCODER_VIRTUAL;
 	list_add(&vkms_config_encoder->link, &vkms_config->encoders);
 	xa_init_flags(&vkms_config_encoder->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 1220b16f6c98d1ebb0ae55d662a84fe25e1a6a02..c6fe0573abd899e4b44b5ad390ff72e12664973f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -55,6 +55,7 @@ struct vkms_config_crtc {
  * @link: Link to the others encoders
  * @name: Name of the encoder
  * @possible_crtcs: List of CRTC that can be used with this encoder
+ * @type: Type of encoder, see drm_mode.h, DRM_MODE_ENCODER_*
  * @encoder: Internal usage. This pointer should never be considered as valid. It can be used to
  *         store a temporary reference to a vkms encoder during device creation. This pointer is
  *         not managed by the configuration and must be managed by other means.
@@ -64,6 +65,7 @@ struct vkms_config_encoder {
 
 	char *name;
 	struct xarray possible_crtcs;
+	char type;
 
 	/* Internal usage */
 	struct drm_encoder *encoder;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 56590afb33d75465971d10a282040690840cdbee..7c87da5757529b9a8dae880cd32272be7dd46a27 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -125,7 +125,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		if (!config_encoder->encoder)
 			return -ENOMEM;
 		ret = drmm_encoder_init(dev, config_encoder->encoder, NULL,
-					DRM_MODE_ENCODER_VIRTUAL, config_encoder->name);
+					config_encoder->type, config_encoder->name);
 		if (ret) {
 			DRM_ERROR("Failed to init encoder\n");
 			return ret;

-- 
2.47.0


