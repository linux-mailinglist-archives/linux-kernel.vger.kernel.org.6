Return-Path: <linux-kernel+bounces-445275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1619F13A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60F16A369
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D11E47CE;
	Fri, 13 Dec 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c3wfTV4n"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAA1E379B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110994; cv=none; b=XzsoroRrbhTexur0vsix5PjfuqkVzLG64wytbY/uicKyjt8JWNwFwjOqgI8lTPFMhXyN4cv2zalsdQacXDZoC2cZGpTCzMlN7WUVzzJYYvr395SF0/PAV5lTGo2FTrB6AZ/X3TOpF1Y3CM6mQkmUxF+cL3uzBpIhjQT8UGX1VSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110994; c=relaxed/simple;
	bh=oBLtTpG+t6oVy5hVRItwgKbsgUoJdCMN+QxbNrxlay0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndOPsbj0p7BMP7/GQd2MImCJz6JJ26obzRngOIdFoYFAYR3xD3qRzeaV0OBq58zH4eGGC6Z03eDlY6D485+42hwV7JcCr0g6zRjKUZDQtQ2/06LzCk24xdoo46bRBK97W4WpTPcsyQrQ6Z4whjmo6UJxjrNt3E+cpbWffmyijNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c3wfTV4n; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ji4LWgzic5EpycjGF8j1anUQNTF5cEN4uryYxseYKb4=; b=c3wfTV4n9Gwu5xm3LN+W8cJa0X
	6Yqskb9IXdBOj7JfaKi9T7KMmycwWlbIgMERGh0lyV6OKrF0qH90vz7/ixycjzlapNlrsnABqZW0d
	8OUg16kcXMgr2dAAdyXuaEti5lkasM+hAziwi/TBq6P68zFEsiqSOwwFEld9JZcwTqDYlFSUBcmEr
	/iO0YcRzTV4Z1ujx2LQr4JE2cB5yKB5dqx5Wok+KByXNviy3QL4SqOe08VHi+ZfirNBzlUjd8vxKb
	TlbIHZwg9T1gy+m/194/N3tq8S4jBxkhnH10NWGHmMC3NomBRxkMbrK9wBUFK281MzwZ81fRaQrWT
	icpslccQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tM9U3-00000007zSj-3p9c;
	Fri, 13 Dec 2024 17:29:48 +0000
Date: Fri, 13 Dec 2024 17:29:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Michal Simek <monstr@monstr.eu>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 3/3] ftrace/microblaze: Do not find
 "true_parent" for return address
Message-ID: <20241213172947.GJ3387508@ZenIV>
References: <20241213152647.904822987@goodmis.org>
 <20241213152704.448212590@goodmis.org>
 <eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7933ae-3462-49de-b76d-16ca652d714e@monstr.eu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 13, 2024 at 04:39:29PM +0100, Michal Simek wrote:

> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index 74c353164ca1..a75d107a45f8 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
> >   	tracing_reset_online_cpus(&tr->array_buffer);
> >   }
> > -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +/* Microblaze currently doesn't implement kernel_stack_pointer() */
> 
> Does it mean that this function should depends on
> ARCH_HAS_CURRENT_STACK_POINTER instead of name the architecture?

Nope.  ARCH_HAS_CURRENT_STACK_POINTER == "there's a current_stack_pointer variable"
(presumably something like register unsigned long current_stack_pointer asm("r1");
in case of microblaze).  kernel_stack_pointer() is "here's pt_regs, give me the
kernel stack pointer stored in it (assuming it _is_ stored there)".

And what ftrace code really want is "here's the structure formed by _mcount();
give me the kernel stack pointer at the time of _mcount() entry".  _IF_ that
structure is pt_regs (fairly common) and if there's kernel_stack_pointer(),
we get the default implementation of that helper in linux/ftrace_regs.h:

#define ftrace_regs_get_stack_pointer(fregs) \
        kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)

If it's not pt_regs, you are expected to define HAVE_ARCH_FTRACE_REGS, define
struct __arch_ftrace_regs to match whatever layout you are using and provide
the set of ftrace_regs_...() helpers.

From my reading of your mcount.S, the layout is, indeed, different and
r1 is not stored there at all - something like

struct __arch_ftrace_regs {
	unsigned long r2, r3, r4, r6;
	unsigned long r7, r8, r9, r10;
	unsigned long r11, r12, r13, r14;
	unsigned long r16, r17, r18, r19;
	unsigned long r20, r21, r22, r23;
	unsigned long r24, r25, r26, r27;
	unsigned long r28, r29, r30, r31;
	unsigned long r5;
}

static inline unsigned long ftrace_regs_get_stack_pointer(struct ftrace_regs *regs)
{
	return (unsigned long)regs + sizeof(struct __arch_ftrace_regs) + 4;
}

