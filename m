Return-Path: <linux-kernel+bounces-326747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96701976C81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEB5285F26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E31BA894;
	Thu, 12 Sep 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZlcxW8Pq"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D953A1DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152321; cv=none; b=dniyap2O/vnwd9GelRgUMIgGDBIxPzSElmAYV55yRjk79HZFrHU9TjAJ52Wsunsi2Crn2ckot7NGIrhMpVO77kA0H2cDUHOn7KZbdsE6lcVKR6mqYiX6zMD4aTict65V1F6TJXl1JbJh5O+a37vT1ojKy+e51PF0YLlE0+CwURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152321; c=relaxed/simple;
	bh=Ula2yYzZw2yesSTiWvHRlTRnDJntJyrmKqqJQ8bq7v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9B0duYK6AX2phJRfY/a3//A/hE75oGIK8WF/+eubnDJSVT7c37dvJxQokBgP43rpQjjptyuRBGqjA9PBpgWVeJb6j3o69aSA/gOgS03r2WnnfsNBFDhRSH7L9LZ5Y0dPLGYN3dgfbYEhsFuvey/S2im6qG6Gajr/p9qiifqSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZlcxW8Pq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11D7060011;
	Thu, 12 Sep 2024 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726152317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KE+gNDDpUp9GvMK6xMOxGaFc09i5YxrO9RNbFqdsjs=;
	b=ZlcxW8PqtYjKupK1wcF552GK0IrupDMj7Rx0mKXSRzeAzvOyCbULDONDLKUtZiVJaQ6DFG
	JMJ6HXOll70xcphGi2ZMpA9jeY4nxJM/HoJLO6tmKTmS9MIV9UqnWvVhisYSNBjPtoBd7u
	+6tj6NuVioVuCDUDxCzoy3yFGuowX853ZvYaHDyCqxaYuk3/RjkKP5gedMDUPQUyNMjCqi
	wEGpwgBXa2KBagD3X/jgHsQD+4gm2pkePAkb/XNvrm5c0wBamJ72tIqLwIotBbe+wvUJaU
	yAznSQJGWkw8VV+S6Z662dlL4C60arzDfurqQmGoBHNaHItkNHN30cCf19yZCA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 16:44:58 +0200
Subject: [PATCH 3/3] drm/vkms: Switch to dynamic allocation for CRTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-b4-vkms-allocated-v1-3-29abbaa14af9@bootlin.com>
References: <20240912-b4-vkms-allocated-v1-0-29abbaa14af9@bootlin.com>
In-Reply-To: <20240912-b4-vkms-allocated-v1-0-29abbaa14af9@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9728;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Ula2yYzZw2yesSTiWvHRlTRnDJntJyrmKqqJQ8bq7v0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4v55n5zgFqWCmOV6uNQ06y44Xddgr7eJdujD8
 YUXc/L2kYWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuL+eQAKCRAgrS7GWxAs
 4o3MD/95p2PZa2kN9SRXnPJD8YRHoi0PGqTqZjEHNYXSLczvbdY6cuPZlemrdDCY10S2hYJR0gd
 /FV290ondiba99fxrf6SwK1GCgjHe5eqQv+6J/FUNgh1Pb6Cb2FF9aoW2iRe/WzBUgZ8PWjAwxe
 vGqWbQbEhhTMRIaNNwBESvZAMdMn/4z7ttLo6r1T7kAXVV2zSp5BZnToapEAwGsRPmABqG2bKJW
 GWsv+bReWwqFXvekm2+hZdF3WN80qehE8nw2LG/rEYAMQdyEFD3W54NkUq8ShvbWgIPDoaBkq/H
 P1ncjZpKpKwo1++litCRoZJFMXQ6rtLbeh5ex+jiDhKl1BACY9UuMlF6bVi8wzYNlKetr/HrUu6
 A+sEGmN+2PVq3ZFUxGj2u0+TTlJx47g6jdZ666EQOTUA9hZL6YK1AoHretzYBM3hAaMdYQwy1uy
 T/Rg6upQi+DaimTWO/24So7s578ys5CvTGqn8SZG+RzK1IW4hpEXUeKbeGDC6CKU62ihPqro69o
 McSvI4ggrs1kXgheo3ZmU97VFM1CaRXdjSSiYTUYaQoM+IWfYEjpvIeqjs72+uxa/iXaPjoKLrp
 CotVxDEmA20uYPYrBco8P2Cx5eZHFY631x1e0My8SGNrnE1vSRz66P/YFwHGvbQuxPMuKIlPoI4
 56eNGHB2nOng1kg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

specific allocation for the CRTC is not strictly necessary at this point,
but in order to implement dynamic configuration of VKMS (configFS), it
will be easier to have one allocation per CRTC.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c      | 28 ++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_drv.h       |  9 ++++----
 drivers/gpu/drm/vkms/vkms_output.c    | 39 ++++++++++++++++++-----------------
 drivers/gpu/drm/vkms/vkms_writeback.c | 17 ++++++++-------
 4 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 821b9ac746083630116e05c1cf8e3dc2424ac66a..1169eb5a5e521fb42b1af85082425cd71aa2be4d 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -88,7 +88,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
-	struct vkms_output *output = &vkmsdev->output;
+	struct vkms_output *output = drm_crtc_to_vkms_output(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 
 	if (!READ_ONCE(vblank->enabled)) {
@@ -281,19 +281,23 @@ static void vkms_crtc_destroy_workqueue(struct drm_device *dev,
 	destroy_workqueue(vkms_out->composer_workq);
 }
 
-int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-		   struct drm_plane *primary, struct drm_plane *cursor)
+struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
+				   struct drm_plane *cursor)
 {
-	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
+	struct vkms_output *vkms_out;
+	struct drm_crtc *crtc;
 	int ret;
 
-	ret = drmm_crtc_init_with_planes(dev, crtc, primary, cursor,
-					 &vkms_crtc_funcs, NULL);
-	if (ret) {
-		DRM_ERROR("Failed to init CRTC\n");
-		return ret;
+	vkms_out = drmm_crtc_alloc_with_planes(dev, struct vkms_output, crtc,
+					       primary, cursor,
+					       &vkms_crtc_funcs, NULL);
+	if (IS_ERR(vkms_out)) {
+		DRM_DEV_ERROR(dev->dev, "Failed to init CRTC\n");
+		return vkms_out;
 	}
 
+	crtc = &vkms_out->crtc;
+
 	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
 
 	drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
@@ -304,12 +308,12 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	vkms_out->composer_workq = alloc_ordered_workqueue("vkms_composer", 0);
 	if (!vkms_out->composer_workq)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = drmm_add_action_or_reset(dev, vkms_crtc_destroy_workqueue,
 				       vkms_out);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
-	return ret;
+	return vkms_out;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 972aee6853f2b29909291e33652f68740fdc9dbc..a97164c0c2d62c4b6bb5641d09b3607a742cf585 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -126,7 +126,6 @@ struct vkms_config {
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
-	struct vkms_output output;
 	const struct vkms_config *config;
 };
 
@@ -143,8 +142,9 @@ struct vkms_device {
 	container_of(target, struct vkms_plane_state, base.base)
 
 /* CRTC */
-int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-		   struct drm_plane *primary, struct drm_plane *cursor);
+struct vkms_output *vkms_crtc_init(struct drm_device *dev,
+				   struct drm_plane *primary,
+				   struct drm_plane *cursor);
 
 int vkms_output_init(struct vkms_device *vkmsdev);
 
@@ -165,6 +165,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
 
 /* Writeback */
-int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
+int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
+				    struct vkms_output *vkms_out);
 
 #endif /* _VKMS_DRV_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 60d5365f8d41b8f20da489cfb9dbc85eb9df4916..a57a0cfa21964577f98e564acf87711b2e85fa67 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -29,11 +29,11 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 
 int vkms_output_init(struct vkms_device *vkmsdev)
 {
-	struct vkms_output *output = &vkmsdev->output;
+
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
-	struct drm_crtc *crtc = &output->crtc;
+	struct vkms_output *output;
 	struct vkms_plane *primary, *overlay, *cursor = NULL;
 	int ret;
 	int writeback;
@@ -49,31 +49,33 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			return PTR_ERR(cursor);
 	}
 
-	ret = vkms_crtc_init(dev, crtc, &primary->base, &cursor->base);
-	if (ret)
-		return ret;
+	output = vkms_crtc_init(dev, &primary->base,
+				cursor ? &cursor->base : NULL);
+	if (IS_ERR(output)) {
+		DRM_ERROR("Failed to allocate CRTC\n");
+		return PTR_ERR(output);
+	}
 
 	if (vkmsdev->config->overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
 			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
 			if (IS_ERR(overlay))
 				return PTR_ERR(overlay);
-			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
+			overlay->base.possible_crtcs = drm_crtc_mask(&output->crtc);
 		}
 	}
 
 	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
 	if (!connector) {
 		DRM_ERROR("Failed to allocate connector\n");
-		ret = -ENOMEM;
-		goto err_connector;
+		return -ENOMEM;
 	}
 
 	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init connector\n");
-		goto err_connector;
+		return ret;
 	}
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
@@ -81,34 +83,33 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
 	if (!encoder) {
 		DRM_ERROR("Failed to allocate encoder\n");
-		ret = -ENOMEM;
-		goto err_connector;
+		return -ENOMEM;
 	}
 	ret = drmm_encoder_init(dev, encoder, NULL,
 				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		goto err_connector;
+		return ret;
 	}
-	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	encoder->possible_crtcs = drm_crtc_mask(&output->crtc);
 
+	/* Attach the encoder and the connector */
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
 		return ret;
 	}
 
+	/* Initialize the writeback component */
 	if (vkmsdev->config->writeback) {
-		writeback = vkms_enable_writeback_connector(vkmsdev);
-		if (writeback)
+		writeback = vkms_enable_writeback_connector(vkmsdev, output);
+		if (writeback) {
 			DRM_ERROR("Failed to init writeback connector\n");
+			return ret;
+		}
 	}
 
 	drm_mode_config_reset(dev);
 
 	return 0;
-
-err_connector:
-	drm_crtc_cleanup(crtc);
-	return ret;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index a948f4598764efef971f76e1016fc1a963fbbba7..f91c6418480f71ab3ec9989ea85814460e10d231 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -105,7 +105,9 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct vkms_writeback_job *vkmsjob = job->priv;
-	struct vkms_device *vkmsdev;
+	struct vkms_output *vkms_output = container_of(connector,
+						       struct vkms_output,
+						       wb_connector);
 
 	if (!job->fb)
 		return;
@@ -114,8 +116,7 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
 
 	drm_framebuffer_put(vkmsjob->wb_frame_info.fb);
 
-	vkmsdev = drm_device_to_vkms_device(job->fb->dev);
-	vkms_set_composer(&vkmsdev->output, false);
+	vkms_set_composer(vkms_output, false);
 	kfree(vkmsjob);
 }
 
@@ -124,8 +125,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 {
 	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
 											 conn);
-	struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
-	struct vkms_output *output = &vkmsdev->output;
+	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
 	struct drm_writeback_connector *wb_conn = &output->wb_connector;
 	struct drm_connector_state *conn_state = wb_conn->base.state;
 	struct vkms_crtc_state *crtc_state = output->composer_state;
@@ -139,7 +139,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
-	vkms_set_composer(&vkmsdev->output, true);
+	vkms_set_composer(output, true);
 
 	active_wb = conn_state->writeback_job->priv;
 	wb_frame_info = &active_wb->wb_frame_info;
@@ -167,9 +167,10 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
 	.atomic_check = vkms_wb_atomic_check,
 };
 
-int vkms_enable_writeback_connector(struct vkms_device *vkmsdev)
+int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
+				    struct vkms_output *vkms_output)
 {
-	struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
+	struct drm_writeback_connector *wb = &vkms_output->wb_connector;
 
 	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
 

-- 
2.44.2


