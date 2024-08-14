Return-Path: <linux-kernel+bounces-286734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F1951E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0077B1F21760
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B51B86F0;
	Wed, 14 Aug 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ohIAGA8F"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E91B3F22
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648568; cv=none; b=Gztn751+q8N127qwJxOgBoLgDoKbMdg+m9iw13FTIB8zZkPSP/WOIIIb+R9txNY5RzSt/3qM72TxgHOKE953q83JdssjiGTBxEo7+UOXGXGNrlc9V00k+KSM8tmHqm8U1ySuwsFjLRCThIdtmtpfhLyplDHd5v3e93J+iFA2HjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648568; c=relaxed/simple;
	bh=J/CrkUPTSbciCxHTSvcXfOPmoAO3X4cKNlwq2Imz+Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8heDLvswunNBVFEwOc/odmCcGog77e3G0nG6ZQ9e2STzB50NeLjsKbFIg3GFB6cBK/jFNkBBiNVm2AzRf3hLSnXxWajL/IFr3VUiQkKSYNvExPCifL5FmHdGLnk1KBvk2OqFdhs2MVl9TX5eMgDyk0AsiRxJFKEDvtYstPkfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ohIAGA8F; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 333B060007;
	Wed, 14 Aug 2024 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723648565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDmGLaOI4YxgN9O9B/IDiZjMLxVVtDfIXivTYF6tc+8=;
	b=ohIAGA8FNN+8tEtC8aZhBFSVIgxRixUT9unp227YPPLXnyyN5aznqEfT/tFMlBFS+xpAwQ
	rpQcazgN09e505m4F9Eu12SNb1QaSj/hDWc8AhQcNItgVH6PcVpD3wVBhXmN2L6DQH40i0
	rg5hIp6expPjAeJ4daCn5Vu5ohzK02NfJTMkzGw72MgSXDVem5hPqHjPfQgN7NiX9EeSoA
	ZYziUVmk3L/8z0yN1CjwB5CSkNfUkImwSyXhW56nm9xokl/xml+/yxk7A6CRS5dOotRzBe
	ZZJnGJ/4bMlKDm7mDrINryWkqmg3GE6UP3XxG/ywZmPsHmEWpfORorYWc5cFlg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 17:15:52 +0200
Subject: [PATCH RFC 5/7] drm/vkms: Add color encoding to ConfigFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240814-google-config-fs-v1-5-8363181907a6@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5372;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=J/CrkUPTSbciCxHTSvcXfOPmoAO3X4cKNlwq2Imz+Iw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMoufAdtJ//ZKjEqR6xQiaH3lweIyo4Lkazql
 hbbGxsInEaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzKLgAKCRAgrS7GWxAs
 4mPOD/0cXvM+XmKaEH539iSdAFe2WgPT81FqczRW/O9nurF7UYpBEuP71/0sIZFsqoWUjqGlPd9
 /a7ISp54UaZZ2FYhaYBPQxBLcsv0nuhaj4BIfE/nnLzKn9xiWDWJLfSq8SU3hItQ4ngecPMnEe+
 /ju0hiloEql++XXgKZOlKF4iodqjAjRA7YHsrcE0/u22uua47WDVeXvb4prfRDlrbOGiCZmsei1
 tL9lcg9oC5xSw7+je9C+zaHOqRp72ETGKV7A7hZSXOo6emzUhh+j1nhUkxJabiGqag7Jzfq5jwo
 BisY7QaBWHktjWhwsiIqQhIX48eBqRN7L1cQR6h4prUGv7nbARdI54+cSVT53VOSMx9VFhJMqw4
 jBmLM1GVDN/rCszFIn4yjL0t9AJewLd31wB4rBe5Jv5GOAgNYz0PzH+2LMfTw8bRbhUqThaRKuR
 40F2x/OWC97qJMGkgM9eG3PJewrd+bmrhJMKXbaZNunwuBOkRM97KsZjp3d+E+nHbawX/Ce5B4Q
 s37+Uf+QRt/maIzLJKIbS4+ukPw7PAVtcMZh7Bt99A0coCuah49WAdh/37+DCbQtg/JZmOMqFwO
 pqldk+OIqxFRf9TFjRKXJOg7hy5mRsO2yunNvTueD7fazfaXsBezXw3mlDt8T3XYv2ASIRpyDQD
 zF2UnWc8yin6Ljw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color encoding per planes. VKMS
supports multiple color encoding, so the userspace can choose any
combination.

The supported color encoding are configured by writing a color encoding
bitmask to the file `supported_color_encoding` and the default color
encoding is chosen by writing a color encoding bitmask to
`default_color_encoding`.

The current interface is:
/config/vkms
       	DEVICE_1
       	┣━ enable
       	┣━ planes
       	┃  ┗━ PLANE_1
       	┃     ┣━ type
       	┃     ┣━ supported_rotations
       	┃     ┣━ supported_color_encoding
       	┃     ┣━ default_rotation
       	┃     ┗━ default_color_encoding
       	DEVICE_2
       	┗━ ditto

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 107 +++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index d121cf54e752..a3dab5986882 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -152,14 +152,121 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_encoding_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane;
+	unsigned int supported_color_encoding;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	supported_color_encoding = plane->supported_color_encoding;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", supported_color_encoding);
+}
+
+static ssize_t plane_supported_color_encoding_store(struct config_item *item,
+						    const char *page, size_t count)
+{
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+	struct vkms_config_plane *plane;
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
+		return -EINVAL;
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled || (val & plane->default_color_encoding) !=
+				      plane->default_color_encoding) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+	plane->supported_color_encoding = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
+/* Plane default_color_encoding : vkms/<device>/planes/<plane>/default_color_encoding */
+
+static ssize_t plane_default_color_encoding_show(struct config_item *item, char *page)
+{
+	struct vkms_config_plane *plane;
+	unsigned int default_color_encoding;
+	struct vkms_configfs_device *vkms_configfs = plane_item_to_vkms_configfs_device(item);
+
+	mutex_lock(&vkms_configfs->lock);
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+	default_color_encoding = plane->default_color_encoding;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return sprintf(page, "%u", default_color_encoding);
+}
+
+static ssize_t plane_default_color_encoding_store(struct config_item *item,
+						  const char *page, size_t count)
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
+	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
+		return -EINVAL;
+	mutex_lock(&vkms_configfs->lock);
+
+	plane = plane_item_to_vkms_configfs_plane(item)->vkms_config_plane;
+
+	/* Ensures that the default rotation is included in supported rotation */
+	if (vkms_configfs->enabled || (val & plane->supported_color_encoding) != val) {
+		mutex_unlock(&vkms_configfs->lock);
+		return -EINVAL;
+	}
+	plane->default_color_encoding = val;
+	mutex_unlock(&vkms_configfs->lock);
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_encoding);
+CONFIGFS_ATTR(plane_, default_color_encoding);
 
 static struct configfs_attribute *plane_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_encoding,
+	&plane_attr_default_color_encoding,
 	NULL,
 };
 

-- 
2.44.2


