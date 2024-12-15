Return-Path: <linux-kernel+bounces-446341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624399F2312
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEB818860D0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FA1494D8;
	Sun, 15 Dec 2024 10:04:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BA20322
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734257088; cv=none; b=trz59hYAGAjM2jwC+3VTcXD1ckLBFHfYubOO/Cw8BjuofJNKFlVGvizYN+vVDFg92DMbQ5jlcZ3iht4zfejIzT9L9Fy8ZzZM17XovxNlSxIR8YKpDdlhQwrNbq1B+GIlc0t/gpxFsQnNuE9Q5x7vhuwV43Fc2qWEPyt/jbgPKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734257088; c=relaxed/simple;
	bh=PqILX2C2DBi1a7/GnAPPm1Mi8+xwz4Wn7O4WQ7XP7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrH5ZQES08aqQYebtd/XMXDvM7H0dn/HLO8tMS05LP4dcvoxSLHAaBl3/RiCj5qncZf9nIxVDOTv8Ild5gzQ8TRWdRXpQVvpGaXCRiQ7Go1PYtDfkZl262e5p5qBeJRZDcSHtiPXkvRMGGVnsVfdVlm3Elm56CS5ftdMBA1Q4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CBBC4CECE;
	Sun, 15 Dec 2024 10:04:47 +0000 (UTC)
Date: Sun, 15 Dec 2024 05:05:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215050517.050e9d83@gandalf.local.home>
In-Reply-To: <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 21:19:01 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

I'll start by saying that I'm fine with ripping this out, but I'm going to
expect seeing bugs in trace events where people just reference strings in
the TP_printk() instead of using the assign_str() logic. I use to get
reports of this a few times a year, and have not had one since this code
was added back in 2021. That's over 3 years of this bug going away in
mainline.

> The code is literally making assumptions about how va_list arguments
> even work. It calls trace_seq_printf() and expects that to keep the
> "va_list" argument in sync as it walks the argument list.

I did my research on this before adding it. With the eventfs, I was very
open about not understanding the file system logic and asked for help,
which I received very little on. I had to go by tribal knowledge.

> 
> The code even seems to *know* how hacky and wrong it is, because it
> does a RUNTIME CHECK for this in test_can_verify(). But that really is
> just testing one random implementation. The whole approach
> fundamnetally doesn't work on some architectures at all, and on others
> it would be broken by seq_buf_vprintf() (or vsprintf) doing a
> va_copy() and using an internal version or any number of other things.
> 
> So the code IS WRONG.

As I said, I did my homework on this and knew exactly what it was doing. I
did my research on va_list and it is possible to do this if the va_list is a
reference and not a copy (as my comment states), which is what the verify
was checking.

> 
> It's wrong at a fundamental level. The thing where it modifies
> iter->fmt in place is just a detail in the bigger picture of that
> function being completely broken.

BTW, this code had only two minor bugs in it since it was created, and the
last one was on March 2022. The bug here, was simply that the temp buffer
it used could also be passed into the function. That would break any
algorithm. The logic itself was not the bug at all. One solution I was
thinking of doing was to introduce a second temp buffer to use, and not
change this code at all.

> 
> It's literally hacking together a really *bad* version of KASAN
> checking, re-implementing 'vsnprintf()' *badly* by trying to use the
> real vsnprintf() for the heavy lifting and literally hacking around
> corner cases. And when I say that the "va_list" handling is buggy, I'm
> *not* asking you to try to fix it. The va_list bug is just another
> symptom of the deeper problem in that thing.

What va_list bug? That logic didn't break. The breakage came here:

		strncpy(iter->fmt, p, i);
		iter->fmt[i] = '\0';

Where it didn't expect p to be pointing to iter->fmt! Because it expected
the fmt parameter to point to the "const char * printk_fmt" of the trace
event, and not be pointing to the iter->fmt itself. My fault for not
noticing in the call in trace_event_printf():

	trace_check_vprintf(iter, trace_event_format(iter, fmt), ap);

that trace_event_format() can return iter->fmt if the hash-ptr option is
disabled.

p was pointing into iter->fmt because iter->fmt was passed into the
function as the "fmt" parameter that p was assigned to.

The fmt parameter started with "comm=%s" and in this case iter->fmt = fmt
and p was iterating it.

When the fmt had:  "comm=%s pid=%d"

We get to i = 5 and since fmt = iter->fmt, p = fmt, that means p = iter->fmt!

The iter->fmt[i] = '\0'; Just changed p[i] to be '\0'. That was the bug. It
had nothing to do with the va_list logic.

		trace_seq_vprintf(&iter->seq, iter->fmt, ap);

Would copy the "comm=" into the seq buffer, but then the code after that
was broken, as p[i] == '\0'.

			strncpy(iter->fmt, p + i, j + 1);
			iter->fmt[j+1] = '\0';

Which just copied an empty string to iter->fmt, so when we do:

			trace_seq_printf(&iter->seq, iter->fmt, str);

It also copied an empty string into the seq buffer.

 The result was:

  "comm= pid=1234"

> 
> This is why I compared it to the tracefs situation. It has exactly the
> same pattern: fundamentally misusing core kernel infrastructure,
> hacking around it to get something that "works", but that is wrong on
> a fundamental level, and then adding more hacks on top when some new
> issue rears its ugly head.
> 
> I absolutely believe that coimmit ff54c8dc3f7a fixes some behavior.
> But I'm looking at it and going "this code is not salvageable". All
> you do is add more bandaids on top.

That commit fixes the iter->fmt being passed into the function by making
the assumption that p will iterate over the temp buffer. It has nothing to
do with the current code that hasn't seen a bug since 2022, and has stopped
constant "%s" bugs since then.

I could have replace ff54c8dc3f7a with using another temp buffer instead
and not change the logic of trace_check_vprintk() at all. Hence, the
va_list logic wasn't the bug.

> 
> Do it right. And honestly, "right" in this case is almost certainly
> "get rid of trace_check_vprintf() entirely".

I can get rid of it, but I highly expect to see the "%s" bug start showing
up within a few months again.

> 
> The fact that you basically disable the thing already with a static
> branch when 'va_list" doesn't work the way you want is a BIG sign.

It gets disabled because I know there were two implementations of va_list.
One that used a pass by reference and another that used a copy. This
wouldn't work with the copy (32bit x86 does that) but does work with pass
by reference (64 bit x86 does that). And the fact that the "%s" bug stopped
showing up after I implemented it, and I was even asked by someone about
the WARN_ON() triggering (but the bug never made it into your tree), I know
that it was the reason the bug stopped showing up.

> 
> Just disable it unconditionally.
> 

I can do that, but I'm not looking forward to seeing random crashes in the
trace event code again :-(

Honestly, I did not like this code when I wrote it, but I have no idea how
to stop the "%s" bug from happening before it gets out to production. This
worked. Do you have any suggestions for alternatives?

-- Steve

