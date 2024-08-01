Return-Path: <linux-kernel+bounces-271528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5F944F82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E341F24241
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538251B1500;
	Thu,  1 Aug 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ICZheYwx"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9742049
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526862; cv=none; b=eIPzwNJb4z/Y7OqpVKhx3PaYx3qjM6st4ipX2lZ/019JT/oH5rvVXZWGFr7XhuZsy8gqYlgBfh63hFA3s28gGvfe4JmXr1ypl/PwoefrMtAMCM5zMl7ndd4fSB46nMEIXb4G4lHqKqPr/yAPfDptjpHMI0gBzhXB5bXgOUP2JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526862; c=relaxed/simple;
	bh=0Gr4HNnXRjbRKFpT8cQdwESPcl2FUM3E/GI0HEm1R3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqG6Amwb1KAzi/X8Tj3pbgmwFe0KS6kRVTAeGd5S/ZuXtdNMAUhdZiz+CIUDqV+TgEC84KZ0nPmclgWF6nIf/t83rce7K2c1URi1Vyr4ObVsgix/kStGSxf4ArfVmFqyk/clXg90Yax3hZmfv7ZwSYx+Rc26ATOdlNQh2bDdX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ICZheYwx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab76558a9so394113366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722526858; x=1723131658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm3nij88CI0Xz6g4fdFRDqb+oTawEfDf75zv631Zj4Q=;
        b=ICZheYwxMI9zitf0vmDLTQITXp1kYOYssVr67wOXJsHxakZgMv2KehoP0f+d3LmOCw
         QyrzUS+U4sF4k+KFUxOrHBdd5/fkgmiFWGpnyueXEhwTJ4MkWo/nrnHsGgI4m1z3ktVW
         +0y5S45IItIntxxCTFiHGxFws2F4ZnqCub0txWpgIHUE+S7cz1IIhG8mgfIrKnspDwow
         F6nzB9AHiIc4ZSH3qDb0VU4sxBZcP1LVPLGmanHEu9rpldGw+T6KUnKpEBBTaFTuN3BD
         2aF4Wq0PtU1e8qHPvddfEQEFT/yo/cKlY67VxmLCaZ3yVusa97pzRsVhXadcwDScnq63
         Meyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526858; x=1723131658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm3nij88CI0Xz6g4fdFRDqb+oTawEfDf75zv631Zj4Q=;
        b=vVYWQ9WgRYVosStC6oFm7RLOxpdJGxMjIkAibntxGO8E6xYP94gjiUZGqBDXzLsErM
         evPyr7vETv81HA2qX6UsKH0Sp33igYVA8qeovqMCJBnSKIlFjiYEvLPMLvPTehybV0Y/
         O/WtnkE+hPv91nbLDbQK4SOe2yIkkkBApPWhEeABy0uPS9/YI5T2rAHSFGlSXeDPSEXO
         vMvpQPkL5JsYZpM/UIxJ9BaXpKtn9xHdb+ucFRvuC0ioOl4jM0cy/ri3eDYQ5J2MngRC
         XlbqorTj6AWhnBqyZNin+IZj4RaE7doO7gh/XB5csrhvDiYd3wqhZ79WtyAEBnLIeJUP
         ETVg==
X-Forwarded-Encrypted: i=1; AJvYcCUEJjmIiYOqNNR+bSmoCqyFKtzU6DRBRKAfSsvLW8FvVaWBgFAj1p+e/xVYKaBThjdYefKvU4uyMAjcLkw4Kro+s9vD1GoJy6jFy+SM
X-Gm-Message-State: AOJu0Yx5dmDMwFg3uhGCXMkq/IimhuMXbGsN9nIBGvBjFWJe5ixs0PHN
	breDvPn7ce266E+0MkitFgIjYVjZeTYrPGXe5PGb/c+tv7iSvQsFgHYVEdUq2cN+AaifUDoK38Y
	4
X-Google-Smtp-Source: AGHT+IGqhwyvQ//yD7gmIHG3EnlwouQ3+hHLw2IJGpTyRUtNWE0k94myDgIyEcH9u+vzAY7GRtf+Iw==
X-Received: by 2002:a17:906:6a1f:b0:a77:ab9e:9202 with SMTP id a640c23a62f3a-a7dbcb903e9mr170122066b.4.1722526858015;
        Thu, 01 Aug 2024 08:40:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41961sm918697866b.131.2024.08.01.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:40:57 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:40:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: preffer_ofload param: was: Re: [PATCH printk v3 11/19] printk:
 nbcon: Rely on kthreads for normal operation
Message-ID: <Zqush2SkFQpYxJ7q@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpAJgKeB0cIlTg7@pathway.suse.cz>
 <8734noz5jv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734noz5jv.fsf@jogness.linutronix.de>

On Thu 2024-08-01 16:28:28, John Ogness wrote:
> On 2024-07-31, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ -1511,10 +1511,10 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
> >>  
> >>  	/*
> >>  	 * If flushing was successful but more records are available, this
> >> -	 * context must flush those remaining records because there is no
> >> -	 * other context that will do it.
> >> +	 * context must flush those remaining records if the printer thread
> >> +	 * is not available do it.
> >>  	 */
> >> -	printk_get_console_flush_type(&ft, false);
> >> +	printk_get_console_flush_type(&ft, true);
> >
> > Hmm, it is a bit weird that we change the value even though it does
> > not affect the behavior. The parameter @prefer_offload affects only
> > the legacy loop.
> 
> For nbcon consoles, prefer_offload is really only annotating the
> intentions. In this case, nbcon_atomic_flush_pending_con() is interested
> in knowing if kthread printer is available, thus using
> prefer_offload=true.
> 
> If the query yields ft.nbcon_atomic set, it means that the kthread
> printer is _not_ available (nbcon_atomic and nbcon_offload are
> exclusive) and it can (and must) handle its flushing responsibilities
> directly (immediately, using the atomic callbacks).
> 
> You might ask, why does it not check ft.nbcon_offload? Although that
> would tell it that the kthread is not available, it does not imply that
> atomic printing is allowed. In order to see if atomic printing is
> allowed, it would need to check ft.nbcon_atomic. And since the two are
> exclusive, really it is enough just to check ft.nbcon_atomic. If
> ft.nbcon_atomic is not set, either the kthread is available or there is
> nothing the nbcon console can do about it anyway (for example, it must
> rely on the legacy loop to handle it).

Where exactly do you need prefer offload of the legacy consoles?

Do need to "prefer offload" or "force offload" in these situations?

Note: We are talking about "legacy consoles" and "legacy approach"
which is:

   Legacy approach: "Prefer direct flush when possible"

Also note that "force_offload" is usually detected automatically via
the context: is_printk_deferred() check.

IMHO, we need to explicitely "force_offload" only in printk_deferred()
where it is passed to vprintk_emit() via LOGLEVEL_SCHED.

IMHO, we could get rid of this hack and simply do something like:

  int vprintk_deferred(const char *fmt, va_list args)
{
	preemption_disable();
	printk_deferred_enter();

	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);

	printk_deferred_exit();
	preemption_enable();
}

> I suppose it is wrong that nbcon_atomic_flush_pending_con(false) will
> set ft.nbcon_offload if the kthreads are available. I would fix that.

This will not work in vprintk_emit(). We need to use there

   nbcon_atomic_flush_pending_con(false)

because legacy consoles should be handled directly when possible
(legacy approach).

But nbcon consoles should be offloaded to the kthread when possible
(new approach).

The new approach is acceptable "only" for nbcon consoles because
they are synchronized by the nbcon context. Namely, they allow
to take over the ownership and flush the messages directly
in emergency or panic context.

In terms of approach:

  nbcon approach: "Prefer offload when possible"

=> for nbcon consoles we would need "prefer_direct" or
   "force_direct" parameter.

> > IMHO, __wake_up_klogd() is the only location where we really need
> > to know if there are any messages for the legacy loop, for example,
> > when called from printk_deferred().
> >
> > It should not be needed in other situations because it there
> > is always __pr_flush() or console_unlock() which would flush
> > the legacy consoles directly anyway.
> >
> > => I suggest to
> >
> > 1. Remove @prefer_offload parameter from printk_get_console_flush_type
> >
> > 2. Update __wake_up_klogd() to check both ft.legacy_offload and
> >    ft.legacy_direct, like:
> >
> > 	printk_get_console_flush_type(&ft);
> > 	if (!ft.legacy_offload && !ft.legacy_direct)
> > 		val &= ~PRINTK_PENDING_OUTPUT;
> >
> >
> > NOTE: I actually suggested to use in vprintk_emit():
> >
> > 	printk_get_console_flush_type(&ft, deffer_legacy);
> >
> >       But it can be done even without this parameter. Like it
> >       is done in this version of the patchset.
> 
> I understand what you are saying. But I don't like it. :-)
> 
> It would mean that functions only interested in offloading must check
> direct. And that direct and offload are no longer exclusive. IMHO this
> is a hack. The whole point of printk_get_console_flush_type() is so that
> the flusher does not need any special code to figure out what to do.

I agree.

> If the flusher is only interested in offloaded flushing capabilities, it
> should be able to query that. We could wrap things into macros to make
> it clearer, but it might get a bit ugly with the efficience (depending
> on how well compilers can optimize the macro usage):
> 
> #define is_nbcon_offload_available() ({			\
> 	struct console_flush_type ft;			\
> 	printk_get_console_flush_type(&ft, true);	\
> 	ft.nbcon_offload;				\
> })
> 
> #define is_nbcon_atomic_available() ({			\
> 	struct console_flush_type ft;			\
> 	printk_get_console_flush_type(&ft, false);	\
> 	ft.nbcon_atomic;				\
> })
> 
> And then this code looks like:
> 
> if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) &&
>     !is_nbcon_offload_available() &&
>     is_nbcon_atomic_available()) {
> 	/* flush directly using atomic callback */
> }

This is crazy. But where exactly do you need this?


> I have backported the printk_get_console_flush_type() macro to the
> atomic series for v7. I would like to keep @prefer_offload and I will
> try to add comments to clarify why the different query types are used.

Please, reconsider this.

I believe that the parameter "prefer_offload" adds more harm than good
because:

   + It is a non-sense for nbcon consoles. They always prefer offload
     except for emergency and panic. But emergency and panic is
     handled transparently by nbcon_get_default_prio().

   + It is confusing even for legacy consoles after introducing the
     kthread. There will be three types of offload:

	+ do console_lock()/unlock() in IRQ work
	+ wake kthread
	+ wake kthread in IRQ work

In fact, the meaning is rather "can_t_call_scheduler_code_a_safe_way".

Best Regards,
Petr

