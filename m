Return-Path: <linux-kernel+bounces-551541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54945A56DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B81899BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1A23F410;
	Fri,  7 Mar 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo8Cz2sA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1823ED74
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365248; cv=none; b=jnUjYN7inwtEMMUKXM0s8XnP1xyYsQsYc0Bi6OyMUbJtII/7XSnhgxoc5WgEcWOn9vs2WM+v8xKMLHPWD3e4MdVOPkPwFfospnuqRUu+MgJ/8dJfw7XruU9U+elLhdqSstgfjac9cxqWpuVcBb199L7u36trF/SjIyw/UO+1W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365248; c=relaxed/simple;
	bh=DlHzaQ6+kTsVPKWf0eXgOzJnInQyREV1NJneAk827rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmMA/GgBIPbkVHmnoy+2sezsJEQtlY1P3yQztUeJdVoARtbcN+PTLr6QRed8fENWjnbaMRa4D7zt6bn6CAA7uSyicVVYIz8w6lduzjic8OdvcCsudrIV+8WVhAZkvvUwXerjusLAH+nw6Uh1hSwg7Mez9SWJv1e6hVGXrW+kjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo8Cz2sA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390cf7458f5so2050993f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365245; x=1741970045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MV2OWA6Mh9vxWtK9J9PJqfJQiomHto+OaIeMpCvYMU=;
        b=Qo8Cz2sAF9UDi5WehnqBHTyj5HOpR/QmSyY45bqFOk6kIy+dG79ztmxkXqsuzeUf8J
         33tZKeIORqwP2dLEWn5KT7AiOoyoJRYZVNsAhtWJ51cfdwQhz5pRsAZg9gU18upS3QU0
         d/3AwOczpeQaiSbaWwA2ULdrdQlFuLvUhZqq7OBu4pgrpmDAnYocb40jDkAh1Vuw1+Rz
         2axTC+h5meWnD8cvaRwstu1t9FbrJifoAk1L1mdSBF4oWmSSUOuyLlUV3DLp6rBoBbdF
         YcfpnbNPt3D1utgem0q7Lx32Pdcjf3mwBfva1bZc2McZDxStjp1FFB4Bdm80pNp1WlVE
         Lg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365245; x=1741970045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MV2OWA6Mh9vxWtK9J9PJqfJQiomHto+OaIeMpCvYMU=;
        b=LpjfBYUaThatXSsL6TkR4iCuXUgZtt0Z78TNdZHh5x+xQigWYjH74O+9gAzrbK3zWL
         55g446AjNzpq3INbw9djNh5+YWhOBN7dkE/YJsSpM1x55QVfFrZp7ttSHZ1bGEcNq8W6
         5gg8emuwekHbxkFvAJk9RvOvdd5Es19nZBN9O4eSSb5XcLKjsiTMSKtt0VRxKTTpqmc+
         6Yx6NyrZ0tqK9069BJpaolXSDPs2VsXQhchVqkAKYO4zcDURtDRRX3Ju+59G5tA/vj+p
         olSmzWQ7vNS+wBBj7lAqlqCb42bXAvA2y+K+Hz7GPmJdngexlx9YvQNuBxdw9MhTDS7j
         jHKw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqqY3JoGuinDEK0KHVr2N4XrBus81PbWyJIZgaz+AMbAAl+erVQLhu03zsO/2LfNU7xvJe3MlfdLcaoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCouIGRpnWAbrcbA1HyAGMMd4/p5E4LXv6CIBN9JgT/SsJLlTc
	iz9jWmO8G19UWN2TiOqVScjMfQu80j2zJwAnfQS53CwqIh/7dxIt
X-Gm-Gg: ASbGncuk66E0OamyzURcXoxfd1L+jyvyOLeMhVmjnogt95dHVf+lj9jPWtWJ0LBaKtN
	1+P1LnTlafFvgtIUCZEYsdhVDcT71Sq8T4LrSfx6j+WZSJDvo1F6nFPI6xnOtbUIQvjcouVcP+H
	d1u4s4V9LtirS4Rurzza4VZGYjwq76Jg/2vC+6MgYc8vrjiX5uV+vbChbC9iopBXzbJMbAaZxz2
	F5duFaORoUim94AEgy4mnj++YzIfxdZryeH/4GDI+816dUrrBJA37at2TA7NC50/QKdfclxhzGR
	Egrjh70XG53orEJ+jnyoW6EYCo/Qh8m64wdOT4gk/+LINK0=
X-Google-Smtp-Source: AGHT+IHy6prLRyeDeLBBqQYAih4z7dhF8ZsgqaozMxKPj1Kdi9OZe1sSmPCaA48+hp2UIfpfozoC+w==
X-Received: by 2002:a5d:47cd:0:b0:391:952:c730 with SMTP id ffacd0b85a97d-39132d09078mr4081895f8f.11.1741365243576;
        Fri, 07 Mar 2025 08:34:03 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:02 -0800 (PST)
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
Subject: [PATCH v3 04/16] drm/vkms: Allow to configure the plane type via configfs
Date: Fri,  7 Mar 2025 17:33:41 +0100
Message-ID: <20250307163353.5896-5-jose.exposito89@gmail.com>
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

When a plane is created, add a `type` file to allow to set the type:

 - 0 overlay
 - 1 primary
 - 2 cursor

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  5 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 46 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index bf23d0da33fe..a87e0925bebb 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -84,6 +84,11 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
+Planes have 1 configurable attribute:
+
+- type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
+  exposed by the "type" property of a plane)
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a7c705e00e4c..398755127759 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -55,6 +55,51 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+static ssize_t plane_type_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	enum drm_plane_type type;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		type = vkms_config_plane_get_type(plane->config);
+
+	return sprintf(page, "%u", type);
+}
+
+static ssize_t plane_type_store(struct config_item *item, const char *page,
+				size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	enum drm_plane_type type;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &type))
+		return -EINVAL;
+
+	if (type != DRM_PLANE_TYPE_OVERLAY && type != DRM_PLANE_TYPE_PRIMARY &&
+	    type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_type(plane->config, type);
+	}
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(plane_, type);
+
+static struct configfs_attribute *plane_item_attrs[] = {
+	&plane_attr_type,
+	NULL,
+};
+
 static void plane_release(struct config_item *item)
 {
 	struct vkms_configfs_plane *plane;
@@ -74,6 +119,7 @@ static struct configfs_item_operations plane_item_operations = {
 };
 
 static const struct config_item_type plane_item_type = {
+	.ct_attrs	= plane_item_attrs,
 	.ct_item_ops	= &plane_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


