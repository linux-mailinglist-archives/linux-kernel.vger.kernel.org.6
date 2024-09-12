Return-Path: <linux-kernel+bounces-326744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BD976C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A03B285F38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF81B12F2;
	Thu, 12 Sep 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="USnakRW0"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01D53365
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152320; cv=none; b=BcoFYTpbcQQ6DujifRoWw8WkDa+DFIrySCwahH6vv369aUBH3vIixeyzO2MwuEILeRlH84DbrLEIiXYqpJJAnjOs+ySoXwKXk3DFe7WX5sdexOvEiNHpZS0hTDjbkRSSvDBHp4HwTjb43e6cX+0DIV34EEGa1DBQ21b7kxhnDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152320; c=relaxed/simple;
	bh=VISv8cauLqco3i0yU3WE+qBEYcD8Yqy+TzLEZjfI2aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnYHE+8E8ARewL+aduwPxVqrGrlHNKpTQiyeeSBQ8KJkdbId/B+lK1iBkAHovc60GPQHYSGmQyf867GbSOvJ3bsXn87ZIfWWYIIYlrffrbP5/F91K7pRYTQQRpEpL3U5ZbHeQAZIBW1ckW9zfOTjD4IPAWbJjDRIdDcqGXn6lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=USnakRW0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9446560002;
	Thu, 12 Sep 2024 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726152316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjOJC+EL99w5X5JPK4o+U/Y7d6sfgViwqZhRV6zOAXs=;
	b=USnakRW0P3+On5tsLuyinvtacjPXpy8jk6m6vSK0e9hSSGrgC5lcDcREmd4Lqoj8nI+3xG
	n/cZZ9kaXMaUIyuErJkrf/yDZ/rNcXrbQ3D7fGivoB7fwF2MEjLCLvYt3veMIrGYtl9nzB
	3GzEv+7HW8OCkKfb8qkwKi3MFAc49As76BSSN0CGJOnPWJvp1HN1Y9eticXFeRxAKCZC53
	1/wveso1Z8q39B29mOimsDEwOcQLSpYC1LsRSUjBdQ/JPWWMTmwjmrAkaM1/QYu4UJOn2r
	W6+QSGOD1st0q/K2CZjNWmJ/guX6Kkl2R8rNxAlZPs9mkmxi26feUs+l+6mIAg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 16:44:56 +0200
Subject: [PATCH 1/3] drm/vkms: Switch to dynamic allocation for connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-b4-vkms-allocated-v1-1-29abbaa14af9@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VISv8cauLqco3i0yU3WE+qBEYcD8Yqy+TzLEZjfI2aA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4v55KfOcgsvimu2ERpNMHzA47HInyittFEgRR
 VDvWFM3DuGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuL+eQAKCRAgrS7GWxAs
 4j/UD/4hQ/weYoMyUBLTN8U6NVvM4pvYx0eSMoehZRzPgxwhhR3D3EY32zadogiYdvftp9aWpin
 45/OGfmnpOjPvC03b5oxWpEiu9JRi5/yKzlxR7smvvxTKhoPZYHrgr0jBlFEBFPfk5CDWvN/5i+
 qvRaI4F/Yu5kgUnNhSEzBwVmddS9jQNeCmGIAMJv3J0+ttDS+yIDPaCHFlyNu+0hgvWgWaGm9yw
 8dOzZ+MGwo2VBZrxGSg1i6vtHBONUK+w0h5KKBHQWLNrGr+x81IwqU+3S+a95y15od2JlkQtLLy
 1Lm7LlXXNGCZpUhthutXrDE/wBOq/T9rgCEDqPCjeO2jtuOISk7fFhXqGC03MFFprocf4JJHNuk
 DY+rYvNWJj9ie7HIM+Y5fW2G/CUdXro2c2ttixYOYZhHMrh0UR8eL0o/OTE/ZiUiLGOABdj83Ik
 WwW7be/XZESwR3EZB+ARwE48cScO3D8qCO4cHsJfAbEYrR3yauoL/oyZOI12QFjueOuPreQbPJz
 BvUr31ITHrYzO+iPnApjPz094BUSoy5wAFxSETfZ7qXkQNY0XCkFD/XFwEeWdqayW0LNn0oa+YS
 niTtXjr8Mpf5FyJ7uwafs3MqtFd/utBcTZOzHB+aSOQp7AExKT4cc6rvSf4jqs32EqLirPulpoP
 et/l8QiVuM28kxQ==
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
 drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index dac063f11dcd751865cc79d3c2466d113b8e79c7..938f369dba7ab82b55c656ac6ccf2dfe5a11f9e6 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -99,7 +99,6 @@ struct vkms_crtc_state {
 struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
-	struct drm_connector connector;
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2226ba1972f3ff51483abacac45ee8914be0c94a..a0331181ab0e369d711aee0974df4859844c6549 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -31,7 +31,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
-	struct drm_connector *connector = &output->connector;
+	struct drm_connector *connector;
 	struct drm_encoder *encoder = &output->encoder;
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_plane *primary, *overlay, *cursor = NULL;
@@ -62,6 +62,13 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
+	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector) {
+		DRM_ERROR("Failed to allocate connector\n");
+		ret = -ENOMEM;
+		goto err_connector;
+	}
+
 	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
 	if (ret) {

-- 
2.44.2


