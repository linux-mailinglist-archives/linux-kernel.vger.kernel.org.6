Return-Path: <linux-kernel+bounces-361964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E699AF60
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E486B1C2733C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA11E7668;
	Fri, 11 Oct 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxFKRPAm"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF81E0B6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689144; cv=none; b=dy88fHHplxaesbd2kXX+qbegb5Lj6MkZvijCroHRQp/zTBvCoOfGBKIoKNiZcsPIRLgZ3yA8x9cMeYGUtNDuk2UeT0IjP08dV5zqF4A2mg8/VH+ZprIOgb50AK9e6zs2mgPPwqVogxkCyZhW/eS5dGcUjtlPem52cv4FoBOGu2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689144; c=relaxed/simple;
	bh=urjROjbvvzG3adzYbMqYoVN99qnivB8A7yniPBhNj20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frfIcjOFlRF/bq5iEbHp7b5k1leS44llzdKm+FgdzpmrA4MgEDfBfJyzhB68J9NkXNwL2Cc/RGNChC+edkVmjcMcqOgMYXInGQfmSRLuZP9yJS/ToygzPbPNmfgAQNhuQkZnFf1pWjsAYGXhE8v6TkAdKT9DyKYiU9yykCVdpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxFKRPAm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so2476457a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689142; x=1729293942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zSymx5j9+ZJCHggN2DuLmX3gB/lIKt6AY663VlhicU=;
        b=RxFKRPAm0iGtAgi7TiRpgbaazm8on5KnNx7JDVi84aBWxK1AyJCKRyfSIQkFr9Tmpw
         AMghBAueRKZD9Yz2qPqfPhwbCFDz9edCqUYmDVoQPHnWYi+H3zgSjClnAquQKUmZdcSb
         d6OSzDaWvcsDRszBjdbKGhDh6ICFApOtJurQwjx1BBq07JjjHRVyKyvEJQbyDHePxlMS
         CxC9+OMooM+6qmz10wCOGdI5bGbIIHL0qzEbBSMWFw+1TmvY1iKK4MQCGqBaa6sMsxaE
         RcZoSSxx9+os6AJHTMt95fMy708WMT9nFvQFwfGofUPP9PkWiyrhyFxvvVfozTub5ViU
         QVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689142; x=1729293942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zSymx5j9+ZJCHggN2DuLmX3gB/lIKt6AY663VlhicU=;
        b=ejQCl1f8iTpFcL3L02uVS4jTt6Z+I3fsjntVM4S59HnnLTOwPCj98sLYBfqljLBcTq
         uvTbJCPVmw7twM+FIQBodYYj07jAxs7H9HDDDKI1OTw3GALELAcIuM07KuWuYvrfMJd1
         itHhPWswDg8Dm2XjJj/oIvDmXTZ9CWk728ByXNjQRuNVab2tNlnlZQI8LkP7Lbqbb2JZ
         C8k9vYT2eTTywpzArZmKLh08hEXgq5nYc1E6A8SMGZV4iRVJOKmb7EE2POx2iqI/y7dv
         JEvbfWX+un3vquH/55OV9OrOoWbiju42fumQYpJM/GodRj/A2B4hp0esWaAlFJOMLj4y
         b67w==
X-Gm-Message-State: AOJu0YzW8+ME/uTAD64LOeYX0M74wuJrpSUMszT+3bnXrs2tpRY3erx5
	BcdM268UVQMo28i8UmVbtxfIvM/rwlTisTOO/pqeiJBXivAHixYto8HWbfU5yZwDa3APV4BeCXO
	JQutiJYQlrFkzD2IsDzoV6Jc5DGcG6WyC2V3dzmj8b4ziI/JRdGkNHIuPg5CBJrf6klrlNuui7W
	DdoGecqsHxGvXc4ldZIY5hzAI6ji5BTZ+HeAstTLtU+bul
X-Google-Smtp-Source: AGHT+IEijfMwwl5nsVTqDbSHbzV4cEsaxEpnYMdFNF9cXIcE7hTT62zKvUWPzw0G57DaYlcvR1v/Ownztaso
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:de55:0:b0:7cd:8b26:15df with SMTP id
 41be03b00d2f7-7ea5358e84cmr3375a12.7.1728689141080; Fri, 11 Oct 2024 16:25:41
 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:15 -0700
In-Reply-To: <20241011232525.2513424-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-4-jstultz@google.com>
Subject: [PATCH v13 3/7] locking/mutex: Expose __mutex_owner()
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
2.47.0.rc1.288.g06298d1525-goog


