Return-Path: <linux-kernel+bounces-519926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D585A3A3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71ED172594
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250F270ED4;
	Tue, 18 Feb 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUT9YQwT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24826FDBB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898504; cv=none; b=Nj5cWni5d0PLAFg4WcJg/Erf2mb7AHfce3PZ938PRL8OGV9L0s6AXgkDXgIUVstukP0uMlR3IkzlQmN2cwkmkovTGrwl52TTskhpdD3K01IIu+mxXaEC0tMhvyMAJtP48OBL9lGkjk+8GcqXt6kAymA8nRP8dIB53jiZeEfVnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898504; c=relaxed/simple;
	bh=UXB8z+a8DWFyN1/YnVgBN9tWyovb/3R/u7SPCbhhKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCP7AfUjbhytYwH7dtXilYBzo/63TfkonQbRmLoXFkduvgbpJLjAVbJTSX0fQ/1c0PGFF+DsH3yIq9JBctj1UTLndLbkN8bDThkjlHNNHLtrra4yv1M9BXIlPS/0uDBXie+uIVgR6kZj7j/buDuQtGtSnc+xFVHTUH8VLUA0gXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUT9YQwT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4396a24118dso42678325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898501; x=1740503301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1/MGJA6ABLV0I3ehMALxcBw1PNxhc/iy12fyDBkAZY=;
        b=SUT9YQwT6fjupN0IU2EgID4HnAremrNm7+augFHVjbC+vzIJrxyCzT6fEy1E/jLViZ
         2nj0fwWiTGzIRUWa7OuSAvIJWDSNvpFenbUunN2tlt4diVushwpDGZ+3UkjbM/vFjAVz
         mU+Scja98y3tsA639DNo2kyQfudoRas0B4Uty4v+lVfK5kI5sDB0emqDwJcpMGXG1iga
         mONVnJFfeZ0e15Tjo6lHt5uXaTr3WksvD/LbO+7ioYAb+oz1PFo40fROGMUm9alnJNZD
         79PQr+ampn+RS8Qxg2CBya3Bu+TZx9VfLpHcbW4aoUQ2JNhXYaZ/EQR714BrBAH/r55c
         WEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898501; x=1740503301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1/MGJA6ABLV0I3ehMALxcBw1PNxhc/iy12fyDBkAZY=;
        b=kVZxIPMdjKUs5zXTQO4IBDILHTCHUlw8bOZzHVv2tJD/uY4OsFsFo0Il9zJSihSG8x
         cbL4OmoIAcSVoakF6+1kArFezYErlbSROObIb7Lmrk33Gi3CYrv5FzyBZuSP9fZxL5im
         MVoHeIRqLGidTCGZTHEr+6uopNc0vqcae5i3Bqe6hnJlWbcUne50FayX3+pLA63cCOqP
         M1upZMq9xHUNm36uRlFfQnvwoXEaIHWEupJ2sU6VhohI0BHqKQa8QSBiUMFk2IeFP59T
         gFuXYGR4WBd8mxvzjWMEjakNqMh9C4VtG4mIebIVPSvRALXvep7ajuf6Zky3iRuDSRgj
         XwjA==
X-Forwarded-Encrypted: i=1; AJvYcCVWvsBX8qwyIX1oCCnIm9DNKef7XIO65Bx+ML1tDd0B+HXYMYiCoO1vG8RoQTKPkWgD36rZTh92jF8HMmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmkLcYpenB3/9HEY9eY9UgnBxOfcyrfZZsJ7TjrQE2G2dEMj0
	X1+dgH4TSQ/gB+ebeXw8NaMyLBSToJ1slHCPlCZWiczfYAcBoxke
X-Gm-Gg: ASbGncvKtlU+6nmf6jKy1vJsooRuHjBe+EaJAjmhGqXeQseRkVPOp6oKiSEn7AGSNn2
	rpwIrChcfB+M42I3befviC7FOohBw2Ym7tkuHdgj4oy5nmUbbJI6gVqJtYnK/y6mdKsFdJha+xZ
	1VPwEnb0ezzDgo+N+dvvKH3H+lvmEuV28MGUBLwrwSTUWu2h5E0P910GUWYC2NoqDZjoYRLou0a
	oOTIfLmw5MAYqBR2ZI2fnlNndn9z3zMh/S5Kpb3D5Tuo7C/cPkPvlxpEKm2REutUkXyCH68x1RG
	BLnBq+/qnRltd6d1ww==
X-Google-Smtp-Source: AGHT+IF1iQmYZpMoTMMeqAXis1UUCoLwudIFl99fCClIyXGpAUbfavofD4v8daX3RdLtI67Xxu9Krg==
X-Received: by 2002:a05:600c:19ce:b0:439:6a7b:7697 with SMTP id 5b1f17b1804b1-43999da70d4mr5526705e9.14.1739898500661;
        Tue, 18 Feb 2025 09:08:20 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:20 -0800 (PST)
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
Subject: [PATCH 06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
Date: Tue, 18 Feb 2025 18:07:58 +0100
Message-ID: <20250218170808.9507-7-jose.exposito89@gmail.com>
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

When a CRTC is created, add a `writeback` file to allow to enable or
disable writeback connector support

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 47 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index da5157adfd79..4e87d8a81844 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -93,6 +93,10 @@ Continue by creating one or more CRTCs::
 
   sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
 
+CRTCs have 1 configurable attribute:
+
+- writeback: Enable or disable writeback connector support
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 52205a8a9cb4..88037a57a138 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -73,6 +73,52 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+static ssize_t crtc_writeback_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	mutex_lock(&crtc->dev->lock);
+	writeback = vkms_config_crtc_get_writeback(crtc->config);
+	mutex_unlock(&crtc->dev->lock);
+
+	return sprintf(page, "%d\n", writeback);
+}
+
+static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_crtc *crtc;
+	bool writeback;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	if (kstrtobool(page, &writeback))
+		return -EINVAL;
+
+	mutex_lock(&crtc->dev->lock);
+
+	if (crtc->dev->enabled) {
+		mutex_unlock(&crtc->dev->lock);
+		return -EPERM;
+	}
+
+	vkms_config_crtc_set_writeback(crtc->config, writeback);
+
+	mutex_unlock(&crtc->dev->lock);
+
+	return (ssize_t)count;
+}
+
+CONFIGFS_ATTR(crtc_, writeback);
+
+static struct configfs_attribute *crtc_item_attrs[] = {
+	&crtc_attr_writeback,
+	NULL,
+};
+
 static void crtc_release(struct config_item *item)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -92,6 +138,7 @@ static struct configfs_item_operations crtc_item_operations = {
 };
 
 static const struct config_item_type crtc_item_type = {
+	.ct_attrs	= crtc_item_attrs,
 	.ct_item_ops	= &crtc_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


