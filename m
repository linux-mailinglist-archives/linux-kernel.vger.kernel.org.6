Return-Path: <linux-kernel+bounces-567468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E812DA6866F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FACF7A40F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757192505A6;
	Wed, 19 Mar 2025 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6OPNCOM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1A250C05
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371920; cv=none; b=PtHBbjMZyClvixVFeYl0UZXqNK0CW267Y006eKvqms2NrKa3bBg7kFTMQl9o2l/2eJjVfOXkigDPSdhGwd/GEuKla81Xp68i5jaa8cyyZmxRbwmsi6VH3r2SpJye0lAK6zuApveGqSxvTpkiW5S25+myuudX/zFWHe7r4+ZsWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371920; c=relaxed/simple;
	bh=4EhUfCVQUxR5J7gqv/boEpWQ3MGl/dt+SCdq02OsOyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj2Bpg31/Js3/ddm6Umo0wxbhKmt8Jb7CINLZrIs1CXQglbNwdAlkCWR5E4Nl9CiFTm5o1T1LFWFWAzYDDtCWrHBovyuiDm5SRE1VrX/w+mVcg4dWXo6A6BQ4kU7VLrmN2AMV1GJyxAYN2wLy57dbeSFA/8FY/9sL6rO+RHz/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6OPNCOM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so115158335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371918; x=1742976718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZlFDlSF7AqvF57mjv5vrSlNteUTqwoDL2WmwvhirRE=;
        b=O6OPNCOMbFZBEhLrUxCSCCKP2Bdkar/jWYs+9jllqGfLbi1S2yKF37QPrbaCKNw4Xz
         BZJLulyiZ5YtEWq1Iq5in6NkI6vTMEFEe6kzeh8TeVFZ9En0+LulzyEJFFFRl91ppwOa
         oNcY0y7SQmPT/YKlv54PmoOQ3R3LsV1FMm52LcxBDUQv5ls3fb/QAam5mGNl9QwpX9y9
         JbD7A1BxljZOvIVjrPaudqTXldOSVZ1q37jeJ0xA/2zKNOv8TVPEU9gwRLUB5VpIXfar
         dJuwvdkuOIYY5RWPXkHV3uWi+n4fnpQ55W5qyy5vQYo+D5u0Jumq/zdReviigxv8LpMx
         SqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371918; x=1742976718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZlFDlSF7AqvF57mjv5vrSlNteUTqwoDL2WmwvhirRE=;
        b=PO7a7gV8HwkC95jtf7iHZXjVkEH4Wu6xE8arx/6DJdQWK7l0DZrLEcryOc7lHqUmqg
         NPeUR0lfCMc6pdtBDdGITGeFWyXx7ABFExED8ZeiqGr3u/V4HREqtPIkm9y70LqWqMbO
         UlG25Fc3z81DBI+aSozb4jBvFcPmA9bE6kPmRgWcKK+SSbXNnVBb0z+bj/n3sFGvS4D0
         rPTLWuqQeAZEudEDnlwf2MdfjEsa+IulsWwlec7D/mC7F9MCtiFLWSiKfxKGsDsRhGWf
         TcGYiPjqex7GvOJf+AEYcjniuIv9e9ZP+cvI5obbiqhOgO346bKY0N43eomZUR+igqWA
         Vi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIDnIKJGnsZ+vd8xOKc7nuAeB2xw47zME3qqmxddHxIcXPvyrujBamctSqx2gK3f4FTP7jV9nO50wmdkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFC/zQ0QPj+s0x62XQItndoR6DVTvhOs6b4ASeST5L5J2AhV/g
	dTf+m0FtanOLGHFPfkapFJygxaVoAdJJzjRqWKzJOnPH5lowHecV
X-Gm-Gg: ASbGncuV0gKUp47TgG6hqtxVmzIODLcewXnIsc/hOyqNnzKSvCmHMof3SaQ2SjHc2uR
	D+23S0jUcG1qdo3SwrDSiKyq+aFHW13hbxbV9kzZ+U1OCgIEpmnB6txEREEHxl/8fuivBKQEtCq
	IHs+KtNRO+EE3cAUHMkmNr3alTJkEcDL05BDxBO9BW7MiC2tLLxLxYfxQZneczZ+x6rq/EGJmPa
	+jVe4zVRDFWOXyVSdCrUFnX2dDH5+YZVtgRSknDP0U5VObZAmLeoS7XCy9qZGhUTXgBHOdGKGE6
	3hdeDjFGpFnbMfFy+pYyQ1v5Omn1gR5Fg83Lw0dhO6UzKGNphQ==
X-Google-Smtp-Source: AGHT+IFLeir0kUG1XyDANghNlfpfVcyJRyygUh5d0Ei/zdJYbncofCJGaKBymSabp6bdQAU5C77NvQ==
X-Received: by 2002:a17:902:e80d:b0:224:26f2:97d7 with SMTP id d9443c01a7336-2264980c676mr22793935ad.8.1742371918389;
        Wed, 19 Mar 2025 01:11:58 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887bfsm108059455ad.34.2025.03.19.01.11.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 01:11:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] hung_task: replace blocker_mutex with encoded blocker
Date: Wed, 19 Mar 2025 16:11:36 +0800
Message-ID: <20250319081138.25133-2-ioworker0@gmail.com>
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

This patch replaces 'struct mutex *blocker_mutex' with 'unsigned long
blocker', as only one blocker is active at a time.

The blocker filed can store both the lock addrees and the lock type, with
LSB used to encode the type as Masami suggested, making it easier to extend
the feature to cover other types of locks.

Also, once the lock type is determined, we can directly extract the address
and cast it to a lock pointer ;)

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/hung_task.h | 93 +++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |  2 +-
 kernel/hung_task.c        | 12 ++---
 kernel/locking/mutex.c    |  5 ++-
 4 files changed, 104 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/hung_task.h

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
new file mode 100644
index 000000000000..c772bca6775b
--- /dev/null
+++ b/include/linux/hung_task.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Detect Hung Task: detecting tasks stuck in D state
+ *
+ * Copyright (C) 2025 Tongcheng Travel (www.ly.com)
+ * Author: Lance Yang <mingzhe.yang@ly.com>
+ */
+#ifndef __LINUX_HUNG_TASK_H
+#define __LINUX_HUNG_TASK_H
+
+#include <linux/bug.h>
+#include <linux/sched.h>
+#include <linux/compiler.h>
+
+/*
+ * @blocker: Combines lock address and blocking type.
+ *
+ * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
+ * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
+ * always zero. So we can use these bits to encode the specific blocking
+ * type.
+ *
+ * Type encoding:
+ * 00 - Blocked on mutex        (BLOCKER_TYPE_MUTEX)
+ * 01 - Blocked on semaphore    (BLOCKER_TYPE_SEM)
+ * 10 - Blocked on rt-mutex     (BLOCKER_TYPE_RTMUTEX)
+ * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
+ */
+#define BLOCKER_TYPE_MUTEX      0x00UL
+#define BLOCKER_TYPE_SEM        0x01UL
+#define BLOCKER_TYPE_RTMUTEX    0x02UL
+#define BLOCKER_TYPE_RWSEM      0x03UL
+
+#define BLOCKER_TYPE_MASK       0x03UL
+
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+static inline void hung_task_set_blocker(void *lock, unsigned long type)
+{
+	unsigned long lock_ptr = (unsigned long)lock;
+
+	WARN_ON_ONCE(!lock_ptr);
+	WARN_ON_ONCE(READ_ONCE(current->blocker));
+
+	/*
+	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
+	 * without writing anything.
+	 */
+	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
+		return;
+
+	WRITE_ONCE(current->blocker, lock_ptr | type);
+}
+
+static inline void hung_task_clear_blocker(void)
+{
+	WARN_ON_ONCE(!READ_ONCE(current->blocker));
+
+	WRITE_ONCE(current->blocker, 0UL);
+}
+
+static inline bool hung_task_blocker_is_type(unsigned long blocker,
+					  unsigned long type)
+{
+	WARN_ON_ONCE(!blocker);
+
+	return (blocker & BLOCKER_TYPE_MASK) == type;
+}
+
+static inline void *hung_task_blocker_to_lock(unsigned long blocker)
+{
+	WARN_ON_ONCE(!blocker);
+
+	return (void *)(blocker & ~BLOCKER_TYPE_MASK);
+}
+#else
+static inline void hung_task_set_blocker(void *lock, unsigned long type)
+{
+}
+static inline void hung_task_clear_blocker(void)
+{
+}
+static inline bool hung_task_blocker_is_type(unsigned long blocker,
+					     unsigned long type)
+{
+	return false;
+}
+static inline void *hung_task_blocker_to_lock(unsigned long blocker)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __LINUX_HUNG_TASK_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1419d94c8e87..f27060dac499 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1218,7 +1218,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-	struct mutex			*blocker_mutex;
+	unsigned long			blocker;
 #endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index dc898ec93463..75dc1048f2c1 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -22,6 +22,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
+#include <linux/hung_task.h>
 
 #include <trace/events/sched.h>
 
@@ -98,16 +99,17 @@ static struct notifier_block panic_block = {
 static void debug_show_blocker(struct task_struct *task)
 {
 	struct task_struct *g, *t;
-	unsigned long owner;
-	struct mutex *lock;
+	unsigned long owner, blocker;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
 
-	lock = READ_ONCE(task->blocker_mutex);
-	if (!lock)
+	blocker = READ_ONCE(task->blocker);
+	if (!blocker || !hung_task_blocker_is_type(blocker, BLOCKER_TYPE_MUTEX))
 		return;
 
-	owner = mutex_get_owner(lock);
+	owner = mutex_get_owner(
+		(struct mutex *)hung_task_blocker_to_lock(blocker));
+
 	if (unlikely(!owner)) {
 		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
 			task->comm, task->pid);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6a543c204a14..e9ef70a6cb5f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
+#include <linux/hung_task.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
@@ -189,7 +190,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-	WRITE_ONCE(current->blocker_mutex, lock);
+	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
 #endif
 	debug_mutex_add_waiter(lock, waiter, current);
 
@@ -207,7 +208,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 
 	debug_mutex_remove_waiter(lock, waiter, current);
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-	WRITE_ONCE(current->blocker_mutex, NULL);
+	hung_task_clear_blocker();
 #endif
 }
 
-- 
2.45.2


