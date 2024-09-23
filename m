Return-Path: <linux-kernel+bounces-329767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6017D9795D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848671C20DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B41C2DDD;
	Sun, 15 Sep 2024 08:51:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875F6F2E0;
	Sun, 15 Sep 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726390304; cv=none; b=gSel6HENZvVTm4N9CubFnS2qE3Ol1pz6wjx1GaoMLsKRBewmZkcq8GzrxnS+gv+3riOpyLcEqNJQdhHhj39isOiNvb4Jprp9G6G0OjT75b9osRQLxthbr05fHcRNU+Oj870Cd+oNzxWshrnAeZaxb4Tf3CNCQEgjZ34Jpqwn9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726390304; c=relaxed/simple;
	bh=cQpaluTSWmOrUFATPMqZU7Qgp3jn5WmbVZL05n8YsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azRo6+2DSanHAcYHXwbCBUqQYZhMdNssOscPpibkYwE1C5qGF1i68kBM57WmlJOWg81d21Y/gMCoxP6dWLfLT5/T451r3dKIsqDRad1rI3jSf4A+Ejh0Qf57tjcS9m4r6CgAGKpzgOjxeVCgjhJawhZYq8mtBqs1CVaVrKn6L3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAA5C4CEC3;
	Sun, 15 Sep 2024 08:51:41 +0000 (UTC)
Date: Sun, 15 Sep 2024 04:51:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 05/19] function_graph: Pass ftrace_regs to retfunc
Message-ID: <20240915045138.3a53050d@rorschach.local.home>
In-Reply-To: <172615374207.133222.13117574733580053025.stgit@devnote2>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615374207.133222.13117574733580053025.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Can I get an Acked-by from the LOONGARCH maintainers for this patch?

Thanks!

-- Steve

[ Note this is modifies the return side ]

On Fri, 13 Sep 2024 00:09:02 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Pass ftrace_regs to the fgraph_ops::retfunc(). If ftrace_regs is not
> available, it passes a NULL instead. User callback function can access
> some registers (including return address) via this ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v8:
>   - Pass ftrace_regs to retfunc, instead of adding retregfunc.
>  Changes in v6:
>   - update to use ftrace_regs_get_return_value() because of reordering
>     patches.
>  Changes in v3:
>   - Update for new multiple fgraph.
>   - Save the return address to instruction pointer in ftrace_regs.
> ---
>  include/linux/ftrace.h               |    3 ++-
>  kernel/trace/fgraph.c                |   16 +++++++++++-----
>  kernel/trace/ftrace.c                |    3 ++-
>  kernel/trace/trace.h                 |    3 ++-
>  kernel/trace/trace_functions_graph.c |    7 ++++---
>  kernel/trace/trace_irqsoff.c         |    3 ++-
>  kernel/trace/trace_sched_wakeup.c    |    3 ++-
>  kernel/trace/trace_selftest.c        |    3 ++-
>  8 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 13987cd63553..e7c41d9988e1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1069,7 +1069,8 @@ struct fgraph_ops;
>  
>  /* Type of the callback handlers for tracing function graph*/
>  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
> -				       struct fgraph_ops *); /* return */
> +				       struct fgraph_ops *,
> +				       struct ftrace_regs *); /* return */
>  typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
>  				      struct fgraph_ops *,
>  				      struct ftrace_regs *); /* entry */
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 30bebe43607d..6a3e2db16aa4 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -297,7 +297,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
>  }
>  
>  /* ftrace_graph_return set to this to tell some archs to run function graph */
> -static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
> +static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
> +		       struct ftrace_regs *fregs)
>  {
>  }
>  
> @@ -491,7 +492,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
>  }
>  
>  static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
> -				  struct fgraph_ops *gops)
> +				  struct fgraph_ops *gops,
> +				  struct ftrace_regs *fregs)
>  {
>  }
>  
> @@ -787,6 +789,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	}
>  
>  	trace.rettime = trace_clock_local();
> +	if (fregs)
> +		ftrace_regs_set_instruction_pointer(fregs, ret);
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	trace.retval = ftrace_regs_get_return_value(fregs);
>  #endif
> @@ -796,7 +801,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  #ifdef CONFIG_HAVE_STATIC_CALL
>  	if (static_branch_likely(&fgraph_do_direct)) {
>  		if (test_bit(fgraph_direct_gops->idx, &bitmap))
> -			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops);
> +			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
>  	} else
>  #endif
>  	{
> @@ -806,7 +811,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  			if (gops == &fgraph_stub)
>  				continue;
>  
> -			gops->retfunc(&trace, gops);
> +			gops->retfunc(&trace, gops, fregs);
>  		}
>  	}
>  
> @@ -956,7 +961,8 @@ void ftrace_graph_sleep_time_control(bool enable)
>   * Simply points to ftrace_stub, but with the proper protocol.
>   * Defined by the linker script in linux/vmlinux.lds.h
>   */
> -void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
> +void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
> +		       struct ftrace_regs *fregs);
>  
>  /* The callbacks that hook a function */
>  trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 775040a9f541..fd6c5a50c5e5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -840,7 +840,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
>  }
>  
>  static void profile_graph_return(struct ftrace_graph_ret *trace,
> -				 struct fgraph_ops *gops)
> +				 struct fgraph_ops *gops,
> +				 struct ftrace_regs *fregs)
>  {
>  	struct ftrace_ret_stack *ret_stack;
>  	struct ftrace_profile_stat *stat;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 28d8ad5e31e6..f4a3f75bd916 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -682,7 +682,8 @@ void trace_latency_header(struct seq_file *m);
>  void trace_default_header(struct seq_file *m);
>  void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
>  
> -void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
> +void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
> +			struct ftrace_regs *fregs);
>  int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		      struct ftrace_regs *fregs);
>  
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index b9785fc919c9..241407000109 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -240,7 +240,7 @@ void __trace_graph_return(struct trace_array *tr,
>  }
>  
>  void trace_graph_return(struct ftrace_graph_ret *trace,
> -			struct fgraph_ops *gops)
> +			struct fgraph_ops *gops, struct ftrace_regs *fregs)
>  {
>  	unsigned long *task_var = fgraph_get_task_var(gops);
>  	struct trace_array *tr = gops->private;
> @@ -270,7 +270,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
>  }
>  
>  static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
> -				      struct fgraph_ops *gops)
> +				      struct fgraph_ops *gops,
> +				      struct ftrace_regs *fregs)
>  {
>  	ftrace_graph_addr_finish(gops, trace);
>  
> @@ -283,7 +284,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
>  	    (trace->rettime - trace->calltime < tracing_thresh))
>  		return;
>  	else
> -		trace_graph_return(trace, gops);
> +		trace_graph_return(trace, gops, fregs);
>  }
>  
>  static struct fgraph_ops funcgraph_ops = {
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index ad739d76fc86..504de7a05498 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -208,7 +208,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
>  }
>  
>  static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
> -				 struct fgraph_ops *gops)
> +				 struct fgraph_ops *gops,
> +				 struct ftrace_regs *fregs)
>  {
>  	struct trace_array *tr = irqsoff_trace;
>  	struct trace_array_cpu *data;
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 23360a2700de..9ffbd9326898 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -144,7 +144,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
>  }
>  
>  static void wakeup_graph_return(struct ftrace_graph_ret *trace,
> -				struct fgraph_ops *gops)
> +				struct fgraph_ops *gops,
> +				struct ftrace_regs *fregs)
>  {
>  	struct trace_array *tr = wakeup_trace;
>  	struct trace_array_cpu *data;
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 89067f02094a..1ebd0899238f 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -807,7 +807,8 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
>  }
>  
>  static __init void store_return(struct ftrace_graph_ret *trace,
> -				struct fgraph_ops *gops)
> +				struct fgraph_ops *gops,
> +				struct ftrace_regs *fregs)
>  {
>  	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
>  	const char *type = fixture->store_type_name;


