Return-Path: <linux-kernel+bounces-341820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07219886A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C96B221CC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ADB8248D;
	Fri, 27 Sep 2024 14:02:50 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BB1C6A5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445770; cv=none; b=OBYOA2qnKFMTJtR3ywSXJ0GNSIniHXFg6E38VZnDX9d5daJr5MaKHTB9G+SXZhKw9YEpxji/ppDWFR/bK7HGXwg5QJNEixvXR95sbrgMRpz0IyLpdgxjbb0l6jwy/jmT4Q1QyahS0D1vciPiM1tGqEsDMgwOEz6TJWAi5lsdHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445770; c=relaxed/simple;
	bh=253Zqta9CAPSxb0t76sFDkKz3VGVITFMFbl7WkT/ffY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Eab7lZI0T0pY8wnSi9ptkVxVAmU6HWkX1YBoTpIHcMzGo9NxaMtEQyzJLXDXvm79JVNik/sLmNv2VlFw0NMQ6Ftc+ElpEkTHSZ4QK7VKMwRn7sUAdG3qCGXmfgLs+PIeE4JOpFVyYrRBc07dfPQUh669QIfDL53c8fZDYdRdx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:48944)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBYV-002Q08-SJ; Fri, 27 Sep 2024 08:02:47 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:35456 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1suBYT-009lQK-GZ; Fri, 27 Sep 2024 08:02:47 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240927083900.989915582@linutronix.de>
	<20240927084817.138903581@linutronix.de>
Date: Fri, 27 Sep 2024 09:02:39 -0500
In-Reply-To: <20240927084817.138903581@linutronix.de> (Thomas Gleixner's
	message of "Fri, 27 Sep 2024 10:48:44 +0200 (CEST)")
Message-ID: <87r095yz28.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1suBYT-009lQK-GZ;;;mid=<87r095yz28.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+8CoN0e1B/8db3/9AENJYL3kqPKwuQVmw=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1745 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.70
	(0.1%), extract_message_metadata: 38 (2.2%), get_uri_detail_list: 4.2
	(0.2%), tests_pri_-2000: 71 (4.0%), tests_pri_-1000: 14 (0.8%),
	tests_pri_-950: 1.82 (0.1%), tests_pri_-900: 1.42 (0.1%),
	tests_pri_-90: 212 (12.1%), check_bayes: 210 (12.0%), b_tokenize: 42
	(2.4%), b_tok_get_all: 43 (2.4%), b_comp_prob: 4.5 (0.3%),
	b_tok_touch_all: 100 (5.7%), b_finish: 1.09 (0.1%), tests_pri_0: 1318
	(75.5%), check_dkim_signature: 1.92 (0.1%), check_dkim_adsp: 13 (0.8%),
	 poll_dns_idle: 10 (0.6%), tests_pri_10: 16 (0.9%), tests_pri_500: 52
	(3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch v4 04/27] posix-timers: Cure si_sys_private race
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: oleg@redhat.com, sboyd@kernel.org, mingo@kernel.org, peterz@infradead.org, jstultz@google.com, frederic@kernel.org, anna-maria@linutronix.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Thomas Gleixner <tglx@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> The si_sys_private member of the siginfo which is embedded in the
> preallocated sigqueue is used by the posix timer code to decide whether a
> timer must be reprogrammed on signal delivery.
>
> The handling of this is racy as a long standing comment in that code
> documents. It is modified with the timer lock held, but without sighand
> lock being held. The actual signal delivery code checks for it under
> sighand lock without holding the timer lock.

I suspect this falls under the ancient all integers are atomic rule
in practice.

> Hand the new value to send_sigqueue() as argument and store it with sighand
> lock held.

Is there any way we can simply remove the hack of using si_sys_private,
and use a field in the structure that contains the preallocated signal?

I don't have any issues with updating send_siqueue so that the locking
is consistent.  However can we possibly name the argument something like
it_requeue_pending instead of si_private?

Eric

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> ---
>  include/linux/sched/signal.h |  2 +-
>  kernel/signal.c              | 10 +++++++++-
>  kernel/time/posix-timers.c   | 15 +--------------
>  3 files changed, 11 insertions(+), 16 deletions(-)
> ---
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index c8ed09ac29ac..bd9f569231d9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -340,7 +340,7 @@ extern int send_sig(int, struct task_struct *, int);
>  extern int zap_other_threads(struct task_struct *p);
>  extern struct sigqueue *sigqueue_alloc(void);
>  extern void sigqueue_free(struct sigqueue *);
> -extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
> +extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
>  extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
>  
>  static inline void clear_notify_signal(void)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 3d2e087283ab..443baadb5ab0 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1915,7 +1915,7 @@ void sigqueue_free(struct sigqueue *q)
>  		__sigqueue_free(q);
>  }
>  
> -int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
> +int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
>  {
>  	int sig = q->info.si_signo;
>  	struct sigpending *pending;
> @@ -1950,6 +1950,14 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	if (!likely(lock_task_sighand(t, &flags)))
>  		goto ret;
>  
> +	/*
> +	 * Update @q::info::si_sys_private for posix timer signals with
> +	 * sighand locked to prevent a race against dequeue_signal() which
> +	 * decides based on si_sys_private whether to invoke
> +	 * posixtimer_rearm() or not.
> +	 */
> +	q->info.si_sys_private = si_private;
> +
>  	ret = 1; /* the signal is ignored */
>  	result = TRACE_SIGNAL_IGNORED;
>  	if (!prepare_signal(sig, t, false))
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index bcd5e56412e7..b6cca1ed2f90 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_itimer *timr)
>  	if (timr->it_interval)
>  		si_private = ++timr->it_requeue_pending;
>  
> -	/*
> -	 * FIXME: if ->sigq is queued we can race with
> -	 * dequeue_signal()->posixtimer_rearm().
> -	 *
> -	 * If dequeue_signal() sees the "right" value of
> -	 * si_sys_private it calls posixtimer_rearm().
> -	 * We re-queue ->sigq and drop ->it_lock().
> -	 * posixtimer_rearm() locks the timer
> -	 * and re-schedules it while ->sigq is pending.
> -	 * Not really bad, but not that we want.
> -	 */
> -	timr->sigq->info.si_sys_private = si_private;
> -
>  	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> -	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> +	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
>  	/* If we failed to send the signal the timer stops. */
>  	return ret > 0;
>  }

