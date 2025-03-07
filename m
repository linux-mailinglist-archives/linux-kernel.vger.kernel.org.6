Return-Path: <linux-kernel+bounces-551548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACACDA56DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09D37A8CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD0241CBC;
	Fri,  7 Mar 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAsY0ll+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDF23E23D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365258; cv=none; b=N/2iBkCgGcTaNlJyuT1Ib+a4ic7CYixjMyzqySAfDnoIY0tAEX5KvJhpQpuYsK7zWIHDficqUBDPRvlAjCC/DsPzVbV4X/jUc/i+4sbRYJ51a6lsyjIG9PGbrIZ4OjrgwpGRURmZjVWPQrXPbrdMgcVbZG7eCrQ1LAiIzTaCfys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365258; c=relaxed/simple;
	bh=tA+WmKfmch3Ua9PWXbOHsgfkOu092C1qCFygk8hIly4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnPRAxkaPZiba4YvFN4PVj8a211fMJA7sC/Jjj457iIxwZrSYW6m5Rj/5BZGSBx0BoNM6rXfDUWRU1pKmgBk2ZvloVRid/r7LtIualealCTYidpBg+byRzgE/ttTSLEaHG5C7DALfVXXhnS1LNwoNyeBP0GrYd+znZe/JOeRfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAsY0ll+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39127512371so1268478f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365254; x=1741970054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkjoxigyIPAGM4bWibC29uQWmfsXcpbtj5sqbZDQnLA=;
        b=OAsY0ll+HYCKkNdPNTM7BPX40IeGabD1KugHtTrGNSUgVPdwvqj4Qt5ED1281WSs8P
         C/wUOqAXV/UM+M85b1bYVYBbXHCxDPc8djlZM2qUW8AsUHpg+/c9KY9m6rvTBPJpufsr
         2rAN/4InNZWa2E6b6ogNcC+A9j+9AUVtbsEFvx1RNS9RFvRWQoeZg6O1kAJ/TU0X9hFp
         iEEbVFK/P5OND46zAeNziIYrFhjcv/S55j1B1NHanN4Qu9O5VzFQ6oxxe8u/X3XXcGqB
         I5eUwGoJd4e02VUgHc3t40T4dd4lok43vss+VM/CwOpg1OgIztzR/rlevMP129fnGrR0
         qICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365254; x=1741970054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkjoxigyIPAGM4bWibC29uQWmfsXcpbtj5sqbZDQnLA=;
        b=acp3zbPNDYLZ71pT1tIx1uumxvLo8n2+BaeO8nQ0u4FLHvrKR9a44AnBH1IqWMVzEN
         Iy0dM9NaxotQCrfUcuX9wseNJEdLYacDakOSXrN4bGgGNNlgM9rRN27O4EWO3bWEWmUM
         0LGXZ+9yo8OvoaqUZK4HL2UvWcMqDCdrZ/DPGHaInBEwcmFid6bJW/NEnfEciA6wyj/h
         8oS2I/QXST3jmKgMoE3FDAYwbh4ZlFv6z4bys5PrHkzm4YYOYO1mhMvRYRRQfgK1+AQP
         IqHYKO07Ich+vyl3siAlMv9mwi4dw40LuA1nK1llHkoXu1lmAfPdjhGjYIL0FU9p8BGO
         vBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXJWvxtCWxNm6fU/LE4zPidlP4DMgFMDbsj7M+4jabFv/BmYoaQEYpBCbVbALqPIVmz5jQzdTltFBmPdK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0BEZ9/tudCfFcPG/O1REuD9Xa+czRDIsO/+2XhDhnhDiSSr7
	gZYnADJvsEoczlJYKG1sblTN5iz0fs/h1ba8PeF7FVv8V5sgOEHWFEH14b+F
X-Gm-Gg: ASbGncsz5MSrbGmOC11DafhhDuKZxWQG42w9LsFGdhf6xb0LO7dDNyUOJNX67Lo8t3k
	6JAw9mPxwqIQQ3dEzp6T5B/TuFcZssECGUIfapez4ztqZ3+ZdNeH9Q9kDFojzZFBR9VmOp0Hkan
	OclvnGQvzl1xsC+gVV5iFVRRv36NjrFq9RMSAvZ6dMbm2zyuTNZiqvkM8ktmW+9WjVl4gXCMFsr
	ijWo+ISB0hP/BuEPcrjHvuXbuv//wGHSafG4m2lefwIru0TSajHv2yhOacksQGray9POEl4jCST
	6KVOWizgOtNQgxhZmfWpUtXNX9nKEWUgN583TIrmvSod4NE=
X-Google-Smtp-Source: AGHT+IESNA23In2kHjqdFJ6dx0smo1M6kzDdgbcUv2LBI727vsHZMdwd4dUthvuCgUPRlt36reWHvA==
X-Received: by 2002:a05:6000:4185:b0:391:306f:57d1 with SMTP id ffacd0b85a97d-39132dd6d3cmr2539139f8f.35.1741365254331;
        Fri, 07 Mar 2025 08:34:14 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:13 -0800 (PST)
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
Subject: [PATCH v3 11/16] drm/vkms: Allow to attach connectors and encoders via configfs
Date: Fri,  7 Mar 2025 17:33:48 +0100
Message-ID: <20250307163353.5896-12-jose.exposito89@gmail.com>
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

Create a default subgroup at
/config/vkms/connectors/connector/possible_encoders that will contain
symbolic links to the possible encoders for the connector.

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  2 +
 drivers/gpu/drm/vkms/vkms_configfs.c | 62 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 744e2355db23..74126d2e32e4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -112,6 +112,7 @@ To finish the configuration, link the different pipeline items::
 
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/planes/plane0/possible_crtcs
   sudo ln -s /config/vkms/my-vkms/crtcs/crtc0 /config/vkms/my-vkms/encoders/encoder0/possible_crtcs
+  sudo ln -s /config/vkms/my-vkms/encoders/encoder0 /config/vkms/my-vkms/connectors/connector0/possible_encoders
 
 Since at least one primary plane is required, make sure to set the right type::
 
@@ -129,6 +130,7 @@ And removing the top level directory and its subdirectories::
 
   sudo rm /config/vkms/my-vkms/planes/*/possible_crtcs/*
   sudo rm /config/vkms/my-vkms/encoders/*/possible_crtcs/*
+  sudo rm /config/vkms/my-vkms/connectors/*/possible_encoders/*
   sudo rmdir /config/vkms/my-vkms/planes/*
   sudo rmdir /config/vkms/my-vkms/crtcs/*
   sudo rmdir /config/vkms/my-vkms/encoders/*
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 692e1b708012..8e90acbebd6a 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -88,11 +88,14 @@ struct vkms_configfs_encoder {
  *
  * @group: Top level configuration group that represents a connector.
  * Initialized when a new directory is created under "/config/vkms/connectors"
+ * @possible_encoders_group: Default subgroup of @group at
+ * "connector/possible_encoders"
  * @dev: The vkms_configfs_device this connector belongs to
  * @config: Configuration of the VKMS connector
  */
 struct vkms_configfs_connector {
 	struct config_group group;
+	struct config_group possible_encoders_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -126,6 +129,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     group)
 
+#define connector_possible_encoders_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     possible_encoders_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -528,6 +535,55 @@ static const struct config_item_type connector_item_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_possible_encoders_allow_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+	int ret;
+
+	if (target->ci_type != &encoder_item_type)
+		return -EINVAL;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		ret = vkms_config_connector_attach_encoder(connector->config,
+							   encoder->config);
+	}
+
+	return ret;
+}
+
+static void connector_possible_encoders_drop_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_configfs_encoder *encoder;
+
+	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	encoder = encoder_item_to_vkms_configfs_encoder(target);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		vkms_config_connector_detach_encoder(connector->config,
+						     encoder->config);
+	}
+}
+
+static struct configfs_item_operations connector_possible_encoders_item_operations = {
+	.allow_link	= connector_possible_encoders_allow_link,
+	.drop_link	= connector_possible_encoders_drop_link,
+};
+
+static const struct config_item_type connector_possible_encoders_group_type = {
+	.ct_item_ops	= &connector_possible_encoders_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static struct config_group *make_connector_group(struct config_group *group,
 						 const char *name)
 {
@@ -554,6 +610,12 @@ static struct config_group *make_connector_group(struct config_group *group,
 
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
+
+		config_group_init_type_name(&connector->possible_encoders_group,
+					    "possible_encoders",
+					    &connector_possible_encoders_group_type);
+		configfs_add_default_group(&connector->possible_encoders_group,
+					   &connector->group);
 	}
 
 	return &connector->group;
-- 
2.48.1


