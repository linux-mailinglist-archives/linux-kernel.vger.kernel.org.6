Return-Path: <linux-kernel+bounces-519934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C0A3A3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1EF3AD419
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312727FE74;
	Tue, 18 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP7f1igo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418C274252
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898514; cv=none; b=RAwwubHswuW+afdsNu64LRkdYmU1z5YeFyzlp17WhvwN+DNHA4sPHVyLYEc12QpBzYKLp+A8Trc4+ApTwrP19R9+9gzSgQ8EMdxTjq7nmpgP1gFL54lgnYYsr/wVRaUCWnxNkmF74LvqVCAtHzKgIVjxEbTTmN10QuhrbE4BVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898514; c=relaxed/simple;
	bh=cP/vJyUBqJiIoGO1WrOZ5V3xdt/E8aOXvrwvz5xVmvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlATIB6RlS3+5KfeSWJd/ITVXEQfSOr/W0rKlHEjEB2o1t2ctD3u5eN2iBRsOxQocreCD0m17BW05ON0/istk3Hek3f0quX3Q31f2e8JsMG5OX4anp8oNCh6VQpJ9kn4bGMtJfzOliA4afq17ydu6H6SsiYJVLLWwK8Tl7+ak88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP7f1igo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so35592255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898510; x=1740503310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlEG/chzPR/lrdsujZEdOLY/tag0kKNloUyKVadlYPE=;
        b=bP7f1igoOuxXb2rpEFZ6rnplIKAcXMesKODCrWbWmu5QUBHMRDpsvjSJ7MwyFocA+E
         zlLjMrJFScAOu3e3TVGXETnnuwpAeMmlewkKH3tMGM3sCoX6fmAuIUzgO6loR+9apqqB
         8ggB7EGzKLMrGMhJdeBBPfKWeS4GpOwywoFJ8MZl7l1zqeExjrXkRIl70FWad6qpW5io
         85OpB0Cd0sQqAv0mTn3JKv7qxbmxx8HqTcNIOGk++ZylMDAEFboj81JKCRSm1fh0RRc7
         R6JnL7TEcnQYeVsj6gZFZVotALPxmFTlM4anekZRcqv6pOJu93nqRc0bBvSN5i4qstSu
         zP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898510; x=1740503310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlEG/chzPR/lrdsujZEdOLY/tag0kKNloUyKVadlYPE=;
        b=lvg/MMicGuHI8WvpNruPZJWlBCHbC8kvjUz6lNHV1PkteV8Ah3Qo90QNYYJeKaMNRq
         JtXC2g32jpDrm8nlJJ9EarUfAud19vHvarD7y+Yl9T/9ewxdz9S21Kkr70nHjxmnH7C6
         1YKA+0zE+wj+lKd4v6w8oPTTQJ+hcu7qnYnI6t0e3RU8OWDN7W9zNrjvEBcsF+Iux0fw
         E+2dC1S730q1lYTQXTGhCeTycRCgO4ctDWDLdyHzlwLStGGaji5e0l1IOJkgvn4Eq2A2
         xhddr8VFhQvxxkv1p/+f62G4WsT+P4C7cQ4PeXbc8mFolM3fFO1xUDZecbnNeXukvDnx
         fBug==
X-Forwarded-Encrypted: i=1; AJvYcCUAKAVZ62avZhfr6pdgQQhq1ifZxfZBestvKxoDzCM3nCbzXO4lkGMhpZZ1qHFz7oRDR4tN1dvojplHrCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnJaDCGhx4Lrj+u2PSqxlqE4qU06nAtEqoWRUXVGuqB75gzYc
	gfkB0QKPHiPKXjZ7zVc/7h4veaJgaiUBeQA9TJXkP97n21/6O4tI
X-Gm-Gg: ASbGncvfD/rbo6OMwsR+4BKRf6r4WU4ZS7aMIyoO2/MPQeWv0qxvHi8lHzcViNr2CgJ
	hhszadYFu42lWfCWb+CL9vZfetrB6QXAkzyA4ZMWN15lQEdfY1tA5frrZ0VTTqbDpRPHgvFEAQ6
	UZ/1QAiLA0PMZUgruJhZSCdGzv3Ne2xo6aeIo5Ns68Eal0Y8GkkGjB5Tkg2pEdH9//i1rLEPFLu
	Cl8vHs/Yn+ifVFV7sR2BQuoMkxXwXbSItdkCBex1dpJeO38fxhNoRWiPmvXDOdGCV9CF85kSjBS
	4AM7VVsDYYCp0MuX6Q==
X-Google-Smtp-Source: AGHT+IHJmx9NR3wfEj00ecrWtmWoVJ6ofaJLqeLW5MRWaQuX9F66y4B2x+CLpKatjE9UzUn3+3O1BQ==
X-Received: by 2002:a05:600c:1c86:b0:439:9863:e876 with SMTP id 5b1f17b1804b1-4399863e985mr13677105e9.24.1739898510369;
        Tue, 18 Feb 2025 09:08:30 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:29 -0800 (PST)
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
Subject: [PATCH 14/16] drm/vkms: Allow to configure connector status via configfs
Date: Tue, 18 Feb 2025 18:08:06 +0100
Message-ID: <20250218170808.9507-15-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
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
 Documentation/gpu/vkms.rst            |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c  | 51 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_connector.h |  6 ++++
 4 files changed, 68 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 0212e99e12dd..3068879ce1fc 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -107,6 +107,10 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
+Connectors have 1 configurable attribute:
+
+- status: Connection status: 1 connected, 2 disconnected, 3 unknown
+
 To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 9036d9983078..f0813536be12 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -6,6 +6,7 @@
 #include "vkms_drv.h"
 #include "vkms_config.h"
 #include "vkms_configfs.h"
+#include "vkms_connector.h"
 
 /* To avoid registering configfs more than once or unregistering on error */
 static bool is_configfs_registered;
@@ -567,6 +568,55 @@ static const struct config_item_type encoder_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static ssize_t connector_status_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	enum drm_connector_status status;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	mutex_lock(&connector->dev->lock);
+	status = vkms_config_connector_get_status(connector->config);
+	mutex_unlock(&connector->dev->lock);
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
+	mutex_lock(&connector->dev->lock);
+
+	vkms_config_connector_set_status(connector->config, status);
+
+	if (connector->dev->enabled)
+		vkms_trigger_connector_hotplug(connector->dev->config->dev);
+
+	mutex_unlock(&connector->dev->lock);
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
@@ -586,6 +636,7 @@ static struct configfs_item_operations connector_item_operations = {
 };
 
 static const struct config_item_type connector_item_type = {
+	.ct_attrs	= connector_item_attrs,
 	.ct_item_ops	= &connector_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b03a00b5803a..ed99270c590f 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -76,3 +76,10 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 
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
index 5ab8a6d65182..7865f54a313c 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -33,4 +33,10 @@ struct vkms_connector {
 struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 					   struct vkms_config_connector *connector_cfg);
 
+/**
+ * struct vkms_device *vkmsdev() - Update the device's connectors status
+ * @vkmsdev: VKMS device to update
+ */
+void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
-- 
2.48.1


