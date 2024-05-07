Return-Path: <linux-kernel+bounces-170659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFC8BDA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AAA287192
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E66D1C7;
	Tue,  7 May 2024 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jl2uy3zP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30296BFA4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057704; cv=none; b=ufl01+ZvEq6v7khmeDM//erGxfpAC4VEHCom3fHvh+zAaTP/lYtfeJMMfuUjdpw2gZgbEirtDrY6DT+S2+eGbmNFROaUQIaNZE/n5chKo4OarUKCWZAq7qe0IfZt9Ao1jeev8tgk01PNXeGCqmRhDGMimo8wcs4N0NIabI3gHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057704; c=relaxed/simple;
	bh=LJozwWFo00icSc+ph1GrGuSQds/hXTBjQ8rp7ambAo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBEkFZ9L8dJWWWr+2E7r1jEpzAPu5eohzi/gGScxPu/65uVSlnWHF6enfsNfjoJLIGa7jDCKG8tSrvuZV7taeZ/xMzTiqKseLN3ALOFsRJWK3fUcbNnjdNYRzGKZNY9A5nSzaS0CRkwLbDhZBQ2b8TuoUvTGDQyWZTV6WybKG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jl2uy3zP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so5917862276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057702; x=1715662502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5TEm22m8AhcjBDC3yb2+ACT2qc5jdCH9i9C2IPWAkE=;
        b=Jl2uy3zP/Vdcj/ApST/FlgX0jLLb+mlqQviZtBcC1BT8oQrIKowrNxylcvsYGG652M
         iojTrVGLIoqqZZ07qcXqYsmjhLqmy6vnO/y+/3f+LIH9ocudEBiytii1MRBW8e2+vOqY
         dTL7Jaz9CNuBCtvtspgI9PMeITcpYJ4RPFhH+/ist7Q5lF61y1F3yCrCHsjuPBE2yK0U
         +bs6vhu7JRTeXipT6+C3PuM5APlelQ/RAJVVfr0zxRcLbs8zqSCy6HJqx2bsJaw7FMVI
         AWvk/Fi7cTfNlLdArgPU6tfpr169RXHtew2cWQobtUdLsfDslMbmQA5LY0vkDuxFv1GQ
         1/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057702; x=1715662502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5TEm22m8AhcjBDC3yb2+ACT2qc5jdCH9i9C2IPWAkE=;
        b=aw/6AlXyNRBr63xqCWw1vhnU8QtrzfmCFVjA208WJiNGimPDqs7ux9LbDkFru7I959
         dEC7ru641GzqJA5FuYxHPVW5CW8qBwFET1tZ/aVjh1tSH6Wvs9UQR1QHGN+ZQE1cU0oP
         aw1VIAZQr3V4Ach8J0aXltVT5t9aXHTEUUm8KnHgY+H2AcTfUvg6W5zZGQnXpD0Zz8Cw
         /Bh9dXUe9kYPNTKOj83IjkmwhL6IJACr82sHVQNJz0EosbHkDXqe0KDU/aP1LDdkUezz
         TsyGwTQJ/+frb1/tmt4HXBb6eEwz6rsBoCaVvRUrdgW8pAfSYN8PcfiaTFftFS3L7DQq
         eRpw==
X-Gm-Message-State: AOJu0YzBv/wzgu4BrULUDwU92FRCP19MF6ub0UY4gfaIZrtf8IRux4op
	0pCs7bHEfQkeJMQrKWM65I4drF+z90U9lRc/56QjVUPIACLxz3CSiLf0UNl2ilbLGNNbDvSnB5N
	D22N3jgc/3n8Y4fqcFhvIPcofTN9F1ABUVHz2jzH9Dvh0WWCGaKZBVvQJqCYqraW3ZWqzHzBm6p
	4Oj+2ocNuv++qNygCAaOkm5TVbK9e8n2rj1KmdR89cz18m
X-Google-Smtp-Source: AGHT+IEBdky+n78mUJDzkbJ5MNXnoaZpEpKu6Pn2MLbvJpxrCOpCdmVI80xUslnpLqD7y0cfr2dRXFly7bst
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:701:b0:dcb:e4a2:1ab1 with SMTP id
 k1-20020a056902070100b00dcbe4a21ab1mr4171430ybt.11.1715057701501; Mon, 06 May
 2024 21:55:01 -0700 (PDT)
Date: Mon,  6 May 2024 21:54:32 -0700
In-Reply-To: <20240507045450.895430-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507045450.895430-4-jstultz@google.com>
Subject: [PATCH v10 3/7] locking/mutex: Expose __mutex_owner()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Juri Lelli <juri.lelli@redhat.com>

Implementing proxy execution requires that scheduler code be able to
identify the current owner of a mutex. Expose __mutex_owner() for
this purpose (alone!).

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
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


