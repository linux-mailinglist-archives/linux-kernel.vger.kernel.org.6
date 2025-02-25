Return-Path: <linux-kernel+bounces-532148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C95A4497B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34FB3A64AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA071A8F79;
	Tue, 25 Feb 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjH1lkaf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70F1A238F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506389; cv=none; b=LswJ3ew0XwCnyEr0Y4924WVtx6WNwvOrO+JdzrMsm5UMCKex9kW/OYxxMQA+y7r4Pd6Xo5xY1NKVZX7hr+t3j9jd2/Zg+PDBLGeOZbnEo8G75Wr0NfuPA8r269oJY7iD6EkxuPpZYS1j1gQA49jOCu7LFx4jYu6gA35IqhKxs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506389; c=relaxed/simple;
	bh=YUvB7QHhz2oAtXRcICQ+cY/hQ3SsmPEYVPupSKFGUTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uh+Qxzl0YFN90uzW1mTESmFlhedjtM904NibdfOO8TWh+95qI101ROlpaTjV71+bkv2bOhhMEkRHKXfwvzsOexeVkIiZ304EtIKjxaOc87I/T7K+Q3kgs3iCTuJ5AqrFABtdbPATJ1AWFKeq7CJMl3K6UAcYFmpWbRwNbuQ9pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjH1lkaf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43994ef3872so36644825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506386; x=1741111186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmwMWV6oF+Vmhdp0fICh2mmxVSO2Me4ydPSVWJnw9l0=;
        b=FjH1lkaf4BTlIXF0TAD4rhIHTvyymwkKmRuoVJKkWZR3Fdrn9FkZ9Uv5Fo3RBSh1ii
         UfSLmXzpWp+S46XlR5v1bbqmi8nDHLku6CVsG5nQ1/+SPQr2vBscQeHdlPVKWG5STG9N
         s5mKjdXXdwPj/UxYKc3RqCyKXaBLewCCKtsc6ZqIPiGcOanpSoURsr1SFamH284Bfawf
         G5kWSH5Z0uoGnOryd0OkFXgdBjEzaTdvVJD1l13sWqj9tEdB9mKKr313Vksi8GSwpASm
         w9AoIwGimXy6txwtUAcuqmHOUHCYpS8GumFewHp+TI+4kN3IeJzIqSkq0+hKgfZ+c3Eb
         b1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506386; x=1741111186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmwMWV6oF+Vmhdp0fICh2mmxVSO2Me4ydPSVWJnw9l0=;
        b=m6STHIEA3qTgiy9jAv2bM1q9+zVjkKJc9odZkltj9KoyNytQk0874AkJxuY8zholzr
         zXyH5zatw5vwdqxI/CsyTw9We3kwnf2Ib5DwbME3lAUI4IDRT9lpnuhFnzf567LyOuz7
         0pXVxuW/0syH3KTEDk2TUM6AXBnYLpm6kS4us3b7XgDffpKTiC67sW9+Tq9kKuYHYL9I
         Pzv63CM01iz//M1AWlIWITaBqaPOLaQHUpOuFxUfBE0TMGwyL1GMheT7n0XtjSCE0MGT
         98xV+nb5Fur4Yfjf/xcie8TQ4vaQIIN/46qUhT+DrAUxk5rUAehRtuGxm2ZTTqq55JR2
         u8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5zXh3GFsNG5iSl6eo51liZtGxnaFVKqrGC38F4emp4rdVHTgKkB4TAJNE1aWNsklw9YVw+x1xX2vEPr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5l84MJ3HAi0B2c0YS75xmWagi4LdCu6Qk7S7GVLUuB3Qyewb
	oSBpcAz/i07xF8x1ZP3faUbadVoaHK3uL9YqVYjfaOaUgw5mpOU+
X-Gm-Gg: ASbGnctHKMoBiGaUnBMcrU5XLUrFu1/wo1QTLatURCPITqx7NYxdE0aWznZgohNWmRf
	794icILOejTrZ7YjTxX1yMMxDZ8tQabXLnfVmhvaEtBQTphCgQ/K+NaQEhBeDVduRQ7EZ7Q5BEf
	r6mwfTbpVTPBqNAa5vlwoGe2PF334ZTWh3a1ZlEZVo2vWxTENAIkrPdVskKxNr7yaa9V0R6v9/1
	RH51UuwYk2+a8DXDn68ZAYLAtwPB2xzYey8ZdXdzCSRHgiFcoP9jXVzo+tFjIaswGBaK25QU+Dv
	U62A0q7Hk0ALp+fKcfpF/ZDpJuoJ
X-Google-Smtp-Source: AGHT+IFLjeZRYlh7NEmH/CmtWS5phKKBkIkl2C2e27eaJkg9xOLmwwxXIek45/j4yp0tP6BluN2ZOQ==
X-Received: by 2002:a05:600c:5012:b0:439:98b0:f8ce with SMTP id 5b1f17b1804b1-43ab60f0c1bmr25519295e9.7.1740506386063;
        Tue, 25 Feb 2025 09:59:46 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:44 -0800 (PST)
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
Subject: [PATCH v2 04/16] drm/vkms: Allow to configure the plane type via configfs
Date: Tue, 25 Feb 2025 18:59:24 +0100
Message-ID: <20250225175936.7223-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
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
 Documentation/gpu/vkms.rst           |  5 ++++
 drivers/gpu/drm/vkms/vkms_configfs.c | 43 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index 4f9d3341e6c0..c2e1eef75906 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -55,6 +55,48 @@ struct vkms_configfs_plane {
 #define plane_item_to_vkms_configfs_plane(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_plane, group)
 
+static ssize_t plane_type_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	guard(mutex)(&plane->dev->lock);
+	return sprintf(page, "%u", vkms_config_plane_get_type(plane->config));
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
+	guard(mutex)(&plane->dev->lock);
+
+	if (plane->dev->enabled)
+		return -EBUSY;
+
+	vkms_config_plane_set_type(plane->config, type);
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
@@ -73,6 +115,7 @@ static struct configfs_item_operations plane_item_operations = {
 };
 
 static const struct config_item_type plane_item_type = {
+	.ct_attrs	= plane_item_attrs,
 	.ct_item_ops	= &plane_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


