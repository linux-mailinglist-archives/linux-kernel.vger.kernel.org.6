Return-Path: <linux-kernel+bounces-366403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB799F4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2BB1F21D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550C1F8EF2;
	Tue, 15 Oct 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+byhxs"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798E28691
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015785; cv=none; b=TcQUdNarpt6HU4wStHYTGyJSqxizdh8hNaU/blDgip7rJ78O/UYzhSv6OXuVLzPngvd3q0BaG+lIYmYo8/OzJSIMFSb+V2ZZY4tcVRef/i/nAaGNsFRekWL9J+P+ru1oVzzyO+ua/jjCxUY2KddMhTW4kXPzvDpEspcf2cIZWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015785; c=relaxed/simple;
	bh=ENUVOthTyASGcf8mdbAmVoT3dOTPJqQIyt9lfrdDDpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3ltlj6uUO2DouFmLykk3243v+ylN9lIt+Pl9rh8oK+oHrHmlvlBFAT3GiK60N37RrogV2h+i04TfgwkGoF1T76NdmAzJ0ZUYQ4GElqFiGTTa0UZ6Y6rIM4FKfXJtSyEJBe3CrSHm9olKWLPKuw+kzTZGpXZKlJu3vs4qG97lN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw+byhxs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c714cd9c8so45863085ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729015782; x=1729620582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhRRsLR/T1fXOW5zZC3UCwsnfkeGEX7bunbKOXTaB2s=;
        b=Zw+byhxsiZHi+iOnODfURfAenXhT283uf8DG0p5tSwyLDciF9N1mw/NIUZTrDVdBI9
         j+WQYBrD7WCnB0Th9zlmckJj7tZTNfS0mPNIul7KWOAJOt/0hGXlYOZZRCoRF5knAzwf
         db2VXaaY++0k4AMfKE0OWqhYPu2TXAhrr4YHEDqtsSOh0vz4pHvFoZuNxdU/91aTLTCR
         9hz0oLuzag1YhmQDrOxfy7fTaG3NA8dkj39QoBVocLybTjoZvNwYnr/Kli/7H2ov2CuV
         cgzhh7v87+yhQ3a1KIeg8aHEso08mf7YHfTR3HUS3X1pddE6V5th3b3Uun34M03ifTkD
         CzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015782; x=1729620582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhRRsLR/T1fXOW5zZC3UCwsnfkeGEX7bunbKOXTaB2s=;
        b=SjxVcD9t+FVAT4N5TXaG6AWrt4DUe170CHC6JAHyQwVRTG6WdnyVHoAIpwVTrZ7SAZ
         mp0T5DkEKlXdEaoYjY82NAUhRVqVnVxpcr2HuWAakiM/aM9f0npSMgL7WOuWhJopKCJ4
         QJqPFyed1YMeMyMls856bfesspeJd7O7tQ2qzr6bWF60ShGqt+6Wvynk6R0m/lm5X4fo
         JvVYNXwAUnGXTL5VN6m8FBsE1qlv1d26U6zZUIaOfH8a4XvjL/vTLQrRRwWCxhxk5RJR
         dpEXiuA9yV8dMqcIhvDXwkS62wafKxaz8fzyfg5vhlXNmeyySZfWeXrAzyGvMrier1wg
         Q2vA==
X-Gm-Message-State: AOJu0YxuxIFZaPU3rQTcGXIRukSizPVGUNugRoF2ihi1ZdB+ItfWO+Qm
	9pXCFNbTkEkwab+e+oBqjvljd04xSHe7A/eJmHuaXcov0ecFhPKh29JjUw==
X-Google-Smtp-Source: AGHT+IEZ+AVOBChrHTOrRx0mM+NJXJyqrdMA0PK+l/5g0k1zAZekaqIZ48kpdQ/+Bmt2qg08ZHWrfQ==
X-Received: by 2002:a17:902:ecc1:b0:20c:c482:1d62 with SMTP id d9443c01a7336-20cc4821f06mr132887725ad.61.1729015782284;
        Tue, 15 Oct 2024 11:09:42 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:efdb:1582:924:51c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d180366a8sm14970675ad.165.2024.10.15.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:09:41 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v6] f2fs: introduce device aliasing file
Date: Tue, 15 Oct 2024 11:09:36 -0700
Message-ID: <20241015180936.1180394-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

F2FS should understand how the device aliasing file works and support
deleting the file after use. A device aliasing file can be created by
mkfs.f2fs tool and it can map the whole device with an extent, not
using node blocks. The file space should be pinned and normally used for
read-only usages.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v6: added the description in the kernel doc.
v5: added a ioctl to know whether a file is for device aliasing
v4: added file pinning check in sanity check
v3: merged Chao's extent cache sanity check.
    prevented device aliasing support with noextent mount option
v2: changed the position of f2fs_destroy_extent_tree() only for device
    aliasing files
---
 Documentation/filesystems/f2fs.rst | 45 ++++++++++++++++++++++++++++++
 fs/f2fs/data.c                     |  5 ++++
 fs/f2fs/extent_cache.c             | 45 +++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h                     |  5 ++++
 fs/f2fs/file.c                     | 44 ++++++++++++++++++++++++++---
 fs/f2fs/inode.c                    | 19 ++++++++++++-
 fs/f2fs/super.c                    |  4 +++
 fs/f2fs/sysfs.c                    |  2 ++
 include/uapi/linux/f2fs.h          |  1 +
 9 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 68a0885fb5e6..e61e8c630ecd 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -943,3 +943,48 @@ NVMe Zoned Namespace devices
   can start before the zone-capacity and span across zone-capacity boundary.
   Such spanning segments are also considered as usable segments. All blocks
   past the zone-capacity are considered unusable in these segments.
+
+Device aliasing feature
+-----------------------
+
+f2fs can utilize a special file called a "device aliasing file." This file allows
+the entire storage device to be mapped with a single, large extent, not using
+the usual f2fs node structures. This mapped area is pinned and primarily intended
+for holding the space.
+
+Essentially, this mechanism allows a portion of the f2fs area to be temporarily
+reserved and used by another filesystem or for different purposes. Once that
+external usage is complete, the device aliasing file can be deleted, releasing
+the reserved space back to F2FS for its own use.
+
+<use-case>
+
+# ls /dev/vd*
+/dev/vdb (32GB) /dev/vdc (32GB)
+# mkfs.ext4 /dev/vdc
+# mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
+# mount /dev/vdb /mnt/f2fs
+# ls -l /mnt/f2fs
+vdc.file
+# df -h
+/dev/vdb                            64G   33G   32G  52% /mnt/f2fs
+
+# mount -o loop /dev/vdc /mnt/ext4
+# df -h
+/dev/vdb                            64G   33G   32G  52% /mnt/f2fs
+/dev/loop7                          32G   24K   30G   1% /mnt/ext4
+# umount /mnt/ext4
+
+# f2fs_io getflags /mnt/f2fs/vdc.file
+get a flag on /mnt/f2fs/vdc.file ret=0, flags=nocow(pinned),immutable
+# f2fs_io setflags noimmutable /mnt/f2fs/vdc.file
+get a flag on noimmutable ret=0, flags=800010
+set a flag on /mnt/f2fs/vdc.file ret=0, flags=noimmutable
+# rm /mnt/f2fs/vdc.file
+# df -h
+/dev/vdb                            64G  753M   64G   2% /mnt/f2fs
+
+So, the key idea is, user can do any file operations on /dev/vdc, and
+reclaim the space after the use, while the space is counted as /data.
+That doesn't require modifying partition size and filesystem format.
+
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 94f7b084f601..90fa8ab85194 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3441,6 +3441,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
 						 &dn.data_blkaddr)) {
+		if (IS_DEVICE_ALIASING(inode)) {
+			err = -ENODATA;
+			goto out;
+		}
+
 		if (locked) {
 			err = f2fs_reserve_block(&dn, index);
 			goto out;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 62ac440d9416..019c1f7b7fa5 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
 	struct extent_info ei;
+	int devi;
 
 	get_read_extent_info(&ei, i_ext);
 
@@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 			  ei.blk, ei.fofs, ei.len);
 		return false;
 	}
-	return true;
+
+	if (!IS_DEVICE_ALIASING(inode))
+		return true;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++) {
+		if (FDEV(devi).start_blk != ei.blk ||
+				FDEV(devi).end_blk != ei.blk + ei.len - 1)
+			continue;
+
+		if (devi == 0) {
+			f2fs_warn(sbi,
+			    "%s: inode (ino=%lx) is an alias of meta device",
+			    __func__, inode->i_ino);
+			return false;
+		}
+
+		if (bdev_is_zoned(FDEV(devi).bdev)) {
+			f2fs_warn(sbi,
+			    "%s: device alias inode (ino=%lx)'s extent info "
+			    "[%u, %u, %u] maps to zoned block device",
+			    __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
+			return false;
+		}
+		return true;
+	}
+
+	f2fs_warn(sbi, "%s: device alias inode (ino=%lx)'s extent info "
+			"[%u, %u, %u] is inconsistent w/ any devices",
+			__func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
+	return false;
 }
 
 static void __set_extent_info(struct extent_info *ei,
@@ -76,6 +106,9 @@ static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
 
 static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 {
+	if (IS_DEVICE_ALIASING(inode) && type == EX_READ)
+		return true;
+
 	/*
 	 * for recovered files during mount do not create extents
 	 * if shrinker is not registered.
@@ -401,6 +434,11 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 	if (atomic_read(&et->node_cnt) || !ei.len)
 		goto skip;
 
+	if (IS_DEVICE_ALIASING(inode)) {
+		et->largest = ei;
+		goto skip;
+	}
+
 	en = __attach_extent_node(sbi, et, &ei, NULL,
 				&et->root.rb_root.rb_node, true);
 	if (en) {
@@ -463,6 +501,11 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		goto out;
 	}
 
+	if (IS_DEVICE_ALIASING(inode)) {
+		ret = false;
+		goto out;
+	}
+
 	en = __lookup_extent_node(&et->root, et->cached_en, pgofs);
 	if (!en)
 		goto out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 33f5449dc22d..b6ba22a1da47 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -213,6 +213,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_CASEFOLD			0x00001000
 #define F2FS_FEATURE_COMPRESSION		0x00002000
 #define F2FS_FEATURE_RO				0x00004000
+#define F2FS_FEATURE_DEVICE_ALIAS		0x00008000
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -3046,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
+#define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
 
 #define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
 
@@ -3061,6 +3063,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 /* Flags that are appropriate for non-directories/regular files. */
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
 
+#define IS_DEVICE_ALIASING(inode)	(F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
+
 static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
 {
 	if (S_ISDIR(mode))
@@ -4510,6 +4514,7 @@ F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
 F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
+F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9ae54c4c72fe..25d934357d3c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -725,6 +725,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
+	if (IS_DEVICE_ALIASING(inode) && from) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
 	free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
 
 	if (free_from >= max_file_blocks(inode))
@@ -739,6 +744,21 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		goto out;
 	}
 
+	if (IS_DEVICE_ALIASING(inode)) {
+		struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
+		struct extent_info ei = et->largest;
+		unsigned int i;
+
+		for (i = 0; i < ei.len; i++)
+			f2fs_invalidate_blocks(sbi, ei.blk + i);
+
+		dec_valid_block_count(sbi, inode, ei.len);
+		f2fs_update_time(sbi, REQ_TIME);
+
+		f2fs_put_page(ipage, 1);
+		goto out;
+	}
+
 	if (f2fs_has_inline_data(inode)) {
 		f2fs_truncate_inline_inode(inode, ipage, from);
 		f2fs_put_page(ipage, 1);
@@ -774,7 +794,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	/* lastly zero out the first data page */
 	if (!err)
 		err = truncate_partial_data_page(inode, from, truncate_page);
-
+out_err:
 	trace_f2fs_truncate_blocks_exit(inode, err);
 	return err;
 }
@@ -992,7 +1012,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (!f2fs_is_compress_backend_ready(inode))
+		if (!f2fs_is_compress_backend_ready(inode) ||
+				IS_DEVICE_ALIASING(inode))
 			return -EOPNOTSUPP;
 		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
 			!IS_ALIGNED(attr->ia_size,
@@ -1860,7 +1881,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 		return -EIO;
 	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
 		return -ENOSPC;
-	if (!f2fs_is_compress_backend_ready(inode))
+	if (!f2fs_is_compress_backend_ready(inode) || IS_DEVICE_ALIASING(inode))
 		return -EOPNOTSUPP;
 
 	/* f2fs only support ->fallocate for regular file */
@@ -3296,6 +3317,9 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
+	if (IS_DEVICE_ALIASING(inode))
+		return -EINVAL;
+
 	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
 		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
 			  __func__, inode->i_ino, fi->i_gc_failures);
@@ -3326,6 +3350,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (!pin && IS_DEVICE_ALIASING(inode))
+		return -EOPNOTSUPP;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -3391,6 +3418,12 @@ static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
 	return put_user(pin, (u32 __user *)arg);
 }
 
+static int f2fs_ioc_get_dev_alias_file(struct file *filp, unsigned long arg)
+{
+	return put_user(IS_DEVICE_ALIASING(file_inode(filp)) ? 1 : 0,
+			(u32 __user *)arg);
+}
+
 int f2fs_precache_extents(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -4490,6 +4523,8 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_decompress_file(filp);
 	case F2FS_IOC_COMPRESS_FILE:
 		return f2fs_ioc_compress_file(filp);
+	case F2FS_IOC_GET_DEV_ALIAS_FILE:
+		return f2fs_ioc_get_dev_alias_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4764,7 +4799,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	else
 		return 0;
 
-	map.m_may_create = true;
+	if (!IS_DEVICE_ALIASING(inode))
+		map.m_may_create = true;
 	if (dio) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(sbi,
 						inode->i_write_hint);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ed86df343a5..194dc0f53ad8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,6 +372,19 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (IS_DEVICE_ALIASING(inode)) {
+		if (!f2fs_sb_has_device_alias(sbi)) {
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
+				  __func__, inode->i_ino);
+			return false;
+		}
+		if (!f2fs_is_pinned_file(inode)) {
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but is not pinned",
+				  __func__, inode->i_ino);
+			return false;
+		}
+	}
+
 	return true;
 }
 
@@ -823,7 +836,8 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	f2fs_remove_dirty_inode(inode);
 
-	f2fs_destroy_extent_tree(inode);
+	if (!IS_DEVICE_ALIASING(inode))
+		f2fs_destroy_extent_tree(inode);
 
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
@@ -879,6 +893,9 @@ void f2fs_evict_inode(struct inode *inode)
 		goto retry;
 	}
 
+	if (IS_DEVICE_ALIASING(inode))
+		f2fs_destroy_extent_tree(inode);
+
 	if (err) {
 		f2fs_update_inode_page(inode);
 		if (dquot_initialize_needed(inode))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd48..30646418241c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -834,6 +834,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			set_opt(sbi, READ_EXTENT_CACHE);
 			break;
 		case Opt_noextent_cache:
+			if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_DEVICE_ALIAS)) {
+				f2fs_err(sbi, "device aliasing requires extent cache");
+				return -EINVAL;
+			}
 			clear_opt(sbi, READ_EXTENT_CACHE);
 			break;
 		case Opt_noinline_data:
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c56e8c873935..e51304bc65ea 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1313,6 +1313,7 @@ F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
 F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
 F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
 F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
+F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
 
 static struct attribute *f2fs_sb_feat_attrs[] = {
 	ATTR_LIST(sb_encryption),
@@ -1329,6 +1330,7 @@ static struct attribute *f2fs_sb_feat_attrs[] = {
 	ATTR_LIST(sb_casefold),
 	ATTR_LIST(sb_compression),
 	ATTR_LIST(sb_readonly),
+	ATTR_LIST(sb_device_alias),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_sb_feat);
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 955d440be104..f7aaf8d23e20 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -43,6 +43,7 @@
 #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
+#define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.47.0.rc1.288.g06298d1525-goog


