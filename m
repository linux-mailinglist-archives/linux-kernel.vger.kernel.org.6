Return-Path: <linux-kernel+bounces-279137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F394B972
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9BF1F220B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8834145B0B;
	Thu,  8 Aug 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ITFIw3ds"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0018D63E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107800; cv=none; b=RTPeC7mWFUPWlp12ycD0NMAI1yc8DSA2mNFM3mtihao/39XwbdPJN0yT//Ki8TGMXhmoFP2nPNnXJHDoOInBYdiOKGZWz52umHRa3waM4qY9OzJl9hXaWvRQeo683TT5eu5WpgQ89Iif6t9yxCHeGzTBH0u7V2Jrw8kz5+PhLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107800; c=relaxed/simple;
	bh=LS5yC8MsSS7JkREGLQWh4WM3H03iTTG/lvsTevXlqKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwoVVDLSkBVH3AvdPoNwyz+tdJAiF7wtYTES5ij3cnopihMQoxz8nmSc3YpqfXh0XkT5cZTbtqlm86WNzqhXptrYFFRbUJkv7EV07B1vNG3Hi23Cf3xnK7zSjqOgLWGYGOU6oLCQZPm+E9GNSGYDr6FubLH78eu2jLbGzazV4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ITFIw3ds; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so897333e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723107796; x=1723712596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Xfgb6CbYkBG+g9RAQcMkwLNARHOZtDTn1E+4GyCUM=;
        b=ITFIw3dsXN7CTkljd7ydD6rivKKqZkc3oz269Vv/nqiX4Ov4R6H8DEqghXbQjekfm1
         /abV6aUXiw3wRX9fiTSmiEAiNs8e18At/aiqB5FCuHMre45NwGZsrenVnKIkUAyxzoUr
         e5EOaB5Z3D61bkji5i8d2VicomjWCsajzLH2eRPjsUvC8lDeR1azyuQzjdXzW08sffw9
         WImRG8QxhiD8INW5n7t0JSpfryWGOqDd7UfZ/WsRFjs4kx2haD6f/E2M9zQu/3vAIuB7
         ira2SQ8MeARJJedlbhIisVKNNaYE4xX6TTsrWnnIA/o9tO1wvJDOGyc4HIsqMJuhD7iG
         agwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723107796; x=1723712596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+Xfgb6CbYkBG+g9RAQcMkwLNARHOZtDTn1E+4GyCUM=;
        b=QcWPnkl2nb/obcK2vMJCPucTWhZRb2CMk0mCEGjVJwEPsS+tzMybhwu1Pc9w5v4cHz
         eo99fZrikE5BYGphFAumIzrPD5Z+e/6QZYVndM2sA8C+wsHJffKhdy9supqaa30yyUVn
         G+4lrRT4H0DflpXHu6/R6S+jtJauxoJ12QafdWhcpqQwRjWFTRSAt9IqXYwky8xx9ATo
         tDxe0Ek/x5RDie3RHz8NvmvOlgeauqVKAkcTD1T2YriZ2RlwIZ8tYqvFTPqsP2j8YFTi
         FuS5P1Ml0BuliTzn9+qT9g02/OSWvkAUdv6KfmDaBXkz5LiQDhjf9LgZuPdltWnRN+IS
         /P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8hnceVUSfcVEDOpkZDNKyr8X93EU0LAhk4AfHO8783ewih5GkZ5uv14w1S8dB/BugOW8RdTChbM2SQ+1hW+lhsSKIqjRd9f+Z6yH/
X-Gm-Message-State: AOJu0YwtLiD0AYuhfpf7ToLAT3qxAqqlqM+lLeDrk9bmdTsZrYCXRik8
	KFnpreZ0xp+cTk3CqpjvGa5yity+YjEVgfJ4TMv/jZnj/ON2xY9aWPLknhCSXsQQwJMpvd4tIZs
	A
X-Google-Smtp-Source: AGHT+IEwBHvo3+7PIWlvlbShaKapE6NJIIKG1uQdJowY3MznjiGIW19mzjkspv3qN5+XTu/TNTIU1Q==
X-Received: by 2002:a05:6512:230a:b0:530:c3e9:5bcf with SMTP id 2adb3069b0e04-530e588c483mr720036e87.60.1723107795391;
        Thu, 08 Aug 2024 02:03:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf9b02sm430297a12.6.2024.08.08.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:03:14 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:03:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 30/35] printk: Add helper for flush type logic
Message-ID: <ZrSJ0Dkno1y6BAAU@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-31-john.ogness@linutronix.de>
 <ZrNcr5-uZoQnSHii@pathway.suse.cz>
 <87zfpozal4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfpozal4.fsf@jogness.linutronix.de>

On Wed 2024-08-07 16:17:51, John Ogness wrote:
> On 2024-08-07, Petr Mladek <pmladek@suse.com> wrote:
> > I would suggest to change the semantic and set the _preferred_
> > flush method instead of an _available_ one.
> 
> I will need to evaluate this closely. I worry that the caller needs to
> understands how the helper function is choosing the preference. For
> example, at the end you make a suggestion that is broken with this
> suggested change.

I see. Well, console_flush_on_panic() is special. It is the last
resort. It actually ignores even the "what is available/allowed"
semantic.

> >> +		if (ft.nbcon_atomic) {
> >> +			stop_seq = prb_next_reserve_seq(prb);
> >> +			goto again;
> >> +		}
> >
> > BTW: I wonder how this code would look like after adding the printk
> >      threads. We should do "goto again" only when ft.nbcon_atomic
> >      is the preferred (only available) flush type for nbcon consoles.
> 
> 	if (ft.nbcon_offload) {
> 		...
> 	} else if (ft.nbcon_atomic) {
> 		...
> 	}
> 
> >      IMHO, it is another reason to change the semantic.
> 
> The caller does not need to rely on the helper "choosing" the right
> one. I understand your point that: It is easier for the caller when we
> can blindly rely on the helper to choose for us. But I worry that if we
> ever adjust the helper, we might break various call sites that blindly
> rely on the helper making a certain choice. If the helper's job is only
> to say what is possible, then I would worry less for the future when we
> may need to adjust the helper.

In the ideal world, the helper should tell the caller what has to be
done to flush pending messages on all consoles. The helper makes
the decision using the global variables where the variables define:

   + type of registered consoles
   + NBCON_PRIO
   + deferred context
   + possible or forced offload to kthreads

IMHO, it depends on how many callers are happy with the proposed
solution.

> >> +	printk_get_console_flush_type(&ft);
> >
> > It is a nice trick to call printk_get_console_flush_type() this early.
> > I allows to hack the result when processing the hacky LOGLEVEL_SCHED ;-)
> >
> >> +
> >>  	/* If called from the scheduler, we can not call up(). */
> >>  	if (level == LOGLEVEL_SCHED) {
> >>  		level = LOGLEVEL_DEFAULT;
> >>  		do_trylock_unlock = false;
> >> -		defer_legacy = true;
> >> +	} else {
> >> +		do_trylock_unlock = ft.legacy_direct;
> >>  	}
> >
> > We could hack the @ft structure directly here:
> >
> > 	if (level == LOGLEVEL_SCHED) {
> > 		level = LOGLEVEL_DEFAULT;
> > 		ft.legacy_offload |= ft.legacy_direct;
> > 		ft.legacy_direct = false;
> > 	}
> 
> The hack seems a bit complicated to me. Especially when the helper is
> choosing preferred methods. I will think about it.

The hack converts legacy_direct -> legacy_offload.

> >> +	if (!cpuhp_tasks_frozen) {
> >> +		printk_get_console_flush_type(&ft);
> >> +		if (ft.legacy_direct) {
> >> +			if (console_trylock())
> >> +				console_unlock();
> >
> > Why do we actually call only the legacy loop here?
> > IMHO, we should also do
> >
> > 	if (ft.nbcon_atomic)
> >  		nbcon_atomic_flush_pending();
> 
> Atomic consoles do not care if a CPU was online or not. I can add this,
> but I expect there is nothing for the atomic console to flush.

console_cpu_notify() has been added by the commit 034260d6779087431
("printk: fix delayed messages from CPU hotplug events"). It
is related to the check

    cpu_online(smp_processor_id()) == 0

which is still called in console_is_usable() even for nbcon consoles.

IMHO, it means that nbcon_atomic_flush_pending() might not be able
to flush the messages when called from vprintk_emit() on CPU which
is just being hot-plugged.


> And when
> threading is added, we would need the extra code to avoid atomic
> flushing:
> 
> 	if (!ft.nbcon_offload && ft.nbcon_atomic)                
> 		nbcon_atomic_flush_pending();

This extra change won't be needed when printk_get_console_flush_type(&ft)
uses the "set the preferred flush type" semantic ;-)


> >> @@ -3327,7 +3316,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
> >>  	if (mode == CONSOLE_REPLAY_ALL)
> >>  		__console_rewind_all();
> >>  
> >> -	if (!have_boot_console)
> >> +	printk_get_console_flush_type(&ft);
> >> +	if (ft.nbcon_atomic)
> >>  		nbcon_atomic_flush_pending();
> >
> > I would use "ft.legacy_direct" also below for the decision about
> > the legacy loop:
> >
> > -	if (legacy_allow_panic_sync)
> > +	if (ft.legacy_direct)
> > 		console_flush_all(false, &next_seq, &handover);
> 
> No, because it would mean the console is not flushed if the CPU is in
> the deferred state. That is why I added an extra comment in the helper
> saying that console_flush_on_panic() will _always_ flush directly.
> 
> I thought about adding that extra logic into the helper, but it really
> isn't possible. @legacy_allow_panic_sync does not matter if there are no
> nbcon consoles. So somehow the helper would need to know that CPU is in
> the deferred state, but now it is allowed to do direct printing.
> 
> So it seemed more straight forward to have console_flush_on_panic() not
> care about what is allowed (for legacy). It is going to flush directly
> no matter what.

Makes sense. console_flush_on_panic() is special. It is the last
resort. And it does things which are not safe/allowed.

> I will reconsider your suggestions about the helper and also compare the
> end result at the call sites (also with threading changes applied) to
> see what looks simpler to maintain.

Sigh, this is a kind of "bike shedding" discussion. It makes some
sense as long as it helps to find bugs and simplify the logic.
Feel free to stop it when you think that it is not longer worth
the effort.

Best Regards,
Petr

