Return-Path: <linux-kernel+bounces-569075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E368AA69E38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781103BE6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2C1EB182;
	Thu, 20 Mar 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keVJ3O1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1E1E9B2A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437367; cv=none; b=uwOO4EMBrKy8vn5Fqltu1DLOSwpWkEFlwAH1YN+UWIWOIuX7BrPJeiZy6yftVzJV8VqP9/6Szwwxl8ovTPAeHlEA5T2iXWemqiAPShPzdACrXE8iDO8fmajCqloFYgyZhhpXAYBB7kBijAu6xeZWune33tkU1lv4ZirihUKuK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437367; c=relaxed/simple;
	bh=7+Yts5LeHOxEOmhtkUAzJyFa7c2XWV7zaUXjWc0iIys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKdEEf648VnX5SZ/tCuWcjc74A5C2HtE6vxGm/VQQesbrEmZAKLioIvpC0DE10X0GDtidt5pkbIdtF27KAaOZnZax70TgLUhyqnVuUlFVD1MHHyru19SAQtRuuv61QL06h+lJG+JnaUmvd6Rl2tcj+ImUIOUKDAjVM7Jy6/779k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keVJ3O1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00BDC4CEE8;
	Thu, 20 Mar 2025 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742437366;
	bh=7+Yts5LeHOxEOmhtkUAzJyFa7c2XWV7zaUXjWc0iIys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keVJ3O1xNqwhqCBcZqW6EL+MgA/8ihCfTSSHVEXzvWr4LqmEC2FukSJtwyAshe4Sp
	 CSAQRRPpSn3kQXiw68iAjeGkaArinWIXG/r8dJs4cYoJ2AYiJkzjWknynLmcz3RiEL
	 4Mv2LAjtbM6jS6mkaND29O6a0gB+O09od9YVd8yvrl7AfaiYh1CJnfIOT0Ct0vYYFa
	 rnaDimRlj4aZNPNDPkg9KYomRiz60G/3K5gqTZFGPSYlWwdj3eQft84NQ1ST6lOZ5z
	 Y66tJArcOhBH7ATz0hq4UDq1BO8MaBcqrW8LdgeHU9r83uKWzHJW26PGf4yIBPku/Z
	 HrbSy4+6dfiXg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: fix to update injection attrs according to fault_option
Date: Thu, 20 Mar 2025 10:22:30 +0800
Message-ID: <20250320022230.1938110-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250320022230.1938110-1-chao@kernel.org>
References: <20250320022230.1938110-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we update inject type via sysfs, it shows wrong rate value as
below, there is a same problem when we update inject rate, fix it.

Before:
F2FS-fs (vdd): build fault injection attr: rate: 0, type: 0xffff
F2FS-fs (vdd): build fault injection attr: rate: 1, type: 0x0

After:
F2FS-fs (vdd): build fault injection type: 0x1
F2FS-fs (vdd): build fault injection rate: 1

Meanwhile, let's avoid turning on all fault types when we enable fault
injection via fault_injection mount option, it will lead to shutdown
filesystem or fail the mount() easily.

mount -o fault_injection=4 /dev/vdd /mnt/f2fs
F2FS-fs (vdd): build fault injection attr: rate: 4, type: 0x7fffff
F2FS-fs (vdd): inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0xbdf/0x27c0

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2
- no changes
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       | 14 ++++++++++----
 fs/f2fs/super.c      | 26 +++++++++++++-------------
 fs/f2fs/sysfs.c      |  4 ++--
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index cf77987d0698..85b7141f0d89 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -29,7 +29,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
 						unsigned char reason)
 {
-	f2fs_build_fault_attr(sbi, 0, 0);
+	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
 	f2fs_handle_critical_error(sbi, reason);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 986ee5b9326d..ca884e39a5ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -66,9 +66,14 @@ enum {
 	FAULT_MAX,
 };
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-#define F2FS_ALL_FAULT_TYPE		(GENMASK(FAULT_MAX - 1, 0))
+/* indicate which option to update */
+enum fault_option {
+	FAULT_RATE	= 1,	/* only update fault rate */
+	FAULT_TYPE	= 2,	/* only update fault type */
+	FAULT_ALL	= 4,	/* reset all fault injection options/stats */
+};
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
 struct f2fs_fault_info {
 	atomic_t inject_ops;
 	int inject_rate;
@@ -4765,10 +4770,11 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-							unsigned long type);
+					unsigned long type, enum fault_option fo);
 #else
 static inline int f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
-					unsigned long rate, unsigned long type)
+					unsigned long rate, unsigned long type,
+					enum fault_option fo)
 {
 	return 0;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dfe0604ab558..011925ee54f8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -68,29 +68,30 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 };
 
 int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-							unsigned long type)
+				unsigned long type, enum fault_option fo)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
-	if (rate) {
+	if (fo & FAULT_ALL) {
+		memset(ffi, 0, sizeof(struct f2fs_fault_info));
+		return 0;
+	}
+
+	if (fo & FAULT_RATE) {
 		if (rate > INT_MAX)
 			return -EINVAL;
 		atomic_set(&ffi->inject_ops, 0);
 		ffi->inject_rate = (int)rate;
+		f2fs_info(sbi, "build fault injection rate: %lu", rate);
 	}
 
-	if (type) {
+	if (fo & FAULT_TYPE) {
 		if (type >= BIT(FAULT_MAX))
 			return -EINVAL;
 		ffi->inject_type = (unsigned int)type;
+		f2fs_info(sbi, "build fault injection type: 0x%lx", type);
 	}
 
-	if (!rate && !type)
-		memset(ffi, 0, sizeof(struct f2fs_fault_info));
-	else
-		f2fs_info(sbi,
-			"build fault injection attr: rate: %lu, type: 0x%lx",
-								rate, type);
 	return 0;
 }
 #endif
@@ -897,8 +898,7 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (f2fs_build_fault_attr(sbi, arg,
-					F2FS_ALL_FAULT_TYPE))
+			if (f2fs_build_fault_attr(sbi, arg, 0, FAULT_RATE))
 				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
@@ -906,7 +906,7 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 		case Opt_fault_type:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (f2fs_build_fault_attr(sbi, 0, arg))
+			if (f2fs_build_fault_attr(sbi, 0, arg, FAULT_TYPE))
 				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
@@ -2209,7 +2209,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-	f2fs_build_fault_attr(sbi, 0, 0);
+	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
 }
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 46fa94db08a8..3a3485622691 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -494,12 +494,12 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return ret;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (a->struct_type == FAULT_INFO_TYPE) {
-		if (f2fs_build_fault_attr(sbi, 0, t))
+		if (f2fs_build_fault_attr(sbi, 0, t, FAULT_TYPE))
 			return -EINVAL;
 		return count;
 	}
 	if (a->struct_type == FAULT_INFO_RATE) {
-		if (f2fs_build_fault_attr(sbi, t, 0))
+		if (f2fs_build_fault_attr(sbi, t, 0, FAULT_RATE))
 			return -EINVAL;
 		return count;
 	}
-- 
2.48.1


