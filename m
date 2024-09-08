Return-Path: <linux-kernel+bounces-320367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD597095D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F221F213EC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6111779BD;
	Sun,  8 Sep 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="IE689qlD"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C87174EDF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725822269; cv=none; b=mQ0IP+aK/Df8v8BfV0gHc5xZ8hbxoy99walKUYl5J3vAuJUoc9JHKKHDg+9tHj1XZsBnrI/zaA7ztmGyJY/eNlcGEd+K07vOuYWwl1oMxAiZHTxkzzOO46A71swmCSxdQ4p2IEFJlfFcoHmdsLwPsD1OIsyhcJoF4oolg4hvDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725822269; c=relaxed/simple;
	bh=cSuRv1s4Z3jU6ggrMdiItv7yMIs76w8gQpvH3RezZhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRs6XE7vhLhnuZs4f3zoRydLO99ilNvSNguXDrow6o06YBTn3Q8Wql4EUHImCuU2Rofi8uno2j0jKIrhmI+84C0Xq3hs/SWfZnXkvNXREvQxCcUt0aSKFoiCi4WNA5dgakzllxdt8QPhhig62UMIyauAgg3Ax4ENTYwfffEP+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=IE689qlD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71798661a52so2041306b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1725822266; x=1726427066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdlK6bqU1J6v6b7a6AyJDnN3HxR3Wbc9tjxaGTWMUE=;
        b=IE689qlDbI35V0hamaDxD0csqU/ZFjkBuoSnLDaOSmTAzxqpUnA2R9ZW8CA+khRVJ6
         OeKT5HW4/7A2wyo/M5B0ZEestQwzsZQ2wghVrQhtONqRY5XgOaWVBILwXE7P3l28SRzi
         G+iZZQOwCUM1QvKRDGpZ6/dXO/Jr9mRk7G8tr5LqYZZloCmxUZ3SxsSYXek/Dwo3hoEX
         njlI7Byjv96n17WYYHklmFMlV8MTgMrThaRT627S9MceoKQqo4LSASthqNuX7BP/7w6p
         3X7ELaDo50dKBrTvw0bGDAh9uML5xp4B9tdXIu44p071hFsujIw1rGgDkvZwqsOpuXxO
         3dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725822266; x=1726427066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVdlK6bqU1J6v6b7a6AyJDnN3HxR3Wbc9tjxaGTWMUE=;
        b=uKeFWcANUJ+2uqNFKATXvwRLr22WlFdfhvUqi1ivH4nrn/0k/sFggaBoZaeFR3Cufh
         DpYbNHZLIc2JHVoyumXcnS1eGP6sZDsOQcwoTrjkr/uMCQkk21XBzz9YXIVE+EKk8bdF
         IbFOwiyKj9OkA1Zu6/tpiEcmo+1wU6+2WEM5xM+z/s4rCEhx07KOnAcqvmVjBt8jLFtP
         rLR2ZT874ODEqwsArRUaCtbMEN9nqzfbutO4m3MHC47FHP9ZfiLhv34OJPtxKx4L62T+
         pW90BpkS4kEsHmm904frAN59k/l1AvM9Z0QM8/lTmwh3TQX7yVU2MoaQmjqBU6ue1ycg
         Irmw==
X-Gm-Message-State: AOJu0YzwRtN8BfreOpnUTbmH4mmXNbmfgf5RwThHzWvLYd8SYU5kcA6Q
	FA+ELA9NGG6Wmy3JPHR+e0ttr0dnXJGCD3DLZZ0ymP5o75WR6tnxAvp/7FPBKoEroot43nHs/9u
	X
X-Google-Smtp-Source: AGHT+IFyaU2il64o/F+ORIgIKZHOvXTBgexbGGEuLPa36C+5BY1sXRPupmYXTT+2C3ihE5u6bfj56g==
X-Received: by 2002:a05:6a00:cca:b0:704:151d:dcce with SMTP id d2e1a72fcca58-718d5341f04mr13528793b3a.5.1725822265513;
        Sun, 08 Sep 2024 12:04:25 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5896f19sm2310580b3a.32.2024.09.08.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:04:24 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>,
	Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] pps: Remove embedded cdev to fix a use-after-free
Date: Sun,  8 Sep 2024 12:04:13 -0700
Message-ID: <ed73319e062495a56f5c8fd95c1674f891871882.1725820970.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
in sys_exit() from gpsd when rebooting:

    pps pps1: removed
    ------------[ cut here ]------------
    kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
    WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
    CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
    Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
    pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : kobject_put+0x120/0x150
    lr : kobject_put+0x120/0x150
    sp : ffffffc0803d3ae0
    x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
    x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
    x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
    x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
    x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
    x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
    x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
    x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
    x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     kobject_put+0x120/0x150
     cdev_put+0x20/0x3c
     __fput+0x2c4/0x2d8
     ____fput+0x1c/0x38
     task_work_run+0x70/0xfc
     do_exit+0x2a0/0x924
     do_group_exit+0x34/0x90
     get_signal+0x7fc/0x8c0
     do_signal+0x128/0x13b4
     do_notify_resume+0xdc/0x160
     el0_svc+0xd4/0xf8
     el0t_64_sync_handler+0x140/0x14c
     el0t_64_sync+0x190/0x194
    ---[ end trace 0000000000000000 ]---

...followed by more symptoms of corruption, with similar stacks:

    refcount_t: underflow; use-after-free.
    kernel BUG at lib/list_debug.c:62!
    Kernel panic - not syncing: Oops - BUG: Fatal exception

This happens because pps_device_destruct() frees the pps_device with the
embedded cdev immediately after calling cdev_del(), but, as the comment
above cdev_del() notes, fops for previously opened cdevs are still
callable even after cdev_del() returns. I think this bug has always
been there: I can't explain why it suddenly started happening every time
I reboot this particular board.

In commit d953e0e837e6 ("pps: Fix a use-after free bug when
unregistering a source."), George Spelvin suggested removing the
embedded cdev. That seems like the simplest way to fix this, so I've
implemented his suggestion, with pps_idr becoming the source of truth
for which minor corresponds to which device.

But now that pps_idr defines userspace visibility instead of cdev_add(),
we need to be sure the pps->dev kobject refcount can't reach zero while
userspace can still find it again. So, the idr_remove() call moves to
pps_unregister_cdev(), and pps_idr now holds a reference to the pps->dev
kobject.

Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
Cc: stable@vger.kernel.org
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/pps.c          | 85 ++++++++++++++++++++------------------
 include/linux/pps_kernel.h |  1 -
 2 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 5d19baae6a38..72606d10f5f5 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -25,7 +25,7 @@
  * Local variables
  */
 
-static dev_t pps_devt;
+static int pps_major;
 static struct class *pps_class;
 
 static DEFINE_MUTEX(pps_idr_lock);
@@ -296,19 +296,35 @@ static long pps_cdev_compat_ioctl(struct file *file,
 #define pps_cdev_compat_ioctl	NULL
 #endif
 
+static struct pps_device *pps_idr_get(unsigned long id)
+{
+	struct pps_device *pps;
+
+	mutex_lock(&pps_idr_lock);
+	pps = idr_find(&pps_idr, id);
+	if (pps)
+		kobject_get(&pps->dev->kobj);
+
+	mutex_unlock(&pps_idr_lock);
+	return pps;
+}
+
 static int pps_cdev_open(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = pps_idr_get(iminor(inode));
+
+	if (!pps)
+		return -ENODEV;
+
 	file->private_data = pps;
-	kobject_get(&pps->dev->kobj);
 	return 0;
 }
 
 static int pps_cdev_release(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = file->private_data;
+
+	WARN_ON(pps->id != iminor(inode));
 	kobject_put(&pps->dev->kobj);
 	return 0;
 }
@@ -332,14 +348,6 @@ static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	cdev_del(&pps->cdev);
-
-	/* Now we can release the ID for re-use */
-	pr_debug("deallocating pps%d\n", pps->id);
-	mutex_lock(&pps_idr_lock);
-	idr_remove(&pps_idr, pps->id);
-	mutex_unlock(&pps_idr_lock);
-
 	kfree(dev);
 	kfree(pps);
 }
@@ -364,39 +372,26 @@ int pps_register_cdev(struct pps_device *pps)
 		goto out_unlock;
 	}
 	pps->id = err;
-	mutex_unlock(&pps_idr_lock);
 
-	devt = MKDEV(MAJOR(pps_devt), pps->id);
-
-	cdev_init(&pps->cdev, &pps_cdev_fops);
-	pps->cdev.owner = pps->info.owner;
-
-	err = cdev_add(&pps->cdev, devt, 1);
-	if (err) {
-		pr_err("%s: failed to add char device %d:%d\n",
-				pps->info.name, MAJOR(pps_devt), pps->id);
-		goto free_idr;
-	}
+	devt = MKDEV(pps_major, pps->id);
 	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
 							"pps%d", pps->id);
 	if (IS_ERR(pps->dev)) {
 		err = PTR_ERR(pps->dev);
-		goto del_cdev;
+		goto free_idr;
 	}
 
 	/* Override the release function with our own */
 	pps->dev->release = pps_device_destruct;
 
-	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
-			MAJOR(pps_devt), pps->id);
+	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
+		 pps->id);
 
+	kobject_get(&pps->dev->kobj);
+	mutex_unlock(&pps_idr_lock);
 	return 0;
 
-del_cdev:
-	cdev_del(&pps->cdev);
-
 free_idr:
-	mutex_lock(&pps_idr_lock);
 	idr_remove(&pps_idr, pps->id);
 out_unlock:
 	mutex_unlock(&pps_idr_lock);
@@ -408,6 +403,13 @@ void pps_unregister_cdev(struct pps_device *pps)
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
 	device_destroy(pps_class, pps->dev->devt);
+
+	/* Now we can release the ID for re-use */
+	pr_debug("deallocating pps%d\n", pps->id);
+	mutex_lock(&pps_idr_lock);
+	idr_remove(&pps_idr, pps->id);
+	kobject_put(&pps->dev->kobj);
+	mutex_unlock(&pps_idr_lock);
 }
 
 /*
@@ -427,6 +429,11 @@ void pps_unregister_cdev(struct pps_device *pps)
  * so that it will not be used again, even if the pps device cannot
  * be removed from the idr due to pending references holding the minor
  * number in use.
+ *
+ * Since pps_idr holds a reference to the kobject, the returned
+ * pps_device is guaranteed to be valid until pps_unregister_cdev() is
+ * called on it. But after calling pps_unregister_cdev(), it may be
+ * freed at any time.
  */
 struct pps_device *pps_lookup_dev(void const *cookie)
 {
@@ -449,13 +456,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
 static void __exit pps_exit(void)
 {
 	class_destroy(pps_class);
-	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
+	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
 }
 
 static int __init pps_init(void)
 {
-	int err;
-
 	pps_class = class_create("pps");
 	if (IS_ERR(pps_class)) {
 		pr_err("failed to allocate class\n");
@@ -463,8 +468,9 @@ static int __init pps_init(void)
 	}
 	pps_class->dev_groups = pps_groups;
 
-	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
-	if (err < 0) {
+	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
+				      &pps_cdev_fops);
+	if (pps_major < 0) {
 		pr_err("failed to allocate char device region\n");
 		goto remove_class;
 	}
@@ -477,8 +483,7 @@ static int __init pps_init(void)
 
 remove_class:
 	class_destroy(pps_class);
-
-	return err;
+	return pps_major;
 }
 
 subsys_initcall(pps_init);
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..8ee312788118 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -56,7 +56,6 @@ struct pps_device {
 
 	unsigned int id;			/* PPS source unique ID */
 	void const *lookup_cookie;		/* For pps_lookup_dev() only */
-	struct cdev cdev;
 	struct device *dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
-- 
2.45.2


