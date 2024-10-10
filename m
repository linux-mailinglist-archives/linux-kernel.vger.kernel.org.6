Return-Path: <linux-kernel+bounces-359918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C5999276
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1811F2233F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ACC1CEEA4;
	Thu, 10 Oct 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Crtv+8Yz"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB2198E75
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589043; cv=none; b=f1IhVijo9U3QKZrRzBs7s85mKH+7FQiICilkrBiFvI78eUA8v09WlRA2KBe/bb/dT+TDf0tzOchLsJG/pxePmhqF1aVMcyLwKnHRx4JWjzQ6rvIg7dWFTguDeh8XvMyQ8wU4ip7W4oXUgABvZ+JHfRbH+ABY2EUrDpvTlRMNi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589043; c=relaxed/simple;
	bh=kyK9IfIumtMxOBKf01YQ/Yv4b7sj1pM8kXYoi3jPLzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soS+DUqiNLlF2WtOufkZuV7tGp8kZjXy0/in6qAyukmk2T3qXQW9WeLcgk44ytFQEpLOyRey2qDRHYT90dir7gAtSA3XhpCNSlrIDZHPpSQRSyPMQIfgHAFRt3aO+r8Phet9NEvX9AdsQJr/IKzOh/1jYy9+Qz7DqAuouXH6vNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Crtv+8Yz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b111003738so86309985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728589038; x=1729193838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsLHGAEjqDtfYrDyUfOa/QAzf3Oef5x5SfIBxktNMGQ=;
        b=Crtv+8YzUbxWy0+/TSre7AXPxLZUSWLWdHLd65GsEXvVYuzAcJl9Q9Jr95hvLy5wBK
         f23lymG+3Bur/JcNBOH/Qg2TNR/j0g7zK8bGfWElYCL3R4NhNaHdlEGfnazbcjE635XM
         puptpEHD1Ep6s47a4TmRjxijdzTGJJ7klkiv60maABzlVrM0gZ2//b/T2L2cxFFR9zI6
         l0TYB0zsIBO8uHW8nnt9WqiaPZyhNH60zeQOpe+SgvUwLlhPZDN9ZAwSFJ3Essm22F7j
         hPF9IBrebgTZE5QwhKJ5NDkQ7NRVHl0EuG+O0kQRKgVKpXmw2axZanEUAtI4YKhr33UU
         wFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589038; x=1729193838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsLHGAEjqDtfYrDyUfOa/QAzf3Oef5x5SfIBxktNMGQ=;
        b=xO3eZmuaSnd3AyAmpt791lyS1nPKfpxPwKuGsIgRIExdpEv3FwYOA5t4c5wzDRYgrN
         tdaIgri0ERQ5JrPsteY2bLTuE36+GIPGEy9xsWFdbOkaP9R4jV4x3qlz7Zc8rRkVyFJ5
         JIK/l2lZ7rXdgGSdbTjlLN8/TRxQFOmR4GlLYMYAE2fXsO95V3UwLFFbNqMeWvu38i3s
         gVBtk/NAZYLnBetLW4L6EIacOFqwCHrQtGYDJHqB1P1l8CJa3V+FA5GFL5KSEvIC1AwE
         z4M0YiqwJUzeM9mI3OYvESUeWAwwkIO91NIbQtGal9bez955NNEesoa/61uCcuVG65tb
         phpA==
X-Forwarded-Encrypted: i=1; AJvYcCUFv/B6tav9aPwRBy8NfQlGvkkHK3w0L03LmV0B4lqj7rpjoRmaSNTiLh60/Bh/BOV/Wqx7IMzrpBrHXyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMW8tRfGf9uC+kw7mEn7Dne5fY3E5UeLdaLVYo30WgZrqqxtl
	ubkP+hp99fcMaIPMCsFPWUEeXhVkBYIvHCQtt5hFDMEUbg+TOewN7uHL+3dLfPY=
X-Google-Smtp-Source: AGHT+IHj5PGC9osLeQUv9ktZgVhXRPSB6Fwv1DjqQyk86AtXgSdlA2G2TojPVocEWliGjaTLX//pTw==
X-Received: by 2002:a05:620a:450c:b0:7b1:171a:5abf with SMTP id af79cd13be357-7b11a3ad759mr40640685a.45.1728589038183;
        Thu, 10 Oct 2024 12:37:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148df5d6sm72055985a.31.2024.10.10.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:37:17 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:37:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Message-ID: <20241010193712.GC181795@cmpxchg.org>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010130621.GH17263@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 03:06:21PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 09:03:16AM -0400, Johannes Weiner wrote:
> 
> > I'll try to come up with a suitable solution as well, please don't
> > apply this one for now.
> 
> I'll make sure it doesn't end up in tip as-is.

Thanks.

This would be a replacement patch for #2 and #3 that handles migration
of delayed tasks. It's slightly more invasive on the psi callback
side, but I think it keeps the sched core bits simpler. Thoughts?

---

From d72a665d7c7c7d9c806424f473d13452754471d3 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 10 Oct 2024 14:37:43 -0400
Subject: [PATCH] sched: psi: handle delayed-dequeue task migration

Since sched_delayed tasks remain queued even after blocking, the load
balancer can migrate them between runqueues while PSI considers them
to be asleep. As a result, it misreads the migration requeue followed
by a wakeup as a double queue:

  psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=. set=4

First, call psi_enqueue() after p->sched_class->enqueue_task(). A
wakeup will clear p->se.sched_delayed while a migration will not, so
psi can use that flag to tell them apart.

Then teach psi to migrate any "sleep" state when delayed-dequeue tasks
are being migrated.

Delayed-dequeue tasks can be revived by ttwu_runnable(), which will
call down with a new ENQUEUE_DELAYED. Instead of further complicating
the wakeup conditional in enqueue_task(), identify migration contexts
instead and default to wakeup handling for all other cases.

Debugged-by-and-original-fix-by: K Prateek Nayak <kprateek.nayak@amd.com>
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Link: https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/core.c  | 12 +++++------
 kernel/sched/stats.h | 48 ++++++++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88cbfc671fb6..527502a86ff9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,11 +2012,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
-		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
-	}
-
 	p->sched_class->enqueue_task(rq, p, flags);
 	/*
 	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
@@ -2024,6 +2019,11 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
+	if (!(flags & ENQUEUE_RESTORE)) {
+		sched_info_enqueue(rq, p);
+		psi_enqueue(p, flags & ENQUEUE_MIGRATED);
+	}
+
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
 }
@@ -2041,7 +2041,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	if (!(flags & DEQUEUE_SAVE)) {
 		sched_info_dequeue(rq, p);
-		psi_dequeue(p, flags & DEQUEUE_SLEEP);
+		psi_dequeue(p, !(flags & DEQUEUE_SLEEP));
 	}
 
 	/*
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780aa3c53..767e098a3bd1 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -119,45 +119,63 @@ static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
- * where a task's runnable state changes, and requeues, where a task
- * and its state are being moved between CPUs and runqueues.
+ * where a task's runnable state changes, and migrations, where a task
+ * and its runnable state are being moved between CPUs and runqueues.
+ *
+ * A notable case is a task whose dequeue is delayed. PSI considers
+ * those sleeping, but because they are still on the runqueue they can
+ * go through migration requeues. In this case, *sleeping* states need
+ * to be transferred.
  */
-static inline void psi_enqueue(struct task_struct *p, bool wakeup)
+static inline void psi_enqueue(struct task_struct *p, bool migrate)
 {
-	int clear = 0, set = TSK_RUNNING;
+	int clear = 0, set = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (p->in_memstall)
-		set |= TSK_MEMSTALL_RUNNING;
-
-	if (!wakeup) {
+	if (p->se.sched_delayed) {
+		/* CPU migration of "sleeping" task */
+		SCHED_WARN_ON(!migrate);
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
+		if (p->in_iowait)
+			set |= TSK_IOWAIT;
+	} else if (migrate) {
+		/* CPU migration of runnable task */
+		set = TSK_RUNNING;
+		if (p->in_memstall)
+			set |= TSK_MEMSTALL | TSK_MEMSTALL_RUNNING;
 	} else {
+		/* Wakeup of new or sleeping task */
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
+		set = TSK_RUNNING;
+		if (p->in_memstall)
+			set |= TSK_MEMSTALL_RUNNING;
 	}
 
 	psi_task_change(p, clear, set);
 }
 
-static inline void psi_dequeue(struct task_struct *p, bool sleep)
+static inline void psi_dequeue(struct task_struct *p, bool migrate)
 {
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/*
+	 * When migrating a task to another CPU, clear all psi
+	 * state. The enqueue callback above will work it out.
+	 */
+	if (migrate)
+		psi_task_change(p, p->psi_flags, 0);
+
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
-	if (sleep)
-		return;
-
-	psi_task_change(p, p->psi_flags, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
@@ -190,8 +208,8 @@ static inline void psi_sched_switch(struct task_struct *prev,
 }
 
 #else /* CONFIG_PSI */
-static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
-static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
+static inline void psi_enqueue(struct task_struct *p, bool migrate) {}
+static inline void psi_dequeue(struct task_struct *p, bool migrate) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
-- 
2.46.2


