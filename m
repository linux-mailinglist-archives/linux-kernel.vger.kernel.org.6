Return-Path: <linux-kernel+bounces-220480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674390E23F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F231F24270
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72021E878;
	Wed, 19 Jun 2024 04:12:25 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A03C099
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770345; cv=none; b=Tjr/NrBDgH5Msoe+m6ph+Y4KRUSfFin65JdpOrMQvpT3qSGMGjOBGAFoaQEAAfIiuy99/prjceFWAJVWJK7uyxG0+cyLP2nPJ9xcXhHtqafGPpGtBLbcTXQr0GKU/EKRgN9+ha64aj+qPtm9dU+GWfrC2UsgFXBfXGPyNeV7GNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770345; c=relaxed/simple;
	bh=sUrNmkLXmK66eGoLP0Q3kuFYnsriY9zdRjT2aEhy/pY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=aYBu7C4j8M4aot96sn2MWeIyg0jpEErSdhSCDX/Fh/fluG/msEWIHKsDPI/JtZAYqCdxjB22ZouJgllwq+j4NtFW6a5iXtxzVTq6YWmtIOFwu1ZIQjvfxO48Rt7xrGxgssqnDVt98ZwqeZgMOacv5ar0SLBjtwSKqOXYDxacuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:39140)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmgI-005up4-G8; Tue, 18 Jun 2024 22:12:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:59068 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmgH-009SG7-1S; Tue, 18 Jun 2024 22:12:22 -0600
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
Date: Tue, 18 Jun 2024 23:12:12 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <877celfu5f.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmgH-009SG7-1S;;;mid=<877celfu5f.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18H0Aorairo9gNKQotFHiRTRk8CwDTc7a0=
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
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.4 XMBrknScrpt_02 Possible Broken Spam Script
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 874 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 12 (1.4%), b_tie_ro: 11 (1.2%), parse: 1.30
	(0.1%), extract_message_metadata: 15 (1.8%), get_uri_detail_list: 4.5
	(0.5%), tests_pri_-2000: 13 (1.5%), tests_pri_-1000: 2.3 (0.3%),
	tests_pri_-950: 1.26 (0.1%), tests_pri_-900: 0.97 (0.1%),
	tests_pri_-90: 323 (37.0%), check_bayes: 321 (36.8%), b_tokenize: 14
	(1.5%), b_tok_get_all: 11 (1.3%), b_comp_prob: 3.2 (0.4%),
	b_tok_touch_all: 289 (33.1%), b_finish: 1.17 (0.1%), tests_pri_0: 489
	(56.0%), check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 3.0
	(0.3%), poll_dns_idle: 1.27 (0.1%), tests_pri_10: 3.0 (0.3%),
	tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 15/17] ptrace: Separate task->ptrace_code out from
 task->exit_code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


A process can be marked for death by setting SIGNAL_GROUP_EXIT and
group_exit_code, long before do_exit is called.  Unfortunately because
of PTRACE_EVENT_EXIT residing in do_exit this same tactic can not be
used for task death.

Correct this by adding a new task field task->ptrace_code that holds
the code for ptrace stops.  This allows task->exit_code to be set to
the exit code long before the PTRACE_EVENT_EXIT ptrace stop.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/array.c       |  3 +++
 include/linux/sched.h |  1 +
 kernel/exit.c         |  2 +-
 kernel/ptrace.c       | 12 ++++++------
 kernel/signal.c       | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..b1c1d1f2bda8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -525,6 +525,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
+		if (task_is_traced(task) && !(task->jobctl & JOBCTL_LISTENING))
+			exit_code = task->ptrace_code;
+
 		if (whole) {
 			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
 				exit_code = sig->group_exit_code;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..0995775cd065 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1213,6 +1213,7 @@ struct task_struct {
 	/* Ptrace state: */
 	unsigned long			ptrace_message;
 	kernel_siginfo_t		*last_siginfo;
+	int				ptrace_code;
 
 	struct task_io_accounting	ioac;
 #ifdef CONFIG_PSI
diff --git a/kernel/exit.c b/kernel/exit.c
index 35452e822cc9..dc944e3c1493 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1199,7 +1199,7 @@ static int *task_stopped_code(struct task_struct *p, bool ptrace)
 {
 	if (ptrace) {
 		if (task_is_traced(p) && !(p->jobctl & JOBCTL_LISTENING))
-			return &p->exit_code;
+			return &p->ptrace_code;
 	} else {
 		if (p->signal->flags & SIGNAL_STOP_STOPPED)
 			return &p->signal->group_exit_code;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..9f8022e55eb7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -162,7 +162,7 @@ void __ptrace_unlink(struct task_struct *child)
 
 static bool looks_like_a_spurious_pid(struct task_struct *task)
 {
-	if (task->exit_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
+	if (task->ptrace_code != ((PTRACE_EVENT_EXEC << 8) | SIGTRAP))
 		return false;
 
 	if (task_pid_vnr(task) == task->ptrace_message)
@@ -578,7 +578,7 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
 	 * tasklist_lock avoids the race with wait_task_stopped(), see
 	 * the comment in ptrace_resume().
 	 */
-	child->exit_code = data;
+	child->ptrace_code = data;
 	__ptrace_detach(current, child);
 	write_unlock_irq(&tasklist_lock);
 
@@ -851,16 +851,16 @@ static int ptrace_resume(struct task_struct *child, long request,
 	}
 
 	/*
-	 * Change ->exit_code and ->state under siglock to avoid the race
-	 * with wait_task_stopped() in between; a non-zero ->exit_code will
+	 * Change ->ptrace_code and ->state under siglock to avoid the race
+	 * with wait_task_stopped() in between; a non-zero ->ptrace_code will
 	 * wrongly look like another report from tracee.
 	 *
-	 * Note that we need siglock even if ->exit_code == data and/or this
+	 * Note that we need siglock even if ->ptrace_code == data and/or this
 	 * status was not reported yet, the new status must not be cleared by
 	 * wait_task_stopped() after resume.
 	 */
 	spin_lock_irq(&child->sighand->siglock);
-	child->exit_code = data;
+	child->ptrace_code = data;
 	child->jobctl &= ~JOBCTL_TRACED;
 	wake_up_state(child, __TASK_TRACED);
 	spin_unlock_irq(&child->sighand->siglock);
diff --git a/kernel/signal.c b/kernel/signal.c
index fe1d46b00e9f..dc9ab998fa15 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2193,7 +2193,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  		info.si_status = tsk->signal->group_exit_code & 0x7f;
  		break;
  	case CLD_TRAPPED:
- 		info.si_status = tsk->exit_code & 0x7f;
+		info.si_status = tsk->ptrace_code & 0x7f;
  		break;
  	default:
  		BUG();
@@ -2223,7 +2223,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * with.  If the code did not stop because the tracer is gone,
  * the stop signal remains unchanged unless clear_code.
  */
-static int ptrace_stop(int exit_code, int why, unsigned long message,
+static int ptrace_stop(int code, int why, unsigned long message,
 		       kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
@@ -2246,12 +2246,12 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 
 	/* Do not stop if ptrace_unlink has happened. */
 	if (!current->ptrace)
-		return exit_code;
+		return code;
 
 	/* Do not stop in a killed task except for PTRACE_EVENT_EXIT */
 	if (task_exit_pending(current) &&
-	    ((exit_code >> 8) != PTRACE_EVENT_EXIT))
-		return exit_code;
+	    ((code >> 8) != PTRACE_EVENT_EXIT))
+		return code;
 
 	/*
 	 * After this point ptrace_unlink or a fatal signal will clear
@@ -2282,7 +2282,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 
 	current->ptrace_message = message;
 	current->last_siginfo = info;
-	current->exit_code = exit_code;
+	current->ptrace_code = code;
 
 	/*
 	 * If @why is CLD_STOPPED, we're trapping to participate in a group
@@ -2361,10 +2361,10 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	exit_code = current->exit_code;
+	code = current->ptrace_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
-	current->exit_code = 0;
+	current->ptrace_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN);
@@ -2375,7 +2375,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
 	recalc_sigpending_tsk(current);
-	return exit_code;
+	return code;
 }
 
 static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
@@ -2535,11 +2535,11 @@ static bool do_signal_stop(int signr)
  *
  * When PT_SEIZED, it's used for both group stop and explicit
  * SEIZE/INTERRUPT traps.  Both generate PTRACE_EVENT_STOP trap with
- * accompanying siginfo.  If stopped, lower eight bits of exit_code contain
+ * accompanying siginfo.  If stopped, lower eight bits of ptrace_code contain
  * the stop signal; otherwise, %SIGTRAP.
  *
  * When !PT_SEIZED, it's used only for group stop trap with stop signal
- * number as exit_code and no siginfo.
+ * number as ptrace_code and no siginfo.
  *
  * CONTEXT:
  * Must be called with @current->sighand->siglock held, which may be
-- 
2.41.0


