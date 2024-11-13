Return-Path: <linux-kernel+bounces-408401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064999C7E55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA81285298
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE618C005;
	Wed, 13 Nov 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BtIn72Jb"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7C17A597
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537556; cv=none; b=uM3CoCZj52LTspeTkK6k1Go6N1bOvoq1VNh19LERMTnK7r1DNIhGul51GDrr6UNe7TyLkMq4oHhl2UsB9PNxYmeg/QM/cEoJlOPUc8Y8CXO1fbUDC/S7GEIveadNVwXUxKBRyC0WDxv7XkrV3k04qwvHO9YBNc6coQyjPrVMoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537556; c=relaxed/simple;
	bh=q1QhUkOFt61jacMK0YXMALVLobqB39lmim39e4dP/24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlsroQAcyk3fqo46GABfMwsfLXMFfLSlPPxEUK2p1Mu6zI6IXF6A6M6GoL9jspYPMzKG5M/ddXc+Tht1nC38jMsqZUOpj7vBuqyuRblq7YCrhTVzpEe9NToK4FkmuETx7nN2x8BRJitqFhu3V4cusBN9JO3v+6YLS+tfEAz4DGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=BtIn72Jb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3c00f2c75so26413965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731537554; x=1732142354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKpVg45VRQ9OaKCVvpAuH8rnLY78q7P84Mw6JJiht30=;
        b=BtIn72JboGyMoxJ0BpDp+i1H8mXPoKCehoUMMh384SwQ+JpnAWLLSjf3VX3j9HvcrR
         VaUQhF1oDXFDqN0e+qN9uHNxf4J0vbPra4yjvKPx2AD6XXhVSGE0BN3It9EOtpf/U2Kf
         BUqohneaA9OMupnDPavGqhbtC7QuQDZjR++LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731537554; x=1732142354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKpVg45VRQ9OaKCVvpAuH8rnLY78q7P84Mw6JJiht30=;
        b=CX7qm7il+J9qVcyQ6SHN3VWSvb85uoXquq0lQ3NqnKXpDn65RNU0J6bX5mw/GZaXhl
         Z3FxUB0AtZfFb7aBz675xlsiOaFgKkbx/PzMEu5cM9Glpx37nkpgy7EoyBIBSujUGqFJ
         QjkzlX6IcHWLeRwkNQz7HFJnMkMlj/VEhV1LJm7OsLh0wvHXwLe8PVZKzRzyLxT0AmVq
         r5R2mGvgXtYK4FN5k6ByQN/rId9jHh2htQR+NL6BUU/urEAZp2RQo94vu0kTxxIIkZhe
         17qpGjZ+ADZD5YHoyJAGlHL5tmpNv30kzXcg50fVXPNlMqr5XY0yvuq9itIGh77l0iPa
         cFTQ==
X-Gm-Message-State: AOJu0Yz+/3hzBXwKH/lgyqYjNr4O0VW6EQ41X65OCfCXCnIz0X+vH1wL
	fGSr/mIWIMp00ipXilsGcNMWknQH4U2vfYNDS85pY+sMP8pjFC6OgxuhXT6kOag=
X-Google-Smtp-Source: AGHT+IHnsJb70CkNEZXcoSgcDA7uXgh0RcGKdO4SbwfZn7X2nVxrdkvke5Ziz1K+6CZaOsRKQUF6Bw==
X-Received: by 2002:a05:6602:158e:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83e03351215mr2687932039f.12.1731537553675;
        Wed, 13 Nov 2024 14:39:13 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de78715634sm3152312173.27.2024.11.13.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 14:39:13 -0800 (PST)
Date: Wed, 13 Nov 2024 22:39:12 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Message-ID: <20241113223912.GD2331600@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
 <ZzKES39RkUfyN5x4@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzKES39RkUfyN5x4@pavilion.home>

On Mon, Nov 11, 2024 at 11:25:15PM +0100, Frederic Weisbecker wrote:
> Le Fri, Nov 08, 2024 at 05:48:36PM +0000, Joel Fernandes (Google) a écrit :
> > This solves the issue where jiffies can be stale and inaccurate.
> > 
> > Putting some prints, I see that basemono can be quite stale:
> > tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000
> 
> That's 3 ms. If HZ < 1000 that's to be expected. But even with HZ = 1000 it can
> happen.

For me HZ=1000 though.

> > Since we have 'now' in ts->idle_entrytime, we can just use that. It is
> > more accurate, cleaner, reduces lines of code and reduces any lock
> > contention with the seq locks.
> 
> Do we need such accuracy? The timers rely on jiffies anyway.
> Also it's a seqcount read. Basically just a pair of smp_rmb().
> Not sure a division would be cheaper.

In low resolution mode, hrtimers are also expired by the tick. It seems to
me, because of the error in jiffies, the clockevent programming for the tick
will also have errors which reflect in hrtimer expiry (granted if one does
not want errors in hrtimer, they shouldn't be using low-res mode, but
still a bounded error is better than an unpredictable unbounded one..).

I agree on the division issue though, I couldn't find an alternative.

Expanding on the previous paragraph, it seems to me that we will end up
programming the clockevent with incorrect values that are subject to the
error. Like if basemono is lagging by several ticks, then 'expires' value in
clock event may also be lagging.  Then after the clock event is programmed
with the erroneous value, the clockevent will wake up the CPU too soon I
think causing power wastage. If the jifies was accurate, the clockevent would
wake up the system more into the future..

Or do you see this scenario not playing out?

> > I was also concerned about issue where jiffies is not updated for a long
> > time, and then we receive a non-tick interrupt in the future. Relying on
> > stale jiffies value and using that as base can be inaccurate to determine
> > whether next event occurs within next tick. Fix that.
> > 
> > XXX: Need to fix issue in idle accounting which does 'jiffies -
> > idle_entrytime'. If idle_entrytime is more current than jiffies, it
> > could cause negative values. I could replace jiffies with idle_exittime
> > in this computation potentially to fix that.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/time/tick-sched.c | 27 +++++++--------------------
> >  1 file changed, 7 insertions(+), 20 deletions(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 4aa64266f2b0..22a4f96d9585 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -860,24 +860,6 @@ static inline bool local_timer_softirq_pending(void)
> >  	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
> >  }
> >  
> > -/*
> > - * Read jiffies and the time when jiffies were updated last
> > - */
> > -u64 get_jiffies_update(unsigned long *basej)
> > -{
> > -	unsigned long basejiff;
> > -	unsigned int seq;
> > -	u64 basemono;
> > -
> > -	do {
> > -		seq = read_seqcount_begin(&jiffies_seq);
> > -		basemono = last_jiffies_update;
> > -		basejiff = jiffies;
> > -	} while (read_seqcount_retry(&jiffies_seq, seq));
> > -	*basej = basejiff;
> > -	return basemono;
> > -}
> 
> This is used in tmigr as well.

Yeah, sorry I had fixed the issue in my next revision when I adjusted the
timer migration code:

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=timers/tick-sched&id=1cf33bddf50341cf9802ed19374dc42d8466868b

I am on work travel this week, apologies for slow replies and thanks so much
for your replies and your discussions!

thanks,

 - Joel


