Return-Path: <linux-kernel+bounces-220479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97790E23E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC871C226D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82A4CB4B;
	Wed, 19 Jun 2024 04:12:02 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052451E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770322; cv=none; b=HRC6UZWE7rwjlbNYA3zjUpCl1URL3+CttF5y3P6YlWr8mXVA64UEWfzETcPIuxI/EMgMDuqn/PtQ/72Y1jw26tDdeQgTk+uVHg2Bq8mBLNc0ChXWrI0Q/Yo37e5Z4PI3+DsH5YtXVcVcaXUjX7uofD+W6n5MwZk2An5HwYe6vyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770322; c=relaxed/simple;
	bh=vtmrOF5N4KhitX4HDnMLKIVY1v8F5yZrqYrbuDCbe5o=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=n1Azhd9dz4W6QsZH9Iy22cXuwFF5llVjEAMsOHaYdbgA91u+glIOuKHzDZxlGW65+/Dk6yaJ39JDMQpQU7eHmjPAF0nGKYDZW25jd+VwEmGYQDMX50C+S0l0YSgvs5NZj8DiuMhH4GrNxKl/40gRb6VdhI7vStCOjGqT1JGn0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35746)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmfu-004PQd-8P; Tue, 18 Jun 2024 22:11:58 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57468 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmfs-009S7c-Mh; Tue, 18 Jun 2024 22:11:57 -0600
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
Date: Tue, 18 Jun 2024 23:11:49 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87cyodfu62.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmfs-009S7c-Mh;;;mid=<87cyodfu62.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+l132/YIhjPoZqdGCn7BV7GUBu/unn59Y=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.5 XMGappySubj_01 Very gappy subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 982 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 14 (1.4%), b_tie_ro: 12 (1.2%), parse: 1.82
	(0.2%), extract_message_metadata: 20 (2.0%), get_uri_detail_list: 3.9
	(0.4%), tests_pri_-2000: 19 (2.0%), tests_pri_-1000: 3.3 (0.3%),
	tests_pri_-950: 1.71 (0.2%), tests_pri_-900: 1.30 (0.1%),
	tests_pri_-90: 537 (54.7%), check_bayes: 535 (54.5%), b_tokenize: 12
	(1.2%), b_tok_get_all: 476 (48.4%), b_comp_prob: 3.9 (0.4%),
	b_tok_touch_all: 39 (4.0%), b_finish: 1.26 (0.1%), tests_pri_0: 364
	(37.1%), check_dkim_signature: 0.83 (0.1%), check_dkim_adsp: 3.7
	(0.4%), poll_dns_idle: 1.22 (0.1%), tests_pri_10: 3.9 (0.4%),
	tests_pri_500: 11 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 14/17] signal: Factor out schedule_group_exit_locked
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Essentially the same code is present in zap_process, complete_signal,
do_group_exit and get_signal.  Place that code in a function and call
it signal_group_exit_locked.  Call signal_group_exit_locked instead of
repeat the sequence inline 4 different times.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                |  8 ++------
 include/linux/sched/signal.h |  1 +
 kernel/exit.c                | 11 ++--------
 kernel/signal.c              | 40 ++++++++++++++++++------------------
 4 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index dce91e5c121a..aba72f1d170a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -366,14 +366,10 @@ static int zap_process(struct task_struct *start, int exit_code)
 	struct task_struct *t;
 	int nr = 0;
 
-	start->signal->flags = SIGNAL_GROUP_EXIT;
-	start->signal->group_exit_code = exit_code;
-	start->signal->group_stop_count = 0;
+	schedule_group_exit_locked(start->signal, exit_code);
 
-	for_each_thread(start, t) {
-		schedule_task_exit_locked(t);
+	for_each_thread(start, t)
 		nr += (t != current) && !(t->flags & PF_POSTCOREDUMP);
-	}
 
 	return nr;
 }
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 250bd537aa6a..54b2b924aaea 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -462,6 +462,7 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 }
 
 void schedule_task_exit_locked(struct task_struct *task);
+void schedule_group_exit_locked(struct signal_struct *signal, int exit_code);
 
 void task_join_group_stop(struct task_struct *task);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 471af82376e5..35452e822cc9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1009,15 +1009,8 @@ do_group_exit(int exit_code)
 		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
-		else {
-			struct task_struct *t;
-
-			sig->group_exit_code = exit_code;
-			sig->flags = SIGNAL_GROUP_EXIT;
-			sig->group_stop_count = 0;
-			__for_each_thread(sig, t)
-				schedule_task_exit_locked(t);
-		}
+		else
+			schedule_group_exit_locked(sig, exit_code);
 		spin_unlock_irq(&sighand->siglock);
 	}
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 8ae6d6550e82..fe1d46b00e9f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -999,6 +999,23 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !task_sigpending(p);
 }
 
+void schedule_group_exit_locked(struct signal_struct *signal, int exit_code)
+{
+	/*
+	 * Start a group exit and wake everybody up.
+	 * This way we don't have other threads
+	 * running and doing things after a slower
+	 * thread has the fatal signal pending.
+	 */
+	struct task_struct *t;
+
+	signal->flags = SIGNAL_GROUP_EXIT;
+	signal->group_exit_code = exit_code;
+	signal->group_stop_count = 0;
+	__for_each_thread(signal, t)
+		schedule_task_exit_locked(t);
+}
+
 static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
@@ -1046,18 +1063,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 		 * This signal will be fatal to the whole group.
 		 */
 		if (!sig_kernel_coredump(sig)) {
-			/*
-			 * Start a group exit and wake everybody up.
-			 * This way we don't have other threads
-			 * running and doing things after a slower
-			 * thread has the fatal signal pending.
-			 */
-			signal->flags = SIGNAL_GROUP_EXIT;
-			signal->group_exit_code = sig;
-			signal->group_stop_count = 0;
-			__for_each_thread(signal, t) {
-				schedule_task_exit_locked(t);
-			}
+			schedule_group_exit_locked(signal, sig);
 			return;
 		}
 	}
@@ -2727,7 +2733,6 @@ bool get_signal(struct ksignal *ksig)
 	for (;;) {
 		bool group_exit_needed = false;
 		struct k_sigaction *ka;
-		struct task_struct *t;
 		enum pid_type type;
 		int exit_code;
 
@@ -2872,13 +2877,8 @@ bool get_signal(struct ksignal *ksig)
 		exit_code = signr;
 		if (sig_kernel_coredump(signr))
 			group_exit_needed = true;
-		else {
-			signal->group_exit_code = exit_code;
-			signal->flags = SIGNAL_GROUP_EXIT;
-			signal->group_stop_count = 0;
-			__for_each_thread(signal, t)
-				schedule_task_exit_locked(t);
-		}
+		else
+			schedule_group_exit_locked(signal, exit_code);
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
-- 
2.41.0


