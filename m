Return-Path: <linux-kernel+bounces-235770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810991D970
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C7CB21AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6881AC1;
	Mon,  1 Jul 2024 07:52:32 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D99C144
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820352; cv=none; b=Rrhvztx3X1lQ0uWDk9wgHlOFxuLP8+cfEzhG0/rJwCSPkfbEMaKl8GQrmWf3ldKPKcjb9iRn99KX2ILI6pdeMuPJUQMIVObwZWe2dbTVQO+KppI+7y3bAWw1NM2RyuomIjFBbIsi25i73SSqgfh9H5vM3JiRe+DykcqgUMG6JZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820352; c=relaxed/simple;
	bh=EJoyUeN1V2DAY4KiLqtU+EuAQkzsUGo4uJ31LusWlCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0TNFLPnq22bbe0oQpzzNC3doEbdYVM25kaV434dKWE8G4NFA3GJSedFq/wrMbmxKWB+knwn70fENMaK2w5TqptRrhnoRwKenxwFqXG4xJeL+v3u0lvFZryU8lEAZO71EbHxs9NVJ7izhTijOAmDtazW0W81/ukxbRxV/Dde9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4617pill064601;
	Mon, 1 Jul 2024 15:51:44 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCJ5l68MFz2KQ9Qx;
	Mon,  1 Jul 2024 15:46:51 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 1 Jul 2024 15:51:41 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <ebiggers@google.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kent.overstreet@linux.dev>,
        <niuzhiguo84@gmail.com>, <Hao_hao.Wang@unisoc.com>,
        <yunlongxing23@gmail.com>, <yi.sun@unisoc.com>
Subject: [PATCH v2 1/2] workqueue: new struct io_work
Date: Mon, 1 Jul 2024 15:51:37 +0800
Message-ID: <20240701075138.1144575-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701075138.1144575-1-yi.sun@unisoc.com>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4617pill064601

Many works will go to submit_bio(), and in many cases the io priority
of kworker cannot meet the real-time requirements of this work.

So create a new struct io_work, which contains the io priority that
the kworker thread can adjust its own io priority according to.

And,
new function set_io_work_ioprio() to set the io priority of io work,
new function may_adjust_io_work_task_ioprio() to adjust kworker's io
priority,
new function restore_io_work_task_ioprio() to restore kworker's io
priority.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 include/linux/workqueue.h | 47 ++++++++++++++++++++++++++++++++++++
 kernel/workqueue.c        | 50 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d9968bfc8eac..4b2cb54a68b2 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -127,6 +127,21 @@ struct rcu_work {
 	struct workqueue_struct *wq;
 };
 
+/*
+ * If a work may do disk IO, it is recommended to use struct io_work
+ * instead of struct work_struct.
+ */
+struct io_work {
+	struct work_struct work;
+
+	/* If the work does submit_bio, io priority may be needed. */
+	unsigned short ioprio;
+	/* Record kworker's original io priority. */
+	unsigned short ori_ioprio;
+	/* Whether the work has set io priority? */
+	long ioprio_flag;
+};
+
 enum wq_affn_scope {
 	WQ_AFFN_DFL,			/* use system default */
 	WQ_AFFN_CPU,			/* one pod per CPU */
@@ -218,6 +233,11 @@ static inline struct rcu_work *to_rcu_work(struct work_struct *work)
 	return container_of(work, struct rcu_work, work);
 }
 
+static inline struct io_work *to_io_work(struct work_struct *work)
+{
+	return container_of(work, struct io_work, work);
+}
+
 struct execute_work {
 	struct work_struct work;
 };
@@ -347,6 +367,18 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define INIT_RCU_WORK_ONSTACK(_work, _func)				\
 	INIT_WORK_ONSTACK(&(_work)->work, (_func))
 
+#define INIT_IO_WORK(_work, _func)					\
+	do {								\
+		INIT_WORK(&(_work)->work, (_func));			\
+		(_work)->ioprio_flag = 0;				\
+	} while (0)
+
+#define INIT_IO_WORK_ONSTACK(_work, _func)				\
+	do {								\
+		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
+		(_work)->ioprio_flag = 0;				\
+	} while (0)
+
 /**
  * work_pending - Find out whether a work item is currently pending
  * @work: The work item in question
@@ -552,6 +584,10 @@ extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *dwork, unsigned long delay);
 extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
 
+extern void set_io_work_ioprio(struct io_work *work, unsigned short ioprio);
+extern void may_adjust_io_work_task_ioprio(struct io_work *work);
+extern void restore_io_work_task_ioprio(struct io_work *work);
+
 extern void __flush_workqueue(struct workqueue_struct *wq);
 extern void drain_workqueue(struct workqueue_struct *wq);
 
@@ -636,6 +672,17 @@ static inline bool queue_delayed_work(struct workqueue_struct *wq,
 	return queue_delayed_work_on(WORK_CPU_UNBOUND, wq, dwork, delay);
 }
 
+/**
+ * queue_io_work - queue io work on a workqueue
+ * @wq: workqueue to use
+ * @iowork: io work to queue
+ */
+static inline bool queue_io_work(struct workqueue_struct *wq,
+				      struct io_work *iowork)
+{
+	return queue_work(wq, &(iowork->work));
+}
+
 /**
  * mod_delayed_work - modify delay of or queue a delayed work
  * @wq: workqueue to use
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3fbaecfc88c2..a55b74d5f560 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2652,6 +2652,56 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(queue_rcu_work);
 
+/**
+ * set_io_work_ioprio - set io priority for the current io work
+ * @iowork: the io work to be set
+ * @ioprio: desired io priority
+ *
+ * This function can be called after INIT_IO_WORK if the io priority
+ * of the io work needs to adjust. And it is recommended to use this
+ * function together with may_adjust_io_work_task_ioprio() and
+ * restore_io_work_task_ioprio().
+ */
+void set_io_work_ioprio(struct io_work *iowork, unsigned short ioprio)
+{
+	iowork->ioprio = ioprio;
+	iowork->ioprio_flag = 1;
+}
+EXPORT_SYMBOL(set_io_work_ioprio);
+
+/**
+ * may_adjust_io_work_task_ioprio - maybe adjust the io priority of kworker
+ * @iowork: the io work that kworker will do
+ *
+ * It is recommended to use this function together with set_io_work_ioprio()
+ * and restore_io_work_task_ioprio().
+ */
+void may_adjust_io_work_task_ioprio(struct io_work *iowork)
+{
+	if (iowork->ioprio_flag) {
+		iowork->ori_ioprio = get_current_ioprio();
+		set_task_ioprio(current, iowork->ioprio);
+	}
+}
+EXPORT_SYMBOL(may_adjust_io_work_task_ioprio);
+
+/**
+ * restore_io_work_task_ioprio - restore the io priority of kworker
+ * @iowork: the io work that kworker just did
+ *
+ * When kworker finishes the io work, the original io priority of
+ * kworker should be restored. It is recommended to use this function
+ * together with set_io_work_ioprio() and may_adjust_io_work_task_ioprio().
+ */
+void restore_io_work_task_ioprio(struct io_work *iowork)
+{
+	if (iowork->ioprio_flag) {
+		set_task_ioprio(current, iowork->ori_ioprio);
+		iowork->ioprio_flag = 0;
+	}
+}
+EXPORT_SYMBOL(restore_io_work_task_ioprio);
+
 static struct worker *alloc_worker(int node)
 {
 	struct worker *worker;
-- 
2.25.1


