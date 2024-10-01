Return-Path: <linux-kernel+bounces-346635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D698C6FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D228557D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F71CC16E;
	Tue,  1 Oct 2024 20:49:24 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A162B9A5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815764; cv=none; b=lc4sexWNy4I7b5CG6MmRfq6Vs7KBa1SKKvyR9bhF+oRtn/d6bZ+w8uLfCnZEZEP8AE6sAFlfz8BVH3i0pofnRwzzappOQmBAtkOgJ6en4JLEHNCy+U2yPxGJOrWueNiAtRufn3grPgHCAVLGWCdcYWUfxFXnyyn14DIf9WXLyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815764; c=relaxed/simple;
	bh=+Vv+FbPz6R4bHIL79lh0d8UhXLN34qGJ0eIW99Y8aWc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=PP6Tmpwd1AvYCYksS/A4TYR3DnCHUK0T/s1zHwttIZvvnuRw1UDthzFMP3ufZOtG78oaKkt5wY87PGIMjVABaNRln2NXtTndMsYUhieS9WSVKYZYkWaNR+9YFLwwy/OPDsiyshWyk/07we19WjYa14VIVyCaKsVn6KxpI7RRlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59134)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1svjo2-00BeGL-KH; Tue, 01 Oct 2024 14:49:14 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:48076 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1svjo1-001GvE-CC; Tue, 01 Oct 2024 14:49:14 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20241001083138.922192481@linutronix.de>
Date: Tue, 01 Oct 2024 15:48:48 -0500
In-Reply-To: <20241001083138.922192481@linutronix.de> (Thomas Gleixner's
	message of "Tue, 1 Oct 2024 10:41:59 +0200 (CEST)")
Message-ID: <87h69vk0r3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1svjo1-001GvE-CC;;;mid=<87h69vk0r3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/w3CmKtMMOdwQ0diK/fG+2HY/u8wokg/w=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 651 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (1.8%), b_tie_ro: 10 (1.5%), parse: 1.46
	(0.2%), extract_message_metadata: 20 (3.0%), get_uri_detail_list: 4.3
	(0.7%), tests_pri_-2000: 20 (3.1%), tests_pri_-1000: 2.6 (0.4%),
	tests_pri_-950: 1.24 (0.2%), tests_pri_-900: 1.00 (0.2%),
	tests_pri_-90: 127 (19.5%), check_bayes: 126 (19.3%), b_tokenize: 11
	(1.7%), b_tok_get_all: 13 (1.9%), b_comp_prob: 3.8 (0.6%),
	b_tok_touch_all: 94 (14.4%), b_finish: 0.90 (0.1%), tests_pri_0: 446
	(68.6%), check_dkim_signature: 0.62 (0.1%), check_dkim_adsp: 2.6
	(0.4%), poll_dns_idle: 0.81 (0.1%), tests_pri_10: 2.3 (0.4%),
	tests_pri_500: 14 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch V5 00/26] posix-timers: Cure the SIG_IGN mess
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: oleg@redhat.com, sboyd@kernel.org, mingo@kernel.org, peterz@infradead.org, jstultz@google.com, frederic@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@linutronix.de> writes:

> This are the remaining bits to cure the SIG_IGN mess. Version 4 can be found
> here:
>
>    https://lore.kernel.org/lkml/20240927083900.989915582@linutronix.de
>
> Last year I reread a 15 years old comment about the SIG_IGN problem:
>
>  "FIXME: What we really want, is to stop this timer completely and restart
>   it in case the SIG_IGN is removed. This is a non trivial change which
>   involves sighand locking (sigh !), which we don't want to do late in the
>   release cycle.  ...  A more complex fix which solves also another related
>   inconsistency is already in the pipeline."
>
> The embarrasing part was that I put that comment in back then. So I went
> back and rumaged through old notes as I completely had forgotten why our
> attempts to fix this back then failed.
>
> It turned out that the comment is about right: sighand locking and life
> time issues. So I sat down with the old notes and started to wrap my head
> around this again.
>
> The problem to solve:
>
> Posix interval timers are not rearmed automatically by the kernel for
> various reasons:
>
>    1) To prevent DoS by extremly short intervals.
>    2) To avoid timer overhead when a signal is pending and has not
>       yet been delivered.
>
> This is achieved by queueing the signal at timer expiry and rearming the
> timer at signal delivery to user space. This puts the rearming basically
> under scheduler control and the work happens in context of the task which
> asked for the signal.
>
> There is a problem with that vs. SIG_IGN. If a signal has SIG_IGN installed
> as handler, the related signals are discarded. So in case of posix interval
> timers this means that such a timer is never rearmed even when SIG_IGN is
> replaced later with a real handler (including SIG_DFL).
>
> To work around that the kernel self rearms those timers and throttles them
> when the interval is smaller than a tick to prevent a DoS.
>
> That just keeps timers ticking, which obviously has effects on power and
> just creates work for nothing.
>
> So ideally these timers should be stopped and rearmed when SIG_IGN is
> replaced, which aligns with the regular handling of posix timers.
>
> Sounds trivial, but isn't:
>
>   1) Lock ordering.
>
>      The timer lock cannot be taken with sighand lock held which is
>      problematic vs. the atomicity of sigaction().
>
>   2) Life time rules
>
>      The timer and the sigqueue are separate entities which requires a
>      lookup of the timer ID in the signal rearm code. This can be handled,
>      but the separate life time rules are not necessarily robust.
>
>   3) Finding the relevant timers
>
>      Obviosly it is possible to walk the posix timer list under sighand
>      lock and handle it from there. That can be expensive especially in the
>      case that there are no affected timers as the walk would just end up
>      doing nothing.
>
> The following series is a new and this time actually working attempt to
> solve this. It addresses it by:
>
>   1) Embedding the preallocated sigqueue into struct k_itimer, which makes
>      the life time rules way simpler and just needs a trivial reference
>      count.
>
>   2) Having a separate list in task::signal on which ignored timers are
>      queued.
>
>      This avoids walking a potentially large timer list for nothing on a
>      SIG_IGN to handler transition.
>
>   3) Requeueing the timers signal in the relevant signal queue so the timer
>      is rearmed when the signal is actually delivered
>
>      That turned out to be the least complicated way to address the sighand
>      lock vs. timer lock ordering issue.
>
> With that timers which have their signal ignored are not longer self
> rearmed and the relevant workarounds including throttling for DoS
> prevention are removed.
>
> The series is also available from git:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v5
>
> Changes vs. V4:
>
>     - Remove the si_sys_private restrictions - Eric
>
>     - Hand down the pointer to the preallocated sigqueue instead of relying
>       on si_sys_priv* magic - Eric

For the bits removing the dependency on si_sys_private
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There are a lot of slightly subtle things going on in the surrounding
patches that my brain glossed over, so I can't speak for them, but
the removal of si_sys_private looks good.

Eric

> Thanks,
>
> 	tglx
> ---
>  drivers/power/supply/charger-manager.c |    3 
>  fs/proc/base.c                         |    4 
>  fs/timerfd.c                           |    4 
>  include/linux/alarmtimer.h             |   10 
>  include/linux/posix-timers.h           |   70 ++++
>  include/linux/sched/signal.h           |    4 
>  init/init_task.c                       |    5 
>  kernel/fork.c                          |    1 
>  kernel/signal.c                        |  465 +++++++++++++++++++--------------
>  kernel/time/alarmtimer.c               |   87 ------
>  kernel/time/itimer.c                   |   22 +
>  kernel/time/posix-cpu-timers.c         |   38 +-
>  kernel/time/posix-timers.c             |  222 +++++++--------
>  kernel/time/posix-timers.h             |    8 
>  net/netfilter/xt_IDLETIMER.c           |    4 
>  15 files changed, 502 insertions(+), 445 deletions(-)

