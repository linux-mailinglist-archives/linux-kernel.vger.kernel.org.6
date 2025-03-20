Return-Path: <linux-kernel+bounces-569207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A2A69FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EAE1895CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D01EF388;
	Thu, 20 Mar 2025 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co3y5Ypd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FC1EF0BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453391; cv=none; b=nEHl+NlQVh/qNx9WQm40kX9EQWku1jiQvyWikpOqxHM0SpWqJs21g0BHvxvgGCcSjczXobZnWEi+YWZYN51yEg1veHX39WpqbzCJ0ovDwqE7pvbxcOExAOY9xIqwvHDEBpWj1gVFgBh8mDMkv7Pp6dq1aSFkH2+J9GcDsbQtM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453391; c=relaxed/simple;
	bh=Q3B4ztC5UfKKbD8pZjDo1mFpMDP6UCdo0zeWuFAosUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbVKYb74w8zQAnt/8NnDQNqRBzjFgAOXfQ1RTBnAuTSUdvwWlsl7v8s4Sn2HGcw8g8Wu0Em/oXhY644/w4oV2Sv8cyfcdh8fuXft9mQTn0NdUlThMglTMuCXJJrh26BzGxQwQ7TKja+AFx49eitsIs7rpLOheBQCLZqgoUkXPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co3y5Ypd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so5705625ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742453389; x=1743058189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03Xv1keiWzxrHieU5ZbpkW3iG/vVYUxPpzBjO5i3q8A=;
        b=co3y5YpdRcBOoa5VOHGLovtKSRfjsCmI+MhCD2JtCfnuG8PPvYOydagCTcUd64rCUy
         cGTuoS98GOyYgD4p3pv5NWQFfkNyykzl2gVosb8OdwPrEs6KwgvXVRIsKoxd7LO6GMoP
         YWXJXNFm7RkpKcw/ZSBsphY0WQoaCARSBDermcPym2Nne4bN764f4TcN1Og4Y9SG+Edz
         kuboL5aFbsypB1tzQCN/HUTs3+WHTLPcHfE7bmu5uc9onaYgwnKARIz22s5ZSzS55SjC
         6xtEZkeYS1vH49Y21aRFs7tBFbVfuXN2ebPazMQ6RVjYrFRtuW/OY676o1BxGMS8DD9g
         yDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453389; x=1743058189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03Xv1keiWzxrHieU5ZbpkW3iG/vVYUxPpzBjO5i3q8A=;
        b=Z5zRHRd6+X/mwYO0vVIoSB/UMavJRLAhdX1gPkKBQOE17A2uS7UstGxGB49NuD5xHH
         zRhL1wqnC3IKsGrEZn2S+3x+4FI7rLk0qk9x94U6X7H89D9PgmBMgmDB8KxoW9YR+2D3
         nZsIOLwhMHaUZu3grHNj8KS/GoDo1gFKBr3EhXD06pBVujsa03oggSNlqNZXYtTUHtpL
         xkPYjibE28yLbS1nEG/kfsrQcCMO69ANKSgzDNPr/MZzoL5GDHi8cW6dpfv1HW8CwYkw
         vtoDpmlhylRszbOIzxXqeKBqE74lmXXW30ThGAHNwrge+7H4hfpwj976IPAhFk9DmJiv
         bCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxXwzQZZsb6KYDKRAW7VfBVw/bS4/inTriB8kVNqdIy3z2yLBOXV+b0+wMDZl3A+IdW4MdhLrVvk2rzpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzXcBv0baucDEoVlmz0FjEhZCMX4RbSptR72wrpjVmnklvzZ7
	LFK+9ywxwWrnkKDZu6kUhjBU9UDRj3tsuJgPBR9HHsyNBhOPEztJ
X-Gm-Gg: ASbGncvu4d24TvM67zF5bIdRKFe9EZ7g4X0S9cfh6qYBSqpGDg/fns1lzLbZectgRVD
	2o29kpK+mXbwzRBZAXzQWbWbAgce68MO5inG8AF2ksdIpt1R72RIvtFROHKpdN4eA9MCZrxCEDm
	kjjEOyX5j49q1te9qvjJ+Cb3kQFkNPbwU+qTSldj2Ttepz4lCJb8RWgF/z2wlX1x+zzwt2RApqv
	XxMbzYH4jZ7rp2wGAODeyHbis7pya/LLZDNHitTdQF44+Y8U+dntNb6VwQDPDfp2Xqd9u5iq68K
	b4meL8eds2ls7rx72Tct89Zm02FezlM5YHXIjLgPV/AqQruTnNARLFEcSUWDzFM=
X-Google-Smtp-Source: AGHT+IF3RJQvrZXSax/z/cCKngBADtM/wtxhJQDhvbqiQpvsNxBAPAKbhaEyCy5y29hu3OBaFfxmKw==
X-Received: by 2002:a17:902:db01:b0:224:1c95:451e with SMTP id d9443c01a7336-22649c8e7c3mr80690285ad.33.1742453388916;
        Wed, 19 Mar 2025 23:49:48 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm127260155ad.13.2025.03.19.23.49.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 23:49:48 -0700 (PDT)
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
Subject: [PATCH v4 1/3] hung_task: replace blocker_mutex with encoded blocker
Date: Thu, 20 Mar 2025 14:49:21 +0800
Message-ID: <20250320064923.24000-2-ioworker0@gmail.com>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/hung_task.h | 99 +++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |  2 +-
 kernel/hung_task.c        | 13 +++--
 kernel/locking/mutex.c    |  5 +-
 4 files changed, 111 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/hung_task.h

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
new file mode 100644
index 000000000000..a5414d7b402d
--- /dev/null
+++ b/include/linux/hung_task.h
@@ -0,0 +1,99 @@
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
+/*
+ * hung_task_get_blocker_type - Extracts blocker type from encoded blocker
+ * address.
+ *
+ * @blocker: Blocker pointer with encoded type (via LSB bits)
+ *
+ * Returns: BLOCKER_TYPE_MUTEX, BLOCKER_TYPE_SEM, etc.
+ */
+static inline unsigned long hung_task_get_blocker_type(unsigned long blocker)
+{
+	WARN_ON_ONCE(!blocker);
+
+	return blocker & BLOCKER_TYPE_MASK;
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
+static inline unsigned long hung_task_get_blocker_type(unsigned long blocker)
+{
+	return 0UL;
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
index dc898ec93463..79558d76ef06 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -22,6 +22,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
+#include <linux/hung_task.h>
 
 #include <trace/events/sched.h>
 
@@ -98,16 +99,18 @@ static struct notifier_block panic_block = {
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
+	if (!blocker ||
+	    hung_task_get_blocker_type(blocker) != BLOCKER_TYPE_MUTEX)
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


