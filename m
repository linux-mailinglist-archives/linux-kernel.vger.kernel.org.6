Return-Path: <linux-kernel+bounces-510391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31DA31C21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D6D1882A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566E1D7E42;
	Wed, 12 Feb 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB4qTsKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992B288B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327735; cv=none; b=IyQhrBj/HBpRIvrChIXLCV+VFnsPeYoKDWmPQwn+b0p9CwEbiq2LhGJe288b79McZJk7BGS6lk223AL8vBTO5LU2XC2EBaZt3EufIiDflNX+NQUI4yHQm67w9KbiIFKas/iEBRYT2nvi/9A6B+HeWiT2RIgpkPq0VQRR2zdIJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327735; c=relaxed/simple;
	bh=xwp5+OyY+74H+o3SIMBQrYP3ySAXaQNadZNPQ4QEGCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcMWsY/AmTLGe0roZVR1LH2wgQAE4Ru33c8zQi9h78+aQCnh06nYytiGKCcxid/Y/VORkAC7LLurVfoyBF4XbMy/7IHLmUjDPobxhmOd3rtM2uNimuHnWSrkLtTazvZcgTUIcPMjeeJq3NE2FaBl2d1oUFuzSHovx1yw3+8UQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB4qTsKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86D5C4CEDD;
	Wed, 12 Feb 2025 02:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327734;
	bh=xwp5+OyY+74H+o3SIMBQrYP3ySAXaQNadZNPQ4QEGCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BB4qTsKhwr8tIZNTZpTMKW58jkgjLty0NM3VY6i1TkOsY5B3xUPh52DIJyrAIlQan
	 8G0bi9Nx9QLwujhUD+veLjSbLyq/z725lAO9033jTePp1SZLPRZVIugk/R5g1EYGHt
	 ssZmgMWnvW8I0EPUIUYFGse1O5HUimPQSNo42QZGqZTYNYQ3TzzVHQ0QCyN+6LpcWJ
	 KrVcU69iE1CK+vkDaBku7DvwZnTJBi37nDIWzgI82t6H9vsNMZT6GnDENXh8xPSGEO
	 giZrfJVnlgTT0O0u75caMaxSNHbf2ZEiL3fF2jxFD1iH1ZsKLM7na9xARZYgIhyilM
	 2v+B5lCIPLZ3Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages
Date: Wed, 12 Feb 2025 02:31:57 +0000
Message-ID: <20250212023518.897942-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250212023518.897942-1-jaegeuk@kernel.org>
References: <20250212023518.897942-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. fadvise(fd1, POSIX_FADV_NOREUSE, {0,3});
2. fadvise(fd2, POSIX_FADV_NOREUSE, {1,2});
3. fadvise(fd3, POSIX_FADV_NOREUSE, {3,1});
4. echo 1024 > /sys/fs/f2fs/tuning/reclaim_caches_kb

This gives a way to reclaim file-backed pages by iterating all f2fs mounts until
reclaiming 1MB page cache ranges, registered by #1, #2, and #3.

5. cat /sys/fs/f2fs/tuning/reclaim_caches_kb
-> gives total number of registered file ranges.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++
 fs/f2fs/f2fs.h                          |  2 +
 fs/f2fs/shrinker.c                      | 90 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         | 63 +++++++++++++++++
 4 files changed, 162 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3e1630c70d8a..81deae2af84d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -828,3 +828,10 @@ Date:		November 2024
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls max read extent count for per-inode, the value of threshold
 		is 10240 by default.
+
+What:		/sys/fs/f2fs/tuning/reclaim_caches_kb
+Date:		February 2025
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	It reclaims the given KBs of file-backed pages registered by
+		ioctl(F2FS_IOC_DONATE_RANGE).
+		For example, writing N tries to drop N KBs spaces in LRU.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3abcb84a0d47..05879c6dc4d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4243,6 +4243,8 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 			struct shrink_control *sc);
 unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 			struct shrink_control *sc);
+unsigned int f2fs_donate_files(void);
+void f2fs_reclaim_caches(unsigned int reclaim_caches_kb);
 void f2fs_join_shrinker(struct f2fs_sb_info *sbi);
 void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index fc1bbef418ce..9c8d3aee89af 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -130,6 +130,96 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
+unsigned int f2fs_donate_files(void)
+{
+	struct f2fs_sb_info *sbi;
+	struct list_head *p;
+	unsigned int donate_files = 0;
+
+	spin_lock(&f2fs_list_lock);
+	p = f2fs_list.next;
+	while (p != &f2fs_list) {
+		sbi = list_entry(p, struct f2fs_sb_info, s_list);
+
+		/* stop f2fs_put_super */
+		if (!mutex_trylock(&sbi->umount_mutex)) {
+			p = p->next;
+			continue;
+		}
+		spin_unlock(&f2fs_list_lock);
+
+		donate_files += sbi->donate_files;
+
+		spin_lock(&f2fs_list_lock);
+		p = p->next;
+		mutex_unlock(&sbi->umount_mutex);
+	}
+	spin_unlock(&f2fs_list_lock);
+
+	return donate_files;
+}
+
+static unsigned int do_reclaim_caches(struct f2fs_sb_info *sbi,
+				unsigned int reclaim_caches_kb)
+{
+	struct inode *inode;
+	struct f2fs_inode_info *fi;
+	unsigned int nfiles = sbi->donate_files;
+	pgoff_t npages = reclaim_caches_kb >> (PAGE_SHIFT - 10);
+
+	while (npages && nfiles--) {
+		pgoff_t len;
+
+		spin_lock(&sbi->inode_lock[DONATE_INODE]);
+		if (list_empty(&sbi->inode_list[DONATE_INODE])) {
+			spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+			break;
+		}
+		fi = list_first_entry(&sbi->inode_list[DONATE_INODE],
+					struct f2fs_inode_info, gdonate_list);
+		list_move_tail(&fi->gdonate_list, &sbi->inode_list[DONATE_INODE]);
+		inode = igrab(&fi->vfs_inode);
+		spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+
+		if (!inode)
+			continue;
+
+		len = fi->donate_end - fi->donate_start + 1;
+		npages = npages < len ? 0 : npages - len;
+		invalidate_inode_pages2_range(inode->i_mapping,
+					fi->donate_start, fi->donate_end);
+		iput(inode);
+		cond_resched();
+	}
+	return npages << (PAGE_SHIFT - 10);
+}
+
+void f2fs_reclaim_caches(unsigned int reclaim_caches_kb)
+{
+	struct f2fs_sb_info *sbi;
+	struct list_head *p;
+
+	spin_lock(&f2fs_list_lock);
+	p = f2fs_list.next;
+	while (p != &f2fs_list && reclaim_caches_kb) {
+		sbi = list_entry(p, struct f2fs_sb_info, s_list);
+
+		/* stop f2fs_put_super */
+		if (!mutex_trylock(&sbi->umount_mutex)) {
+			p = p->next;
+			continue;
+		}
+		spin_unlock(&f2fs_list_lock);
+
+		reclaim_caches_kb = do_reclaim_caches(sbi, reclaim_caches_kb);
+
+		spin_lock(&f2fs_list_lock);
+		p = p->next;
+		mutex_unlock(&sbi->umount_mutex);
+	}
+	spin_unlock(&f2fs_list_lock);
+}
+
 void f2fs_join_shrinker(struct f2fs_sb_info *sbi)
 {
 	spin_lock(&f2fs_list_lock);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b419555e1ea7..b27336acf519 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -916,6 +916,39 @@ static struct f2fs_base_attr f2fs_base_attr_##_name = {		\
 	.show	= f2fs_feature_show,				\
 }
 
+static ssize_t f2fs_tune_show(struct f2fs_base_attr *a, char *buf)
+{
+	unsigned int res = 0;
+
+	if (!strcmp(a->attr.name, "reclaim_caches_kb"))
+		res = f2fs_donate_files();
+
+	return sysfs_emit(buf, "%u\n", res);
+}
+
+static ssize_t f2fs_tune_store(struct f2fs_base_attr *a,
+			const char *buf, size_t count)
+{
+	unsigned long t;
+	int ret;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret)
+		return ret;
+
+	if (!strcmp(a->attr.name, "reclaim_caches_kb"))
+		f2fs_reclaim_caches(t);
+
+	return count;
+}
+
+#define F2FS_TUNE_RW_ATTR(_name)				\
+static struct f2fs_base_attr f2fs_base_attr_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = 0644 },	\
+	.show	= f2fs_tune_show,				\
+	.store	= f2fs_tune_store,				\
+}
+
 static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1368,6 +1401,14 @@ static struct attribute *f2fs_sb_feat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_sb_feat);
 
+F2FS_TUNE_RW_ATTR(reclaim_caches_kb);
+
+static struct attribute *f2fs_tune_attrs[] = {
+	BASE_ATTR_LIST(reclaim_caches_kb),
+	NULL,
+};
+ATTRIBUTE_GROUPS(f2fs_tune);
+
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
 	.store	= f2fs_attr_store,
@@ -1401,6 +1442,20 @@ static struct kobject f2fs_feat = {
 	.kset	= &f2fs_kset,
 };
 
+static const struct sysfs_ops f2fs_tune_attr_ops = {
+	.show	= f2fs_base_attr_show,
+	.store	= f2fs_base_attr_store,
+};
+
+static const struct kobj_type f2fs_tune_ktype = {
+	.default_groups = f2fs_tune_groups,
+	.sysfs_ops	= &f2fs_tune_attr_ops,
+};
+
+static struct kobject f2fs_tune = {
+	.kset	= &f2fs_kset,
+};
+
 static ssize_t f2fs_stat_attr_show(struct kobject *kobj,
 				struct attribute *attr, char *buf)
 {
@@ -1637,6 +1692,11 @@ int __init f2fs_init_sysfs(void)
 	if (ret)
 		goto put_kobject;
 
+	ret = kobject_init_and_add(&f2fs_tune, &f2fs_tune_ktype,
+				   NULL, "tuning");
+	if (ret)
+		goto put_kobject;
+
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	if (!f2fs_proc_root) {
 		ret = -ENOMEM;
@@ -1644,7 +1704,9 @@ int __init f2fs_init_sysfs(void)
 	}
 
 	return 0;
+
 put_kobject:
+	kobject_put(&f2fs_tune);
 	kobject_put(&f2fs_feat);
 	kset_unregister(&f2fs_kset);
 	return ret;
@@ -1652,6 +1714,7 @@ int __init f2fs_init_sysfs(void)
 
 void f2fs_exit_sysfs(void)
 {
+	kobject_put(&f2fs_tune);
 	kobject_put(&f2fs_feat);
 	kset_unregister(&f2fs_kset);
 	remove_proc_entry("fs/f2fs", NULL);
-- 
2.48.1.601.g30ceb7b040-goog


