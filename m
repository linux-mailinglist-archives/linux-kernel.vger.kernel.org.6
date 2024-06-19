Return-Path: <linux-kernel+bounces-220470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4F90E227
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552121C212C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339150280;
	Wed, 19 Jun 2024 04:07:13 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69A1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770032; cv=none; b=QLGJrG1rONzJxxHRnJ3b9nOvqR+VfiW+HQkNUtIFDeOKO75St06owQ15o9F2GxiAOVJPelo+tBDKx13oJHTlaPb/4nrshSGk5x5KYxyyiUcLrXF8IPOumwXgQzDWjm6sgAab1AGBb0LUa6UALVxaqHfYWcZvGXlVqVTnzL/qSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770032; c=relaxed/simple;
	bh=i+m7kUTGynqCmryG7YxhUOK/9KsV3QYutaznmVWfxmg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=f0NRcZJmtxt0uX98Zve41C7arvenMjbEjnsE4ctArfqPpZj9G0gP68VwT+RExJN4TNE5gBS+EqwTRUy334YZ7AgQBmE/4wbT4fXGLYfdH6PMNLw010qmaUjHGGHn/L3nihd9QsP8b24FNV6uKlJZvpYj3J2XuULvVVtoBRwH38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:42174)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmbG-005ubB-57; Tue, 18 Jun 2024 22:07:10 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:55932 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmbF-002rlL-6O; Tue, 18 Jun 2024 22:07:09 -0600
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
Date: Tue, 18 Jun 2024 23:07:01 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87v825h8yi.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmbF-002rlL-6O;;;mid=<87v825h8yi.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/y2ryawxIpgt1oI8YJofl+KVxOOknMOMc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 383 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 15 (3.9%), b_tie_ro: 12 (3.2%), parse: 1.13
	(0.3%), extract_message_metadata: 14 (3.5%), get_uri_detail_list: 1.09
	(0.3%), tests_pri_-2000: 13 (3.3%), tests_pri_-1000: 2.3 (0.6%),
	tests_pri_-950: 1.46 (0.4%), tests_pri_-900: 1.13 (0.3%),
	tests_pri_-90: 183 (47.6%), check_bayes: 180 (47.0%), b_tokenize: 4.3
	(1.1%), b_tok_get_all: 7 (1.8%), b_comp_prob: 2.00 (0.5%),
	b_tok_touch_all: 162 (42.2%), b_finish: 1.44 (0.4%), tests_pri_0: 138
	(36.1%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 3.0
	(0.8%), poll_dns_idle: 1.21 (0.3%), tests_pri_10: 2.3 (0.6%),
	tests_pri_500: 9 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/17] signal: Bring down all threads when handling a
 non-coredump fatal signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)


For non-coredump fatal signals instead of dropping and reacquiring
siglock to shoot down the other threads from do_group_exit
at the end of get_signal, shot down the other threads before
siglock is dropped.

This can not be done for coredump signals yet, because do_coredump
needs to be in a position to catch dying threads before it kills them
so it can make certain to catch them, so they can be added to the
coredump.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index caeaff81a197..269ec88f650d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2882,7 +2882,13 @@ bool get_signal(struct ksignal *ksig)
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		exit_code = signr;
-		group_exit_needed = true;
+		if (sig_kernel_coredump(signr))
+			group_exit_needed = true;
+		else {
+			signal->group_exit_code = exit_code;
+			signal->flags = SIGNAL_GROUP_EXIT;
+			zap_other_threads(current);
+		}
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
-- 
2.41.0


