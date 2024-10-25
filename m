Return-Path: <linux-kernel+bounces-380799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D7F9AF63B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8368E2824C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DD1859;
	Fri, 25 Oct 2024 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gthvQVR5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1038389
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816677; cv=none; b=nRDD+uN0ih8FIKbF54JyLNYENvqQdjlIt3nAphaw9HrA9UUglQYPuanHjjrkHHFvU+EAtUrjqKCk17KSeKsEVKjSXq6mYcg9w1PiAifDchqYrHTEv86WEEaDPdmNU6mGYnJfEimREExtXh+8T9OF+XcC2U7tDPbe3EWuYWPrh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816677; c=relaxed/simple;
	bh=sMgwvjUhq3tF+Lgl21ldlA1Yr4MwGWW6sshpk9Pt6j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XziLjvLj6r1WKi2rFPFRUzdHM4bkGINcWK7OhDRi//ZlPScZeW2ZNgdMIpqgWOgPdr6g5hO1moVOszK5mPeTiyR7g6hPaDrEJrc2lYwZdz+kaUM1o2DYWNsVWqcnrzvcFOOxAlhhmqpUsrSnpVe5iEEI0a7TFrd3OLQRU4f7mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gthvQVR5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729816673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6+zLF7qyVynVu0svG5QjzT7pX1JxbR+qHzl6WhHYkg=;
	b=gthvQVR5pIbTNHrSI1igEsgkJqRhFT8LRBMNNaSiVe7spEMByDYRqYIyy7epL6NsJaNAEZ
	at4nikkn+1zOPRCcsMxUIQIPoD72U87LHo5Po8G55lt+payeePIQC51x5JCaZfJUMn8k3W
	kDaMhjDcM9GclV4xuX6eKl0ZRsbu5ME=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-JiQOOPfnMTeq_LkXDEuFLw-1; Thu,
 24 Oct 2024 20:37:50 -0400
X-MC-Unique: JiQOOPfnMTeq_LkXDEuFLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9901119560B4;
	Fri, 25 Oct 2024 00:37:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BA341956088;
	Fri, 25 Oct 2024 00:37:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] block: model freeze & enter queue as lock for supporting lockdep
Date: Fri, 25 Oct 2024 08:37:20 +0800
Message-ID: <20241025003722.3630252-4-ming.lei@redhat.com>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Recently we got several deadlock report[1][2][3] caused by
blk_mq_freeze_queue and blk_enter_queue().

Turns out the two are just like acquiring read/write lock, so model them
as read/write lock for supporting lockdep:

1) model q->q_usage_counter as two locks(io and queue lock)

- queue lock covers sync with blk_enter_queue()

- io lock covers sync with bio_enter_queue()

2) make the lockdep class/key as per-queue:

- different subsystem has very different lock use pattern, shared lock
 class causes false positive easily

- freeze_queue degrades to no lock in case that disk state becomes DEAD
  because bio_enter_queue() won't be blocked any more

- freeze_queue degrades to no lock in case that request queue becomes dying
  because blk_enter_queue() won't be blocked any more

3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
- it is exclusive lock, so dependency with blk_enter_queue() is covered

- it is trylock because blk_mq_freeze_queue() are allowed to run
  concurrently

4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
- nested blk_enter_queue() are allowed

- dependency with blk_mq_freeze_queue() is covered

- blk_queue_exit() is often called from other contexts(such as irq), and
it can't be annotated as lock_release(), so simply do it in
blk_enter_queue(), this way still covered cases as many as possible

With lockdep support, such kind of reports may be reported asap and
needn't wait until the real deadlock is triggered.

For example, lockdep report can be triggered in the report[3] with this
patch applied.

[1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
https://bugzilla.kernel.org/show_bug.cgi?id=219166

[2] del_gendisk() vs blk_queue_enter() race condition
https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/

[3] queue_freeze & queue_enter deadlock in scsi
https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 18 ++++++++++++++++--
 block/blk-mq.c         | 26 ++++++++++++++++++++++----
 block/blk.h            | 29 ++++++++++++++++++++++++++---
 block/genhd.c          | 15 +++++++++++----
 include/linux/blkdev.h |  6 ++++++
 5 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5eaac9..09d10bb95fda 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -261,6 +261,8 @@ static void blk_free_queue(struct request_queue *q)
 		blk_mq_release(q);
 
 	ida_free(&blk_queue_ida, q->id);
+	lockdep_unregister_key(&q->io_lock_cls_key);
+	lockdep_unregister_key(&q->q_lock_cls_key);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
@@ -278,18 +280,20 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
-void blk_queue_start_drain(struct request_queue *q)
+bool blk_queue_start_drain(struct request_queue *q)
 {
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
-	blk_freeze_queue_start(q);
+	bool freeze = __blk_freeze_queue_start(q);
 	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
+
+	return freeze;
 }
 
 /**
@@ -321,6 +325,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 			return -ENODEV;
 	}
 
+	rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->q_lockdep_map, _RET_IP_);
 	return 0;
 }
 
@@ -352,6 +358,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 			goto dead;
 	}
 
+	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
 	bio_io_error(bio);
@@ -441,6 +449,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
 	if (error)
 		goto fail_stats;
+	lockdep_register_key(&q->io_lock_cls_key);
+	lockdep_register_key(&q->q_lock_cls_key);
+	lockdep_init_map(&q->io_lockdep_map, "&q->q_usage_counter(io)",
+			 &q->io_lock_cls_key, 0);
+	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
+			 &q->q_lock_cls_key, 0);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 96858fb3b9ff..76f277a30c11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -120,17 +120,29 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+bool __blk_freeze_queue_start(struct request_queue *q)
 {
+	int freeze;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
 		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
+		freeze = true;
 	} else {
 		mutex_unlock(&q->mq_freeze_lock);
+		freeze = false;
 	}
+
+	return freeze;
+}
+
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	if (__blk_freeze_queue_start(q))
+		blk_freeze_acquire_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
@@ -176,8 +188,10 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 {
+	int unfreeze = false;
+
 	mutex_lock(&q->mq_freeze_lock);
 	if (force_atomic)
 		q->q_usage_counter.data->force_atomic = true;
@@ -186,13 +200,17 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
+		unfreeze = true;
 	}
 	mutex_unlock(&q->mq_freeze_lock);
+
+	return unfreeze;
 }
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	__blk_mq_unfreeze_queue(q, false);
+	if (__blk_mq_unfreeze_queue(q, false))
+		blk_unfreeze_release_lock(q, false, false);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
@@ -205,7 +223,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_freeze_queue_start_non_owner(struct request_queue *q)
 {
-	blk_freeze_queue_start(q);
+	__blk_freeze_queue_start(q);
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
 
diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..832e54c5a271 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
 #include <linux/timekeeping.h>
@@ -35,8 +36,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
-void blk_queue_start_drain(struct request_queue *q);
+bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
+bool blk_queue_start_drain(struct request_queue *q);
+bool __blk_freeze_queue_start(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 void submit_bio_noacct_nocheck(struct bio *bio);
 void bio_await_chain(struct bio *bio);
@@ -69,8 +71,11 @@ static inline int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
-	if (blk_try_enter_queue(q, false))
+	if (blk_try_enter_queue(q, false)) {
+		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
+	}
 	return __bio_queue_enter(q, bio);
 }
 
@@ -734,4 +739,22 @@ void blk_integrity_verify(struct bio *bio);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
+static inline void blk_freeze_acquire_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!disk_dead)
+		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
+	if (!queue_dying)
+		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
+}
+
+static inline void blk_unfreeze_release_lock(struct request_queue *q, bool
+		disk_dead, bool queue_dying)
+{
+	if (!queue_dying)
+		rwsem_release(&q->q_lockdep_map, _RET_IP_);
+	if (!disk_dead)
+		rwsem_release(&q->io_lockdep_map, _RET_IP_);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..6ad3fcde0110 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -581,13 +581,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	rcu_read_unlock();
 }
 
-static void __blk_mark_disk_dead(struct gendisk *disk)
+static bool __blk_mark_disk_dead(struct gendisk *disk)
 {
 	/*
 	 * Fail any new I/O.
 	 */
 	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return;
+		return false;
 
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
@@ -600,7 +600,7 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
 	/*
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
-	blk_queue_start_drain(disk->queue);
+	return blk_queue_start_drain(disk->queue);
 }
 
 /**
@@ -641,6 +641,7 @@ void del_gendisk(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct block_device *part;
 	unsigned long idx;
+	bool start_drain, queue_dying;
 
 	might_sleep();
 
@@ -668,7 +669,10 @@ void del_gendisk(struct gendisk *disk)
 	 * Drop all partitions now that the disk is marked dead.
 	 */
 	mutex_lock(&disk->open_mutex);
-	__blk_mark_disk_dead(disk);
+	start_drain = __blk_mark_disk_dead(disk);
+	queue_dying = blk_queue_dying(q);
+	if (start_drain)
+		blk_freeze_acquire_lock(q, true, queue_dying);
 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		drop_partition(part);
 	mutex_unlock(&disk->open_mutex);
@@ -725,6 +729,9 @@ void del_gendisk(struct gendisk *disk)
 		if (queue_is_mq(q))
 			blk_mq_exit_queue(q);
 	}
+
+	if (start_drain)
+		blk_unfreeze_release_lock(q, true, queue_dying);
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..57f1ee386b57 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -25,6 +25,7 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 #include <linux/file.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct request_queue;
@@ -471,6 +472,11 @@ struct request_queue {
 	struct xarray		hctx_table;
 
 	struct percpu_ref	q_usage_counter;
+	struct lock_class_key	io_lock_cls_key;
+	struct lockdep_map	io_lockdep_map;
+
+	struct lock_class_key	q_lock_cls_key;
+	struct lockdep_map	q_lockdep_map;
 
 	struct request		*last_merge;
 
-- 
2.46.0


