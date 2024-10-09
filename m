Return-Path: <linux-kernel+bounces-358023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49599795E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1299B23073
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0F1E571B;
	Wed,  9 Oct 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF1cR3ir"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5E149C4F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518047; cv=none; b=k3tcnO/bBeBpiZpUwAy3S/Wrgacqhuhh2PxD8vFgZpvlYUDo0XCbG7xX4IrDseUUBRT4e65CWWAvPqEryMWJ+gARcSyslo++WJG7iVsmRXA97yU9j89gHn7Xgc1ijunPPTJHYhU/LjdwR2Fd9QWcavahxc0aYB/1UycBIOih6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518047; c=relaxed/simple;
	bh=wqY14AU+JSwok0UwEF/K9zE/dL8T0OKEFy+eP0e6QlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRoo14aNiQHZ9fZ+3RaHHCyW/WI77hXdcYRkcJumS4N40vTM3qRrq4Nk51xjijaji5xz6eAt+JveT30TYfXclRel74QpnNZEuw+XuW+snW0GQlVrJxMXCv8NdOljKwjvc45ONlOC8A3bYPKFdalAbPrMgAqzW9Qc0oe09mBIXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF1cR3ir; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904a54a10so462642276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518044; x=1729122844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkogdeMtbJj9ox/OqjcbeCQ27hEpo9k2fOdRUr04kJg=;
        b=IF1cR3irF50m8fJcxHC2XNlqv6djdWsYWgWj9CirBlQuy66k03JKA8O0mkBdlepMVS
         xWRhsP6URWeW1/3nGMis6xXO2oeq4Fvn/rg9SBlbViLd1OQ5jPRCUqSLrpu2zQwyL3Tv
         SbgVAxqO8a/t+YKeCH3D7p/AOfuju5Kc/fgHHz6YZbEW+aL9wnLfGuDreJQlvxnbOhLw
         N3kWl5uWIsqf3WKTLZ5QovgOM6QTZF/fkv9nBr56c7nRdeluRsvu+8v6fGGGfhWoTxYS
         ej4CYTlKWAHdxPM5UnCfpLttKKzX8il3ut/XyEfwnMLOOwYWvANfM4ovZtMXnxHh69yV
         wQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518044; x=1729122844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkogdeMtbJj9ox/OqjcbeCQ27hEpo9k2fOdRUr04kJg=;
        b=r3pL1TNwBMSLSLHM2shqY4jpCQq+bBd66GDUPOWBpGW+Pmnz14DiHt4GmQuKRhAPtm
         2nICe3X8rE2p+IMS8hkwhctR28HSpl3ZQgGpTg969ow33Dh6E+9yvqku1QTAVGopZ226
         UtS/AboIJ98BDk/ydSU0tetazan9O8t38u+ur1kPGiwLJAdJMI3emehhT9wf1/e3fRm7
         QAD2LiiWeYIW2oB74uJ6j+v8PmhFZpOD+ZUdl/Jfa+TU5C6/zsBw4Y0fD6pUCVRrT0bW
         ezpAf6T5LbMzD+bZRsAuKuO6TscAS+kL+i7I32ZiMYCMpEy+qIFe9gRJ9oT3V4YNNG0q
         5sFQ==
X-Gm-Message-State: AOJu0Yx3iTyYllkz7fuQPAlo1M+Bv+d13YsJyad7xKLB2WeJKOSeSQCI
	IPbt56h0bKOKes7Y8sIoizVLjgM1FmRv5lRO7CixCEDSKM0Eg0w0O7rhYp8bNhvEGGuIR+aw7xw
	wi2mPIEfrERZQ6V3IRNf5mXW7stVqliVAu+8OKE5RWB3ahKZKcCiUCPUUE39zIqvtvEK4E0DBwl
	A04poNQ2JlPhgsfaZeYlWJbokSidzLqJFNIMikGtXIHAiD
X-Google-Smtp-Source: AGHT+IGubb1i6Fe4d1tNJZZWfjTqMmvikGKS3I8RQwQIBtaDowV7huq0tOvyvN/FAU/Qkd6pvEsYusKzWfH5
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:c74a:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e28fe54b2f9mr2895276.9.1728518044054; Wed, 09 Oct 2024 16:54:04
 -0700 (PDT)
Date: Wed,  9 Oct 2024 16:53:36 -0700
In-Reply-To: <20241009235352.1614323-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009235352.1614323-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009235352.1614323-4-jstultz@google.com>
Subject: [RESEND x3][PATCH v12 3/7] locking/mutex: Expose __mutex_owner()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Juri Lelli <juri.lelli@redhat.com>

Implementing proxy execution requires that scheduler code be able to
identify the current owner of a mutex. Expose __mutex_owner() for
this purpose (alone!). Includes a null mutex check, so that users
of the function can be simplified.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Removed the EXPORT_SYMBOL]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Reworked per Peter's suggestions]
Signed-off-by: John Stultz <jstultz@google.com>
---
v4:
* Move __mutex_owner() to kernel/locking/mutex.h instead of
  adding a new globally available accessor function to keep
  the exposure of this low, along with keeping it an inline
  function, as suggested by PeterZ
v10:
* Handle null lock ptr, to simplify later code, as suggested
  by Metin Kaya
v11:
* Tweak commit message suggested by Metin Kaya
---
 kernel/locking/mutex.c | 25 -------------------------
 kernel/locking/mutex.h | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cd248d1767eb..3302e52f0c96 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -56,31 +56,6 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__mutex_init);
 
-/*
- * @owner: contains: 'struct task_struct *' to the current lock owner,
- * NULL means not owned. Since task_struct pointers are aligned at
- * at least L1_CACHE_BYTES, we have low bits to store extra state.
- *
- * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
- * Bit1 indicates unlock needs to hand the lock to the top-waiter
- * Bit2 indicates handoff has been done and we're waiting for pickup.
- */
-#define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
-#define MUTEX_FLAG_PICKUP	0x04
-
-#define MUTEX_FLAGS		0x07
-
-/*
- * Internal helper function; C doesn't allow us to hide it :/
- *
- * DO NOT USE (outside of mutex code).
- */
-static inline struct task_struct *__mutex_owner(struct mutex *lock)
-{
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
-}
-
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 0b2a79c4013b..cbff35b9b7ae 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -20,6 +20,33 @@ struct mutex_waiter {
 #endif
 };
 
+/*
+ * @owner: contains: 'struct task_struct *' to the current lock owner,
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * at least L1_CACHE_BYTES, we have low bits to store extra state.
+ *
+ * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ * Bit1 indicates unlock needs to hand the lock to the top-waiter
+ * Bit2 indicates handoff has been done and we're waiting for pickup.
+ */
+#define MUTEX_FLAG_WAITERS	0x01
+#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_PICKUP	0x04
+
+#define MUTEX_FLAGS		0x07
+
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex & scheduler code).
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	if (!lock)
+		return NULL;
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
+}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);
-- 
2.47.0.rc0.187.ge670bccf7e-goog


