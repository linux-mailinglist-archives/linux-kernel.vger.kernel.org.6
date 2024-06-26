Return-Path: <linux-kernel+bounces-230697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B49180B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01582821FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55217C22E;
	Wed, 26 Jun 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W3E6LtQa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F9180A9F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404103; cv=none; b=CRVZZS+i83b0e4qXT6RN82MZpEA9NatYrJYL2mdXqfAwwPCHc5g91KhB6R/m7W/qjFO6WkKFtfCY/ZCQ+UgwaUddp9LsCHacIQ70lLFUe6I86QymokbuuN7/cexU4YTgssw5hGRJG6N6HyjmWSfy4YeEJPpoMNXomN1tVshVWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404103; c=relaxed/simple;
	bh=H3xN7XNgO4wSQjlz1GucupOGW3kccQKGe39mf4SfYek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP+Ux6m4BUP9FNa67SW1Gz5N7RI20rvG4ZEkpF2ir91Lxir+Pg1x2x9C5KJ2ANZMw1loibkRLQc4IgbWKqMx8Ap+x1s/YypWSWWiSQhVCySXO9W98RnvHfkKQOEieaW9xrz45tITXsnHis31cZ+pSPOgZ4mcHDfARJlffnxEfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W3E6LtQa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so76169851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719404099; x=1720008899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0zAqH30TzcFYcIaNWuyZONtaFaRBcnpnYO/QbPj8/4=;
        b=W3E6LtQa374mlSbOx00P0PmVPyNJLXoE2/59zKaX+Ynole1Kcgbuc89+OBXrOF4UHn
         GPvZVmzk5k3zXPK+tMgb9HllahQBOyBoqFrKFUO3I3MUJjtjYExqzMZ0lk6qZPoz/Gpc
         9M5ZOFKy1RWkQtYVzV1tnHWqkEHwiwsdz9Xs3/y89FtC/6snZeSH4Arb8PnL/i16kvyE
         en1TamOAHqFCkFMe4RD1c6PLKjRTtGwzGmccpLuWmZ7EXFVbr1WWjYgtQxm08E9b7jQW
         R7Ktsoq+uo0nJq0yN6iqMLSDqe0d5goMzBJ/snZ0IfrKdK7s89zxaUXSbJSfoukGHHV9
         XaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404099; x=1720008899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0zAqH30TzcFYcIaNWuyZONtaFaRBcnpnYO/QbPj8/4=;
        b=BC2EfvLu95FFvtNptZrGN9H9gCxMCjVtxvgK/wpots9Rcp3F77NCwPkfa96x9chfBi
         vAGky6xyB5LTe+tq7d+nd1OwfoP68ocz23aHFcYOT7sJKLvsuCKb2mGzHoIzPGNjWcjD
         rgCd2012A07oGVUmHwc45H/s1CaXdhMWvCJJXCX43ja2NeJuTw76SuAPift0/mq3pX1J
         irjoEBgvLgW1qK0oDFwsrRKAJ8ltbAsRobX863A2hMRQzmANUVZtqEl+KF8Ie0PioIqQ
         vp+yHeO6NMebAb82nRXNwTVI/j/XK23JApyTPNtxxvNPFxDrW5Qg41x09LVdKnreIBi2
         gUQw==
X-Forwarded-Encrypted: i=1; AJvYcCUdYr2NXeEuLbQcfWNiMZelKTA4HYF/f5eklJA+Dc583jf08yAJ/4VAkamaccjDa74TgwZryg6bibjsiF1RN5fFtIZWH9of66HZMQnz
X-Gm-Message-State: AOJu0YwrUdJKLb4KDsmmrZM7r46WgymLkRevan+TnvkXpvL0Eq70sLwd
	J90r5RllSPeQcc1NrDgqHbKAWA5h6x1uUGCaooFTS93szt3+tyNcm3a5jvyccgs=
X-Google-Smtp-Source: AGHT+IEk0Vd8QVRZ9+EMgzByNdvlrulhitE5mwDbIEkYBLfFebPHvlc1iJxL7iv+tLqucKv17QbrWA==
X-Received: by 2002:a2e:9847:0:b0:2ec:661e:e83e with SMTP id 38308e7fff4ca-2ec661ee8fbmr42202231fa.23.1719404099102;
        Wed, 26 Jun 2024 05:14:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8066732sm1519741a91.28.2024.06.26.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 05:14:58 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:14:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 08/18] printk: nbcon: Stop threads on
 shutdown/reboot
Message-ID: <ZnwGOaSLTkIB0csA@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-9-john.ogness@linutronix.de>
 <ZnBUe0ZJgjbZXlAL@pathway.suse.cz>
 <874j9gyexd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j9gyexd.fsf@jogness.linutronix.de>

On Tue 2024-06-25 22:02:30, John Ogness wrote:
> On 2024-06-17, Petr Mladek <pmladek@suse.com> wrote:
> > This makes me wonder whether we need to stop the kthreads at all.
> 
> > How exactly does this make printk more robust during shutdown?
> 
> Because by stopping them, the printing threads are guaranteed to go
> silent before they suddenly freeze. Without the clean shutdown, I could
> create shutdown/reboot scenarios where the printing thread would stop
> mid-line. Then the atomic printing would never be able to finish because
> it is a non-panic situation and the thread was frozen while holding the
> context. The result: the user never sees the final printk messages.

I see.

> > Well, there is one differece. The kthreads could not interferre with
> > the direct flush when they are stopped.
> >
> > But we have the same problem also with suspend/resume. And we do not
> > stop the kthreads in this case.
> 
> Suspend/resume is something different. Suspend needs to stop _all_
> printing. I do not think it makes sense to shutdown threads for
> this. The consoles becoming temporarily !usable() is enough.

Just to be sure that we are on the same page. I made a closer
look at the suspend code. I see 4 important milestones:

  1. suspend_console();

     The consoles are intentionally stopped after this point.
     It allows to suspend the related hardware, for example,
     the serial port.


  2. pm_sleep_disable_secondary_cpus();

     Other CPUs are stopped at this point. The kthread might still
     be theoretically scheduled.


  3. local_irq_disable();

     IRQs get disabled. Neither the hardware nor the kthread could
     work after this point.


  4. system_state = SYSTEM_SUSPEND;

     The global value is set. vprintk_emit() starts calling
     nbcon_atomic_flush_pending().


From some reasons, I thought that ordering was different and
the "system_state" was set much earlier. This is why I thought
that it would make sense to "stop" the kthreads.

But it seems that, in reality, the nbcon_atomic_flush_pending() in
vprintk_emit() would never do anything during suspend. The consoles
are already suspended (unusable) when the system_state gets set
to SYSTEM_SUSPEND.

It means that we do not need to synchronize the printk kthreads with
vprintk_emit() for suspend. The only important thing is
the pr_flush() in suspend_console().


> For shutdown, the consoles are usable() the entire time. I just want the
> threads to get out of the way before they freeze so that the user can
> see all the messages on shutdown/reboot.

I see what you mean now. The consoles are not suspended => they are
usable all the time.


> > Maybe, we should just add a check of
> >
> >        system_state > SYSTEM_RUNNING
> >
> > also into the nbcon_kthread_func(). Maybe, the kthread should not try
> > to flush the messages when they are flushed directly by
> > vprintk_emit().
> 
> It gets racy when we start relying on the contexts noticing some
> variables. By racy, I mean there are scenarios where there are unprinted
> records and no context is printing. I think it is easiest when the
> following steps occur within a notifier:
> 
> 1. notifier sets a flag to allow atomic printing from vprintk_emit()
> 
> 2. notifier stops all threads (with the kthread_should_stop() moved
>    inside the printing loop of nbcon_kthread_func())
> 
> 3. notifier performs nbcon_atomic_flush_pending()
> 
> This guarantees that no messages are lost and that all get flushed.

Makes sense.

Best Regards,
Petr

