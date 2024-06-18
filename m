Return-Path: <linux-kernel+bounces-219852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB090D8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0D11F26830
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C7C0B7;
	Tue, 18 Jun 2024 16:14:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF574BE0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727241; cv=none; b=T4F2g6RbkY8E5IzMTamMfh2JHix65hg19RPQqfSjUhKEI+wQUhdDkyKc6gTmnFHMI4OgR9uEq2RP5O81CLT78//LY5Vg1eFlOWS1buGnA/ncNryddFfJ2gkpItVuRbCB6yGhjnWq+Qy8QRk7CPnCmmyv5j6BGNo8GItzqfR5Obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727241; c=relaxed/simple;
	bh=WpwGvZyseMXRhSzg2BOxGHcEd9ygNbzOnGSpkLjQXu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMHAv5LMIsfkSb3tdPtMdvRBW3AXDGUp6cOjF5jjiciJlJTliuQOeriPcZPmxG/PKwa7PcZQk81J620wLcE3b2HcIi28jdaVhCZvseCfkvO/DIfTQiVtXCRbPZ7qcfT1s4kWsEs1PCl4p6CrpzhYnQYa+oneM+OMDKaBGCvIoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9321FC4AF1D;
	Tue, 18 Jun 2024 16:13:58 +0000 (UTC)
Date: Tue, 18 Jun 2024 12:13:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland
 <samuel.holland@sifive.com>, Matthew Bystrin <dev.mbstr@gmail.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com
Subject: Re: [PATCH] riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
Message-ID: <20240618121356.08f961eb@rorschach.local.home>
In-Reply-To: <20240618145820.62112-1-puranjay@kernel.org>
References: <20240618145820.62112-1-puranjay@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:58:20 +0000
Puranjay Mohan <puranjay@kernel.org> wrote:

> ftrace_graph_ret_addr() takes an `idx` integer pointer that is used to
> optimize the stack unwinding. Pass it a valid pointer to utilize the
> optimizations that might be available in the future.
> 
> The commit is making riscv's usage of ftrace_graph_ret_addr() match
> x86_64.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Not only that, the updated code for ftrace_graph_ret_addr() will just
return the passed in return address if it is NULL. Basically, it will
not work without this.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> ---
>  arch/riscv/kernel/stacktrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 528ec7cc9a62..6cb7f9ca9d82 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -32,6 +32,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			     bool (*fn)(void *, unsigned long), void *arg)
>  {
>  	unsigned long fp, sp, pc;
> +	int graph_idx = 0;
>  	int level = 0;
>  
>  	if (regs) {
> @@ -68,7 +69,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			pc = regs->ra;
>  		} else {
>  			fp = frame->fp;
> -			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
> +			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
>  						   &frame->ra);
>  			if (pc == (unsigned long)ret_from_exception) {
>  				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))


