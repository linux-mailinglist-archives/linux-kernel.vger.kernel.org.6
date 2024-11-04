Return-Path: <linux-kernel+bounces-395655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FC9BC13A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BFA1F22946
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF81B2198;
	Mon,  4 Nov 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjIvBGdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05216087B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761348; cv=none; b=WdeiFQEwUnhRJfJ2YHn9EcjmNswRXi8vqZsyzWoYTj0fSacdniGfXQypYUNgP8G0Zj3172tiSSgRcLKHvPaqhoyURV1i54R+2/64pWfmZDaGrR3EgM/h07RM6UG9J0uXtlRlTK2lOKa5XdlhICR7ZVbEYs6mHqETRtL7qN8jO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761348; c=relaxed/simple;
	bh=LjLu6o9Ujp7xHl9vr+OkzdT9oGVoaxAWokeQ+nmHfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rut3yxdY7WTmUwrW3QrTypb66Jl+aX1L1ir14ErTzMqUxPq6eCZkR3ibkmJUbRv/N5IgtzE269lIJZw1XKQZ9/SVRFA7x3W+Bn8BVSThjQ9z4L2Q9kYDbqwnLfEBRS/SNJcIaSszT7pQxj159D4TVrnSq/+0wzfB/yIAXhfVMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjIvBGdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27158C4CECE;
	Mon,  4 Nov 2024 23:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730761348;
	bh=LjLu6o9Ujp7xHl9vr+OkzdT9oGVoaxAWokeQ+nmHfsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjIvBGdYBHzL4Z4VXg5EEKsCLBBfY3TG3rTvdw0+JLYfGpuxcaC0v7ft3ppFXQwRT
	 NnCEq4oYygL0idUShLvWF8on34dPaeAEElCeTVueae/k5e0zKkRmIC1eRxXv904tjM
	 OuvLD4wQAF1Lvevrxxwl8kIYBX0Izw+9gKsFXNYepmUk5uzOg3F8ODv3UE+k9rfRiX
	 qZFQ9vD4RLIhW/DGf9I1/EeF8NE4OikZTsDgPZa/RnhrVDajXU7j9TSSct+XttCU1A
	 eVcypbJjQxSb2nZXnaQGBFSfRTkVn/7CHNFZQM4Wv6RfBMFpRz9lPPvOGtT705uJLQ
	 s5/RtEHAyQuaQ==
Date: Tue, 5 Nov 2024 00:02:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6.1 17/20] signal: Queue ignored posixtimers on ignore
 list
Message-ID: <ZylSgfgJyf7YtQS0@pavilion.home>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <8734k9qrcr.ffs@tglx>
 <ZyizGM4-3FmPDtGj@localhost.localdomain>
 <87plnbowh6.ffs@tglx>
 <87msieptwy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msieptwy.ffs@tglx>

Le Mon, Nov 04, 2024 at 10:31:57PM +0100, Thomas Gleixner a écrit :
> On Mon, Nov 04 2024 at 16:21, Thomas Gleixner wrote:
> 
> > On Mon, Nov 04 2024 at 12:42, Frederic Weisbecker wrote:
> >> But there is something more problematic against the delete() path:
> >>                                    
> >> Thread within                  Signal target             Timer target
> >> signal target group
> >> --------------------           -------------             -------------
> >>                                                          timr->it_status = POSIX_TIMER_REQUEUE_PENDING
> >>                                                          posixtimer_send_sigqueue();
> >>                                                          do_exit();
> >> timer_delete()
> >>     posix_cpu_timer_del()
> >>         // return NULL
> >>         cpu_timer_task_rcu()
> >>         // timer->it_status NOT set
> >>         // to POSIX_TIMER_DISARMED
> >>     hlist_del(&timer->list);
> >>     posix_timer_cleanup_ignored()
> >>
> >>
> >>                                do_sigaction(SIG_IGN...)
> >>                                flush_sigqueue_mask()
> >>                                   sigqueue_free_ignored()
> >>                                       posixtimer_sig_ignore()
> >>                                           // Observe POSIX_TIMER_REQUEUE_PENDING
> >>                                           hlist_add_head(...ignored_posix_timers)
> >>                                do_exit()
> >>                                    exit_itimers()
> >>                                    if (hlist_empty(&tsk->signal->posix_timers))
> >>                                        return;
> >>                                    // leaked timer queued to migrate list
> >>                                    
> >
> > Duh. Let me stare at that some more.
> 
> The delete() issue is actually easy to address:
> 
>   posixtimer_sig_ignore() must check timer->it_signal, which is set to
>   NULL in timer_delete(). This write must move into the sighand lock
>   held section, where posix_timer_cleanup_ignored() is invoked.
> 
>   If NULL, posixtimer_sig_ignore() drops the reference.
> 
>   If do_sigaction() locked sighand first and moved it to the ignored
>   list, then posix_timer_cleanup_ignored() will remove it again.

Indeed. Unconditionally writing ->it_status to DISARMED in posix_cpu_timer_del()
would also do the trick as that write would be released by the sighand unlock after
posix_timer_cleanup_ignored(). But testing ->it_signal after guaranteeing it is
written inside sighand looks like a more straightforward way to go.

(Still it makes sense to unconditionally set ->it_status to DISARMED after delete()).

> 
> 
> The status part is hard to get right without sighand lock being held,
> but it is required to ensure that a pending one-shot timer signal is
> dropped in do_sigaction(SIG_IGN).
> 
> There is an easy fix for that too:
> 
>   posixtimer_send_siqqueue() does the following under sighand lock:
> 
>     timer->it_sig_periodic = timer->it_status == POSIX_TIMER_REQUEUE_PENDING;
>          
>   posixtimer_sig_ignore() checks that flag. If not set it can drop the
>   reference independent of the actual status of the timer. If the timer
>   was rearmed as periodic, then it did not expire yet because the expiry
>   would have set the flag. If it expires concurrently the expiry
>   function is stuck on sighand::siglock.
> 
>   If the flag is set then the signal will go onto the ignored list and
>   un-ignore will move it back to the pending list. That's not a problem
>   in the case that the timer was re/dis-armed before or after moving, as
>   this is all covered by the sequence check.
> 
> All of that works because in both cases the protection scheme on the
> timer side is that both timer::lock and sighand::siglock have to be held
> for modifying
> 
>    timer::it_sigqueue_seq
>    timer::it_signal
>    timer::it_sig_periodic
> 
> which means that on the signal side holding sighand::siglock is enough.
> 
> In posixtimer_deliver_signal() holding the timer lock is sufficient to
> do the sequence validation against timer::it_sig_periodic.

Exactly.

> 
> I'll fixup the inconsistent state thing in posix-cpu-timers too and send
> out a v7 soon.

Thanks!

