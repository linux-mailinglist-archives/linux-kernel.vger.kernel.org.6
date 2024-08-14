Return-Path: <linux-kernel+bounces-286650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C5951D62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3370B1F23BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C41BD012;
	Wed, 14 Aug 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZrQhpDcb"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF821B4C40
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646203; cv=none; b=Dvxchq3FOKWSsallgLrqDvWQGQ1mn65/8EC3uUVYW5eee/7FxuvQBf4b2avSFlCtLq1dxnygI5vTNGPr0rLGME+4IBhAXjjc4/JUPVAfiP0b+YriLah7qislXk0xMnI2YmEm2hNnBoSBwwXxHYPgBUXJNJt3EEKL1zOuWsPG2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646203; c=relaxed/simple;
	bh=n9VPKadJ0Gfeu1GqQvFJ1hXBtbm3Y/iFV6hNgIT98iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD0PHGN8xCNmsJBAuV0QY/STWISC5iCyAYj4YAXTqc60KfJBK0KtpxkjVo0odvZje8DwXNiODXR3mpjZsCLYm5RIf9Hg3rPKZZ4Fni/1PJLTxrKe1HZyM5VA+kwDE1yG1gEBadkPeMY8H7Mb3GYMts4CaahCXFcl9CbKosJQfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZrQhpDcb; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E6191C0018;
	Wed, 14 Aug 2024 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTzJTdqCcC1+FQ3s6IZb2V6Dy36Za0dGp0XBs510Djs=;
	b=ZrQhpDcbqqyl4hg/GfPX8VSMqaaLqN2dKzG46VH3h2Y7YzRQHbar44c5HpvUIq81KdNt63
	YcMoy/rMiWb02lixQ7CAaufsaz5dAp9zN4F9L1FrJIzldjQMFip0QChBVxHd4IylAq2qgz
	ut+M20ceSUUNyEi3eVgosPGuQRuq4co46IsGIseBkuX6WxPJpGPR+K1Fo1J2PSsX3Wqwc3
	PFHJJ/n5EKaNdjNpThiZy3XdcwjP1PhwvqbuW3IquXgyeM0UyHWAU6BGwMBPsAZVNFg/xO
	bodgvHvasKfee5fZGGub4V+LhXXMvQUja0WVTzWbQMKMwUFPlL3jn2WiGseJ2Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:32 +0200
Subject: [PATCH RFC 10/15] drm/vkms: Introduce configuration for plane
 color range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-10-6e179abf9fd4@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4055;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=n9VPKadJ0Gfeu1GqQvFJ1hXBtbm3Y/iFV6hNgIT98iA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDriBn6dfYmApqULXo+hRdf5GNGoUO/I7qN0
 dRdo/RXo/SJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6wAKCRAgrS7GWxAs
 4ivuD/4tmWZQtc4L41tnQ+2Rapur8BHqHMgmPqu5nPpnVMtp0i7xwLv+Jd5xEuOloLQkuD2bqiF
 N79ThDvPjAizfR2OCJyj3n00pB0b58tvFrlXG/oChy3t70R4IIuWPTd+GJqOUVOJG+PHYsCKQwT
 PeLnAXP3v6xz3qSq72+r0CB1EKE1jlHR11BtLPPQx/VU150KRsRh9rfUjhwXqTym4qOw9O8zv/2
 DJJ+9xQ5T44bghwF4DmxD3MZeVLsASl2Ha5Q6jNMCQylgVxMwPs6IZv011GwCFWJaNBRgVCVA0Y
 kEkVR06Bl9ZstUWhO/vxTIheut8uv6kqv3GhXMKuD3oX22rB4KVglCAiqnNPCui2EJt3Bi8WMzK
 TfQ4zL2iwqA04XdpzamZjnlTC32bAKpONwzLtA7UXs5kSRUgwOt57oHlEApQ7C6j1eyFKE3il+d
 GiNXB0N8uvx8+72/pEoB+9o/lTcmmS7HpKnQBG/N0kND/xNzuBt5zarWdQa34Ifb4qZzboFPPsl
 oBji4I9uFcjZf45B0TkKneYu9VSbTbzE4vTOlDAnbpnDoZkv/uEL2kHVuB8GFmd3hFScuT7E4UH
 xl0FKezyDEp7WNGov/DxJNOUbcQbz/YrvqX6XTSgMdL6OEgcDSM2XX+i9Z3Cz7kladWKehS9pVp
 bsKWEVqH0Mvwxkw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

VKMS driver supports all the color range on planes, but for testing it can
be useful to only advertise few of them. This new configuration interface
will allow configuring the color range per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 15 ++++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.h |  4 ++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  5 ++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index dabb8cb13314..e9e30974523a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -86,7 +86,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_conf
 							BIT(DRM_COLOR_YCBCR_BT709) |
 							BIT(DRM_COLOR_YCBCR_BT2020);
 	vkms_config_overlay->default_color_encoding = DRM_COLOR_YCBCR_BT601;
-
+	vkms_config_overlay->supported_color_range = BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE);
+	vkms_config_overlay->default_color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
 	list_add(&vkms_config_overlay->link, &vkms_config->planes);
 
@@ -132,6 +134,13 @@ bool vkms_config_is_valid(struct vkms_config *config)
 		    BIT(config_plane->default_color_encoding))
 			return false;
 
+
+		// Default color range not in supported color range
+		if ((BIT(config_plane->default_color_range) &
+		     config_plane->supported_color_range) !=
+		    BIT(config_plane->default_color_range))
+			return false;
+
 		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY) {
 			// Multiple primary planes for only one CRTC
 			if (has_primary)
@@ -170,6 +179,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   config_plane->supported_color_encoding);
 		seq_printf(m, "\tdefault color encoding: %d\n",
 			   config_plane->default_color_encoding);
+		seq_printf(m, "\tsupported color range: 0x%x\n",
+			   config_plane->supported_color_range);
+		seq_printf(m, "\tdefault color range: %d\n",
+			   config_plane->default_color_range);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index c8802bfb9ab2..d668aeab9d26 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -32,6 +32,8 @@ struct vkms_config {
  * @supported_rotation: Rotation that this plane will support
  * @default_color_encoding: Default color encoding that should be used by this plane
  * @supported_color_encoding: Color encoding that this plane will support
+ * @default_color_range: Default color range that should be used by this plane
+ * @supported_color_range: Color range that this plane will support
  * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
  *         store a temporary reference to a vkms plane during device creation. This pointer is
  *         not managed by the configuration and must be managed by other means.
@@ -45,6 +47,8 @@ struct vkms_config_plane {
 	unsigned int supported_rotations;
 	enum drm_color_encoding default_color_encoding;
 	unsigned int supported_color_encoding;
+	enum drm_color_range default_color_range;
+	unsigned int supported_color_range;
 
 	/* Internal usage */
 	struct vkms_plane *plane;
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index ef20da7ccb17..e7e890f730dd 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -243,10 +243,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_create_color_properties(&plane->base,
 					  config->supported_color_encoding,
-					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  config->supported_color_range,
 					  config->default_color_encoding,
-					  DRM_COLOR_YCBCR_FULL_RANGE);
+					  config->default_color_range);
 
 	return plane;
 }

-- 
2.44.2


