Return-Path: <linux-kernel+bounces-567469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A209EA68670
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615E87A452B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE05250BFD;
	Wed, 19 Mar 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbLwGeM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8041250C1E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371925; cv=none; b=iVbgHXAjCpIRCeYoDv16VI1y+3KlzxXaTvgxbhDWrUR+meVA1kXTUoQ9g6CSZ7oxHIr82YH/gDdKAhC9YcAc38A3ybiQScge5IzR/Gmcps0FLR1c6ubniVzvlFjIT97zS+KkMY6htuazRKXdZfLExlrvZnTcOOoWVY7XNsEjfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371925; c=relaxed/simple;
	bh=0pg96570/DWQ9kK+1kWvJx26/2gCXEfjQRFN6c++RlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmAKnC+8wJx7Ziq1Fm92eBpcJk1E11YSODRazsWNckwv9vvh91GeyXD1bPoDAFoaJuAdfvIXxJ2Q6FfFLK1ZcYfLxW6po7+dbfv/yAp+W2hKkfI1aTnE1QaNQi4ICD+dJ6GesoRwcw08siQIji3A4xiCB36h6iQX68lZWDwQi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWbLwGeM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso110672735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371923; x=1742976723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp+093aAsh+QnWxtzdVtL38jzib+ORy5VJVUCZ4KHO4=;
        b=XWbLwGeMRNzmp67x1FsjOMtDDv1l2MMXySGFZsyLsBVL7ob4Rv6ysvCC7ETfWxgrzL
         G6Wxu3ppbnSbI44LB48e2/c0K2+3MRppDLIiQ4+Wy5v2tVhlNgqOgouLZh1yG7Hdywsj
         Il5ooniImeDaXzVWhkAENDYrwVtSJ0lo5tYWouywP+dhDxQKTD+b/vn10R3OLkJ2Sg/U
         FQBMh9PYRIvCNSf6nz4ebK2fBvoLE4GvQRF+u5hL8laiESY2qL/LHytrAS3gxPHNjgle
         BzRPwMESqqQ1i7eTlBR1ETsh6lTmyZlQ44V8+cFBgqb7gFcvZPnbOMjKE3KcJTkC34Ze
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371923; x=1742976723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp+093aAsh+QnWxtzdVtL38jzib+ORy5VJVUCZ4KHO4=;
        b=FmG53XeSXJxSe5MvtZeB0Gf/E73FdshRHQzDo9cZbX5L5Xnd8k/gn4BRGyFzYrqwwb
         JYxu9vtUKruMiv/ySW5Vw/YhVNPd8dgO2bGdaidzJqDPFnhtdvLXjITClgiYmFqkgl/E
         javoa/lFotHbb+72/JwmO6YepLwWrgP6zxESEOBznwSafPFw1ZdPNV1vU2FNSUTfse+v
         lWOiSrbqUZIT1DWlijvOfY/H4+tn8XSbL2qs/pMv9xII9TLL/vQ5m2oCT/98Uwuf+HXN
         tbOhEXtvTVxuhRC679vpcEnXf/E87+eVUTjLvHWMivzS+UO4PcTR7DDD8AXeQQpqVsfz
         gEng==
X-Forwarded-Encrypted: i=1; AJvYcCXoOtrTUVxy58dd0Y6rQbTMki3asptFJKl6LK9zUTFIDLwZmaWT4KucmzuQo+CYNt9fL/sWIfVgvF+NLjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV08fRtWVQTbOH1WXglCeHvYNduNjnij0syyxocDRdB8ZlWi5E
	3GNWgxpsOG4lyzqeQRV/h/DubtpzVdu/1ByjZoggQDprm4XgCneK
X-Gm-Gg: ASbGnctFoKqaKiWFaZCw4bEuhkV7Zbi/aAR209aAp2d1DqXTAGgI867EHzbKBg5Io59
	IgfaRdDR+AtJMPo6mfU4lSyDVVKHq6qqVwhjU3Q5sDiPkDSyzlRnoYpFbqJz13AaE0sJ/WRV9Go
	+5+65p7EM1fzt7XTz/z3JyhBgMsQ6eT9HtqOOwanzKnO9wKWxA9dGg7VzoJYpwPMvhIh07eYpG9
	aw/+2PGJlQwEXH3M+8dV5wxTGGctwf3N478QI3pKf3TxssPLYoIDa882Ts665gZxFLmTBnY66r+
	K3LxtmTjWDF4WOr6aMmXNaxvvwebcn/GELiNPvpBoxUwCY+GRxTKzAsITG1q
X-Google-Smtp-Source: AGHT+IEfDltqdvsqVwR/CE9OmPlEgqRDSaVaVajo4J0oD0Y3tgEY9RZJchwdADkhN1tyvLKc/mRXEQ==
X-Received: by 2002:a17:902:e84a:b0:224:fa0:36d2 with SMTP id d9443c01a7336-226499389c3mr24211705ad.26.1742371923078;
        Wed, 19 Mar 2025 01:12:03 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887bfsm108059455ad.34.2025.03.19.01.11.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 01:12:02 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	longman@redhat.com,
	mhiramat@kernel.org,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	joel.granados@kernel.org,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	amaindex@outlook.com,
	jstultz@google.com,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v3 2/3] hung_task: show the blocker task if the task is hung on semaphore
Date: Wed, 19 Mar 2025 16:11:37 +0800
Message-ID: <20250319081138.25133-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319081138.25133-1-ioworker0@gmail.com>
References: <20250319081138.25133-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspired by mutex blocker tracking[1], this patch makes a trade-off to
balance the overhead and utility of the hung task detector.

Unlike mutexes, semaphores lack explicit ownership tracking, making it
challenging to identify the root cause of hangs. To address this, we
introduce a last_holder field to the semaphore structure, which is
updated when a task successfully calls down() and cleared during up().

The assumption is that if a task is blocked on a semaphore, the holders
must not have released it. While this does not guarantee that the last
holder is one of the current blockers, it likely provides a practical hint
for diagnosing semaphore-related stalls.

With this change, the hung task detector can now show blocker task's info
like below:

[Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked for more than 122 seconds.
[Thu Mar 13 15:18:38 2025]       Tainted: G           OE      6.14.0-rc3+ #14
[Thu Mar 13 15:18:38 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Mar 13 15:18:38 2025] task:cat             state:D stack:0     pid:1803  tgid:1803  ppid:1057   task_flags:0x400000 flags:0x00000004
[Thu Mar 13 15:18:38 2025] Call trace:
[Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
[Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
[Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
[Thu Mar 13 15:18:38 2025]  schedule_timeout+0x1d0/0x208
[Thu Mar 13 15:18:38 2025]  __down_common+0x2d4/0x6f8
[Thu Mar 13 15:18:38 2025]  __down+0x24/0x50
[Thu Mar 13 15:18:38 2025]  down+0xd0/0x140
[Thu Mar 13 15:18:38 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
[Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
[Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
[Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
[Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
[Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
[Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
[Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
[Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
[Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
[Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
[Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked on a semaphore likely last held by task cat:1802
[Thu Mar 13 15:18:38 2025] task:cat             state:S stack:0     pid:1802  tgid:1802  ppid:1057   task_flags:0x400000 flags:0x00000004
[Thu Mar 13 15:18:38 2025] Call trace:
[Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
[Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
[Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
[Thu Mar 13 15:18:38 2025]  schedule_timeout+0xf4/0x208
[Thu Mar 13 15:18:38 2025]  msleep_interruptible+0x70/0x130
[Thu Mar 13 15:18:38 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
[Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
[Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
[Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
[Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
[Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
[Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
[Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
[Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
[Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
[Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0

[1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/semaphore.h  | 15 ++++++++++-
 kernel/hung_task.c         | 45 +++++++++++++++++++++++++--------
 kernel/locking/semaphore.c | 52 +++++++++++++++++++++++++++++++++-----
 3 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 04655faadc2d..89706157e622 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -16,13 +16,25 @@ struct semaphore {
 	raw_spinlock_t		lock;
 	unsigned int		count;
 	struct list_head	wait_list;
+
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	unsigned long		last_holder;
+#endif
 };
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+#define __LAST_HOLDER_SEMAPHORE_INITIALIZER				\
+	, .last_holder = 0UL
+#else
+#define __LAST_HOLDER_SEMAPHORE_INITIALIZER
+#endif
+
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.lock		= __RAW_SPIN_LOCK_UNLOCKED((name).lock),	\
 	.count		= n,						\
-	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
+	.wait_list	= LIST_HEAD_INIT((name).wait_list)		\
+	__LAST_HOLDER_SEMAPHORE_INITIALIZER				\
 }
 
 /*
@@ -47,5 +59,6 @@ extern int __must_check down_killable(struct semaphore *sem);
 extern int __must_check down_trylock(struct semaphore *sem);
 extern int __must_check down_timeout(struct semaphore *sem, long jiffies);
 extern void up(struct semaphore *sem);
+extern unsigned long sem_last_holder(struct semaphore *sem);
 
 #endif /* __LINUX_SEMAPHORE_H */
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 75dc1048f2c1..1403e71df039 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -99,31 +99,56 @@ static struct notifier_block panic_block = {
 static void debug_show_blocker(struct task_struct *task)
 {
 	struct task_struct *g, *t;
-	unsigned long owner, blocker;
+	unsigned long owner, blocker, blocker_lock_type;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
 
 	blocker = READ_ONCE(task->blocker);
-	if (!blocker || !hung_task_blocker_is_type(blocker, BLOCKER_TYPE_MUTEX))
+	if (!blocker)
 		return;
 
-	owner = mutex_get_owner(
-		(struct mutex *)hung_task_blocker_to_lock(blocker));
+	if (hung_task_blocker_is_type(blocker, BLOCKER_TYPE_MUTEX)) {
+		owner = mutex_get_owner(
+			(struct mutex *)hung_task_blocker_to_lock(blocker));
+		blocker_lock_type = BLOCKER_TYPE_MUTEX;
+	} else if (hung_task_blocker_is_type(blocker, BLOCKER_TYPE_SEM)) {
+		owner = sem_last_holder(
+			(struct semaphore *)hung_task_blocker_to_lock(blocker));
+		blocker_lock_type = BLOCKER_TYPE_SEM;
+	} else
+		return;
 
 	if (unlikely(!owner)) {
-		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
-			task->comm, task->pid);
+		switch (blocker_lock_type) {
+		case BLOCKER_TYPE_MUTEX:
+			pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
+			       task->comm, task->pid);
+			break;
+		case BLOCKER_TYPE_SEM:
+			pr_err("INFO: task %s:%d is blocked on a semaphore, but the last holder is not found.\n",
+			       task->comm, task->pid);
+			break;
+		}
 		return;
 	}
 
 	/* Ensure the owner information is correct. */
 	for_each_process_thread(g, t) {
-		if ((unsigned long)t == owner) {
+		if ((unsigned long)t != owner)
+			continue;
+
+		switch (blocker_lock_type) {
+		case BLOCKER_TYPE_MUTEX:
 			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
-				task->comm, task->pid, t->comm, t->pid);
-			sched_show_task(t);
-			return;
+			       task->comm, task->pid, t->comm, t->pid);
+			break;
+		case BLOCKER_TYPE_SEM:
+			pr_err("INFO: task %s:%d blocked on a semaphore likely last held by task %s:%d\n",
+			       task->comm, task->pid, t->comm, t->pid);
+			break;
 		}
+		sched_show_task(t);
+		return;
 	}
 }
 #else
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae72f295..3d06d4adc05b 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,12 +33,14 @@
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
 #include <trace/events/lock.h>
+#include <linux/hung_task.h>
 
 static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
 static noinline void __up(struct semaphore *sem);
+static inline void __sem_acquire(struct semaphore *sem);
 
 /**
  * down - acquire the semaphore
@@ -58,7 +60,7 @@ void __sched down(struct semaphore *sem)
 	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
-		sem->count--;
+		__sem_acquire(sem);
 	else
 		__down(sem);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
@@ -82,7 +84,7 @@ int __sched down_interruptible(struct semaphore *sem)
 	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
-		sem->count--;
+		__sem_acquire(sem);
 	else
 		result = __down_interruptible(sem);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
@@ -109,7 +111,7 @@ int __sched down_killable(struct semaphore *sem)
 	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
-		sem->count--;
+		__sem_acquire(sem);
 	else
 		result = __down_killable(sem);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
@@ -139,7 +141,7 @@ int __sched down_trylock(struct semaphore *sem)
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	count = sem->count - 1;
 	if (likely(count >= 0))
-		sem->count = count;
+		__sem_acquire(sem);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
 
 	return (count < 0);
@@ -164,7 +166,7 @@ int __sched down_timeout(struct semaphore *sem, long timeout)
 	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
-		sem->count--;
+		__sem_acquire(sem);
 	else
 		result = __down_timeout(sem, timeout);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
@@ -185,6 +187,12 @@ void __sched up(struct semaphore *sem)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
+
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	if (READ_ONCE(sem->last_holder) == (unsigned long)current)
+		WRITE_ONCE(sem->last_holder, 0UL);
+#endif
+
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
@@ -224,8 +232,12 @@ static inline int __sched ___down_common(struct semaphore *sem, long state,
 		raw_spin_unlock_irq(&sem->lock);
 		timeout = schedule_timeout(timeout);
 		raw_spin_lock_irq(&sem->lock);
-		if (waiter.up)
+		if (waiter.up) {
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+			WRITE_ONCE(sem->last_holder, (unsigned long)current);
+#endif
 			return 0;
+		}
 	}
 
  timed_out:
@@ -242,10 +254,18 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 {
 	int ret;
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	hung_task_set_blocker(sem, BLOCKER_TYPE_SEM);
+#endif
+
 	trace_contention_begin(sem, 0);
 	ret = ___down_common(sem, state, timeout);
 	trace_contention_end(sem, ret);
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	hung_task_clear_blocker();
+#endif
+
 	return ret;
 }
 
@@ -277,3 +297,23 @@ static noinline void __sched __up(struct semaphore *sem)
 	waiter->up = true;
 	wake_up_process(waiter->task);
 }
+
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+unsigned long sem_last_holder(struct semaphore *sem)
+{
+	return READ_ONCE(sem->last_holder);
+}
+#else
+unsigned long sem_last_holder(struct semaphore *sem)
+{
+	return 0UL;
+}
+#endif
+
+static inline void __sem_acquire(struct semaphore *sem)
+{
+	sem->count--;
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+	WRITE_ONCE(sem->last_holder, (unsigned long)current);
+#endif
+}
-- 
2.45.2


