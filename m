Return-Path: <linux-kernel+bounces-311190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3D9685C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566F2286337
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A71D54D8;
	Mon,  2 Sep 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i8IBfu6I"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FD1D54D2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275212; cv=none; b=QfFHqyxSYODCNPNsP1fmhCNHsDKVoOtHOeUE78R/DYaUFWHeoC02/hH7jtUmhA8Fc7n6SR97NG4Oh067lwp2dpA+2OInpiYkdJiIsg8+QxebWmNQsQNk+cbX7DnJDJC9bO5uikNnjALsGhKF8koic4+OfJzDDYeJEyfakN4fnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275212; c=relaxed/simple;
	bh=LM1TNY8Lojkj9WlEEyFgXKiALoAeXliyUuknPJjuiSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNvhAFqw+GVPxecY5ToOUHg+XWlf6e7euCAGVfZPCgxzsFnJ+7u+Rhv40VhIlYhWaw9MFg/qhIWq7HflDK2frQcha4ESTUPjGQWlZMUBScHnRYOwxVEFhdh4VeHDK3w5jdT9DvbgiaQFuls59vWZEXHkbih4KjjpMRPteJj3CqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i8IBfu6I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275207; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8F/K6gXuWQR15VccFVhsO1O0QRvNL2x4hMbfePUdpfk=;
	b=i8IBfu6IE2Cf8ntTD2pBTCBnfwvEJN9R9MSAkp349WnxEetG0pjIEXrZ6dubaOfFNG8pDDGs+HI+yUJPC1dMgpV5eUyG5K7oweMtBDr/NLX/cJ7QICijRLNiE8jV2fIvgxc3zXQppbMgdX2P0sg5dkZ9iG1HtvWDq4eane+dUvM=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE8BYL5_1725275206)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:47 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: lihongbo22@huawei.com,
	linux-kernel@vger.kernel.org,
	Hongzhen Luo <hongzhen@linux.alibaba.com>
Subject: [PATCH RFC v4 4/4] erofs: introduce .fadvise for page cache share
Date: Mon,  2 Sep 2024 19:06:20 +0800
Message-ID: <20240902110620.2202586-5-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
References: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using .fadvice to release a file's page cache, it frees
those page caches that were firstly read by this file. To achieve
this, an interval tree is added in the inode of that file to track
the segments firstly read by that inode.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c            | 38 +++++++++++++++++++--
 fs/erofs/internal.h        |  5 +++
 fs/erofs/pagecache_share.c | 68 ++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  3 +-
 fs/erofs/super.c           |  9 +++++
 5 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ef27b934115f..e4fcc8a6ce6d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
+#include "pagecache_share.h"
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
 {
@@ -349,6 +350,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
+	struct interval_tree_node *seg;
 	int ret;
 
 	if (file && file->private_data) {
@@ -359,8 +361,22 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 			vi = NULL;
 	}
 	ret = iomap_read_folio(folio, &erofs_iomap_ops);
-	if (vi)
+	if (vi) {
 		folio->mapping->host = file_inode(file);
+		seg = erofs_pcs_alloc_seg();
+		if (!seg)
+			return -ENOMEM;
+		seg->start = folio_index(folio);
+		seg->last = seg->start + (folio_size(folio) >> PAGE_SHIFT);
+		if (seg->last > (vi->vfs_inode.i_size >> PAGE_SHIFT))
+			seg->last = vi->vfs_inode.i_size >> PAGE_SHIFT;
+		if (seg->last >= seg->start) {
+			mutex_lock(&vi->segs_mutex);
+			interval_tree_insert(seg, &vi->segs);
+			mutex_unlock(&vi->segs_mutex);
+		} else
+			erofs_pcs_free_seg(seg);
+	}
 	return ret;
 #else
 	return iomap_read_folio(folio, &erofs_iomap_ops);
@@ -371,6 +387,8 @@ static void erofs_readahead(struct readahead_control *rac)
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
 	struct file *file = rac->file;
+	struct interval_tree_node *seg;
+	erofs_off_t start, end;
 
 	if (file && file->private_data) {
 		vi = file->private_data;
@@ -378,10 +396,26 @@ static void erofs_readahead(struct readahead_control *rac)
 			rac->mapping->host = &vi->vfs_inode;
 		else
 			vi = NULL;
+		start = readahead_pos(rac);
+		end = start + readahead_length(rac);
+		if (end > vi->vfs_inode.i_size)
+			end = vi->vfs_inode.i_size;
 	}
 	iomap_readahead(rac, &erofs_iomap_ops);
-	if (vi)
+	if (vi) {
 		rac->mapping->host = file_inode(file);
+		seg = erofs_pcs_alloc_seg();
+		if (!seg)
+			return;
+		seg->start = start >> PAGE_SHIFT;
+		seg->last = end >> PAGE_SHIFT;
+		if (seg->last >= seg->start) {
+			mutex_lock(&vi->segs_mutex);
+			interval_tree_insert(seg, &vi->segs);
+			mutex_unlock(&vi->segs_mutex);
+		} else
+			erofs_pcs_free_seg(seg);
+	}
 #else
 	return iomap_readahead(rac, &erofs_iomap_ops);
 #endif
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 358377825927..59af8768fab8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/interval_tree.h>
+#include <linux/mutex.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -290,6 +292,9 @@ struct erofs_inode {
 	};
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct inode *ano_inode;
+	/* segments attributed by this inode */
+	struct rb_root_cached segs;
+	struct mutex segs_mutex;
 #endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
index 2d2a74547b67..a97024904019 100644
--- a/fs/erofs/pagecache_share.c
+++ b/fs/erofs/pagecache_share.c
@@ -4,6 +4,9 @@
  */
 #include <linux/xxhash.h>
 #include <linux/refcount.h>
+#include <uapi/linux/fadvise.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
 #include "pagecache_share.h"
 #include "internal.h"
 #include "xattr.h"
@@ -15,6 +18,7 @@
 static DEFINE_MUTEX(pseudo_mnt_lock);
 static refcount_t pseudo_mnt_count;
 static struct vfsmount *erofs_pcs_mnt;
+struct kmem_cache *erofs_pcs_segsp;
 
 int erofs_pcs_init_mnt(void)
 {
@@ -25,6 +29,11 @@ int erofs_pcs_init_mnt(void)
 			return PTR_ERR(tmp);
 		erofs_pcs_mnt = tmp;
 		refcount_set(&pseudo_mnt_count, 1);
+		erofs_pcs_segsp = kmem_cache_create("erofs_pcs_segs",
+				sizeof(struct interval_tree_node), 0,
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT, NULL);
+		if (!erofs_pcs_segsp)
+			return -ENOMEM;
 	} else
 		refcount_add(1, &pseudo_mnt_count);
 	mutex_unlock(&pseudo_mnt_lock);
@@ -37,10 +46,22 @@ void erofs_pcs_free_mnt(void)
 	if (refcount_dec_and_test(&pseudo_mnt_count)) {
 		kern_unmount(erofs_pcs_mnt);
 		erofs_pcs_mnt = NULL;
+		kmem_cache_destroy(erofs_pcs_segsp);
+		erofs_pcs_segsp = NULL;
 	}
 	mutex_unlock(&pseudo_mnt_lock);
 }
 
+struct interval_tree_node *erofs_pcs_alloc_seg(void)
+{
+	return kmem_cache_alloc(erofs_pcs_segsp, GFP_KERNEL);
+}
+
+void erofs_pcs_free_seg(struct interval_tree_node *seg)
+{
+	kmem_cache_free(erofs_pcs_segsp, seg);
+}
+
 static int erofs_pcs_eq(struct inode *inode, void *data)
 {
 	return inode->i_private && memcmp(inode->i_private, data,
@@ -73,6 +94,8 @@ void erofs_pcs_fill_inode(struct inode *inode)
 		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
 				erofs_pcs_eq, erofs_pcs_set_fprt, fprt);
 		vi->ano_inode = ano_inode;
+		vi->segs = RB_ROOT_CACHED;
+		mutex_init(&vi->segs_mutex);
 		if (ano_inode->i_state & I_NEW) {
 			if (erofs_inode_is_data_compressed(vi->datalayout))
 				ano_inode->i_mapping->a_ops = &z_erofs_aops;
@@ -160,6 +183,50 @@ static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int erofs_pcs_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct erofs_inode *vi = EROFS_I(file_inode(file));
+	struct interval_tree_node *seg, *next_seg, *new_seg;
+	struct file *ano_file = file->private_data;
+	erofs_off_t start, end;
+	int err = 0;
+	u64 l, r;
+
+	if (advice != POSIX_FADV_DONTNEED)
+		return generic_fadvise(ano_file, offset, len, advice);
+
+	start = offset >> PAGE_SHIFT;
+	/* len = 0 means EOF */
+	end = (!len ? LLONG_MAX : offset + len) >> PAGE_SHIFT;
+
+	mutex_lock(&vi->segs_mutex);
+	seg = interval_tree_iter_first(&vi->segs, start, end);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, start, end);
+		l = max_t(u64, seg->start | 0ULL, start);
+		r = min_t(u64, seg->last | 0ULL, end);
+		if (l > r)
+			continue;
+		(void)invalidate_mapping_pages(ano_file->f_mapping, l, r);
+		if (seg->start < l) {
+			new_seg = erofs_pcs_alloc_seg();
+			new_seg->start = seg->start;
+			new_seg->last = l;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+		if (r < seg->last) {
+			new_seg = erofs_pcs_alloc_seg();
+			new_seg->start = r;
+			new_seg->last = seg->last;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+		interval_tree_remove(seg, &vi->segs);
+		seg = next_seg;
+	}
+	mutex_unlock(&vi->segs_mutex);
+	return err;
+}
+
 const struct file_operations erofs_pcs_file_fops = {
 	.open		= erofs_pcs_file_open,
 	.llseek		= generic_file_llseek,
@@ -168,4 +235,5 @@ const struct file_operations erofs_pcs_file_fops = {
 	.release	= erofs_pcs_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_pcs_fadvise,
 };
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
index b8111291cf79..e0aba20a6a0e 100644
--- a/fs/erofs/pagecache_share.h
+++ b/fs/erofs/pagecache_share.h
@@ -14,7 +14,8 @@
 int erofs_pcs_init_mnt(void);
 void erofs_pcs_free_mnt(void);
 void erofs_pcs_fill_inode(struct inode *inode);
+struct interval_tree_node *erofs_pcs_alloc_seg(void);
+void erofs_pcs_free_seg(struct interval_tree_node *seg);
 
 extern const struct vm_operations_struct generic_file_vm_ops;
-
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 113e305080fa..da595e608702 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -105,10 +105,19 @@ static void erofs_free_inode(struct inode *inode)
 	struct erofs_inode *vi = EROFS_I(inode);
 
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct interval_tree_node *seg, *next_seg;
+
 	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
 		iput(vi->ano_inode);
 		vi->ano_inode = NULL;
 	}
+	seg = interval_tree_iter_first(&vi->segs, 0, LLONG_MAX);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, 0, LLONG_MAX);
+		interval_tree_remove(seg, &vi->segs);
+		erofs_pcs_free_seg(seg);
+		seg = next_seg;
+	}
 #endif
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
-- 
2.43.5


