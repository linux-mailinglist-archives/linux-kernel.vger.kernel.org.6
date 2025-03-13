Return-Path: <linux-kernel+bounces-559507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B11A5F4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20F67AA640
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D58A2676E9;
	Thu, 13 Mar 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Igh6mdiC"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207526659C;
	Thu, 13 Mar 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869561; cv=none; b=kin6CL+GW7qXuYr00S/bW04eSdhMN3rkfhNWxyBa0NJ3q3W7qJ1bWkCmYpzY5ZsV3M7mWWCWhAXnRfDttokFlGiruwgcsZFf4dCTVUKEdyHQ54NxXdAxI4oOQKfeHhoRH4SScT+stHukcjMi0cdyjfM/3tKgLTM2vzpZG3YPex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869561; c=relaxed/simple;
	bh=R49ux7GAa6FUdQ6XiRq1pWMwNgAMVVqQ1suhvkWncjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uoQFBVPDflgLSzmqoU5TzhXLsAWnPME+/Hi4eXCsXvYfG6DSbMRoumWzXIqrjkIOl9ZDXLQER2a5Oer1Z1DgeJD4LoFVqMkv9jhvPPqnSMGwP8CWTWyhzuAIiICLzoTgHxxocQlJ1K1iTafq08g6qeeFUdaTu9zhnm1yOkBFofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Igh6mdiC; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6d9ZK
	FjuV8GSrxW8OgiOZ8jd/gQ05HIDF0SS4LvlBJU=; b=Igh6mdiCXdySqXS4x2tgO
	5A3sWqZl6fE+QatLFrL6jL1Z17KVhRDav6OFKUcsWL54GyDj0Hi35VlJBaUCyGR0
	zFw6D2akRSKFJkc3vmSYCbyOCjntu4xsu9amRDjgiGXdRNueoc3/gpxsapZRtTCv
	ULUtGFHN8APhQiNizP+8oo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnEv+60dJnJuINRw--.30448S2;
	Thu, 13 Mar 2025 20:38:18 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbcon: Use static attribute groups for sysfs entries
Date: Thu, 13 Mar 2025 20:38:16 +0800
Message-Id: <20250313123816.393397-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnEv+60dJnJuINRw--.30448S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1fArW3GrykCr18trW3trb_yoWrtrWfpr
	4Uta4YgF45G3ZxWw45Zw4DZwnxWwn7C34fXr4kKw1SgFykArZaqa48JFyjyayfJrZ7GF1r
	Aa4qyry8AF4xur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnPEfUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXAoPD2fSzZxRWgAAs5

From: Shixiong Ou <oushixiong@kylinos.cn>

Using device_create_with_groups() to simplify creation and removal.
Same as commit 1083a7be4504 ("tty: Use static attribute groups for
sysfs entries").

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 67 +++++++++-----------------------
 1 file changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e8b4e8c119b5..7f96b60c07f5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -160,7 +160,6 @@ static int info_idx = -1;
 
 /* console rotation */
 static int initial_rotation = -1;
-static int fbcon_has_sysfs;
 static int margin_color;
 
 static const struct consw fb_con;
@@ -3157,7 +3156,7 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static ssize_t store_rotate(struct device *device,
+static ssize_t rotate_store(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
 {
@@ -3179,7 +3178,7 @@ static ssize_t store_rotate(struct device *device,
 	return count;
 }
 
-static ssize_t store_rotate_all(struct device *device,
+static ssize_t rotate_all_store(struct device *device,
 				struct device_attribute *attr,const char *buf,
 				size_t count)
 {
@@ -3201,7 +3200,7 @@ static ssize_t store_rotate_all(struct device *device,
 	return count;
 }
 
-static ssize_t show_rotate(struct device *device,
+static ssize_t rotate_show(struct device *device,
 			   struct device_attribute *attr,char *buf)
 {
 	struct fb_info *info;
@@ -3220,7 +3219,7 @@ static ssize_t show_rotate(struct device *device,
 	return sysfs_emit(buf, "%d\n", rotate);
 }
 
-static ssize_t show_cursor_blink(struct device *device,
+static ssize_t cursor_blink_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info;
@@ -3245,7 +3244,7 @@ static ssize_t show_cursor_blink(struct device *device,
 	return sysfs_emit(buf, "%d\n", blink);
 }
 
-static ssize_t store_cursor_blink(struct device *device,
+static ssize_t cursor_blink_store(struct device *device,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
@@ -3279,35 +3278,18 @@ static ssize_t store_cursor_blink(struct device *device,
 	return count;
 }
 
-static struct device_attribute device_attrs[] = {
-	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
-	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
-	__ATTR(cursor_blink, S_IRUGO|S_IWUSR, show_cursor_blink,
-	       store_cursor_blink),
-};
-
-static int fbcon_init_device(void)
-{
-	int i, error = 0;
+static DEVICE_ATTR_RW(rotate);
+static DEVICE_ATTR_WO(rotate_all);
+static DEVICE_ATTR_RW(cursor_blink);
 
-	fbcon_has_sysfs = 1;
-
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
-		error = device_create_file(fbcon_device, &device_attrs[i]);
-
-		if (error)
-			break;
-	}
-
-	if (error) {
-		while (--i >= 0)
-			device_remove_file(fbcon_device, &device_attrs[i]);
-
-		fbcon_has_sysfs = 0;
-	}
+static struct attribute *fbcon_device_attrs[] = {
+	&dev_attr_rotate.attr,
+	&dev_attr_rotate_all.attr,
+	&dev_attr_cursor_blink.attr,
+	NULL
+};
 
-	return 0;
-}
+ATTRIBUTE_GROUPS(fbcon_device);
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 static void fbcon_register_existing_fbs(struct work_struct *work)
@@ -3367,14 +3349,16 @@ void __init fb_console_init(void)
 	console_lock();
 	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
 				     "fbcon");
+	fbcon_device = device_create_with_groups(fb_class, NULL,
+						 MKDEV(0, 0), NULL,
+						 fbcon_device_groups, "fbcon");
 
 	if (IS_ERR(fbcon_device)) {
 		printk(KERN_WARNING "Unable to create device "
 		       "for fbcon; errno = %ld\n",
 		       PTR_ERR(fbcon_device));
 		fbcon_device = NULL;
-	} else
-		fbcon_init_device();
+	}
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
@@ -3385,18 +3369,6 @@ void __init fb_console_init(void)
 
 #ifdef MODULE
 
-static void __exit fbcon_deinit_device(void)
-{
-	int i;
-
-	if (fbcon_has_sysfs) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fbcon_device, &device_attrs[i]);
-
-		fbcon_has_sysfs = 0;
-	}
-}
-
 void __exit fb_console_exit(void)
 {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
@@ -3409,7 +3381,6 @@ void __exit fb_console_exit(void)
 #endif
 
 	console_lock();
-	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
 
 	do_unregister_con_driver(&fb_con);
-- 
2.17.1


