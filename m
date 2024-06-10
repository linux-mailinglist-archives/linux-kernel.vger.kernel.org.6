Return-Path: <linux-kernel+bounces-208600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F51190271D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469E41C2160B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD014AD35;
	Mon, 10 Jun 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzYYJiRU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNxdn8zN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F8157499
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037773; cv=none; b=mF2RM+UwEUhqBxKsnlbP/SAG0H4rL/NgVGnlMuWNj6Gvn0dwCGnzoXFcf34TifSYwSm4MTHbCglbRU590zeyHNv/TuG7Hzxns0dMTS9QeCK35CU4aSGX1NjVs3cD7AX/fQ0OVrUeLsaMsUEZT07yAqMhtD1L4wq1QdGxSTknTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037773; c=relaxed/simple;
	bh=189exjZEUItQ6zpVS/Cs7Gleaem5nfeA9wEfKXDkURg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EawG/kyzi7xQ8HBvH6N2t8lIZFAGkWB6DSQn9m1KVbOK+oPexybYXmT9zKGj+y8nNmKQJV/28wA5iwPfeEdkjRrBk6QGUKt0fuyHtJ/Znbbwv6vOUE4VyXHqlXtWbASE0HMwKX0g+R1ldhXiuesZdbZlTqKuO/xkWIhUBfbMc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzYYJiRU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNxdn8zN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.790855258@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RIInviEgVz+BvUxJyZo2yuM0Ys8NWIcWoXCI4X06Uos=;
	b=kzYYJiRUHYneLHxU4yVu7jk3zyjkdzM9cQnC0fAvTWzV1TleUOAJ0LCzJnxjPJEV0PLksm
	GurYLFhLM+gcxEYXAL7OX9kBCnz+kOgK0xrjvNiuXxvGrRIKMTlF7vZukeWMqDElj25Sx0
	S750UabkqwiPzIPmFHZoeS53EGzDaI6HuyZE28ujNW2OiEA2e8Cb1uvm5oVq6WMrObeisP
	I2j0r+D0T1gw6NVAhBwgoOhKJoNCA9pLNqE8Zw+mwKj/RVs393I3kLSayYYwCQun0vtzv3
	iCXvgblnbwBJgu6LFHmmmuZ9+sHvzerF6gqaIJ7GVbb6YMPFcb1A3OWPNR1uGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RIInviEgVz+BvUxJyZo2yuM0Ys8NWIcWoXCI4X06Uos=;
	b=rNxdn8zNpFOcZoFpC3GkZkEeDPnjsjWSI7Ou0wG3/CHUPxPLYeSMyi6tIUkk77M7MVPybu
	5+sjFfzZpzrCELBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 37/51] signal: Split up __sigqueue_alloc()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:50 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Reorganize __sigqueue_alloc() so the ucounts retrieval and the
initialization can be used independently.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -396,16 +396,9 @@ void task_join_group_stop(struct task_st
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
-/*
- * allocate a new signal queue record
- * - this may be called without locks if and only if t == current, otherwise an
- *   appropriate lock must be held to stop the target task from exiting
- */
-static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-		 int override_rlimit, const unsigned int sigqueue_flags)
+static struct ucounts *sig_get_ucounts(struct task_struct *t, int sig,
+				       int override_rlimit)
 {
-	struct sigqueue *q = NULL;
 	struct ucounts *ucounts;
 	long sigpending;
 
@@ -424,19 +417,44 @@ static struct sigqueue *
 	if (!sigpending)
 		return NULL;
 
-	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
-	} else {
+	if (unlikely(!override_rlimit && sigpending > task_rlimit(t, RLIMIT_SIGPENDING))) {
+		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		print_dropped_signal(sig);
+		return NULL;
 	}
 
-	if (unlikely(q == NULL)) {
+	return ucounts;
+}
+
+static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
+			    const unsigned int sigqueue_flags)
+{
+	INIT_LIST_HEAD(&q->list);
+	q->flags = sigqueue_flags;
+	q->ucounts = ucounts;
+}
+
+/*
+ * allocate a new signal queue record
+ * - this may be called without locks if and only if t == current, otherwise an
+ *   appropriate lock must be held to stop the target task from exiting
+ */
+static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+					 int override_rlimit, const unsigned int sigqueue_flags)
+{
+	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
+	struct sigqueue *q;
+
+	if (!ucounts)
+		return NULL;
+
+	q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+	if (!q) {
 		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
-	} else {
-		INIT_LIST_HEAD(&q->list);
-		q->flags = sigqueue_flags;
-		q->ucounts = ucounts;
+		return NULL;
 	}
+
+	__sigqueue_init(q, ucounts, sigqueue_flags);
 	return q;
 }
 


