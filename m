Return-Path: <linux-kernel+bounces-386555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC29B450A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5061F22167
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8EA202F65;
	Tue, 29 Oct 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YltMDVYF"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B12040A1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192183; cv=none; b=XjQlTvioY8t5NMMmpKISR/kzBcHsrfVJYj8iGC1/2TjNBNwXFvZr8x1SdA+s9wmTTrC0k9PPuGs4QLPCtqoIRblarUFyZuu7RZrdWCb6FI2zojyvhPhTMyzUpW+SHWW7lBjW4G3ReAduGfD8ONeEDGPnZhQSse2YxAW6iqnerHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192183; c=relaxed/simple;
	bh=vFg36jmsJgodQ8IFAiNKwf0z86RwvMywEjZxbRMV2u4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DK0QpeHfMKsRRuI63iHbxRUO1tXzouGAPuMA6Gd5yuKKe1+/vwdNVNgOJw6v8XTRBOkJxMj78yQ+/eDXEvc09IlRZDZX0i7yMMduRzjdSYuA7/y4gr+fgLP6LM+vIOHauq/NGjbyKKEpXQrxX/lEw8sWSB7weCenNweD89yEeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YltMDVYF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2884a6b897cso2663405fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730192180; x=1730796980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JSW/59ZXSTTYZTVlWt6K85VyfdapHkDrjU/vQqeQUk=;
        b=YltMDVYFXuTOXWLmyJEGhcXE0Iz2XbDeP5c/QTkK8gn+9gAPaWkLLnqCw46oVx7HZe
         UuL2mhWsH2xchG9/VONwreUzG81Rm0t0YX3I3VHBnfiBKG8gSa/PmzL83Mi/c7+AWVmE
         mUxNznDs9ifsYaxYJiNtEnmsBE2GnNmZru9pT0O82fWkkYyM21bPPHmfa5Qkbk4dbnzj
         EkXnA9qDzhk3JFWv34op/rCY4MCusyhuM9hvDxvIprU79IBMZ27/HR4o72iYlx/gEWdM
         wxQ3y6TKKq1Z2crYn9pTyM4F2RAxy87iChwMO4/6nEDP8VNuIDhBfGum6RGGHLbbkhvd
         rxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192180; x=1730796980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JSW/59ZXSTTYZTVlWt6K85VyfdapHkDrjU/vQqeQUk=;
        b=SllkbRRy8R+HTYn7AEURiHtkNkJ0MeIIM73ETr6YmuSDrvAinTNQzGuYMIx66D7DVE
         fFqTCdzd0fevemOAGrMiWS2pOxY9z6mA7yEfVlz/cj/jKVUWDgvQqYn3nyetRGlU0qBm
         Bh1I6PLoJhag7jQy7LWxGupfKVRIr7xCVO8QI+OMmtbBWUhamYymMBhq2wYTZDfcEo8T
         Z+qOjSidP1GyKABXQxpUwxymZhLUWkHHJ1bIBa9LAk6sSEJr0Ux8mmRg5OfoCZ67AA9o
         4yOqx+M2ou69CT2jQfm2b1uqt+lYaUDpYnvtdqeO/e1cP8M1rHLBimClHY98+z3yWVHq
         VtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3MJ/EtfRVCBkdu2+2SLjmJDb7jIXuok4IxL0kM+q+gXAx1jr3mnfJS8uT10woO54yaYNyQ3oW7hk8pb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwJSX0QelVIA0mwP89DU/4iogxpLpWg/ztV96dGOIXhGLvRt9
	kasi5qERWNfOV4N0hRt+qt+f5Lj+CLHxh11CEHvNdjtj7q2J1b68JYeCLBJkKfY=
X-Google-Smtp-Source: AGHT+IEWsq0oYmYsjl2A5VxU8r6bb9OneAr3wf56xcJ8n/+RxFtRKq36+xMxJcbJU9b5B7r/QkaXFw==
X-Received: by 2002:a05:6870:d60b:b0:261:17e7:59b3 with SMTP id 586e51a60fabf-29051af0f85mr9556559fac.3.1730192179702;
        Tue, 29 Oct 2024 01:56:19 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696a86sm7156832a12.47.2024.10.29.01.56.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Oct 2024 01:56:18 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	yukuai1@huaweicloud.com
Cc: chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/2] block: introduce init_wait_func()
Date: Tue, 29 Oct 2024 16:55:58 +0800
Message-Id: <20241029085559.98390-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a macro DEFINE_WAIT_FUNC() to declare a wait_queue_entry
with a specified waking function. But there is not a counterpart for
initializing one wait_queue_entry with a specified waking function. So
introducing init_wait_func() for this, which also could be used in iocost
and rq-qos. Using default_wake_function() in rq_qos_wait() to wake up
waiters, which could remove ->task field from rq_qos_wait_data.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-iocost.c   |  3 +--
 block/blk-rq-qos.c   | 14 +++++++-------
 include/linux/wait.h |  6 ++++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca6..630895b4471c3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2709,8 +2709,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 * All waiters are on iocg->waitq and the wait states are
 	 * synchronized using waitq.lock.
 	 */
-	init_waitqueue_func_entry(&wait.wait, iocg_wake_fn);
-	wait.wait.private = current;
+	init_wait_func(&wait.wait, iocg_wake_fn);
 	wait.bio = bio;
 	wait.abs_cost = abs_cost;
 	wait.committed = false;	/* will be set true by waker */
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 9b0aa7dd6779f..858ce69c04ece 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -196,7 +196,6 @@ bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 
 struct rq_qos_wait_data {
 	struct wait_queue_entry wq;
-	struct task_struct *task;
 	struct rq_wait *rqw;
 	acquire_inflight_cb_t *cb;
 	void *private_data;
@@ -218,7 +217,12 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
-	wake_up_process(data->task);
+	/*
+	 * autoremove_wake_function() removes the wait entry only when it
+	 * actually changed the task state. We want the wait always removed.
+	 * Remove explicitly and use default_wake_function().
+	 */
+	default_wake_function(curr, mode, wake_flags, key);
 	list_del_init_careful(&curr->entry);
 	return 1;
 }
@@ -244,11 +248,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 cleanup_cb_t *cleanup_cb)
 {
 	struct rq_qos_wait_data data = {
-		.wq = {
-			.func	= rq_qos_wake_function,
-			.entry	= LIST_HEAD_INIT(data.wq.entry),
-		},
-		.task = current,
 		.rqw = rqw,
 		.cb = acquire_inflight_cb,
 		.private_data = private_data,
@@ -259,6 +258,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
 		return;
 
+	init_wait_func(&data.wq, rq_qos_wake_function);
 	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
 	do {
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


