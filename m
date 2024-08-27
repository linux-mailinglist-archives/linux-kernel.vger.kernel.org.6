Return-Path: <linux-kernel+bounces-303044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017ED960696
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764091F20FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E11156C40;
	Tue, 27 Aug 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FjX0fvnt"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1844149E0E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752918; cv=none; b=fLsKMlrDTj2KCZdgyK38j2nqpaQ7Q/Yycj4lsqU3WoCgdoGxfJkgHWUBD05AoBSkeeXqZGHW6dZxcBFF67dMPtvEyHzv9aouZ28zANAK7l/NdcVHJolUnYgeNiILRU5U2qd2h7CrWvSQdhnLoDl2WIaWSsDpzdqWKrDmyyM6INo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752918; c=relaxed/simple;
	bh=675tGI9t4siyekAGAqTdIzTYThmUt23EspEKi2jqEUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8T3FVAE5Tg8LSlqgxU75dmR0wfe8twbJ8ZXvbveuCxQboF55R2YPoWb5bdpSDbVt5mfjFPya6ZxObNEjTodWs7qaLyuKciCPdi+gvTpvBaQ4CHVjx+dv+sfwY20v7tsZXITJBsxenlQ9tYhoNWOfnyjJUhcRfyAuWlp+MEGekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FjX0fvnt; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6F761C0005;
	Tue, 27 Aug 2024 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724752915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLpzZikRAqTA1AgFL9mPE5QtLpuXTGeDfy/jMnIuw64=;
	b=FjX0fvntQgDahP26SR8gjVd42xgLvnQ8DsjWD6u/wmDfUvdRi7fPfpij3CzYsArNUgysuK
	mt2FA+ccXy5uzyLTAbqrtukkLlz/+ZD+qVYwVE/erBXkzwIga2hI/0b3oWjaW5WVnyrRW/
	kAkChvg10h1HubMgyw8bc7Htu1TTZ5E21p8udRDoYnDjW8JchDSBqAmZR16kPDiBhp3Sx1
	TR9zqmm6hSRpFRQOTq9vE9/xGdJUV8EAEn8RlfBRU/i2N7/+8uUzxLmXRepkNGKDMk96Qu
	O66ZWEZQGUOE2vFnJwXQKm8Zko4abrT6R+AsqD1jHcehKEmnSNChbpARNYv1wg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 27 Aug 2024 11:57:37 +0200
Subject: [PATCH v2 2/6] drm/vkms: Switch to managed for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-google-vkms-managed-v2-2-f41104553aeb@bootlin.com>
References: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
In-Reply-To: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=675tGI9t4siyekAGAqTdIzTYThmUt23EspEKi2jqEUw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmzaQPxh3W6g4AWc2LFokZazuLTgBmg1bYlS+Ko
 v5T3sq4YrOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZs2kDwAKCRAgrS7GWxAs
 4uiYEACB/OXTMAKcYDyZjpKrC6FIWGqvtuGYe0kXaCjLSbrkHA7HznuMNLYaY8z0yfNfU0874fz
 Wb5w46Ezg2kP16PYnom7EG2H+fdsuUWdQXGvouML/1QNFvk+FTh1Wh/1dRLTFN4XGvOkL4H0Gi4
 ha/x/an9EUIbmGwtmIMfwcVzGrsLbkpmjussTI9o7/FEtRHEnUaBr4h5/Gb8rS4CqJOSWD28T0J
 jZZPDhFcxgRVLqVk4yqS2GYeePnfVw3+hL1QYtgDA8ATwqO/53U4SgQOD1iAJzSaQI+aAV123p9
 8EYXWS+h7OIYYNk/70lpkmn/8weKY9CbWsOvow2GIXusv91w/zXNdtNOPHu/ZceswjAECquT+4V
 +CH084GoyDtYWxdZp+mz1Z+1QlgTxmLcX8Irf8ejZyfOM9PwGZoxQ8DTIxfyP26TKHQa8/eniwa
 5VkkA3d8pTse4r0dOJCuVzJ7tVGorZa4j00agSZlOLHXj3ZfAsNOuJZlJrEZNEOeAyBNllXpmv4
 kqpM3KnxFsD0qhGhPvioz3WvrqTMrN0zM71nli1Bwell6+GuJp0sUDQG+1eAkLxu+ZUj6EoPXoW
 Fyx05511zL8P2WCKto23+8iI4Dq+iiLIs9ekHQyDO1tWJ/Y0tiqkpumDwPPP1ylIrPj3ZXuTeUu
 Wiqfi/3gxKpbmZw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create encoders. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
 drivers/gpu/drm/vkms/vkms_output.c | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 9a3c6c34d1f6..101993378b49 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -98,7 +98,6 @@ struct vkms_crtc_state {
 
 struct vkms_output {
 	struct drm_crtc crtc;
-	struct drm_encoder encoder;
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 4fe6b88e8081..bbec7c14229c 100644
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
@@ -51,7 +47,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector;
-	struct drm_encoder *encoder = &output->encoder;
+	struct drm_encoder *encoder;
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_plane *primary, *cursor = NULL;
 	int ret;
@@ -96,18 +92,24 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder) {
+		DRM_ERROR("Failed to allocate encoder\n");
+		ret = -ENOMEM;
+		goto err_connector;
+	}
+
+	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
-		return ret;
+		goto err_connector;
 	}
 	encoder->possible_crtcs = 1;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
-		goto err_attach;
+		return ret;
 	}
 
 	if (vkmsdev->config->writeback) {
@@ -120,8 +122,6 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 
 	return 0;
 
-err_attach:
-	drm_encoder_cleanup(encoder);
 err_connector:
 	drm_crtc_cleanup(crtc);
 	return ret;

-- 
2.44.2


