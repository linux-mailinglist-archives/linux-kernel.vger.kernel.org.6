Return-Path: <linux-kernel+bounces-446666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2C9F27C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44E916585F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2EEEDD;
	Mon, 16 Dec 2024 01:24:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BE4A07
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734312245; cv=none; b=C+/7AaW0JWDlAIav1spBLC+LPVZONvNITo7p9Zt1OIjYai6m4TftXtHjpq3S8kKwK1YriZu2jKeiwsjH36u2l8CHNjnukrViyDNQXasKL11LPPME8NKqzTaU2aTNhIx1Eeb585G6NH5kRzVOdVUKl4L9ds3QU56Ifj/+q+Gqt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734312245; c=relaxed/simple;
	bh=vte5OkJhY5bpx5PtUsPwlRiuAq/xUf/KI7qoDqoQ7yM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9KpWeUcqRKKUBllUVYSCrzw9hS9Bf5cXIHI0QlaMSs4Pdk3r5n/QFjz/YT56BhMCn7is0QLTjYEhA5Sp7SlXcmzb8wFds13Z+zEl5fDasH1jukjMdoYXMJbYb0vaW3dNPM2Dhnk+5+toP6k+K5AdrCnNfFtj1daVxKZv4ZcGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69041C4CECE;
	Mon, 16 Dec 2024 01:24:03 +0000 (UTC)
Date: Sun, 15 Dec 2024 20:24:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215202404.06f7be8f@batman.local.home>
In-Reply-To: <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
	<CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 09:23:18 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And dammit, you must have known this code was garbage, because when I
> do a "git blame", I see your name on that test_can_verify_check()
> function.

Yes, that was added in the same commit that added the
trace_check_vprintk() code.

> 
> Basically, you are walking the va_list in invalid ways, because you
> want to use vsnprintf() in invalid ways. As part of that walk, you are
> (a) fundamentally mis-using va_list and (b) modifying the format
> string as you go along (both in the sense of actually changing the
> format string, but also switching that format pointer around).
> 
> My issue with this is that (b) was buggy, but it was a bug that came
> from a much more *fundamental* bug - the misuse of vsnprintf.   Which
> is why I'm saying "rip it out". Because your fix is fixing symptoms.
> It's not fixing the fact that you are doing things that are wrong.

I'm not disagreeing with you. I didn't like the code when I wrote it,
but I did write it because it was the only way I could stop the "%s"
bug. Last night, thinking about this, I think I have another solution
that can be added to the test_event_printk() and flag the fields that
can be printed via "%s" to make sure that they are correct *before*
processing the vsnprintf() code. That should give the same warning and
checks as the trace_check_vprintf().

I would also add a check in the vsnprintf() that uses
__get_kernel_nofault() like you suggested.

> 
> Looking up more, I also think the whole "replace "%p" with "%px" is
> broken and wrong.
> 
> Isn't every single case of '%p' in this context from a TP_printk() situation?
> 
> IOW, instead of dynamically creating a temporary buffer and adding
> that 'x' by hand, why wasn't that just a 'sed' script and done
> statically?
> 
> In fact, wouldn't *most* of the sanity checking be possible to just do
> entirely statically instead of at runtime?
> 
> Yeah, yeah, there's more than a few '%p' users, but
> 
>      git grep 'TP_printk.*%p[^A-Za-z]' | wc
> 
> shows that it's manageable. That probably misses some multi-line
> cases, but still - doing this kind of "rewrite constant string at
> runtime because we didn't do it statically" seems *wrong*.
> 
> And in this case, that wrongness was literally the cause of the bug.

I'm also OK with that. Should that be done for 6.13 or something to be
added for 6.14?

-- Steve

