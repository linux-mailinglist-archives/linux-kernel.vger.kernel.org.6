Return-Path: <linux-kernel+bounces-246635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBE92C493
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BA8282D96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EDD185633;
	Tue,  9 Jul 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J33I4bmP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D1185616
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557154; cv=none; b=oLkSXWwihO9SCt2tU6OtVJ302qW/qRB+9rDXuZnU8H3Xt/98s2CVyVZR543Zr9T48cdmcDSGBRaQImzwbjt6HmoUoKgGCMWNmwr66fjT7DdCUJtadRWIqv9aXNYAIvaMC7ezlXTmXEtaom/AAxF9MecIwd7axVnZQhwAHGHN2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557154; c=relaxed/simple;
	bh=X541dEl79Yn7xvidTxrBKmxXUU7GWVN/DNRykcpVjO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hz2KyYW2K/gn8pzMI5lCatLEJcnSxv6rKDCu7mfGPeYdDGLqUHmfU5clzcZre2u5o0jMqehMC6hfETEBQYC9/1KqtydKcnG5uHKpP3oOUCAUORUKgyshxDRAAsRfsGjT4qZQ8ZOg/xVpfWbRnZ41/HT2NwWEGhgIrA0+fy/5oMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J33I4bmP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-652c6e92147so93851177b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557152; x=1721161952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HO7ngMSkWjPHLXmo+rqra2Oo+7w/UwqwG9JY6wVCFY0=;
        b=J33I4bmPO55haCHEhl7ssnCPZDyCEQ+8oC2qPr9GVEhtRbXcj95dLEwq1p0sMOp6Cv
         5JqaHxrGTEIqkwvDOXtV0JHfYT14QMCqKHz0k+/HAFAtyty9tzuE3V6G0H0dV2GEtSOC
         ni/h/CmZhGaVKVAow20LOLRxNZvrJJHdKhP3coQXlIjvUfl4hUHiX0MT8sh100Gc2za6
         EQGhlIsuYMBWhMwIZX8qJrFI1PrC1tquyZITVZC8F+3yEfU5KRzTGIRHinJKNcdEQZRJ
         N8EBo5SvnxxUS6zTYe/beFqo7nJRyynYApx1VLG6+HAm7mWwg/Um04c48wKbi7M4LN8B
         dd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557152; x=1721161952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO7ngMSkWjPHLXmo+rqra2Oo+7w/UwqwG9JY6wVCFY0=;
        b=w8FGUhKJ1eXVZg1ZOUmVVF4SBiSbCeaztPlbqV3QyTRl4rDDdhl6GwAmfmnWOGp44K
         weCNDtBInwXRpDb4x/dFfC0gjVL2+tD9POzt1MhL7Cuhheyn0mJRLWN4TwCqbwyS3kcF
         3pSqTGjzv/I0Am8YQMowZYM01dGqETimMEKOQblw0JiPbxIjK66w9oEbm/VSdeKGlb6i
         9ww9PUWvVfN/lxgCX0AbOKl1ytOxMxyCfCLX4yv2rJ/22ooIwa8IFR3ZflxIKgHC+NzI
         nUEAGHbEsVnUPjhGYytyXSmc0k8xnxPtMeTSVQdABtvkaVjQIcbmeAzqJwptYVYJwqok
         ZHEA==
X-Gm-Message-State: AOJu0Yy2y2W1QI0q34mpkFkYfy+FI9XRdOrJDLRJIqQ3mnbDrAmUmZJc
	/c1dfxjZYFYtjLNimsrHB3L8kAYDRSAF9EjSelNka+93EFt2SIoWlsrAUFet/HIQHosGXNfgydy
	mQ4P2EcsMvz8ljcql8M8ypqiqQK5Fq4FJXlVaHLtJgPun/3fGk3hneHUBDlY3PPmVbxkM2LhUEI
	d3BgM5hx8uxyOKGeNOwIfrZse2TM6gyuGf33HZT73/1+JC
X-Google-Smtp-Source: AGHT+IHTH0TVWsYmV2MjvWBvPTj8ERIhji6Z6aTrrT6MOTDQGQfSU4XEudhShTCy9Ws1HmhvyEA3jtWXgA4p
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:260b:b0:e05:5fd1:b4ba with SMTP
 id 3f1490d57ef6-e055fd1bcb3mr97276.4.1720557151478; Tue, 09 Jul 2024 13:32:31
 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:46 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-4-jstultz@google.com>
Subject: [PATCH v11 3/7] locking/mutex: Expose __mutex_owner()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>
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
Cc: Youssef Esmat <youssefesmat@google.com>
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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Removed the EXPORT_SYMBOL]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Reworked per Peter's suggestions]
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
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
index 6d843a0978a5..4b7193fd3be9 100644
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
2.45.2.993.g49e7a77208-goog


