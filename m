Return-Path: <linux-kernel+bounces-418598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D09D6364
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307CE161343
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914D1E0496;
	Fri, 22 Nov 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oMz1yEI1"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDED1DFD98
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297150; cv=none; b=S9V+0x+kOHfEDYV4ZM7luluWWiBA/bNmTiV53EQmyH0YevVC7TPq1x9NX4nOy52EHSx6yQlAimsG49NiIeQTgTm5hhj7amHvFg8NSOkKDKF1dmbBTiQ69gmeNzpjCmn1OGum3sIvQ2uQ3kKSr7IUxRobQE4f2Xp26tpSRSWujl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297150; c=relaxed/simple;
	bh=ZvvsaZwGqFsLr0ChkQtKz12Rpe5AImIeJhO57DvpCUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrvnmmmgVwQTtMG5KlrJ5r/OjJseYVCcP1TGNB0CRuRvE+K0iZP+nyFXQYhL9BpGcu24nQt1rYaENYay3gxWM7t9muD+grAQHXEKTs6U1ZFwq9UKxGUd+h9tz8lozjM8YBcc440qfigHQuVgc1zgw9KfV0tkKwY5AMGGLOO+ZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oMz1yEI1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8AE7C000A;
	Fri, 22 Nov 2024 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOsGcq1tgnZ8J3YdAQwSil2grZlMHMu/LuOePC1ySMQ=;
	b=oMz1yEI1hls94RmSiM9sPRDlBjlxb/3MRRkxg+zJc/BWsu3CH8hNbDAsQQHwl9XaoC+GJa
	Ff3up5EP9hOATAmI38KKN6+OIAavhfUdEzUSJR88NmXhbE5PW5BEfaJXg2dQdlqyJJwnyl
	nhLPDchLjPWRR5b/c2R+YidAN05CUqwKmMBUeFB+rEjfAT2pRw0WcM7YPYTTGG0YLvbDOb
	O4zesuafKOOh+a5b8ZzlV3u2KJRH2awDOBNR8wt4oSVfuJ09jGik+/tjR1pVLLyYfY5Nrs
	GLYVyhTcZKnYI4sKhdkAcCTAe9ATY6gYbedxSy3E0UNQa0fhl4ea/0waP4rlkA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:31 +0100
Subject: [PATCH RFC v2 05/16] drm/vkms: Introduce configfs for plane
 rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-google-config-fs-v2-5-4b7e6f183320@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4695;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ZvvsaZwGqFsLr0ChkQtKz12Rpe5AImIeJhO57DvpCUU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGqV1JFvAcJ+p3yD1XW/GaJZSLJi4ZgXZ9D2
 YfnhbLMTkGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBqgAKCRAgrS7GWxAs
 4pIYEADWRI5sKoMv/PlWUSS52nO5VAVtM2FtMi7dn1xxvD46lfriigR6KbhMiaGCGzA1z/vF0qG
 NKX0m5eOeqg5EQCey32+HmjEENRTu11dWUGoSg1Qz/D1eXvyu7kR8l8XOikldJINKBpYPXr2OOG
 a/PQhC7gwJdyg/gTV5yu+bHIRhu7QLRYWXkw6O3gL1not86PPglBroB7WxrT5aseD2X1F7Gu53I
 hWCm/MP69/bmMxmvAoBxmsV1M2Lqi14qVFVu9gYjGCzTvB+jFzk+GEmli32AfiW71cEnm+hlDnL
 oX0hhK5WtblFvUMEv0SB/mygrCNdx7w+3tnGrjke6aKPpf/J7HR4n8cFtIThqOzE+0PeF9x0MnF
 sofuoOQMsekiMLTsen21odN9amU+eUsHgujfD/Tn5B2hR5YemE8rquwzUcCjoIorlmtCxqbm1eZ
 6XZZ7kdmlJXM1pMFhp/Fiy5HLR7k4ygxvBltTK98djUTVO9ai0DKChalBI7wQcvYHHr9Slh4VRh
 IIbhWuHASCJ4z4Mi8+OMGE8QgsJZMsIT06NBbyvuNuZhuqkHPBX64icDkVLoTEBRorkZ4XLcomy
 X3FG81nc2ej04ToYFX3lPSCAf6mDzrRC8W0IGYjUkzCiNZjQoFegpBCKzCD1pX7rpmYH2m1/Tbo
 6DXA2HLtOceepig==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available rotation per planes. VKMS
supports any rotation and reflection, so the userspace can choose any
combination.

The supported rotations are configured by writing a rotation bitmask to
the file `supported_rotations` and the default rotation is chosen by
writing a rotation bitmask to `default_rotation`.

The current interface is:
/config/vkms
       	DEVICE_1
       	┣━ enable
       	┣━ planes
       	┃  ┗━ PLANE_1
       	┃     ┣━ type
       	┃     ┣━ supported_rotations
       	┃     ┗━ default_rotation
       	DEVICE_2
       	┗━ ditto

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 102 +++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index ee64243396b3e586f76ff0671441c172da022421..d121cf54e75238bdb582362596a353682cceebd3 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -54,10 +54,112 @@ static ssize_t plane_type_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_rotations_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane;
+	unsigned int plane_type;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	plane_type = plane->supported_rotations;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", plane_type);
+}
+
+static ssize_t plane_supported_rotations_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct vkms_config_plane *plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 0, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+	/* Should at least provide one rotation */
+	if (!(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
+	mutex_lock(&vkms_configfs->lock);
+
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled || (val & plane->default_rotation) != plane->default_rotation) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+
+	plane->supported_rotations = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
+static ssize_t plane_default_rotation_show(struct config_item *item, char *page)
+{
+	unsigned int plane_type;
+	struct vkms_config_plane *plane;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	plane_type = plane->default_rotation;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", plane_type);
+}
+
+static ssize_t plane_default_rotation_store(struct config_item *item,
+					    const char *page, size_t count)
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
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+	/* Should at least provide one rotation */
+	if ((val & DRM_MODE_ROTATE_MASK) == 0)
+		return -EINVAL;
+	/* Should contains only one rotation */
+	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+	mutex_lock(&vkms_configfs->lock);
+
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled ||
+	    (val & plane->supported_rotations) != val) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+	plane->default_rotation = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
+CONFIGFS_ATTR(plane_, supported_rotations);
+CONFIGFS_ATTR(plane_, default_rotation);
 
 static struct configfs_attribute *plane_attrs[] = {
 	&plane_attr_type,
+	&plane_attr_supported_rotations,
+	&plane_attr_default_rotation,
 	NULL,
 };
 

-- 
2.47.0


