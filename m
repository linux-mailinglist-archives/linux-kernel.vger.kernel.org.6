Return-Path: <linux-kernel+bounces-220482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6C90E241
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432C91F2326D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F64C635;
	Wed, 19 Jun 2024 04:13:07 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E935588E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770387; cv=none; b=Gg61vlImK5gl5FzB3GgZWO5barehTn47NM4ubtG1M4xLWshzMI1mBj2oWNw+bEI58r3h96Nf2GyNuohJ2yamrS9EZ3Ve2z9FxzPUf+KvBXN+3ABcz5TzM1HklGB77PX+l7Tsss8YgYjgCGFAaTHtx4LYu5HpuK+Be6XjHMXHGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770387; c=relaxed/simple;
	bh=N5xqzhHiMn5sjodiwTiMky0jNsveAIIw19AeHh9JrSw=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=dzAhpnXUxnOzN58mHCShZpeUTQ0frseEEKbH4wVfqjCpNEuImdS2KJpT5Y8ETvM2BE2oF7O6BXQ3IaVaVLSalihSXK3uFAkY42wGLa3eeaR5uORP8SZpg1ea+8CTPlIKI5834K/lGyHpo5NKt5xo79Sxdye+dWnNzjig7y7C4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42776)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmgy-004PYQ-G3; Tue, 18 Jun 2024 22:13:04 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56222 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmgx-009SKN-DK; Tue, 18 Jun 2024 22:13:04 -0600
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
Date: Tue, 18 Jun 2024 23:12:56 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87y171efjr.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmgx-009SKN-DK;;;mid=<87y171efjr.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/Jyv22mqBP7c5a8A8XIKv6TJOQkl6JrFY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4894]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 443 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.5 (1.0%), b_tie_ro: 3.1 (0.7%), parse: 1.30
	(0.3%), extract_message_metadata: 11 (2.5%), get_uri_detail_list: 2.8
	(0.6%), tests_pri_-2000: 11 (2.4%), tests_pri_-1000: 1.80 (0.4%),
	tests_pri_-950: 1.06 (0.2%), tests_pri_-900: 0.78 (0.2%),
	tests_pri_-90: 55 (12.5%), check_bayes: 54 (12.3%), b_tokenize: 7
	(1.6%), b_tok_get_all: 7 (1.6%), b_comp_prob: 1.60 (0.4%),
	b_tok_touch_all: 36 (8.0%), b_finish: 0.75 (0.2%), tests_pri_0: 342
	(77.4%), check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 3.8
	(0.9%), poll_dns_idle: 1.49 (0.3%), tests_pri_10: 2.8 (0.6%),
	tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 16/17] signal: Record the exit_code when an exit is scheduled
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


With ptrace_stop no longer using task->exit_code it is safe
to set task->exit_code when an exit is scheduled.

Use the bit JOBCTL_WILL_EXIT to detect when a exit is first scheduled
and only set exit_code the first time.  Only use the code provided
to do_exit if the task has not yet been schedled to exit.

In get_signal and do_grup_exit when JOBCTL_WILL_EXIT is set read the
recored exit_code from current->exit_code, instead of assuming
exit_code will always be 0.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 2 +-
 include/linux/sched/signal.h | 2 +-
 kernel/exit.c                | 9 +++++----
 kernel/signal.c              | 7 ++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 57d617917b1c..99ee1a850c37 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1097,7 +1097,7 @@ static int de_thread(struct task_struct *tsk)
 		if (t == tsk)
 			continue;
 		sig->notify_count++;
-		schedule_task_exit_locked(t);
+		schedule_task_exit_locked(t, 0);
 	}
 
 	while (sig->notify_count) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 54b2b924aaea..bc702fd94a1f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -461,7 +461,7 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, state);
 }
 
-void schedule_task_exit_locked(struct task_struct *task);
+void schedule_task_exit_locked(struct task_struct *task, int exit_code);
 void schedule_group_exit_locked(struct signal_struct *signal, int exit_code);
 
 void task_join_group_stop(struct task_struct *task);
diff --git a/kernel/exit.c b/kernel/exit.c
index dc944e3c1493..2b4e57ff02a1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -795,13 +795,14 @@ static void check_stack_usage(void)
 static inline void check_stack_usage(void) {}
 #endif
 
-static void synchronize_group_exit(struct task_struct *tsk, long code)
+static int synchronize_group_exit(struct task_struct *tsk, long code)
 {
 	struct sighand_struct *sighand = tsk->sighand;
 	struct signal_struct *signal = tsk->signal;
 
 	spin_lock_irq(&sighand->siglock);
-	schedule_task_exit_locked(tsk);
+	schedule_task_exit_locked(tsk, code);
+	code = tsk->exit_code;
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
@@ -810,6 +811,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		signal->group_stop_count = 0;
 	}
 	spin_unlock_irq(&sighand->siglock);
+	return code;
 }
 
 void __noreturn do_exit(long code)
@@ -819,7 +821,7 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(irqs_disabled());
 
-	synchronize_group_exit(tsk, code);
+	code = synchronize_group_exit(tsk, code);
 
 	WARN_ON(tsk->plug);
 
@@ -856,7 +858,6 @@ void __noreturn do_exit(long code)
 		tty_audit_exit();
 	audit_free(tsk);
 
-	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
 	exit_mm();
diff --git a/kernel/signal.c b/kernel/signal.c
index dc9ab998fa15..c8b896bc84bb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1013,7 +1013,7 @@ void schedule_group_exit_locked(struct signal_struct *signal, int exit_code)
 	signal->group_exit_code = exit_code;
 	signal->group_stop_count = 0;
 	__for_each_thread(signal, t)
-		schedule_task_exit_locked(t);
+		schedule_task_exit_locked(t, exit_code);
 }
 
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
@@ -1373,11 +1373,12 @@ int force_sig_info(struct kernel_siginfo *info)
 	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
 }
 
-void schedule_task_exit_locked(struct task_struct *task)
+void schedule_task_exit_locked(struct task_struct *task, int exit_code)
 {
 	if (!(task->jobctl & JOBCTL_WILL_EXIT)) {
 		task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
 		task->jobctl |= JOBCTL_WILL_EXIT;
+		task->exit_code = exit_code;
 		signal_wake_up(task, true);
 	}
 }
@@ -2749,7 +2750,7 @@ bool get_signal(struct ksignal *ksig)
 			if (signal->flags & SIGNAL_GROUP_EXIT)
 				exit_code = signal->group_exit_code;
 			else
-				exit_code = 0;
+				exit_code = current->exit_code;
 			goto fatal;
 		}
 
-- 
2.41.0


