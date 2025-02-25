Return-Path: <linux-kernel+bounces-532150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20FA44953
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB31895F20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1AA1C861B;
	Tue, 25 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLkbjP7W"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78819FA93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506391; cv=none; b=FpoR9kErRQ7+e4IFoA+qWOqh2TpJsZCTvh/BFEVurYhs+B2tN67QdH+M+QTKLXnJZO/rzs/ldGhOV9tPLegxd0BUogyT0+bhiY92pXXuBKPnkKlxjR5szscAxjprKVyyAUrNkm1m257f4SGf0YcBby5MAroZMvsgVXkhgl3OXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506391; c=relaxed/simple;
	bh=zBegzXjEYCFd/3MpfD5QFh3xM2l5NRR4TrERad1Xozk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKHx5ahhgpThvFfs76bYhl6vqRk9h6ByYTEoADWvdSZ5ii4dZ+EEUZyvagJyqKhQwFRhfHJcr9d7HeqOqnbs2i5Ha3Jh1PPAFJNjF2JF6mBmSYjGAy74Gw3sYzxJLBUvVPPmXYbA602m6LtWs535dxdJZvJynCWrHC8VB+S7yQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLkbjP7W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43994ef3872so36645305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506388; x=1741111188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1Ilm0hsqaAWJ6FLSDKxA/oNa1o2785HX4v9RhTC7S0=;
        b=XLkbjP7WRCxrQExKkWpD++wNUKHMHvvxOkwbO8zhaXxU6WqOIeEdXhl0sUPPVTyOeI
         fnmnLw49eQKVKRaPOkWEjIn/Rf246ZopueiMa5NX9CxLWiUn8ueT09g3iiTP34vD4vdl
         3P/KxbLYzXjDoI32uYcKGquaD9QJGWfxoEC+9knG5J5vYE+vZnUsKxC3KEsdTNo0wRtz
         ll44epYuFqRugZPeZZ8zeeYzjIMJXgbdqXJLrf7p6alLajeBGaEIVYoWj6T1v9rpaDLD
         YZ83phnawF+LkIheyL0PzJICt+omb09rvfkvWK7ahFDzgepCcHkg8q/E1CLR4znrkUWp
         jZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506388; x=1741111188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1Ilm0hsqaAWJ6FLSDKxA/oNa1o2785HX4v9RhTC7S0=;
        b=vjjMIdPARGZ8qEWHv6u9oOvJzVJvIVH4q0tJAlX+Ar2EUdzVcJoG1SAOdUwff1VwTR
         gjq1c/wR5mR8Cm6lgj4tEMk1UkG7gbqq2glTyDmVr+ekig+hx4xqPb0WU1jDAdU8Yqrt
         tUu64c6p10iAUigbCQcM7ijJpKMXUHXzuE8toLIqGnFYpBFIXBiovlW3n+qVlrPf4ruL
         8qNJMIxsCP/d7DU1EJd5vVX2vq2AjtXXvUQ78fFf/bFnuUNZxlue2Ns1yk/UbJS0wiy2
         PQLcDkU9uiEOJngd5svPl6o4p0YaUK9Vh+Dv5svfPfwUL/HKUAtU1ZCPyWlM6QTELMlS
         5Yaw==
X-Forwarded-Encrypted: i=1; AJvYcCVMsgmx7+skRtsNB/6BLH/I69aH/UFHAI4vuTGqohocmCty+N20fN7VHJnh0Ld7QrUDlIjDAeK9s6jI8dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0FPcdvDWO6v8/MxqAoSvckfSAycIw6lwdb0/d92b58vw/0Jb
	YJ2vJxr/9rzBTGzARVtUgWMJTpX0UTu8/70Ze+eAroaMqurFrPGW
X-Gm-Gg: ASbGnctHxjfZqLPuTjdnZEL4MF5HYf3YyZYiMGfQ/iByhRXxC/2EAvQ5AngWRUgz3yG
	YgtzTKsjqr5x0M016PE3mo2HTz2LjCwucojIYrSvxNu6owpx0zLubM/9GjpATCib/Rc+HCiRXTE
	aXeAwY2Laar30fCvktpdNMjxabvDIuzBFCUeG5Lal51SDTPKdd5r+7imgeWdj3ZMMKmO0HBJFZq
	3Tjv3jmmyLLhEpNinDjelNqzd1g6PEM1Z6oKD5EEqOMsJdyIBU3xa86df3gp5RD+k9YxKzPMCYJ
	RWmFbH65GWopYrFdhJNMqzN4tu9m
X-Google-Smtp-Source: AGHT+IG/Jg6sQzfteNDw1Z0ZLJPWyZtj1UzkuvnZQYZgwvyGWiXUaguZlAArqY4qPHtreL4LKbBH/Q==
X-Received: by 2002:a05:600c:1989:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43ab0f4271cmr48566515e9.16.1740506387928;
        Tue, 25 Feb 2025 09:59:47 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:47 -0800 (PST)
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
Subject: [PATCH v2 06/16] drm/vkms: Allow to configure CRTC writeback support via configfs
Date: Tue, 25 Feb 2025 18:59:26 +0100
Message-ID: <20250225175936.7223-7-jose.exposito89@gmail.com>
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

When a CRTC is created, add a `writeback` file to allow to enable or
disable writeback connector support

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst           |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 40 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index e0699603ef53..abe7a0f5a4ab 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -94,6 +94,10 @@ Continue by creating one or more CRTCs::
 
   sudo mkdir /config/vkms/my-vkms/crtcs/crtc0
 
+CRTCs have 1 configurable attribute:
+
+- writeback: Enable or disable writeback connector support by writing 1 or 0
+
 Once you are done configuring the VKMS instance, enable it::
 
   echo "1" | sudo tee /config/vkms/my-vkms/enabled
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 1483f47244e6..233a3d4ad75c 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -74,6 +74,45 @@ struct vkms_configfs_crtc {
 #define crtc_item_to_vkms_configfs_crtc(item) \
 	container_of(to_config_group((item)), struct vkms_configfs_crtc, group)
 
+static ssize_t crtc_writeback_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_crtc *crtc;
+
+	crtc = crtc_item_to_vkms_configfs_crtc(item);
+
+	guard(mutex)(&crtc->dev->lock);
+	return sprintf(page, "%d\n",
+		       vkms_config_crtc_get_writeback(crtc->config));
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
+	guard(mutex)(&crtc->dev->lock);
+
+	if (crtc->dev->enabled)
+		return -EBUSY;
+
+	vkms_config_crtc_set_writeback(crtc->config, writeback);
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
@@ -92,6 +131,7 @@ static struct configfs_item_operations crtc_item_operations = {
 };
 
 static const struct config_item_type crtc_item_type = {
+	.ct_attrs	= crtc_item_attrs,
 	.ct_item_ops	= &crtc_item_operations,
 	.ct_owner	= THIS_MODULE,
 };
-- 
2.48.1


