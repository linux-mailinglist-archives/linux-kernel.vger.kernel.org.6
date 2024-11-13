Return-Path: <linux-kernel+bounces-408388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A39C7E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D20FB23603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989C18A6B5;
	Wed, 13 Nov 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P9Xps/M4"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0B7081D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536288; cv=none; b=T0y0RepBAWDZ3YtuFgyvjkgITh0yGI50v7HxhfF6C0VA3arDFlGcW4lXiidzKM4rTqhoEHxyXqawSR6TBLRgew8ba1pcv3OhbnBVJ94Q3U+P8JQ6HtRsWTi+gJQrtdn8ZDKgC975uF+CebCzsScHT8kXpruGsHi7FArC5lJ9GFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536288; c=relaxed/simple;
	bh=L0+uBKrUQ/0gco5VuTBXfLXf5tlrpOWQHfNNVS1Q2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcgMlVyrKXcrUX6NIIt6Xy3JWxPDHQVapSnluOCAazobU4NIiUTelOJFe4X4UcS9/6SQJ14HyuKYswdqnI+qv7WAjkxjwfFlWYwwsb4W1WBEpaFK2AwzQ9m/lcdS4zXqIQsX8bTYpk3VtCbDsU+0icEzm7aiPRomwSn7IdvLFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=P9Xps/M4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a70315d38dso13269145ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731536286; x=1732141086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUUp9hnlhuLcMZfQIzjNbXpjrKL+vQSBQg+jzje+Uys=;
        b=P9Xps/M4ouQh2VJqXYVKBUjlp1BeN9/AjpVOlyiMfKj0U4+xh4OU8BucngJfIPlgdP
         8IoGd2MC0aXLASrcXm2GCM1+csQArmW5a62MluhcExsFwW8e0qh1cIfrIZaw7KCzRg3o
         /t97PPck2wUcKtDOfexS8RgI7FJqqGMtsAmvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536286; x=1732141086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUUp9hnlhuLcMZfQIzjNbXpjrKL+vQSBQg+jzje+Uys=;
        b=BpEiM6rDvzWCK4Zt2VIbFMbN1WCFfjuor6Kl76R2pdR9dHA1rl9VtXGJnwlJo1pL1I
         Y93M1hJG0Ag/ur7fU+fgZ18vXNOZzfVmusEf8JMVfbwJQuV6DQUY5lGyN2jm4D1dx7lI
         DKoz8jTkKVduf6HHMuYHPh0QPV1jNpy4nEIou9alfoszCEoBRRi9AUMgzMi9wdBm24y1
         ro64lmHs+AaYP+/CPXwhk6Eyi3dYKa83/VvXsMFwjAumM2/1tNhzg3IfPDReRdC5GMIn
         89cxaDU1qcwTnLo/+V0xswv+LeOabiWsynWHFxesIR8qyaKRcOzkAUC1zgUIeIMV+TAZ
         AQbQ==
X-Gm-Message-State: AOJu0YwLk4CbpFDoxq5voMmAPXNbhhlqKlYdLTKdMU2YZ+b6vZRPwNoj
	NbulL4J2T7wmN1j38jFyqH+qr++4Wa/XpfWu2I81LcPHAfg83w5CU5HZDPImykw=
X-Google-Smtp-Source: AGHT+IHLrACiP2l2OLVO5VJ/rG9PEXEkh0S61CI9FGPadNm3T46Vs8+391cRikf2ZoBDq0w2dlpJ/A==
X-Received: by 2002:a05:6e02:1b07:b0:3a0:9cd5:92f7 with SMTP id e9e14a558f8ab-3a6f1a6eca3mr258548905ab.17.1731536285730;
        Wed, 13 Nov 2024 14:18:05 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de7883c03esm3023282173.157.2024.11.13.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 14:18:04 -0800 (PST)
Date: Wed, 13 Nov 2024 22:18:04 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Message-ID: <20241113221804.GC2331600@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
 <871pzgo77j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pzgo77j.ffs@tglx>

On Tue, Nov 12, 2024 at 03:30:24PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 08 2024 at 17:48, Joel Fernandes wrote:
> > This solves the issue where jiffies can be stale and inaccurate.
> 
> Which issue?

I will describe below.

> > Putting some prints, I see that basemono can be quite stale:
> > tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000
> 
> What is your definition of stale? 3ms on a system with HZ < 1000 is
> completely correct and within the margin of the next tick, no?

I am on HZ=1000. So 3ms is not within margin of the next tick for me.

> > Since we have 'now' in ts->idle_entrytime, we can just use that. It is
> > more accurate, cleaner, reduces lines of code and reduces any lock
> > contention with the seq locks.
> 
> What's more accurate and what is the actual problem you are trying to
> solve. This handwaving about cleaner, less lines of code and contention
> on a non existing lock is just not helpful.

Oh sure. the concern I have is that jiffies might be quite out of date for
whatever reason as I shared above with comparing the jiffies with
idle_entrytrime. I am not sure exactly why this happens, maybe because
interrupts were disabled on the do-timer CPU? But in any case I was concerned
about this code in tick_nohz_next_event():


	if (rcu_needs_cpu() || arch_needs_cpu() ||
	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
		next_tick = basemono + TICK_NSEC;
	}

If we are using a stale basemono, that just seems wrong to me. If basemono
is stale, then next_tick could even be in the past?

> > I was also concerned about issue where jiffies is not updated for a long
> > time, and then we receive a non-tick interrupt in the future. Relying on
> > stale jiffies value and using that as base can be inaccurate to determine
> > whether next event occurs within next tick. Fix that.
> 
> I'm failing to decode this word salad.

I think I came up with an incorrect explanation of why basemono is lagging -
I have to look deeper into when basemono can be out-of-date - I certainly saw
it being lagging sometimes as I showed in the traces.

Anyway my broken word salad was something like: Say jiffies update did not
happen for a long time (can the tick be turned off on a do-timer CPU?). Then
say if a non-tick interrupt, like a device interrupt bring the CPU out of
idle, and then on the way back to idle, it tries to stop the tick. 'basemono'
would be quite out of date.

I am just speculating, I don't know exactly why I see basemono lagging. I
thought maybe we can fix that and avoid issues in the future that might show
up because of such inaccuracy.

Other theories?

I wonder if you're going to mention that this code works even if basemono is
out-of-date. But I am concerned that in 'low resolution mode', if we have an
hrtimer that is about to expire within the next tick, and if basemono is
lagging by several ticks, then could this code accidentally not keep the tick
alive thinking that the hrtimer is several ticks away?

> > XXX: Need to fix issue in idle accounting which does 'jiffies -
> > idle_entrytime'. If idle_entrytime is more current than jiffies, it
> > could cause negative values. I could replace jiffies with idle_exittime
> > in this computation potentially to fix that.
> 
> So you "fix" some yet to be correctly described issue by breaking stuff?

Its a side-effect of this patch, more adjustments are needed. This is just an
RFC, Thomas :-)

> >  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> >  {
> > -	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo;
> > +	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo, boot_ticks;
> >  	unsigned long basejiff;
> >  	int tick_cpu;
> >  
> > -	basemono = get_jiffies_update(&basejiff);
> > +	boot_ticks = DIV_ROUND_DOWN_ULL(ts->idle_entrytime, TICK_NSEC);
> 
> Again this div/mult is more expensive than the sequence count on 32bit.

Got it, I was hoping that there was a better way to calculate the number of
ticks without expensive div/mult, let me know if you had any ideas on that?
But it seems to me there isn't an alternative. So we may have to table this
idea. Also I think it suffers from the same tick-skew issue you mentioned I
think.

> > -/*
> > - * Read jiffies and the time when jiffies were updated last
> > - */
> > -u64 get_jiffies_update(unsigned long *basej)
> 
> How does this even compile? This function is global for a reason.

Yeah, sorry I had fixed the issue in my next revision when I adjusted the
timer migration code:

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=timers/tick-sched&id=1cf33bddf50341cf9802ed19374dc42d8466868b

thanks,

 - Joel


