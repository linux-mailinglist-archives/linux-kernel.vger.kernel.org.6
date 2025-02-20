Return-Path: <linux-kernel+bounces-522993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835DA3D0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB717C284
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A901EB9F7;
	Thu, 20 Feb 2025 05:36:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80F1E571F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029768; cv=none; b=Xz6VcgI/kZbEG8HI3AjEJi2DfV7YLQFM8UEPjLpQHknuief42NuLFYalPPemtjma0P8hcYJxQLKJRKdXe2Kdfpg+kSJwHDig2UxmISTTzl1c38OYwnaXp+k5eBU/TqOWjt3wcctLx9cNlbyI9JXcGw/I9QtdAYbKex66ttgMDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029768; c=relaxed/simple;
	bh=j7QU/35dX1hh0elbRPf8gMTWbEEz1zESJHGhkIar0Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oKOmspIOAf9UEIYifP6FZ8Z7JJPeSX5hFycxRprX8mU6knd1WUUeVcU10wyhbT4xwNi/IKg13Ki/Cq66/WUVBi6M8D5JeX4sRzmWJEZOGVDNvPTuQuqt/Ij2k2UUFW8GeiX/dDpdn/FaJP1Bl/WQUCZruO8ijX83fqgmmMBpZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-f9-67b6bba672fe
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 15/26] fs, filemap: refactor to gather the scattered ->write_{begin,end}() calls
Date: Thu, 20 Feb 2025 14:20:16 +0900
Message-Id: <20250220052027.58847-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDU7vs7KYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	388mFszMrujZfYGtgbE1tIuRk0NCwESires2M4zd8aaRFcRmE1CXuHHjJ1hcRMBM4mDrH3YQ
	m1ngLpPEgX62LkYODmGBDIkJK6xBwiwCqhLXNneDtfICle/Ys5ERYqS8xOoNB8DGcALFf8zo
	ZQOxhQRMJd4tuMTUxcgFVPOZTeLX3s9sEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVe
	ZoVecn7uJkZg2C+r/RO9g/HTheBDjAIcjEo8vDNat6ULsSaWFVfmHmKU4GBWEuFtq9+SLsSb
	klhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFx1ca/ahuM56hH
	1Xsd274v+fLC/17ZPw6m6X38knPm++09M58k6fzbVnXjjB1f/lzjfd3lU3YLqJjXPHRd9Mxi
	x8HTnnF5LztUNz91Pd74Ys6BSctLC2/qP2w+8K3A7tMBs8tTaldaFUxiSFX5d/DUpxWmGn3c
	+c/nWYbPUJl33H5fcYbKG+6DW5VYijMSDbWYi4oTAb3RVLJ3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g/d7DSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfH9bGLBzOyKnt0X2BoYW0O7GDk5JARMJDreNLKC2GwC6hI3bvxkBrFFBMwk
	Drb+YQexmQXuMkkc6GfrYuTgEBbIkJiwwhokzCKgKnFtczdYKy9Q+Y49GxkhRspLrN5wAGwM
	J1D8x4xeNhBbSMBU4t2CS0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAziZbV/
	Ju5g/HLZ/RCjAAejEg/vg8db04VYE8uKK3MPMUpwMCuJ8LbVb0kX4k1JrKxKLcqPLyrNSS0+
	xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYOwL21D2p295TsuKHdzXTq60uv7q+1S/
	A6vWx9r2xbB7+5qpWsip7gxs1dn68WzI5Qv71/M8/rP2nb1xyx/OHxezgu3q3YNfqH34e9h/
	rU2PxgVrvom1H1bzXODc2n1QrVK+8PjaFZN2H69zbrXfXH6VtbpPqTfr0mTZ/kOPln0WVq+c
	+5Xx5QwlluKMREMt5qLiRADutSDtXgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
requires to hook when updating page cache that might have pages that
have been mapped on any tasks so that tlb flush needed can be performed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 11 ++++-------
 fs/affs/file.c                            |  4 ++--
 fs/buffer.c                               | 14 ++++++--------
 fs/exfat/file.c                           |  5 ++---
 fs/ext4/verity.c                          |  5 ++---
 fs/f2fs/super.c                           |  5 ++---
 fs/f2fs/verity.c                          |  5 ++---
 fs/namei.c                                |  5 ++---
 include/linux/fs.h                        | 18 ++++++++++++++++++
 mm/filemap.c                              |  5 ++---
 10 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index fe69f2c8527d7..1d475d681d3de 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -422,7 +422,6 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 	     const struct drm_i915_gem_pwrite *arg)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	char __user *user_data = u64_to_user_ptr(arg->data_ptr);
 	u64 remain;
 	loff_t pos;
@@ -481,7 +480,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err)
 			return err;
 
-		err = aops->write_begin(obj->base.filp, mapping, pos, len,
+		err = mapping_write_begin(obj->base.filp, mapping, pos, len,
 					&folio, &data);
 		if (err < 0)
 			return err;
@@ -492,7 +491,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		pagefault_enable();
 		kunmap_local(vaddr);
 
-		err = aops->write_end(obj->base.filp, mapping, pos, len,
+		err = mapping_write_end(obj->base.filp, mapping, pos, len,
 				      len - unwritten, folio, data);
 		if (err < 0)
 			return err;
@@ -658,7 +657,6 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 {
 	struct drm_i915_gem_object *obj;
 	struct file *file;
-	const struct address_space_operations *aops;
 	loff_t pos;
 	int err;
 
@@ -670,21 +668,20 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 	GEM_BUG_ON(obj->write_domain != I915_GEM_DOMAIN_CPU);
 
 	file = obj->base.filp;
-	aops = file->f_mapping->a_ops;
 	pos = 0;
 	do {
 		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
 		struct folio *folio;
 		void *fsdata;
 
-		err = aops->write_begin(file, file->f_mapping, pos, len,
+		err = mapping_write_begin(file, file->f_mapping, pos, len,
 					&folio, &fsdata);
 		if (err < 0)
 			goto fail;
 
 		memcpy_to_folio(folio, offset_in_folio(folio, pos), data, len);
 
-		err = aops->write_end(file, file->f_mapping, pos, len, len,
+		err = mapping_write_end(file, file->f_mapping, pos, len, len,
 				      folio, fsdata);
 		if (err < 0)
 			goto fail;
diff --git a/fs/affs/file.c b/fs/affs/file.c
index a5a861dd52230..10e7f53828e93 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -885,9 +885,9 @@ affs_truncate(struct inode *inode)
 		loff_t isize = inode->i_size;
 		int res;
 
-		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, &folio, &fsdata);
+		res = mapping_write_begin(NULL, mapping, isize, 0, &folio, &fsdata);
 		if (!res)
-			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, folio, fsdata);
+			res = mapping_write_end(NULL, mapping, isize, 0, 0, folio, fsdata);
 		else
 			inode->i_size = AFFS_I(inode)->mmu_private;
 		mark_inode_dirty(inode);
diff --git a/fs/buffer.c b/fs/buffer.c
index 88e765b0699fe..7cb0295500937 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2456,7 +2456,6 @@ EXPORT_SYMBOL(block_read_full_folio);
 int generic_cont_expand_simple(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	struct folio *folio;
 	void *fsdata = NULL;
 	int err;
@@ -2465,11 +2464,11 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
+	err = mapping_write_begin(NULL, mapping, size, 0, &folio, &fsdata);
 	if (err)
 		goto out;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
+	err = mapping_write_end(NULL, mapping, size, 0, 0, folio, fsdata);
 	BUG_ON(err > 0);
 
 out:
@@ -2481,7 +2480,6 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 			    loff_t pos, loff_t *bytes)
 {
 	struct inode *inode = mapping->host;
-	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct folio *folio;
 	void *fsdata = NULL;
@@ -2501,12 +2499,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = PAGE_SIZE - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
+		err = mapping_write_begin(file, mapping, curpos, len,
 					    &folio, &fsdata);
 		if (err)
 			goto out;
 		folio_zero_range(folio, offset_in_folio(folio, curpos), len);
-		err = aops->write_end(file, mapping, curpos, len, len,
+		err = mapping_write_end(file, mapping, curpos, len, len,
 						folio, fsdata);
 		if (err < 0)
 			goto out;
@@ -2534,12 +2532,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = offset - zerofrom;
 
-		err = aops->write_begin(file, mapping, curpos, len,
+		err = mapping_write_begin(file, mapping, curpos, len,
 					    &folio, &fsdata);
 		if (err)
 			goto out;
 		folio_zero_range(folio, offset_in_folio(folio, curpos), len);
-		err = aops->write_end(file, mapping, curpos, len, len,
+		err = mapping_write_end(file, mapping, curpos, len, len,
 						folio, fsdata);
 		if (err < 0)
 			goto out;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a25d7eb789f4c..242563b9dec95 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -539,7 +539,6 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
 	struct inode *inode = file_inode(file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *ops = mapping->a_ops;
 
 	pos = ei->valid_size;
 	while (pos < new_valid_size) {
@@ -550,11 +549,11 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
 		if (pos + len > new_valid_size)
 			len = new_valid_size - pos;
 
-		err = ops->write_begin(file, mapping, pos, len, &folio, NULL);
+		err = mapping_write_begin(file, mapping, pos, len, &folio, NULL);
 		if (err)
 			goto out;
 
-		err = ops->write_end(file, mapping, pos, len, len, folio, NULL);
+		err = mapping_write_end(file, mapping, pos, len, len, folio, NULL);
 		if (err < 0)
 			goto out;
 		pos += len;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index d9203228ce979..64fa43f80c73e 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -68,7 +68,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 			   loff_t pos)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 
 	if (pos + count > inode->i_sb->s_maxbytes)
 		return -EFBIG;
@@ -80,13 +79,13 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *fsdata = NULL;
 		int res;
 
-		res = aops->write_begin(NULL, mapping, pos, n, &folio, &fsdata);
+		res = mapping_write_begin(NULL, mapping, pos, n, &folio, &fsdata);
 		if (res)
 			return res;
 
 		memcpy_to_folio(folio, offset_in_folio(folio, pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, folio, fsdata);
+		res = mapping_write_end(NULL, mapping, pos, n, n, folio, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd482..f8d5ee466807c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2678,7 +2678,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
 	int offset = off & (sb->s_blocksize - 1);
 	size_t towrite = len;
 	struct folio *folio;
@@ -2690,7 +2689,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-		err = a_ops->write_begin(NULL, mapping, off, tocopy,
+		err = mapping_write_begin(NULL, mapping, off, tocopy,
 							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
@@ -2703,7 +2702,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 		memcpy_to_folio(folio, offset_in_folio(folio, off), data, tocopy);
 
-		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
+		mapping_write_end(NULL, mapping, off, tocopy, tocopy,
 						folio, fsdata);
 		offset = 0;
 		towrite -= tocopy;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 2287f238ae09e..b232589546d39 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -72,7 +72,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 			   loff_t pos)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 
 	if (pos + count > F2FS_BLK_TO_BYTES(max_file_blocks(inode)))
 		return -EFBIG;
@@ -84,13 +83,13 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *fsdata = NULL;
 		int res;
 
-		res = aops->write_begin(NULL, mapping, pos, n, &folio, &fsdata);
+		res = mapping_write_begin(NULL, mapping, pos, n, &folio, &fsdata);
 		if (res)
 			return res;
 
 		memcpy_to_folio(folio, offset_in_folio(folio, pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, folio, fsdata);
+		res = mapping_write_end(NULL, mapping, pos, n, n, folio, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac20..14a701ecf1a7e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5349,7 +5349,6 @@ EXPORT_SYMBOL(page_readlink);
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct folio *folio;
 	void *fsdata = NULL;
@@ -5359,7 +5358,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 retry:
 	if (nofs)
 		flags = memalloc_nofs_save();
-	err = aops->write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
+	err = mapping_write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
 	if (nofs)
 		memalloc_nofs_restore(flags);
 	if (err)
@@ -5367,7 +5366,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 
 	memcpy(folio_address(folio), symname, len - 1);
 
-	err = aops->write_end(NULL, mapping, 0, len - 1, len - 1,
+	err = mapping_write_end(NULL, mapping, 0, len - 1, len - 1,
 						folio, fsdata);
 	if (err < 0)
 		goto fail;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c15..bfd8aaeb78bb8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -494,6 +494,24 @@ struct address_space {
 #define PAGECACHE_TAG_WRITEBACK	XA_MARK_1
 #define PAGECACHE_TAG_TOWRITE	XA_MARK_2
 
+static inline int mapping_write_begin(struct file *file,
+				struct address_space *mapping,
+				loff_t pos, unsigned len,
+				struct folio **foliop, void **fsdata)
+{
+	return mapping->a_ops->write_begin(file, mapping, pos, len, foliop,
+			fsdata);
+}
+
+static inline int mapping_write_end(struct file *file,
+				struct address_space *mapping,
+				loff_t pos, unsigned len, unsigned copied,
+				struct folio *folio, void *fsdata)
+{
+	return mapping->a_ops->write_end(file, mapping, pos, len, copied,
+			folio, fsdata);
+}
+
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index e582a1545d2ae..a4930449fc705 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4016,7 +4016,6 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
 	size_t chunk = mapping_max_folio_size(mapping);
 	long status = 0;
 	ssize_t written = 0;
@@ -4050,7 +4049,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes,
+		status = mapping_write_begin(file, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))
 			break;
@@ -4065,7 +4064,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		flush_dcache_folio(folio);
 
-		status = a_ops->write_end(file, mapping, pos, bytes, copied,
+		status = mapping_write_end(file, mapping, pos, bytes, copied,
 						folio, fsdata);
 		if (unlikely(status != copied)) {
 			iov_iter_revert(i, copied - max(status, 0L));
-- 
2.17.1


