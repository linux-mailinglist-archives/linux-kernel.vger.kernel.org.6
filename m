Return-Path: <linux-kernel+bounces-224060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E983911CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A989B2317A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B016C699;
	Fri, 21 Jun 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEediqK5"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51F16C436
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954987; cv=none; b=RiggYQt0yXbfktlUlWTw7uWfYtLYEX/aYe3guuejHcSErMoldR0pFawx8Sx1+E9ftfZEdyQ4GLWlSOXf33JSEBiy6+UOcHdwYlQYlOLg7HW7HNlykcBgu3JrvX2TtzZSpp1iRuWz24YLZnrgcMAIRwJ+8K8YzCrUCqKB7+6RS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954987; c=relaxed/simple;
	bh=jUbJuRYowq+lTNk/JeWk1wlSh7O1av6rtsq6MZo7vJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDHXNdYH4Ske9xuCezStuDSEUspaNAW4+M73cgLPylpvn5Gyq1Qf8lr/RUaTvwfJ9KXXr9Hqr/EEbUPIlKsWnZ2cLVJ2qiYf5WcqC52I+7OB281jGRaSgzY1HJ29lqnyvsHAW/XsXAGGJi8RVgN8YbCvTg0CUxSshsq8Z9otlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEediqK5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so1709427b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954985; x=1719559785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RM/r+VPbqDnzVngpECuz1flcgt2geIdwHZBnUvHHTQ=;
        b=mEediqK5VjW0ZZ5yLPONKO/nSskzyU3uA+a9RqUEsXajQl4IKfnZPv1Ef2IkJfufBs
         rE4+NDVbTcY8eFln9Pqsw96UG90uFVlRtCHzDQLGLzMySZRvvcrGjtkVjqd2fgZSVOlP
         SBjr80jaXxoupNiWAoag1o7o/4LtBhYovq5FoCuvHOJXVPShjT3XIPwbftpsSMleGtgX
         QAifjv0GKbztIODq5kgmEDYwFkHblpulY+MrIIeFy5OEDGEd0xkH1b4FOkFvEzIf1bpJ
         SHKZjqI7mzB+6GoCS3SeA66rz1h84GzlnGspri8fpxPlo9jdjnckuTiTxcltzIA0ko8f
         gI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954985; x=1719559785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RM/r+VPbqDnzVngpECuz1flcgt2geIdwHZBnUvHHTQ=;
        b=LxFet+r9bOoG1Y6Ao25LvbmUT4GE4uDm3iCml09/0ay/1XNNMKVS8Or7kAZBDeVzHG
         E18qG5Li+hKbV1nrM+OcjMjJVcb/7mGJ+7U57+BkRhUTxmGk7JgBQrJ7BLcrewfK58im
         3P8i4n4bqIz4St4sPWzeA6vBwBqbMz/0fhKGkxwtbMk/gAXgLtENEwh/+MFRNbTaJlHj
         n0xkYXOTT4L0j4rze0Valy/rh2owbhtyBaVWb5sxI0skkWNrL0l/C/4XipwNElX4FJno
         hDSyv2cwScIy5xf6ub8YyjqcC3MarmWcBS4JnvhE2tZ02NzFqZYiKcS3gKngzLYljb8H
         WDcQ==
X-Gm-Message-State: AOJu0Yx88CrkBKngFwqhS/byAvNzo+P3bRbS2sJ4w5lRms3EWswuG0O0
	vL8LX998yyHoVbGmGNnX5/qJyZezN0k9VJZKHJmSV4RhYSHExVm5DjbKZA==
X-Google-Smtp-Source: AGHT+IFuwj1HMWnohHgc82cK/EZthf5aN4oaCsTbAnAxrkg0nHbdOgJcXrnVqnLZfv6QORdpNslrMQ==
X-Received: by 2002:a17:90b:f82:b0:2c8:631:2f53 with SMTP id 98e67ed59e1d1-2c806313090mr4062787a91.7.1718954985202;
        Fri, 21 Jun 2024 00:29:45 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55dcdffsm2934129a91.33.2024.06.21.00.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:29:44 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and remove detach_completion
Date: Fri, 21 Jun 2024 15:32:22 +0800
Message-Id: <20240621073225.3600-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240621073225.3600-1-jiangshanlai@gmail.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The code to kick off the destruction of workers is now in a process
context (idle_cull_fn()), so kthread_stop() can be used in the process
context to replace the work of pool->detach_completion.

The wakeup in wake_dying_workers() is unneeded after this change, but it
is harmless, jut keep it here until next patch renames wake_dying_workers()
rather than renaming it again and again.

Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 25a7d9a1a7ae..a0fb2f60e938 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -216,7 +216,6 @@ struct worker_pool {
 	struct worker		*manager;	/* L: purely informational */
 	struct list_head	workers;	/* A: attached workers */
 	struct list_head        dying_workers;  /* A: workers about to die */
-	struct completion	*detach_completion; /* all workers detached */
 
 	struct ida		worker_ida;	/* worker IDs for task name */
 
@@ -2696,7 +2695,6 @@ static void worker_attach_to_pool(struct worker *worker,
 static void worker_detach_from_pool(struct worker *worker)
 {
 	struct worker_pool *pool = worker->pool;
-	struct completion *detach_completion = NULL;
 
 	/* there is one permanent BH worker per CPU which should never detach */
 	WARN_ON_ONCE(pool->flags & POOL_BH);
@@ -2707,15 +2705,10 @@ static void worker_detach_from_pool(struct worker *worker)
 	list_del(&worker->node);
 	worker->pool = NULL;
 
-	if (list_empty(&pool->workers) && list_empty(&pool->dying_workers))
-		detach_completion = pool->detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
 	worker->flags &= ~(WORKER_UNBOUND | WORKER_REBOUND);
-
-	if (detach_completion)
-		complete(detach_completion);
 }
 
 /**
@@ -2816,10 +2809,9 @@ static void unbind_worker(struct worker *worker)
 
 static void wake_dying_workers(struct list_head *cull_list)
 {
-	struct worker *worker, *tmp;
+	struct worker *worker;
 
-	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
-		list_del_init(&worker->entry);
+	list_for_each_entry(worker, cull_list, entry) {
 		unbind_worker(worker);
 		/*
 		 * If the worker was somehow already running, then it had to be
@@ -2835,6 +2827,17 @@ static void wake_dying_workers(struct list_head *cull_list)
 	}
 }
 
+static void reap_dying_workers(struct list_head *cull_list)
+{
+	struct worker *worker, *tmp;
+
+	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
+		list_del_init(&worker->entry);
+		kthread_stop_put(worker->task);
+		kfree(worker);
+	}
+}
+
 /**
  * set_worker_dying - Tag a worker for destruction
  * @worker: worker to be destroyed
@@ -2866,6 +2869,9 @@ static void set_worker_dying(struct worker *worker, struct list_head *list)
 
 	list_move(&worker->entry, list);
 	list_move(&worker->node, &pool->dying_workers);
+
+	/* get an extra task struct reference for later kthread_stop_put() */
+	get_task_struct(worker->task);
 }
 
 /**
@@ -2949,6 +2955,8 @@ static void idle_cull_fn(struct work_struct *work)
 	raw_spin_unlock_irq(&pool->lock);
 	wake_dying_workers(&cull_list);
 	mutex_unlock(&wq_pool_attach_mutex);
+
+	reap_dying_workers(&cull_list);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -3330,7 +3338,6 @@ static int worker_thread(void *__worker)
 		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
-		kfree(worker);
 		return 0;
 	}
 
@@ -4863,7 +4870,6 @@ static void rcu_free_pool(struct rcu_head *rcu)
  */
 static void put_unbound_pool(struct worker_pool *pool)
 {
-	DECLARE_COMPLETION_ONSTACK(detach_completion);
 	struct worker *worker;
 	LIST_HEAD(cull_list);
 
@@ -4917,12 +4923,9 @@ static void put_unbound_pool(struct worker_pool *pool)
 
 	wake_dying_workers(&cull_list);
 
-	if (!list_empty(&pool->workers) || !list_empty(&pool->dying_workers))
-		pool->detach_completion = &detach_completion;
 	mutex_unlock(&wq_pool_attach_mutex);
 
-	if (pool->detach_completion)
-		wait_for_completion(pool->detach_completion);
+	reap_dying_workers(&cull_list);
 
 	/* shut down the timers */
 	del_timer_sync(&pool->idle_timer);
-- 
2.19.1.6.gb485710b


