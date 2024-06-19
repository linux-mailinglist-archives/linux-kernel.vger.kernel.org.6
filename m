Return-Path: <linux-kernel+bounces-220473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03B90E22A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209C91C21C42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388574C635;
	Wed, 19 Jun 2024 04:08:56 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452C1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770135; cv=none; b=s0MA8EtxIY/1y5R9z7DOp9OS/b3eJik8COACbFYFB2LFISOc0IELGkS7mJ2slz9IFdNYjZyiH4jM+XvjmWs20quTxop0TInHKkxcGt6tltaFumltPmV4V210Vooy1eIu7DknVLAU7LCFbXNrFo8E/jb9J7s2OVLSfpeamBk12z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770135; c=relaxed/simple;
	bh=l+zcJ9ggR0nX8sADXoEpzsJOzpB5V9+0+3iv8sug3h8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=bu+t1dm2yl/rJHSnJY09JWKkOVYOsgGi0LUXkmzNE244/HpjQPSTVdGQEKXwGR3MFow4NQYFEdMD3nHnd1be7/M8SN9kRjxG/H/xoqscQI9RKprRauBtVgKByAsnZ0uEPFW3ReNXbBvcOKBXIf+HHL7tIzbL2ibIus1h2aPO9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:40576)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmcv-005ud7-C9; Tue, 18 Jun 2024 22:08:53 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:43974 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmcu-009Rm5-D8; Tue, 18 Jun 2024 22:08:52 -0600
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
Date: Tue, 18 Jun 2024 23:08:45 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87bk3xh8vm.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmcu-009Rm5-D8;;;mid=<87bk3xh8vm.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/wn0KJUa+Ve3aKlybryx15IbrIX1Ru1nE=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 284 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (4.0%), b_tie_ro: 10 (3.4%), parse: 0.91
	(0.3%), extract_message_metadata: 12 (4.1%), get_uri_detail_list: 1.04
	(0.4%), tests_pri_-2000: 13 (4.7%), tests_pri_-1000: 2.5 (0.9%),
	tests_pri_-950: 1.29 (0.5%), tests_pri_-900: 1.03 (0.4%),
	tests_pri_-90: 54 (19.1%), check_bayes: 53 (18.6%), b_tokenize: 6
	(2.1%), b_tok_get_all: 4.9 (1.7%), b_comp_prob: 1.88 (0.7%),
	b_tok_touch_all: 37 (12.9%), b_finish: 0.93 (0.3%), tests_pri_0: 172
	(60.5%), check_dkim_signature: 0.61 (0.2%), check_dkim_adsp: 2.9
	(1.0%), poll_dns_idle: 1.05 (0.4%), tests_pri_10: 3.1 (1.1%),
	tests_pri_500: 10 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/17] signal: Don't target tasks that are exiting
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Teach wants_signal and retarget_shared_pending to use
JOBCTL_TASK_EXITING to detect threads that have an exit pending and so
will not be processing any more signals.

Teach task_set_jobctl_pending to directly examine JOBCTL_WILL_EXIT
rather than looking at PF_EXITING and fatal_signal_pending as those
are redundant.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d169b47775b0..5e67c00b9b30 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -281,7 +281,7 @@ bool task_set_jobctl_pending(struct task_struct *task, unsigned long mask)
 			JOBCTL_STOP_SIGMASK | JOBCTL_TRAPPING));
 	BUG_ON((mask & JOBCTL_TRAPPING) && !(mask & JOBCTL_PENDING_MASK));
 
-	if (unlikely(fatal_signal_pending(task) || (task->flags & PF_EXITING)))
+	if (unlikely(task->jobctl & JOBCTL_WILL_EXIT))
 		return false;
 
 	if (mask & JOBCTL_STOP_SIGMASK)
@@ -985,7 +985,7 @@ static inline bool wants_signal(int sig, struct task_struct *p)
 	if (sigismember(&p->blocked, sig))
 		return false;
 
-	if (p->flags & PF_EXITING)
+	if (p->jobctl & JOBCTL_WILL_EXIT)
 		return false;
 
 	if (sig == SIGKILL)
@@ -2998,7 +2998,7 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 		return;
 
 	for_other_threads(tsk, t) {
-		if (t->flags & PF_EXITING)
+		if (t->jobctl & JOBCTL_WILL_EXIT)
 			continue;
 
 		if (!has_pending_signals(&retarget, &t->blocked))
-- 
2.41.0


