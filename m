Return-Path: <linux-kernel+bounces-569074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0BA69E36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EEC16D940
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B61EA7C4;
	Thu, 20 Mar 2025 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCk442lm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54C1C32FF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437366; cv=none; b=HtEYzNHhrmTBMWnL5mnBR75i/UXFzwdWl+DgXe1/Ne6P0IzzUfFFXvlthlr7licQ/UG0EYqQ453GDhbpF6JLRbRstOzACMl057jBEGowLe4nd1cXmX2UUQxpXVglAHvPCNm4i+cD1YpfyuaHy23qsaqoNRqQjgZN5ko9idlNyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437366; c=relaxed/simple;
	bh=W7q6/PTwJrqZQUKTE/L2eAuHe1DXB/d42aG5MQ4jxcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3xS0vDt5xqd+bRN5F8NKF0ONfHY0mdu/RfdTKhMfjxaswGti6wTtknbicGLTlEiDNkrVuNAFjOxfd4Mh1bx0ti7uJuHJnYdFp89WP4ziiT6aQt8wWhAMxFKqrhZq1wKNcaHtXb3Y7v31dgAUjJIFtCO+7ZXlltsY4h4adBnkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCk442lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0316C4CEE4;
	Thu, 20 Mar 2025 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742437365;
	bh=W7q6/PTwJrqZQUKTE/L2eAuHe1DXB/d42aG5MQ4jxcA=;
	h=From:To:Cc:Subject:Date:From;
	b=SCk442lmYPaXAGDnk5j7Z3iS8kIKBgaGbOHm5Qqd3iKft7cefuA2aemDt2LhRE6L5
	 RPk9Ulu4TfOESGU9MlfQG3eJaCvIJadkpZ6qw6Pn0ycmdcFul8THx3d4ySQKdodBuy
	 e0QeN5I6cYzacySyNpk8lJM3WP+MoWQOL06ssfQY4Q9tlSIgyd9kmFpwFi5rVkRstP
	 IsUziD6c/kQQdZoWGlIcRc9hOf0D8/W3EXaAMh3Vl/XabFjqaXdYOA2gZUNMLvb+wM
	 agp09fdxMq+Wr+uh2S5rQzQB/6r/BLtq9RsM10IpuW5YWJ7miaOiQ8yLzBX3UHvr5I
	 jjhKaVBQZi+KQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/2] f2fs: add a proc entry show inject stats
Date: Thu, 20 Mar 2025 10:22:29 +0800
Message-ID: <20250320022230.1938110-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a proc entry named inject_stats to show total injected
count for each fault type.

cat /proc/fs/f2fs/<dev>/inject_stats
fault_type              injected_count
kmalloc                 0
kvmalloc                0
page alloc              0
page get                0
alloc bio(obsolete)     0
alloc nid               0
orphan                  0
no more block           0
too big dir depth       0
evict_inode fail        0
truncate fail           0
read IO error           0
checkpoint error        0
discard error           0
write IO error          0
slab alloc              0
dquot initialize        0
lock_op                 0
invalid blkaddr         0
inconsistent blkaddr    0
no free segment         0
inconsistent footer     0

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add missing CONFIG_F2FS_FAULT_INJECTION
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c |  1 +
 fs/f2fs/sysfs.c | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1576dc6ec67..986ee5b9326d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -73,6 +73,8 @@ struct f2fs_fault_info {
 	atomic_t inject_ops;
 	int inject_rate;
 	unsigned int inject_type;
+	/* Used to account total count of injection for each type */
+	unsigned int inject_count[FAULT_MAX];
 };
 
 extern const char *f2fs_fault_name[FAULT_MAX];
@@ -1902,6 +1904,7 @@ static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
 	atomic_inc(&ffi->inject_ops);
 	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
 		atomic_set(&ffi->inject_ops, 0);
+		ffi->inject_count[type]++;
 		f2fs_info_ratelimited(sbi, "inject %s in %s of %pS",
 				f2fs_fault_name[type], func, parent_func);
 		return true;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f087b2b71c89..dfe0604ab558 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -47,6 +47,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KVMALLOC]		= "kvmalloc",
 	[FAULT_PAGE_ALLOC]		= "page alloc",
 	[FAULT_PAGE_GET]		= "page get",
+	[FAULT_ALLOC_BIO]		= "alloc bio(obsolete)",
 	[FAULT_ALLOC_NID]		= "alloc nid",
 	[FAULT_ORPHAN]			= "orphan",
 	[FAULT_BLOCK]			= "no more block",
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c69161366467..46fa94db08a8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1679,6 +1679,24 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+static int __maybe_unused inject_stats_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
+	int i;
+
+	seq_puts(seq, "fault_type		injected_count\n");
+
+	for (i = 0; i < FAULT_MAX; i++)
+		seq_printf(seq, "%-24s%-10u\n", f2fs_fault_name[i],
+						ffi->inject_count[i]);
+	return 0;
+}
+#endif
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -1770,6 +1788,10 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				discard_plist_seq_show, sb);
 	proc_create_single_data("disk_map", 0444, sbi->s_proc,
 				disk_map_seq_show, sb);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	proc_create_single_data("inject_stats", 0444, sbi->s_proc,
+				inject_stats_seq_show, sb);
+#endif
 	return 0;
 put_feature_list_kobj:
 	kobject_put(&sbi->s_feature_list_kobj);
-- 
2.48.1


