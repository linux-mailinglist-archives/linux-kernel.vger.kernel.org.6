Return-Path: <linux-kernel+bounces-519924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A5BA3A3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335F416F301
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E7270EAF;
	Tue, 18 Feb 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOAKHPss"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141626FD90
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898502; cv=none; b=Zy8JMVCa2+KKqRp2yMoMIu/Hb1pGeaXLub/4CjtZmUUVspNZDNWfiPR49RwgAXffWP8lR/VqnZKvn61mshp4aIqRjQ+sJwDt4bf5QXb297e5GsyV0QMFGWYP8HK4sPNc58j5kprIEepNfr2+p6r4Z4+WGmcYXxl+DuUXfK3guPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898502; c=relaxed/simple;
	bh=XitDAvUM1Wx5xFhJ7Os5VQ2nlEn501y+yZnDKuH2EAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPwmls29YokYQu/6nRNK6Y5dzengyP6YWL9EqRC67W6a5eS5nNuLGUQXbOi+8G3d7hYdy3JNkWWA30Zd7HZ303hwzU9uy0PoalhY1EU6BxWC6zF9rZOaimHKa8VkR14n3SDXbnkrbpkJfjTwFqbRZ8KeToYL3hHGbgw5dj7x8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOAKHPss; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso64099655e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898498; x=1740503298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8R03JFVj2NKekAWxfkOZ96PWx+yt6w/rnA7LR8wx3E=;
        b=lOAKHPss8+7WbAMjm0djjUQ5vxrneCrLwr7maIswxgcokt4NPGUAUUu9ZDDw3fP16u
         8i7b3oCPDKadc0LTDLPmcmD2VWDXoCNMe62Sf+h3i5xk6Ka5hww9V0PPu5p47ITuZ6uv
         p1S2caGhBUmzS996YAw16KAjXRLeD9PURLsMEhGI22ZED9cBl1Gk4ZeQ26mDa1wPc4ee
         gSWMzEIj8MR7nqrvzXnAhTj+xAoLHC/fnk1Ekx7nUTAZi54DNRx2zgFjDrVmzV0UHJX8
         pcwsa8SjCk9scqXiGk/sIgk693Z7JQsxzjPt9YXEa3+wYqRyuQt/zuVD9tenzLspM/kI
         CKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898498; x=1740503298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8R03JFVj2NKekAWxfkOZ96PWx+yt6w/rnA7LR8wx3E=;
        b=kEaEURPe2+gLxfco69D3ibW2AGe7R+GG4ZAmbqBSXQBvIx79X+89V5IVBUchC8SoVS
         9JWjJycpx2DgOVRJjT6TOSWsfkPsK/OA8ihISou2uPzsSNRRkJ4NQJi8X64Y1rNDxlTl
         e+YLD6IzEjskTGjYWUKO5hruem7XF02kxeVOF1VEUrIxpSVAG2ycGFvWidXmCTUNa/Mo
         OcVkZEKIeGSls2Ojjf662Kr/Qr02SNJ94KAv7FvDMtuExtvVem1/fyWQGvyppRwVlUdH
         d9j95s2RVUebgrlY+xCcGZ9bWL6LxtGyTtpDEjAL5t3JXsu6STZ+3bbgZxAC5J24s70H
         qeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOEkthsLvw23ErpJmIab1WoagRMPqMEzOVyVnkHurb5Isl2r7IivEouYtxP/VcGS/zGFRdjefXc3WiJnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKN9nLQpFrAwIynp+LGePLV5qz1bJT3y76JAtaNAbpO6zfcaZV
	zjIB452TH7VPzv92bMFjDTwU5OZYFx3PVYoUKadAAbdIUrAeHY4D
X-Gm-Gg: ASbGncufHqYoDtJbvwDaFdILJ1dvLQNDUMNDGHpPq9Td+/DrOBGMyqUgluJv3/bu3qd
	/uO93ZNAWd4mRr6LzKDXQZO0/3IG4Gg3obcY4/Tw6UkMoWskEk7si5LbpSa2xQvmxb7Kv2qV2Nz
	Hm6Rl943YrDn28E4WtTmBr3hUraUyotHduIB3WNOv9EZxmZkDnbpnRc2S4IBmxxdeKG2ZLrksqq
	EahgTVWfFahVV6d/x54oKlryOYj2K6vz5Hz7w2/mdM9/eLmb5+DhFQlIoQX5P28sk8fdlFzL2S+
	ZR0hVxHBB2XE1kAekQ==
X-Google-Smtp-Source: AGHT+IFHJhZKf7IH9i9zM3eHxhLXuccFXsGBcnnRTeEzbT9cC2YctBvx2HRssvzKQvcni8dI79RnDw==
X-Received: by 2002:a05:600c:4ecd:b0:439:35e2:bb45 with SMTP id 5b1f17b1804b1-4396e6dfd41mr152201005e9.18.1739898498201;
        Tue, 18 Feb 2025 09:08:18 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:17 -0800 (PST)
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
Subject: [PATCH 04/16] drm/vkms: Allow to configure the plane type via configfs
Date: Tue, 18 Feb 2025 18:07:56 +0100
Message-ID: <20250218170808.9507-5-jose.exposito89@gmail.com>
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

When a plane is created, add a `type` file to allow to set the type:

 - 0 overlay
 - 1 primary
 - 2 cursor

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 51 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index bf23d0da33fe..d95f228de05b 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -84,6 +84,10 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
+Planes have 1 configurable attribute:
+
+- type: Plane type: 0 overlay, 1 primary, 2 cursor
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index dd9dfe51eb3a..093735f47858 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -54,6 +54,56 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+static ssize_t plane_type_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	enum drm_plane_type type;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	mutex_lock(&plane->dev->lock);
+	type = vkms_config_plane_get_type(plane->config);
+	mutex_unlock(&plane->dev->lock);
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
+	mutex_lock(&plane->dev->lock);
+
+	if (plane->dev->enabled) {
+		mutex_unlock(&plane->dev->lock);
+		return -EPERM;
+	}
+
+	vkms_config_plane_set_type(plane->config, type);
+
+	mutex_unlock(&plane->dev->lock);
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
@@ -73,6 +123,7 @@ static struct configfs_item_operations plane_item_operations = {
 };
 
 static const struct config_item_type plane_item_type = {
+	.ct_attrs	= plane_item_attrs,
 	.ct_item_ops	= &plane_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


