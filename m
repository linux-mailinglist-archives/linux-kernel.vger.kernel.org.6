Return-Path: <linux-kernel+bounces-533726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB3A45E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C141768EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD404221D8F;
	Wed, 26 Feb 2025 12:01:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443621D3F5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571313; cv=none; b=VAUXkMdQnqMZ7X7yBGodPS8CKpyzLX+zDkU8NzHC0ru4YK3sv8j/k4aXK37tNQpynIUo3dYDq2eMHw2NGRupeuAxaI/nFqfh/GqrqRry06I1H6rS4HXGlOQf0sJdGjiyOZdtc80NsyIhS0+mHF52TiuuerKSIEDBseCm8QB1sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571313; c=relaxed/simple;
	bh=IebXMzVjzhtgKw9wJcCtsEokmAkJ+0QpAvKulqGNLBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qp8JMOPt7eV+F25B2YPo7qwrB6FrhryQFw72B9DzqnVTEL5eU9FyQv89uyDAxKUc67H676ZKPY4cCxt24yqvG9tmGgVV6CAhINGTBw9f0HES8rzcl2rfmpFW0zU208aEDJmbJshe0vJMoWCDJd8r9auvNBxD1Fwx/1AixlnU/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-0d-67bf02a79efb
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
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
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 15/25] fs, filemap: refactor to gather the scattered ->write_{begin,end}() calls
Date: Wed, 26 Feb 2025 21:01:22 +0900
Message-Id: <20250226120132.28469-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBpN/8lrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8b9Fa3sBd+yK9Y9XM/cwHgutIuR
	k0NCwERixbYrbF2MHGD2kl+BIGE2AXWJGzd+MoPYIgJmEgdb/7B3MXJxMAssY5LYe6KBDcQR
	FpjAKDFvVQs7SBWLgKrEsc1rwGxeoI5F1/uZIRbIS6zecADM5gSK/9v9G6xGSCBZomX9bxaQ
	QRIC99kkdszrYoRokJQ4uOIGywRG3gWMDKsYhTLzynITM3NM9DIq8zIr9JLzczcxAsN6We2f
	6B2Mny4EH2IU4GBU4uF9cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGKOPTc+YkDU7+9WRvPMnXbfzrM5KL3tw
	4+8WoY//r5n4lNhpHX8f+1H73k+ukhtJX21WlP/stznGvDDzXF1zZxPvhlv9Wo2yxQ1Jyzs9
	DFL7Lu8VkFt6xspSQuY0Y4XL6tU+t3SmRMxuvmJcrXPEN3qxksBu/sMP3nsVyPx/MzmBtc//
	71wdUyWW4oxEQy3mouJEAGgv1UtnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wc2DLBZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBl3F/Ryl7wLbti
	3cP1zA2M50K7GDk4JARMJJb8Cuxi5ORgE1CXuHHjJzOILSJgJnGw9Q97FyMXB7PAMiaJvSca
	2EAcYYEJjBLzVrWwg1SxCKhKHNu8BszmBepYdL0frFtCQF5i9YYDYDYnUPzf7t9gNUICyRIt
	63+zTGDkWsDIsIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwSJfV/pm4g/HLZfdDjAIcjEo8
	vA/O7E0XYk0sK67MPcQowcGsJMLLmbknXYg3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBA
	emJJanZqakFqEUyWiYNTqoFxYdWJv10t/g9y7OTsmX2VvDr1i5WZDluEcK8PPsOtZGoo+HN/
	e8gN4d2/ZusGvzHdtC+zedW8m8df3RA8aiG970lQi2rBGbndr8x3rlV33vWzxiE52nvNRJvg
	KbP5nnZwO1XM+2fp6v4zv9Ro65WjiX7BWtr3gx+1nUz6+cwuknnNtKqitBglluKMREMt5qLi
	RACLtfHSTgIAAA==
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
index ae3343c81a645..22ce009d13689 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -418,7 +418,6 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 	     const struct drm_i915_gem_pwrite *arg)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	char __user *user_data = u64_to_user_ptr(arg->data_ptr);
 	u64 remain;
 	loff_t pos;
@@ -477,7 +476,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err)
 			return err;
 
-		err = aops->write_begin(obj->base.filp, mapping, pos, len,
+		err = mapping_write_begin(obj->base.filp, mapping, pos, len,
 					&folio, &data);
 		if (err < 0)
 			return err;
@@ -488,7 +487,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		pagefault_enable();
 		kunmap_local(vaddr);
 
-		err = aops->write_end(obj->base.filp, mapping, pos, len,
+		err = mapping_write_end(obj->base.filp, mapping, pos, len,
 				      len - unwritten, folio, data);
 		if (err < 0)
 			return err;
@@ -654,7 +653,6 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 {
 	struct drm_i915_gem_object *obj;
 	struct file *file;
-	const struct address_space_operations *aops;
 	loff_t pos;
 	int err;
 
@@ -666,21 +664,20 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
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
index c66a59bb068b9..6655912f12c46 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2457,7 +2457,6 @@ EXPORT_SYMBOL(block_read_full_folio);
 int generic_cont_expand_simple(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	struct folio *folio;
 	void *fsdata = NULL;
 	int err;
@@ -2466,11 +2465,11 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
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
@@ -2482,7 +2481,6 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 			    loff_t pos, loff_t *bytes)
 {
 	struct inode *inode = mapping->host;
-	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct folio *folio;
 	void *fsdata = NULL;
@@ -2502,12 +2500,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
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
@@ -2535,12 +2533,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
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
index 05b51e7217838..9a1002761f79f 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -539,7 +539,6 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
 	struct inode *inode = file_inode(file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *ops = mapping->a_ops;
 
 	pos = ei->valid_size;
 	while (pos < new_valid_size) {
@@ -551,14 +550,14 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
 		if (pos + len > new_valid_size)
 			len = new_valid_size - pos;
 
-		err = ops->write_begin(file, mapping, pos, len, &folio, NULL);
+		err = mapping_write_begin(file, mapping, pos, len, &folio, NULL);
 		if (err)
 			goto out;
 
 		off = offset_in_folio(folio, pos);
 		folio_zero_new_buffers(folio, off, off + len);
 
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
index 19b67828ae325..87c26f0571dab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2710,7 +2710,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
 	int offset = off & (sb->s_blocksize - 1);
 	size_t towrite = len;
 	struct folio *folio;
@@ -2722,7 +2721,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-		err = a_ops->write_begin(NULL, mapping, off, tocopy,
+		err = mapping_write_begin(NULL, mapping, off, tocopy,
 							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
@@ -2735,7 +2734,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
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
index 3ab9440c5b931..e1c6d28c560da 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5409,7 +5409,6 @@ EXPORT_SYMBOL(page_readlink);
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct folio *folio;
 	void *fsdata = NULL;
@@ -5419,7 +5418,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 retry:
 	if (nofs)
 		flags = memalloc_nofs_save();
-	err = aops->write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
+	err = mapping_write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
 	if (nofs)
 		memalloc_nofs_restore(flags);
 	if (err)
@@ -5427,7 +5426,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 
 	memcpy(folio_address(folio), symname, len - 1);
 
-	err = aops->write_end(NULL, mapping, 0, len - 1, len - 1,
+	err = mapping_write_end(NULL, mapping, 0, len - 1, len - 1,
 						folio, fsdata);
 	if (err < 0)
 		goto fail;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f7..820ff4752249e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -531,6 +531,24 @@ struct address_space {
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
index c6650de837d06..1c6fda5a43020 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4141,7 +4141,6 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
-	const struct address_space_operations *a_ops = mapping->a_ops;
 	size_t chunk = mapping_max_folio_size(mapping);
 	long status = 0;
 	ssize_t written = 0;
@@ -4175,7 +4174,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes,
+		status = mapping_write_begin(file, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))
 			break;
@@ -4190,7 +4189,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		flush_dcache_folio(folio);
 
-		status = a_ops->write_end(file, mapping, pos, bytes, copied,
+		status = mapping_write_end(file, mapping, pos, bytes, copied,
 						folio, fsdata);
 		if (unlikely(status != copied)) {
 			iov_iter_revert(i, copied - max(status, 0L));
-- 
2.17.1


