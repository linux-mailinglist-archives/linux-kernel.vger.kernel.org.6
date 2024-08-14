Return-Path: <linux-kernel+bounces-286654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68B951D66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6E91C256D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63271BE226;
	Wed, 14 Aug 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S0CZ3pId"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5421BC07A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646205; cv=none; b=D/IGR+qHNWRNAsvhsxZR1Dc+WA4epbl33axmJfo64EuwZGeMffvHQk96AQDp82jOA9Ynkq0if/wHH5UYPCANjAkuFoiyahvRXJDiGaL4iZJMN8BJ6b2j7ssR3Ipy8AKK3o97WkplapaA9VdchIQ419VACAip2M6ogEdWsGYGqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646205; c=relaxed/simple;
	bh=7ECEXMl0/sjLnYGUbuJj1pxIV+1npiLzlGfXdPZbOiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGxrrpuLDhahhyfEm5068TJUrVFPSeTIczh3TqvBll4kGaafio8Gxm9nj1u/7Y+nheHcsLG0y7u74VwvA0GAmdqqyktdYWVIOkHRGANFl7kwWWtkfyIg8pvcaYlJQRCekpJiCi0Dt+G3vPGgS+JJeMzftZEBGGLNedTWcLx3RLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S0CZ3pId; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 695151C0013;
	Wed, 14 Aug 2024 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv9G0qT3QDgWb7mJla/RT5pO59ye8gTf1MNCr9gFUH0=;
	b=S0CZ3pIdYc0MG0mTR5Ntzwhm/ivfK793sCZtSr+1lfpdt6l2+WQ7KMCSg4WBUNDsRxrDXI
	J/PxcGPj/zNBcv3peTnfo+nA7XT7m9JE1Go6WSEoFmZK3POZbA7lFFIrmXcek6rS55TAz7
	iHT5Ux/7WrjlI+75DLVK/J8n5ZyobFGTpZk+sTIIIFsPrmZSsRYP4+cirtwwxRdgTfTVxh
	Xe9FftWq1CA2+pU+4G/LowYt2fy9X23KG7+xTJ9FAwrkN71Jf1/do9farSsNXYDn+GTy+f
	cH6eJW+4JHuo5ptRF582y1C0Fgtk7pIJJHAwtz+HUNfZ2XlVc5cL7VCmCklw9w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:35 +0200
Subject: [PATCH RFC 13/15] drm/vkms: Add name configuration for encoders
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-13-6e179abf9fd4@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2974;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=7ECEXMl0/sjLnYGUbuJj1pxIV+1npiLzlGfXdPZbOiQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDrxIqYar9la9HQlFNEf9xCptfEMltxbvRGS
 V8eIljbQaWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6wAKCRAgrS7GWxAs
 4nxMEACCHj59aLFDqD8+GAzzBA8IMbwVpDf4E4CLJT1rk5OA0WUHbHMg8xYB2nI3ieiPt/3rZlh
 o4CuzlDj58qNv1kX0tbn03M4eWFW6onC+mnmi9nDo4IveT+vB/8y1o1A1v+EEiWVfRJd2ZdiFUs
 2prGrer7ChxaPoRVy8/3npB4Nw270dQqR/p6ZoIQ/U0jTBD6OcUXuGHOTfPDl7f604iILIlHH4H
 2NC9bNgmrs5mnRdi0sgkkfVf8NNV6HP5TdWI1dVkApW1/klzch3HsmBE4Q6hAydCodMHLbmK1nU
 7XLnef1dSsiD1pKGRnRbw1hP/eJypx1Fiddo0bLZ6oyGpTU4Ciq0NBakAbF3O6SzqDXnAGzQYEl
 5bRveUyuhcxcEgqKHbyxC2cVbzFFE1H//MX5lqSoZC3eHDjLulAex/Nk9tZ0WEeiTWrATn5XgL6
 iFAf1WYddQwS/whJ3a0v0IDnyyj/dLOEIwSgWifmGYq+59IRRbcPqPCp0vvvIW8gxWKSYrGDIvg
 NcS0uOMIlJICShZrwsCbWxP8R4WF8QWMr4QwuojOjtBsbYVFH5HrNoeZ0vhUx2yw3QJw7enFNzx
 9V4ScEPGBmLg62fm3Wx5V4AEAqklj3O+sciPb1dRUlih0YaKQdmnZV6Xe2LtNz9/Xw+5CqcNTC8
 t4cXU9O/g95nBtQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As an encoder will be a directory in ConfigFS, add the configuration for
encoder name so we will be able to reflect the configfs directory name in
the drm name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 6 ++++++
 drivers/gpu/drm/vkms/vkms_config.h | 2 ++
 drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index fcd4a128c21b..7ef525091967 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -39,6 +39,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 	encoder = vkms_config_create_encoder(vkms_config);
 	if (!encoder)
 		goto err_alloc;
+	encoder->name = kzalloc(sizeof("Main Encoder"), GFP_KERNEL);
+	if (!encoder->name)
+		goto err_alloc;
+	sprintf(encoder->name, "Main Encoder");
 
 	if (vkms_config_encoder_attach_crtc(encoder, crtc))
 		goto err_alloc;
@@ -232,6 +236,7 @@ void vkms_config_delete_encoder(struct vkms_config_encoder *vkms_config_encoder,
 		}
 	}
 
+	kfree(vkms_config_encoder->name);
 	kfree(vkms_config_encoder);
 }
 
@@ -394,6 +399,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	list_for_each_entry(config_encoder, &vkmsdev->config->encoders, link) {
 		seq_puts(m, "encoder:\n");
+		seq_printf(m, "\tname: %s\n", config_encoder->name);
 	}
 
 	list_for_each_entry(config_crtc, &vkmsdev->config->crtcs, link) {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8f247fc09373..4223edd94ec2 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -50,6 +50,7 @@ struct vkms_config_crtc {
  * struct vkms_config_encoder
  *
  * @link: Link to the others encoders
+ * @name: Name of the encoder
  * @possible_crtcs: List of CRTC that can be used with this encoder
  * @encoder: Internal usage. This pointer should never be considered as valid. It can be used to
  *         store a temporary reference to a vkms encoder during device creation. This pointer is
@@ -58,6 +59,7 @@ struct vkms_config_crtc {
 struct vkms_config_encoder {
 	struct list_head link;
 
+	char *name;
 	struct xarray possible_crtcs;
 
 	/* Internal usage */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6deff5099322..cd3920270905 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -216,7 +216,7 @@ static int vkms_output_init(struct vkms_device *vkmsdev)
 		if (!config_encoder->encoder)
 			return -ENOMEM;
 		ret = drmm_encoder_init(dev, config_encoder->encoder, &vkms_encoder_funcs,
-					DRM_MODE_ENCODER_VIRTUAL, NULL);
+					DRM_MODE_ENCODER_VIRTUAL, config_encoder->name);
 		if (ret) {
 			DRM_ERROR("Failed to init encoder\n");
 			return ret;

-- 
2.44.2


