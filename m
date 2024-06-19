Return-Path: <linux-kernel+bounces-220472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBE90E229
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B564CB22B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB784C635;
	Wed, 19 Jun 2024 04:08:25 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2C1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770105; cv=none; b=QmElTDg36IsQp0NXYyFxlqS4K5Vh9cYebKTKWQSQbgLjG0s54ecMETSQtl5T1HGWbDn0BLHlQaZYyNvNM2imHG+UD2dTic3OPEZkdrHcEBZAPMmPVXpwkwOqnU7sFLTM1R5KsTPsWvKzVr7knB3h8fFu7rKJWJjewYbYrwClVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770105; c=relaxed/simple;
	bh=QH+DAI3nDRMv0sqQ0yqjwXEumeM6njYB9SC659wkAYA=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=WNL8lEUmF3eVemFuUlnP65EZbHK6ijz2jIB5zsVokDKahZl7TfZugfy9uciiXEKEDT9hWcSBFOv61UiVzMvAAzh6YYXrnYg+Vw9cQqejKkaeuzIKs7DAHya40tdZIcDpkUPUYCczmzVQSRSkngt/rGSAIDkjMs7ygw7krYSGwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:38394)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmcQ-005ucK-MC; Tue, 18 Jun 2024 22:08:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:40308 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmcP-009Rix-DV; Tue, 18 Jun 2024 22:08:22 -0600
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
Date: Tue, 18 Jun 2024 23:08:14 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87h6dph8wh.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmcP-009Rix-DV;;;mid=<87h6dph8wh.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+ENUfgGe2dDkLUgk0AlTk9w8VqTBFhMT4=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4987]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 424 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (1.1%), b_tie_ro: 3.4 (0.8%), parse: 1.23
	(0.3%), extract_message_metadata: 12 (2.9%), get_uri_detail_list: 2.9
	(0.7%), tests_pri_-2000: 11 (2.5%), tests_pri_-1000: 1.80 (0.4%),
	tests_pri_-950: 1.07 (0.3%), tests_pri_-900: 0.78 (0.2%),
	tests_pri_-90: 61 (14.4%), check_bayes: 60 (14.2%), b_tokenize: 7
	(1.7%), b_tok_get_all: 8 (1.9%), b_comp_prob: 1.76 (0.4%),
	b_tok_touch_all: 40 (9.4%), b_finish: 0.62 (0.1%), tests_pri_0: 317
	(74.9%), check_dkim_signature: 0.41 (0.1%), check_dkim_adsp: 3.2
	(0.8%), poll_dns_idle: 1.98 (0.5%), tests_pri_10: 2.2 (0.5%),
	tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/17] signal: Always set JOBCTL_WILL_EXIT for exiting tasks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


This is a semantic change.  Previously JOBCTL_WILL_EXIT replaced the
use of sigaddset(&t->pending.signal, SIGKILL) to mark tasks for
termination but was otherwise identical.  Now JOBCTL_WILL_EXIT once
set remains set (except possibly for the thread performing a
coredump).

Keeping JOBCTL_WILL_EXIT set makes it possible to detect and skip
unnecessary work when the decision has been made for a task to exit.

Getting there involves not clearing JOBCTL_WILL_EXIT when short
circuited signals are being processed, and setting JOBCTL_WILL_EXIT on
all tasks when SIGNAL_GROUP_EXIT is set.

Never clearing JOBCTL_WILL_EXIT requires updating ptrace_stop
so it will continue to stop in PTRACE_EVENT_EXIT.

Set JOBCTL_WILL_EXIT in coredump_finish so that it winds up on the
coredumping thread.  It was initially set in zap_process when all of
the tasks of the processed were asked to exit, and then cleared in
zap_threads so that the coredump thread can be killed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   |  1 +
 kernel/exit.c   |  2 ++
 kernel/signal.c | 20 ++++++++++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index bec9e290802a..c8b057724bf6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -443,6 +443,7 @@ static void coredump_finish(bool core_dumped)
 		current->signal->group_exit_code |= 0x80;
 	next = current->signal->core_state->dumper.next;
 	current->signal->core_state = NULL;
+	current->jobctl |= JOBCTL_WILL_EXIT;
 	spin_unlock_irq(&current->sighand->siglock);
 
 	while ((curr = next) != NULL) {
diff --git a/kernel/exit.c b/kernel/exit.c
index 08de33740b9c..0059c60946a3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -801,6 +801,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct signal_struct *signal = tsk->signal;
 
 	spin_lock_irq(&sighand->siglock);
+	tsk->jobctl |= JOBCTL_WILL_EXIT;
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
@@ -1012,6 +1013,7 @@ do_group_exit(int exit_code)
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
 			zap_other_threads(current);
+			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 		spin_unlock_irq(&sighand->siglock);
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index ea7753b31be7..d169b47775b0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2253,15 +2253,19 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
-	/*
-	 * After this point ptrace_signal_wake_up or signal_wake_up
-	 * will clear TASK_TRACED if ptrace_unlink happens or a fatal
-	 * signal comes in.  Handle previous ptrace_unlinks and fatal
-	 * signals here to prevent ptrace_stop sleeping in schedule.
-	 */
-	if (!current->ptrace || __fatal_signal_pending(current))
+	/* Do not stop if ptrace_unlink has happened. */
+	if (!current->ptrace)
+		return exit_code;
+
+	/* Do not stop in a killed task except for PTRACE_EVENT_EXIT */
+	if (task_exit_pending(current) &&
+	    ((exit_code >> 8) != PTRACE_EVENT_EXIT))
 		return exit_code;
 
+	/*
+	 * After this point ptrace_unlink or a fatal signal will clear
+	 * TASK_TRACED preventing ptrace_stop from sleeping.
+	 */
 	set_special_state(TASK_TRACED);
 	current->jobctl |= JOBCTL_TRACED;
 
@@ -2746,7 +2750,6 @@ bool get_signal(struct ksignal *ksig)
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
 		     signal->group_exec_task) {
 			signr = SIGKILL;
-			current->jobctl &= ~JOBCTL_WILL_EXIT;
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
 					     &sighand->action[SIGKILL-1]);
 			recalc_sigpending();
@@ -2889,6 +2892,7 @@ bool get_signal(struct ksignal *ksig)
 			signal->group_exit_code = exit_code;
 			signal->flags = SIGNAL_GROUP_EXIT;
 			zap_other_threads(current);
+			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
-- 
2.41.0


