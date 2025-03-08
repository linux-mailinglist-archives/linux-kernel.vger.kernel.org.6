Return-Path: <linux-kernel+bounces-552407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F5A57997
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD209172A62
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6519DF8B;
	Sat,  8 Mar 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNiaNpnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B24BE4F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427237; cv=none; b=sChfU/uIp263GedZyIL/1FCJmR8uzkUom2i4pkWru1sL0p8oOh1nqcsATjEhljQT+Wr5zhMmInoFzu0Hs/bsBoyWysaOvdn0cqjaqAVs66jntmUB5bM2VdU2U6o+v7UYAlfxeY6GgyJ3cTYUCKouOUk+Qv4bd/uXO2I2F9/GohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427237; c=relaxed/simple;
	bh=kBJ5fzJuS4XS6xPkBmPOVlmWnL2oKehn+/7J73khbt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnX5rnhPLuF/cmDcfByAcRrlakt9FgE27mya7XSYlDuJJhg+BVJ7fGd26nOcgdulYhfl4TDTPBSbCLubI/ZeD+T9oJjwYQKIZnqA2s2M+8Fye/lBMPw1mJAZPoW9NjdodgLKI0KpTca+6m7XUOvSMELafRcNDzUczHqK8tWogCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNiaNpnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4708C4CEE0;
	Sat,  8 Mar 2025 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741427236;
	bh=kBJ5fzJuS4XS6xPkBmPOVlmWnL2oKehn+/7J73khbt8=;
	h=From:To:Cc:Subject:Date:From;
	b=cNiaNpnEMytoWcZRiVn759snA9q4Vv811bus0J+0flM/TQzHm4yG9XN2YpJoDWs9i
	 Mc5kdV+Lc8FAGCnkflRYTrQejjclh9FVHiEguI51FMGHEBCmQOa4XD/qeVgu6cA/Lw
	 s/lGDBluIWE//2aJhP6jNE35ayiZfmYad8XZSI7vvoE968VSBbkGb8tVRiuuBxvaP9
	 j2Q+pIlPQYzt3+qHbNKm6oF9GlHI/4sQVAjqzI9B0sfQBww3pRIiiLc7va5IuvvO/p
	 EVwTWQHlRQd3LrA22x+1zZimB43kErVsO8K2lYdgWtVTaTqHgCV17cDKqLmMTQZ0Uq
	 aaZQ44y6dWD5w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: control nat_bits feature via mount option
Date: Sat,  8 Mar 2025 13:18:46 +0800
Message-Id: <20250308051846.29079-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new mount option "nat_bits" to control nat_bits feature,
by default nat_bits feature is disabled.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/filesystems/f2fs.rst |  2 ++
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/node.c                     |  3 +++
 fs/f2fs/super.c                    | 15 +++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 42f28dbf2410..e15c4275862a 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -366,6 +366,8 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			 pending node write	drop		keep		N/A
 			 pending meta write	keep		keep		N/A
 			 ====================== =============== =============== ========
+nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
+			 by default it's disabled.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8d8917b92b5d..99ded6512d8b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -115,6 +115,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define	F2FS_MOUNT_GC_MERGE		0x02000000
 #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
 #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
+#define F2FS_MOUNT_NAT_BITS		0x10000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 24085fa8493b..579955c6e03c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3278,6 +3278,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	if (!nm_i->nat_bitmap)
 		return -ENOMEM;
 
+	if (!test_opt(sbi, NAT_BITS))
+		disable_nat_bits(sbi, true);
+
 	err = __get_nat_bitmaps(sbi);
 	if (err)
 		return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 079c5d4b60b6..1b8ca7d63afe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -191,6 +191,7 @@ enum {
 	Opt_memory_mode,
 	Opt_age_extent_cache,
 	Opt_errors,
+	Opt_nat_bits,
 	Opt_err,
 };
 
@@ -270,6 +271,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_memory_mode, "memory=%s"},
 	{Opt_age_extent_cache, "age_extent_cache"},
 	{Opt_errors, "errors=%s"},
+	{Opt_nat_bits, "nat_bits"},
 	{Opt_err, NULL},
 };
 
@@ -1323,6 +1325,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			}
 			kfree(name);
 			break;
+		case Opt_nat_bits:
+			set_opt(sbi, NAT_BITS);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2135,6 +2140,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC)
 		seq_printf(seq, ",errors=%s", "panic");
 
+	if (test_opt(sbi, NAT_BITS))
+		seq_puts(seq, ",nat_bits");
+
 	return 0;
 }
 
@@ -2325,6 +2333,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool no_discard = !test_opt(sbi, DISCARD);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
 	bool block_unit_discard = f2fs_block_unit_discard(sbi);
+	bool no_nat_bits = !test_opt(sbi, NAT_BITS);
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -2453,6 +2462,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+	if (no_nat_bits == !!test_opt(sbi, NAT_BITS)) {
+		err = -EINVAL;
+		f2fs_warn(sbi, "switch nat_bits option is not allowed");
+		goto restore_opts;
+	}
+
 	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
-- 
2.40.1


