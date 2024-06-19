Return-Path: <linux-kernel+bounces-220474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EDC90E22D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058142830C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AC41C69;
	Wed, 19 Jun 2024 04:09:20 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2154662
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770160; cv=none; b=S8/NcY7JIJD8FCeenMddFH1SedOSdRUVqCC6VQLldQGQH/cBqpwiQJn3OImqYXd8jM/75J8M+dYgvm5IhbTVpZXcI2/LjqVTKcEOYZptsOJ+lTPeRdPiTmWWo+0TqZgbCB8IH7NA0GIlMUt9lngKFWwpjR/yviySIpp1LEqBScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770160; c=relaxed/simple;
	bh=on75TvsnuOnLH39i72mJSk2U6xcE0g8EbXgYf5NSlh0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=jz6QEZWD+T7zOUqw3+ZYSDvfyvgFj6w4ynmf3nacIlemdxmHTIDAhw+U4FyF4hw1Fzz2nemfPxFHjoHwJNrJ7KdmLgS2x8TuzJovXb8vq49FyWA4wyD4ePo9LVGHjxAHt7IkN4ynJeX9BqtznDmLJOQXGigGd+b9Pm6I2q7+bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59772)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmdJ-00E6b0-Tq; Tue, 18 Jun 2024 22:09:17 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50614 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmdJ-009Rob-0L; Tue, 18 Jun 2024 22:09:17 -0600
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
Date: Tue, 18 Jun 2024 23:09:09 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <875xu5h8uy.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmdJ-009Rob-0L;;;mid=<875xu5h8uy.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/qO7lFALjLBQW/RXKc2YVN6kfltibVIdk=
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
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (3.4%), b_tie_ro: 10 (3.0%), parse: 1.20
	(0.4%), extract_message_metadata: 13 (4.0%), get_uri_detail_list: 1.95
	(0.6%), tests_pri_-2000: 13 (3.8%), tests_pri_-1000: 2.3 (0.7%),
	tests_pri_-950: 1.21 (0.4%), tests_pri_-900: 0.98 (0.3%),
	tests_pri_-90: 58 (17.3%), check_bayes: 56 (16.8%), b_tokenize: 7
	(2.1%), b_tok_get_all: 6 (1.9%), b_comp_prob: 1.88 (0.6%),
	b_tok_touch_all: 38 (11.4%), b_finish: 0.84 (0.3%), tests_pri_0: 216
	(65.0%), check_dkim_signature: 0.51 (0.2%), check_dkim_adsp: 2.7
	(0.8%), poll_dns_idle: 0.92 (0.3%), tests_pri_10: 2.9 (0.9%),
	tests_pri_500: 10 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/17] signal: Test for process exit or de_thread using
 task_exit_pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Replace "(sig->flags & SIGNAL_GROUP_EXIT || sig->group_exec_task)"
with "task_exit_pending(tsk)".

THis is just a code simplification.  Every case that sets
SIGNAL_GROUP_EXIT also sets JOBCTL_WILL_EXIT.  Similarly de_thread
sets JOBCTL_WILL_EXIT except for the one task that will exist
after exec.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   | 2 +-
 fs/exec.c       | 2 +-
 kernel/signal.c | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c8b057724bf6..f3e363fa09a3 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -389,7 +389,7 @@ static int zap_threads(struct task_struct *tsk,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+	if (!task_exit_pending(tsk)) {
 		signal->core_state = core_state;
 		nr = zap_process(tsk, exit_code);
 		atomic_set(&core_state->nr_threads, nr);
diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..0d64313716bf 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1080,7 +1080,7 @@ static int de_thread(struct task_struct *tsk)
 	 * Kill all other threads in the thread group.
 	 */
 	spin_lock_irq(lock);
-	if ((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task) {
+	if (task_exit_pending(tsk)) {
 		/*
 		 * Another group action in progress, just
 		 * return so that the signal is processed.
diff --git a/kernel/signal.c b/kernel/signal.c
index 5e67c00b9b30..12e552a35848 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2450,8 +2450,7 @@ static bool do_signal_stop(int signr)
 		WARN_ON_ONCE(signr & ~JOBCTL_STOP_SIGMASK);
 
 		if (!likely(current->jobctl & JOBCTL_STOP_DEQUEUED) ||
-		    unlikely(sig->flags & SIGNAL_GROUP_EXIT) ||
-		    unlikely(sig->group_exec_task))
+		    unlikely(task_exit_pending(current)))
 			return false;
 		/*
 		 * There is no group stop already in progress.  We must
@@ -2747,8 +2746,7 @@ bool get_signal(struct ksignal *ksig)
 		int exit_code;
 
 		/* Has this task already been marked for death? */
-		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
-		     signal->group_exec_task) {
+		if (task_exit_pending(current)) {
 			signr = SIGKILL;
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
 					     &sighand->action[SIGKILL-1]);
-- 
2.41.0


