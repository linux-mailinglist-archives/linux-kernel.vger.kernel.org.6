Return-Path: <linux-kernel+bounces-519923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB2A3A3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D758C188CEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313E26FDA3;
	Tue, 18 Feb 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBMVuIUd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66626F46F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898500; cv=none; b=VJZaXsikTkViOcPJ5hO/cZ7o3oPEYcMuF00vtqJpw3FrPybBkcbh0ptNmc9tu8+jHMEuDlt7UJnuHEU58ZnKr9iP+1rpvrZ3Hqqif4npGGxYO0PibxrAADpq26OjB3SYWpv2ntVN4Sx627gilu/+BzB4mJ/e1lYC/npiWZIYyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898500; c=relaxed/simple;
	bh=rzgWkrbttX0Ywyxe/JMBlAciu582uXAm1V0Cu2EAARg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0BdhRVDwmXtLlrO6qy7fBsdyyiGDF1snp85d51ZnJKqd6LVcyDSgwYImYq7Wu9XS4SAseq9Kj0renW8/OyMfFnPhSRQwj+yAtjFEXqSmDBxRkidmhAYlkrSZ6Wd9ql3pD4vxgc8wMKxOjArhoovm7IGdRUdKyznDXtiIOf9wpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBMVuIUd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43995b907cfso5894455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898497; x=1740503297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjhuBRdxXqW/2QEKLkzw2I4K7vjGSpOOdxc8AYlfvfY=;
        b=HBMVuIUdbCtVvoMRilakvU9+neJTGWpWPSqBXI9l2Nw20XQwWDvPvpcV26ZCUsv3+4
         y8qV7VWq9Ptb3NNCSinmTmRmF3zSEbQHre4NnFG/cLHWxY+NXZugwzKdb9lDIc2kaed+
         IKPdlO66Ztb//FYK/zUTOI8cRXnS+woAO0getgz5gY7X/onRDWgfw0s3h1yTBFaO9hyt
         +cyqJ73Mn0G/n5aovH6PZ8+qALBPEzkjEG8QobSTK9QUKXFdpl3tPXgnFaEBXyZEv0FI
         mlu2sTAlKtTlxXZi28MfMx2hKLaBvuFyow+DQoBbz2FlsscKXy7dDEbPKlLe0cWsPTGe
         DF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898497; x=1740503297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjhuBRdxXqW/2QEKLkzw2I4K7vjGSpOOdxc8AYlfvfY=;
        b=ju+TJ1FRDI4sgR+zPXbdyY2aHTY1nEcjYaStN3/HAOZ1ZkgknkPStZPz2nZFX7Vqex
         yEC6+E4xxwDBV/2yEnwxxbgTZ1v6lvyWRCvVhHR9h5fvVwBN0RID3yYlS+6KFjANvMcY
         yVB/TqgN13eU/V9xy9YOQx+lwb7RvTALaQ7gO1nTw56WUxG+kHOkniXwKPrFrSVyEWou
         F4K6WqRL3BzUjayMhiCKkWdmLp2B2jdVG/tO/6kjHhNuxzpYh33vi2PxuDZzlJEXDNNt
         rqgCRh4R2cJ+0GNctBAiMlHnxv7ulWJhHFK335HZCf391hpaKEjoKGIbHW5GFOKJZfsJ
         Qdmw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUDe+C9TmYJnxSe1wRgfM2dOItapjf8JY59zRyFg3lgACgQeAcoItZADADUBtYAjoxEh2kRO7T5pADPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6OSDk1ofwCvlNRHTacQmee4+VbCkqOfRRjmCCArdvM4cUo1w
	ZwtzKbX0WEVKAz27dhA+uot6pCxS6QLl+SPH5kYW3yDXqZE+XP/M
X-Gm-Gg: ASbGnctzzJNLyNTDeEmdMeo3srCFjre1pNj9qGf3x0+/Q8B+XEpnlJtCgpXltLC7rGd
	/dv0qSjErPI3Hw5JibA5TSEEgwHxGruefOpjr2tZHt35S622m2+uM9JzULzDuartSF6oUI9ypr4
	8muH1d4xduVMaUJhutpA/aoTqMj5WWvNMm3OgC9dq2/bY7Uz9ELMUVGlHrgZuJz2HTmQih88FJR
	JeNTx/CIlAHMNLhzr+NuT1YkRlFRgyNcozvruVspH0iNAY42eGPVhaB4Py/zFKDYNz24yKsbVbB
	2n+qMARrF1/L+G86Kw==
X-Google-Smtp-Source: AGHT+IFbJF9e5WdqgLAejew7B490btdgXX9pwq+ZzgR0AWX/aBt0neIv4ytIpTTz6pcQA9tCEhfsdA==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7324 with SMTP id 5b1f17b1804b1-43986fb738amr67674355e9.4.1739898496776;
        Tue, 18 Feb 2025 09:08:16 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:15 -0800 (PST)
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
Subject: [PATCH 03/16] drm/vkms: Allow to configure multiple planes via configfs
Date: Tue, 18 Feb 2025 18:07:55 +0100
Message-ID: <20250218170808.9507-4-jose.exposito89@gmail.com>
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

Create a default subgroup at /config/vkms/planes to allow to create as
many planes as required.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  16 ++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 101 +++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 423bdf86b5b1..bf23d0da33fe 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -71,6 +71,19 @@ By default, the instance is disabled::
   cat /config/vkms/my-vkms/enabled
   0
 
+And directories are created for each configurable item of the display pipeline::
+
+  tree /config/vkms/my-vkms
+  ├── enabled
+  └── planes
+
+To add items to the display pipeline, create one or more directories under the
+available paths.
+
+Start by creating one or more planes::
+
+  sudo mkdir /config/vkms/my-vkms/planes/plane0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
@@ -79,8 +92,9 @@ Finally, you can remove the VKMS instance disabling it::
 
   echo "0" | sudo tee /config/vkms/my-vkms/enabled
 
-And removing the top level directory::
+And removing the top level directory and its subdirectories::
 
+  sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms
 
 Testing With IGT
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 306f571559b7..dd9dfe51eb3a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -15,6 +15,7 @@ static bool is_configfs_registered;
  *
  * @group: Top level configuration group that represents a VKMS device.
  * Initialized when a new directory is created under "/config/vkms/"
+ * @planes_group: Default subgroup of @group at "/config/vkms/planes"
  * @lock: Lock used to project concurrent access to the configuration attributes
  * @config: Protected by @lock. Configuration of the VKMS device
  * @enabled: Protected by @lock. The device is created or destroyed when this
@@ -22,16 +23,112 @@ static bool is_configfs_registered;
  */
 struct vkms_configfs_device {
 	struct config_group group;
+	struct config_group planes_group;
 
 	struct mutex lock;
 	struct vkms_config *config;
 	bool enabled;
 };
 
+/**
+ * struct vkms_configfs_plane - Configfs representation of a plane
+ *
+ * @group: Top level configuration group that represents a plane.
+ * Initialized when a new directory is created under "/config/vkms/planes"
+ * @dev: The vkms_configfs_device this plane belongs to
+ * @config: Configuration of the VKMS plane
+ */
+struct vkms_configfs_plane {
+	struct config_group group;
+	struct vkms_configfs_device *dev;
+	struct vkms_config_plane *config;
+};
+
 #define device_item_to_vkms_configfs_device(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_device, \
 		     group)
 
+#define child_group_to_vkms_configfs_device(group) \
+	device_item_to_vkms_configfs_device((&(group)->cg_item)->ci_parent)
+
+#define plane_item_to_vkms_configfs_plane(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
+
+static void plane_release(struct config_item *item)
+{
+	struct vkms_configfs_plane *plane;
+	struct mutex *lock;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+	lock = &plane->dev->lock;
+
+	mutex_lock(lock);
+	vkms_config_destroy_plane(plane->config);
+	kfree(plane);
+	mutex_unlock(lock);
+}
+
+static struct configfs_item_operations plane_item_operations = {
+	.release	= &plane_release,
+};
+
+static const struct config_item_type plane_item_type = {
+	.ct_item_ops	= &plane_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *make_plane_group(struct config_group *group,
+					     const char *name)
+{
+	struct vkms_configfs_device *dev;
+	struct vkms_configfs_plane *plane;
+	int ret;
+
+	dev = child_group_to_vkms_configfs_device(group);
+
+	mutex_lock(&dev->lock);
+
+	if (dev->enabled) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
+	if (!plane) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	plane->dev = dev;
+
+	plane->config = vkms_config_create_plane(dev->config);
+	if (IS_ERR(plane->config)) {
+		ret = PTR_ERR(plane->config);
+		goto err_free;
+	}
+
+	config_group_init_type_name(&plane->group, name, &plane_item_type);
+
+	mutex_unlock(&dev->lock);
+
+	return &plane->group;
+
+err_free:
+	kfree(plane);
+err_unlock:
+	mutex_unlock(&dev->lock);
+	return ERR_PTR(ret);
+}
+
+static struct configfs_group_operations planes_group_operations = {
+	.make_group	= &make_plane_group,
+};
+
+static const struct config_item_type plane_group_type = {
+	.ct_group_ops	= &planes_group_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static ssize_t device_enabled_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_device *dev;
@@ -137,6 +234,10 @@ static struct config_group *make_device_group(struct config_group *group,
 	config_group_init_type_name(&dev->group, name, &device_item_type);
 	mutex_init(&dev->lock);
 
+	config_group_init_type_name(&dev->planes_group, "planes",
+				    &plane_group_type);
+	configfs_add_default_group(&dev->planes_group, &dev->group);
+
 	return &dev->group;
 }
 
-- 
2.48.1


