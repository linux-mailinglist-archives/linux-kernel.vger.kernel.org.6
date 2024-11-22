Return-Path: <linux-kernel+bounces-418548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FC9D62EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87554160EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783721DFE09;
	Fri, 22 Nov 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PJIxXipF"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85181DF98E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296029; cv=none; b=MCKnIP4pOhTmt9aFyB7l0YkYsEEWt1sN6cwuTXdg2MG0PXerdbsHLdnrXNjIM42VMCKd1AIBf+8aCEh642dwSh9xh0AAIwiAUoEbtRCgcLyvoj82IPYenjC3i73w/eKHICOvni5pqkcLl9gIRYoFYdJVktKtQp1Dv+SggqGfb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296029; c=relaxed/simple;
	bh=0JbmGZogKVTFANqtFMvuPkBSGo83j3o5kPyKHFU6Jm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh5N2zZIlhdrMdcl/dfxxJuc3FUUDBtIli2LQPdSuyL9SMyPzGloctYMYcVTE1RkdHUxwjc1B54CfEOzJETIQSYzy9wNshowHjzmXqY7+x4Wqw4ExOFPXuP9G5Mi5pAVnFtE2Fl40IPsyw/PeeOkdnWUFG1kGxwIwLcWtAAtil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PJIxXipF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E0C01C000A;
	Fri, 22 Nov 2024 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732296025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA2OGgZp0KRoCQFiGaaZBrzWQDsoZVmLgth29AG0usc=;
	b=PJIxXipFF/6w6dHdZgfdRK5+QBAPOrnkSQj/AZmDRDEqhzfyv79DvL94ByonUg5T78ZPV5
	zuWuGyISyZnuoOYili/yYGKyXHCO+fdOVLfyXNp6EpITKDX6s3ApBFMwlRr4J053jIMCCn
	FxlqbrNZI7mZ8l/uRioyO3DentWKHnj5Rvaq2EjUso5ULCxzWthDPY5iy+lSpumtGQd4jg
	OL76V+OBEzJ9EKzakwIhvEr45aGQGhZ9mSlNkpejWumx9JfcTz7VWX/UoZKkyQnT6YYSY7
	BLCduqZ8TorUmt59Z1TvTwBD+cybQlfDzNlGMOowVuxPG/kqNaP3KJvNKWFIeQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:20:09 +0100
Subject: [PATCH RFC v2 05/18] drm/vkms: Introduce config for plane name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-remove-crtc-index-from-parameter-v2-5-81540742535a@bootlin.com>
References: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
In-Reply-To: <20241122-google-remove-crtc-index-from-parameter-v2-0-81540742535a@bootlin.com>
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: arthurgrillo@riseup.net, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=0JbmGZogKVTFANqtFMvuPkBSGo83j3o5kPyKHFU6Jm0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQL1NnRJhpgQqiMXj5kja+fGJ8xWIB2KZGBC1o
 IXZq2ecThKJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0C9TQAKCRAgrS7GWxAs
 4vkbD/905iuEaC9VXbqglNpgridzRls/TWGXeRPlwOyFZRLFwEho+LzC1+p0FA9wtEXOzgmE3Xp
 Zl+jdzC3Kb7hCeqKK2Qil8bFEhA7jbpK5VbWuT7tbVdDvQciG3wMlbN4q/55iJjMqPcXG4TBrDc
 5wsf0EdO3lovNokIXYioGsE7ZtVgHzAm5wEWDapg8tzwkWcoPWgHAZwo7m/PPcGUIHYkXgSSVpN
 diK386aZNmOl91EPOv+Sl4v5Q7I5/UmxLVOmF44qgTk2mWbsXAgR3a6tQe8HtH94TLPu/i4IBRy
 baVY9dznswVv6G53t+91DMLyXgsJoaAEMBfhiUyjUVc9+Qy9/131ZNAn/q+dP+5/niAX/skJl85
 9LLtp/pLNRStebVrITmSWcZ6NIGfZtBN0rdf0XiA5wPjn0ju/5JU6ERZ2YC06Te3nz7tKUZZvXb
 ay2EJc+l5HT0TtWaKe+WTRXu07eRdyxMo0drBbvGn4fBCiuciMinrTMdm6Fk9Sfws34CmXtYEPo
 rHyk2Ug38amNbdc8Bv9ER092gWubPTQ8Iy9V/PtAer6DCfDr/ztuxmgHfEMahxWW+tfMrqiN9V6
 p82DplG3tavKP0RsJOIME35VEkUMU2HdKPjI3VK3LXwbeZRmf9SbA6bOxVVBUS0OBEH4wBpnxMx
 LP+nIFN9lq7AjOg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As a plane will be a folder in ConfigFS, add name configuration for plane
so it will reflect the folder name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 14 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h |  2 ++
 drivers/gpu/drm/vkms/vkms_plane.c  |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 31981dce2c2ed3ef8fc52e227e301d5f8d5338e6..8af7b80d1fea201102f45f8ee49fd88ce26733e3 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -36,6 +36,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 		goto err_alloc;
 
 	plane->type = DRM_PLANE_TYPE_PRIMARY;
+	plane->name = kzalloc(sizeof("primary"), GFP_KERNEL);
+	if (!plane->name)
+		goto err_alloc;
+	sprintf(plane->name, "primary");
 
 	if (enable_overlay) {
 		for (int i = 0; i < NUM_OVERLAY_PLANES; i++) {
@@ -43,6 +47,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 			if (!plane)
 				goto err_alloc;
 			plane->type = DRM_PLANE_TYPE_OVERLAY;
+			plane->name = kzalloc(10, GFP_KERNEL);
+			if (!plane->name)
+				goto err_alloc;
+			snprintf(plane->name, 10, "plane-%d", i);
 		}
 	}
 	if (enable_cursor) {
@@ -50,6 +58,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 		if (!plane)
 			goto err_alloc;
 		plane->type = DRM_PLANE_TYPE_CURSOR;
+		plane->name = kzalloc(sizeof("cursor"), GFP_KERNEL);
+		if (!plane->name)
+			goto err_alloc;
+		sprintf(plane->name, "cursor");
 	}
 	return vkms_config;
 
@@ -82,6 +94,7 @@ void vkms_config_delete_plane(struct vkms_config_plane *vkms_config_overlay)
 	if (!vkms_config_overlay)
 		return;
 	list_del(&vkms_config_overlay->link);
+	kfree(vkms_config_overlay->name);
 	kfree(vkms_config_overlay);
 }
 
@@ -136,6 +149,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
 	list_for_each_entry(config_plane, &vkmsdev->config->planes, link) {
 		seq_puts(m, "plane:\n");
+		seq_printf(m, "\tname: %s\n", config_plane->name);
 		seq_printf(m, "\ttype: %d\n", config_plane->type);
 	}
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ac99f1df6d9a17bd7040a1e7a6acce14cd8fd9d0..3e70bce8d4f7b06f44ec79b3a3d8e6897f9a44c7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -27,6 +27,7 @@ struct vkms_config {
  * struct vkms_config_plane
  *
  * @link: Link to the others planes
+ * @name: Name of the plane
  * @type: Type of the plane. The creator of configuration needs to ensures that at least one
  *        plane is primary.
  * @plane: Internal usage. This pointer should never be considered as valid. It can be used to
@@ -36,6 +37,7 @@ struct vkms_config {
 struct vkms_config_plane {
 	struct list_head link;
 
+	char *name;
 	enum drm_plane_type type;
 
 	/* Internal usage */
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 3d742e47e0fcd647225251f53a73b6ac0e669868..56725f243382d75668ab2bf23423a69c75cb366b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -228,7 +228,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
-					   NULL, config->type, NULL);
+					   NULL, config->type, config->name);
 	if (IS_ERR(plane))
 		return plane;
 

-- 
2.47.0


