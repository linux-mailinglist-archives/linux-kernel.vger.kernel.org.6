Return-Path: <linux-kernel+bounces-220483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3AA90E242
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B031C226F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7350280;
	Wed, 19 Jun 2024 04:13:34 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F42A8D3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770414; cv=none; b=IErIPrvHMIvCc6zcVl9dur7xrM5l78r/Y8DPNafJkqEbv6M87mutfHPeyaYf5aGOekxLCHNsV1WgsBJAdZwxdETUt+JFLkgG7C2YwWiTV2LFvn0UB3yxvIXfhGs/Mxy6+CA8H4maednz05j3oz6gK8iv+91eHB7PnZAzWJ/0owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770414; c=relaxed/simple;
	bh=uI2aHM4hUVaJa/MTUb83cPxMZqUtYAayeTzix/5VaDQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=DZYidfIBR+ApL4uC5RboiaHgRyELee6caHXG5LvRdjnWwpcOB6I2JMSlVWxzSxvoy1v8o4IQ6hhf6w7l4QmX2PQ3S13mIhXIdK9J9NmjGKYl5oAbJNQyVfkZY3eaZOoC/R5R6i21Qkc7oomGi96XijxY0Hgt/B1M9Wrqi/W+KYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42400)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmhQ-005uro-4N; Tue, 18 Jun 2024 22:13:32 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:51064 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmhO-009SNH-E2; Tue, 18 Jun 2024 22:13:31 -0600
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
Date: Tue, 18 Jun 2024 23:13:22 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87sex9efj1.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmhO-009SNH-E2;;;mid=<87sex9efj1.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+0SSFViOftj1kkcdetOJH4HiMXICFn8N8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 324 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.5 (1.4%), b_tie_ro: 3.1 (0.9%), parse: 1.15
	(0.4%), extract_message_metadata: 12 (3.7%), get_uri_detail_list: 1.89
	(0.6%), tests_pri_-2000: 10 (3.2%), tests_pri_-1000: 1.79 (0.6%),
	tests_pri_-950: 1.03 (0.3%), tests_pri_-900: 0.77 (0.2%),
	tests_pri_-90: 55 (17.1%), check_bayes: 54 (16.7%), b_tokenize: 5
	(1.6%), b_tok_get_all: 5 (1.6%), b_comp_prob: 1.28 (0.4%),
	b_tok_touch_all: 39 (12.2%), b_finish: 0.71 (0.2%), tests_pri_0: 226
	(69.8%), check_dkim_signature: 0.39 (0.1%), check_dkim_adsp: 3.6
	(1.1%), poll_dns_idle: 1.71 (0.5%), tests_pri_10: 1.74 (0.5%),
	tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 17/17] signal: Set SIGNAL_GROUP_EXIT when all tasks have
 decided to exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Move the quick_threads decrement from synchronize_group_exit into
schedule_task_exit_locked allowing quick_threads to be decremented
when the decision is made for a task to exit.

Set SIGNAL_GROUP_EXIT, group_exit_code, and group_stop_code when the
decision is made that the last thread will exit.  This makes the
information available earlier and so the kernel needs to do less work
when a process is exiting.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   |  8 --------
 kernel/signal.c | 10 +++++++---
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2b4e57ff02a1..ba48124f9bc9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -798,18 +798,10 @@ static inline void check_stack_usage(void) {}
 static int synchronize_group_exit(struct task_struct *tsk, long code)
 {
 	struct sighand_struct *sighand = tsk->sighand;
-	struct signal_struct *signal = tsk->signal;
 
 	spin_lock_irq(&sighand->siglock);
 	schedule_task_exit_locked(tsk, code);
 	code = tsk->exit_code;
-	signal->quick_threads--;
-	if ((signal->quick_threads == 0) &&
-	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
-		signal->flags = SIGNAL_GROUP_EXIT;
-		signal->group_exit_code = code;
-		signal->group_stop_count = 0;
-	}
 	spin_unlock_irq(&sighand->siglock);
 	return code;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index c8b896bc84bb..59e0c5505d76 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1009,9 +1009,6 @@ void schedule_group_exit_locked(struct signal_struct *signal, int exit_code)
 	 */
 	struct task_struct *t;
 
-	signal->flags = SIGNAL_GROUP_EXIT;
-	signal->group_exit_code = exit_code;
-	signal->group_stop_count = 0;
 	__for_each_thread(signal, t)
 		schedule_task_exit_locked(t, exit_code);
 }
@@ -1376,10 +1373,17 @@ int force_sig_info(struct kernel_siginfo *info)
 void schedule_task_exit_locked(struct task_struct *task, int exit_code)
 {
 	if (!(task->jobctl & JOBCTL_WILL_EXIT)) {
+		struct signal_struct *signal = task->signal;
 		task_clear_jobctl_pending(task, JOBCTL_PENDING_MASK);
 		task->jobctl |= JOBCTL_WILL_EXIT;
 		task->exit_code = exit_code;
 		signal_wake_up(task, true);
+		signal->quick_threads--;
+		if (signal->quick_threads == 0) {
+			signal->flags = SIGNAL_GROUP_EXIT;
+			signal->group_exit_code = exit_code;
+			signal->group_stop_count = 0;
+		}
 	}
 }
 
-- 
2.41.0


