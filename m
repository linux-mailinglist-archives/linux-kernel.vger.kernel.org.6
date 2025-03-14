Return-Path: <linux-kernel+bounces-561605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C077CA613E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255CA3BF333
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42494200BBE;
	Fri, 14 Mar 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO9i2jCp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D91FCFE3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963405; cv=none; b=Bhwtg0GTSLeataminMFMok1niSJz2oowm7LTrcoq5Y5RssyMTRxMI/Ip8d48Sxo7HPCW2EXllpXCMr1jchhnnURk2OwPodcq3uad3KzlpVEGV82odauGkbAWWp/PW7W7D5cbCDPFPojeIKYeafw/9vE/ipu9M7IQxVV95yRtkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963405; c=relaxed/simple;
	bh=/BpjvfSorWraWWygAxTXKqjuAb/WHKVfa62nChACPBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGADPJIYEoQdUqVKlvE4IwXVokatahi9cBtVJNNe7JBzGLghexR4SSEbqjnW/0YE6AQrncVAtBPr4KbLb5zqQnyye+m6Mxf3f1wCeoY6o+tlV0MRiQ+2zpn/scjRAyzBYn/Vg/EyXz1HWdPFaiC9eUosomfGT9uNLwzMkQNDRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO9i2jCp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so54809845ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741963403; x=1742568203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCqv96c1xYGiVFkUw2dAmjH7VP4TawbSEvBpf+3+AQY=;
        b=WO9i2jCpg1h8vmGusWRTvAopjnPTQcA7bFp/GsFQ8oWjEPC5bw4mEtP0qn80Qm8pOZ
         Ra4JweP8vLK/+4nfwdfDTzOXaoeQpPyWuwiVfnaoGoy2N7jH+norDBH/1Abxu9/Yi9rs
         G0G46Y9hmX9zrj/WXtNcQUgt5yo+CJqpTqRHElBDqs4ATZB/gO6KvasNc5PuUkRoIaZq
         62FMAC60GtqeHqnrt19Ts8qJF6wFFfkGx9u7FPIUidblHb9FAzchkfnQkq1KYg4faZ7o
         P61Gh8KMXFnk+aU1vCRsef+at7U6uqh4ff6CzqC58hSu0/1HPTWguxVkMKhBbc1pQUk8
         zy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963403; x=1742568203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCqv96c1xYGiVFkUw2dAmjH7VP4TawbSEvBpf+3+AQY=;
        b=P9pxa5Dh73EM0sojDIMuKoVDHbH/sva32Jk5cbWBG7MAZ8G1uluEu+g6ziEgP2m6do
         1dYclfv5ZhiVWQ40lASOHjf3NclKLbDPw3uuOfE9asW0D7G78YKMdbgiKzMXOBo3xRgK
         7AU3aE/20hEwW9Rh/0Ew3rTU3QkpSsR0eBxh6eVU9U71iq9qINhkeAmOKFCCdF3B2fyP
         KBjvFtFnGTbIDs9tDmoRhOSAanzx7l31RMSluV3jbNT7329OFgq+VohkiwQcCHb3H8K8
         4mK/fW690FvjRL3Q2MJl8s91EHMeoVqFhcMd8lqUohK9RpF1ZLmJ4J3X7NGVXVC7fnrr
         QuoA==
X-Forwarded-Encrypted: i=1; AJvYcCXz8Ar36M8gk472dC4CvFoFAydP9BQHGg749VH/Z9roVwFUgfCSWCYQ5TQMJ1Mvt0gSNVntWGoJ0a/Z6+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznueaZjRAqSOJrygXZVfldVXUWBm069mn6NyWBy6uYcTh9tDl6
	qKhKzZ76djckhtLmzyvm/FPlGsak7xBhRpZlvDKNi/lfr96hf5Tu
X-Gm-Gg: ASbGncvLpN6qJ8xgBQTwC6NlTCcFuAIVsNEpPp0Lk7tZtHuivuN6o6K7dVTCVOWPMvN
	dHm5tWtDKd6YDIqKO29sh9gmDbOezoLxWf6QFm+D/DM6xS8Wexh3/6O+nguVYZRgA1Z2CZpTZt7
	rAtJnnuIQmNmhZtGTn57n+ira1rEtUWrDierOk44yUn++o3t6+C++gWW7ElaV0zNfsml0mtEMNu
	1BMNk4tDRAoa0gpc3v/8vuKfEtlh96xMd+gPUC+1sPsTshK/K0VkRYa34BkSa0w9jprrxb+oh/x
	vPAUWKC6oJJBlqJTULTgHRkjAdWABBPnneaiJvHs3xnO+UL1jc2DThJB5liLAsLXLA==
X-Google-Smtp-Source: AGHT+IHgxHWefkw0lKRsL7IvjEXUhywi5ikpmUx3UK7dKW+dPBFppxfOmgXQwahfsu+ynPfdaJprng==
X-Received: by 2002:a17:903:11c4:b0:21f:85ee:f2df with SMTP id d9443c01a7336-225e0a896a9mr41357025ad.15.1741963403163;
        Fri, 14 Mar 2025 07:43:23 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7280sm29228835ad.147.2025.03.14.07.43.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:43:22 -0700 (PDT)
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
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH RESEND v2 1/3] hung_task: replace blocker_mutex with encoded blocker
Date: Fri, 14 Mar 2025 22:42:58 +0800
Message-ID: <20250314144300.32542-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314144300.32542-1-ioworker0@gmail.com>
References: <20250314144300.32542-1-ioworker0@gmail.com>
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
 include/linux/hung_task.h | 94 +++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |  2 +-
 kernel/hung_task.c        | 15 ++++---
 kernel/locking/mutex.c    |  8 +++-
 4 files changed, 111 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/hung_task.h

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
new file mode 100644
index 000000000000..64ced33b0d1f
--- /dev/null
+++ b/include/linux/hung_task.h
@@ -0,0 +1,94 @@
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
+	WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK);
+	WARN_ON_ONCE(READ_ONCE(current->blocker));
+
+	/*
+	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
+	 * without writing anything.
+	 */
+	if (lock_ptr & BLOCKER_TYPE_MASK)
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
index dc898ec93463..46eb6717564d 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -25,6 +25,10 @@
 
 #include <trace/events/sched.h>
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+#include <linux/hung_task.h>
+#endif
+
 /*
  * The number of tasks checked:
  */
@@ -98,16 +102,17 @@ static struct notifier_block panic_block = {
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
index 6a543c204a14..642d6398e0dd 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -42,6 +42,10 @@
 # define MUTEX_WARN_ON(cond)
 #endif
 
+#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
+#include <linux/hung_task.h>
+#endif
+
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
@@ -189,7 +193,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-	WRITE_ONCE(current->blocker_mutex, lock);
+	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
 #endif
 	debug_mutex_add_waiter(lock, waiter, current);
 
@@ -207,7 +211,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 
 	debug_mutex_remove_waiter(lock, waiter, current);
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-	WRITE_ONCE(current->blocker_mutex, NULL);
+	hung_task_clear_blocker();
 #endif
 }
 
-- 
2.45.2


