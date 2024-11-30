Return-Path: <linux-kernel+bounces-426115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A979DEF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E87F163745
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 06:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3D149E16;
	Sat, 30 Nov 2024 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PGk47AwR"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839F13C8E8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732948625; cv=none; b=AojEIJVI5KInxFcrQ0qP4U/eYPUn/5fVByZN2qeicLWvafJH07nwKZssUnGPmyI6rHBbsOAtO/UXn7eBG23+RREPjIw9JnvsYRLlX+hdDE8QcE98mNMmBRRAs/vnh2+jii5jRme9quZfuTnPZGRKHFDYUJIzMjc1VJRiiVNyJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732948625; c=relaxed/simple;
	bh=nPzA4awnZioieH5/GUiWH6Q1g6NGKZF7/J7a0r9M+Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm+nB9EbhiW2BmnVhos+EPu+COF8KWZVT9ECsLF0LJyFSEGm29/+eI3edQDuWShpPBLjEK8IDbIBxsE9Ywe0jlorpGL/3YYsMBbYcbkmPtwLXxx3/jrN9zRuJGtSZXpGrO2fxcsjJK29RHS6BEKdXfl9jVMR4DBWYQDDXM1RLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PGk47AwR; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=OsyGn
	ki5o6g212ZSCtqYRDaMbguZhKpJrnZFCLHi8p8=; b=PGk47AwRMa49yxRANqMmh
	6vzzaG4Es0ce+CamUJ+gGxG9XIq/DeqMVk/smiG/tcAlC/EtNCgt5yQQD+geowik
	FiAXtv78icHEH0RkVVLht54iMlvn7Ukdakn47Fvnw6nLzoQyJaeS8FRWWprYP61O
	G4ILcuZ9HBGo/o2AuKx1ak=
Received: from Jerry-PC.. (unknown [115.204.198.71])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H0_6sUpnQ0YgCA--.43253S2;
	Sat, 30 Nov 2024 14:34:38 +0800 (CST)
From: Jerry <jerrydeng079@163.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jerry <jerrydeng079@163.com>
Subject: [PATCH] Fix issue:  Writing a block devices case dead loop. generic_perform_write()->     balance_dirty_pages_ratelimited()->         balance_dirty_pages() At this point, if the block device removed,  the process  may trapped in a dead loop. and the memory of the bdi  device hass also been  released. I found this issue through SCSI devices
Date: Sat, 30 Nov 2024 14:34:31 +0800
Message-ID: <20241130063431.79079-1-jerrydeng079@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H0_6sUpnQ0YgCA--.43253S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4fur1DZw4UJFy3GFW3Jrb_yoW7JF1kpF
	Wayw1FyrW8JFy7WrZ3CayUZF4a93yIkFW7Ary7Ga9IyrsxKF1jkFyavFy0yr10krZ8GrWa
	vr45trW7Gr48Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UndbbUUUUU=
X-CM-SenderInfo: xmhu25pghqwiixz6il2tof0z/1tbiNgun22dKsMMXGwAAsT

Signed-off-by: Jerry <jerrydeng079@163.com>
---
 mm/backing-dev.c    |  1 +
 mm/filemap.c        |  6 ++++-
 mm/page-writeback.c | 61 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index dd08ab928..0b86bd980 100755
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -878,6 +878,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
+	wake_up(&(bdi->wb_waitq));
 	cgwb_bdi_unregister(bdi);
 
 	/*
diff --git a/mm/filemap.c b/mm/filemap.c
index 3b0d8c6dd..3282840f0 100755
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3300,6 +3300,7 @@ ssize_t generic_perform_write(struct file *file,
 	long status = 0;
 	ssize_t written = 0;
 	unsigned int flags = 0;
+	errseq_t err = 0;
 
 	do {
 		struct page *page;
@@ -3368,8 +3369,11 @@ ssize_t generic_perform_write(struct file *file,
 		}
 		pos += copied;
 		written += copied;
-
 		balance_dirty_pages_ratelimited(mapping);
+		err = errseq_check(&mapping->wb_err, 0);
+		if (err)
+			return err;
+
 	} while (iov_iter_count(i));
 
 	return written ? written : status;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b2c916474..e013a6d01 100755
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -146,6 +146,16 @@ struct dirty_throttle_control {
 	unsigned long		pos_ratio;
 };
 
+
+
+struct bdi_wq_callback_entry {
+
+	struct task_struct *tsk;
+	struct wait_queue_entry  wq_entry;
+	int bdi_unregister;
+};
+
+
 /*
  * Length of period for aging writeout fractions of bdis. This is an
  * arbitrarily chosen number. The longer the period, the slower fractions will
@@ -1567,6 +1577,22 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	}
 }
 
+
+static int wake_up_bdi_waitq(wait_queue_entry_t *wait, unsigned int mode,
+				int sync, void *key)
+{
+
+	struct bdi_wq_callback_entry *bwce =
+		container_of(wait, struct bdi_wq_callback_entry, wq_entry);
+
+	bwce->bdi_unregister = 1;
+	if (bwce->tsk)
+		wake_up_process(bwce->tsk);
+
+	return 0;
+}
+
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1574,7 +1600,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
  * If we're over `background_thresh' then the writeback threads are woken to
  * perform some writeout.
  */
-static void balance_dirty_pages(struct bdi_writeback *wb,
+static int balance_dirty_pages(struct bdi_writeback *wb,
 				unsigned long pages_dirtied)
 {
 	struct dirty_throttle_control gdtc_stor = { GDTC_INIT(wb) };
@@ -1595,6 +1621,16 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 	struct backing_dev_info *bdi = wb->bdi;
 	bool strictlimit = bdi->capabilities & BDI_CAP_STRICTLIMIT;
 	unsigned long start_time = jiffies;
+	struct bdi_wq_callback_entry bwce = {NULL};
+	int ret = 0;
+
+
+	if (!test_bit(WB_registered, &wb->state))
+		return -EIO;
+
+	init_waitqueue_func_entry(&(bwce.wq_entry), wake_up_bdi_waitq);
+	bwce.tsk = current;
+	add_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
 
 	for (;;) {
 		unsigned long now = jiffies;
@@ -1816,6 +1852,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		wb->dirty_sleep = now;
 		io_schedule_timeout(pause);
 
+		/* bid is unregister NULL, all bdi memory is illegal */
+		if (bwce.bdi_unregister) {
+			ret = -EIO;
+			break;
+		}
+
 		current->dirty_paused_when = now + pause;
 		current->nr_dirtied = 0;
 		current->nr_dirtied_pause = nr_dirtied_pause;
@@ -1843,12 +1885,15 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		if (fatal_signal_pending(current))
 			break;
 	}
+
+	if (bwce.bdi_unregister == 0)
+		remove_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
 
 	if (!dirty_exceeded && wb->dirty_exceeded)
 		wb->dirty_exceeded = 0;
 
 	if (writeback_in_progress(wb))
-		return;
+		return ret;
 
 	/*
 	 * In laptop mode, we wait until hitting the higher threshold before
@@ -1859,10 +1904,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 	 * background_thresh, to keep the amount of dirty memory low.
 	 */
 	if (laptop_mode)
-		return;
+		return ret;
 
 	if (nr_reclaimable > gdtc->bg_thresh)
 		wb_start_background_writeback(wb);
+
+	return ret;
 }
 
 static DEFINE_PER_CPU(int, bdp_ratelimits);
@@ -1944,8 +1991,12 @@ void balance_dirty_pages_ratelimited(struct address_space *mapping)
 	}
 	preempt_enable();
 
-	if (unlikely(current->nr_dirtied >= ratelimit))
-		balance_dirty_pages(wb, current->nr_dirtied);
+	if (unlikely(current->nr_dirtied >= ratelimit)) {
+
+		if (balance_dirty_pages(wb, current->nr_dirtied) < 0)
+			errseq_set(&(mapping->wb_err), -EIO);
+
+	}
 
 	wb_put(wb);
 }
-- 
2.43.0


