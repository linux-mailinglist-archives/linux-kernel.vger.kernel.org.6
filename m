Return-Path: <linux-kernel+bounces-341863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8104988745
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6681F22E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340118872F;
	Fri, 27 Sep 2024 14:39:20 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFF13634C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447959; cv=none; b=jdN7JdTRHE5gPjnCilaeQWupnUb/1fNwwk08Hw2TfAXfhblyrfPwKXcdTjf3x0LrZGAixB0REkaCdDtijzy59JTYx5h4cOAWwA2z5zn1Q7a5d5nYVaH+goscvs4eW/674FjB+JTS9huLev0/E9RyugsZMeAirIcm+8wXzIEt7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447959; c=relaxed/simple;
	bh=4ZPshYNz8k3gT1QtY0zm0edyKbvQgiHaffh5csKc+T8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=jjbEJtQszYzOsypzyfBetlzCpFSbk2wJEIiFbtZ8KtE93ycw+CsCsHDe0SFDTYRG8ghkmG4PNhq36wpkktLxwq05mhKGDvgF1w8IDVSBI6pGd3Gt5XRP9ngoUg8C7torZxwz0TSuQVlhn/Hs2OePVc+2rkg7clF17ixFaQ+Jr/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:35776)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suC7o-00AZxe-SA; Fri, 27 Sep 2024 08:39:16 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:57458 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suC7n-00CZhw-Ms; Fri, 27 Sep 2024 08:39:16 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240927083900.989915582@linutronix.de>
Date: Fri, 27 Sep 2024 09:39:09 -0500
In-Reply-To: <20240927083900.989915582@linutronix.de> (Thomas Gleixner's
	message of "Fri, 27 Sep 2024 10:48:39 +0200 (CEST)")
Message-ID: <87o749xisy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suC7n-00CZhw-Ms;;;mid=<87o749xisy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/Z4Qezx73vBMnxQy5qkmPm8rdeO9MGilU=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 553 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.7 (0.8%), b_tie_ro: 3.2 (0.6%), parse: 1.28
	(0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 4.5
	(0.8%), tests_pri_-2000: 8 (1.5%), tests_pri_-1000: 1.99 (0.4%),
	tests_pri_-950: 1.04 (0.2%), tests_pri_-900: 0.81 (0.1%),
	tests_pri_-90: 65 (11.7%), check_bayes: 64 (11.5%), b_tokenize: 9
	(1.6%), b_tok_get_all: 12 (2.2%), b_comp_prob: 3.0 (0.5%),
	b_tok_touch_all: 36 (6.6%), b_finish: 0.71 (0.1%), tests_pri_0: 443
	(80.1%), check_dkim_signature: 0.44 (0.1%), check_dkim_adsp: 3.4
	(0.6%), poll_dns_idle: 2.1 (0.4%), tests_pri_10: 2.7 (0.5%),
	tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch v4 00/27] posix-timers: Cure the SIG_IGN mess
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: oleg@redhat.com, sboyd@kernel.org, mingo@kernel.org, peterz@infradead.org, jstultz@google.com, frederic@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@linutronix.de> writes:

> This are the remaining bits to cure the SIG_IGN mess. The preparatory work
> from the previous version 3 has been merged already. Version 3 can be found
> here:
>
>    https://lore.kernel.org/lkml/20240610163452.591699700@linutronix.de
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
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v4
>
> Changes vs. V3:
>
>     - Rebased to mainline
>    
>     - Fixed up a intermediate build breakage reported by 0-day

I have stopped looking at this after patch 4.

The current code can and does handle userspace injecting a signal with
si_sys_private sent to an non-zero value using rt_sigqueueinfo(2) and
that value will be delivered to userspace.

I think the at least the ability to inject such a signal (ignoring
si_sys_private) is very interesting for debuggers and checkpoint restart
applications.

I get the feeling the rest of the patch series depends upon not
supporting userspace injecting signals with si_code == SI_TIMER.  That
seems unnecessary.

It seems reasonable to depend upon something like the SIGQUEUE_PREALLOC
in the flags field of struct sigqueue to detect a kernel generated
signal.  Rather than adding various hacks to make everything work
with just a struct kernel_siginfo_t.  Especially as the timer signals
today are the only signals that are preallocated.

Is there any chance 18/27 posix-timers: Embed sigqueue in struct k_itimer
can be moved up?

That should allow removing the reliance on si_sys_private.

That should prevent the need to add another hack with sys_private_ptr in
struct kernel_siginfo

Perhaps what needs to happen is to update collect_signal to return the
sigqueue entry (if it was preallocated), instead of the resched_timer.
Then the timer code can just use container_of to get the struct
k_itimer?

After that si_sys_private can move into struct k_itimer, and the code
won't need to worry about userspace setting that value, or about needing
to clear that value.  As si_sys_private will always be 0 in preallocated
signals.

Eric

