Return-Path: <linux-kernel+bounces-169696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44B8BCC49
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A4B1C217CB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB371143736;
	Mon,  6 May 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6qHBPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25364142E75
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992352; cv=none; b=qI9OGOrsMgo4+BAMmblrXKv6b92RXuaWekGXGLqJcbua4ZZ0DxNHhjMYaoS1MRSOTUTYMr0Q/LKlwfgOK4+i6tyajJBCkoez4c1kzPyhoil9zQbvplW3yFHedD1zudNxmm1xrbT5Jhm4gh8EMR2+MY+bfEPZB4xNNUGJsGpunHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992352; c=relaxed/simple;
	bh=ujeNWZnZlwotBG7o+WYiKDn4iCBwSQc+8Bif1ZGJ0Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0S7DzEipHRtc+fTmrJH5dGMAK/7M1VGzblLAxWmSjNyLbGy7y0C6OolinXshH8/QAbziXGRBZwb2SQj4a++d8lQ4zmoM1UU77Q5yILRzHy1YHke2uLpxY9OfHYz7WhUr3u+r56b87M6VcdHBHX/eIVxQg1Rt972AJ3UW+FHR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6qHBPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BFBC4AF18;
	Mon,  6 May 2024 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992352;
	bh=ujeNWZnZlwotBG7o+WYiKDn4iCBwSQc+8Bif1ZGJ0Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YV6qHBPbcPC67A9nuHjPMpbW32y9pTdI8DVPfhUx9PovciXUiwhd3+Q0r/sqfl481
	 UhgFYT9v/y36fBzQ4SecdPVaqGffrbe4TtEUf2wNWWp8F5fptrGy8yf2RYrrKIA+8o
	 EBGSo4ZTDhCuFVoabmbmX6HqqL/IIVyBvptqSWiABC0nMrIVE2StSiqAi+5VYYrS4j
	 yGDAHp9ZAuNXyhlhOLeH7l4c7euNhPq9/Ioxj1sRSN7feJqDB0O6cK9h5lOwkwBSxU
	 K4J++WVvbcedm5EtXtCs8w40fQO2N4oC6QuyYtY6bGplMOgcRfnrBNA9ziERW0F0h5
	 XcuuD+eW99OzA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to limit gc_pin_file_threshold
Date: Mon,  6 May 2024 18:45:38 +0800
Message-Id: <20240506104538.778116-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104538.778116-1-chao@kernel.org>
References: <20240506104538.778116-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

type of f2fs_inode.i_gc_failures, f2fs_inode_info.i_gc_failures, and
f2fs_sb_info.gc_pin_file_threshold is __le16, unsigned int, and u64,
so it will cause truncation during comparison and persistence.

Unifying variable of these three variables to unsigned short, and
add an upper boundary limitation for gc_pin_file_threshold.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  2 +-
 fs/f2fs/f2fs.h                          |  4 ++--
 fs/f2fs/file.c                          | 11 ++++++-----
 fs/f2fs/gc.h                            |  1 +
 fs/f2fs/sysfs.c                         |  7 +++++++
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 1a4d83953379..cad6c3dc1f9c 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -331,7 +331,7 @@ Date:		January 2018
 Contact:	Jaegeuk Kim <jaegeuk@kernel.org>
 Description:	This indicates how many GC can be failed for the pinned
 		file. If it exceeds this, F2FS doesn't guarantee its pinning
-		state. 2048 trials is set by default.
+		state. 2048 trials is set by default, and 65535 as maximum.
 
 What:		/sys/fs/f2fs/<disk>/extension_list
 Date:		February 2018
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 400ff8e1abe0..3dff45cd6cde 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -813,7 +813,7 @@ struct f2fs_inode_info {
 	unsigned char i_dir_level;	/* use for dentry level for large dir */
 	union {
 		unsigned int i_current_depth;	/* only for directory depth */
-		unsigned int i_gc_failures;	/* for gc failure statistic */
+		unsigned short i_gc_failures;	/* for gc failure statistic */
 	};
 	unsigned int i_pino;		/* parent inode number */
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
@@ -1672,7 +1672,7 @@ struct f2fs_sb_info {
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
 
 	/* threshold for gc trials on pinned files */
-	u64 gc_pin_file_threshold;
+	unsigned short gc_pin_file_threshold;
 	struct f2fs_rwsem pin_sem;
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 200cafc75dce..1b1b08923f7d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3194,16 +3194,17 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	/* Use i_gc_failures for normal file as a risk signal. */
-	if (inc)
-		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
-
-	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
+	if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
 		f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
 			  __func__, inode->i_ino, fi->i_gc_failures);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
 	}
+
+	/* Use i_gc_failures for normal file as a risk signal. */
+	if (inc)
+		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
+
 	return 0;
 }
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 9c0d06c4d19a..a8ea3301b815 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -26,6 +26,7 @@
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
+#define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7aa3844e7a80..09d3ecfaa4f1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -681,6 +681,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_pin_file_threshold")) {
+		if (t > MAX_GC_FAILED_PINNED_FILES)
+			return -EINVAL;
+		sbi->gc_pin_file_threshold = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
 		if (t != 0)
 			return -EINVAL;
-- 
2.40.1


