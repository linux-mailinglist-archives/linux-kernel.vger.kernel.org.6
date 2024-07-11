Return-Path: <linux-kernel+bounces-249392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C592EB10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C981C20F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8516A37C;
	Thu, 11 Jul 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbPE43Bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508C12C549
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709687; cv=none; b=q34AON4EuRgwnLPcOiDNdYSyfP1t1OhxkV2I/GAstSfBYY8dQeHg+8H+c8f34R+j+GB6fpJQxbbWnDfZMQykiaxiPIoPpyIuEurvrkUvEgVSr5cwOG6Oupi0Q8ovv6b7XSjT4FmVtk00m8uy2LzC90Rvj5ZVOaNjr+/39OLLzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709687; c=relaxed/simple;
	bh=0/mI3AauqSo/TufjQdQjUo6dCLrU1WeCSj/5ySxVsSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW5FdruwG4mqgUmY3VJKYOtT9M1Y4T9o58PG4jcO61TMR0zs5fxJv/661FXYRAbGN1Ao9lH1hb6qw1HqrVnLE1p4+2lnoh1L+zfxe+wboCzkbz658r9WzzxAsGz1D42HlZ1K69C1/ijp6lqkfU35qqJSyTuHlmJQh/4KrGPi0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbPE43Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC1C116B1;
	Thu, 11 Jul 2024 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720709687;
	bh=0/mI3AauqSo/TufjQdQjUo6dCLrU1WeCSj/5ySxVsSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbPE43BmBoIbVEv+lnM0MBlVgA3oBAnb0wNCbr4rUrmOEPabS436DWqehGD5N6GJY
	 WhG6r8w+PWZitMYZrchmb+3TPUvfEOjuoV1NKJm+rENCe9rDHVthD+hAopZaZwmP3Z
	 f7PuWnhLyt7WVx4NBV55us5oX8Le3TwHtahk1cJchCMtEq9Xql5IpPR1OGKKEsl6ek
	 R9LrGPr6i4zDJLbDUpxPrFRfIQo27nXLhJHOZJXlgIWXYrV8QDPTvu6lducX1fjpar
	 QKlSlHLZxEDUQv8ioLR5Ks2e2TiX6SGGfwDT1rdQ7j+xr10TFccRxdiYQyMNkjfkDG
	 +tiKS77A4EHWw==
Date: Thu, 11 Jul 2024 22:40:33 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	antonb@tenstorrent.com
Subject: Re: [PATCH v2] riscv: Improve exception and system call latency
Message-ID: <Zo_u4eoq3-m9e3X7@xhacker>
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
 <20240607061335.2197383-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607061335.2197383-1-cyrilbur@tenstorrent.com>

On Thu, Jun 06, 2024 at 11:13:35PM -0700, Cyril Bur wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
> 
> Many CPUs implement return address branch prediction as a stack. The
> RISCV architecture refers to this as a return address stack (RAS). If
> this gets corrupted then the CPU will mispredict at least one but
> potentally many function returns.
> 
> There are two issues with the current RISCV exception code:
> 
> - We are using the alternate link stack (x5/t0) for the indirect branch
>   which makes the hardware think this is a function return. This will
>   corrupt the RAS.
> 
> - We modify the return address of handle_exception to point to
>   ret_from_exception. This will also corrupt the RAS.
> 
> Testing the null system call latency before and after the patch:
> 
> Visionfive2 (StarFive JH7110 / U74)
> baseline: 189.87 ns
> patched:  176.76 ns
> 
> Lichee pi 4a (T-Head TH1520 / C910)
> baseline: 666.58 ns
> patched:  636.90 ns
> 
> Just over 7% on the U74 and just over 4% on the C910.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>

Tested-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> v2:
>    Simplify jalr ra,t1 to jalr t1
>    Drop extra .globl from entry.S and use ra == handle_exception
> ---
>  arch/riscv/kernel/entry.S      | 17 ++++++++++-------
>  arch/riscv/kernel/stacktrace.c |  4 ++--
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..c933460ed3e9 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -88,7 +88,6 @@ SYM_CODE_START(handle_exception)
>  	call riscv_v_context_nesting_start
>  #endif
>  	move a0, sp /* pt_regs */
> -	la ra, ret_from_exception
>  
>  	/*
>  	 * MSB of cause differentiates between
> @@ -97,7 +96,8 @@ SYM_CODE_START(handle_exception)
>  	bge s4, zero, 1f
>  
>  	/* Handle interrupts */
> -	tail do_irq
> +	call do_irq
> +	j ret_from_exception
>  1:
>  	/* Handle other exceptions */
>  	slli t0, s4, RISCV_LGPTR
> @@ -105,11 +105,14 @@ SYM_CODE_START(handle_exception)
>  	la t2, excp_vect_table_end
>  	add t0, t1, t0
>  	/* Check if exception code lies within bounds */
> -	bgeu t0, t2, 1f
> -	REG_L t0, 0(t0)
> -	jr t0
> -1:
> -	tail do_trap_unknown
> +	bgeu t0, t2, 3f
> +	REG_L t1, 0(t0)
> +2:	jalr t1
> +	j ret_from_exception
> +3:
> +
> +	la t1, do_trap_unknown
> +	j 2b
>  SYM_CODE_END(handle_exception)
>  ASM_NOKPROBE(handle_exception)
>  
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 528ec7cc9a62..5eb3d135b717 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_FRAME_POINTER
>  
> -extern asmlinkage void ret_from_exception(void);
> +extern asmlinkage void handle_exception(void);
>  
>  static inline int fp_is_valid(unsigned long fp, unsigned long sp)
>  {
> @@ -70,7 +70,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			fp = frame->fp;
>  			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>  						   &frame->ra);
> -			if (pc == (unsigned long)ret_from_exception) {
> +			if (pc == (unsigned long)handle_exception) {
>  				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
>  					break;
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

