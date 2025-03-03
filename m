Return-Path: <linux-kernel+bounces-540961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9256A4B6F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D301891289
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239B1E1C09;
	Mon,  3 Mar 2025 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIcMW/5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB170805
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973581; cv=none; b=ELh2gIfT3fK/Xl5txz68mNYKIzW0Jc1zllGxDhI1yIpbX4Io3DVqjHq9nrcVj/aW0nJR8/X7BLKprEae6k96upLku8TDZqqPq4dFeY6dcEZy48cgu6PjJYTg4ykzG6nIfHNm7Y4Ktb5n7bIhk3YlofHHUkOyqhA2jKAeoQ9/gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973581; c=relaxed/simple;
	bh=LIa3c5jErC+Fa9BEa/bZPI0QfpHqsWVhgevulq+HzFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5MH+IP/eUrPyVXWggUi/C1FKLtNKKExO5QJj06UOh/GBJrGJ19acTNpEorGL/fEvEmSr2ukrAp0MJRDSs+OGS2/x1c2RrfWY+c8DLANCtcVjgkc6yqXa3buxwSm09/L3FyalE2MKd5v+0MOjoU29re/vGAW8N/PntEzvpQEHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIcMW/5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3A4C4CEE6;
	Mon,  3 Mar 2025 03:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740973580;
	bh=LIa3c5jErC+Fa9BEa/bZPI0QfpHqsWVhgevulq+HzFo=;
	h=From:To:Cc:Subject:Date:From;
	b=LIcMW/5FVny7KJOkpdM4Ug/xO6v/wn0jO2LGfrNR8V6wusL6G5mzdoEdA/wW1gWNU
	 3hs3Hq4XRzFKTuviescIVJEayvB9UV87shgMQnsXSIieTDBsC6kOihN6W3G0U/5O1V
	 DBFJorNfwTHk3liD/qGDTILgjJyQsQY/q6EVA/+8jdftsbL84pK6X49O4h9pv7GtjB
	 7y4ZxHbBQFcgDcp68aWM2ONuUvHwYUto9ctTUPD2Pibi6PgAti3RDBIpbJ6GUSahT+
	 20iNMnYzx9aT6Q/aZMCwm2fq3DKddvaFRt8KB3hbYThiZMJb2m7zK4jfiM9zIpx/sh
	 NgotyexoQODng==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support F2FS_NOLINEAR_LOOKUP_FL
Date: Mon,  3 Mar 2025 11:46:06 +0800
Message-ID: <20250303034606.1355224-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new flag F2FS_NOLINEAR_LOOKUP_FL, so that we can
tag casefolded directory w/ it to disable linear lookup functionality,
it can be used for QA.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c             |  3 ++-
 fs/f2fs/f2fs.h            |  2 ++
 fs/f2fs/file.c            | 36 +++++++++++++++++++++++-------------
 include/uapi/linux/f2fs.h |  5 +++++
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 54dd52de7269..4c74f29a2c73 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -366,7 +366,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 out:
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (IS_CASEFOLDED(dir) && !de && use_hash) {
+	if (IS_CASEFOLDED(dir) && !de && use_hash &&
+				!IS_NOLINEAR_LOOKUP(dir)) {
 		use_hash = false;
 		goto start_find_entry;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 05879c6dc4d6..787f1e5a52d7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3047,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_NOLINEAR_LOOKUP_FL		0x08000000 /* do not use linear lookup */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
@@ -3066,6 +3067,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
 
 #define IS_DEVICE_ALIASING(inode)	(F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
+#define IS_NOLINEAR_LOOKUP(inode)	(F2FS_I(inode)->i_flags & F2FS_NOLINEAR_LOOKUP_FL)
 
 static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 014cb7660a9a..1acddc4d11e4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2062,6 +2062,11 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		}
 	}
 
+	if ((iflags ^ masked_flags) & F2FS_NOLINEAR_LOOKUP_FLAG) {
+		if (!S_ISDIR(inode->i_mode) || !IS_CASEFOLDED(inode))
+			return -EINVAL;
+	}
+
 	fi->i_flags = iflags | (fi->i_flags & ~mask);
 	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
 					(fi->i_flags & F2FS_NOCOMP_FL));
@@ -2093,17 +2098,18 @@ static const struct {
 	u32 iflag;
 	u32 fsflag;
 } f2fs_fsflags_map[] = {
-	{ F2FS_COMPR_FL,	FS_COMPR_FL },
-	{ F2FS_SYNC_FL,		FS_SYNC_FL },
-	{ F2FS_IMMUTABLE_FL,	FS_IMMUTABLE_FL },
-	{ F2FS_APPEND_FL,	FS_APPEND_FL },
-	{ F2FS_NODUMP_FL,	FS_NODUMP_FL },
-	{ F2FS_NOATIME_FL,	FS_NOATIME_FL },
-	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
-	{ F2FS_INDEX_FL,	FS_INDEX_FL },
-	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
-	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
-	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
+	{ F2FS_COMPR_FL,		FS_COMPR_FL },
+	{ F2FS_SYNC_FL,			FS_SYNC_FL },
+	{ F2FS_IMMUTABLE_FL,		FS_IMMUTABLE_FL },
+	{ F2FS_APPEND_FL,		FS_APPEND_FL },
+	{ F2FS_NODUMP_FL,		FS_NODUMP_FL },
+	{ F2FS_NOATIME_FL,		FS_NOATIME_FL },
+	{ F2FS_NOCOMP_FL,		FS_NOCOMP_FL },
+	{ F2FS_INDEX_FL,		FS_INDEX_FL },
+	{ F2FS_DIRSYNC_FL,		FS_DIRSYNC_FL },
+	{ F2FS_PROJINHERIT_FL,		FS_PROJINHERIT_FL },
+	{ F2FS_CASEFOLD_FL,		FS_CASEFOLD_FL },
+	{ F2FS_NOLINEAR_LOOKUP_FL,	F2FS_NOLINEAR_LOOKUP_FL },
 };
 
 #define F2FS_GETTABLE_FS_FL (		\
@@ -2121,7 +2127,8 @@ static const struct {
 		FS_INLINE_DATA_FL |	\
 		FS_NOCOW_FL |		\
 		FS_VERITY_FL |		\
-		FS_CASEFOLD_FL)
+		FS_CASEFOLD_FL |	\
+		F2FS_NOLINEAR_LOOKUP_FL)
 
 #define F2FS_SETTABLE_FS_FL (		\
 		FS_COMPR_FL |		\
@@ -2133,7 +2140,8 @@ static const struct {
 		FS_NOCOMP_FL |		\
 		FS_DIRSYNC_FL |		\
 		FS_PROJINHERIT_FL |	\
-		FS_CASEFOLD_FL)
+		FS_CASEFOLD_FL |	\
+		F2FS_NOLINEAR_LOOKUP_FL)
 
 /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
 static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
@@ -3344,6 +3352,8 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 		fsflags |= FS_INLINE_DATA_FL;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
 		fsflags |= FS_NOCOW_FL;
+	if (IS_NOLINEAR_LOOKUP(inode))
+		fsflags |= F2FS_NOLINEAR_LOOKUP_FL;
 
 	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
 
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 795e26258355..a03626fdcf35 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -104,4 +104,9 @@ struct f2fs_comp_option {
 	__u8 log_cluster_size;
 };
 
+/* used for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS */
+enum {
+	F2FS_NOLINEAR_LOOKUP_FLAG = 0x08000000,
+};
+
 #endif /* _UAPI_LINUX_F2FS_H */
-- 
2.48.1


