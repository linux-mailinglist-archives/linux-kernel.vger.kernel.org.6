Return-Path: <linux-kernel+bounces-367586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025959A0422
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF37D282CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418871D1319;
	Wed, 16 Oct 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjsFNHMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD94C8C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067065; cv=none; b=XNirm63d7f5+gFzmZXULIpMJn+QSw5+XajEZujjzVnNjtBP2PPKqjFlpqiq0aGKjXQrmqnATm4WIm0PmOCAXvz90krH/SDNK7CU+rq1L05FYx3m14euhG/bvFzRsmFoQvZX0UOg+QxyvkOMMtX6WohWkCeoKa8iZrN0lU/QMEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067065; c=relaxed/simple;
	bh=dIvzv7sd2ar5087L2o+rqiYca11YTybBulCn0tAdkJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G1q9c4dcnN4oBxFJSnu7RANFVAP3dVpKoE/1OHzSUavWj5Rve99+plhgFgxmDpArQvfAsxnPFe3iGLNIn/KkZs8HnvkxKsQ5tJVVz+EfDaKLdSd4bNQxV5yQ/I/zOUq0b9FdjY3xpWgVq2k/S1Ghi0R7XDlilNsdqh6S8A63Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjsFNHMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB620C4CEC5;
	Wed, 16 Oct 2024 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729067065;
	bh=dIvzv7sd2ar5087L2o+rqiYca11YTybBulCn0tAdkJs=;
	h=From:To:Cc:Subject:Date:From;
	b=MjsFNHMpAfiHtronLrckEagIn8Ut39up/JE8bzHTXsv1hhYjZDzqBWUWizVFGF6z0
	 CkHJ+fKtmLV1WNMs38G8pRS7IHr2hzuGO86u7b4YlxvpsyMQfCpY/mYb9R0H0ASgcz
	 i8gg690SRrfGlspZU27AnPpDmGeOGtnAP/+J76KRk0UOVtutgr+fkc0bPH0bKg6nj/
	 Fg4KyYmgI9+1HjBJXFKMFP9BYG/mwH/TZXvWo2YbzEgJFhK8/n6foBmyUtBQPDNA3+
	 2gHDd3c08Ajo1Hv7zd3CxxZxzRjWVcS52TGEaYBsDtz7OoL3Bt0POPUM7TltbCqvtu
	 MnpzfvuX/zZNA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: multidevice: add stats in debugfs
Date: Wed, 16 Oct 2024 16:24:20 +0800
Message-Id: <20241016082420.610844-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds per-device stats in debugfs, the examples
are as below:

mkfs.f2fs -f -c /dev/vdc /dev/vdb
mount /dev/vdb /mnt/f2fs/
cat /sys/kernel/debug/f2fs/status

Multidevice stats:
  [seg:      inuse    dirty     full     free  prefree]
  #0             5        0        0     4007        0
  #1             1        0        0     8191        0

mkfs.f2fs -f -s 2 -c /dev/vdc /dev/vdb
mount /dev/vdb /mnt/f2fs
cat /sys/kernel/debug/f2fs/status

Multidevice stats:
  [seg:      inuse    dirty     full     free  prefree] [sec:      inuse    dirty     full     free  prefree]
  #0             5        0        0     4005        0                 5        0        0     2000        0
  #1             1        0        0     8191        0                 1        0        0     4095        0

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/debug.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  14 +++++++
 2 files changed, 121 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 546b8ba91261..278c8855ac0a 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -60,6 +60,70 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static void update_multidevice_stats(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	struct f2fs_dev_stats *dev_stats = si->dev_stats;
+	int i, j;
+
+	if (!f2fs_is_multi_device(sbi))
+		return;
+
+	memset(dev_stats, 0, sizeof(struct f2fs_dev_stats) * sbi->s_ndevs);
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		unsigned int start_segno, end_segno;
+		block_t start_blk, end_blk;
+
+		if (i == 0) {
+			start_blk = MAIN_BLKADDR(sbi);
+			end_blk = FDEV(i).end_blk + 1 - SEG0_BLKADDR(sbi);
+		} else {
+			start_blk = FDEV(i).start_blk;
+			end_blk = FDEV(i).end_blk + 1;
+		}
+
+		start_segno = GET_SEGNO(sbi, start_blk);
+		end_segno = GET_SEGNO(sbi, end_blk);
+
+		for (j = start_segno; j < end_segno; j++) {
+			unsigned int seg_blks, sec_blks;
+
+			seg_blks = get_seg_entry(sbi, j)->valid_blocks;
+
+			/* update segment stats */
+			if (IS_CURSEG(sbi, j))
+				dev_stats[i].devstats[0][DEVSTAT_INUSE]++;
+			else if (seg_blks == BLKS_PER_SEG(sbi))
+				dev_stats[i].devstats[0][DEVSTAT_FULL]++;
+			else if (seg_blks != 0)
+				dev_stats[i].devstats[0][DEVSTAT_DIRTY]++;
+			else if (!test_bit(j, FREE_I(sbi)->free_segmap))
+				dev_stats[i].devstats[0][DEVSTAT_FREE]++;
+			else
+				dev_stats[i].devstats[0][DEVSTAT_PREFREE]++;
+
+			if (!__is_large_section(sbi) ||
+				(j % SEGS_PER_SEC(sbi)) != 0)
+				continue;
+
+			sec_blks = get_sec_entry(sbi, j)->valid_blocks;
+
+			/* update section stats */
+			if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, j)))
+				dev_stats[i].devstats[1][DEVSTAT_INUSE]++;
+			else if (sec_blks == BLKS_PER_SEC(sbi))
+				dev_stats[i].devstats[1][DEVSTAT_FULL]++;
+			else if (sec_blks != 0)
+				dev_stats[i].devstats[1][DEVSTAT_DIRTY]++;
+			else if (!test_bit(GET_SEC_FROM_SEG(sbi, j),
+					FREE_I(sbi)->free_secmap))
+				dev_stats[i].devstats[1][DEVSTAT_FREE]++;
+			else
+				dev_stats[i].devstats[1][DEVSTAT_PREFREE]++;
+		}
+	}
+}
+
 static void update_general_status(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
@@ -214,6 +278,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->valid_blks[type] += blks;
 	}
 
+	update_multidevice_stats(sbi);
+
 	for (i = 0; i < MAX_CALL_TYPE; i++)
 		si->cp_call_count[i] = atomic_read(&sbi->cp_call_count[i]);
 
@@ -498,6 +564,36 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->dirty_count);
 		seq_printf(s, "  - Prefree: %d\n  - Free: %d (%d)\n\n",
 			   si->prefree_count, si->free_segs, si->free_secs);
+		if (f2fs_is_multi_device(sbi)) {
+			seq_puts(s, "Multidevice stats:\n");
+			seq_printf(s, "  [seg:   %8s %8s %8s %8s %8s]",
+					"inuse", "dirty", "full", "free", "prefree");
+			if (__is_large_section(sbi))
+				seq_printf(s, " [sec:   %8s %8s %8s %8s %8s]\n",
+					"inuse", "dirty", "full", "free", "prefree");
+			else
+				seq_puts(s, "\n");
+
+			for (i = 0; i < sbi->s_ndevs; i++) {
+				seq_printf(s, "  #%-2d     %8u %8u %8u %8u %8u", i,
+					si->dev_stats[i].devstats[0][DEVSTAT_INUSE],
+					si->dev_stats[i].devstats[0][DEVSTAT_DIRTY],
+					si->dev_stats[i].devstats[0][DEVSTAT_FULL],
+					si->dev_stats[i].devstats[0][DEVSTAT_FREE],
+					si->dev_stats[i].devstats[0][DEVSTAT_PREFREE]);
+				if (!__is_large_section(sbi)) {
+					seq_puts(s, "\n");
+					continue;
+				}
+				seq_printf(s, "          %8u %8u %8u %8u %8u\n",
+					si->dev_stats[i].devstats[1][DEVSTAT_INUSE],
+					si->dev_stats[i].devstats[1][DEVSTAT_DIRTY],
+					si->dev_stats[i].devstats[1][DEVSTAT_FULL],
+					si->dev_stats[i].devstats[1][DEVSTAT_FREE],
+					si->dev_stats[i].devstats[1][DEVSTAT_PREFREE]);
+			}
+			seq_puts(s, "\n");
+		}
 		seq_printf(s, "CP calls: %d (BG: %d)\n",
 			   si->cp_call_count[TOTAL_CALL],
 			   si->cp_call_count[BACKGROUND]);
@@ -665,6 +761,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_stat_info *si;
+	struct f2fs_dev_stats *dev_stats;
 	unsigned long flags;
 	int i;
 
@@ -672,6 +769,15 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	if (!si)
 		return -ENOMEM;
 
+	dev_stats = f2fs_kzalloc(sbi, sizeof(struct f2fs_dev_stats) *
+						sbi->s_ndevs, GFP_KERNEL);
+	if (!dev_stats) {
+		kfree(si);
+		return -ENOMEM;
+	}
+
+	si->dev_stats = dev_stats;
+
 	si->all_area_segs = le32_to_cpu(raw_super->segment_count);
 	si->sit_area_segs = le32_to_cpu(raw_super->segment_count_sit);
 	si->nat_area_segs = le32_to_cpu(raw_super->segment_count_nat);
@@ -724,6 +830,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	list_del(&si->stat_list);
 	raw_spin_unlock_irqrestore(&f2fs_stat_lock, flags);
 
+	kfree(si->dev_stats);
 	kfree(si);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bda61d7ca8dd..56797f8e6659 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3942,6 +3942,19 @@ void f2fs_destroy_recovery_cache(void);
  * debug.c
  */
 #ifdef CONFIG_F2FS_STAT_FS
+enum {
+	DEVSTAT_INUSE,
+	DEVSTAT_DIRTY,
+	DEVSTAT_FULL,
+	DEVSTAT_FREE,
+	DEVSTAT_PREFREE,
+	DEVSTAT_MAX,
+};
+
+struct f2fs_dev_stats {
+	unsigned int devstats[2][DEVSTAT_MAX];		/* 0: segs, 1: secs */
+};
+
 struct f2fs_stat_info {
 	struct list_head stat_list;
 	struct f2fs_sb_info *sbi;
@@ -4005,6 +4018,7 @@ struct f2fs_stat_info {
 	unsigned int block_count[2];
 	unsigned int inplace_count;
 	unsigned long long base_mem, cache_mem, page_mem;
+	struct f2fs_dev_stats *dev_stats;
 };
 
 static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
-- 
2.40.1


