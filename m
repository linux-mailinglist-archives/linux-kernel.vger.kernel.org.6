Return-Path: <linux-kernel+bounces-561573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD56A613A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3982819C471F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21519201002;
	Fri, 14 Mar 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cho3dOnH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4C28DB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962574; cv=none; b=gVS1hagZR+gLgn8tgwLsZ9HYjyjSqY06lISyj/1Ov3ovUZQ44/S41xQDABH1r/B+1hHXyNYbd3zdyrPeqK/UNZjBKWM/yWIA/Nxs6iXJ6vVYH14iQMmFKcjKQHldFVMkbVpBWamm61hzhIppfMObHQ/A9P7I+FtC86GVuFjrYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962574; c=relaxed/simple;
	bh=/BpjvfSorWraWWygAxTXKqjuAb/WHKVfa62nChACPBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcjKyqdUK+vjR+VGcTN5YoIqgZ4E42yBeqilIURM2H7BDAceO7puMirBHqCQ0gJ/UwGAviESVfszVGXPT+hemp6jXoqVkBeo9AMj0K8QheKuJUEp7HHv/D58tZCWLHijteNpWhWco0XMcBo5glT4aKW34dhiaHnbBfb53/GGOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cho3dOnH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso39497405ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962571; x=1742567371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCqv96c1xYGiVFkUw2dAmjH7VP4TawbSEvBpf+3+AQY=;
        b=Cho3dOnHl/RvQL+qpV/ab2xBxHDSpGPz8i/McebmZe/B3BDIp09TRG6CXbcUR4BcuZ
         uqHCSge1axARycjn+PlQYr/iNLq6K2rR5qBZ/BkwY7LxnAzSXDSGc6Njzgt8ffqGK6/W
         lGFhVmzD741B+/vvj6AbF5MkXqFVSp77tOkH61SND2Kz8HcLf8e3eLsnp4BEWCDJe5Yo
         1kSmMPZrRu9DNDRgOS1IY1/qgowpdtE8AFJpVoo/sxMaFuIwjuSCGsJ7dsb4rLwS86XD
         30OHzywlpCQb544W6iS0zTXflmXSVqOhbxJ1GKz+RmBK3Exf57elsWVhN0uXF7TT+gqe
         00FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962571; x=1742567371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCqv96c1xYGiVFkUw2dAmjH7VP4TawbSEvBpf+3+AQY=;
        b=hf4LLKFIt6qiRhNIrKfEhr7IhcFcOTicnq3B+mJq1DwHUQ3LXIGunRWJNXtfFUe8k0
         RiK1KoQ0BtJ6PtsFKuUSXLsp8fxoI3u8OGm/7uwTqsGuzuGJ3QgtoYt2oErgmr/MKz8D
         kHKkEoSo5BPJUrjoAZ2vpqIpw5eGdopwoNijLI3K0iN2VgQFd+CYG1TPnL5YD71B6jGx
         sokIl3ROU8mJyDJAQs6Vz69KiGGvkwXiC36jZSW4XcC8BLmiOpyHq2tv3nbCk005fmtc
         48imw1fiVVkwWmRuqEMOKywgp4rMez0nyquHBdNrRaQx1PlZ8Kf769FevYSrMB/IglX0
         HQlg==
X-Forwarded-Encrypted: i=1; AJvYcCWPo49dTycO/0ruQ12TXy8MclCdiOWS6v4NVI+QjlljEOvbzoN0CxMnUvPdylA3tjq+18KIoZqb1zzfF4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FIlSrPnCo9gMv4LFvkTgiGYnpFBKZmICAzhrr5IwGLkypCmg
	UVBzWWTnwLtjke2lPeiArjD877ulOKQx6TqjbjS6u9OO5vdenFjs
X-Gm-Gg: ASbGncu0SQu5NrHr/k21jasO5A6o9vZGfAa52iypv4EEB6AU6E2Z3y1uQYnV6ZNB3Rk
	eByFoVR6j1IitSocUdIbbZaR6rI2rNxuwj+6k/CxFY3JkdMP2O3oyySfntDA8IWUM/t8FVsPCDV
	jUEq4e385751a5rcd/xfXJTRhu8ZS4/qJpmGeJJCxRyn+AMU7dQFMW6KmGGTCVOAf1C6y+gncxg
	2SB6HicxIJl2PfQ7XozO8mgyckBllmZcMt4oB9i4FWQ6iZDMRsupJsV0UhLX50ssh0xBtCrD5SK
	GHflekv8km98QErG7GrhyZLs0+tG46ULT/7t2vixo98nGkdhoECnLLc=
X-Google-Smtp-Source: AGHT+IEoa2pa+++oKxSveSUboFGRRI+MANuUcKVn5pRv4S3lBj2T2XA1lbdwTfIVrQBYybpZfwXP2A==
X-Received: by 2002:a17:903:2cd:b0:224:721:cc with SMTP id d9443c01a7336-225e0a52150mr28034115ad.13.1741962571137;
        Fri, 14 Mar 2025 07:29:31 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe833sm29142445ad.183.2025.03.14.07.29.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:29:30 -0700 (PDT)
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
Subject: [PATCH 1/3] hung_task: replace blocker_mutex with encoded blocker
Date: Fri, 14 Mar 2025 22:28:36 +0800
Message-ID: <20250314142839.24910-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314142839.24910-1-ioworker0@gmail.com>
References: <20250314142839.24910-1-ioworker0@gmail.com>
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


