Return-Path: <linux-kernel+bounces-286735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77690951E63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A122B2BE77
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA301B8E88;
	Wed, 14 Aug 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BkPNgfIj"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BB1B4C32
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648569; cv=none; b=KFhQcLu6CfFyWt8lz8X8dACz8XmbHBgFntcMdKDXEnS9389hRZfjFGO3Ll0kTyIIBmW/TCN+CuZqnLPYjX3XZZXo/w+UO5I0LHGrwFzaPMlq3njOI4gkOvev02AENy0480SeQNG5uJTQQk5BVgNQFNfSN8u/yWQB1hSXyALshxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648569; c=relaxed/simple;
	bh=UwfWjkDRUSPTIpDVCjvKIClHTrQ+CQ4DCl4x+NwGblw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1UWsUW0pRF+2PyW2T+gQOuU0Kj0gQ7QyNJyupatOPWja6px5Xw5aHpDZLo61rgbsF1B/7ZIcNmDdbvE5DgZsZWU0YSBIZ9Yot+U7hn21esaUGPuNioihmhanjoTgPcRMjFRjNUNK0rnQquFX59QFD+ZkfdCPGcpgQOpA/YtBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BkPNgfIj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C2496000C;
	Wed, 14 Aug 2024 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723648566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtHdgw9McHanJ5bgqEq9uSdi74niZL2dpQLUKRPjzOU=;
	b=BkPNgfIj7lzx08jG3e3/K2pbTyUPcF5iXTw/ho9ACTIoCqF+yUCGEvjOsOzEfMbPoyYwrs
	1inTWqg9LmvtK/SmG71dQD2apILkJvqMOOJ9HkwPoYvENWjyypWZrV0Uk5l1HpwJlYkjGQ
	sEJgRjICurqGYHXC1ifVNKmYMk/D5+97cVMRNUu9DH332tGSosjP0E4SQ0ioF/GjJOc6Rd
	u9vGowgFnsyTNC3Bb/5DsjDaF9zgoAZIFCF7c1wj2UnOskekTCW5dJzNXdhdcMMSpomNp1
	SKP+kVmuXQOP9x9zN3EsZGx7kDzrnlvMgh1l0eLrd0ZXqpX1j+9q/sOOmqi4Dw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 17:15:53 +0200
Subject: [PATCH RFC 6/7] drm/vkms: Add color range in ConfigFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240814-google-config-fs-v1-6-8363181907a6@bootlin.com>
References: <20240814-google-config-fs-v1-0-8363181907a6@bootlin.com>
In-Reply-To: <20240814-google-config-fs-v1-0-8363181907a6@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=UwfWjkDRUSPTIpDVCjvKIClHTrQ+CQ4DCl4x+NwGblw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMouw1bQlgtzsLxesTAO9Pp5Dmg7I7dl32SPZ
 QU6egIGqXyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzKLgAKCRAgrS7GWxAs
 4iMxEACrdScEUMyOO/jJ053MWzOFSgbEYepGRtExWLtPPnm9+5AUUKkcnsG1OhvPaQUt01+mdqq
 IQGZGP1OWrUnQT+QeRmyASiJMXXL5TeHtKYZiP+5zPa5WMQH684PVwWiGcx8Sg9awp/o2fG+gUu
 OB+L9quTbAZOJ0HQLeBWplv3/9UiNnRJ7I8IG8zVeWnYSZxaqwvEAVxMe2C8zJnx0z6HFyLv+cL
 w/5/7Nq5f+PvYDsLRQUf2/islVyD+O1lWcA9A49ufCNiTJTwyaPgz+dkq0NBReQOHxlAIsPoPwt
 /6z1FR7jLss/VPtL0ISd52wmjJ5dUw4ZgnJsIcfV8W+aiBbSV83ZjPGOjUqM2Ih97JcMYWMV6jD
 Ehp3wkiIx2o1oAPoT6if4WuuQFw5OAE1N6d604mFBdv7gFFYQz8Y3pqu6FBA8xqLOj9+8+DfhuO
 IDtiwAU77SzsmTiSWfeV2EOT/oyPDxT3ZnzNkT4uCBLNloP2YYqRrjziezrfYzWxuElpYLq+hqL
 0YA5E7ms3NHmXY1y/c1omia8ybwK9uGzMWr2jFxD2ZYW6iExhNhl5ueQ5gUVJuDAqIADMsdBNuU
 yuMaHIZWMGuc7TlJlnlPtwIYYl5wkzcWsE6vtTPegaiwNLmLeGAUZVqR8+/n5YwXfZYAFkXQDBO
 AVmX7eTU1ya6gAg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color ranges per planes. VKMS
supports multiple color ranges, so the userspace can choose any
combination.

The supported color ranges are configured by writing a color range bitmask
to the file `supported_color_ranges` and the default color range is
chosen by writing a color encoding bitmask to `default_color_range`.

The current interface is:
/config/vkms
       	DEVICE_1
       	┣━ enable
       	┣━ planes
       	┃  ┗━ PLANE_1
       	┃     ┣━ type
       	┃     ┣━ supported_rotations
       	┃     ┣━ supported_color_encoding
       	┃     ┣━ supported_color_ranges
       	┃     ┣━ default_rotation
       	┃     ┣━ default_color_encoding
       	┃     ┗━ default_color_range
       	DEVICE_2
       	┗━ ditto

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a3dab5986882..aabc83283626 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -152,6 +152,105 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_color_range_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane;
+	unsigned int plane_type;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	plane_type = plane->supported_color_range;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", plane_type);
+}
+
+static ssize_t plane_color_range_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_config_plane *plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
+		return -EINVAL;
+
+	mutex_lock(&vkms_configfs->lock);
+
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled || (val & plane->default_color_range) !=
+				      plane->default_color_range) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+	plane->supported_color_range = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
+static ssize_t plane_default_color_range_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane;
+	unsigned int plane_type;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	plane_type = plane->default_color_range;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", plane_type);
+}
+
+static ssize_t plane_default_color_range_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct vkms_config_plane *plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
+		return -EINVAL;
+
+	mutex_lock(&vkms_configfs->lock);
+
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled || (val & plane->supported_color_range) != val) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+	plane->default_color_range = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
 static ssize_t plane_supported_color_encoding_show(struct config_item *item, char *page)
 {
 	struct vkms_config_plane *plane;
@@ -258,6 +357,8 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, color_range);
+CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encoding);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 
@@ -265,6 +366,8 @@ static struct configfs_attribute *plane_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_color_range,
+	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encoding,
 	&plane_attr_default_color_encoding,
 	NULL,

-- 
2.44.2


