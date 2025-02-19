Return-Path: <linux-kernel+bounces-521571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2FA3BF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F3216CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAF1E98ED;
	Wed, 19 Feb 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emwPC9J8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0651E8326
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970053; cv=none; b=RqwO7BTt3li/ID7JcCFNOVRUIDGlqKTtrcMm74stbU9b5C+0bAm5MqHgAMK3i06fVzsvSuVQtN82lbTBbvpxJA56653xDnAx8ax5Awr4hYIrNBGlfR099rIpr8mKpbGg7cPpXWkgtxrJHu54lpjM72YhLarLQFco08MDKGCkM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970053; c=relaxed/simple;
	bh=sb6Wf5NKqPEY4wAFsfQBGRH2U+v7+V075jzr4+QqN74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGR9e+r6XLR/zKbz+9yinlRdU6fDyqcGiddgdV7p6ylP0hu3VuXu7LUU2hviRKjEx21Nax76mg0zupFekQiIRXB+T81h4NBN92vN4cSmwm3l6u0wzVZZp7ZqL0KoGM1qTR6mbSa/E3QI5ho4WZCswhS65Z3AhMGZXWpblAi9Cto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emwPC9J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E6BC4CED1;
	Wed, 19 Feb 2025 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739970052;
	bh=sb6Wf5NKqPEY4wAFsfQBGRH2U+v7+V075jzr4+QqN74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emwPC9J84b5EDAVdhlCu/qnrEWrlwHqSZ845uY8rc7wTOvKfRyIC21S2OCeAGMmyj
	 uLkWNuDwWw4Rqh/KlExx4VCwxuQ0iazs6v5L+gkOByiiUG3gKVV+xXxAGV6BEakCnX
	 ZR+QJRwN1lXz7LMiw9FXtzZ619RcRWWi5DnCiAlR8dfr0Fpchlu0Rm0dIsddtVljpd
	 zFfxTkAv0eTh3BIQVHEcaUg7OpXuerkJZCn10ZNUkVUNd6Psd2sX3kxPbT+tc71/J+
	 8a/KE+9PYvCv6VvjiMrmu/fJ1oLEZYNdVeIetSIEveKDj/cYrOU4VryM/SIeadapCg
	 dRqC7Wk9Ou5Cg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Lance Yang <ioworker0@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yongliang Gao <leonylgao@tencent.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hung_task: Show the blocker task if the task is hung on mutex
Date: Wed, 19 Feb 2025 22:00:49 +0900
Message-ID:  <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To:  <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
References:  <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The "hung_task" shows a long-time uninterruptible slept task, but most
often, it's blocked on a mutex acquired by another task. Without
dumping such a task, investigating the root cause of the hung task
problem is very difficult.

Fortunately CONFIG_DEBUG_MUTEXES=y allows us to identify the mutex
blocking the task. And the mutex has "owner" information, which can
be used to find the owner task and dump it with hung tasks.

With this change, the hung task shows blocker task's info like below;

 INFO: task cat:113 blocked for more than 122 seconds.
       Not tainted 6.14.0-rc3-00002-g6afe972e1b9b #152
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cat             state:D stack:13432 pid:113   tgid:113   ppid:103    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_preempt_disabled+0x54/0xa0
  schedule+0xb7/0x140
  ? __mutex_lock+0x51d/0xa50
  ? __mutex_lock+0x51d/0xa50
  schedule_preempt_disabled+0x54/0xa0
  __mutex_lock+0x51d/0xa50
  ? current_time+0x3a/0x120
  read_dummy+0x23/0x70
  full_proxy_read+0x6a/0xc0
  vfs_read+0xc2/0x340
  ? __pfx_direct_file_splice_eof+0x10/0x10
  ? do_sendfile+0x1bd/0x2e0
  ksys_read+0x76/0xe0
  do_syscall_64+0xe3/0x1c0
  ? exc_page_fault+0xa9/0x1d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4840cd
 RSP: 002b:00007ffe632b76c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe632b7710 RDI: 0000000000000003
 RBP: 00007ffe632b7710 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 000000003a8b63a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>
 INFO: task cat:113 is blocked on a mutex owned by task cat:112.
 task:cat             state:S stack:13432 pid:112   tgid:112   ppid:103    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_timeout+0xa8/0x120
  schedule+0xb7/0x140
  schedule_timeout+0xa8/0x120
  ? __pfx_process_timeout+0x10/0x10
  msleep_interruptible+0x3e/0x60
  read_dummy+0x2d/0x70
  full_proxy_read+0x6a/0xc0
  vfs_read+0xc2/0x340
  ? __pfx_direct_file_splice_eof+0x10/0x10
  ? do_sendfile+0x1bd/0x2e0
  ksys_read+0x76/0xe0
  do_syscall_64+0xe3/0x1c0
  ? exc_page_fault+0xa9/0x1d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4840cd
 RSP: 002b:00007ffd69513748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffd69513790 RDI: 0000000000000003
 RBP: 00007ffd69513790 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 0000000029d8d3a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/hung_task.c           |   38 ++++++++++++++++++++++++++++++++++++++
 kernel/locking/mutex-debug.c |    1 +
 kernel/locking/mutex.c       |    9 +++++++++
 kernel/locking/mutex.h       |    6 ++++++
 4 files changed, 54 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 04efa7a6e69b..d1ce69504090 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -25,6 +25,8 @@
 
 #include <trace/events/sched.h>
 
+#include "locking/mutex.h"
+
 /*
  * The number of tasks checked:
  */
@@ -93,6 +95,41 @@ static struct notifier_block panic_block = {
 	.notifier_call = hung_task_panic,
 };
 
+
+#ifdef CONFIG_DEBUG_MUTEXES
+static void debug_show_blocker(struct task_struct *task)
+{
+	struct task_struct *g, *t;
+	unsigned long owner;
+	struct mutex *lock;
+
+	if (!task->blocked_on)
+		return;
+
+	lock = task->blocked_on->mutex;
+	if (unlikely(!lock)) {
+		pr_err("INFO: task %s:%d is blocked on a mutex, but the mutex is not found.\n",
+			task->comm, task->pid);
+		return;
+	}
+	owner = debug_mutex_get_owner(lock);
+	if (likely(owner)) {
+		/* Ensure the owner information is correct. */
+		for_each_process_thread(g, t)
+			if ((unsigned long)t == owner) {
+				pr_err("INFO: task %s:%d is blocked on a mutex owned by task %s:%d.\n",
+					task->comm, task->pid, t->comm, t->pid);
+				sched_show_task(t);
+				return;
+			}
+	}
+	pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
+		task->comm, task->pid);
+}
+#else
+#define debug_show_blocker(t)	do {} while (0)
+#endif
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -152,6 +189,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
+		debug_show_blocker(t);
 		hung_task_show_lock = true;
 
 		if (sysctl_hung_task_all_cpu_backtrace)
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 6e6f6071cfa2..94282c760cee 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -30,6 +30,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
+	waiter->mutex = lock;
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->ww_ctx = MUTEX_POISON_WW_CTX;
 }
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b36f23de48f1..db093cc0a220 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -72,6 +72,15 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
 }
 
+#ifdef CONFIG_DEBUG_MUTEXES
+/* Do not use the return value as a pointer directly. */
+unsigned long debug_mutex_get_owner(struct mutex *lock)
+{
+	unsigned long owner = atomic_long_read(&lock->owner);
+
+	return (unsigned long)__owner_task(owner);
+}
+#endif
 /*
  * Returns: __mutex_owner(lock) on failure or NULL on success.
  */
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index cbff35b9b7ae..0d884e6b3a66 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -16,6 +16,7 @@ struct mutex_waiter {
 	struct task_struct	*task;
 	struct ww_acquire_ctx	*ww_ctx;
 #ifdef CONFIG_DEBUG_MUTEXES
+	struct mutex		*mutex;
 	void			*magic;
 #endif
 };
@@ -61,6 +62,7 @@ extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *w
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
 			     struct lock_class_key *key);
+extern unsigned long debug_mutex_get_owner(struct mutex *lock);
 #else /* CONFIG_DEBUG_MUTEXES */
 # define debug_mutex_lock_common(lock, waiter)		do { } while (0)
 # define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
@@ -69,4 +71,8 @@ extern void debug_mutex_init(struct mutex *lock, const char *name,
 # define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_unlock(lock)			do { } while (0)
 # define debug_mutex_init(lock, name, key)		do { } while (0)
+static inline unsigned long debug_mutex_get_owner(struct mutex *lock)
+{
+	return 0;
+}
 #endif /* !CONFIG_DEBUG_MUTEXES */


