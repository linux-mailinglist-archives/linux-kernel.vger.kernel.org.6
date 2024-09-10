Return-Path: <linux-kernel+bounces-323933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF291974570
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E71C2554A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F921AC44B;
	Tue, 10 Sep 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7Gt5K+r"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B971ABEDA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006386; cv=none; b=lOgjhmEx2NwnSiA6660j+04uWD1cHzbl9HBz14bnAzt21TA1Mzxq6CEWLYT5sfzUpmL8Lp60QqvLc4TM3on12fc1vmaGmgRXF7uncWpFeRer7QGR5rBEj+RXIPQNUFvYIqPggnqASHlQGgajg1ZZ23y7g+td99ejDpyrO1jfLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006386; c=relaxed/simple;
	bh=MDWJdTnVn3yMfkCMDsuVz9ep2U1fMOWvy1+eqwZ/7w0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nyE+Sr5WX6+/PHiOoZfkrzIq7HarYLZeJGF/i+0b/YxM0fYS22QyBWUGsFDN2dMupw1IHTdMNjTMdVyC1Pd3nxXuQG8spbTyNd+J/GEr3gu+B72wGtWXqyaJdX1ynfUVk4AZuwpaYf6mE6i/lPexNIX4lLgNtv5SJTRECyxDcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7Gt5K+r; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c42e3so76933987b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726006384; x=1726611184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhbjDyq5bWGd6aE16hj7/sjohLBvxh5vFhyJLxlnWkI=;
        b=d7Gt5K+rETtm/sXr+kPlbejL6iP857IxrAnuO7UOA17oTtEovCY6oroDTBSefX8v5U
         cjzg+qOH+yjtUu/d8LAjW/qvd6T849P95wMaPuFfQ9ycF43dZ6LjVK+5Fm18bQ9dwaxX
         LLHEU49C6xarSRdvBqD+hHvtEitZqcqPufg78pCjmiNRKBDn+tIeAS9OHaJE/q4CqGgn
         8KEV+uzlFIDlYO1Zc7960Qo02AuXedQX/p3qZZyrR0DiQMx0SGXZJMmHuv+rTJXGLo/F
         uBRNRZQjWRNYKdf8O/rh2dEwqqnOADCkRtr/O9uv/41tP/syG6cVAf6pBZfyp0acyDu8
         k6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006384; x=1726611184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhbjDyq5bWGd6aE16hj7/sjohLBvxh5vFhyJLxlnWkI=;
        b=Y0MRUHiE+g/6fkPlmmuG8MJn0dBqDWFD242MWOnnk7VWRwKSY0na7bMQr9x6FSU8Rl
         QI4QilrQ6aWDehmAtvhVGTL4ql3YQyweuTmbgogZMIVlrDS9xwRDV8sI1MpuhOL4bK2d
         81rjXpb2euyVDaszxwWVsFdx8uYBWC3c3bQH8ICxk149MBx7HnUZc4DzuQNXyZ2PgzhE
         zF76rpEelwTxBmZm6ffY6705TsXS/qffiOnQXFDBdsbXff0z5UWpnZ8TPd0CWhB1kQDt
         0uA9uQonnUc1cJ9ZOaRpyUuzTNEc0gGnzu5QwbFKYWPqsLZnZqfnLJ6J1ylQiSQpMzRT
         bO1w==
X-Gm-Message-State: AOJu0YxpgsiXw5jrBBmezaxyxOLd2d8hscjPw36M/vk3GGgWsHojGsGB
	DPPfkjmbx8yTmDIpZEwpMW3rwSu3vkCGzTaajf/4uAqp/+6jOeUEQzst0dNdLpe7OSHSgf3rjDj
	u4mPGDmc48ibbUTb+H68UIj+lnuSy8Jnj4dqZgLRhz8/cwkPsBpG+fwrWE0A54QKT4JAAtn2bw+
	wWhczzfF0Qk5NevCyb3bQ7UIRIpdsJOuEQk2eTAP9Z6tLk
X-Google-Smtp-Source: AGHT+IHOl9GEKAMD0CohshIcmkU7HXkZZTAiByP/xkr6WfxSSFoPnsB1khHBYAQxvJBUcOOAPHDih0gRx8mo
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:6a04:b0:6ad:e9c1:fc4f with SMTP
 id 00721157ae682-6db4516ff0cmr5877617b3.5.1726006383505; Tue, 10 Sep 2024
 15:13:03 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:12:09 -0700
In-Reply-To: <20240910221235.2132138-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910221235.2132138-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910221235.2132138-4-jstultz@google.com>
Subject: [RESEND x2][PATCH v12 3/7] locking/mutex: Expose __mutex_owner()
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
index cd248d1767eb3..3302e52f0c967 100644
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
index 0b2a79c4013bd..cbff35b9b7ae3 100644
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
2.46.0.598.g6f2099f65c-goog


