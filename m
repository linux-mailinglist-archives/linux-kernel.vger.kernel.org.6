Return-Path: <linux-kernel+bounces-449590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD49F5120
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC1189132B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891171494CF;
	Tue, 17 Dec 2024 16:33:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF84211C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453195; cv=none; b=Y+UJSMBymTOTxB/P+dQyw8+Jz937KG45YosREQvQaSbiY4x/KYcRMrsRW8F/bJP3XmrMXLWKhIcJ2CeJjqW/2NVF7eNlsdXk6hL5QNpOUxTJ14kDJDPAr6WW0BLrbrKWKrkt3EAEKADVV1J0N6BuRcQyRCI52uwHNXW5wn0E3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453195; c=relaxed/simple;
	bh=fu8Jd6MX6mUNEOcutqCnKWQXmIFDOR8HRzSPSxMI9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ri4QtL/gl3E3KdzpZqLN+mDjFnA1PGiDILHbVdNa6/rrOLEzZ1H0w2K1Yb/BpZS1mEa9u8VxLRqMgrRkZJ7XQbFgtT1CrdmRKRDpHL7ZVWBftCDANX174DNmPPSzsN5puet4ZXkSUbYtDRiluTyyBzc91TzAxSYIhL/p71SmtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24755C4CED3;
	Tue, 17 Dec 2024 16:33:14 +0000 (UTC)
Date: Tue, 17 Dec 2024 11:33:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [for-linus v2][PATCH 0/2] ftrace: Fixes for v6.13
Message-ID: <20241217113349.398c3370@gandalf.local.home>
In-Reply-To: <20241217161840.069495339@goodmis.org>
References: <20241217161840.069495339@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 11:18:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Ftrace fixes for 6.13:
> 
> - Always try to initialize the idle functions when graph tracer starts
> 
>   A bug was found that when a CPU is offline when graph tracing starts
>   and then comes online, that CPU is not traced. The fix to that was
>   to move the initialization of the idle shadow stack over to the
>   hot plug online logic, which also handle onlined CPUs. The issue was
>   that it removed the initialization of the shadow stack when graph tracing
>   starts, but the callbacks to the hot plug logic do nothing if graph
>   tracing isn't currently running. Although that fix fixed the onlining
>   of a CPU during tracing, it broke the CPUs that were already online.
> 
> - Have microblaze not try to get the "true parent" in function tracing
> 
>   If function tracing and graph tracing are both enabled at the same time
>   the parent of the functions traced by the function tracer may sometimes
>   be the graph tracing trampoline. The graph tracing hijacks the return
>   pointer of the function to trace it, but that can interfere with the
>   function tracing parent output. This was fixed by using the
>   ftrace_graph_ret_addr() function passing in the kernel stack pointer
>   using the ftrace_regs_get_stack_pointer() function. But Al Viro reported
>   that Microblaze does not implement the kernel_stack_pointer(regs)
>   helper function that ftrace_regs_get_stack_pointer() uses and fails
>   to compile when function graph tracing is enabled.
> 
>   It was first thought that this was a microblaze issue, but the real
>   cause is that this only works when an architecture implements
>   HAVE_DYNAMIC_FTRACE_WITH_ARGS, as a requirement for that config
>   is to have ftrace always pass a valid ftrace_regs to the callbacks.
>   That also means that the architecture supports ftrace_regs_get_stack_pointer()
>   Microblaze does not set HAVE_DYNAMIC_FTRACE_WITH_ARGS nor does it
>   implement ftrace_regs_get_stack_pointer() which caused it to fail to
>   build. Only implement the "true parent" logic if an architecture has
>   that config set.
> 
> Changes since v1: https://lore.kernel.org/all/20241214182138.4e7984a2@batman.local.home/
> 
> - Removed the hash-ptr fix as Linus was unhappy with the code it was
>   fixing and I have another series to address that. It didn't even
>   belong in this pull request, as this is the ftrace topic and that
>   was a tracing topic.
> 
> - Properly fix the function_get_true_parent_ip(), which wasn't a
>   microblaze issue at all, but an issue for any architecture that
>   does not support HAVE_DYNAMIC_FTRACE_WITH_ARGS.


I forgot to append the diffstat and branch where this lives:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/fixes

Head SHA1: 166438a432d76c68d3f0da60667248f3c2303d6c


Steven Rostedt (2):
      fgraph: Still initialize idle shadow stacks when starting
      ftrace: Do not find "true_parent" if HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set

----
 kernel/trace/fgraph.c          | 8 +++++++-
 kernel/trace/trace_functions.c | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

