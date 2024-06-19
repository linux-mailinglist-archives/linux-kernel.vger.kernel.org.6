Return-Path: <linux-kernel+bounces-220476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B066F90E231
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AD328476A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471734CB4B;
	Wed, 19 Jun 2024 04:10:19 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9B1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770218; cv=none; b=JlQf0eczW/KmteYC31X/ltMGI13rdM940A2vuvanoHMgl5eabtATbq9axZYNqCrkQbACENZlAAZQg8QR6M088ZbV1tnYflQUi6UiE+iwsq5t5Z0QYFMC/P0Vrs0YWtic+gaGZm0FWqNxrBLLjG8EQjp0l2iPERge+ptGzsznlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770218; c=relaxed/simple;
	bh=V0wIUt5HPjbJ6P9U7BxdMTY3xdPgMdiqjjqtH60Ki9M=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=rt3waUfogv1Fd3FJ05bgXiTxDTASC1jzLHQH5myPWMYxcbiGygnA9zjYUEKgJHGLfPvxmRL7m13a6IxFCMuP+cqBvsLbIOmr3d2GQXCloOwPZv7az7OEij5bWMGn61rphBWhV48+Kz8OxqIC0BJ3znutU3IeXQMH50eAVmljKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:54274)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmeG-004POC-6s; Tue, 18 Jun 2024 22:10:16 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:47492 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmeF-009RwG-4t; Tue, 18 Jun 2024 22:10:15 -0600
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
Date: Tue, 18 Jun 2024 23:10:08 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87tthpfu8v.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmeF-009RwG-4t;;;mid=<87tthpfu8v.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18uezSPVsxUbrkq7vk2KmijE3ISWn2ED8w=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 395 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 15 (3.9%), b_tie_ro: 13 (3.3%), parse: 1.30
	(0.3%), extract_message_metadata: 14 (3.6%), get_uri_detail_list: 2.6
	(0.7%), tests_pri_-2000: 12 (3.0%), tests_pri_-1000: 2.2 (0.6%),
	tests_pri_-950: 1.40 (0.4%), tests_pri_-900: 1.18 (0.3%),
	tests_pri_-90: 84 (21.3%), check_bayes: 82 (20.8%), b_tokenize: 8
	(2.1%), b_tok_get_all: 9 (2.3%), b_comp_prob: 2.6 (0.7%),
	b_tok_touch_all: 57 (14.5%), b_finish: 1.36 (0.3%), tests_pri_0: 247
	(62.6%), check_dkim_signature: 0.59 (0.2%), check_dkim_adsp: 3.3
	(0.8%), poll_dns_idle: 1.63 (0.4%), tests_pri_10: 2.7 (0.7%),
	tests_pri_500: 9 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/17] signal: Make individual tasks exiting a first class
 concept
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Add a helper schedule_task_exit_locked that is equivalent to
asynchronously calling exit(2) except for not having an exit code.

This is a generalization of what happens in do_exit, de_thread,
zap_process, prepare_signal, complete_signal, and zap_other_threads
when individual tasks are asked to shutdown.

While schedule_task_exit_locked is a generalization of what happens in
prepare_signal I do not change prepare_signal to use
schedule_task_exit_locked to deliver SIGKILL to a coredumping process.
This keeps all of the specialness of delivering a signal to a
coredumping process limited to prepare_signal and the coredump code
itself.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  6 +-----
 include/linux/sched/signal.h |  2 ++
 kernel/exit.c                |  5 +----
 kernel/signal.c              | 25 +++++++++++--------------
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index bcef41ec69a9..dce91e5c121a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,11 +371,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
-		if (!(t->jobctl & JOBCTL_WILL_EXIT)) {
-			task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-			t->jobctl |= JOBCTL_WILL_EXIT;
-			signal_wake_up(t, 1);
-		}
+		schedule_task_exit_locked(t);
 		nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);
 	}
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 33bf363a3354..48b67162b38c 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -462,6 +462,8 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, state);
 }
 
+void schedule_task_exit_locked(struct task_struct *task);
+
 void task_join_group_stop(struct task_struct *task);
 
 #ifdef TIF_RESTORE_SIGMASK
diff --git a/kernel/exit.c b/kernel/exit.c
index 73eb3afbf083..902af3beb7cc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -801,10 +801,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct signal_struct *signal = tsk->signal;
 
 	spin_lock_irq(&sighand->siglock);
-	if (!(tsk->jobctl & JOBCTL_WILL_EXIT)) {
-		task_clear_jobctl_pending(tsk, JOBCTL_PENDING_MASK);
-		tsk->jobctl |= JOBCTL_WILL_EXIT;
-	}
+	schedule_task_exit_locked(tsk);
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 341717c6cc97..ac4ac3aeda0a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1056,11 +1056,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_exit_code = sig;
 			signal->group_stop_count = 0;
 			__for_each_thread(signal, t) {
-				if (!(t->jobctl & JOBCTL_WILL_EXIT)) {
-					task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-					t->jobctl |= JOBCTL_WILL_EXIT;
-					signal_wake_up(t, 1);
-				}
+				schedule_task_exit_locked(t);
 			}
 			return;
 		}
@@ -1371,6 +1367,15 @@ int force_sig_info(struct kernel_siginfo *info)
 	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
 }
 
+void schedule_task_exit_locked(struct task_struct *task)
+{
+	if (!(task->jobctl & JOBCTL_WILL_EXIT)) {
+		task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
+		task->jobctl |= JOBCTL_WILL_EXIT;
+		signal_wake_up(task, true);
+	}
+}
+
 /*
  * Nuke all other threads in the group.
  */
@@ -1383,16 +1388,8 @@ int zap_other_threads(struct task_struct *p)
 
 	for_other_threads(p, t) {
 		count++;
-
-		/* Only bother with threads that might be alive */
-		if (t->jobctl & JOBCTL_WILL_EXIT)
-			continue;
-
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		t->jobctl |= JOBCTL_WILL_EXIT;
-		signal_wake_up(t, 1);
+		schedule_task_exit_locked(t);
 	}
-
 	return count;
 }
 
-- 
2.41.0


