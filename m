Return-Path: <linux-kernel+bounces-526910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE9A40507
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F62A862E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972D78F30;
	Sat, 22 Feb 2025 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKu3aaGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2097250EC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189835; cv=none; b=mZ3ITaE74tYY3Pqx32+t+k11H1+voG2qNkgXHJEl6X9NDajzi0Yn6Gzwxla83k96S1rE+T2OMTLEbXfdUv8gqvLgcUbeEHN0zZpw1/OP5NgtyKgu2oWADRk14LIicBFYdCZPO+0xVZFsirQfAFMHZ2u2j7FRXqPAdYv8WlgxKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189835; c=relaxed/simple;
	bh=gpcodVpHeAZ+ueIVKoHvp/Xk9EgU356TD/teySJNH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+JCdfYKU4YDC5QBcd0oCvBzWs6D4hkjmTPMHeKe2SUe06O9R+4hNZoLkbPf5FfB0ijF3sisLOPR3yk6Vq5X3nE0iNRN0Jhvhpf9Q6+SzoVRBjbYV12pXxTIaOoEZfLLnRpIqTIXVpBJFbmdLYGtde63CdQD1HuK+r2c78tuLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKu3aaGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89563C4CED6;
	Sat, 22 Feb 2025 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740189834;
	bh=gpcodVpHeAZ+ueIVKoHvp/Xk9EgU356TD/teySJNH8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKu3aaGN8ea0hqCi4xJkr2Q4R20JDkp7OdsMHGSxlDJMT6D6gV2G2ekN3z6sPIRce
	 0rQPrTTPNU4svPHKeq5YrLfj4qS8zD15JiH3qALqMwFn27QNw18PDuiahVIYxmBsV1
	 uk5GcwRPqDWIkA04p5JRkWdvLcKlRWmHWm3nCrIM9Rs4Lp+oDaEyoupxX2FYV5rg/P
	 mq1XZGU0DQs69dAphx03AaIdmXtA750W8ypXgkUSUnSWAjknH6GTkNM0SDwqaF4rxF
	 ehW9XDMqP9jpe+K9c9oym6M4B4z9CNcTzpZc2vyDk43A1fF97icTPyjareRtiblzIA
	 x1UyTP9p995zw==
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
Subject: [PATCH v3 1/2] hung_task: Show the blocker task if the task is hung on mutex
Date: Sat, 22 Feb 2025 11:03:51 +0900
Message-ID:  <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
References:  <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
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

This introduce task_struct::blocker_mutex to point the mutex lock
which this task is waiting for. Since the mutex has "owner"
information, we can find the owner task and dump it with hung tasks.

Note: the owner can be changed while dumping the owner task, so
this is "likely" the owner of the mutex.

With this change, the hung task shows blocker task's info like below;

 INFO: task cat:115 blocked for more than 122 seconds.
       Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_preempt_disabled+0x54/0xa0
  schedule+0xb7/0x140
  ? __mutex_lock+0x51b/0xa60
  ? __mutex_lock+0x51b/0xa60
  schedule_preempt_disabled+0x54/0xa0
  __mutex_lock+0x51b/0xa60
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
 RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
 RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>
 INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
 task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
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
 RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
 RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add RCU_LOCKDEP_WARN() to ensure rcu_read_lock() is held.
  - Cleanup code to make it fail-fast and add brace to
    for_each_process_thread().
  - Change the message to "likely owned" instead of "owned".
 Changes in v2:
  - Introduce CONFIG_DETECT_HUNG_TASK_BLOCKER for this feature.
  - Introduce task_struct::blocker_mutex to point the mutex.
  - Rename debug_mutex_get_owner() to mutex_get_owner().
  - Remove unneeded mutex_waiter::mutex.
---
 include/linux/mutex.h  |    2 ++
 include/linux/sched.h  |    4 ++++
 kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
 kernel/locking/mutex.c |   14 ++++++++++++++
 lib/Kconfig.debug      |   10 ++++++++++
 5 files changed, 66 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2bf91b57591b..2143d05116be 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -202,4 +202,6 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
+extern unsigned long mutex_get_owner(struct mutex *lock);
+
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..0cebdd736d44 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1217,6 +1217,10 @@ struct task_struct {
 	struct mutex_waiter		*blocked_on;
 #endif
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	struct mutex			*blocker_mutex;
+#endif
+
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
 #endif
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 04efa7a6e69b..ccd7217fcec1 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -93,6 +93,41 @@ static struct notifier_block panic_block = {
 	.notifier_call = hung_task_panic,
 };
 
+
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+static void debug_show_blocker(struct task_struct *task)
+{
+	struct task_struct *g, *t;
+	unsigned long owner;
+	struct mutex *lock;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
+
+	lock = READ_ONCE(task->blocker_mutex);
+	if (!lock)
+		return;
+
+	owner = mutex_get_owner(lock);
+	if (unlikely(!owner)) {
+		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
+			task->comm, task->pid);
+		return;
+	}
+
+	/* Ensure the owner information is correct. */
+	for_each_process_thread(g, t) {
+		if ((unsigned long)t == owner) {
+			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
+				task->comm, task->pid, t->comm, t->pid);
+			sched_show_task(t);
+			return;
+		}
+	}
+}
+#else
+#define debug_show_blocker(t)	do {} while (0)
+#endif
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -152,6 +187,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
+		debug_show_blocker(t);
 		hung_task_show_lock = true;
 
 		if (sysctl_hung_task_all_cpu_backtrace)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b36f23de48f1..6a543c204a14 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -72,6 +72,14 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
 }
 
+/* Do not use the return value as a pointer directly. */
+unsigned long mutex_get_owner(struct mutex *lock)
+{
+	unsigned long owner = atomic_long_read(&lock->owner);
+
+	return (unsigned long)__owner_task(owner);
+}
+
 /*
  * Returns: __mutex_owner(lock) on failure or NULL on success.
  */
@@ -180,6 +188,9 @@ static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	WRITE_ONCE(current->blocker_mutex, lock);
+#endif
 	debug_mutex_add_waiter(lock, waiter, current);
 
 	list_add_tail(&waiter->list, list);
@@ -195,6 +206,9 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
 
 	debug_mutex_remove_waiter(lock, waiter, current);
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	WRITE_ONCE(current->blocker_mutex, NULL);
+#endif
 }
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..91dfd8c10fbb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1260,6 +1260,16 @@ config BOOTPARAM_HUNG_TASK_PANIC
 
 	  Say N if unsure.
 
+config DETECT_HUNG_TASK_BLOCKER
+	bool "Dump Hung Tasks Blocker"
+	depends on DETECT_HUNG_TASK
+	default y
+	help
+	  Say Y here to show the blocker task's stacktrace who acquires
+	  the mutex lock which "hung tasks" are waiting.
+	  This will add overhead a bit but shows suspicious tasks and
+	  call trace if it comes from waiting a mutex.
+
 config WQ_WATCHDOG
 	bool "Detect Workqueue Stalls"
 	depends on DEBUG_KERNEL


