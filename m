Return-Path: <linux-kernel+bounces-315210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACB96BF3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39B02855CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC41DA619;
	Wed,  4 Sep 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssDyDsdT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741C1DA303
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458209; cv=none; b=hJhdRVJ4E2eevD1GI2Y/jfzpjyAEIsopX6TRi+XPgqyXnpMnE6w9FGcvVyHrP5JPNh2FZoj8fMKXX+IjisJs9KkuZ9JqVuRABmStCQAr47Mf/dHsvUsPU8NPPrMNIqpRR10EoyZGaKlin1CzJZMTN2hAl7tLa8wUtQJEr46hp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458209; c=relaxed/simple;
	bh=E0FsCaFyMhW52iOrP5SyPcoRqua6HK7yG5BBntvWWnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/ni5w3L/MZ2EH6gX4caFMwuhrZ5r8p5dt5BqRBtpzvB6u5FEqEforplqTUtHBNbbP0XR3gdDtu6AfiFVtk+xqzSdqZe7Th3isz3XhvDG1LhhU9iz0GIKG7qg3i38jphRlFLeYYK2ByLhKWtwQB/tNnnjNZziwmiK/MLK2UYv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ssDyDsdT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BNQC2oft7ujcNcjB+Mf1bIu6Q7qkj39qcMS6tmlwHIM=; b=ssDyDsdTF4MVfxkbgfBIIcR1BW
	npKHaUyEjA2qBq/OxyeJJ0a/TVkyBoP1K8dndDmvtHY21C8nt4ypbb6fA6zzPWz/0EpScDNpp8Nou
	W3LaRxB58Ts9h11XpSfXZn75RTb3dfohMF7OB0oBKMyhlbVrwJ6l/Dqd0aZCTirMfJwI6vun/+m5k
	smqH57oNkuefMVGxBMluW/1gieDasBEe61sWt5KrObkths8ABZUgBWIphiuOS24UrdGE0vjabhwDc
	UnFpzC9Qww90i6FKKsyB1JdaiNZyOnvDO+KL9xVXTCeLlGM/TolCjuqDDDrE9Qf4Y5fbVKNdQaTL/
	6r/BR+tA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slqUp-00000000wZM-2OEg;
	Wed, 04 Sep 2024 13:56:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0ACE300070; Wed,  4 Sep 2024 15:56:31 +0200 (CEST)
Date: Wed, 4 Sep 2024 15:56:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
Message-ID: <20240904135631.GJ4723@noisy.programming.kicks-ass.net>
References: <20240813222548.049744955@infradead.org>
 <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>

On Wed, Aug 21, 2024 at 05:41:32PM -0400, Joel Fernandes wrote:
> On Tue, Aug 13, 2024 at 6:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi,
> >
> > These patches apply on top of the EEVDF series (queue/sched/core), which
> > re-arranges the fair pick_task() functions to make them state invariant such
> > that they can easily be restarted upon picking (and dequeueing) a delayed task.
> >
> > This same is required to push (the final) put_prev_task() beyond pick_task(),
> > like we do for sched_core already.
> >
> > This in turn is done to prepare for sched_ext, which wants a final callback to
> > be in possesion of the next task, such that it can tell if the context switch
> > will leave the sched_class.
> >
> > As such, this all re-arranges the current order of:
> >
> >   put_prev_task(rq, prev);
> >   next = pick_next_task(rq); /* implies set_next_task(.first=true); */
> >
> > to sometihng like:
> >
> >   next = pick_task(rq)
> >   if (next != prev) {
> >     put_prev_task(rq, prev, next);
> >     set_next_task(rq, next, true);
> >   }
> >
> > The patches do a fair bit of cleaning up. Notably a bunch of sched_core stuff
> > -- Joel, could you please test this stuff, because the self-tests we have are
> > hardly adequate.
> >
> > The EEVDF stuff was supposed to be merged already, but since Valentin seems to
> > be doing a read-through, I figured I'd give him a little extra time. A complete
> > set can be found at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/prep
> >
> 
> So I booted queue.git sched/core branch on a newish Chromebook (after
> applying 700 patches for making it boot and spending 2 days on it
> since we boot old kernels -- I wasn't joking when I said I would carve
> some time up for you this week :P).
> 
> With sched/core , it boots fine with core scheduling disabled, but
> when core scheduling is enabled I am getting hard hangs and
> occasionally get to the login screen if I'm lucky. So there's
> definitely something wonky in sched/core branch and core sched.
> I could not get a trace or logs yet, since once it hangs I have to
> hard power off.
> 
> I could bissect it tomorrow though since it looks like a manageable
> set of patches on 6.11-rc1.  Or did you already figure out the issue?

Finally got around to poking sched_core with something sharp... the
below patch (on top of tip/sched/core) boots for me with
"sched_core_test".

I'm an idiot and the issue is very much the same as the one in:

  dfa0a574cbc4 ("sched/uclamg: Handle delayed dequeue")

I'll go write it up as a proper patch, but I'll probably also keep the
sched_core_test thing, its a useful hack for someone that doesn't have
suitable userspace (iow. me).


---
 include/linux/sched.h     |  7 +++++--
 kernel/fork.c             |  2 +-
 kernel/sched/core.c       | 14 ++++++++++++++
 kernel/sched/core_sched.c | 17 +++++++++++++++--
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 57cf27a3045c..db03f22abfee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2172,14 +2172,17 @@ unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SCHED_CORE
+extern int sched_core_test;
+extern unsigned long sched_core_alloc_cookie(void);
 extern void sched_core_free(struct task_struct *tsk);
-extern void sched_core_fork(struct task_struct *p);
+extern void sched_core_fork(unsigned long clone_flags, struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
 extern int sched_core_idle_cpu(int cpu);
 #else
+#define sched_core_test (0)
 static inline void sched_core_free(struct task_struct *tsk) { }
-static inline void sched_core_fork(struct task_struct *p) { }
+static inline void sched_core_fork(unsigned long clone_flags, struct task_struct *p) { }
 static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..064cd99db5b4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2515,7 +2515,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	klp_copy_process(p);
 
-	sched_core_fork(p);
+	sched_core_fork(clone_flags, p);
 
 	spin_lock(&current->sighand->siglock);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ffcd637dc8e4..49eb2e8ca64e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -259,6 +259,9 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 
 void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
+	if (p->se.sched_delayed)
+		return;
+
 	rq->core->core_task_seq++;
 
 	if (!p->core_cookie)
@@ -269,6 +272,9 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 
 void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (p->se.sched_delayed)
+		return;
+
 	rq->core->core_task_seq++;
 
 	if (sched_core_enqueued(p)) {
@@ -4613,6 +4619,14 @@ late_initcall(sched_core_sysctl_init);
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	__sched_fork(clone_flags, p);
+
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_test && !(clone_flags & CLONE_THREAD)) {
+		p->core_cookie = sched_core_alloc_cookie();
+		if (!p->core_cookie)
+			return -ENOMEM;
+	}
+#endif
 	/*
 	 * We mark the process as NEW here. This guarantees that
 	 * nobody will actually run it, and a signal or other external
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ef98a93eb1d..7cd40592e7b6 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,5 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+int sched_core_test;
+
+static int __init setup_sched_core_test(char *str)
+{
+	sched_core_test = 1;
+	return 0;
+}
+__setup("sched_core_test", setup_sched_core_test);
+
 /*
  * A simple wrapper around refcount. An allocated sched_core_cookie's
  * address is used to compute the cookie of the task.
@@ -8,7 +17,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
 
-static unsigned long sched_core_alloc_cookie(void)
+unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -107,9 +116,13 @@ static unsigned long sched_core_clone_cookie(struct task_struct *p)
 	return cookie;
 }
 
-void sched_core_fork(struct task_struct *p)
+void sched_core_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	RB_CLEAR_NODE(&p->core_node);
+
+	if (sched_core_test && !(clone_flags & CLONE_THREAD))
+		return;
+
 	p->core_cookie = sched_core_clone_cookie(current);
 }
 

