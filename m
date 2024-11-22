Return-Path: <linux-kernel+bounces-418593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50D9D635D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5E91612F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB21DFD9A;
	Fri, 22 Nov 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dCCmuCze"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AF1607AB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297147; cv=none; b=l5ZPQ+pzpxfQ0VIwSQgmkOoQinhdgJH3TBAyNex6xBzzSzvwus9iJx0TZIvrg3IdClerIAJK3Asqhlh1ianLM6g6rnOoyL1cwrT3BEs4tZVVB6k3IRKeX+9DMiV1P776VwQE839XDeUYkuAy/aZIfHVN1TryE+mJ1zhcxJjXsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297147; c=relaxed/simple;
	bh=i8E2F83sag4K7/D42ANd9mcZg4fMKlUl/lF3IvPXT6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYwFKXvKAnHv+2cb0QqPI1yztWMMl3hHXMK3tbWovBatJV1TcvCHUyUfct42POotoU0dUFl1JmKuT8kUsnH1vIvmTb9/OjCPfb0qqfg9HLEH8TbvgfoO9ZGnSYMwWlJiRQZ56LYW6DNTIVo9sE5fKBc9KlTKY+4g07QLUcXOtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dCCmuCze; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C14E6C000D;
	Fri, 22 Nov 2024 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gTDNrB6XitmE4T+aS2E6vxEsV3E+1SNA41vUDvIuVQ=;
	b=dCCmuCzeLx8SxWss10bpqaQGyPbq4VP03W3A8N73IyhZXhoZ0sa1BUwdWuZ3CT7J51/G4j
	F4mKvn2uSGDP8WkVuP+a3DW/R9suxMilaul+jzxbUdRtkyuVXwKoC4J80wWGic7RSDS4we
	EpwiKPDoD5c6RIVvncN53qgPKySwzPeLHKPiAJLlt2jJTabcVvpF0QHZJTCRLMec9sNwtS
	T5hbF5SNdgz/2nHBtnFx1RL6GNwEG5hPKLvJjAul5GskR/NSeUhNgrcrgUCVPpOpsnF5gB
	WDwqT1yVVOATsuMH15yNwnKE+ZQoIUBFyMVnk0PMjwCkl4dYITpicOtdc7d5Yg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:33 +0100
Subject: [PATCH RFC v2 07/16] drm/vkms: Introduce configfs for plane color
 range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-google-config-fs-v2-7-4b7e6f183320@bootlin.com>
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
In-Reply-To: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org, 
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5573;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=i8E2F83sag4K7/D42ANd9mcZg4fMKlUl/lF3IvPXT6M=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGrqhjyajHbpqYX8tyBXHzWkLE5kKRkLVANP
 vJz8Jq3WhCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBqwAKCRAgrS7GWxAs
 4i4QEACkrGkbPPF5wa62Gww4gsNaKa5golQMfPiqiRQRpfEml2bGjXOIMZj1Itl7Sp73745Vy9+
 lHPO6ei0v3KpkaSiYDSPebhLwxY9qpEzLZF+Foj4bEggNCSAeuM9Wc/pzucrb1H4za8RMU1Sw1w
 mp7/5b4Xl78Zr/jQaQBRQQWgkv6y8aX/IHRXUl5gmL8viwFwDkvMVLhUzRnbi+oO4YXf827t1Xh
 KFX051GZi/tqYrPLS51ed5QBBWav3Rjh7Rbqfnrq6na19h4s3JlQFd0z6c+70dYhsDgdL9HJkg4
 Ryo3G0Mlg6RC0HlPwNyqXfqQGyM7qqyVnDAoTT8IEiE8VXcpk7IdJVe5bP69YeURqvKRf9SMLFn
 Nda5OREpsJrxVgpOcDBgDS0t5qNEqlS3tj4XHDGPkZxrEisAjSR0o8WjdzPHze5GT2Zhbc7OwtU
 eq3ovmn8InKzNJanmYTs+qWQR2Dbx5dcwaaU5uBZfqZUeEfrOIk2IYx95qwrozfv9N4k0Pkc65p
 atULXY1KC2iZ8k/khqoMy6ZmhJcdnjoZY/6X7Io7jsi3jNyyj1Wd7G0AxbTFZdN2rGiHkdKl0xI
 jTn44iHxJAswpOFxNCxgqZr58rp8llasuJVR2j5D6ENFS1q6AUiiy/f8jgUT6bWY3BfCOjuJre/
 B2whOanvIwnZZXg==
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
index a3dab59868829266adfe8192c5089cda2044c050..aabc832836266668c8adc60d7d5284ee1f385f31 100644
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
2.47.0


