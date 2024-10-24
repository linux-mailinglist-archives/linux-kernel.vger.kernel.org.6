Return-Path: <linux-kernel+bounces-379171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0939ADAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2098BB217B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1216DC3C;
	Thu, 24 Oct 2024 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T3qqcq2v"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFB167D83
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744613; cv=none; b=drrQFfQ+ovR9jGtAtPyzAsoJbs5UthaJbcoWnoFGLRzMm1pvXcLAPWQ3ruCud3kUQFVrTmuBaNB/WPZmQaEPRxobHpx+Pt3umK+c5regGmtXy/uPbAcvtT1mRI9nzUiWDutsp9eCKEObH3tM4+z/dkixGUYGOeESgQwS+ojWrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744613; c=relaxed/simple;
	bh=0xHsIDR9nQXTWPtVCvWpad1re8GISE2n+yQsKhnNEsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3+Ys9SXwewYnNRIQE2n0XexVV4+Vp0xmXIu/kMTZahYq/6l4rfz1Vh8H+dQDBzAr2s76S/WtjQnAFG4a9/8c/l8MFXNxKkX7q3HczstJH0xw1zYGf5d6ucm9Au1COJkFvZmH5PCvpPRDjxmohcSKCTe73lG1RVQXX1jXwleqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T3qqcq2v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caccadbeeso3793975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729744610; x=1730349410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXl2e78MmAfJ5YnG8JHxdcmasUVncNg3So4LAyflpt8=;
        b=T3qqcq2vYyFE+GH3nI2tKXxDs8STXWub5jAQes3AI6+1hJZ+1Kbz2SLRHzUsAOECOD
         9b8MXidtImnGQmWoqBKm8JfDgKaj4B0Vx1o/QS3CID5j/2lLLXvxpssuP4KB1VWDK6vv
         XN/s6ZPOVNzt9tNcfsACxGR+qLrIvyIt5fH2YpX2AXQdXbfz1FhfR6mQgA88DObynV1q
         HiP9IPCN/a+CFmm60CWYFjU+BErRDYDl6bnkM/hVJ6NfAX/NGRCeXLGipQGzKAggkjeU
         yq0TeT3XBhcPAfQ1UJgEcJzTvOUmUgPO57YkWAignsDhesaHFWDvsJ5tungDv6HZ0a9M
         Rv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729744610; x=1730349410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXl2e78MmAfJ5YnG8JHxdcmasUVncNg3So4LAyflpt8=;
        b=VwNPWHqu7ezm4xjxdED3jQ1PHumQLhkkQ2CfhId63vxqjhqR9UDX3tAQZOBe6lD1Em
         60WsFlKWJV2rM49Lf+Vv3xiT/3dkivG3/R/bYnQ5o5jahMlpZX38D098GbJNLawBT82s
         5o0L+jPsqBTztDyT6hZWsRvHdn7pnIbSvPFmCtUA5NMNyb5+WmBHI1sY8RR61TTerzv6
         iBlikmPJl5rCubZUpJKVvXuvGtS2tZgtTwZiHwqQcnkBiqGtxp/Nc1TXqFoICAs4BXkU
         OSVs3ec5oKfS+y7HwrcISFL3ow3/SY6Nh9SQpmVYtMwAxvXIxJV3Emr5rEJ5iApQM6lk
         NiBA==
X-Forwarded-Encrypted: i=1; AJvYcCVr/nxtqC49v5VbCtSsS1tRa7c6Em0C55ANaTxNS6ydZY6e0jt5l2nPbecKqtnnzzca5K8pYClUrRupVyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyduvZm2p5ncwRPe5sG4eDF9JAe9UZx1XJ7T0n5rbAzIoRcFtpu
	XA0hGw6e4I8bCTNAPk0g9ucxI+SR8RtVePUa/XrdCHm0PsGDv6el3iTCw+zJRRg=
X-Google-Smtp-Source: AGHT+IF44oDg1FP3y1VznBP3ivYT9eDUaI/+kOtvTPpJ5x2Ur7GrKayMV/LDqaW8iBQzwmVJx2t2uw==
X-Received: by 2002:a17:903:2302:b0:207:1675:6709 with SMTP id d9443c01a7336-20fa70773c8mr68102745ad.0.1729744609767;
        Wed, 23 Oct 2024 21:36:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0bda3sm65239735ad.91.2024.10.23.21.36.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Oct 2024 21:36:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: mingo@redhat.com,
	peterz@infradead.org,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] block: refactor rq_qos_wait()
Date: Thu, 24 Oct 2024 12:35:25 +0800
Message-Id: <20241024043525.98663-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rq_qos_wait() is first introduced, it is easy to understand. But
with some bug fixes applied, it is not easy for newcomers to understand
the whole logic under those fixes. In this patch, rq_qos_wait() is
refactored and more comments are added for better understanding. There
are 4 points for the improvement:

    1) Use waitqueue_active() instead of wq_has_sleeper() to eliminate
       unnecessary memory barrier in wq_has_sleeper() which is supposed
       to be used in waker side. In this case, we do need the barrier.
       So use the cheaper one to locklessly test for waiters on the queue.

    2) There is already a macro DEFINE_WAIT_FUNC() to declare a
       wait_queue_entry with a specified waking function. But there is not
       a counterpart for initializing one wait_queue_entry with a
       specified waking function. So introducing init_wait_func() for
       this, which also could be used elsewhere (like filemap.c). It can
       be used in rq_qos_wait() to use default_wake_function() to wake up
       waiters, which could remove ->task field from rq_qos_wait_data.

    3) Remove acquire_inflight_cb() logic for the first waiter out of the
       while loop to make the code clear.

    4) Add more comments to explain how to sync with different waiters and
       the waker.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-rq-qos.c   | 82 +++++++++++++++++++++++++++++---------------
 include/linux/wait.h |  6 ++--
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 9b0aa7dd6779f..5d995d389eaf5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -196,7 +196,6 @@ bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 
 struct rq_qos_wait_data {
 	struct wait_queue_entry wq;
-	struct task_struct *task;
 	struct rq_wait *rqw;
 	acquire_inflight_cb_t *cb;
 	void *private_data;
@@ -218,7 +217,20 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
-	wake_up_process(data->task);
+	/*
+	 * autoremove_wake_function() removes the wait entry only when it
+	 * actually changed the task state. We want the wait always removed.
+	 * Remove explicitly and use default_wake_function().
+	 */
+	default_wake_function(curr, mode, wake_flags, key);
+	/*
+	 * Note that the order of operations is important as finish_wait()
+	 * tests whether @curr is removed without grabbing the lock. This
+	 * should be the last thing to do to make sure we will not have a
+	 * UAF access to @data. And the semantics of memory barrier in it
+	 * also make sure the waiter will see the latest @data->got_token
+	 * once list_empty_careful() in finish_wait() returns true.
+	 */
 	list_del_init_careful(&curr->entry);
 	return 1;
 }
@@ -244,41 +256,55 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 cleanup_cb_t *cleanup_cb)
 {
 	struct rq_qos_wait_data data = {
-		.wq = {
-			.func	= rq_qos_wake_function,
-			.entry	= LIST_HEAD_INIT(data.wq.entry),
-		},
-		.task = current,
-		.rqw = rqw,
-		.cb = acquire_inflight_cb,
-		.private_data = private_data,
+		.rqw		= rqw,
+		.cb		= acquire_inflight_cb,
+		.private_data	= private_data,
+		.got_token	= false,
 	};
-	bool has_sleeper;
+	bool first_waiter;
 
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
+	/*
+	 * If there are no waiters in the waiting queue, try to increase the
+	 * inflight counter if we can. Otherwise, prepare for adding ourselves
+	 * to the waiting queue.
+	 */
+	if (!waitqueue_active(&rqw->wait) && acquire_inflight_cb(rqw, private_data))
 		return;
 
-	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
+	init_wait_func(&data.wq, rq_qos_wake_function);
+	first_waiter = prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
+	/*
+	 * Make sure there is at least one inflight process; otherwise, waiters
+	 * will never be woken up. Since there may be no inflight process before
+	 * adding ourselves to the waiting queue above, we need to try to
+	 * increase the inflight counter for ourselves. And it is sufficient to
+	 * guarantee that at least the first waiter to enter the waiting queue
+	 * will re-check the waiting condition before going to sleep, thus
+	 * ensuring forward progress.
+	 */
+	if (!data.got_token && first_waiter && acquire_inflight_cb(rqw, private_data)) {
+		finish_wait(&rqw->wait, &data.wq);
+		/*
+		 * We raced with rq_qos_wake_function() getting a token,
+		 * which means we now have two. Put our local token
+		 * and wake anyone else potentially waiting for one.
+		 *
+		 * Enough memory barrier in list_empty_careful() in
+		 * finish_wait() is paired with list_del_init_careful()
+		 * in rq_qos_wake_function() to make sure we will see
+		 * the latest @data->got_token.
+		 */
+		if (data.got_token)
+			cleanup_cb(rqw, private_data);
+		return;
+	}
+
+	/* we are now relying on the waker to increase our inflight counter. */
 	do {
-		/* The memory barrier in set_task_state saves us here. */
 		if (data.got_token)
 			break;
-		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-			finish_wait(&rqw->wait, &data.wq);
-
-			/*
-			 * We raced with rq_qos_wake_function() getting a token,
-			 * which means we now have two. Put our local token
-			 * and wake anyone else potentially waiting for one.
-			 */
-			if (data.got_token)
-				cleanup_cb(rqw, private_data);
-			return;
-		}
 		io_schedule();
-		has_sleeper = true;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a08..b008ca42b5903 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1206,14 +1206,16 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 
 #define DEFINE_WAIT(name) DEFINE_WAIT_FUNC(name, autoremove_wake_function)
 
-#define init_wait(wait)								\
+#define init_wait_func(wait, function)						\
 	do {									\
 		(wait)->private = current;					\
-		(wait)->func = autoremove_wake_function;			\
+		(wait)->func = function;					\
 		INIT_LIST_HEAD(&(wait)->entry);					\
 		(wait)->flags = 0;						\
 	} while (0)
 
+#define init_wait(wait)	init_wait_func(wait, autoremove_wake_function)
+
 typedef int (*task_call_f)(struct task_struct *p, void *arg);
 extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
 
-- 
2.20.1


