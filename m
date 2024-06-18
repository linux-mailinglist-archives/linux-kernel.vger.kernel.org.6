Return-Path: <linux-kernel+bounces-219904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21590D9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F5C2889CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB1127E0D;
	Tue, 18 Jun 2024 16:50:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC51E877
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729434; cv=none; b=LNFsL+dKVE9/d2ChLTWF8IWODK2w37Po0PsGcwl8PxjrAQfVrwIrQDeRJDsBB9DP5Q46TClduriRge+K2FkPYDza/+mGCaWxlIfYf4onC4ucKfV7bxjdmxVShKNeufJ0UkrB//5g9hBSLfCLqYXOTXMGo6tydMupk+ilYHZwrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729434; c=relaxed/simple;
	bh=0XhGD4NSPjZsKEN/6F7C9dXux6xGZZwl0fia3/i/qns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icfGPxsO0utm3qIGzLOJMYevnbAYoO/MtGq/b4zj2PUUGd8eYs9+CghATkm0so7RspvfkNq+auNQ5fCdHy+Tue7d3GvIAkdLw4FGedvUlvDkmfINOASSyR/qF1HOoysVI41kbEapyiZy6p4g+7tnK6XNCiJuoaTftfRn8PXU4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC9C3277B;
	Tue, 18 Jun 2024 16:50:32 +0000 (UTC)
Date: Tue, 18 Jun 2024 12:50:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Madhavan T.
 Venkataraman" <madvenka@linux.microsoft.com>, Kalesh Singh
 <kaleshsingh@google.com>, chenqiwu <qiwuchen55@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240618125031.22642d40@rorschach.local.home>
In-Reply-To: <20240618162342.28275-1-puranjay@kernel.org>
References: <20240618162342.28275-1-puranjay@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 16:23:42 +0000
Puranjay Mohan <puranjay@kernel.org> wrote:

> ftrace_graph_ret_addr() takes an 'idx' integer pointer that is used to
> optimize the stack unwinding process. arm64 currently passes `NULL` for
> this parameter which stops it from utilizing these optimizations.

It no longer is an optimization (in linux-next). If it's not included,
it doesn't bother to find what the "return_to_handler" actually points to.

> 
> Further, the current code for ftrace_graph_ret_addr() will just return
> the passed in return address if it is NULL which will break this usage.
> 
> Pass a valid integer pointer to ftrace_graph_ret_addr() similar to
> x86_64's stack unwinder.

In the next merge window, this will not work. Besides the comment about
"optimization" not the real reason for this change...

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


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


