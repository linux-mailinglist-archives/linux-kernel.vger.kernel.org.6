Return-Path: <linux-kernel+bounces-393599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5209BA2D7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8641A283365
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D861714CA;
	Sat,  2 Nov 2024 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTDoJYxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673701494B3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730588270; cv=none; b=NtXVefM4TzRCaTHpmYzf/8kUlV9X62EQz4itF+gLIiCBfwGC71p31iIEnJ/6vrUnPBLSsPGPLv7XmFSTd5TeyBT7LzIzyb6MmYTgzyuCf9FWvLj0iSCL88WNHKTppCbYnDiNb8jbHfIL3v7CW8KBlEiNj0yYlBK9o+xA7M7wPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730588270; c=relaxed/simple;
	bh=y4xER3y91kpKnhVy3Y7EI1I0sRsYhkyzLhJPjciSQbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvOT/MGNAYfUwx3jaabpgP18cirSwwRJ/8RnqOClcHZfpg24QcVnz7pz2CODTbfs+i6vrD0EJNw+twbkEOmk3LGEHrPqYCfuCbHuwIu9fZIEElIQIMUjmg0OgrxFc16nOcrZnlSYWRgX6TYB2zDoUjssqksNM7O5L2LXVA0qeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTDoJYxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FECDC4CEC3;
	Sat,  2 Nov 2024 22:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730588270;
	bh=y4xER3y91kpKnhVy3Y7EI1I0sRsYhkyzLhJPjciSQbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTDoJYxovaYzuTs9L/UiorZCl9WVxu7EMzZ+6WRp1ugkym9g+hJHHr/rMnVQcDBsZ
	 lO2u7FNpsXzBIJuOyXOYfKEzcz65a+MwoAW0jBAWpHg5ep6NQ38/pWuXzs5/iZBsh1
	 9yM8OJ5eByigSdUE7oyunNuUkKJAwexgZ1pz48noK0nuJWmlwKYBFjNdiOq2moNkD9
	 RqS/nRIlgzxUMsUrH5kQhwDLyMchWSj6VPTuxscx0pKW3jhizqbHfISh9iRI/9zYyz
	 TQOtpdT6cVHmEeBF/xyFlfYAW1lv/4yG2+zNHCUnHj+w/UME+GlnYHcncHIflvHR/F
	 F/9BqEBDfDB8w==
Date: Sat, 2 Nov 2024 23:57:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 02/20] posix-timers: Make signal overrun accounting
 sensible
Message-ID: <Zyauaj2icYHqc33N@pavilion.home>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.677253735@linutronix.de>
 <ZyTO7mFZWRZf7sNv@localhost.localdomain>
 <877c9mvgh7.ffs@tglx>
 <878qu1qv7i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qu1qv7i.ffs@tglx>

Le Sat, Nov 02, 2024 at 08:41:53PM +0100, Thomas Gleixner a écrit :
> On Fri, Nov 01 2024 at 21:36, Thomas Gleixner wrote:
> > On Fri, Nov 01 2024 at 13:51, Frederic Weisbecker wrote:
> >> Le Thu, Oct 31, 2024 at 04:46:25PM +0100, Thomas Gleixner a écrit :
> >>> @@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, st
> >>>  
> >>>  	ret = 0;
> >>>  	if (unlikely(!list_empty(&q->list))) {
> >>> -		/*
> >>> -		 * If an SI_TIMER entry is already queue just increment
> >>> -		 * the overrun count.
> >>> -		 */
> >>> -		q->info.si_overrun++;
> >>>  		result = TRACE_SIGNAL_ALREADY_PENDING;
> >>>  		goto out;
> >>>  	}
> >>> -	q->info.si_overrun = 0;
> >>
> >> So it's not cleared anymore on signal queue?
> >>
> >> Not sure if it's a big problem but if an interval timer gets a signal with
> >> overruns and then the timer is reset later as non interval, the resulting
> >> upcoming signals will still carry the previous non-zero overruns?
> >
> > Duh. Yes.
> >
> >> However it's better to keep the overrun update on a single place so
> >> perhaps this?
> >>
> >> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> >> index 66ed49efc02f..f06c52731d65 100644
> >> --- a/kernel/time/posix-timers.c
> >> +++ b/kernel/time/posix-timers.c
> >> @@ -282,6 +282,8 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
> >>  		++timr->it_signal_seq;
> >>  
> >>  		info->si_overrun = timer_overrun_to_int(timr);
> >> +	} else {
> >> +		info->si_overrun = 0;
> >>  	}
> >>  	ret = true;
> >>  
> >> Other than that:
> >
> > Let me fold that.
> 
> Actually no. info is the siginfo which was allocated by the signal
> delivery code on stack.
> 
> collect_signal() copies timer->sigqueue.info into that siginfo
> struct. As timer->sigqueue.info.si_overrun is zero and never written to,
> this else path is pointless.

Good point, thanks for pointing out!

