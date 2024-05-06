Return-Path: <linux-kernel+bounces-169695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1288BCC46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FEF283EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01E142E69;
	Mon,  6 May 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1nk7Np7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A324436A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992350; cv=none; b=H7FFvbcFeFW6r2oTYp1wKVdnbw1Ha5Rm/Kaav/YMOAhoSXBmrKLua5WcSnyD4JGjyQNRbITQelUGLSXFMj/kbcA3+TVX1MKBnyH/2CnIdJV5BlrtQh1EK6q0A197zlYQGFv6ZQDoo/LEKMW3WZ0sMEM78P8C37Uawi77QuHvexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992350; c=relaxed/simple;
	bh=5FXL1w0kKd3v0/c9H8JOMPfU9RVcvwO4fWYHuVk8glE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YM1ToH1lea4ZMNbonxmDIKgly6ay1164kx3e5KW1t+WKxE/j/5tUEE2Bs6AEdlZiGEPLoQ/lZT4+AQPR21Mwkafh+FdUXUvzkOS9cX4zFrLqD1Sd3X819EpJZljd0C9ZkTXF0F1Ox/DAS0IAHHkegDCk3zJRBV+Is+5MU8VN8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1nk7Np7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1DBC116B1;
	Mon,  6 May 2024 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992350;
	bh=5FXL1w0kKd3v0/c9H8JOMPfU9RVcvwO4fWYHuVk8glE=;
	h=From:To:Cc:Subject:Date:From;
	b=r1nk7Np7JNO5Kym3vyWEHhbHQsp/9VFNe2U/ZPA9DqjwZQ+N7LTlpMI3GX8xb+7Ps
	 PeywSepD8oFBV9bap2jeKm4XyMIoZNi/9P/8FJuFSz4DTRhk87KAbQu2/GbU/yS7Do
	 cMdXXDV4xMe0RDIpoLfvnxtDN2LPrCpYhQeP9vlynn+bqWmCnZdyy9+grHnM2uP980
	 Y+PCFEoWFVwe20f4sQ46R7GhWCDQLFJgv991UBogfjsMBnC8f98VGOEjVrQRFAq2ta
	 TBfIjFmDpUKyUu7pYTQ2SLnCnkFEbrzG0Lbye/Psp5XeSnkjGWwDPABMHz5agSjx5D
	 /PJM9SuewHLHQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: remove unused GC_FAILURE_PIN
Date: Mon,  6 May 2024 18:45:37 +0800
Message-Id: <20240506104538.778116-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 3db1de0e582c ("f2fs: change the current atomic write way"),
we removed all GC_FAILURE_ATOMIC usage, let's change i_gc_failures[]
array to i_pin_failure for cleanup.

Meanwhile, let's define i_current_depth and i_gc_failures as union
variable due to they won't be valid at the same time.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h     | 14 +++++---------
 fs/f2fs/file.c     | 12 +++++-------
 fs/f2fs/inode.c    |  6 ++----
 fs/f2fs/recovery.c |  3 +--
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b03d75e4eedc..400ff8e1abe0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -765,11 +765,6 @@ enum {
 
 #define DEF_DIR_LEVEL		0
 
-enum {
-	GC_FAILURE_PIN,
-	MAX_GC_FAILURE
-};
-
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
@@ -816,9 +811,10 @@ struct f2fs_inode_info {
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
 	unsigned char i_advise;		/* use to give file attribute hints */
 	unsigned char i_dir_level;	/* use for dentry level for large dir */
-	unsigned int i_current_depth;	/* only for directory depth */
-	/* for gc failure statistic */
-	unsigned int i_gc_failures[MAX_GC_FAILURE];
+	union {
+		unsigned int i_current_depth;	/* only for directory depth */
+		unsigned int i_gc_failures;	/* for gc failure statistic */
+	};
 	unsigned int i_pino;		/* parent inode number */
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
 
@@ -3133,7 +3129,7 @@ static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 static inline void f2fs_i_gc_failures_write(struct inode *inode,
 					unsigned int count)
 {
-	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] = count;
+	F2FS_I(inode)->i_gc_failures = count;
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac9d6380e433..200cafc75dce 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3196,13 +3196,11 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 
 	/* Use i_gc_failures for normal file as a risk signal. */
 	if (inc)
-		f2fs_i_gc_failures_write(inode,
-				fi->i_gc_failures[GC_FAILURE_PIN] + 1);
+		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
 
-	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
+	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
 		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
-			  __func__, inode->i_ino,
-			  fi->i_gc_failures[GC_FAILURE_PIN]);
+			  __func__, inode->i_ino, fi->i_gc_failures);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
 	}
@@ -3266,7 +3264,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	}
 
 	set_inode_flag(inode, FI_PIN_FILE);
-	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
+	ret = F2FS_I(inode)->i_gc_failures;
 done:
 	f2fs_update_time(sbi, REQ_TIME);
 out:
@@ -3281,7 +3279,7 @@ static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin = 0;
 
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		pin = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
+		pin = F2FS_I(inode)->i_gc_failures;
 	return put_user(pin, (u32 __user *)arg);
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1423cd27a477..9a8c2b63f56d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -408,8 +408,7 @@ static int do_read_inode(struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		fi->i_gc_failures[GC_FAILURE_PIN] =
-					le16_to_cpu(ri->i_gc_failures);
+		fi->i_gc_failures = le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
 	if (S_ISREG(inode->i_mode))
@@ -679,8 +678,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		ri->i_current_depth =
 			cpu_to_le32(F2FS_I(inode)->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		ri->i_gc_failures =
-			cpu_to_le16(F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN]);
+		ri->i_gc_failures = cpu_to_le16(F2FS_I(inode)->i_gc_failures);
 	ri->i_xattr_nid = cpu_to_le32(F2FS_I(inode)->i_xattr_nid);
 	ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);
 	ri->i_pino = cpu_to_le32(F2FS_I(inode)->i_pino);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e7bf15b8240a..496aee53c38a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -330,8 +330,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 	f2fs_set_inode_flags(inode);
-	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
-				le16_to_cpu(raw->i_gc_failures);
+	F2FS_I(inode)->i_gc_failures = le16_to_cpu(raw->i_gc_failures);
 
 	recover_inline_flags(inode, raw);
 
-- 
2.40.1


