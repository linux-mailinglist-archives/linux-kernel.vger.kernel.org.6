Return-Path: <linux-kernel+bounces-446429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FC69F243A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921A81885839
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316618CBE8;
	Sun, 15 Dec 2024 13:46:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FB14EC60
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270401; cv=none; b=OYjMzcZwrBNYr5Bs/n+XDIvmPgy40VW9KodcRYoZCVjtNkEixIVn4EBc/M/iNq/VHvChQxogbWA2ubvljUTmGLDz5zqA97rqwT4X8cMwF5nOl/htOnyEpDDXCkzeTlC/m7ks7AFKXalI7liJ9rAOiVm3oU2hlZwddIRm7CLIx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270401; c=relaxed/simple;
	bh=U48MPo4OhHdpetNR6ZHefkbUxKP9D5WkCxuv+dwmadQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyqdQGK7v3/0h/iPyDGoHUdQtymwzk3EryMYp26CFb4NMtqv3utk8NycKjojfoOA3elrVjKutPREygjur8bKWJRiqFrqYq4RPxmLV/m2i5KNnlyvNZh8lexSQjtPjbTvp0TQLO5njcmaEKLraiadIzxzkdD3p4aNV94VCgpeGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7090CC4CECE;
	Sun, 15 Dec 2024 13:46:39 +0000 (UTC)
Date: Sun, 15 Dec 2024 08:47:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215084709.42ab04c3@gandalf.local.home>
In-Reply-To: <69db591d-08b0-47e7-a8cc-bdaf3e9d4678@efficios.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
	<20241214220403.03a8f5d0@gandalf.local.home>
	<20241214221212.38cc22c3@gandalf.local.home>
	<CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
	<CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
	<20241214233855.46ad80e0@gandalf.local.home>
	<CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
	<20241215050517.050e9d83@gandalf.local.home>
	<69db591d-08b0-47e7-a8cc-bdaf3e9d4678@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 07:42:35 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-12-15 05:05, Steven Rostedt wrote:
> > On Sat, 14 Dec 2024 21:19:01 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:  
> 
> [...]
> 
> >>
> >> Just disable it unconditionally.
> >>  
> > 
> > I can do that, but I'm not looking forward to seeing random crashes in the
> > trace event code again :-(
> > 
> > Honestly, I did not like this code when I wrote it, but I have no idea how
> > to stop the "%s" bug from happening before it gets out to production. This
> > worked. Do you have any suggestions for alternatives?  
> 
> IMHO, deferred execution of TP_printk() code in kernel context is
> a fundamental mistake causing all those problems. This opens the
> door to store pointers to strings (or anything else really)
> that sit in kernel modules which can be unloaded between

Module unloading will clear out the ring buffers to prevent issues.

> tracing and TP_printk() execution, or as we are seeing here
> pointers to data which can be mapped at different addresses
> across kernel reboot, into the ring buffer.
> 
> If TP_printk() don't have access to load data from random kernel
> memory in the first place, and can only read from the buffer, we
> would not be having those misuses, and there would be nothing to
> work-around as the strings/data would all be serialized into the
> ring buffer.
> 
> In LTTng we've taken the approach to only read the trace data
> at post-processing from user-space (we don't have the equivalent
> of TP_printk(), and that's on purpose).
> 
> I wonder if we could keep the ftrace trace_pipe pretty-printing
> behavior, while isolating the TP_printk() execution into a
> userspace process which would only map the ring buffer ? This way,

That would change the entire use of tracefs, especially in the embedded
world. Note, this hasn't been a major issue since the test/check logic was
put in place. It catches pretty much all issues with the delayed printing.

-- Steve


> users trying to misuse TP_printk() would get immediate feedback
> about their mistake because they cannot print the trace. We could
> print a dmesg warning about crash of a usermode helper program,
> for instance.

