Return-Path: <linux-kernel+bounces-395583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0869BC01A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF53B2131B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB31C304A;
	Mon,  4 Nov 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SJAZRxcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqK9UkWr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADC19BBA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755922; cv=none; b=eGVWB/birNQKjf9jwgODnxhO0xze3OEqg0iGl6IfaZsUynjicITVI9PMVbX691G5Fh+ixQNnowv7tnwf6JeJXegyEZ/yOJn9GrVcrfiC4OUU51/nXcnIUWW+zNB+hglzU+G0oi+b77kQWsgb7WK0NR6FOB8L6NQ2r/hbssVS73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755922; c=relaxed/simple;
	bh=fx9gFf09RjPLR1o9eWSmUX6o7p4kligpg2b8DXhsx3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZH5KVspyXdm8tb10fDndfAEi8Ch2UY+dl1LaoGVN7KDzm0FJrIawpFMgNcAC2faURq98VCNoVMfXhlS7L5uGrJ+W5jjlq3yCY+KxtjcOQrCkFcDlDlPv67UDeK/EXYVqGeTzvw/oCZfuUMJ4gEmrGibvoGWhxtm77D6n3/EMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SJAZRxcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqK9UkWr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730755918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soaHNMxi7Lenk5tI7evGGia08TpSKvGUkKS6u9mIN1I=;
	b=SJAZRxcC/mB2eawyFNagrc2wPLDqbz/lm/PpSatY4k5qGlgvc833+aIuTVDyLZKfC24L5l
	25qg8vNzgPX5IfiGbFOtqKEcXWpE942R/RdbiWgk7zBjCXKplZt6Ig68Tv2Sh5id7kI0jL
	Lmv17oHAulmi24LOXDuUCHET6LAJ3fIanGRG3R/pMchDs/HTEESK0orXmJ8CFW649IsSs3
	0xOJ8IKmpoHsA9ZWl0HNlJNqb5MvDVVT5rmgEyYrCd9iu0hjY4lvgtpdC7dyzIoeEiHiSQ
	/Q4Q8V92z6Ye0ehQJHpUX2mf9YdudiVZWeyHa7BZAsP0hEbcI1JE5Wv1d+KGgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730755918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soaHNMxi7Lenk5tI7evGGia08TpSKvGUkKS6u9mIN1I=;
	b=LqK9UkWrYVvwPYj+mSSzVywbG8wpsMauqsw9PELBWDx+lUafbiZZJHX3ApG/vZ9C7LXakv
	iv5CKD7stVGlhLBw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6.1 17/20] signal: Queue ignored posixtimers on ignore
 list
In-Reply-To: <87plnbowh6.ffs@tglx>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de> <8734k9qrcr.ffs@tglx>
 <ZyizGM4-3FmPDtGj@localhost.localdomain> <87plnbowh6.ffs@tglx>
Date: Mon, 04 Nov 2024 22:31:57 +0100
Message-ID: <87msieptwy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 04 2024 at 16:21, Thomas Gleixner wrote:

> On Mon, Nov 04 2024 at 12:42, Frederic Weisbecker wrote:
>> But there is something more problematic against the delete() path:
>>                                    
>> Thread within                  Signal target             Timer target
>> signal target group
>> --------------------           -------------             -------------
>>                                                          timr->it_status = POSIX_TIMER_REQUEUE_PENDING
>>                                                          posixtimer_send_sigqueue();
>>                                                          do_exit();
>> timer_delete()
>>     posix_cpu_timer_del()
>>         // return NULL
>>         cpu_timer_task_rcu()
>>         // timer->it_status NOT set
>>         // to POSIX_TIMER_DISARMED
>>     hlist_del(&timer->list);
>>     posix_timer_cleanup_ignored()
>>
>>
>>                                do_sigaction(SIG_IGN...)
>>                                flush_sigqueue_mask()
>>                                   sigqueue_free_ignored()
>>                                       posixtimer_sig_ignore()
>>                                           // Observe POSIX_TIMER_REQUEUE_PENDING
>>                                           hlist_add_head(...ignored_posix_timers)
>>                                do_exit()
>>                                    exit_itimers()
>>                                    if (hlist_empty(&tsk->signal->posix_timers))
>>                                        return;
>>                                    // leaked timer queued to migrate list
>>                                    
>
> Duh. Let me stare at that some more.

The delete() issue is actually easy to address:

  posixtimer_sig_ignore() must check timer->it_signal, which is set to
  NULL in timer_delete(). This write must move into the sighand lock
  held section, where posix_timer_cleanup_ignored() is invoked.

  If NULL, posixtimer_sig_ignore() drops the reference.

  If do_sigaction() locked sighand first and moved it to the ignored
  list, then posix_timer_cleanup_ignored() will remove it again.


The status part is hard to get right without sighand lock being held,
but it is required to ensure that a pending one-shot timer signal is
dropped in do_sigaction(SIG_IGN).

There is an easy fix for that too:

  posixtimer_send_siqqueue() does the following under sighand lock:

    timer->it_sig_periodic = timer->it_status == POSIX_TIMER_REQUEUE_PENDING;
         
  posixtimer_sig_ignore() checks that flag. If not set it can drop the
  reference independent of the actual status of the timer. If the timer
  was rearmed as periodic, then it did not expire yet because the expiry
  would have set the flag. If it expires concurrently the expiry
  function is stuck on sighand::siglock.

  If the flag is set then the signal will go onto the ignored list and
  un-ignore will move it back to the pending list. That's not a problem
  in the case that the timer was re/dis-armed before or after moving, as
  this is all covered by the sequence check.

All of that works because in both cases the protection scheme on the
timer side is that both timer::lock and sighand::siglock have to be held
for modifying

   timer::it_sigqueue_seq
   timer::it_signal
   timer::it_sig_periodic

which means that on the signal side holding sighand::siglock is enough.

In posixtimer_deliver_signal() holding the timer lock is sufficient to
do the sequence validation against timer::it_sig_periodic.

I'll fixup the inconsistent state thing in posix-cpu-timers too and send
out a v7 soon.

Thanks a lot for studying this in detail!

        tglx



