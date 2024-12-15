Return-Path: <linux-kernel+bounces-446290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE79F2238
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2473166468
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFAAD2FB;
	Sun, 15 Dec 2024 04:52:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C7320E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734238372; cv=none; b=aWs4vFFFOfeuJUakQCjIssy4pnrV+UBPmUsYvv3JxDOSCXXGWveNy2n52ADxOOd2/dk5YR5BZFu5si+VTnCBQUdM7RP1jSzi2WZiFkJjIgQ0qnocd+cOEc+UmVfdpSljsMQnK6y/MxnnDWSvtnwW+6eO+DUoBEK5zNKalEnHHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734238372; c=relaxed/simple;
	bh=n0yFxY2LnK9gemNPrU+hS3raWv5fBzJMreOH1zaeDeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRR7HszzQIuTtAmuN5opQucQ4YKKtP04IyG5roUuZqNwe91EUuWpp74Y2kd3eNzGqisVBwT6pP4AiZzA8zNythedg9EZkQUA1YoniX5BvvhZTYxayQyh6R1nM+n79xaSOE/DBXHpxbJOxTUw8QPAivPcYPuJXQF6SRlzXZDaM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBECFC4CED4;
	Sun, 15 Dec 2024 04:52:50 +0000 (UTC)
Date: Sat, 14 Dec 2024 23:53:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214235320.0b01d809@gandalf.local.home>
In-Reply-To: <CAHk-=wi63xXZiCUsMC_3JCuBbYNT2wSiF0JE24fKbyS=yGu8hA@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
	<20241214232333.3c49c1e3@gandalf.local.home>
	<CAHk-=wi63xXZiCUsMC_3JCuBbYNT2wSiF0JE24fKbyS=yGu8hA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:37:01 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 14 Dec 2024 at 20:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > We are using this for ChromeOS in ChromeBooks where we have to have
> > KASLR on. And yes, I've documented that it has to be the same kernel to
> > work and will not work for modules. That has been accepted by the
> > users.  
> 
> "Accepted by users" is not an argument for sh*t code quality.

That's just for the mapped code. I can easily add logic to make it fail if
the kernel signature does not match, and the deltas will be zero and the
buffer is cleared, and it will not affect anything here. I was planning on
adding that anyway.

I can also make it ignore pointers to modules.

The use case is for always on tracing and when a crash happens, you can
retrieve the events that lead up to a crash.

The text_delta was only added to this because it was causing this logic to
trigger WARN_ON()s when it tried to read the origin address of the static
strings.

> 
> This smells of all the horrors you had in tracefs. Bad, unmaintainable
> code, that caused endless "fix up bugs because the code was doing bad
> things".
> 
> Now you're doing the same thing here. Bad, unmaintainable code that
> basically misuses the vsprintf code instead of misusing the VFS code.
> 
> I can rip it out if you refuse to do so. In the kernel we don't put in
> random hacks like this that "users are ok with". Code needs to make
> sense and be maintainable, not be a pile of garbage hackery that then
> results in even more hackery because the first hackery was broken and
> caused problems.

But main code of trace_check_vprintk() that you appear to be objecting to
is the hacking into vsnprintf() that was added back in 2021 to handle the
RCU and other events that point to their strings. I'm not sure how we can
check that before hand because we don't see the pointers until the event is
being printed.

Sure, we can harden the "%s" to just print "(fault)" or something, but then
we don't know about it until it happens, and then we will likely get trace
events that have string pointers to fields that may be freed in the future
popping up in the ring buffer again. Testing will not uncover this because
the strings will exist when the developer tests the events. But when a user
sends a report back to someone and the trace has a bunch of "(fault)"s in
it where strings should be, I'm the one that's going to be told that
tracing is broken.


-- Steve

