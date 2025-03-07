Return-Path: <linux-kernel+bounces-551553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED740A56DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8183B7A9D37
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA72459EE;
	Fri,  7 Mar 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQqfZTmj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D42459C2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365264; cv=none; b=a0JFIAlco22phejAmA0yzaRhHMj+89J9XNazR/e9FwPi88df+tWzx/cZTDpM38YZS9kwyVz9BXJCs/SqocMKhOeTTbRuHsl/Pd9euvOsSH+DoUzdIdhJxIwVEplPyNDyJXZvDrmuspojdCXU0MsOC3I2oFHj07QNYsuWgqtsnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365264; c=relaxed/simple;
	bh=UaHEGZDcjpFQM+/91kkr8nzcxY1detjrCFlN+Zq5nB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnQKCe7KFCGyZeOQ/w4ZXGKFVASVUPB2io7ypwDcIp8MF4n0IdyWVelgN9Ruv12FBJeCBUVql2Dyw7H6UYDvtE3zoP8LQIzeJQj2MPQaaMgbYWDqrG8zJuGLFQT01efohNSW7jWKz7lu20fvtLwOiaTkObdTuv+/rxpXgBSLXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQqfZTmj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bbb440520so24117415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365261; x=1741970061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK4w0zRijqvJSQy92+j3ZDq7C+G47BlmHwixThFbhJo=;
        b=lQqfZTmj1emrMPM9GLLcZ+B0gd0HVLwpahXPa9DJkFPiThejWlZCYApXaIage6Z0Pv
         0FqZDpjMUJ5XVNynncfxK/JQ1VpJm4NTGYRGczquErCklvCho0UpApZFG0aiTKm40JS6
         PLFl0SpWTPMNxeOyTeV2TIAYX5zWQnoDgZRo9FBjpkiiWfJxom/xxEJT4GskzFtLASu8
         CnSSDLzhhrHy1mcZqoc63ULs3ch5eK33ecfk0d3iSGFOYMP+267AWEH/TWl9m2f7RKci
         1J095vYA1+J/BVKgBhwRaEFXgnsGbAC4jMk9CMGedXkLvIBdicPD+/gH+jGVUxl7ZLDc
         zKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365261; x=1741970061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK4w0zRijqvJSQy92+j3ZDq7C+G47BlmHwixThFbhJo=;
        b=hF1wa6pLVE46FWw4d+A4FAP/2Hf49cTuGV4h7I+U6LOr0ZfwzwMZWr0bNHGqRaA03s
         3rcIC4U00Xz5vtvA4r9w6RM6/r+cEOj2AO6l9kkyS+FnlDJEAZqTUMOHaqpwETuwswue
         hTXISPfRmzC7I6L87MuxJbDtX11em2GGa7vNWozfBYNo2et/3MiZDcfAOs3S7dkERwfe
         BvXGpH1NGbimTt/Quj9Lax68IHpByfqRbAdKCq/2iPitkad1EBRG1magAlrCkk9QKpQI
         XvXZ6hwZr5YP3NkXnFk12TOg1lwBclsP/I4cTg6Y1pHX4EDEBfup+Pl5ObX/RIlDC8ZJ
         ZYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR8ItIArKrBlWlVLWT9GwyeRPnksmXAqahzWVdBLyjOjU6pKXN/YCowqYRLIQG0SgtgfKDwTsFw+B70ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PCV1MjiYFH7hncOW93y9nLgTRmt9N1obLeuj2JdXWTuRPySV
	nZiLeITr7hQjdu5hFNRI/AU9EHmAfG8AsIUyOV786RP2jNLyazYR
X-Gm-Gg: ASbGnctR4msV+3D/QlbG5O1p+7pu7rySNtP7z581EFcD4iJ/vkks6JQ54sHKflxZ8iW
	RTv0+Hrd3tEONJJaWzYYl3naXW/q5e0JjcJGJZlNFr2LQzsijRXAhyS8Sp7r7Wd225svhi5TqNY
	l9qKldmENjRm3nd1l/9iE9qkkf0kLD8FWOXcK4fdnjC0YBJvYXE5awRWgGHL0L6cm1PYpsJ9zsX
	wDuobG5kUbcC0HoBQT7cVe7AfxScB6pUhijHAgWX/bjD0s9TRlTsr7HNMmmLx50+RRvWp+cTu3Y
	871/FNRqFp/SPvNvhFhSI3M+zAYD8UtNhyGgFQhewRulphM=
X-Google-Smtp-Source: AGHT+IFIs9tK6Ia3HZmasKFOBkOZ5DkA964+wt56EXCns6wInJJjqFt3Tdwt5ChZJns81z6POSdXoQ==
X-Received: by 2002:a5d:588a:0:b0:391:298c:d673 with SMTP id ffacd0b85a97d-39132da2286mr4274440f8f.40.1741365261208;
        Fri, 07 Mar 2025 08:34:21 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:20 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 16/16] drm/vkms: Allow to configure connector status via configfs
Date: Fri,  7 Mar 2025 17:33:53 +0100
Message-ID: <20250307163353.5896-17-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a connector is created, add a `status` file to allow to update the
connector status to:

 - 1 connector_status_connected
 - 2 connector_status_disconnected
 - 3 connector_status_unknown

If the device is enabled, updating the status hot-plug or unplugs the
connector.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst            |  5 +++
 drivers/gpu/drm/vkms/vkms_configfs.c  | 48 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_connector.h |  6 ++++
 4 files changed, 66 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index c551241fe873..7c54099b1dc6 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -108,6 +108,11 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
+Connectors have 1 configurable attribute:
+
+- status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
+  as those exposed by the "status" property of a connector)
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 8e90acbebd6a..07ab794e1052 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -7,6 +7,7 @@
 #include "vkms_drv.h"
 #include "vkms_config.h"
 #include "vkms_configfs.h"
+#include "vkms_connector.h"
 
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
@@ -512,6 +513,52 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static ssize_t connector_status_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		status = vkms_config_connector_get_status(connector->config);
+
+	return sprintf(page, "%u", status);
+}
+
+static ssize_t connector_status_store(struct config_item *item,
+				      const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	if (kstrtouint(page, 10, &status))
+		return -EINVAL;
+
+	if (status != connector_status_connected &&
+	    status != connector_status_disconnected &&
+	    status != connector_status_unknown)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		vkms_config_connector_set_status(connector->config, status);
+
+		if (connector->dev->enabled)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(connector_, status);
+
+static struct configfs_attribute *connector_item_attrs[] = {
+	&connector_attr_status,
+	NULL,
+};
+
 static void connector_release(struct config_item *item)
 {
 	struct vkms_configfs_connector *connector;
@@ -531,6 +578,7 @@ static struct configfs_item_operations connector_item_operations = {
 };
 
 static const struct config_item_type connector_item_type = {
+	.ct_attrs	= connector_item_attrs,
 	.ct_item_ops	= &connector_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 89fa8d9d739b..b0a6b212d3f4 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -87,3 +87,10 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 
 	return connector;
 }
+
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
+{
+	struct drm_device *dev = &vkmsdev->drm;
+
+	drm_kms_helper_hotplug_event(dev);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 90f835f70b3b..35f2adf97e32 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -26,4 +26,10 @@ struct vkms_connector {
  */
 struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
 
+/**
+ * struct vkms_device *vkmsdev() - Update the device's connectors status
+ * @vkmsdev: VKMS device to update
+ */
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
-- 
2.48.1


