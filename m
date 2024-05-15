Return-Path: <linux-kernel+bounces-180020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4F8C68EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720AD1F23015
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CC155753;
	Wed, 15 May 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1OrolyO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF9155747
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784202; cv=none; b=tOvTA0xAUdgYvoXdwoh+YaZ0RnrJXBRf6lBYH3GmfevrshKeqcbsd33tyKBQkN0+VhVbnUvPn5jJIIwv6+oI0TKywN5xp6H2Q518N4t52sHyPPNWRDuhBkxyvL7KHrZUlnymIDpNbjUllw5NliB5XyID/Rsvf4HQ3cPWVV9P/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784202; c=relaxed/simple;
	bh=h5BS6iv73849I+JhcmkAxZ+BUypAbZHe6BoAQtBTn8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8TeVYMBOhf7Zw6kV19pBYwYwGtUVSdsqMQpF7qkmHupoQt07JaJ9+n3oPvwec6A8UfVCYoCfAeqRtXOia1gmjEHQUnHrVrWJhjKT1ueO7RDK0fNJaVH9XsF5YE5JlzKRasNy/vTgRbbwT7Smr6ArMo/3JBEYvfiC5zdZPTaKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1OrolyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BF8C4AF09;
	Wed, 15 May 2024 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784201;
	bh=h5BS6iv73849I+JhcmkAxZ+BUypAbZHe6BoAQtBTn8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1OrolyOnVZ4DNL0UtcQ1WQNTI03tF2AiYNBtXCQZ3EPKO6pWdEecn0kPPg8X9i/0
	 Lsj9B0nOB8TLtyEWB7B1pb/BndHiA5tQKmb+YiFsYN0SxbUAvKCuaIHXApGuaWSaZn
	 x7/fOT9cPUEH8d1E0tK0CJ2EzL8SpveiSzSR/VFRTwq//htyhAReaNQbQ2vtgpVxeu
	 jDxWFT2hyp6d5Kt94KXo31eiwqzqlkkFERMLoVuMn/eLRjCaORsQdtFLKKjA9Y5r/w
	 Eolpn6gghz+Wf1cRzeN7EHOOv/FjcZNdqOH0+OibC8Vn7c20gqa2vc/4I+7lNMLPvt
	 h4YYhCl7mSeBw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] task_work: s/task_work_cancel()/task_work_cancel_func()/
Date: Wed, 15 May 2024 16:43:08 +0200
Message-ID: <20240515144311.16038-2-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515144311.16038-1-frederic@kernel.org>
References: <20240515144311.16038-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A proper task_work_cancel() API that actually cancels a callback and not
*any* callback pointing to a given function is going to be needed for
perf events event freeing. Do the appropriate rename to prepare for
that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/task_work.h |  2 +-
 kernel/irq/manage.c       |  2 +-
 kernel/task_work.c        | 10 +++++-----
 security/keys/keyctl.c    |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a68429..23ab01ae185e 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -30,7 +30,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bf9ae8a8686f..ab767e62b19a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1333,7 +1333,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..54ac24059daa 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -120,9 +120,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -131,7 +131,7 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
@@ -168,7 +168,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10ba439968f7..3aff32a2bcf3 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1693,7 +1693,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-- 
2.44.0


