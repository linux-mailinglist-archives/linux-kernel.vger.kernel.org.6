Return-Path: <linux-kernel+bounces-548265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96381A54284
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44B43AE192
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826519DF7A;
	Thu,  6 Mar 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDIKoKaE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9536D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241157; cv=none; b=EnCXGizgBQ0+IzhBGq7FR+oBj0Zl9UWIQ737LyhuKVeVBXgJ59LE3ii2IPJPRkL9x/P0QbZ1RCyUr6+lWd/2SGumMe9WXsaqDFss8bhBD8jjzsutrk/OGwHft93sQZVYxDrhi1yOvoPVwUom+mIEIcRsdp7OHZqDUfhhQGvsG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241157; c=relaxed/simple;
	bh=isAglVlUHW5/henYHfaAflphOnRpORipo00NkYN+Z/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROgPuY4vG64u9lQ9/QEcQcXXpYNFtpPrv1KFZ1ldJ6SWFogS+FevK7xgl+XWRzbi8whBw8dsDUViQRZUEimwszg5hxtk2tUf8WHbH+MEEW1wl/Gp8vKJq2oYjwGhhk7amOlxtuLz+9Eap9tRvGDKLWORJnYwUxSttcGZ1+psQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDIKoKaE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso5255065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741241155; x=1741845955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG9rqCcnNUyKo1EuZi4UaOq8qKj1OcWCXfP605i9OAs=;
        b=BDIKoKaEgiQaQs/V8s6W5V5qnkj3anV+D4tp54pmyBMEJlcfQcDyHhbtx8Uu1EaODX
         KOILd2b8lGNtywaR72Eg5TuVDPicSklC1xK+NrgsallYrWv+yloIi+de3qEjD21IKcY/
         TIvt3aV3RquL/gbyGeh9JgwPGbpyW8beotM33VVkjWLFx8YsaYyd9qhOGkTDCwaU7YtY
         PciNBuORtu0HatUsTELyXIrTWDjjV8u6cHrrlxI0DTBg6YjkuSXYAf/3xsVNKGezxARJ
         llUPxhSIiqLCE+lsEz0Ooud2UOJ4uvy3pE+ES/YPH1L+N8MRUQhE6cAUtKxsUHHjfKyS
         uD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741241155; x=1741845955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG9rqCcnNUyKo1EuZi4UaOq8qKj1OcWCXfP605i9OAs=;
        b=Mpx3vtjLk7QVFJ6H1+lcquuAumW8obeRxxeGL/CmCOUIc5Dh+AFEtwsK24/3MJpBe8
         0Zv7Wv7xie5izmkEB9OaeZHJCLG9CAH/t6LWPawm2cy9JQPBVQfXRWD8LmYS+jDhWly+
         hZ7QPw1AT+ilnCEcxVLopLQVBxCFln+zSQoBOEEl7eb6L6Em361t2XZdynKbyUxaJjmO
         KuU5+Gb/8CxOzAuSzsBiYbENskE6jE28vIiNayJHk94OG+VZESSxI7nFqK1ivhdG0gLF
         E2HQAS9uxKc/TWkPoMcj2ssUUsZJgNPDvqjA+h2cQqHFTrf8HNljqgzCo7m93zkPxxKW
         FYGw==
X-Forwarded-Encrypted: i=1; AJvYcCVTILqAId4CemwGKdqWtjz9K69+PNMBnzWenKps7fw699Tojdi7JQ2Gy0VMkePwlNNWcUKq5P6BB8kdClE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cg6bRxMQ39qLLKea6jKfncZF9tX0AJSJvIId2dAe48ymkd/2
	6csJt3thbbqB3/Nflfz9TGWHg/XwyLL9d4TTZQhGWYgSUe04JmqT
X-Gm-Gg: ASbGncsfuvZDlviZ2hwijwiodRU8GhWVFQJk1MfErmZugf9L72BsOdaxIdRjZX3pd/1
	4Y3pFU1n6LTYr2z4MlKPCpgGX7vrpvwlid5+zTsCNLE2LShsrWhFF0F6Q21uH496jP5tJbha/Hq
	DO/oXbqemKnqB66APjtdomlYqq/KTdL6fM0DHrYCmjyUpEAuUJhwXFb6X7SRgzwx+GAbh28OIZs
	gNEociTm8UMuPx5g4CWwolf9L4qWjJxGychgDq7PNpAYD2LtN7Brwpew2AGu9RDzitbYpJy0kA/
	84y17ogA61mkMPe4W6xNYpyORLZOTRs5z/0yP85MU2A9pvdi3A==
X-Google-Smtp-Source: AGHT+IFAxcTCstjfuF0X0c0N0+rKtDXjn9RJlyyZRr5yiQ9SzWxJAyoAMCJq23quMPQV96bX/TvZnA==
X-Received: by 2002:a17:902:e84d:b0:215:a56f:1e50 with SMTP id d9443c01a7336-224093ffb90mr33605885ad.8.1741241154765;
        Wed, 05 Mar 2025 22:05:54 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109de155sm4180865ad.27.2025.03.05.22.05.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Mar 2025 22:05:54 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	ioworker0@gmail.com,
	joel.granados@kernel.org,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mingo@redhat.com,
	mingzhe.yang@ly.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	will@kernel.org
Subject: Re: [PATCH 1/1] hung_task: show the blocker task if the task is hung on semaphore
Date: Thu,  6 Mar 2025 14:05:42 +0800
Message-ID: <20250306060542.56435-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
References: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Could you give me a quick feedback before sending out the v2?

It seems unnecessary to make 'blocker' a union. I replaced 'struct mutex
*blocker_mutex' with 'unsigned long blocker', as only one blocker is active
at a time, IIUC ;)

The blocker filed can store both the lock addrees and the lock type, with
LSB used to encode the type as you suggested, making it easier to extend
the feature to cover other types of locks.

Also, once the lock type is determined, we can directly extract the address
and cast it to a lock pointer ;)

---
 include/linux/hung_task.h | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |  2 +-
 kernel/hung_task.c        | 15 ++++---
 kernel/locking/mutex.c    |  8 +++-
 4 files changed, 99 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/hung_task.h

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
new file mode 100644
index 000000000000..569d2e579f36
--- /dev/null
+++ b/include/linux/hung_task.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Detect Hung Task: detecting tasks stuck in D state
+ *
+ * Copyright 2025 Lance Yang <ioworker0@gmail.com>
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
+ * 10 - Blocked on rw-mutex     (BLOCKER_TYPE_RWMUTEX)
+ * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
+ */
+#define BLOCKER_TYPE_MUTEX      0x00UL
+#define BLOCKER_TYPE_SEM        0x01UL
+#define BLOCKER_TYPE_RWMUTEX    0x02UL
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
+#define hung_task_set_blocker(lock, type)       do {} while (0)
+#define hung_task_clear_blocker()               do {} while (0)
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
index ccd7217fcec1..f7fa832261c8 100644
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

Thanks,
Lance

