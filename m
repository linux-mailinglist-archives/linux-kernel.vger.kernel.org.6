Return-Path: <linux-kernel+bounces-220477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321790E239
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11962858F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368357CA6;
	Wed, 19 Jun 2024 04:10:45 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AB5674D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770245; cv=none; b=n3N4NOXuZG0b48rIsLb57q5xvnbIojnmNXcdRh0UBoOLgGuLezGfvPJuZaC+mzro5qRDwoO3gU3yAUca1NDwCcUzaguIasMZo9iZJyMq3Z+HitVYyVnI7Um3To5Pud31uRofLOAJf1WzsqJQeymr9aaT6ACy1hDOE8sHX90eyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770245; c=relaxed/simple;
	bh=45db+cBhok/OVJqOrcrMq9W2H4YzWN6x6K1kdcGkQJs=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ZyVhCJj0LEJw471D1aRetLS5S6feGxGq0+iY1OI5IfgWsTcrst4gX4Ry3E/smdBM9VBl+qx45iY3FXOwXdFXdO3cubaI41nYYs/g90ib3efvFZXxE7c7K+G11OYaagU3Z4FEjYf18eXJc12hPHfdP9+n2mQ6fyE8nH7EjGcSjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59680)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmeg-005ufz-Qr; Tue, 18 Jun 2024 22:10:42 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49564 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmef-009RzG-SJ; Tue, 18 Jun 2024 22:10:42 -0600
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
Date: Tue, 18 Jun 2024 23:10:34 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87o77xfu85.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmef-009RzG-SJ;;;mid=<87o77xfu85.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18+I/REcgM7LhAWKGG9i1btRuVe5W37LQY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4978]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 380 ms - load_scoreonly_sql: 0.11 (0.0%),
	signal_user_changed: 16 (4.1%), b_tie_ro: 13 (3.4%), parse: 1.52
	(0.4%), extract_message_metadata: 14 (3.8%), get_uri_detail_list: 2.2
	(0.6%), tests_pri_-2000: 12 (3.3%), tests_pri_-1000: 2.7 (0.7%),
	tests_pri_-950: 1.59 (0.4%), tests_pri_-900: 1.14 (0.3%),
	tests_pri_-90: 65 (17.0%), check_bayes: 63 (16.5%), b_tokenize: 9
	(2.5%), b_tok_get_all: 9 (2.4%), b_comp_prob: 1.95 (0.5%),
	b_tok_touch_all: 37 (9.8%), b_finish: 1.35 (0.4%), tests_pri_0: 251
	(66.2%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 3.3
	(0.9%), poll_dns_idle: 1.52 (0.4%), tests_pri_10: 2.2 (0.6%),
	tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 12/17] signal: Remove zap_other_threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


The three callers of zap_other_threads want different things. The
function do_group_exit wants to set the exit code and it does not care
about the number of threads exiting.  In de_thread the current thread
is not exiting so there is not really an exit code.

Since schedule_task_exit_locked factors out the tricky bits stop
sharing the loop in zap_other_threads between de_thread, get_signal
and do_group_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 12 +++++++++---
 include/linux/sched/signal.h |  1 -
 kernel/exit.c                |  9 ++++++++-
 kernel/signal.c              | 25 +++++++------------------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0d64313716bf..57d617917b1c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1072,6 +1072,7 @@ static int de_thread(struct task_struct *tsk)
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *t;
 
 	if (thread_group_empty(tsk))
 		goto no_thread_group;
@@ -1090,9 +1091,14 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	sig->group_exec_task = tsk;
-	sig->notify_count = zap_other_threads(tsk);
-	if (!thread_group_leader(tsk))
-		sig->notify_count--;
+	sig->group_stop_count = 0;
+	sig->notify_count = 0;
+	__for_each_thread(sig, t) {
+		if (t == tsk)
+			continue;
+		sig->notify_count++;
+		schedule_task_exit_locked(t);
+	}
 
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 48b67162b38c..250bd537aa6a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,7 +338,6 @@ extern void force_sig(int);
 extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
-extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
diff --git a/kernel/exit.c b/kernel/exit.c
index 902af3beb7cc..564bf17f4589 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1010,9 +1010,16 @@ do_group_exit(int exit_code)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
 		else {
+			struct task_struct *t;
+
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
-			zap_other_threads(current);
+			sig->group_stop_count = 0;
+			__for_each_thread(sig, t) {
+				if (t == current)
+					continue;
+				schedule_task_exit_locked(t);
+			}
 			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 		spin_unlock_irq(&sighand->siglock);
diff --git a/kernel/signal.c b/kernel/signal.c
index ac4ac3aeda0a..2b0f6d8baebb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1376,23 +1376,6 @@ void schedule_task_exit_locked(struct task_struct *task)
 	}
 }
 
-/*
- * Nuke all other threads in the group.
- */
-int zap_other_threads(struct task_struct *p)
-{
-	struct task_struct *t;
-	int count = 0;
-
-	p->signal->group_stop_count = 0;
-
-	for_other_threads(p, t) {
-		count++;
-		schedule_task_exit_locked(t);
-	}
-	return count;
-}
-
 struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 					   unsigned long *flags)
 {
@@ -2744,6 +2727,7 @@ bool get_signal(struct ksignal *ksig)
 	for (;;) {
 		bool group_exit_needed = false;
 		struct k_sigaction *ka;
+		struct task_struct *t;
 		enum pid_type type;
 		int exit_code;
 
@@ -2891,7 +2875,12 @@ bool get_signal(struct ksignal *ksig)
 		else {
 			signal->group_exit_code = exit_code;
 			signal->flags = SIGNAL_GROUP_EXIT;
-			zap_other_threads(current);
+			signal->group_stop_count = 0;
+			__for_each_thread(signal, t) {
+				if (t == current)
+					continue;
+				schedule_task_exit_locked(t);
+			}
 			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 	fatal:
-- 
2.41.0


