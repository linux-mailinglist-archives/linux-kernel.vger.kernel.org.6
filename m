Return-Path: <linux-kernel+bounces-392234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CB9B9150
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8EE28368A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9C199E94;
	Fri,  1 Nov 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEty/j6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082ECF9D9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465521; cv=none; b=j+0idILYtsb9H1s+BrrfHzk/nxYilJ4YNJElezGQtUbuZcdMHcapEh2ENYy5jOuT4X1LZQK1Djjblx7+9s/zf18zEuk4wk2/rrOf/QnLTXYg7D+evV+8gGuqx5HGXvG52qrXmTsJ5xUfWQe6oFGJQgLHu1oEXFgd94NscDtqwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465521; c=relaxed/simple;
	bh=H+aNtEBwueduLsW4XnWQR+rrmk/1O7+5DwZemAt3L6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/DeU3K6mYjSim82b1V/v6+jjUsBujat2DK8V2fAZxcgNa8Ed9gsqwntnCN1ILUgfTiJpPHkFlmw/QSWCNY8nNPsf5Ls9qW8q2KUUbnfK6kdRnBr9rgqkaNN8a/4g4dRXYzSkX4DiUAssbCXDrLo95JbUdLxJKkFtVoi449f6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEty/j6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ACEC4CECD;
	Fri,  1 Nov 2024 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730465520;
	bh=H+aNtEBwueduLsW4XnWQR+rrmk/1O7+5DwZemAt3L6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEty/j6+RyqFJniOH+Wz6hWSabi8QYHGAxuSDRzOiqDfHWfUB4VVtLG5StG8qJVfN
	 aXxeCoW1PVu7A4B3HuQueyqXgmdIzSspcktcdnSvjHOABFWFd1/McQ/EeLAz9iTpeT
	 DYhMigJtWlJDOXxmpPxttZkb5AHsCvEUDc9oO0JBmoWqUm1a8vuL0oAPm4IGOC2zgj
	 6hzVwFSdECDTCSKKLYSunqHJEgiTBxY4pu26gl79IdNZfaUrJIYtaFvGB/UTk8UWlW
	 G6Sf/gBRQX4NLnew0lAfZe2tS1o5NFzgTXrCj4Ty5tyNkV1Lf1OqA9FbH2mU8dLoZn
	 ejPJwnhmIBlOQ==
Date: Fri, 1 Nov 2024 13:51:58 +0100
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
Message-ID: <ZyTO7mFZWRZf7sNv@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.677253735@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154424.677253735@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:25PM +0100, Thomas Gleixner a écrit :
> The handling of the timer overrun in the signal code is inconsistent as it
> takes previous overruns into account. This is just wrong as after the
> reprogramming of a timer the overrun count starts over from a clean state,
> i.e. 0.
> 
> Don't touch info::si_overrun in send_sigqueue() and only store the overrun
> value at signal delivery time, which is computed from the timer itself
> relative to the expiry time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> V6: Fold the timer_overrun_to_int() cleanup from Frederic and remove all
>     overrun fiddling from the signal path.
> ---
>  kernel/signal.c            |    6 ------
>  kernel/time/posix-timers.c |   11 ++++++-----
>  2 files changed, 6 insertions(+), 11 deletions(-)
> ---
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, st
>  
>  	ret = 0;
>  	if (unlikely(!list_empty(&q->list))) {
> -		/*
> -		 * If an SI_TIMER entry is already queue just increment
> -		 * the overrun count.
> -		 */
> -		q->info.si_overrun++;
>  		result = TRACE_SIGNAL_ALREADY_PENDING;
>  		goto out;
>  	}
> -	q->info.si_overrun = 0;

So it's not cleared anymore on signal queue?

Not sure if it's a big problem but if an interval timer gets a signal with
overruns and then the timer is reset later as non interval, the resulting
upcoming signals will still carry the previous non-zero overruns?

However it's better to keep the overrun update on a single place so
perhaps this?

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 66ed49efc02f..f06c52731d65 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -282,6 +282,8 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 		++timr->it_signal_seq;
 
 		info->si_overrun = timer_overrun_to_int(timr);
+	} else {
+		info->si_overrun = 0;
 	}
 	ret = true;
 
Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

