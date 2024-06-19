Return-Path: <linux-kernel+bounces-220471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625290E228
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B11C212E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71B50280;
	Wed, 19 Jun 2024 04:07:36 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7821A04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770056; cv=none; b=tX2MOv1uJdMsta3uZ1Q8dAS6Xyyy2wGs1GzqcveMAV3ZfA1VzFDX/e6nv9qEoEma352VW0ahMoCEMjkSGRfHdnXcs38LhJbLPiyUqNiKFhq84YjaJHy/uUZ5uRptWQOjHFLCCeIV+O7f15fnCpBKQgQ8anxInIgI/S/6DNth+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770056; c=relaxed/simple;
	bh=K6Iay5pFDdcwxqEtxQTV2xD54wTqZzBwd5YUhYpkhPk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=tXSOCG6pkwGUTKUj6TNAMRDHJvr2gWq7b1xi6zyixsCGJCNUJ/tDOW7HbZQ3qebWuFTxiSTa9jvqZUUoiUGHYAvIf+eyYIL5SVOVGDZeqZW39SY1imqdhzHY3LuiWUJZVlM1k96xT5gKHsXAaLNxknh8XwG8tB+O/H9624CXbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42706)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmbd-00E6YB-Ni; Tue, 18 Jun 2024 22:07:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35360 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmbc-009Rcs-KZ; Tue, 18 Jun 2024 22:07:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Tejun Heo <tj@kernel.org>,
  linux-kernel@vger.kernel.org
References: <20240609142342.GA11165@redhat.com>
	<87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
	<20240610152902.GC20640@redhat.com>
	<20240613154541.GD18218@redhat.com>
	<87ikyamf4u.fsf@email.froward.int.ebiederm.org>
	<20240617183758.GB10753@redhat.com>
	<87iky5k2yi.fsf@email.froward.int.ebiederm.org>
	<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
Date: Tue, 18 Jun 2024 23:07:26 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87plsdh8xt.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmbc-009Rcs-KZ;;;mid=<87plsdh8xt.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/PErfWajg1E24d8ogSO60aQE13VchzCaU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 528 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.09
	(0.2%), extract_message_metadata: 13 (2.5%), get_uri_detail_list: 2.7
	(0.5%), tests_pri_-2000: 13 (2.5%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.28 (0.2%), tests_pri_-900: 1.04 (0.2%),
	tests_pri_-90: 86 (16.4%), check_bayes: 85 (16.0%), b_tokenize: 11
	(2.1%), b_tok_get_all: 9 (1.7%), b_comp_prob: 2.5 (0.5%),
	b_tok_touch_all: 58 (11.0%), b_finish: 1.09 (0.2%), tests_pri_0: 382
	(72.4%), check_dkim_signature: 0.87 (0.2%), check_dkim_adsp: 2.9
	(0.6%), poll_dns_idle: 0.81 (0.2%), tests_pri_10: 3.1 (0.6%),
	tests_pri_500: 10 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/17] signal: Add JOBCTL_WILL_EXIT to mark exiting tasks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Mark tasks that need to exit with JOBCTL_WILL_EXIT instead of reusing
the per thread SIGKILL.

A jobctl flag was choosen for this purpose because jobctl changes are
protected by siglock, and updates are already careful not to change or
clear other bits in jobctl.  Protection by a lock when changing the
value is necessary as JOBCTL_WILL_EXIT will not be limited to being
set by the current task.  That task->jobctl is protected by siglock is
convenient as siglock is already held everywhere I want to set or
reset JOBCTL_WILL_EXIT.

Instead of having __fatal_signal_pending test JOBCTL_WILL_EXIT
directly add a more accurately named helper task_will_exit to test
JOBCTL_WILL_EXIT that __fatal_signal_pending calls.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  4 ++--
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  7 ++++++-
 kernel/signal.c              | 11 ++++++-----
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index be0405346882..bec9e290802a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -373,7 +373,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	for_each_thread(start, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		if (!(t->flags & PF_POSTCOREDUMP)) {
-			sigaddset(&t->pending.signal, SIGKILL);
+			t->jobctl |= JOBCTL_WILL_EXIT;
 			signal_wake_up(t, 1);
 		}
 		nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);
@@ -396,7 +396,7 @@ static int zap_threads(struct task_struct *tsk,
 
 		/* Allow SIGKILL, see prepare_signal() */
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
-		sigdelset(&tsk->pending.signal, SIGKILL);
+		tsk->jobctl &= ~JOBCTL_WILL_EXIT;
 		tsk->flags |= PF_DUMPCORE;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index 68876d0a7ef9..2e840f2db746 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -23,6 +23,7 @@ struct task_struct;
 
 #define JOBCTL_STOPPED_BIT	26	/* do_signal_stop() */
 #define JOBCTL_TRACED_BIT	27	/* ptrace_stop() */
+#define JOBCTL_WILL_EXIT_BIT	31	/* task will exit */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -36,6 +37,7 @@ struct task_struct;
 
 #define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
 #define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+#define JOBCTL_WILL_EXIT	(1UL << JOBCTL_WILL_EXIT_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0a0e23c45406..33bf363a3354 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -393,9 +393,14 @@ static inline int signal_pending(struct task_struct *p)
 	return task_sigpending(p);
 }
 
+static inline bool task_exit_pending(struct task_struct *p)
+{
+	return unlikely(READ_ONCE(p->jobctl) & JOBCTL_WILL_EXIT);
+}
+
 static inline int __fatal_signal_pending(struct task_struct *p)
 {
-	return unlikely(sigismember(&p->pending.signal, SIGKILL));
+	return task_exit_pending(p);
 }
 
 static inline int fatal_signal_pending(struct task_struct *p)
diff --git a/kernel/signal.c b/kernel/signal.c
index 269ec88f650d..ea7753b31be7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -156,7 +156,8 @@ static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 
 static bool recalc_sigpending_tsk(struct task_struct *t)
 {
-	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) ||
+	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE |
+			  JOBCTL_WILL_EXIT)) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked) ||
 	    cgroup_task_frozen(t)) {
@@ -910,7 +911,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		if (signal->core_state && (sig == SIGKILL)) {
 			struct task_struct *dumper =
 				signal->core_state->dumper.task;
-			sigaddset(&dumper->pending.signal, SIGKILL);
+			dumper->jobctl |= JOBCTL_WILL_EXIT;
 			signal_wake_up(dumper, 1);
 		}
 		/*
@@ -1054,7 +1055,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_stop_count = 0;
 			__for_each_thread(signal, t) {
 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				sigaddset(&t->pending.signal, SIGKILL);
+				t->jobctl |= JOBCTL_WILL_EXIT;
 				signal_wake_up(t, 1);
 			}
 			return;
@@ -1383,7 +1384,7 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
-		sigaddset(&t->pending.signal, SIGKILL);
+		t->jobctl |= JOBCTL_WILL_EXIT;
 		signal_wake_up(t, 1);
 	}
 
@@ -2745,7 +2746,7 @@ bool get_signal(struct ksignal *ksig)
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
 		     signal->group_exec_task) {
 			signr = SIGKILL;
-			sigdelset(&current->pending.signal, SIGKILL);
+			current->jobctl &= ~JOBCTL_WILL_EXIT;
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
 					     &sighand->action[SIGKILL-1]);
 			recalc_sigpending();
-- 
2.41.0


