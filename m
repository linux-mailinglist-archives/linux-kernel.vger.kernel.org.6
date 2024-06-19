Return-Path: <linux-kernel+bounces-220466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690B90E223
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434D91F230C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CA4C635;
	Wed, 19 Jun 2024 04:05:00 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFF1E878
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769900; cv=none; b=Dvnns5c8HISk6fYCEainmztpfY1B5mTKsSi3uLkQOK3lyiP6iFPlZ8nw3rz4FxpwX0H+CeTfYBn+GO4E79tI6ErZXP4bzOofELLTzdf1wHDg42t0+aAFTD1gkKrUwQJMpk728+g5GgPjU39UnP3iqsMMZTvb8QYB6GG9BmtGWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769900; c=relaxed/simple;
	bh=KRahQrORI0w3OZ7xRO8cJ6r2bHUUkghgjzVxetxkYck=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=KTjZUn/FlUAu/UZr2VDZmdXSgNUWOfGDdbVzLJTW6n6JQb5fJzKifWYpK/TFaP6GONP4hoBDt6oE7w0Zq74o55p3PS9jEO00FhXgZBlwsOGH3+ch1TLngMYm1E+8NZYNmMyCS38oGH3bu9/BwiM3nCW2aRBDCLOKPXKUQqWma3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:53516)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZ1-00E5km-9W; Tue, 18 Jun 2024 22:04:51 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41020 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sJmZ0-009RFf-AE; Tue, 18 Jun 2024 22:04:50 -0600
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
Date: Tue, 18 Jun 2024 23:04:42 -0500
In-Reply-To: <87iky5k2yi.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Tue, 18 Jun 2024 22:48:21 -0500")
Message-ID: <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sJmZ0-009RFf-AE;;;mid=<87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18Ns0dSc1lw2+lZJGsLO5PyIizCCXtxp5A=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4751]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 347 ms - load_scoreonly_sql: 0.23 (0.1%),
	signal_user_changed: 13 (3.8%), b_tie_ro: 11 (3.2%), parse: 1.17
	(0.3%), extract_message_metadata: 4.2 (1.2%), get_uri_detail_list:
	1.56 (0.5%), tests_pri_-2000: 3.1 (0.9%), tests_pri_-1000: 2.3 (0.7%),
	tests_pri_-950: 1.22 (0.4%), tests_pri_-900: 0.96 (0.3%),
	tests_pri_-90: 69 (19.9%), check_bayes: 68 (19.5%), b_tokenize: 6
	(1.8%), b_tok_get_all: 7 (2.1%), b_comp_prob: 2.3 (0.7%),
	b_tok_touch_all: 49 (14.1%), b_finish: 0.84 (0.2%), tests_pri_0: 223
	(64.3%), check_dkim_signature: 0.52 (0.2%), check_dkim_adsp: 2.9
	(0.8%), poll_dns_idle: 1.04 (0.3%), tests_pri_10: 3.4 (1.0%),
	tests_pri_500: 14 (4.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/17] exit: complete synchronize_group_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)


This patchset is against v6.10-rc3

A while ago I was working on the problem of how to allow signals that
trigger coredumps to support short circuit delivery.  Along the way I
wound up developing some code that would make ``process'' exits
triggered by signals, do_exit, or do_group_exit clean.  This patchset is
that code.

The highlights add enough bits to the task_struct to allow task exits to
be scheduled like signal group exits.

Add helpers schedule_task_exit_locked, and schedule_group_exit_locked
so the same code is not repeated in small variations in different parts
of the code, and allowing de_thread to be implemented cleanly.

Eric W. Biederman (17):
      signal: Make SIGKILL during coredumps an explicit special case
      signal: Compute the process exit_code in get_signal
      coredump: Consolidate the work to allow SIGKILL during coredumps
      signal: In get_signal call do_exit when it is unnecessary to shoot down threads
      signal: Bring down all threads when handling a non-coredump fatal signal
      signal: Add JOBCTL_WILL_EXIT to mark exiting tasks
      signal: Always set JOBCTL_WILL_EXIT for exiting tasks
      signal: Don't target tasks that are exiting
      signal: Test for process exit or de_thread using task_exit_pending
      signal: Only set JOBCTL_WILL_EXIT if it is not already set
      signal: Make individual tasks exiting a first class concept
      signal: Remove zap_other_threads
      signal: Stop skipping current in do_group_exit & get_signal
      signal: Factor out schedule_group_exit_locked
      ptrace: Separate task->ptrace_code out from task->exit_code
      signal: Record the exit_code when an exit is scheduled
      signal: Set SIGNAL_GROUP_EXIT when all tasks have decided to exit

 fs/coredump.c                |  25 +++-----
 fs/exec.c                    |  14 ++--
 fs/proc/array.c              |   3 +
 include/linux/sched.h        |   1 +
 include/linux/sched/jobctl.h |   2 +
 include/linux/sched/signal.h |  11 +++-
 kernel/exit.c                |  29 +++------
 kernel/ptrace.c              |  12 ++--
 kernel/signal.c              | 148 ++++++++++++++++++++++++-------------------
 9 files changed, 131 insertions(+), 114 deletions(-)

Eric

