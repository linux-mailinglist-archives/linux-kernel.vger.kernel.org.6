Return-Path: <linux-kernel+bounces-569208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0DA69FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFE21895C85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D61EDA3B;
	Thu, 20 Mar 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RagyR6xx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC81EBFFF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453397; cv=none; b=EcPUn15/beG6DFL1qen4XaRylwLcs5sL1EbqItM3ZsUTraAwBYZhIbuK0mVIQ9yWgWAvzQJImiKXl1bCHusydI0+eMC/QuXsavmhVjNRByYkAw6UmIzlOOxMtTL5q5nPCuNpauP7nO7/Wi/Dk1haJiIlQhIIkiB4RjQ9vdvZMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453397; c=relaxed/simple;
	bh=a2mHZ2iJT2uh1sea/6KzfQvVbMAxtxd7XIdL94kpylM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxAcQnVOIBMoX1A0pAMqhgKJGkjCRHUvixixiUmo+YpD0jVKYwO+DGOwr2BpepqMXL39whB5G7A5oZ2vNfE+DUrItpw9aOM35gd08/vyI7uVV5jDO22ztuG1sk7+P4HLz4y9Sbrwy/iOu1YPP07457nCQkw4kZoyCPU5kjooL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RagyR6xx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso6437445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742453395; x=1743058195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTfmmcbrECq+SMoxCLy2EmU0/2NLJ8Y+ljJ0B1foO8=;
        b=RagyR6xxOrEs/WALACB5GHFpdTKPz+onQwhcy9G+mlvRiuvDcCbugfyAzgYZMuWWkx
         qBnbXrRvnV4OvmVaU5vpI3hRV3/XQIB/+55fVl+CJpsFvCLeQZ6jwsyW1W87NiWr3D2j
         xF32RLc4oQMn+b/45ByCRcbkN30JTSe/ksqV0JYfSohKldovB7p224HReMT//aiqJpI9
         nIDVdzje80SwMOgZzBrOxDaUBCSsUaeU8ZFORlEQ1msy+tDrghHan4DuIvseZP0/BHsg
         NTiuqHECWGPQgnnTL2k74JkkNHaHFZDpOMQRkQ94L3v8Q/9XIxIM30XV9v8Su2NkdkP4
         YlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453395; x=1743058195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTfmmcbrECq+SMoxCLy2EmU0/2NLJ8Y+ljJ0B1foO8=;
        b=QDFJWn3DB9nwmYc4kO2wVDighsCHO+FNS+jMv1D7O8dxywDvndVAK4xl/XhGxqwWfk
         dmSwVBGmU7v9TGADlgs7m5H9qHFKzsgWUmb3j/1SLPEOE9t1QSdgDip2R1l5BwUFvg7F
         aqMgdMlD5S4TOP62/mAracTMqQYCSVnjdKT2+sOu8x4mLbYtrdVdRZ7WEq+XFO9fiPha
         WpNAxI9DGkWKDFpxZ48wfLACQ+j/T0jHPlftmed5/PwCVFa7q0pUOvvLIU6rm9TQakzS
         yk9NUnsfAsNI9kskZ7YEWkmcPNR9+JvSBpkLNFE+swGwMYUgrDdBFi849qPbUeaj3qO5
         3oaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMcFL+URvWTBXlqP6PnO2aIXcatv5Q+WLcTo7LiWKi47NTrQL6vW8dN0KukgOTrRObwwGEUvGEPKHWcHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsDOGSnCHN/1glrmzFR2KudwXw4hryMsL8XsRuwGvvpprSvOb
	pxQSYWzj6OXgM8QA9MEmIKxTT682uMkTwZcFOQ1FhqBUJh3EecxI
X-Gm-Gg: ASbGncu13LH0D2t7OxTFkXEzHlyU/iFHqUf5zeZZMs+5rcoSOimPir4V35qr6i5p134
	dD9RuA3YLVSbOBfZ33fTwV1wwnLMwRwmOPYErPXPsNBSiPoQ8ewQz250TqzhFf28VFl3sV/Mt3q
	1pycb0ibQPLnJv8e92o4aY5TBuxMoCwBq7YwvxoAy9YDc70sibdpCHCCVXJo1BG2oglQDZnat0G
	v/cFLivKQyMbG566UBn/jIPSQ4qgdwX6890P+rZvSJcaKoENbuKGzG4UXHl7G+cDOzejad2sf5b
	+QnscRyw+m6aMcFoNJWmrudTCGNnbkAG/9P4glLpDLXk8ouppa7i
X-Google-Smtp-Source: AGHT+IHYFxD7x3BTvt6GRVnlniV7Ypq6Pf2Sbop3/K613KEv9gv26enJb9RRS/7d6c2WXKfBLgRVfQ==
X-Received: by 2002:a17:902:f603:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2265e6916dbmr41034695ad.2.1742453395214;
        Wed, 19 Mar 2025 23:49:55 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm127260155ad.13.2025.03.19.23.49.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 23:49:54 -0700 (PDT)
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
Subject: [PATCH v4 2/3] hung_task: show the blocker task if the task is hung on semaphore
Date: Thu, 20 Mar 2025 14:49:22 +0800
Message-ID: <20250320064923.24000-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320064923.24000-1-ioworker0@gmail.com>
References: <20250320064923.24000-1-ioworker0@gmail.com>
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

[Thu Mar 20 04:52:21 2025] INFO: task cat:955 blocked for more than 120 seconds.
[Thu Mar 20 04:52:21 2025]       Tainted: G            E      6.14.0-rc6+ #1
[Thu Mar 20 04:52:21 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Thu Mar 20 04:52:21 2025] task:cat             state:D stack:0     pid:955   tgid:955   ppid:917    task_flags:0x400000 flags:0x00000000
[Thu Mar 20 04:52:21 2025] Call Trace:
[Thu Mar 20 04:52:21 2025]  <TASK>
[Thu Mar 20 04:52:21 2025]  __schedule+0x491/0xbd0
[Thu Mar 20 04:52:21 2025]  schedule+0x27/0xf0
[Thu Mar 20 04:52:21 2025]  schedule_timeout+0xe3/0xf0
[Thu Mar 20 04:52:21 2025]  ? __folio_mod_stat+0x2a/0x80
[Thu Mar 20 04:52:21 2025]  ? set_ptes.constprop.0+0x27/0x90
[Thu Mar 20 04:52:21 2025]  __down_common+0x155/0x280
[Thu Mar 20 04:52:21 2025]  down+0x53/0x70
[Thu Mar 20 04:52:21 2025]  read_dummy_semaphore+0x23/0x60
[Thu Mar 20 04:52:21 2025]  full_proxy_read+0x5f/0xa0
[Thu Mar 20 04:52:21 2025]  vfs_read+0xbc/0x350
[Thu Mar 20 04:52:21 2025]  ? __count_memcg_events+0xa5/0x140
[Thu Mar 20 04:52:21 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
[Thu Mar 20 04:52:21 2025]  ? handle_mm_fault+0x180/0x260
[Thu Mar 20 04:52:21 2025]  ksys_read+0x66/0xe0
[Thu Mar 20 04:52:21 2025]  do_syscall_64+0x51/0x120
[Thu Mar 20 04:52:21 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Thu Mar 20 04:52:21 2025] RIP: 0033:0x7ff96d4ab46e
[Thu Mar 20 04:52:21 2025] RSP: 002b:00007ffe2f47f3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[Thu Mar 20 04:52:21 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ff96d4ab46e
[Thu Mar 20 04:52:21 2025] RDX: 0000000000020000 RSI: 00007ff96d39f000 RDI: 0000000000000003
[Thu Mar 20 04:52:21 2025] RBP: 00007ff96d39f000 R08: 00007ff96d39e010 R09: 0000000000000000
[Thu Mar 20 04:52:21 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
[Thu Mar 20 04:52:21 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[Thu Mar 20 04:52:21 2025]  </TASK>
[Thu Mar 20 04:52:21 2025] INFO: task cat:955 blocked on a semaphore likely last held by task cat:909
[Thu Mar 20 04:52:21 2025] task:cat             state:S stack:0     pid:909   tgid:909   ppid:771    task_flags:0x400000 flags:0x00000000
[Thu Mar 20 04:52:21 2025] Call Trace:
[Thu Mar 20 04:52:21 2025]  <TASK>
[Thu Mar 20 04:52:21 2025]  __schedule+0x491/0xbd0
[Thu Mar 20 04:52:21 2025]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[Thu Mar 20 04:52:21 2025]  schedule+0x27/0xf0
[Thu Mar 20 04:52:21 2025]  schedule_timeout+0x77/0xf0
[Thu Mar 20 04:52:21 2025]  ? __pfx_process_timeout+0x10/0x10
[Thu Mar 20 04:52:21 2025]  msleep_interruptible+0x49/0x60
[Thu Mar 20 04:52:21 2025]  read_dummy_semaphore+0x2d/0x60
[Thu Mar 20 04:52:21 2025]  full_proxy_read+0x5f/0xa0
[Thu Mar 20 04:52:21 2025]  vfs_read+0xbc/0x350
[Thu Mar 20 04:52:21 2025]  ? __count_memcg_events+0xa5/0x140
[Thu Mar 20 04:52:21 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
[Thu Mar 20 04:52:21 2025]  ? handle_mm_fault+0x180/0x260
[Thu Mar 20 04:52:21 2025]  ksys_read+0x66/0xe0
[Thu Mar 20 04:52:21 2025]  do_syscall_64+0x51/0x120
[Thu Mar 20 04:52:21 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Thu Mar 20 04:52:21 2025] RIP: 0033:0x7fe6bf7a046e
[Thu Mar 20 04:52:21 2025] RSP: 002b:00007ffd6e1a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[Thu Mar 20 04:52:21 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fe6bf7a046e
[Thu Mar 20 04:52:21 2025] RDX: 0000000000020000 RSI: 00007fe6bf694000 RDI: 0000000000000003
[Thu Mar 20 04:52:21 2025] RBP: 00007fe6bf694000 R08: 00007fe6bf693010 R09: 0000000000000000
[Thu Mar 20 04:52:21 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
[Thu Mar 20 04:52:21 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000

[1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/semaphore.h  | 15 ++++++++++-
 kernel/hung_task.c         | 52 ++++++++++++++++++++++++++++++--------
 kernel/locking/semaphore.c | 52 +++++++++++++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 18 deletions(-)

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
index 79558d76ef06..d2432df2b905 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -99,32 +99,62 @@ static struct notifier_block panic_block = {
 static void debug_show_blocker(struct task_struct *task)
 {
 	struct task_struct *g, *t;
-	unsigned long owner, blocker;
+	unsigned long owner, blocker, blocker_type;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
 
 	blocker = READ_ONCE(task->blocker);
-	if (!blocker ||
-	    hung_task_get_blocker_type(blocker) != BLOCKER_TYPE_MUTEX)
+	if (!blocker)
 		return;
 
-	owner = mutex_get_owner(
-		(struct mutex *)hung_task_blocker_to_lock(blocker));
+	blocker_type = hung_task_get_blocker_type(blocker);
+
+	switch (blocker_type) {
+	case BLOCKER_TYPE_MUTEX:
+		owner = mutex_get_owner(
+			(struct mutex *)hung_task_blocker_to_lock(blocker));
+		break;
+	case BLOCKER_TYPE_SEM:
+		owner = sem_last_holder(
+			(struct semaphore *)hung_task_blocker_to_lock(blocker));
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
 
 	if (unlikely(!owner)) {
-		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
-			task->comm, task->pid);
+		switch (blocker_type) {
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
+		switch (blocker_type) {
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


