Return-Path: <linux-kernel+bounces-304854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55659625DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA14A1C22D06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C469316D30C;
	Wed, 28 Aug 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cE0eWcpG"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94916BE1D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844010; cv=none; b=M9L8WqBXEgdf3FDB7LSi+zm97zK+9Fu828aa7P7wu4VM1PcqBzEa4sT1H0NQu3+im9C93fcVhkEc5eJOb6ei/zpiDn/QpkH9KYq0TTAI59d9W24zG9PgBVMBPAbIs5SuymAUah8zj7XOA7bE+TM+krOoCs/+ST/ajucrq38iDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844010; c=relaxed/simple;
	bh=3pi99uHIwwOIFQzEvRSPY6co3WBSXGC1UypCX80O/qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvAFBSx01q2vVHjViQTGZKEMcDI2ZSu4lDtPw1sDC4eNyyOIO1jK6PCPP7JBcjKUct04CIEtW+RLomiWflHt8RiXugVqtXRhVJNpTJ1VScHSa4SAmXsh4cvNCbfoRti63oMDC5V2T4lfkIkEp3TIA8qaFJd3WeuHwFf6YBy7b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cE0eWcpG; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844004; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GP1qWyY2z2RJIcQnlphdbQWrtwZ/5976hBqeDeYwFxE=;
	b=cE0eWcpGrDht4o3bs8WIhkLlBFXu9w/b1SAyTUG3kjGJWwncREZiI9Sk21zr1CJ6TSgn2YlZ8qjCc1voOu8zHrsQhPcXBaYoJcuTSlM229H6GAq5EIpydRix/95U+Y/xZ/WI9JLvV3nGG3R4zHKFTif+xTRb7TCRd3eFiwMZ1ag=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDpbUPP_1724844003)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:20:04 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Cc: linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v3 2/3] erofs: introduce page cache share feature
Date: Wed, 28 Aug 2024 19:19:58 +0800
Message-ID: <20240828111959.3677011-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
References: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
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
phase, the file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
(indicated by the `ano_inode` field). When a read request occurs, the
anonymous inode serves as a "container" whose page cache is shared. The
actual operations involving the iomap are carried out by the original
inode which is mapped to the anonymous inode.

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
|  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3:
The previous implementation maintained a list for inodes with identical content,
and utilized one of these inodes from the list to handle read request operations.
However, this could lead to a situation where a device cannot be unmounted because
its inode is being used for read-related operations.

This implementation has been redesigned to avoid the aforementioned unmounting issues.
Additionally, this implementation adds support for compressed files.

v2: https://lore.kernel.org/all/20240731080704.678259-2-hongzhen@linux.alibaba.com/

v1: https://lore.kernel.org/all/20240722065355.1396365-4-hongzhen@linux.alibaba.com/
---
 fs/erofs/Kconfig           |  10 +++
 fs/erofs/Makefile          |   1 +
 fs/erofs/internal.h        |   4 +
 fs/erofs/pagecache_share.c | 171 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  20 +++++
 5 files changed, 206 insertions(+)
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
index 3f1984664dac..a1517b2e6973 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -288,6 +288,9 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct inode *ano_inode;
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -384,6 +387,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_pcs_file_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
new file mode 100644
index 000000000000..2d2a74547b67
--- /dev/null
+++ b/fs/erofs/pagecache_share.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include "pagecache_share.h"
+#include "internal.h"
+#include "xattr.h"
+
+#define PCS_FPRT_IDX	4
+#define PCS_FPRT_NAME	"erofs.fingerprint"
+#define PCS_FPRT_MAXLEN (sizeof(size_t) + 1024)
+
+static DEFINE_MUTEX(pseudo_mnt_lock);
+static refcount_t pseudo_mnt_count;
+static struct vfsmount *erofs_pcs_mnt;
+
+int erofs_pcs_init_mnt(void)
+{
+	mutex_lock(&pseudo_mnt_lock);
+	if (!erofs_pcs_mnt) {
+		struct vfsmount *tmp = kern_mount(&erofs_anon_fs_type);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+		erofs_pcs_mnt = tmp;
+		refcount_set(&pseudo_mnt_count, 1);
+	} else
+		refcount_add(1, &pseudo_mnt_count);
+	mutex_unlock(&pseudo_mnt_lock);
+	return 0;
+}
+
+void erofs_pcs_free_mnt(void)
+{
+	mutex_lock(&pseudo_mnt_lock);
+	if (refcount_dec_and_test(&pseudo_mnt_count)) {
+		kern_unmount(erofs_pcs_mnt);
+		erofs_pcs_mnt = NULL;
+	}
+	mutex_unlock(&pseudo_mnt_lock);
+}
+
+static int erofs_pcs_eq(struct inode *inode, void *data)
+{
+	return inode->i_private && memcmp(inode->i_private, data,
+			sizeof(size_t) + *(size_t *)data) == 0 ? 1 : 0;
+}
+
+static int erofs_pcs_set_fprt(struct inode *inode, void *data)
+{
+	/* fprt length and content */
+	inode->i_private = kmalloc(*(size_t *)data + sizeof(size_t),
+				   GFP_KERNEL);
+	memcpy(inode->i_private, data, sizeof(size_t) + *(size_t *)data);
+	return 0;
+}
+
+void erofs_pcs_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	char fprt[PCS_FPRT_MAXLEN];
+	struct inode *ano_inode;
+	unsigned long fprt_hash;
+	size_t fprt_len;
+
+	vi->ano_inode = NULL;
+	fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME,
+			fprt + sizeof(size_t), PCS_FPRT_MAXLEN);
+	if (fprt_len > 0 && fprt_len <= PCS_FPRT_MAXLEN) {
+		*(size_t *)fprt = fprt_len;
+		fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
+		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
+				erofs_pcs_eq, erofs_pcs_set_fprt, fprt);
+		vi->ano_inode = ano_inode;
+		if (ano_inode->i_state & I_NEW) {
+			if (erofs_inode_is_data_compressed(vi->datalayout))
+				ano_inode->i_mapping->a_ops = &z_erofs_aops;
+			else
+				ano_inode->i_mapping->a_ops =
+						&erofs_raw_access_aops;
+			ano_inode->i_size = inode->i_size;
+			unlock_new_inode(ano_inode);
+		}
+	}
+}
+
+static struct file *erofs_pcs_alloc_file(struct file *file,
+					 struct inode *ano_inode)
+{
+	struct file *ano_file;
+
+	ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
+				     O_RDONLY, &erofs_file_fops);
+	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
+	ano_file->private_data = EROFS_I(file_inode(file));
+	return ano_file;
+}
+
+static int erofs_pcs_file_open(struct inode *inode, struct file *file)
+{
+	struct file *ano_file;
+	struct inode *ano_inode;
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	ano_inode = vi->ano_inode;
+	if (!ano_inode)
+		return -EINVAL;
+	ano_file = erofs_pcs_alloc_file(file, ano_inode);
+	ihold(ano_inode);
+	file->private_data = (void *)ano_file;
+	return 0;
+}
+
+static int erofs_pcs_file_release(struct inode *inode, struct file *file)
+{
+	if (!file->private_data)
+		return -EINVAL;
+	fput((struct file *)file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file, *ano_file;
+	struct kiocb ano_iocb;
+	ssize_t res;
+
+	if (!iov_iter_count(to))
+		return 0;
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return erofs_file_fops.read_iter(iocb, to);
+#endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return erofs_file_fops.read_iter(iocb, to);
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
+static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *ano_file = file->private_data;
+
+	vma_set_file(vma, ano_file);
+	vma->vm_ops = &generic_file_vm_ops;
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
index 000000000000..b8111291cf79
--- /dev/null
+++ b/fs/erofs/pagecache_share.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_PAGECACHE_SHARE_H
+#define __EROFS_PAGECACHE_SHARE_H
+
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/rwlock.h>
+#include <linux/mutex.h>
+#include "internal.h"
+
+int erofs_pcs_init_mnt(void);
+void erofs_pcs_free_mnt(void);
+void erofs_pcs_fill_inode(struct inode *inode);
+
+extern const struct vm_operations_struct generic_file_vm_ops;
+
+#endif
-- 
2.43.5


