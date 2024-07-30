Return-Path: <linux-kernel+bounces-267143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B9940D50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B5D1C240D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B5194C73;
	Tue, 30 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LTmawn1V"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3483194AF2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331471; cv=none; b=VehcamKO/GN4pHHu6kI9+0v0CWgeE7Pe3CHrNN/jA/QKSYpK6CRf6Rh2SHnJ2aKrKxgRreEAlmrqM5dscbvDnxJbuCPaABEOZFeukRYNDtp7odz06a/1wk2P6LngF5ZHEe+6LHPuUSOZQp+oMo+9FIFweNefjD7eR/EOohmM7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331471; c=relaxed/simple;
	bh=p+Rupz8ih6HoQ30POvMKQ88xsNK9ieDKWPeXE+KG2p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8IEYp/mGMkJq54gA7Hm4DWDSoGz0P5Ie9kNVid+dPBVt0ag8YfRBOymr1cjh5OF7fbyNmTj1zD4t5Kdox15XBfF6LMD3rEiH8/+r+7haVYk/gX/DRfx92KxFAQhaZPSO6w/dTYXimnqUOUmp630C2wP7vNyva8TAREAowDgtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LTmawn1V; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4858687a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722331468; x=1722936268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eB6kbl2tZQNRGFRJR3GT3kM50/k+xk/5o7y8D32eYvc=;
        b=LTmawn1VZrvx19GZKu9+C9UP+MJmGTGcW6TdPtM1bvFjaaerd/nFTugvOWVZM0HVsX
         7LKBWSCHZ3lKalJC1k1MW4IrNdB58D8tikBV4qXWMoL+RrhfzkQ6+vTqTKZhkt/iPQ8T
         V6H6R3RPbx1WeOhTI6NICt0IEu4WPdCxxodDd2/bkLLEjyuKkjvRhKPgLAznQ6eBpcFe
         BsVLwe1oPg6p5J01cvLb2DwSYFqOmUZxNXvTyAvkzePjuMZnZvD8VdR/LvKNS97irbHl
         By9oTyHDeYJBYnYPjtTXqurvZNMELhjB0G8huZuuaINB5hk2UnYRK/48dd9jzmHkoYqh
         KTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331468; x=1722936268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB6kbl2tZQNRGFRJR3GT3kM50/k+xk/5o7y8D32eYvc=;
        b=cFNLCWs6J26z9rwNh9d+fdnxONT+ws8SFPc348zfyLYJf+qxAHsitMjVsaTViRYWrI
         ZkFdmtuv/BRRym/88U8oCmBQIda60yq1yy9+oPzknhOdchwLjP/MV4m97DcQOnB1OFrB
         cjQU7DRZJ9alSOPpwj8mMB10BhXU5YcHL2Rz+QLYqIKYbH2aATyQBf8Km1iN6ZWWD+Sn
         bz0fy9dihqISO3U0dR22pluMXGeqhAECxgAeN+ey/hZc08kcKGgKsHqBosd6ttuwfFmT
         v8vHxB9Z5/heNU6vwKXh3d/MH3PfRF5gHOlA/JM6iMdxmyeyxjlM9wBYmT5/39Egbocf
         W4sw==
X-Forwarded-Encrypted: i=1; AJvYcCU86u6Qe7Vmbwhomm9ZOnFjK41nOQ5OKsa2DAlCuGFPoM1hiZFUDReT7iwdL0G2LJCcvytamIzKEjitM5H/o/0QR8tGjpL5/tJUcC7t
X-Gm-Message-State: AOJu0YwjyiaWLTH6fusKYUjYwTOongyvlkXYab8fTT1IEHUSd2ArvQ2/
	wHy2Pu6chabIL0jW2rbO459mHcDVGY18EYQxKnOqScnBeSTAazf1OKrn53Ze9gk=
X-Google-Smtp-Source: AGHT+IEhoUqt/OqWWGd+w3jOFu3peS1Nh2koRiIuVWBA1oQGDLJKafXMFMwXZEVZKA0gv0ABjcteMg==
X-Received: by 2002:a05:6402:278e:b0:59e:b95d:e744 with SMTP id 4fb4d7f45d1cf-5b021f0e042mr7862721a12.29.1722331468027;
        Tue, 30 Jul 2024 02:24:28 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b10e20dbb8sm4138434a12.49.2024.07.30.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:24:27 -0700 (PDT)
Date: Tue, 30 Jul 2024 11:24:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 03/19] printk: nbcon: Add function for printers
 to reacquire ownership
Message-ID: <ZqixOLkuo0IW2qql@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-4-john.ogness@linutronix.de>
 <ZqOVsZ1KGh3rkxE6@pathway.suse.cz>
 <87cymwfvd7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cymwfvd7.fsf@jogness.linutronix.de>

On Mon 2024-07-29 10:42:04, John Ogness wrote:
> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2024-07-22 19:25:23, John Ogness wrote:
> >> Since ownership can be lost at any time due to handover or
> >> takeover, a printing context _must_ be prepared to back out
> >> immediately and carefully. However, there are scenarios where
> >> the printing context must reacquire ownership in order to
> >> finalize or revert hardware changes.
> >> 
> >> One such example is when interrupts are disabled during
> >> printing. No other context will automagically re-enable the
> >> interrupts. For this case, the disabling context _must_
> >> reacquire nbcon ownership so that it can re-enable the
> >> interrupts.
> >
> > I am still not sure how this is going to be used. It is suspicious.
> > If the context lost the ownership than another started flushing
> > higher priority messages.
> >
> > Is it really safe to manipulate the HW at this point?
> > Won't it break the higher priority context?
> 
> Why would it break anything? It spins until it normally and safely
> acquires ownership again. The commit message provides a simple example
> of why it is necessary. With a threaded printer, this situation happens
> almost every time a warning occurs.

I see. It makes sense now.

> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -911,6 +948,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
> >>  		return false;
> >>  	}
> >>  
> >> +	if (!wctxt->outbuf) {
> >
> > This check works only when con->write_atomic() called
> > nbcon_reacquire_nobuf().
> 
> Exactly. That is what it is for.
> 
> > At least, we should clear the buffer also in nbcon_enter_unsafe() and
> > nbcon_exit_unsafe() when they realize that they do own the context.
> 
> OK.
> 
> > Even better would be to add a check whether we still own the context.
> > Something like:
> >
> > bool nbcon_can_proceed(struct nbcon_write_context *wctxt)
> > {
> > 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > 	struct nbcon_state cur;
> >
> > 	nbcon_state_read(con, &cur);
> >
> > 	return nbcon_context_can_proceed(ctxt, &cur);
> > }
> 
> nbcon_can_proceed() is meant to check ownership. And it only makes sense
> to use it within an unsafe section. Otherwise it is racy.

My idea was: "If we still own the context that we have owned it all
	      the time and con-write_atomic() succeeded."

The race is is not important. If we lose the ownership before updating
nbcon_seq then the line will get written again anyway.

> Once a reacquire has occurred, the driver is allowed to proceed. It just
> is not allowed to print (because its buffer is gone).

I see. My idea does not work because the driver is going to reacquire
the ownership. It means that nbcon_can_proceed() would return true
even when con->atomic_write() failed.

But it is not documented anywhere. And what if the driver has a bug
and does not call reacquire. Or what if the driver does not need
to restore anything.

IMHO, nbcon_emit_next_record() should check both:

	if (use_atomic)
		con->write_atomic(con, wctxt);
	else
		con->write_thread(con, wctxt);

	/* Still owns the console? */
	if (!nbcon_can_proceed(wctxt)
		return false;

	if (!wctxt->outbuf) {
		/*
		 * Ownership was lost and reacquired by the driver.
		 * Handle it as if ownership was lost.
		 */
		nbcon_context_release(ctxt);
		return false;
	}

Best Regards,
Petr

