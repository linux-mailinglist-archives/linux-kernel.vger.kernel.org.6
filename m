Return-Path: <linux-kernel+bounces-229906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7229175DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A4EB21B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130C15ACB;
	Wed, 26 Jun 2024 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQTzU5dI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588310958
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366456; cv=none; b=OJWPZX0tha7Qo8lP7gvmJ7gJgQoJLyyoS6aoZPQ5wzbqIuxJjhNCDkRzM2/3KiMYRucTjLdlvY2kyJGZQ2LsUqI6iApld+vhw/EpxHOfVCE8grTDTnsneP5qriYELAzgfoPOASlgQdGqCpwKggnqy5JNPZG2QRmWaglcB7bZByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366456; c=relaxed/simple;
	bh=NAo/AAxU14nQnbWfFi+qAKpFZk330jznbkDFRoyc4oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GczY40/MbukGz5Di5k0ZDuEQViXXXyBfEF9/AfyqpNHKk08G4mbiOyX/Y69D9uyMxweiG5tnyAI8e5MXiMQbWMYw1+5huC0DiD4c7NY9al1c/w7XxVyKrNc34d5MPYNOaIXn6nsBxAOMCK344Km+AcksQARWPqpk+uj7hMAPolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQTzU5dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FDBC32781;
	Wed, 26 Jun 2024 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719366455;
	bh=NAo/AAxU14nQnbWfFi+qAKpFZk330jznbkDFRoyc4oI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQTzU5dIwKaIpYzjFUJBjTXtrDz9jVi/LZL2y4gFM/HNkxuNmJn9UdUvgwn8VE5sz
	 8IQX0+TLoysruPnUK9M92K5c8oqm1CNnSTiIxBfEB3+su9ZE18gYcoxLWTUrw7YDQM
	 NRYw2Gpc1UxRaNUItSPjz+kZEQEqX4xfX4SAm7KuVH5srj2rfGw+Kb69xvJvV3vPR3
	 WxI52BJiyEwgR/FA3YrgA6WkhTX/x8725S8dRq+NybHb6N+aeqG5Dek9ROaf0QblTN
	 LC0XxvGz6n1EulDpzSaoqHkgySZCGqrSvyLLVl8R19rfZ0qtUYWudnosRgzIlJtOqa
	 gxHQbSl2PAowA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Yunlei He <heyunlei@hihonor.com>
Subject: [PATCH v5] f2fs: reduce expensive checkpoint trigger frequency
Date: Wed, 26 Jun 2024 09:47:27 +0800
Message-Id: <20240626014727.4095350-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We may trigger high frequent checkpoint for below case:
1. mkdir /mnt/dir1; set dir1 encrypted
2. touch /mnt/file1; fsync /mnt/file1
3. mkdir /mnt/dir2; set dir2 encrypted
4. touch /mnt/file2; fsync /mnt/file2
...

Although, newly created dir and file are not related, due to
commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
trigger checkpoint whenever fsync() comes after a new encrypted dir
created.

In order to avoid such performance regression issue, let's record an
entry including directory's ino in global cache whenever we update
directory's xattr data, and then triggerring checkpoint() only if
xattr metadata of target file's parent was updated.

This patch updates to cover below no encryption case as well:
1) parent is checkpointed
2) set_xattr(dir) w/ new xnid
3) create(file)
4) fsync(file)

Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
Reported-by: wangzijie <wangzijie1@honor.com>
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reported-by: Yunlei He <heyunlei@hihonor.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v5:
- update related enumeration type declaration.
 fs/f2fs/f2fs.h              |  2 ++
 fs/f2fs/file.c              |  3 +++
 fs/f2fs/xattr.c             | 14 ++++++++++++--
 include/trace/events/f2fs.h |  3 ++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1d65ee3addf..82f65f9036fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -284,6 +284,7 @@ enum {
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
+	XATTR_DIR_INO,		/* for xattr updated dir ino list */
 	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
@@ -1150,6 +1151,7 @@ enum cp_reason_type {
 	CP_FASTBOOT_MODE,
 	CP_SPEC_LOG_NUM,
 	CP_RECOVER_DIR,
+	CP_XATTR_DIR,
 };
 
 enum iostat_type {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c5f526f0d882..006c748b110c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
 							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
+	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							XATTR_DIR_INO))
+		cp_reason = CP_XATTR_DIR;
 
 	return cp_reason;
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f290fe9327c4..3f3874943679 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
 	int found, newsize;
@@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	if (S_ISDIR(inode->i_mode))
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
+	if (!S_ISDIR(inode->i_mode))
+		goto same;
+	/*
+	 * In restrict mode, fsync() always try to trigger checkpoint for all
+	 * metadata consistency, in other mode, it triggers checkpoint when
+	 * parent's xattr metadata was updated.
+	 */
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		set_sbi_flag(sbi, SBI_NEED_CP);
+	else
+		f2fs_add_ino_entry(sbi, inode->i_ino, XATTR_DIR_INO);
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ed794b5fefbe..2851c823095b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 		{ CP_NODE_NEED_CP,	"node needs cp" },		\
 		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
-		{ CP_RECOVER_DIR,	"dir needs recovery" })
+		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
+		{ CP_XATTR_DIR,		"dir's xattr updated" })
 
 #define show_shutdown_mode(type)					\
 	__print_symbolic(type,						\
-- 
2.40.1


