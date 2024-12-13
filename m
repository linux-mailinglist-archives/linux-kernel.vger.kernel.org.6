Return-Path: <linux-kernel+bounces-445234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB39F131D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7043818844B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192C1E47D0;
	Fri, 13 Dec 2024 17:00:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987681E32DD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109219; cv=none; b=Cx1XmxQQ+HoTxS+KkVfS0f8YZ/G6lP1YCPpkeCL426ZYcF/Z8xsZWuVpYVdTZ0cZcBWNdF3xPA0DiEdQV4UW4m0Tc3Wl6lPAjSjnf01PwnZLJhrX6jOb2xJ/xSVsMugzZ4t+0OLi6uioUgsDGHDrx0pX0hu+tX72LBbRG2PTXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109219; c=relaxed/simple;
	bh=H0homgxCkB/WeRgrhiaaQh5NipGQqn3wiN0slculFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyAR1MJWQ5OA+JeHi1ZAKqOuzLWBQOoUsbGfL0QEmiPucXkzZcFbHbco6felUjPjUlnvqDSpuX9+oBNbooGnNQnT1i/qBc8Jqt7LKFVhBOExJUiaUWcEmQuRkrgIS/ZmZWlWyl0u7v1vraDqyxUldXkPSGxphFgrtdbXePrFz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87AC4CED0;
	Fri, 13 Dec 2024 17:00:18 +0000 (UTC)
Date: Fri, 13 Dec 2024 12:00:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [for-linus][PATCH 3/3] ftrace/microblaze: Do not find
 "true_parent" for return address
Message-ID: <20241213120043.3368c7b4@gandalf.local.home>
In-Reply-To: <eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
References: <20241213152647.904822987@goodmis.org>
	<20241213152704.448212590@goodmis.org>
	<eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 16:39:29 +0100
Michal Simek <monstr@monstr.eu> wrote:

> On 12/13/24 16:26, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When function tracing and function graph tracing are both enabled (in
> > different instances)   
> 
> What does this mean different instances? Two processes or two cores?

Trace instances:

 # mkdir /sys/kernel/tracing/instances/foo
 # echo function > /sys/kernel/tracing/instances/foo/current_tracer

 # mkdir /sys/kernel/tracing/instances/bar
 # echo function_graph > /sys/kernel/tracing/instances/bar/current_tracer

> 
> 
> the "parent" of some of the function tracing events
> > is "return_to_handler" which is the trampoline used by function graph
> > tracing. To fix this, ftrace_get_true_parent_ip() was introduced that
> > returns the "true" parent ip instead of the trampoline.
> > 
> > To do this, the ftrace_regs_get_stack_pointer() is used, which uses
> > kernel_stack_pointer(). The problem is that microblaze does not implement
> > kerenl_stack_pointer() so when function graph tracing is enabled, the
> > build fails.
> > 
> > Modify the #ifdef check to the code around ftrace_get_true_parent_ip() to
> > include !defined(CONFIG_MICROBLAZE) which will default it to just return
> > the parent ip passed in, which may still be the ip of the function garph  
> 
> here is typo.

Oops, thanks!

> 
> > trampoline.
> > 
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Al Viro <viro@ZenIV.linux.org.uk>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Link: https://lore.kernel.org/20241211153634.69c75afa@batman.local.home
> > Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >   kernel/trace/trace_functions.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index 74c353164ca1..a75d107a45f8 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
> >   	tracing_reset_online_cpus(&tr->array_buffer);
> >   }
> >   
> > -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +/* Microblaze currently doesn't implement kernel_stack_pointer() */  
> 
> Does it mean that this function should depends on ARCH_HAS_CURRENT_STACK_POINTER 
> instead of name the architecture?

Hmm, I was looking for a more generic option and didn't find one. I don't
think I looked well enough as that could be what we want. Let me check.

I'll drop this patch for now then.

> 
> 
> > +#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && !defined(CONFIG_MICROBLAZE)
> >   static __always_inline unsigned long
> >   function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
> >   {  
> 
> Thanks,
> Michal
> 

Thanks for the review,

-- Steve

