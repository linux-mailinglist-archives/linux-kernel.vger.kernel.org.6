Return-Path: <linux-kernel+bounces-547764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479BFA50D41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAEB188A79A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFF1FDA62;
	Wed,  5 Mar 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic4KHpXX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABC4A33
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209836; cv=none; b=iZTZp7iTyDAU0KFLHZBuV726mITuUQ2jo/kdWN7cdgKnFYuACbHntEV2VqbP51kkHcvNdN+g1bU/9Pl3nyMTX1s1DpVG5rEjaM3YyHDWjkTxcR0oiNGLZW7aqQcJYExfh5Xbnzb+BXwVtERESMLYHtyih3kxKXT4OGLGPxaHvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209836; c=relaxed/simple;
	bh=8ySDjGy6ifVT9nBen+e+y8tngjg0FvnAc2do9GydDKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pt8Yi1MvHbw1veOb2TYer/4bHUhyUD6JhjzxB9vtlQWA8TWwXDW6zo8cha6hLBQo240n+3CtsnHg43R2tBi+K49MTuSKyp/5/bY3Rgsz3rDmK7FMVBqB/WIY561kV2cSa2LPW0IYe9fTP4BQuUoCni1m33cwnyR0ysQi4BCe+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic4KHpXX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf42913e95so825002666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741209833; x=1741814633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8Dkf2Am7BkCc6xwiEJIkFESnAy6N6xXMin3A5PDXG4=;
        b=Ic4KHpXX6A+W7fmcFBhAKv15IfDjhrWdM/VvJS5xcMYx+41cEppoZzzk7edIftZD+N
         i+zmJGTT7/FT3ChyjsZy1iyfc9/sKhlUZGtJZ2Q6v1VE0ufrJwp+wO0kcUPD+XlB8D65
         T6eXuj4wrnghW3PB3nbppfhw2aGd6rxBp+CUhsdBhHR1vjq4lKE7OAjg1F4xuFsffjul
         Jncb59WmAhW1k5dZmV2ZGGIIxMhIBhEP+fMuVpq0dIT41cd0k1js5eQSiHHyBH+20mAa
         650I5dVsiu9cZ0vIau0wfax7Zeh5+Ykh0iMK97z0b1zBUw9GdId9ESNHko7SSb/yNs7j
         kwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209833; x=1741814633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8Dkf2Am7BkCc6xwiEJIkFESnAy6N6xXMin3A5PDXG4=;
        b=R0/yLC+gm2n20fm6V9Fd/7Zo8UWS2tvEDbmlj+SyMURKKxKPgIKzGRbVH7x3XsPrwv
         bvMZtC+xTLMB8z8INXlyce4R+5heC+r7ZB9po/B+ZvlSDYYkGR9VHJSaDq88rpNVcifH
         yjt/vn92iQBCiwJXpXPjtrba8ASYHO1d+sJWpPWUPgPi3XUm9B1m34t8BNGN4xhhV74G
         aAoB8QemcPOzQwjsJkx6d50nsATnMlhIEd17oPbWk/25hBqdapzexJrpPKw93OLJM218
         5UPwPkgHSAtLR5QJUCgHtj5WOZuepNTUCl/XQgio2h1Gezl7HZZyd083t3kYi6ZUO+tN
         LN6g==
X-Forwarded-Encrypted: i=1; AJvYcCV4rXE18UzTQ3xoSM1IQ+WqyHTUldD6r3bMFtRcxEnMBa9ZLza0brof4PWgnJjNMcz9qZDtMuIjixMCmXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RUV8RqEcArQup/rfvulAysRmw2C3NkPxj8mGa77jQ4faBu76
	GNvEUWBZEiqxbGV6LBkEKbXe5s051yWv100suyTfMSk66cVyV1R0
X-Gm-Gg: ASbGncvQKNT9dJc5DIE8uPFQSveCDETwtAItF920dNNx7jNNvyuaoxNXs+/A/bLffun
	wmmR1dh+/X6glQv/UWEYJ2OQ+xF1aGLVw1fBeMB1cHMsfzIOJbMnoNfi0bmjPsq0HW4wyGZnoz7
	85Jg3wtiPGDsuyYi5/SOIFgPxunAGxuo/vculLCf9JukUh9sagLyI1OOjllXkNreg+6SacL9FoP
	9eT3OacDGnzeUuyO2XZo9bFF0v4zfyWFlujBYeSngYZicyfJHDurggD8E9MgY16V2IvYesf/zU4
	UuyqDgj0JQ0fklkn8aohH1SqZGvNfjnrQG6qLpD3UuwGCFZMrxk7TlgBXDRT
X-Google-Smtp-Source: AGHT+IHCUgJSczMALJRUQsNQJij5yTp/ZhVwBJWdsbeRmE1+G/jwWDZcuvPQrej8azlFaVtQAjkeOQ==
X-Received: by 2002:a17:907:c018:b0:abf:7964:f9e5 with SMTP id a640c23a62f3a-ac20e03b1d0mr507213766b.56.1741209832560;
        Wed, 05 Mar 2025 13:23:52 -0800 (PST)
Received: from localhost.localdomain ([196.235.231.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1ea7dd823sm404025866b.109.2025.03.05.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:23:52 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] drm: amdkfd: Replace (un)register_chrdev() by (unregister/alloc)_chrdev_region()
Date: Wed,  5 Mar 2025 22:08:09 +0100
Message-Id: <20250305210809.218138-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace (un)register_chrdev() by (unregister/alloc)_chrdev_region() as
they are deprecated since kernel 2.6. alloc_chrdev_region() generates a
dev_t value, so replace the kfd_char_dev_major int variable by the
kfd_char_dev_id dev_t variable and drop the MKDEV() call. Initialize a
cdev structure and add it to the device driver model as register_chrdev()
used to do and since alloc_chrdev_region() does not do it. Drop the
iminor() call since alloc_chrdev_region() allocates only one minor number.
On error and in the module exit function, remove the cdev structure from
the device driver model as unregister_chrdev() used to do.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 35 ++++++++++++++++--------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..55c74466d2c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -37,6 +37,8 @@
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
 #include <linux/processor.h>
+#include <linux/cdev.h>
+
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_svm.h"
@@ -61,12 +63,14 @@ static const struct file_operations kfd_fops = {
 	.mmap = kfd_mmap,
 };
 
-static int kfd_char_dev_major = -1;
+static dev_t kfd_char_dev_id;
 struct device *kfd_device;
 static const struct class kfd_class = {
 	.name = kfd_dev_name,
 };
 
+static struct cdev kfd_cdev;
+
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
 {
 	struct kfd_process_device *pdd;
@@ -90,17 +94,24 @@ int kfd_chardev_init(void)
 {
 	int err = 0;
 
-	kfd_char_dev_major = register_chrdev(0, kfd_dev_name, &kfd_fops);
-	err = kfd_char_dev_major;
+	err = alloc_chrdev_region(&kfd_char_dev_id, 0, 1, kfd_dev_name);
+
 	if (err < 0)
-		goto err_register_chrdev;
+		goto err_alloc_chrdev_region;
+
+	cdev_init(&kfd_cdev, &kfd_fops);
+	kfd_cdev.owner = THIS_MODULE;
+
+	err = cdev_add(&kfd_cdev, kfd_char_dev_id, 1);
+	if (err)
+		goto err_cdev_add;
 
 	err = class_register(&kfd_class);
 	if (err)
 		goto err_class_create;
 
 	kfd_device = device_create(&kfd_class, NULL,
-				   MKDEV(kfd_char_dev_major, 0),
+				   kfd_char_dev_id,
 				   NULL, kfd_dev_name);
 	err = PTR_ERR(kfd_device);
 	if (IS_ERR(kfd_device))
@@ -111,16 +122,19 @@ int kfd_chardev_init(void)
 err_device_create:
 	class_unregister(&kfd_class);
 err_class_create:
-	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
-err_register_chrdev:
+	cdev_del(&kfd_cdev);
+err_cdev_add:
+	unregister_chrdev_region(kfd_char_dev_id, 1);
+err_alloc_chrdev_region:
 	return err;
 }
 
 void kfd_chardev_exit(void)
 {
-	device_destroy(&kfd_class, MKDEV(kfd_char_dev_major, 0));
+	device_destroy(&kfd_class, kfd_char_dev_id);
 	class_unregister(&kfd_class);
-	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
+	cdev_del(&kfd_cdev);
+	unregister_chrdev_region(kfd_char_dev_id, 1);
 	kfd_device = NULL;
 }
 
@@ -130,9 +144,6 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	struct kfd_process *process;
 	bool is_32bit_user_mode;
 
-	if (iminor(inode) != 0)
-		return -ENODEV;
-
 	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode) {
-- 
2.34.1


