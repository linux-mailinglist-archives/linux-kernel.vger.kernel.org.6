Return-Path: <linux-kernel+bounces-418552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6579D62F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C428A161222
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96C1E008A;
	Fri, 22 Nov 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AZUhZny4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D371DFDB3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296031; cv=none; b=U1IkttCJ5wU+hc0w6/o2L9hEAWGX7U5vETd6ARLl4/qnADGP4QpbGnO4/mC4uAqJ8avCHbmTHy7Dh8RKo+hgbs7mSmZwysBYZdXuxhao0LsJtLPUv9fsYRLztgbHAgi7ORODqzkCHiauxQlhZmIJ76ahY1iqBX2VOBh109kSUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296031; c=relaxed/simple;
	bh=vs+lZLkIly2HZH9mqvWMTifBJurqNPj2JB/tyPp+AvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Umd1GQWRiWgMyewH3GqRlOiHAG99PG0dZEAwFBtRl40lrjuWHaEd35WcNAzgVk+NuFJZHMlvE9Snhu+jXHE27i+amTeNci/wfiUkVCKhBDfXhnifhQprxWvBcvXTv8vfm8eo7m9pcVkxZlcKWVp6qvJXHL6CmWAsfHZw3g7rogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AZUhZny4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 550261C000B;
	Fri, 22 Nov 2024 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJr0LT76hVInGCIa9UWQbQfIc6LUdemP9ljHnk7QCkU=;
	b=AZUhZny4jPoj+5MTy54eQhOyaX8FaIyBuBS88dbCqqppKp/TT5WbUDeDAws8pU6BNQeT46
	/phxIuNLO8RwcI7lrd5B7l4riah3lsfD5KVZ/ulXbzuEsGVsb9otSx3j1J6snUX6Z5nxpp
	BenngTC0Wr+9n4zsfUAGqabfa6V57CN5LwyxpkehQkNoY1P9SIX5GU3Yv2huIBlrbjJBp/
	w0hQ62UAjsIZVw/tBSYUGYPOHCQT/V4JG8fQWg6ubap/HrRnQPk2K9NVn9iXkWYLZXLbV2
	j2DCoUyjw/eVsHMyqChRD4AUziiFnu/pZGOE+3wwGRkD1GpPuNUzZGdK14wFoA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:12 +0100
Subject: [PATCH RFC v2 08/18] drm/vkms: Introduce config for plane color
 range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-8-81540742535a@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4219;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vs+lZLkIly2HZH9mqvWMTifBJurqNPj2JB/tyPp+AvY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1OTUSQ5PhPXVMtoa7ZfKmjyShPNxoYUIXg7
 HubchCd+6WJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9TgAKCRAgrS7GWxAs
 4oYlD/9fy7Xf7LdE41hwPzsGn8Td/8TFrxdZRDI4aqSjcV/eO5l60Yn1cvhWV95FCJWgX3eSCpS
 1yxWZRy30e7U9ntLfFXWzGlYxXdRIlXPBpAJlvxPmD3HntR8/a5hIZ83oEdoRhqQzyYTNpnF97s
 8fgjFYvQblbo6aCOLv3sHahOjKG03XUarsDcYt/7E7N2dEWnpIdXgumaPLnFuwONsiAEx+PWi1b
 55J6+8wTqabOB6y5d6baZ9jyiqNudrw9ywa+ixOnMpEPnSGiYI/ZJ79vjZrl5hFyQU1wNC3JnfA
 UeQrEvyMuGGiwb5SpsB/jmB6YHb94zNVGhDQhrhN0ya1X9m3nmS81z3fiU1wauMVhO8up49088I
 wi9+b9Ac4CEotIAhvFV73LxcHpZ5lS7pV7BbYZvhUoYQy2CewzC9DkqloyvLhts/jNjntSDheGO
 NwH7k2DA/Z8sKWCJMBRa1sD3TQrMUFKN6gRUAsb8YJszXxIpCZVnh9mWcZhkIIIaIFmENVp7Yco
 +is2xCz3jyN4DjhoC3Ds7m+8wCKr3NEiUhmifIqjhJAXve6cCXSMjMBFi4YJ5TYZFKbJmNn4SWt
 AS1nHzQgOIOwMM4VqAF89cl4Z2cqgcWlnAfJSxGKovmNBg7sMwZCK+xX89ncL4/osMFClzLnkvM
 T3iWJ54mqcjiqOg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

VKMS driver supports all the color range on planes, but for testing it can
be useful to only advertise few of them. This new configuration interface
will allow configuring the color range per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 14 +++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.h |  4 ++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  5 ++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 9f9ebe674f6cbe03ac15e5380e4584c40a8bdea7..10fef173fba921e9abacb5e6dfd292b396694815 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -88,7 +88,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *vkms_conf
 							BIT(DRM_COLOR_YCBCR_BT709) |
 							BIT(DRM_COLOR_YCBCR_BT2020);
 	vkms_config_overlay->default_color_encoding = DRM_COLOR_YCBCR_BT601;
-
+	vkms_config_overlay->supported_color_range = BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE);
+	vkms_config_overlay->default_color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
 	list_add(&vkms_config_overlay->link, &vkms_config->planes);
 
@@ -136,6 +138,12 @@ bool vkms_config_is_valid(struct vkms_config *config)
 		    BIT(config_plane->default_color_encoding))
 			return false;
 
+		// Default color range not in supported color range
+		if ((BIT(config_plane->default_color_range) &
+		     config_plane->supported_color_range) !=
+		    BIT(config_plane->default_color_range))
+			return false;
+
 		if (config_plane->type == DRM_PLANE_TYPE_PRIMARY) {
 			// Multiple primary planes for only one CRTC
 			if (has_primary)
@@ -175,6 +183,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
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
index 6cc9b89a996fe26c04951981cfeff7b603c6aec4..8a58c633f9d4649308ce0c536acfcffb03c0617f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -34,6 +34,8 @@ struct vkms_config {
  * @supported_rotation: Rotation that this plane will support
  * @default_color_encoding: Default color encoding that should be used by this plane
  * @supported_color_encoding: Color encoding that this plane will support
+ * @default_color_range: Default color range that should be used by this plane
+ * @supported_color_range: Color range that this plane will support
  * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
  *         store a temporary reference to a vkms plane during device creation. This pointer is
  *         not managed by the configuration and must be managed by other means.
@@ -47,6 +49,8 @@ struct vkms_config_plane {
 	unsigned int supported_rotations;
 	enum drm_color_encoding default_color_encoding;
 	unsigned int supported_color_encoding;
+	enum drm_color_range default_color_range;
+	unsigned int supported_color_range;
 
 	/* Internal usage */
 	struct vkms_plane *plane;
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 77704ee2d49d2ce1551f67cab6308dc69b329ef5..90a5946481e47ab7cff9b9dc4942720b6bbcbe3f 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -240,10 +240,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
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
2.47.0


