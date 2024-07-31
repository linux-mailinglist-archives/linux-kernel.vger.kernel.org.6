Return-Path: <linux-kernel+bounces-268747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9729428D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA241C21688
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC31A7F6E;
	Wed, 31 Jul 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P0/MiyCh"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AA450E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413253; cv=none; b=alNIuAdwhBWSl8191fZklrzx7deI8EhG/WumQvL0UjNYIPAjzYoTCZaXbZU+S4i6RIulStWZhcgOX5DQGNPpjMJHxRzShP1Vu+6TW0hDiVts1Wf4knHuBM5VqGPi4A1kNZoMqy5UqPNRWc5kfE2rRAPhL4YaBts13cLlNu2DPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413253; c=relaxed/simple;
	bh=UP59hoySUxTOQWRjvpXN0tg1HDwfSZ1aixRrwcBqzAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KArq/MMMaE/t5ZSxt2eHa/ZphdIjcM/RKugkFP8FaKok7MYyaxrN0EQciabS96KhlWrSYb6HJ5l9m+2rkRxgj6HJ4VtsTaPXpcKWPsmmoRnPUTntdsy7uF9Nv77fHdO2Lvoz+SL8EPaap4bMLROOcBSatdO6Zpy208mZTqOvXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P0/MiyCh; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722413247; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1vychGnx9JkHG1URHFL9M2pGgd4sXlxVdgTpdcpkQHk=;
	b=P0/MiyChnboFFrXyu62CSFWb/pXaE9K8UkKc3yOq3oEARoFVY3FsDOUmBGc+xseaTno0uWCpMOPBAJ8jxoRe7xtexwb8ppKs2IFlGWPtgZ/rXf9uUa6VPPW+XxdSCTDTfX0eD8o6YuWW8DaLOn1Byd+LWc86fOIto1pHuSkVcp0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WBiiDRy_1722413246;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBiiDRy_1722413246)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 16:07:26 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v2 1/2] erofs: introduce page cache share feature
Date: Wed, 31 Jul 2024 16:07:03 +0800
Message-ID: <20240731080704.678259-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

This introduces the page cache share feature in erofs. During the mkfs
phase, file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to a list. One of these inodes
that in the list (the first inode in this implementation) is used to store
the actual content. In this way, a single copy of the selected inode's
page cache can serve read requests from several files mapped to it.

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     941     |       9%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     139     |      11%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      23%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Refactored the implementation.
v1: https://lore.kernel.org/all/20240722065355.1396365-4-hongzhen@linux.alibaba.com/
---
 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/internal.h        |   8 ++
 fs/erofs/pagecache_share.c | 189 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  15 +++
 5 files changed, 223 insertions(+)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..756a74de623c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -158,3 +158,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_PAGE_CACHE_SHARE
+       bool "EROFS page cache share support"
+       depends on EROFS_FS
+       default n
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 097d672e6b14..f14a2ac0e561 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 736607675396..e3c17b28d1c5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -288,6 +288,13 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct list_head pcs_list;
+	struct rw_semaphore pcs_rwsem;
+	char *fprt;
+	int fprt_len;
+	unsigned long fprt_hash;
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -383,6 +390,7 @@ extern const struct inode_operations erofs_fast_symlink_iops;
 extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
+extern const struct file_operations erofs_pcs_file_fops;
 extern const struct file_operations erofs_dir_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
new file mode 100644
index 000000000000..985dd2a38b5e
--- /dev/null
+++ b/fs/erofs/pagecache_share.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xarray.h>
+#include <linux/mutex.h>
+#include <linux/xxhash.h>
+#include "internal.h"
+#include "xattr.h"
+#include "pagecache_share.h"
+
+struct erofs_pcs_lhead {
+	struct mutex lmutex;
+	struct list_head list;
+};
+
+#define PCS_FPRT_IDX	4
+#define PCS_FPRT_NAME	"erofs.fingerprint"
+#define PCS_FPRT_MAXLEN 1024
+
+DEFINE_XARRAY(pcs_xarray);
+
+void erofs_pcs_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	char fprt[PCS_FPRT_MAXLEN];
+
+	vi->fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME, fprt,
+				      PCS_FPRT_MAXLEN);
+	if (vi->fprt_len > 0 && vi->fprt_len <= PCS_FPRT_MAXLEN) {
+		vi->fprt = kmalloc(vi->fprt_len, GFP_KERNEL);
+		if (IS_ERR(vi->fprt)) {
+			vi->fprt_len = -1;
+			return;
+		}
+		memcpy(vi->fprt, fprt, vi->fprt_len);
+		vi->fprt_hash = xxh32(vi->fprt, vi->fprt_len, 0);
+	}
+}
+
+int erofs_pcs_add(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_pcs_lhead *lst;
+
+	xa_lock(&pcs_xarray);
+	lst = xa_load(&pcs_xarray, vi->fprt_hash);
+	if (!lst) {
+		lst = kmalloc(sizeof(struct erofs_pcs_lhead), GFP_KERNEL);
+		if (!lst) {
+			xa_unlock(&pcs_xarray);
+			return -ENOMEM;
+		}
+		mutex_init(&lst->lmutex);
+		INIT_LIST_HEAD(&lst->list);
+		/* we have already held the xa_lock here */
+		__xa_store(&pcs_xarray, vi->fprt_hash, lst, GFP_KERNEL);
+	}
+	xa_unlock(&pcs_xarray);
+
+	mutex_lock(&lst->lmutex);
+	list_add_tail(&vi->pcs_list, &lst->list);
+	mutex_unlock(&lst->lmutex);
+	return 0;
+}
+
+int erofs_pcs_remove(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
+
+	if (!lst || list_empty(&lst->list))
+		return -EINVAL;
+
+	mutex_lock(&lst->lmutex);
+	down_write(&vi->pcs_rwsem);
+	list_del(&vi->pcs_list);
+	up_write(&vi->pcs_rwsem);
+	mutex_unlock(&lst->lmutex);
+
+	xa_lock(&pcs_xarray);
+	if (list_empty(&lst->list)) {
+		__xa_erase(&pcs_xarray, vi->fprt_hash);
+		kfree(lst);
+	}
+	xa_unlock(&pcs_xarray);
+	return 0;
+}
+
+static struct inode *erofs_pcs_get4read(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode), *pcs_inode = NULL, *p, *tmp;
+	struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
+
+	if (!lst || list_empty(&lst->list))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&lst->lmutex);
+	list_for_each_entry_safe(p, tmp, &lst->list, pcs_list) {
+		if (vi->fprt_len == p->fprt_len &&
+			!memcmp(vi->fprt, p->fprt, p->fprt_len)) {
+			pcs_inode = p;
+			break;
+		}
+	}
+	if (pcs_inode)
+		down_read(&pcs_inode->pcs_rwsem);
+	mutex_unlock(&lst->lmutex);
+
+	return pcs_inode ? &pcs_inode->vfs_inode : ERR_PTR(-EINVAL);
+}
+
+static int erofs_pcs_file_open(struct inode *inode, struct file *file)
+{
+	struct inode *pcs_inode;
+	struct file *ano_file;
+
+	pcs_inode = erofs_pcs_get4read(inode);
+	if (IS_ERR(pcs_inode))
+		return PTR_ERR(pcs_inode);
+
+	ano_file = alloc_file_pseudo(pcs_inode, file->f_path.mnt, "[erofs_pcs_f]",
+				     O_RDONLY, &erofs_file_fops);
+	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
+	ihold(pcs_inode);
+	file->private_data = (void *)ano_file;
+	return 0;
+}
+
+static int erofs_pcs_file_release(struct inode *inode, struct file *file)
+{
+	struct inode *pcs_inode;
+
+	if (!file->private_data)
+		return -EINVAL;
+	pcs_inode = ((struct file *)file->private_data)->f_inode;
+	up_read(&EROFS_I(pcs_inode)->pcs_rwsem);
+	fput((struct file *)file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
+{
+	struct file *file, *ano_file;
+	struct kiocb ano_iocb;
+	ssize_t res;
+
+	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
+	file = iocb->ki_filp;
+	ano_file = file->private_data;
+	if (!ano_file)
+		return -EINVAL;
+	ano_iocb.ki_filp = ano_file;
+	res = filemap_read(&ano_iocb, to, 0);
+	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
+	iocb->ki_filp = file;
+	file_accessed(file);
+	return res;
+}
+
+static vm_fault_t erofs_pcs_fault(struct vm_fault *vmf)
+{
+	return filemap_fault(vmf);
+}
+
+static const struct vm_operations_struct erofs_pcs_file_vm_ops = {
+	.fault = erofs_pcs_fault,
+};
+
+static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *ano_file = file->private_data;
+
+	vma_set_file(vma, ano_file);
+	vma->vm_ops = &erofs_pcs_file_vm_ops;
+	return 0;
+}
+
+const struct file_operations erofs_pcs_file_fops = {
+	.open		= erofs_pcs_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_pcs_file_read_iter,
+	.mmap		= erofs_pcs_mmap,
+	.release	= erofs_pcs_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
new file mode 100644
index 000000000000..fb75ae3abd8a
--- /dev/null
+++ b/fs/erofs/pagecache_share.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_PAGECACHE_SHARE_H
+#define __EROFS_PAGECACHE_SHARE_H
+
+#include <linux/mutex.h>
+#include "internal.h"
+
+void erofs_pcs_fill_inode(struct inode *inode);
+int erofs_pcs_add(struct inode *inode);
+int erofs_pcs_remove(struct inode *inode);
+
+#endif
-- 
2.43.5


