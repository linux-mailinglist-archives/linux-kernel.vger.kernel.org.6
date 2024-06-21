Return-Path: <linux-kernel+bounces-224288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A2912044
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67E128DD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5B416E887;
	Fri, 21 Jun 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfUPcfCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F716E883
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961371; cv=none; b=nbQc5uvAZyLWq9Njm4SMDGYirA3zWnqZx8a19vFnBzqzWCC1iR9/UtQTzEH7X1ntbOG1snhCOWui95RkA44lXzxPAWSs8/SyamSuzkOOlERofaSdyn8RIzzblpc0JldiVjc0t71ELyOXTmCI+bJIQAICKXS3u31hIF1ibWHJBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961371; c=relaxed/simple;
	bh=QIm0h9NLC7E/SqoC9yvtlRN3pBmKqYZnA6vS14mU9gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqVKI/KFmR96tiJRcjLW4hMOtYkI7f99+DR2mqu8Hrdwv8BpMaAwu2vLPOBhl7R6uBDvI/pI8BHH8dbAS07GzU6j5isfMgos2P8/Ku7W5KoALsV8lIggT/5/Iu+6wQohlQb+fgKgVVSO0oeozs63j/8CKfTsD0tLO3WP7M2c/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfUPcfCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C80C32781;
	Fri, 21 Jun 2024 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961370;
	bh=QIm0h9NLC7E/SqoC9yvtlRN3pBmKqYZnA6vS14mU9gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfUPcfChSiO0xYEl+Jd7zrglwHmLSQzr6q3c4/E+TKK0UfTV7kq6IvvAqw+qhcPoN
	 3g5HNX5gbfxHTjj3dy6BIahFhhNIyP8I43PqnSNjUxwBsqkalkzkqV9D+GQIc52CCX
	 xa2FOTkaWWtWC5MLVAJAzot+oloWAOeEjoCI4KhbMBnpIhRz342eEf5eVYToGfaVNz
	 VCaMFhbHAUk9ZufcRHrRLbZeV2LDMBQX0djiVajisj74VtzO5Si9TRFCTb7nYVVlZt
	 JrQVSF4FzGblhTy/VJ2cFXUGxxCsqdMDs6GBoOKP4Si6oosUhQnL+nIYuVY++fxGoV
	 uj7E4LMcY0vtQ==
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
Date: Fri, 21 Jun 2024 11:15:58 +0200
Message-ID: <20240621091601.18227-2-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621091601.18227-1-frederic@kernel.org>
References: <20240621091601.18227-1-frederic@kernel.org>
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
index 71b0fc2d0aea..dd53298ef1a5 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1337,7 +1337,7 @@ static int irq_thread(void *data)
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
index 4bc3e9398ee3..ab927a142f51 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
-- 
2.45.2


