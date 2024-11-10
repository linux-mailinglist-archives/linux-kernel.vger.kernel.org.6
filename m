Return-Path: <linux-kernel+bounces-403402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACF9C3526
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C94E1F20FC1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4815958A;
	Sun, 10 Nov 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tM/TP22Z"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F76158208
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731279350; cv=none; b=kznPmQiIa2UtBVQtcckHcusEgu8qrTXkCunQC0/InDS63Y/Y1DHpmHppydkbhH+oglsdH1SovOQNNnXCruyR7zwCHQD+j3wJwQl66WMF09Jba8jheB196wiq0tjZRhDZ5kFFNf2ltCdUhRIYJf9+OVzFmhs57X/cIcipcwDSC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731279350; c=relaxed/simple;
	bh=vtJorjk0094tguv7K4akwUUhCd6GQAugX1vz5O+DqJo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctNPaIcGia9qk6WDlt39gV2X05iVPGDEJ9d2zVsd5+B6afo1IsP+87PU1xuER5Xw2cutSr7H3vPUOONH2WtU+FMGhrxHp61hJCQwAPAwaY2twG53KI/FDEjCpMxknsF/uB3m2RMzpl1779nDppCncejBGMnhjkaHmoTN3tYpnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=tM/TP22Z; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83aac75fcceso138484639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731279347; x=1731884147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xnTpwMmO3KB8r2J/VOybgISEzuIz63+AB/8ZUoPZDw=;
        b=tM/TP22ZEd12pYBGpItOVzoQOhoRArJMj4KxCiCsvAbKRfcJY5MmraDmka/8U1oVzZ
         7VpFkcg3naD3tJGu4C8Bx8i8tNlki+bkLBhYAWAO6y+o16GBoXDpIL2tQMvjnSj9usM8
         uSg3yDWkT5CBvsyOP3EqMzcENgOuRz+eXBGBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731279347; x=1731884147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xnTpwMmO3KB8r2J/VOybgISEzuIz63+AB/8ZUoPZDw=;
        b=EddmQ/LdKbh/VgpX13fWpolHbKwy5FipTS1rH6M8+ypLZgdLcOb/8P+ZlGF2H1aU25
         UD3cxFwA+zIT11n6jRDwDOwstfZ4/u/XlhgaxtZNO4xPILb+Tjv+iY3qiSS4eUSsZOge
         Q5mDYeSzMw655v3V1XkbrPUYsG98YunznVH8laCSduw44Whteek+P8Pave2LNntTQkcb
         gBP5qUOqQjcvLRy0VqR7Q083Auchg6e3QDD+Qf8KVC3i8EvAyi2dBCVemlb8w5Kmr1hx
         hIFT6pqFLEXubR5/gBM5yqNYvUEwKkUJM7Gm0VoKGilE4RMLyiDcMX++ePP4D8UDbEEw
         Qurg==
X-Gm-Message-State: AOJu0Yy3vuh7JvDowkTTfeanobB9STC1PXIJw+rmBwmB0J37dk+jrgzt
	AOKeE6TDfIBBT1X6Jrd20bFnQp0wWTKXrtnQECZasDCGmX/dxu8aCcW8ftc6tfONJiJhwfyZHrt
	e
X-Google-Smtp-Source: AGHT+IHSv4Z+ReIssTvoEgs0JaVQFtUqRAhCgG9y63vqTGOQXt2Ewr6vJipQ2c8IoRzMhUZxo84yUw==
X-Received: by 2002:a05:6602:160f:b0:83d:ff89:218c with SMTP id ca18e2360f4ac-83e032f96d1mr1126811739f.7.1731279347248;
        Sun, 10 Nov 2024 14:55:47 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e130aa6c5sm98420839f.0.2024.11.10.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 14:55:46 -0800 (PST)
Date: Sun, 10 Nov 2024 22:55:45 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Message-ID: <20241110225545.GA1579217@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108174839.1016424-4-joel@joelfernandes.org>

On Fri, Nov 08, 2024 at 05:48:36PM +0000, Joel Fernandes (Google) wrote:
> This solves the issue where jiffies can be stale and inaccurate.
> 
> Putting some prints, I see that basemono can be quite stale:
> tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000
> 
> Since we have 'now' in ts->idle_entrytime, we can just use that. It is
> more accurate, cleaner, reduces lines of code and reduces any lock
> contention with the seq locks.
> 
> I was also concerned about issue where jiffies is not updated for a long
> time, and then we receive a non-tick interrupt in the future. Relying on
> stale jiffies value and using that as base can be inaccurate to determine
> whether next event occurs within next tick. Fix that.
> 
> XXX: Need to fix issue in idle accounting which does 'jiffies -
> idle_entrytime'. If idle_entrytime is more current than jiffies, it
> could cause negative values. I could replace jiffies with idle_exittime
> in this computation potentially to fix that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/time/tick-sched.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 4aa64266f2b0..22a4f96d9585 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -860,24 +860,6 @@ static inline bool local_timer_softirq_pending(void)
>  	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
>  }
>  
> -/*
> - * Read jiffies and the time when jiffies were updated last
> - */
> -u64 get_jiffies_update(unsigned long *basej)
> -{
> -	unsigned long basejiff;
> -	unsigned int seq;
> -	u64 basemono;
> -
> -	do {
> -		seq = read_seqcount_begin(&jiffies_seq);
> -		basemono = last_jiffies_update;
> -		basejiff = jiffies;
> -	} while (read_seqcount_retry(&jiffies_seq, seq));
> -	*basej = basejiff;
> -	return basemono;
> -}
> -
>  /**
>   * tick_nohz_next_event() - return the clock monotonic based next event
>   * @ts:		pointer to tick_sched struct
> @@ -887,14 +869,19 @@ u64 get_jiffies_update(unsigned long *basej)
>   * *%0		- When the next event is a maximum of TICK_NSEC in the future
>   *		  and the tick is not stopped yet
>   * *%next_event	- Next event based on clock monotonic
> + *
> + * Note: ts->idle_entrytime is updated with 'now' via tick_nohz_idle_enter().
>   */
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  {
> -	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo;
> +	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo, boot_ticks;
>  	unsigned long basejiff;
>  	int tick_cpu;
>  
> -	basemono = get_jiffies_update(&basejiff);
> +	boot_ticks = DIV_ROUND_DOWN_ULL(ts->idle_entrytime, TICK_NSEC);
> +	basejiff = boot_ticks + INITIAL_JIFFIES;
> +	basemono = boot_ticks * TICK_NSEC;
> +

There is a bug here, I end up overcounting basejiff. I did something like
this and it now makes basejiff equivalent to the previous code so should be
good. I'll work more on it this week...

                                                                                       ─╯
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d88b13076b79..5387c67eea7a 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -34,6 +34,8 @@ DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
  */
 ktime_t tick_next_period;

+ktime_t tick_first_period;
+
 /*
  * tick_do_timer_cpu is a timer core internal variable which holds the CPU NR
  * which is responsible for calling do_timer(), i.e. the timekeeping stuff. This
@@ -219,6 +221,7 @@ static void tick_setup_device(struct tick_device *td,
                if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
                        WRITE_ONCE(tick_do_timer_cpu, cpu);
                        tick_next_period = ktime_get();
+                       tick_first_period = tick_next_period;
 #ifdef CONFIG_NO_HZ_FULL
                        /*
                         * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bd..a15721516a85 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -20,6 +20,7 @@ struct timer_events {

 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
+extern ktime_t tick_first_period;
 extern int tick_do_timer_cpu __read_mostly;

 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8a245f8ceb56..8fdfda4b8af3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -895,11 +896,23 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
        u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo, boot_ticks;
        unsigned long basejiff;
        int tick_cpu;

        boot_ticks = DIV_ROUND_DOWN_ULL(ts->idle_entrytime, TICK_NSEC);
        basejiff = boot_ticks + INITIAL_JIFFIES;
        basemono = boot_ticks * TICK_NSEC;

+       /*
+        * There is some time that passes between when clocksource starts and the
+        * first time tick device is setup. Offset basejiff by that.
+       */
+       basejiff -= DIV_ROUND_DOWN_ULL(tick_first_period, TICK_NSEC);
+
        ts->last_jiffies = basejiff;
        ts->timer_expires_base = basemono;


