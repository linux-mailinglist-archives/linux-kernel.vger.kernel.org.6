Return-Path: <linux-kernel+bounces-219966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27F90DAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D743F282238
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D3146D49;
	Tue, 18 Jun 2024 17:43:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E59145B37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732585; cv=none; b=RzKVeSUuTk3oIUXnB1OuaN4O/O+MMBsjQOxhW6DEW8KkwYBBEjc8yTOTrhvxVFBFN6lYy3KQpC0pRXdikPd9kYswUV/hY5DQRcUeoTI1j2RrCg2bGOob7Wq4AM3RN9khbIFF2KcPc54O5nf3o10FJ7NbKVg0I9Nli5uQ7OLhIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732585; c=relaxed/simple;
	bh=opIP5KByMTY5KtWPitiz7lAXDGbh7/pP8tBi+bLM+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnK7cYdWQJH9tzlhcBTsA4tPrN2hVGpV5lIat/Wp1r5ZWB2YkPmT/IVaUtRakyH9a6+FtQjI8gqfeBk8zfy5AVJ88WzfgFDmO9NnasEI150nWg2VqgPeharMEqI/AVeLG077s1XfdbQYOuWnNe39ZhSieLAVRKuprYg3EMAWG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F409DA7;
	Tue, 18 Jun 2024 10:43:26 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B923F64C;
	Tue, 18 Jun 2024 10:43:00 -0700 (PDT)
Date: Tue, 18 Jun 2024 18:42:54 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>, rostedt@goodmis.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
References: <20240618162342.28275-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618162342.28275-1-puranjay@kernel.org>

On Tue, Jun 18, 2024 at 04:23:42PM +0000, Puranjay Mohan wrote:
> ftrace_graph_ret_addr() takes an 'idx' integer pointer that is used to
> optimize the stack unwinding process. arm64 currently passes `NULL` for
> this parameter which stops it from utilizing these optimizations.

Yep, we removed that back in commit:

  c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")

... because at the time, ftrace_graph_ret_addr() didn't use the 'idx'
argument when HAVE_FUNCTION_GRAPH_RET_ADDR_PTR was set, and I assumed
that was intentional.

AFAICT this is a fix (or preparatory patch) for commit:

  29c1c24a2707a579 ("function_graph: Fix up ftrace_graph_ret_addr())"

... which is queued up in linux-next and makes ftrace_graph_ret_addr()
use 'idx' when HAVE_FUNCTION_GRAPH_RET_ADDR_PTR is set.

Prior to that commit passing (or not passing) 'idx' has no effect
whatsoever, and after that commit not passing 'idx' is a bug.

> Further, the current code for ftrace_graph_ret_addr() will just return
> the passed in return address if it is NULL which will break this usage.
> 
> Pass a valid integer pointer to ftrace_graph_ret_addr() similar to
> x86_64's stack unwinder.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/kernel/stacktrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 6b3258860377..2729faaee4b4 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -25,6 +25,7 @@
>   *
>   * @common:      Common unwind state.
>   * @task:        The task being unwound.
> + * @graph_idx:   Used by ftrace_graph_ret_addr() for optimized stack unwinding.
>   * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
>   *               associated with the most recently encountered replacement lr
>   *               value.
> @@ -32,6 +33,7 @@
>  struct kunwind_state {
>  	struct unwind_state common;
>  	struct task_struct *task;
> +	int graph_idx;

Minor nit, but could we make that:

#ifdef CONFIG_FUNCTION_GRAPH_TRACER
	int graph_idx;
#endif
	
Regardless, this looks good to me, and I've tested it with a few
stacktrace scenarios including the example from commit:

  c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Steve, what's your plan for merging the ftrace bits, and how should we
stage this relative to that? e.g. would it make sense for this to go
through the ftrace tree along with those changes so that this doesn't
end up transiently broken during the merge window?

Catalin, Will, do you have any preference?

Mark.

>  #ifdef CONFIG_KRETPROBES
>  	struct llist_node *kr_cur;
>  #endif
> @@ -106,7 +108,7 @@ kunwind_recover_return_address(struct kunwind_state *state)
>  	if (state->task->ret_stack &&
>  	    (state->common.pc == (unsigned long)return_to_handler)) {
>  		unsigned long orig_pc;
> -		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
> +		orig_pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
>  						state->common.pc,
>  						(void *)state->common.fp);
>  		if (WARN_ON_ONCE(state->common.pc == orig_pc))
> -- 
> 2.40.1
> 

