Return-Path: <linux-kernel+bounces-418508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8C9D625D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9F28104B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69BA1DEFC6;
	Fri, 22 Nov 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c8g+aKhk"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE415ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293317; cv=none; b=dL8SowkgaJh166xe53YQbkZPbjpB4TzR/u3Y/YrMSvBSD5Ye+kQ8jnsnjORbTNzD7cBPwAT2rathynQHzRBao46Fy6/LiCIZNUDm/yI47i9B3EWOFRax26Ug0EJHQ9Zn8sD2FiQkTiG5tEqB9dV0A1p/Xwv6vHrDVm0pPk/7pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293317; c=relaxed/simple;
	bh=+4lvrIye4ET+VE6WPe9UM6/x4v+7EymafhvvpaW3ys0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orJaJqDuu1pDiPAqnHn8xFOYLzjyouMxZvekWDRgwt7Lyt6kW9U6lxFMg4URMpnNE9y78hQtnqsoAJwcFFxNLjVfeNs22GKS5zzLF9B8hTPOpvwdBOQdV1tvLbDD5v8ICDljGJi9hNo4mpWy0e+ysxoHRUoFSP2DutcuCejJ20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c8g+aKhk; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28AC2E0004;
	Fri, 22 Nov 2024 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732293313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Saatg+Kt9CY/Nw+l2VbJ9P3jgV0lrIBz0cECqUwIKPI=;
	b=c8g+aKhkyXEC6ERSbP0XXyyro+tCh6N1w3pPFohWKfw449yMjmLzg9Mu84djCxcmtvZC/q
	DZMBBW5FwJn740keY4VrkKizp0rfIrsI/awoGGDz3T4c55eJ67A4FIH+Sf6JnbWUFt7KCp
	pM8jx7bO0JazqFMnSj8iH/0EFCqtzadBISgRM/SIL9Dlolwkcie3R/26a7pvOOdTnbhtk1
	6VpAPJ0UIGWALAqqMuy7SwTIqBZsktd2RJmE0Ri71+gj1gndg2UjuPuoRSNJHtwof1y30U
	+jD6+fubsE4e2t/86uEc0KencsXOPALLT+zfOH+LVwx+MZwetgyNLtNLQka06A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:35:09 +0100
Subject: [PATCH v2 1/4] drm/vkms: Switch to dynamic allocation for
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-vkms-allocated-v2-1-ff7bddbf0bfb@bootlin.com>
References: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
In-Reply-To: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+4lvrIye4ET+VE6WPe9UM6/x4v+7EymafhvvpaW3ys0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLK+eS8mKIwSrSe6Iv+WAcyJyRpFnBNb4AfD0
 1go24UKFPOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CyvgAKCRAgrS7GWxAs
 4vsqD/47S8zfsrCwhqoJo9+iFBIH2i52S9krESloQKmJXWjtVAyyHsSSketYig+UgCqio7wSrff
 qS0v53LerlgKMsBEBGZ+3aqbN322yFwDKj3YlYxurlId5XohyNZM17l6Dm+DnhUFAvVqKe+Gidn
 7vuF0fYUeLFXY5JdlZQSI+YP8JH17rF+RO+75tuJSgtcI7kNGb3kKpmADTpod8DK2IoTkKwW133
 YuFNygyq/DxoQnLL2ZtNFab2/8XgiEkFRKDjF01uwoQAsEPb54o5LOyINzzfoUDjI2jVNC0K46o
 M3L9q7/nutsax/sRj6ZbxSABdD8rEU6ltnvIwfvHUpuuaJiaMKwxjAa7kzmKMcLZ1PIQpBOvsdq
 /OlbE7LB2aIk1NAa5CKIw592LnYIChdoHYrO0O2Ua4JipTNmTq9Zv5fj4XzDKHBfO5csFNoytzO
 FFhlY6C0CIqZuWqA4ee9iphH720pAOosk1eMSjunUzlWZA5HvPGGviALrfoZofHBx6b1T7/B04w
 bQhSHJnDDEbwfxaxGhPT3qrfi6UZoZ+7n7WOxKpBQHtTUlqxzGaWLzmV6v+6504W/NfAC9FThF6
 uAM8/Q9uhjMglM/rsiYRbTshcMctVcBE4R8Nrh+zSdPdEIlOI5kvmxmbPKViKKFDliRzUmnePgr
 INSFslcD4OBdECQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

A specific allocation for the connector is not strictly necessary
at this point, but in order to implement dynamic configuration of
VKMS (configFS), it will be easier to have one allocation per
connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 1 -
 drivers/gpu/drm/vkms/vkms_output.c | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 00541eff3d1b0aa4b374fb94c8fe34932df31509..820e7899cb049b45d8bdbe5a0dc7be08eee6db69 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -177,7 +177,6 @@ struct vkms_crtc_state {
 struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
-	struct drm_connector connector;
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index ab9affa75b66ce9f00fe025052439405206144ec..ec3545730ef79af0db51d8ec605b9cdfff52c2a3 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -32,7 +32,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
-	struct drm_connector *connector = &output->connector;
+	struct drm_connector *connector;
 	struct drm_encoder *encoder = &output->encoder;
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_plane *primary, *overlay, *cursor = NULL;
@@ -71,6 +71,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
+	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector) {
+		DRM_ERROR("Failed to allocate connector\n");
+		return -ENOMEM;
+	}
+
 	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {

-- 
2.47.0


