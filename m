Return-Path: <linux-kernel+bounces-369044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005069A182B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2CB25740
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47623741;
	Thu, 17 Oct 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzeN5v2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB58182B4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130198; cv=none; b=TuvxVgrRgCVK3dMLYrIHZc1WDhsksh2kUzfdW6YyY8CmYv1NDMVL7Kn8W8g7SnqZYcWcy+ZWf7pUdZLvKDRk45lW6lJL0k7i72j6fh7ydHvw38qf6PPEuWriZ/Fual3EmMig19feEycjsdAbDTSoEYMTrtNohQj9YMIJgKK9Gj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130198; c=relaxed/simple;
	bh=JrtDpU4x9ub+GeD+pDTUa5MAJp4cPtJOFR9YJA5bx5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RkkOzBsFOvgDGowgpFQQBCEYoZ7uXqEVhmppr4JPkU1GoMSL8TW6tERG+arlgaOwKzvI84iybCPGOTHzHS4nIz/tXY/AhcvWiw4NLk12auxh4FlwBZRoixnDdQ7ob1v5RdIYojSJ9f4Qz94aQh2+R9YR4KEreWBwQmljEhZ2zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzeN5v2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDFFC4CEC5;
	Thu, 17 Oct 2024 01:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130197;
	bh=JrtDpU4x9ub+GeD+pDTUa5MAJp4cPtJOFR9YJA5bx5k=;
	h=From:To:Cc:Subject:Date:From;
	b=kzeN5v2bGDzEOcT4aa33efAhJ0EA6D9sYaiIr2qrcaamlNCTa1IHRUpmCYyx0MafZ
	 GHBe4BO3wcbDSDzWE3WPo97tnvV9AGeaYrPvpi77ddgPAsDvP9sWriczvXyy++dnSN
	 jGiE1rO0i032ZUMBYDCRkzddu1xENAieiaIi9ZMjDc9x5HR+rSqxThjG0FJJ0nzXbE
	 MdpX8xJSAjTl2FAmMWVmcuIHVaXEm+NGTjbnGUJJnPnhAA1lLEYd010+5dkCjpHvlI
	 BUz+qoEQxZ0635Z6I1g9/Equ9eJVs3EOt5iKxBWGKoAD5L7whKzC/GiaXd/HVEpKLw
	 ou/ZZvDFXVaUQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daeho43@gmail.com>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v6] f2fs: zone: don't block IO if there is remained open zone
Date: Thu, 17 Oct 2024 09:56:21 +0800
Message-Id: <20241017015621.1590536-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max open zone may be larger than log header number of f2fs, for
such case, it doesn't need to wait last IO in previous zone, let's
introduce available_open_zone semaphore, and reduce it once we
submit first write IO in a zone, and increase it after completion
of last IO in the zone.

Cc: Daeho Jeong <daeho43@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
---
v6:
- use per-device blkaddr instead of global one in
is_blkaddr_zone_boundary()
- check write pointer of log header correctly in
restore_curseg_summaries()
 fs/f2fs/data.c    | 106 ++++++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h    |  33 ++++++++++++---
 fs/f2fs/iostat.c  |   7 +++
 fs/f2fs/iostat.h  |   2 +
 fs/f2fs/segment.c |  41 ++++++++++++++++++
 fs/f2fs/segment.h |   3 +-
 fs/f2fs/super.c   |   2 +
 7 files changed, 152 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90fa8ab85194..0b2966e4ff00 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -372,11 +372,10 @@ static void f2fs_write_end_io(struct bio *bio)
 #ifdef CONFIG_BLK_DEV_ZONED
 static void f2fs_zone_write_end_io(struct bio *bio)
 {
-	struct f2fs_bio_info *io = (struct f2fs_bio_info *)bio->bi_private;
+	struct f2fs_sb_info *sbi = iostat_get_bio_private(bio);
 
-	bio->bi_private = io->bi_private;
-	complete(&io->zone_wait);
 	f2fs_write_end_io(bio);
+	up(&sbi->available_open_zones);
 }
 #endif
 
@@ -532,6 +531,24 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (io->open_zone) {
+		/*
+		 * if there is no open zone, it will wait for last IO in
+		 * previous zone before submitting new IO.
+		 */
+		down(&fio->sbi->available_open_zones);
+		io->open_zone = false;
+		io->zone_opened = true;
+	}
+
+	if (io->close_zone) {
+		io->bio->bi_end_io = f2fs_zone_write_end_io;
+		io->zone_opened = false;
+		io->close_zone = false;
+	}
+#endif
+
 	if (is_read_io(fio->op)) {
 		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
 		f2fs_submit_read_bio(io->sbi, io->bio, fio->type);
@@ -605,9 +622,9 @@ int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi)
 			INIT_LIST_HEAD(&io->bio_list);
 			init_f2fs_rwsem(&io->bio_list_lock);
 #ifdef CONFIG_BLK_DEV_ZONED
-			init_completion(&io->zone_wait);
-			io->zone_pending_bio = NULL;
-			io->bi_private = NULL;
+			io->open_zone = false;
+			io->zone_opened = false;
+			io->close_zone = false;
 #endif
 		}
 	}
@@ -638,6 +655,31 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 	f2fs_up_write(&io->io_rwsem);
 }
 
+void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type)
+{
+#ifdef CONFIG_BLK_DEV_ZONED
+	struct f2fs_bio_info *io;
+
+	if (!f2fs_sb_has_blkzoned(sbi))
+		return;
+
+	io = sbi->write_io[PAGE_TYPE(type)] + f2fs_get_segment_temp(type);
+
+	f2fs_down_write(&io->io_rwsem);
+	if (io->zone_opened) {
+		if (io->bio) {
+			io->close_zone = true;
+			__submit_merged_bio(io);
+		} else {
+			up(&sbi->available_open_zones);
+			io->zone_opened = false;
+		}
+	}
+	f2fs_up_write(&io->io_rwsem);
+#endif
+
+}
+
 static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
 				nid_t ino, enum page_type type, bool force)
@@ -922,24 +964,21 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
+static bool is_blkaddr_zone_boundary(struct f2fs_sb_info *sbi,
+					block_t blkaddr, bool start)
 {
-	struct block_device *bdev = sbi->sb->s_bdev;
-	int devi = 0;
+	if (!f2fs_blkaddr_in_seqzone(sbi, blkaddr))
+		return false;
 
 	if (f2fs_is_multi_device(sbi)) {
-		devi = f2fs_target_device_index(sbi, blkaddr);
-		if (blkaddr < FDEV(devi).start_blk ||
-		    blkaddr > FDEV(devi).end_blk) {
-			f2fs_err(sbi, "Invalid block %x", blkaddr);
-			return false;
-		}
+		int devi = f2fs_target_device_index(sbi, blkaddr);
+
 		blkaddr -= FDEV(devi).start_blk;
-		bdev = FDEV(devi).bdev;
 	}
-	return bdev_is_zoned(bdev) &&
-		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
-		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
+
+	if (start)
+		return (blkaddr % sbi->blocks_per_blkz) == 0;
+	return (blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 }
 #endif
 
@@ -950,20 +989,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
 	enum count_type type;
+#ifdef CONFIG_BLK_DEV_ZONED
+	bool blkzoned = f2fs_sb_has_blkzoned(sbi) && btype < META;
+#endif
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
 next:
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
-		wait_for_completion_io(&io->zone_wait);
-		bio_put(io->zone_pending_bio);
-		io->zone_pending_bio = NULL;
-		io->bi_private = NULL;
-	}
-#endif
-
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
@@ -991,6 +1024,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	type = WB_DATA_TYPE(bio_page, fio->compressed_page);
 	inc_page_count(sbi, type);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blkzoned && is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, true))
+		io->open_zone = true;
+#endif
+
 	if (io->bio &&
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
@@ -1016,15 +1054,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	io->last_block_in_bio = fio->new_blkaddr;
 
 	trace_f2fs_submit_page_write(fio->page, fio);
+
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
-			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
-		bio_get(io->bio);
-		reinit_completion(&io->zone_wait);
-		io->bi_private = io->bio->bi_private;
-		io->bio->bi_private = io;
-		io->bio->bi_end_io = f2fs_zone_write_end_io;
-		io->zone_pending_bio = io->bio;
+	if (blkzoned &&
+		is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, false)) {
+		io->close_zone = true;
 		__submit_merged_bio(io);
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f3ef4dc50992..16e7bd0242fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1241,16 +1241,16 @@ struct f2fs_bio_info {
 	struct bio *bio;		/* bios to merge */
 	sector_t last_block_in_bio;	/* last block number */
 	struct f2fs_io_info fio;	/* store buffered io info. */
-#ifdef CONFIG_BLK_DEV_ZONED
-	struct completion zone_wait;	/* condition value for the previous open zone to close */
-	struct bio *zone_pending_bio;	/* pending bio for the previous zone */
-	void *bi_private;		/* previous bi_private for pending bio */
-#endif
 	struct f2fs_rwsem io_rwsem;	/* blocking op for bio */
 	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
 	struct list_head io_list;	/* track fios */
 	struct list_head bio_list;	/* bio entry list head */
 	struct f2fs_rwsem bio_list_lock;	/* lock to protect bio entry list */
+#ifdef CONFIG_BLK_DEV_ZONED
+	bool open_zone;			/* open a zone */
+	bool zone_opened;		/* zone has been opened */
+	bool close_zone;		/* close a zone */
+#endif
 };
 
 #define FDEV(i)				(sbi->devs[i])
@@ -1572,6 +1572,7 @@ struct f2fs_sb_info {
 	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
 	/* For adjust the priority writing position of data in zone UFS */
 	unsigned int blkzone_alloc_policy;
+	struct semaphore available_open_zones;	/* available open zones */
 #endif
 
 	/* for node-related operations */
@@ -3860,6 +3861,7 @@ void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 			  enum page_type type);
 int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
+void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
@@ -4540,6 +4542,27 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 
 	return test_bit(zno, FDEV(devi).blkz_seq);
 }
+
+static inline bool f2fs_blkaddr_in_seqzone(struct f2fs_sb_info *sbi,
+							block_t blkaddr)
+{
+	struct block_device *bdev = sbi->sb->s_bdev;
+	int devi = 0;
+
+	if (f2fs_is_multi_device(sbi)) {
+		devi = f2fs_target_device_index(sbi, blkaddr);
+		if (blkaddr < FDEV(devi).start_blk ||
+		    blkaddr > FDEV(devi).end_blk) {
+			f2fs_err(sbi, "Invalid block %x", blkaddr);
+			return false;
+		}
+		blkaddr -= FDEV(devi).start_blk;
+		bdev = FDEV(devi).bdev;
+	}
+
+	return bdev_is_zoned(bdev) &&
+		f2fs_blkz_is_seq(sbi, devi, blkaddr);
+}
 #endif
 
 static inline int f2fs_bdev_index(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index f8703038e1d8..a8626e297876 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -237,6 +237,13 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
+void *iostat_get_bio_private(struct bio *bio)
+{
+	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+
+	return iostat_ctx->sbi;
+}
+
 void iostat_update_and_unbind_ctx(struct bio *bio)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index eb99d05cf272..9006c3d41590 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -58,6 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
+extern void *iostat_get_bio_private(struct bio *bio);
 extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
@@ -68,6 +69,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
+static inline void *iostat_get_bio_private(struct bio *bio) { return bio->bi_private; }
 static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0f4408fe2b19..6c68d3455048 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3230,6 +3230,10 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
 		return err;
 	stat_inc_seg_type(sbi, curseg);
 	locate_dirty_segment(sbi, old_segno);
+
+	if (new_sec)
+		f2fs_blkzoned_submit_merged_write(sbi, type);
+
 	return 0;
 }
 
@@ -4299,6 +4303,30 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		for (type = 0; type < NR_PERSISTENT_LOG; type++) {
+			struct curseg_info *curseg = CURSEG_I(sbi, type);
+			enum page_type ptype;
+			enum temp_type temp;
+
+			/* current segment locates in non-seqzone */
+			if (!f2fs_blkaddr_in_seqzone(sbi,
+					START_BLOCK(sbi, curseg->segno)))
+				continue;
+
+			/* write pointer of zone is zero */
+			if (is_blkaddr_zone_boundary(sbi,
+				NEXT_FREE_BLKADDR(sbi, curseg), true))
+				continue;
+
+			ptype = PAGE_TYPE(type);
+			temp = f2fs_get_segment_temp(type);
+			down(&sbi->available_open_zones);
+			sbi->write_io[ptype][temp].zone_opened = true;
+		}
+	}
+#endif
 	return 0;
 }
 
@@ -5632,6 +5660,19 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		kfree(array[i].sum_blk);
 		kfree(array[i].journal);
+		kfree(array[i].target_map);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+		if (f2fs_sb_has_blkzoned(sbi)) {
+			enum page_type ptype = PAGE_TYPE(i);
+			enum temp_type temp = f2fs_get_segment_temp(i);
+
+			if (sbi->write_io[ptype][temp].zone_opened) {
+				up(&sbi->available_open_zones);
+				sbi->write_io[ptype][temp].zone_opened = false;
+			}
+		}
+#endif
 	}
 	kfree(array);
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 55a01da6c4be..728f56b65d77 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -26,7 +26,8 @@
 
 #define IS_DATASEG(t)	((t) <= CURSEG_COLD_DATA)
 #define IS_NODESEG(t)	((t) >= CURSEG_HOT_NODE && (t) <= CURSEG_COLD_NODE)
-#define SE_PAGETYPE(se)	((IS_NODESEG((se)->type) ? NODE : DATA))
+#define PAGE_TYPE(t)	(IS_NODESEG(t) ? NODE : DATA)
+#define SE_PAGETYPE(se)	(PAGE_TYPE((se)->type))
 
 static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 						unsigned short seg_type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index aa14c8fce7d9..0d96e352b4ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3923,6 +3923,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 				sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
 			return -EINVAL;
 		}
+
+		sema_init(&sbi->available_open_zones, sbi->max_open_zones);
 	}
 
 	zone_sectors = bdev_zone_sectors(bdev);
-- 
2.40.1


