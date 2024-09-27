Return-Path: <linux-kernel+bounces-341814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF80988693
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AE31C2194A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D631BF327;
	Fri, 27 Sep 2024 13:53:20 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACF185B72
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445200; cv=none; b=nQXDD0gYaQZMZWoKsrHdQO5FDdc01dSx+mlcrWNSHZRRAnIDG0v6AA7O3u6cxC+ThPEVyERXMku5qzBfcK21nM0nMoAAPBG0oo4EodR3jNvhPpvnYsenLoLVeRi7zFO9nd+VuIJ9qGX6rZ6h5kFRfAOFOstST4226BAeZ1AsqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445200; c=relaxed/simple;
	bh=79NeiamnnJvad8idaUzlKu2/XH6sjWkA8i+QLK47T/M=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=TDjjKEYVbf33t6XuyYkFRb/FBMcIcEhEOoAfpJtEIFrN1/ITyfpZIv8g9v561W3ogriO815zGqqNmt901Bh3BNnngnNcHypgO+qTrZZR4r4tXJF1OUM4Jw4pI2+SJO7WfQ4Dypf6+ol52HKfQq0mZGtrlg6ks4eLEr17Feqz8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34060)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBPJ-002PDc-2e; Fri, 27 Sep 2024 07:53:17 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:41394 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBPG-009k0e-Hs; Fri, 27 Sep 2024 07:53:16 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240927083900.989915582@linutronix.de>
	<20240927084817.077215973@linutronix.de>
Date: Fri, 27 Sep 2024 08:53:07 -0500
In-Reply-To: <20240927084817.077215973@linutronix.de> (Thomas Gleixner's
	message of "Fri, 27 Sep 2024 10:48:42 +0200 (CEST)")
Message-ID: <874j6119vg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suBPG-009k0e-Hs;;;mid=<874j6119vg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+j3QDd0pz5lwPr/DnV8TEDCtxPlAbeN/o=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1934 ms - load_scoreonly_sql: 0.09 (0.0%),
	signal_user_changed: 13 (0.7%), b_tie_ro: 11 (0.6%), parse: 1.65
	(0.1%), extract_message_metadata: 30 (1.6%), get_uri_detail_list: 2.2
	(0.1%), tests_pri_-2000: 9 (0.5%), tests_pri_-1000: 11 (0.6%),
	tests_pri_-950: 1.64 (0.1%), tests_pri_-900: 1.32 (0.1%),
	tests_pri_-90: 146 (7.6%), check_bayes: 143 (7.4%), b_tokenize: 11
	(0.5%), b_tok_get_all: 22 (1.1%), b_comp_prob: 3.0 (0.2%),
	b_tok_touch_all: 98 (5.1%), b_finish: 1.45 (0.1%), tests_pri_0: 315
	(16.3%), check_dkim_signature: 0.69 (0.0%), check_dkim_adsp: 8 (0.4%),
	poll_dns_idle: 1379 (71.3%), tests_pri_10: 2.1 (0.1%), tests_pri_500:
	1389 (71.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch v4 03/27] signal: Get rid of resched_timer logic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: oleg@redhat.com, sboyd@kernel.org, mingo@kernel.org, peterz@infradead.org, jstultz@google.com, frederic@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> There is no reason for handing the *resched pointer argument through
> several functions just to check whether the signal is related to a self
> rearming posix timer.
>
> SI_TIMER is only used by the posix timer code and cannot be queued from
> user space.

Huh???  We have rt_sigqueueinfo.  You just touched the code that
copies the queued signal from userspace.

> The only extra check in collect_signal() to verify whether the
> queued signal is preallocated is not really useful. Some other places
> already check purely the SI_TIMER type.

The check to see if the signal was preallocated prevents shenanigans
with setting si_sys_private.

That is today you can queue a signal with rt_sigqueueinfo and set
si_sys_private and it will make it to userspace.  I don't know how
much we care but that is the case.

Which means that WARN_ON you added in __send_signal_locked can
most definitely be triggered by userspace.

Eric


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> ---
>  kernel/signal.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> ---
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7706cd304785..3d2e087283ab 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -526,8 +526,7 @@ bool unhandled_signal(struct task_struct *tsk, int sig)
>  	return !tsk->ptrace;
>  }
>  
> -static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
> -			   bool *resched_timer)
> +static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info)
>  {
>  	struct sigqueue *q, *first = NULL;
>  
> @@ -549,12 +548,6 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
>  still_pending:
>  		list_del_init(&first->list);
>  		copy_siginfo(info, &first->info);
> -
> -		*resched_timer =
> -			(first->flags & SIGQUEUE_PREALLOC) &&
> -			(info->si_code == SI_TIMER) &&
> -			(info->si_sys_private);
> -
>  		__sigqueue_free(first);
>  	} else {
>  		/*
> @@ -571,13 +564,12 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
>  	}
>  }
>  
> -static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
> -			kernel_siginfo_t *info, bool *resched_timer)
> +static int __dequeue_signal(struct sigpending *pending, sigset_t *mask, kernel_siginfo_t *info)
>  {
>  	int sig = next_signal(pending, mask);
>  
>  	if (sig)
> -		collect_signal(sig, pending, info, resched_timer);
> +		collect_signal(sig, pending, info);
>  	return sig;
>  }
>  
> @@ -589,17 +581,15 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
>  int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
>  {
>  	struct task_struct *tsk = current;
> -	bool resched_timer = false;
>  	int signr;
>  
>  	lockdep_assert_held(&tsk->sighand->siglock);
>  
>  	*type = PIDTYPE_PID;
> -	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
> +	signr = __dequeue_signal(&tsk->pending, mask, info);
>  	if (!signr) {
>  		*type = PIDTYPE_TGID;
> -		signr = __dequeue_signal(&tsk->signal->shared_pending,
> -					 mask, info, &resched_timer);
> +		signr = __dequeue_signal(&tsk->signal->shared_pending, mask, info);
>  
>  		if (unlikely(signr == SIGALRM))
>  			posixtimer_rearm_itimer(tsk);
> @@ -626,7 +616,7 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
>  	}
>  
>  	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
> -		if (unlikely(resched_timer))
> +		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
>  			posixtimer_rearm(info);
>  	}
>  
> @@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  
>  	lockdep_assert_held(&t->sighand->siglock);
>  
> +	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
> +		return 0;
> +
>  	result = TRACE_SIGNAL_IGNORED;
>  	if (!prepare_signal(sig, t, force))
>  		goto ret;

