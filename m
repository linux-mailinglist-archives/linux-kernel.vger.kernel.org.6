Return-Path: <linux-kernel+bounces-220475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D21A90E230
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4F628447A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B650289;
	Wed, 19 Jun 2024 04:09:54 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16337700
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770194; cv=none; b=uIVs4UEV3WyC3awlX4p2SGKyIwTk+oe4yvECPWpc9gPZ0NVFQi90uXHi+Oqysdviu6wzyJWbkolhPH3WjfMd0zR91ZrSn5heA30Pzs6VYaPMr06AKzhwLGBIabsMLUH5pEs5t197/O/sEFXRP6TDgLo99Ql5GyHeVMFjh3sfMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770194; c=relaxed/simple;
	bh=W3pzOWYZJCJl1SnV1PqgzDFAFs70sGWEAYZOvp6wREc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=U9bzPrNrD+NRHnA5sYRHKI/NaOq3k3FUNdJ70Y8C1mr/DcUmi/ATvQhmTe3S64vsifTyM8gT28r8JnWaVnC1tCcNrt4Y4QhWLzo7M6WalEPqQx7ftkWhEMe8THw0mulAlRQzmHoO3/XP9H03Wd9lZPkO1iZOhHXv6hyrbnpge0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:52846)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmdr-00E6bM-Qr; Tue, 18 Jun 2024 22:09:51 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:45984 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmdq-009RsZ-Qm; Tue, 18 Jun 2024 22:09:51 -0600
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
Date: Tue, 18 Jun 2024 23:09:44 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87zfrhfu9j.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmdq-009RsZ-Qm;;;mid=<87zfrhfu9j.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/PC7QFBj9tG64nO2e/p6KeXGHe8TNQDvY=
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
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 402 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.5%), parse: 1.29
	(0.3%), extract_message_metadata: 15 (3.6%), get_uri_detail_list: 2.7
	(0.7%), tests_pri_-2000: 13 (3.1%), tests_pri_-1000: 2.3 (0.6%),
	tests_pri_-950: 1.24 (0.3%), tests_pri_-900: 0.96 (0.2%),
	tests_pri_-90: 64 (16.0%), check_bayes: 63 (15.6%), b_tokenize: 11
	(2.7%), b_tok_get_all: 7 (1.6%), b_comp_prob: 2.1 (0.5%),
	b_tok_touch_all: 40 (9.9%), b_finish: 0.94 (0.2%), tests_pri_0: 277
	(68.8%), check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 3.0
	(0.7%), poll_dns_idle: 1.20 (0.3%), tests_pri_10: 3.1 (0.8%),
	tests_pri_500: 10 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/17] signal: Only set JOBCTL_WILL_EXIT if it is not
 already set
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


The various code paths that set JOBCTL_WILL_EXIT optimize away setting
JOBCTL_WILL_EXIT and calling signal_wake_up based on different
conditions.  If the task has already committed itself to exiting by
setting JOBCTL_WILL_EXIT, setting JOBCTL_WILL_EXIT will accomplish
nothing.  So instead of using any of the original conditions only set
JOBCTL_WILL_EXIT when JOBCTL_WILL_EXIT is not set.

Additionally skip task_clear_jobctl_pending once JOBCTL_WILL_EXIT has
been set as task_set_jobctl_pending won't set any pending bits after
that.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c   |  4 ++--
 kernel/exit.c   |  5 ++++-
 kernel/signal.c | 21 +++++++++++++--------
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f3e363fa09a3..bcef41ec69a9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,8 +371,8 @@ static int zap_process(struct task_struct *start, int exit_code)
 	start->signal->group_stop_count = 0;
 
 	for_each_thread(start, t) {
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		if (!(t->flags & PF_POSTCOREDUMP)) {
+		if (!(t->jobctl & JOBCTL_WILL_EXIT)) {
+			task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 			t->jobctl |= JOBCTL_WILL_EXIT;
 			signal_wake_up(t, 1);
 		}
diff --git a/kernel/exit.c b/kernel/exit.c
index 0059c60946a3..73eb3afbf083 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -801,7 +801,10 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct signal_struct *signal = tsk->signal;
 
 	spin_lock_irq(&sighand->siglock);
-	tsk->jobctl |= JOBCTL_WILL_EXIT;
+	if (!(tsk->jobctl & JOBCTL_WILL_EXIT)) {
+		task_clear_jobctl_pending(tsk, JOBCTL_PENDING_MASK);
+		tsk->jobctl |= JOBCTL_WILL_EXIT;
+	}
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 12e552a35848..341717c6cc97 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -911,8 +911,10 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		if (signal->core_state && (sig == SIGKILL)) {
 			struct task_struct *dumper =
 				signal->core_state->dumper.task;
-			dumper->jobctl |= JOBCTL_WILL_EXIT;
-			signal_wake_up(dumper, 1);
+			if (!(dumper->jobctl & JOBCTL_WILL_EXIT)) {
+				dumper->jobctl |= JOBCTL_WILL_EXIT;
+				signal_wake_up(dumper, 1);
+			}
 		}
 		/*
 		 * The process is in the middle of dying, drop the signal.
@@ -1054,9 +1056,11 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 			signal->group_exit_code = sig;
 			signal->group_stop_count = 0;
 			__for_each_thread(signal, t) {
-				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-				t->jobctl |= JOBCTL_WILL_EXIT;
-				signal_wake_up(t, 1);
+				if (!(t->jobctl & JOBCTL_WILL_EXIT)) {
+					task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
+					t->jobctl |= JOBCTL_WILL_EXIT;
+					signal_wake_up(t, 1);
+				}
 			}
 			return;
 		}
@@ -1378,12 +1382,13 @@ int zap_other_threads(struct task_struct *p)
 	p->signal->group_stop_count = 0;
 
 	for_other_threads(p, t) {
-		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		count++;
 
-		/* Don't bother with already dead threads */
-		if (t->exit_state)
+		/* Only bother with threads that might be alive */
+		if (t->jobctl & JOBCTL_WILL_EXIT)
 			continue;
+
+		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		t->jobctl |= JOBCTL_WILL_EXIT;
 		signal_wake_up(t, 1);
 	}
-- 
2.41.0


