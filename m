Return-Path: <linux-kernel+bounces-349676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B098F9F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23781C2210D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E481CDFD0;
	Thu,  3 Oct 2024 22:35:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FF1CC159;
	Thu,  3 Oct 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994957; cv=none; b=fvAty099/d5KQ645AvC+hntO5NFrMafZoaYOolrC9j6gN2HYvEYmARJdkmuPZ6FxC5sza7MgAs7OdOJrMYFVHSq7zSXvinxBTcVm0qk626dkTXL7E8eGnQej3WbUL2z9AW2XN44c/E7NHX2a48pR8FsudF3hLw8T+M6+QBttlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994957; c=relaxed/simple;
	bh=A3QiTlDMDmaGrjySe0zYiarrzYsP2NbvFlsbMqSig7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AglkjDMlz9f8qdkEskTRabKx7UT5bc77QHspVyo4I/YD7+mzuyIFu4hEhFmckSUMzo3VwM1hFBXSfPB0VNILJVQMEJcPB5bft/Kj8nA902Q7IUY4dM58bM9IH3zrWmAY206OZxvKd4kEIt2+95hcW9RDFR9QnR+qW3vLLOfmj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E64C4CEC5;
	Thu,  3 Oct 2024 22:35:55 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:36:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 6/8] tracing/ftrace: Add might_fault check to syscall
 probes
Message-ID: <20241003183649.0290f0d1@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-7-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-7-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:36 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 0228d9ed94a3..e0d4850b0d77 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -446,6 +446,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
>  static notrace void							\
>  trace_event_raw_event_##call(void *__data, proto)			\
>  {									\
> +	might_fault();							\

I don't think we want "might_fault()" here, as this is called for every
tracepoint that is created by the TRACE_EVENT() macro. That means, there's
going to be plenty of locations this gets called at that do not allow faults.

-- Steve


>  	guard(preempt_notrace)();					\
>  	do_trace_event_raw_event_##call(__data, args);			\
>  }

