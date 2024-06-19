Return-Path: <linux-kernel+bounces-220478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FB90E23D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4C71F241AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D950280;
	Wed, 19 Jun 2024 04:11:28 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B74C635
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770288; cv=none; b=d75VVOej+sbP9PjsT+YwK96G9tqVEZNU7LoXndcl4RANoV4MdQtlv3GMAxExZb4sv/Q9UJtZQc6xSjhnER6b2NUMt+CrH87am0P6AURSfB4KUlYPsoV34zRcjVwac0c3slj9s1pYoHgLM8A1KyxSWe+lTpH7+i4C+I8eHik7Wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770288; c=relaxed/simple;
	bh=rI1/8Q3NCRHP7HCE6BEWfKYBhNQWkf+MwGAKNKeEfXU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=V8fKg7XWNZb3YVtf/Y733TkP/YuwbOWMWvhSx1BnPzlnkzv+aJVyJFHMevQElj/9rYhFzjggIg5lWunGvN68+wxMUL/ber1W84mVY5m5ux7APqmrePBu2mccwKwZehHTzSAinel8pABr7UrEXTZxdOTDRURnAZmdVIDF6FJbIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:45972)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmfN-005ugk-Nu; Tue, 18 Jun 2024 22:11:25 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:43580 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmfM-009S3x-NM; Tue, 18 Jun 2024 22:11:25 -0600
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
Date: Tue, 18 Jun 2024 23:11:17 -0500
In-Reply-To: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 23:04:42 -0500")
Message-ID: <87iky5fu6y.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmfM-009S3x-NM;;;mid=<87iky5fu6y.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/myM0LuKtJuEsnUnXa7k2cvouZldYHIIY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4982]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 305 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (3.9%), b_tie_ro: 10 (3.4%), parse: 1.09
	(0.4%), extract_message_metadata: 13 (4.1%), get_uri_detail_list: 1.32
	(0.4%), tests_pri_-2000: 13 (4.3%), tests_pri_-1000: 2.3 (0.8%),
	tests_pri_-950: 1.22 (0.4%), tests_pri_-900: 0.96 (0.3%),
	tests_pri_-90: 74 (24.2%), check_bayes: 72 (23.6%), b_tokenize: 6
	(1.9%), b_tok_get_all: 4.7 (1.5%), b_comp_prob: 1.67 (0.5%),
	b_tok_touch_all: 57 (18.6%), b_finish: 1.01 (0.3%), tests_pri_0: 173
	(56.6%), check_dkim_signature: 0.50 (0.2%), check_dkim_adsp: 2.9
	(0.9%), poll_dns_idle: 1.08 (0.4%), tests_pri_10: 3.1 (1.0%),
	tests_pri_500: 9 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 13/17] signal: Stop skipping current in do_group_exit &
 get_signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


Now that schedule_task_exit_locked uses JOBCTL_WILL_EXIT instead of
setting the per task SIGKILL pending bit, and JOBCTL_WILL_EXIT is
expected to be present on all tasks that are exiting, it makes no
sense to skip the current task.  So call schedule_task_exit_locked on
all threads.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   | 6 +-----
 kernel/signal.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 564bf17f4589..471af82376e5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1015,12 +1015,8 @@ do_group_exit(int exit_code)
 			sig->group_exit_code = exit_code;
 			sig->flags = SIGNAL_GROUP_EXIT;
 			sig->group_stop_count = 0;
-			__for_each_thread(sig, t) {
-				if (t == current)
-					continue;
+			__for_each_thread(sig, t)
 				schedule_task_exit_locked(t);
-			}
-			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 		spin_unlock_irq(&sighand->siglock);
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index 2b0f6d8baebb..8ae6d6550e82 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2876,12 +2876,8 @@ bool get_signal(struct ksignal *ksig)
 			signal->group_exit_code = exit_code;
 			signal->flags = SIGNAL_GROUP_EXIT;
 			signal->group_stop_count = 0;
-			__for_each_thread(signal, t) {
-				if (t == current)
-					continue;
+			__for_each_thread(signal, t)
 				schedule_task_exit_locked(t);
-			}
-			current->jobctl |= JOBCTL_WILL_EXIT;
 		}
 	fatal:
 		spin_unlock_irq(&sighand->siglock);
-- 
2.41.0


