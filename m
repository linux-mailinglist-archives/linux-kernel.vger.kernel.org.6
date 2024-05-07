Return-Path: <linux-kernel+bounces-170618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3248BD9C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97A5B21B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BB3FB9F;
	Tue,  7 May 2024 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQtDpAwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B884C94
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053132; cv=none; b=TCmufTpikp5qL7OE5qBZPt5vN5QLo00y3TKvJjeHc9GJa35SOfuxBBtwCDaLYu8FeluAb1gp20uqyn4AZdjVatkUAD0t1++RuV9hO5HONTKIgzmpoMloF9gxTnIaLcTeJSOkrnZ7zz8qrXzwReakYW3QyASlQ1/0l5Bxy1Jlziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053132; c=relaxed/simple;
	bh=w8qd20ZQU6l/9WTNecR3HqKI4gPRO0qNiD5oarsTnvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfpyZWmsBEKWNJQcyeBPqZzc5FMaZ9yYLNH2UnUIJkPy81A+6uvCXlWzi+I6tac90X4iPYuQpPq734FLgAKNvkfq8FuwwA60UQOvlgctTxXKOpM32F+zv5Y/JhHZzOw9AY/zhbURyClyfmine9nmYgzqO8HN9y/fSwpHnJlFsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQtDpAwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53B9C2BBFC;
	Tue,  7 May 2024 03:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715053132;
	bh=w8qd20ZQU6l/9WTNecR3HqKI4gPRO0qNiD5oarsTnvo=;
	h=From:To:Cc:Subject:Date:From;
	b=dQtDpAwBa73n+ZPLNWVnzDyWWqjOCiTxO2dxnXiNNdBfnTg18hWbaE76M+sJp1RQy
	 TsyKS3IOsBHCzPSd8n7HX5VrAHtNZURRVhh4k6Ah77Aei3teUnWPxD/McAqvox+5Oy
	 bwkayYNP3LZXJ/2XZYhdZlblNhgZ/owPiMrrg8Rxx3W/vt4UIKr6lNr39gw7kvBLdk
	 CjVGdS8icz58nAeD8Ntmh4h3ar9LMNDwzxjlGQFTCuiw2jeCc/U6wcxliyzf1QY9J3
	 CNEh1lrY4Rv5wfBw+VkBdqo5UgEa8X/BTtenc7FXn6R/PffopsOlh+/JwKV4wEygy9
	 4mxPfWAcr7F8w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: check validation of fault attrs in f2fs_build_fault_attr()
Date: Tue,  7 May 2024 11:38:47 +0800
Message-Id: <20240507033847.1047251-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- It missed to check validation of fault attrs in parse_options(),
let's fix to add check condition in f2fs_build_fault_attr().
- Use f2fs_build_fault_attr() in __sbi_store() to clean up code.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add static for f2fs_build_fault_attr().
 fs/f2fs/f2fs.h  | 12 ++++++++----
 fs/f2fs/super.c | 27 ++++++++++++++++++++-------
 fs/f2fs/sysfs.c | 14 ++++++++++----
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 95a40d4f778f..a29576f46796 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -72,7 +72,7 @@ enum {
 
 struct f2fs_fault_info {
 	atomic_t inject_ops;
-	unsigned int inject_rate;
+	int inject_rate;
 	unsigned int inject_type;
 };
 
@@ -4597,10 +4597,14 @@ static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 }
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-							unsigned int type);
+extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
+							unsigned long type);
 #else
-#define f2fs_build_fault_attr(sbi, rate, type)		do { } while (0)
+static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
+							unsigned long type)
+{
+	return 0;
+}
 #endif
 
 static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a4bc26dfdb1a..94918ae7eddb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -66,21 +66,31 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_NO_SEGMENT]		= "no free segment",
 };
 
-void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-							unsigned int type)
+int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
+							unsigned long type)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
 	if (rate) {
+		if (rate > INT_MAX)
+			return -EINVAL;
 		atomic_set(&ffi->inject_ops, 0);
-		ffi->inject_rate = rate;
+		ffi->inject_rate = (int)rate;
 	}
 
-	if (type)
-		ffi->inject_type = type;
+	if (type) {
+		if (type >= BIT(FAULT_MAX))
+			return -EINVAL;
+		ffi->inject_type = (unsigned int)type;
+	}
 
 	if (!rate && !type)
 		memset(ffi, 0, sizeof(struct f2fs_fault_info));
+	else
+		f2fs_info(sbi,
+			"build fault injection attr: rate: %lu, type: 0x%lx",
+								rate, type);
+	return 0;
 }
 #endif
 
@@ -886,14 +896,17 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			f2fs_build_fault_attr(sbi, arg, F2FS_ALL_FAULT_TYPE);
+			if (f2fs_build_fault_attr(sbi, arg,
+					F2FS_ALL_FAULT_TYPE))
+				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
 
 		case Opt_fault_type:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			f2fs_build_fault_attr(sbi, 0, arg);
+			if (f2fs_build_fault_attr(sbi, 0, arg))
+				return -EINVAL;
 			set_opt(sbi, FAULT_INJECTION);
 			break;
 #else
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a568ce96cf56..7aa3844e7a80 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -484,10 +484,16 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (ret < 0)
 		return ret;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (a->struct_type == FAULT_INFO_TYPE && t >= BIT(FAULT_MAX))
-		return -EINVAL;
-	if (a->struct_type == FAULT_INFO_RATE && t >= UINT_MAX)
-		return -EINVAL;
+	if (a->struct_type == FAULT_INFO_TYPE) {
+		if (f2fs_build_fault_attr(sbi, 0, t))
+			return -EINVAL;
+		return count;
+	}
+	if (a->struct_type == FAULT_INFO_RATE) {
+		if (f2fs_build_fault_attr(sbi, t, 0))
+			return -EINVAL;
+		return count;
+	}
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-- 
2.40.1


