Return-Path: <linux-kernel+bounces-255760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 198709344CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ADF1F21E16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D506F30B;
	Wed, 17 Jul 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtsjuEEN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF43BBEB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255080; cv=none; b=LmPj168U1/J+K7i3OVox8PQJ+BRUT4GN0s0Ik1WU+Q0liayfZjXUkOw5NgIU8CleJPUTUx4VCUTMph+wGmMtLqUQK3OZqCz9WHeuTNrPsbNm62aa956PBZZyuud+dtXIQ+X6xmvrVHNo4eI5Lyo4d+fpD0uVUFHivEPrPlq017k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255080; c=relaxed/simple;
	bh=U735gPL/j4/gNkZpIZj10CDDwOkKG7qvXtx9agyPju4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvcIhxegcAkkChlKLJy0moYK3eV61On2cOOkPklexI4ljk5bo+x/KYBE4Y6Iy/JuhvCaup269cGtVXD6mMx8SGTsKxvX6Ib7gUEEGkoekZ3wc6HT9j7DjygBfAa5rxiOuum3SvDMTOtmf9K2eFEGpjj/mLh+L2KAbE5Is8qvf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtsjuEEN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05a8aa4478so516314276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721255074; x=1721859874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLfk3WKZqMTvBKd64i6B/HOksUTK2sb8iIXkimCFQM=;
        b=WtsjuEENOZRIG63ydjGdZH+zB/mTTX1FrMa9aMXn2ie9UHAG3qWCZPUzTUjPMfpkwJ
         43NSXBom3kriptX3ASUiy9wcPhe0vUp+2pLqp/PXwI/xMek25DqAx9rwPI+6rrC9Ti9f
         GWI6ObXEKI6RdBkmqfb4ftJs8cZJiVooKSmOStegocIEM7dLvZJzKc2pBQM+mxDCWdUc
         m/nQKj5NzX6KILVFoTXBl/XzkpnAp9BSdI79izn7cDz078MUueR09jmECbazG7uAXVGG
         8nqu/h88psSMNGDj/tiR645QamqOeNDdnHbCqIVBSufQ3RauhRmOpBpcRqNB4j0Y4Dgb
         k5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255074; x=1721859874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLfk3WKZqMTvBKd64i6B/HOksUTK2sb8iIXkimCFQM=;
        b=WtcFf4gEo4kmDxVCFlEeJEXTRN44Bg1dsyYgZ2DVwQLn6o7YnpTChCx7dsWGx8MG5y
         g63VWKGUtins/A8Jzz8R/dxQ9D8OEhMY//irBv083PHBUTq8X7Zv8Yi1OTHpCKUxEr0Q
         2L8uPlha6gsCW/7J1A59e/QyWsjpol0mSyMa83MBvsgR9VH6GkuMNExBaiEGa/TZDJx/
         A91v7e3VOvDQ13nsfKl61U8hkkNU4PFk1XbZtuXwqnhWD5dH9nD9DOqJfEMWHWOCzeMB
         HFgcXeL1jK7J6WE+hUxOmUf3/GjHjvJc/GP47pKsncnc+xDJXzrqhQBdQLWnohYQjt61
         UnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZKdLE86ZDzyVhu4u+kbFyLeRBkAFbsK6Ou7CAufnqeOYyOe7GqICSqMealj8046m7w4G02Vq3htAs4fDKVdN3rYV/2StM965F1VY
X-Gm-Message-State: AOJu0YxNx7Tpo5xIdq+t9M1HpUlD1SYWeTfkxGF7ESjM4oM+yBuqYW4L
	86eCO65n/1cWXSlWYiy7Uv6sOMxJSXkt1hj0KvLrZNSrtqbycxD75jYppeAL85SxJSB0DjoO50+
	A98buAvB6SZtZMCQBN2CwxkLULwnigQ==
X-Google-Smtp-Source: AGHT+IGCouqY3qXBhAPrZ6wvEyo1BAsuREg2PdFRGGE6O0pnpk9sCyfzUe+hPFbHoZJIUAjhm0fj6BPI5AYV1WJqT77p
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:a503:d697:557b:840c])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:120c:b0:e02:f35c:d398 with
 SMTP id 3f1490d57ef6-e05ff371065mr23222276.0.1721255073882; Wed, 17 Jul 2024
 15:24:33 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:24:27 -0700
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717222429.2011540-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717222429.2011540-2-axelrasmussen@google.com>
Subject: [PATCH 6.6 1/3] vfio: Create vfio_fs_type with inode per device
From: Axel Rasmussen <axelrasmussen@google.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Eric Auger <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik <leah.rumancik@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@redhat.com>

commit b7c5e64fecfa88764791679cca4786ac65de739e upstream.

By linking all the device fds we provide to userspace to an
address space through a new pseudo fs, we can use tools like
unmap_mapping_range() to zap all vmas associated with a device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240530045236.1005864-2-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 drivers/vfio/device_cdev.c |  7 ++++++
 drivers/vfio/group.c       |  7 ++++++
 drivers/vfio/vfio_main.c   | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h       |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f..bb1817bd4ff3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -39,6 +39,13 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 
 	filep->private_data = df;
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	return 0;
 
 err_put_registration:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429c6191..ded364588d29 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -286,6 +286,13 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	 */
 	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
 			 "(%s:%d)\n", current->comm, task_pid_nr(current));
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 40732e8ed4c6..a205d3a4e379 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -22,8 +22,10 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -43,9 +45,13 @@
 #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC	"VFIO - User Level meta-driver"
 
+#define VFIO_MAGIC 0x5646494f /* "VFIO" */
+
 static struct vfio {
 	struct class			*device_class;
 	struct ida			device_ida;
+	struct vfsmount			*vfs_mount;
+	int				fs_count;
 } vfio;
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -186,6 +192,8 @@ static void vfio_device_release(struct device *dev)
 	if (device->ops->release)
 		device->ops->release(device);
 
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
 	kvfree(device);
 }
 
@@ -228,6 +236,34 @@ struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(_vfio_alloc_device);
 
+static int vfio_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, VFIO_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type vfio_fs_type = {
+	.name = "vfio",
+	.owner = THIS_MODULE,
+	.init_fs_context = vfio_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static struct inode *vfio_fs_inode_new(void)
+{
+	struct inode *inode;
+	int ret;
+
+	ret = simple_pin_fs(&vfio_fs_type, &vfio.vfs_mount, &vfio.fs_count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	inode = alloc_anon_inode(vfio.vfs_mount->mnt_sb);
+	if (IS_ERR(inode))
+		simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+
+	return inode;
+}
+
 /*
  * Initialize a vfio_device so it can be registered to vfio core.
  */
@@ -246,6 +282,11 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	init_completion(&device->comp);
 	device->dev = dev;
 	device->ops = ops;
+	device->inode = vfio_fs_inode_new();
+	if (IS_ERR(device->inode)) {
+		ret = PTR_ERR(device->inode);
+		goto out_inode;
+	}
 
 	if (ops->init) {
 		ret = ops->init(device);
@@ -260,6 +301,9 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return 0;
 
 out_uninit:
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+out_inode:
 	vfio_release_device_set(device);
 	ida_free(&vfio.device_ida, device->index);
 	return ret;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 5ac5f182ce0b..514a7f9b3ef4 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -64,6 +64,7 @@ struct vfio_device {
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
 	void (*put_kvm)(struct kvm *kvm);
+	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
 	u8 iommufd_attached:1;
-- 
2.45.2.993.g49e7a77208-goog


