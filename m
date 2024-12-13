Return-Path: <linux-kernel+bounces-445527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D99F1754
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC6F164127
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8619146E;
	Fri, 13 Dec 2024 20:19:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148018F2FB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121180; cv=none; b=i7XDRzycT7XvyshCoLQA/gYPUBmDuEwCAV6rSQfbrqO9dzMAIJO39IzNUP+xEWNF191KCxE+7ZzdatAr6BJ8JILXlqSUu0gzAbzOYe6180tsJ8ZHnSYhl9/t6LcQmJfHvZNsluqrHfBe2iWY63OW5y0KiLywKLym2i4JpHoyFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121180; c=relaxed/simple;
	bh=w0a5QAnr+DawvGVOT19kGK8AYML+YC9VmvysdHeuvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd4X7eg+7jktLrqc2NEnKAvCXcAYVAkC5rFEiq0g4VKmVKXpA2medS7sPCXHM2Q33svtSnwdAd+btmuorgFdH941v9M3/CsSB5CSEo0OT6Opb8WFQV2lnPfZxumBZ4d7MXQX6kITYECaq+CmHLE12HEJBGLCqsp4phdLu8kXoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9983CC4CED0;
	Fri, 13 Dec 2024 20:19:38 +0000 (UTC)
Date: Fri, 13 Dec 2024 15:20:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 3/3] ftrace/microblaze: Do not find
 "true_parent" for return address
Message-ID: <20241213152004.1e74ca81@gandalf.local.home>
In-Reply-To: <20241213172947.GJ3387508@ZenIV>
References: <20241213152647.904822987@goodmis.org>
	<20241213152704.448212590@goodmis.org>
	<eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
	<20241213172947.GJ3387508@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:29:47 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Fri, Dec 13, 2024 at 04:39:29PM +0100, Michal Simek wrote:
> 
> > > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > > index 74c353164ca1..a75d107a45f8 100644
> > > --- a/kernel/trace/trace_functions.c
> > > +++ b/kernel/trace/trace_functions.c
> > > @@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
> > >   	tracing_reset_online_cpus(&tr->array_buffer);
> > >   }
> > > -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > > +/* Microblaze currently doesn't implement kernel_stack_pointer() */  
> > 
> > Does it mean that this function should depends on
> > ARCH_HAS_CURRENT_STACK_POINTER instead of name the architecture?  
> 
> Nope.  ARCH_HAS_CURRENT_STACK_POINTER == "there's a current_stack_pointer variable"
> (presumably something like register unsigned long current_stack_pointer asm("r1");
> in case of microblaze).  kernel_stack_pointer() is "here's pt_regs, give me the
> kernel stack pointer stored in it (assuming it _is_ stored there)".
> 
> And what ftrace code really want is "here's the structure formed by _mcount();
> give me the kernel stack pointer at the time of _mcount() entry".  _IF_ that
> structure is pt_regs (fairly common) and if there's kernel_stack_pointer(),
> we get the default implementation of that helper in linux/ftrace_regs.h:
> 
> #define ftrace_regs_get_stack_pointer(fregs) \
>         kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
> 
> If it's not pt_regs, you are expected to define HAVE_ARCH_FTRACE_REGS, define
> struct __arch_ftrace_regs to match whatever layout you are using and provide
> the set of ftrace_regs_...() helpers.
> 
> >From my reading of your mcount.S, the layout is, indeed, different and  
> r1 is not stored there at all - something like
> 
> struct __arch_ftrace_regs {
> 	unsigned long r2, r3, r4, r6;
> 	unsigned long r7, r8, r9, r10;
> 	unsigned long r11, r12, r13, r14;
> 	unsigned long r16, r17, r18, r19;
> 	unsigned long r20, r21, r22, r23;
> 	unsigned long r24, r25, r26, r27;
> 	unsigned long r28, r29, r30, r31;
> 	unsigned long r5;
> }
> 
> static inline unsigned long ftrace_regs_get_stack_pointer(struct ftrace_regs *regs)
> {
> 	return (unsigned long)regs + sizeof(struct __arch_ftrace_regs) + 4;
> }

OK, so this is still unique for Microblaze. I'll keep the patch, but fix
the typo in the change log.

Michal,

Any objections?

-- Steve

