Return-Path: <linux-kernel+bounces-220468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0D90E225
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D160C284353
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217E4CB4B;
	Wed, 19 Jun 2024 04:05:53 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880E21A04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769953; cv=none; b=eem9OKfpxuFf9wVJXERE0H3ClGICeUqWlGAxF1ee4V/77+IOSaJ3Zdm04kqVr8cveKTsnsGObrdcikK6jIeqQKqvdEqdDFUiWtk4dh3Ux8kN3++mAEXwDG+CSxB97klKQwU9hU0JB46pmH4U/JCENH7qY36pdoN7XGCEdnN4vTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769953; c=relaxed/simple;
	bh=0LXz04i9dTCWrESR46TDgV9Iu1PXvNJ+7B87yCnsHm4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=WbiSUDGMKQErgTUC9HtHMb25yUiFpKZjvoA8Z/wV+q3rIyza1KBg0d4MzE4ZhP6d7ONirZmH3jO4ZPELSiAVFtSR4rdbptgtuQiOSsrrP3FPktTiIH4PBivyiuQWCLSc4v1EVyVf+DBv3tLfCK8ZG2hLhUre1iffRZZuPJ5lUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:38232)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZy-00E6MB-UA; Tue, 18 Jun 2024 22:05:50 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48484 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZx-002rYB-W8; Tue, 18 Jun 2024 22:05:50 -0600
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
Date: Tue, 18 Jun 2024 23:05:42 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87cyodinl5.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmZx-002rYB-W8;;;mid=<87cyodinl5.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+Ab7xcdTCkx2xFp2VcowCNlPj2wJXhpwk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4990]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 374 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.6 (1.2%), b_tie_ro: 3.2 (0.9%), parse: 1.14
	(0.3%), extract_message_metadata: 11 (2.9%), get_uri_detail_list: 1.31
	(0.4%), tests_pri_-2000: 10 (2.8%), tests_pri_-1000: 1.79 (0.5%),
	tests_pri_-950: 1.01 (0.3%), tests_pri_-900: 0.76 (0.2%),
	tests_pri_-90: 120 (31.9%), check_bayes: 118 (31.5%), b_tokenize: 4.8
	(1.3%), b_tok_get_all: 5 (1.5%), b_comp_prob: 1.48 (0.4%),
	b_tok_touch_all: 103 (27.6%), b_finish: 0.74 (0.2%), tests_pri_0: 211
	(56.4%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 3.2
	(0.8%), poll_dns_idle: 1.83 (0.5%), tests_pri_10: 2.6 (0.7%),
	tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/17] signal: Compute the process exit_code in get_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)


In prepartion for moving the work of sys_exit and sys_group_exit into
get_signal compute exit_code in get_signal, make PF_SIGNALED depend on
the exit_code and pass the exit_code to do_group_exit.

Anytime there is a group exit the exit_code may differ from the signal
number.

To match the historical precedent as best I can make the exit_code 0
during exec. (The exit_code field would not have been set but probably
would have been left at a value of 0).

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e3662fff919a..392d802dbf61 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2738,6 +2738,7 @@ bool get_signal(struct ksignal *ksig)
 	for (;;) {
 		struct k_sigaction *ka;
 		enum pid_type type;
+		int exit_code;
 
 		/* Has this task already been marked for death? */
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
@@ -2751,6 +2752,10 @@ bool get_signal(struct ksignal *ksig)
 			 * implies do_group_exit() or return to PF_USER_WORKER,
 			 * no need to initialize ksig->info/etc.
 			 */
+			if (signal->flags & SIGNAL_GROUP_EXIT)
+				exit_code = signal->group_exit_code;
+			else
+				exit_code = 0;
 			goto fatal;
 		}
 
@@ -2872,15 +2877,17 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
+		/*
+		 * Anything else is fatal, maybe with a core dump.
+		 */
+		exit_code = signr;
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
 			cgroup_leave_frozen(true);
 
-		/*
-		 * Anything else is fatal, maybe with a core dump.
-		 */
-		current->flags |= PF_SIGNALED;
+		if (exit_code & 0x7f)
+			current->flags |= PF_SIGNALED;
 
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
@@ -2909,7 +2916,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(signr);
+		do_group_exit(exit_code);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.41.0


