Return-Path: <linux-kernel+bounces-220469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1C90E226
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AB21F230C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A84C635;
	Wed, 19 Jun 2024 04:06:46 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BF1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770006; cv=none; b=eNHqPiGOcZy8Gh79wtjn0261ZqMpucDjhOlBxAvndcsnlXhuKD6rSArAUUl4XaLmrlAv7OIOq0omIzBc6yF6NJrYyEwckvkwvUdqjtMZ9bJMFMEngo/j136g7EL5u5XLiMjsqjIcxRWncrgzuloFxfAGXFHUwsTQnvPB68iT5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770006; c=relaxed/simple;
	bh=fjQaafk/Rm+2nL3ouvn0B9Us3sRSiAV4htBW8U3yqz8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=DBxMPHFcoRQRyP1FVr8hJeQeGkWsoEUI3F98wCCsdtU901VlBKtshMhoLoqOfyjehk3QVzqmf+vTZ1f8l+FyGCIrmWCzdUTEOQ4MuraEyx5BzouJKMrmZgEfPszE0VRilQhGBrgLttFCWhdVHzfbZxlr0I77oYhUXX1NkpnYdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:54142)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmap-00E6Vx-DW; Tue, 18 Jun 2024 22:06:43 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:36228 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmao-002rij-HO; Tue, 18 Jun 2024 22:06:43 -0600
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
Date: Tue, 18 Jun 2024 23:06:33 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <871q4tinjq.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmao-002rij-HO;;;mid=<871q4tinjq.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18nk/aH0Ch9VSe+bG0PF1Bvf/4AwkcIeCM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4976]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 357 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 9 (2.5%), b_tie_ro: 8 (2.2%), parse: 1.22 (0.3%),
	extract_message_metadata: 13 (3.7%), get_uri_detail_list: 1.66 (0.5%),
	tests_pri_-2000: 13 (3.5%), tests_pri_-1000: 2.3 (0.6%),
	tests_pri_-950: 1.21 (0.3%), tests_pri_-900: 0.97 (0.3%),
	tests_pri_-90: 68 (19.1%), check_bayes: 67 (18.8%), b_tokenize: 7
	(1.9%), b_tok_get_all: 6 (1.7%), b_comp_prob: 2.0 (0.6%),
	b_tok_touch_all: 49 (13.7%), b_finish: 0.85 (0.2%), tests_pri_0: 233
	(65.4%), check_dkim_signature: 0.57 (0.2%), check_dkim_adsp: 3.2
	(0.9%), poll_dns_idle: 1.29 (0.4%), tests_pri_10: 3.0 (0.8%),
	tests_pri_500: 9 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/17] signal: In get_signal call do_exit when it is
 unnecessary to shoot down threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)


In get_signal if other threads of the current process do not need to
be shoot down calling do_group_exit is equivalent to calling do_exit.
The code in get_signal is only responsible for shooting down threads
when it dequeues a signal and decides the signal is fatal.

To remove special cases and make the code easier to read, call do_exit
instead of do_group_exit when no other threads need to be shoot down.

With do_group_exit no longer being called when exec is terminating
threads in de_thread remove the special case in do_group_exit for
handling exec.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   | 4 ----
 kernel/signal.c | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..08de33740b9c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1001,8 +1001,6 @@ do_group_exit(int exit_code)
 
 	if (sig->flags & SIGNAL_GROUP_EXIT)
 		exit_code = sig->group_exit_code;
-	else if (sig->group_exec_task)
-		exit_code = 0;
 	else {
 		struct sighand_struct *const sighand = current->sighand;
 
@@ -1010,8 +1008,6 @@ do_group_exit(int exit_code)
 		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
-		else if (sig->group_exec_task)
-			exit_code = 0;
 		else {
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
diff --git a/kernel/signal.c b/kernel/signal.c
index 392d802dbf61..caeaff81a197 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2736,6 +2736,7 @@ bool get_signal(struct ksignal *ksig)
 	}
 
 	for (;;) {
+		bool group_exit_needed = false;
 		struct k_sigaction *ka;
 		enum pid_type type;
 		int exit_code;
@@ -2881,6 +2882,7 @@ bool get_signal(struct ksignal *ksig)
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		exit_code = signr;
+		group_exit_needed = true;
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
@@ -2916,7 +2918,10 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(exit_code);
+		if (group_exit_needed)
+			do_group_exit(exit_code);
+		else
+			do_exit(exit_code);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.41.0


