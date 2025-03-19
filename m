Return-Path: <linux-kernel+bounces-567945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D9A68C44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A621792E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D86208993;
	Wed, 19 Mar 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRtogbAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021C54758
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385659; cv=none; b=kC1Yf7cumK5UbTjP4H/jp1oJyghazxBCYf4pjmGStz+sTRx9qjzZQ/ISz+VDrTyMT8vuYH27QlVxRsVT5AubDtDJQRBfkn2ppaCm3GKedAp7DOcklcKq4o0flMcnaNRrgZjTkbqdJsyelmOjTPVH2yA85X+gNFzDmI+h30RYSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385659; c=relaxed/simple;
	bh=20gnGCX8dG0bt8mpa3KjSaH6bWueEUSFhGxeJ701lc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYy0OA1feXqc43rJG7lUu0V8a21/YhtcMLt7t+f9R9E/yiJAaNwLmqEE69Yty33UqpEWOhh8rF7469xUotoEu53M0f47RYtuTKHS/cp52zkV4BARSxIz0Xw8caDNyynhtVB3Ii33h3e0Vjd2JGTlGnDq6X46JSPzLOGRBlePW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRtogbAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98028C4CEEC;
	Wed, 19 Mar 2025 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742385658;
	bh=20gnGCX8dG0bt8mpa3KjSaH6bWueEUSFhGxeJ701lc8=;
	h=From:To:Cc:Subject:Date:From;
	b=jRtogbAsDVaQJfrBWWeY9T0Ypu+88TfteuC3nORLduU8HTAmjplGitKkKmQHb8KcY
	 DXTNMetR2fDw+OfMrlk/HnqAIlmIw1LWUKInwxRvn+ly88qqDUqr25aMFJzcn359An
	 O9XIvaDtDLpZwyOpe5KbZf/Hr48BdYt6dJ985qyu3GevpWcLEOPCP2p7kc3BuJQ402
	 8tcsuEAIzTj2v4lSwpkLqeTlAIB33uls13+GCNBt1nV4tcYb+Ak90Rcs3cPbQPPvQ3
	 +AZYCigJJodb2iNPAsyHCTxqxXiaeljNPMnO700bEC1l6u+lRbbQ6EdBj+HfrRQp2f
	 ozTTqhEl56B1Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: add a proc entry show inject stats
Date: Wed, 19 Mar 2025 20:00:45 +0800
Message-ID: <20250319120046.1784103-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
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
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c |  1 +
 fs/f2fs/sysfs.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

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
index c69161366467..e87e89d2c023 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1679,6 +1679,22 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	return 0;
 }
 
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
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -1770,6 +1786,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				discard_plist_seq_show, sb);
 	proc_create_single_data("disk_map", 0444, sbi->s_proc,
 				disk_map_seq_show, sb);
+	proc_create_single_data("inject_stats", 0444, sbi->s_proc,
+				inject_stats_seq_show, sb);
 	return 0;
 put_feature_list_kobj:
 	kobject_put(&sbi->s_feature_list_kobj);
-- 
2.48.1


