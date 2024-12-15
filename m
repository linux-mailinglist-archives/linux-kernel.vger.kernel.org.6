Return-Path: <linux-kernel+bounces-446285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C699F222B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B51661E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950509450;
	Sun, 15 Dec 2024 04:23:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B932139D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734236586; cv=none; b=jA0FAY4SumFcnfa/yBQ6kX48MEq8o9biFWoD6U2P00dyUQRRHCn1yd1T1NIoapWenDIxRC8hrtiB8a4P4DlIxpTB4TRtIFkCqzm6MKL69EtOfn3lN2XzMgBOK+PQGf25qWO3ltus+PB21WS+mE/pVA/QlpwA3jkpbFkFxrzEPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734236586; c=relaxed/simple;
	bh=LlCgE3QyK4Jgk1aRFdhX3FdPxHmo1HeeW6xjpAkHzSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9hLOV8ilZaYgSA7pp9UiiTlMu6x5SY1xC1uWgKIW8KEYITnXwUGwHWwj/9bu+FeAapcPbPJcf79tlOepHzYf7dmSpDQ7WpSh6hk/2T2Hb3kv/WSF5c9TCvltLof01n6HUhxFPLijqZPhoxoB2Oc9sbjQCPut4ix2RVsU7BLuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8244C4CECE;
	Sun, 15 Dec 2024 04:23:04 +0000 (UTC)
Date: Sat, 14 Dec 2024 23:23:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214232333.3c49c1e3@gandalf.local.home>
In-Reply-To: <CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:00:57 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 14 Dec 2024 at 19:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > It gets set by the persistent ring buffer code, via a call to
> > ring_buffer_last_boot_delta().  
> 
> That seems entirely broken, since it basically depends on the kernel
> being the same one. Which isn't even checked for.
> 
> Not to mention that it wouldn't work for modules anyway.
> 
> This kind of random hackery needs to DIE.
> 
> Tell people to turn of KASLR for cross-boot tracing. Or just not do it.

We are using this for ChromeOS in ChromeBooks where we have to have KASLR
on. And yes, I've documented that it has to be the same kernel to work and
will not work for modules. That has been accepted by the users.

> 
> > > If "people use stale pointers for '%s' and we actually care" is a real
> > > issue, we could very possibly teach vsnprintf() about that. The code
> > > already has a "check_pointer()" thing for just NULL pointer magic
> > > printouts.  
> >
> > The check code was added because I was sick and tired of fixing bugs in
> > trace events. People would use the TRACE_EVENT() TP_printk() like a normal
> > printk with things like:
> >
> >   TP_fast_assign(
> >       __entry->ipv6 = ptr_to_ipv6;
> >   )
> >
> >   TP_printk("ipv6=%pI6", __entry->ipv6)  
> 
> I think you are confused.
> 
> You are talking about the checks in test_event_printk(). That is fine
> - that's a sanity check of the trace fmt string at trace event
> registration time.

Ah, I used the wrong example. But it is still fixing the same bug. For %pI6
it is caught at registration time. But the trace_check_vprintk() was added
at the same time test_event_printk() to handle strings. That's because
RCU's trace events (and other trace events) pointed to static strings in
kernel data, and because the string pointer is in the ring buffer, it had
to be checked at run time and not registration time.

My mistake in using the "%pI6" as an example because, as you stated, that
is fixed at registration time. But we have the same bug with strings:

   TP_fast_assign(
       __entry->str = field->name;
   )

   TP_printk("str=%s", __entry->str)  

Which is also a bug and actually a more common bug than the "%pX" ones. But
because of RCU and other trace events that point to static strings, it has to be
tested at run time.

> 
> But that's not at all the code that the new "fix" is all about.
> 
> The new "fix" is for the disgusting horror that is
> trace_check_vprintf(), which is the "I'll take the trace format
> string, and I'll print it out partly using the regular vprintf()
> machinery, but I'll partly dig into it and do horrendous things to
> it".
> 
> And *THAT* is the disgusting code, and it only deals with '%s' (and
> the odd symbol relocation case that I think is completely broken).

The symbol relocation is a special case that just hooked into this code.

> 
> And the '%s' case we could at least partly handle in lib/vsprintf.c -
> not the odd tracing special cases (that you might as well just handle
> in test_event_printk()), but the "we can check that it doesn't fault".

Again, it was added to fix the same issue that test_event_printk(), but for
strings because there's several trace events that point to static strings,
and that will be flagged as being a bug if it was done in test_event_printk().

-- Steve

