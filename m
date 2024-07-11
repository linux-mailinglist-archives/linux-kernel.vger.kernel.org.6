Return-Path: <linux-kernel+bounces-249242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6D92E8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C751F219BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963D1607A1;
	Thu, 11 Jul 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik3KuZel"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9115FD1B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702873; cv=none; b=Q0dCcDvH1YeBR2ATaizWL3fFsxOxwXh75MwqVnTbDmlpliVstT+DQ/ev304FKYTzOTO+a64agJbtsA3F8qKSswJetSJJIc7x0Vv0feEgcx7ZPmL+GpNmP4PLWN3uP3Q+UpXkVUIR1NSehwHeonkbWu4XI50fq8wig7iasse6Xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702873; c=relaxed/simple;
	bh=tk3/eU+VtYT+/UhY7nwOfNv0uD4Ewrnc70U2kX7qZDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stqZRjsPEobSCQ5+gm3zpd1VPyaTYSlTrlAcfhdOlZvRqIM3SVb4etiLxKOXQDdBwM2sNn4rEZzczloltFBR9fme+NJw3f/cOdfeCVaKpyYfFkKMRd6aKGRxQGX5BFJxtccxncYBrjSu8D+H6aFbjAhsHF20D5sOL2G/BcQJdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik3KuZel; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe3ZcX+q5foJNAvfJR3Gr4N1bW3UV6I6D4EkwWMO3O0=;
	b=ik3KuZel+/MNbCrbxQmgD9Sa+ciKJuVuC8Hx9xFy2GqlFD2eF95ouLpQy5AUlI1jhyaorT
	azE01MS2TUGp80g6WUmmm2TntZQOM3GBOJWwlX2rHVmfB/ERfF7OF7naDtOATN99AIbiLC
	L/z0x75P1mHg0XnDBMX3yq5ktFYN1wE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-fdulkfqJNUmCkKIxHRvfTg-1; Thu,
 11 Jul 2024 09:01:07 -0400
X-MC-Unique: fdulkfqJNUmCkKIxHRvfTg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63A4F19560B6;
	Thu, 11 Jul 2024 13:01:01 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 391341955E8E;
	Thu, 11 Jul 2024 13:00:54 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 03/10] task_work, sched: Add a _locked variant to task_work_cancel()
Date: Thu, 11 Jul 2024 14:59:57 +0200
Message-ID: <20240711130004.2157737-4-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Later commits will need to issue a task_work_cancel() from within the
scheduler with the task's ->pi_lock held.

Add a _locked variant that expects p->pi_lock to be held. Expose it in a
separate scheduler header file, as this really is a scheduler-only
interface.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/task_work_sched.h | 14 +++++++
 kernel/task_work.c             | 67 ++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 15 deletions(-)
 create mode 100644 kernel/sched/task_work_sched.h

diff --git a/kernel/sched/task_work_sched.h b/kernel/sched/task_work_sched.h
new file mode 100644
index 0000000000000..e235da456427f
--- /dev/null
+++ b/kernel/sched/task_work_sched.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler internal task_work methods
+ */
+#ifndef _KERNEL_TASK_WORK_SCHED_H
+#define _KERNEL_TASK_WORK_SCHED_H
+
+#include <linux/task_work.h>
+#include <linux/sched.h>
+
+struct callback_head *
+task_work_cancel_locked(struct task_struct *task, task_work_func_t func);
+
+#endif
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1dab..81092bc2e7371 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -3,6 +3,8 @@
 #include <linux/task_work.h>
 #include <linux/resume_user_mode.h>
 
+#include "sched/task_work_sched.h"
+
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
 /**
@@ -74,33 +76,20 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	return 0;
 }
 
-/**
- * task_work_cancel_match - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @match: match function to call
- * @data: data to be passed in to match function
- *
- * RETURNS:
- * The found work or NULL if not found.
- */
-struct callback_head *
-task_work_cancel_match(struct task_struct *task,
+static struct callback_head *
+task_work_cancel_match_locked(struct task_struct *task,
 		       bool (*match)(struct callback_head *, void *data),
 		       void *data)
 {
 	struct callback_head **pprev = &task->task_works;
 	struct callback_head *work;
-	unsigned long flags;
 
-	if (likely(!task_work_pending(task)))
-		return NULL;
 	/*
 	 * If cmpxchg() fails we continue without updating pprev.
 	 * Either we raced with task_work_add() which added the
 	 * new entry before this work, we will find it again. Or
 	 * we raced with task_work_run(), *pprev == NULL/exited.
 	 */
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
 	work = READ_ONCE(*pprev);
 	while (work) {
 		if (!match(work, data)) {
@@ -109,6 +98,32 @@ task_work_cancel_match(struct task_struct *task,
 		} else if (try_cmpxchg(pprev, &work, work->next))
 			break;
 	}
+
+	return work;
+}
+
+/**
+ * task_work_cancel_match - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @match: match function to call
+ * @data: data to be passed in to match function
+ *
+ * RETURNS:
+ * The found work or NULL if not found.
+ */
+struct callback_head *
+task_work_cancel_match(struct task_struct *task,
+		       bool (*match)(struct callback_head *, void *data),
+		       void *data)
+{
+	unsigned long flags;
+	struct callback_head *work;
+
+	if (likely(!task_work_pending(task)))
+		return NULL;
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	work = task_work_cancel_match_locked(task, match, data);
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 
 	return work;
@@ -136,6 +151,28 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @func: identifies the work to remove
+ *
+ * Find the last queued pending work with ->func == @func and remove
+ * it from queue.
+ *
+ * RETURNS:
+ * The found work or NULL if not found.
+ */
+struct callback_head *
+task_work_cancel_locked(struct task_struct *task, task_work_func_t func)
+{
+	lockdep_assert_held(&task->pi_lock);
+
+	if (likely(!task_work_pending(task)))
+		return NULL;
+
+	return task_work_cancel_match_locked(task, task_work_func_match, func);
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
-- 
2.43.0


