Return-Path: <linux-kernel+bounces-406513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93C9C6042
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B80B281B53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A44215C4F;
	Tue, 12 Nov 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="S5+hUPug"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF1FC7F8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435621; cv=none; b=KIYOCN5r1jT6B4d8tQQV0Q7dSdp/tKijAjJnHxgoGGIXyLDjexkYjvOTMLduEW78WgXnVWv7exjJqBr0QKng7dOSlkf/pm4pTtVNdoBYU4ZLlGzktpQPUV+8wktUFsWAZXsMOkax0QhBABi33jRyXUciREPMpU9ecWUbFCKPG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435621; c=relaxed/simple;
	bh=CLxSHmzSf+YmZT578sV24Yddau8UHmWqIZztKVilakQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogS/8NbKOJFlU1gy7ei4ITu2Iwp/RRNu1jhuYn4ZFjXQXAVtC91OfjP7tTxXxI/0kuhApYEX2YB/78rVnZXju9dTajARHzWWZe/rqIRvwo2KGcWCnESpkHAisGQOs+8tS0yYTUDZ1ZHIUndJ3PzyZZzra+p/Nh/IJk7Gw5ep6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=S5+hUPug; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6bc0600f9so22105195ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731435618; x=1732040418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbgHmJ4Gkoa5mlbvbFyvZJofKbNS5nmsA8PherQHRCQ=;
        b=S5+hUPugKqeync/ghYe9aNzaOk0nL/qHwonbH1tWAFxt1OrIvlQyfkVoJy2MDIqtYu
         e7sevtJQhe3r6ZfBQi/V10MWoG3K0bIpC0iWCACcl8ub4AsmmEAzGcIDrzPraV5Kw5Pm
         7OsUiW9vUhohy6g9YY47SXMduz5pe8oZ4R+zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435618; x=1732040418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbgHmJ4Gkoa5mlbvbFyvZJofKbNS5nmsA8PherQHRCQ=;
        b=ehmyts/ySatXttrJilzMjFOQ5w0hYDBy60vjDB9nA553faLG54mJ6QUvrE0QD3jbOT
         8D9CWBuieFjfXmIFgTu5UIhsf8pezSu9TbUYf0Vm82wfGegr94RIa21ZVctiL4ehIV6o
         F3XAb34D1rJcVKXKL6wG2LckkRHsIhSGLYNY5h5c9cGbl6LTroXcNlETBI87M8teQAMF
         lxgy8pvX4eqPvQWIRivAVELJvKGta6wt3ZmhR3b03GM2pv3fPM6IZj+n5lXa6mzIBewr
         ggnzYCRHYnKrvDK7wIxpyZ4aarAh9+uJYDB7ow6mO/ulhPmq0+kKCxUtsCvZwbd5gWqD
         WMxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUmjRBi12YnL73aNJA2qNlPi4nfTPGYo9BhqOAe0fHpyP9IfNhnSDo+dmM59VzRxwx4CGU/yifG1sh9hY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6o+Mm6vIbd/XGCczTqUng5JSLXXGl3Hn0F+QXPpw7xhTeqWQ
	/YugM0o3VO7jqA0ffMvjCjrXBNWMG3eTaM/O4Dr6tYLNyQf0bVIrRuyaDMFbxYE=
X-Google-Smtp-Source: AGHT+IEMCaOCoDJ0ynINun1IJWZ3XqXIpriEuBjl6UXx6tqM7krrQJvHFKH2KmtJuObqBgs9li4ofg==
X-Received: by 2002:a05:6e02:1f0e:b0:3a7:afb:7b36 with SMTP id e9e14a558f8ab-3a70c8975a0mr41007805ab.22.1731435617878;
        Tue, 12 Nov 2024 10:20:17 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de78763435sm2149548173.70.2024.11.12.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:20:17 -0800 (PST)
Date: Tue, 12 Nov 2024 18:20:16 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <20241112182016.GA2057531@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
 <874j4co98w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874j4co98w.ffs@tglx>

On Tue, Nov 12, 2024 at 02:46:23PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 12 2024 at 00:43, Frederic Weisbecker wrote:
> > Le Fri, Nov 08, 2024 at 05:48:34PM +0000, Joel Fernandes (Google) a écrit :
> 
> >> During tick restart, we use last_tick and forward it past now.
> >>
> >> Since we are forwarding past now, we can simply use now as a reference
> >> instead of last_tick. This patch removes last_tick and does so.
> >>
> >> This patch potentially does more mul/imul than the existing code,
> >> as sometimes forwarding past now need not be done if last_tick > now.
> >> However, the patch is a cleanup which reduces LOC and reduces the size
> >> of struct tick_sched.
> 
> May I politely ask you to read and follow the Documentation
> vs. changelogs?
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> 
> Also
> 
> git grep 'This patch' Documentation/process
> 
> might give you a hint.

Oops, sorry. I will go read that again. My bad.

> >> -	/* Forward the time to expire in the future */
> >> -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> >> +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
> 
> How is a division and multiplication in this hotpath helpful? That's
> awfully slow on 32-bit machines and pointless on 64-bit too.

Yes, I was afraid of that but also hrtimer_forward() already does div and
mult:

        if (unlikely(delta >= interval)) {
                s64 incr = ktime_to_ns(interval);

                orun = ktime_divns(delta, incr);
                hrtimer_add_expires_ns(timer, incr * orun);

I am not fully sure if I am doing division and multiplication more often than
existing code (I'll go count that), because tick should not be stopped at a
distance of just 1 tick I think (otherwise why stop it in the first place..).

> Using now is also wrong as it breaks the sched_skew_tick distribution by
> aligning the tick on all CPUs again.

I am not very familiar with that so I'll do some research on it, thanks!

> IOW, this "cleanup" is making things worse.

Sorry and thanks for filling me in on the drawbacks of this. One of the goal
of this particular change I posted is to learn "why not" and this really
helped, thanks!

> > We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
> > enough a relevant information.
> >
> > How about just this? It's worth it as it now forwards after the real last programmed
> > tick, which should be close enough from @now with a delta below TICK_NSEC, or even
> > better @now is below the expiry. Therefore it should resume as just a no-op
> > or at worst an addition within hrtimer_forward():
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 753a184c7090..ffd0c026a248 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> >  {
> >  	hrtimer_cancel(&ts->sched_timer);
> > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> >  
> >  	/* Forward the time to expire in the future */
> >  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> 
> That's just wrong. ts->sched_timer.expires contains a tick in the
> future. If tick_nohz_stop_tick() set it to 10 ticks in the future and
> the CPU goes out of idle due to a device interrupt before the timer
> expires, then hrtimer_forward() will do nothing because expires is ahead
> of now.
> 
> Which means the CPU is not idle and has no tick until the delayed tick
> which was set by tick_nohz_stop_tick() expires. Not really correct.

I agree, Frederic's suggestion will break as we have to reset the hrtimer back
to reality.

thanks,

 - Joel


