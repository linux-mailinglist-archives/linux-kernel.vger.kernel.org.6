Return-Path: <linux-kernel+bounces-225495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16828913140
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50B12837D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2C4404;
	Sat, 22 Jun 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne02Yyz4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD84184D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719018270; cv=none; b=Cmrr+FpdlQ+uoAD1IIiVUFqfFcDYP7dQfVdoJXtzphVoxzaHkoILNCqBgBhNzr1AaVOnknu2EwjDzcrPySXteBR27WtUbleh6amaJg76AcvJIe9KKdTpv0T6x6OwKo+mMGWy/S8J6JZf2rq+Ca4A0SjfnDmaw8vEbhpswH+hcmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719018270; c=relaxed/simple;
	bh=JWw48IU2jpmb4o2/RbQzk4Uqpd13GCQUiOW0AOFWF+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9QF8/ljqX85Lx0kqZ1iXH6g9kGgr74vXqJ77s2uHGeNsDIq9yVZhRXVewMqZ+IyD1xralsDvXIaOdkezZ+WnzFRXzR1YXGGxaxqkHGn3joTS+TELYkIQSSfogjgsj9y7G1UkJhH3cATpPcDtAcbGvPUeDFjJlFqcjJMS0IuJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne02Yyz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169A5C2BBFC;
	Sat, 22 Jun 2024 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719018270;
	bh=JWw48IU2jpmb4o2/RbQzk4Uqpd13GCQUiOW0AOFWF+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ne02Yyz4Z2nvz+f9l3zlP3eianjm65KKdJYkH97EmKAMwH+ULqhTC1i0fPZLc2DvF
	 moUrtKUdAB71jTwCszdMT6TGpdzxDmWv6+8QXqkvyqUUT8pjevgDpHzlqLcKBM3lE9
	 VWun6ZLcbSftlrcb6Wsc7FDEsFlBVDERrew8NgySyYowKQ1zxHbzCMNfQ/vXKneniC
	 UTHqExFGOD5LeUI7Y+Zlqb1nx9OxOgC/fFR8257qj6Z7ZmB4y5dT+6ia+oTXnsUd0e
	 6nM9GnE0OtTmxKK7Ru44I/TXL0HecKNTHJErFSUFvuUZwIvzVWaUkTv+cbfS+vUEjq
	 q/sVz20FEmjOg==
Date: Sat, 22 Jun 2024 08:50:30 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anton Blanchard <antonb@tenstorrent.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>
Subject: Re: [PATCH 1/6] riscv: Improve exception and system call latency
Message-ID: <ZnYf1pGhmETeR8xT@xhacker>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-2-jszhang@kernel.org>
 <ZnYXoSDCeQK0Lcz8@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnYXoSDCeQK0Lcz8@ghost>

On Fri, Jun 21, 2024 at 05:15:29PM -0700, Charlie Jenkins wrote:
> On Mon, Jun 17, 2024 at 01:05:48AM +0800, Jisheng Zhang wrote:
> > From: Anton Blanchard <antonb@tenstorrent.com>
> > 
> > Many CPUs implement return address branch prediction as a stack. The
> > RISCV architecture refers to this as a return address stack (RAS). If
> > this gets corrupted then the CPU will mispredict at least one but
> > potentally many function returns.
> > 
> > There are two issues with the current RISCV exception code:
> > 
> > - We are using the alternate link stack (x5/t0) for the indirect branch
> >   which makes the hardware think this is a function return. This will
> >   corrupt the RAS.
> > 
> > - We modify the return address of handle_exception to point to
> >   ret_from_exception. This will also corrupt the RAS.
> > 
> > Testing the null system call latency before and after the patch:
> > 
> > Visionfive2 (StarFive JH7110 / U74)
> > baseline: 189.87 ns
> > patched:  176.76 ns
> > 
> > Lichee pi 4a (T-Head TH1520 / C910)
> > baseline: 666.58 ns
> > patched:  636.90 ns
> > 
> > Just over 7% on the U74 and just over 4% on the C910.
> > 
> > Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> > Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
> 
> Do you need to sign this off since you're sending this Jisheng?

will do in newer version. Thanks for reminding.

I'm sending out this for reference since we touched the same
asm source code.
> 
> > ---
> >  arch/riscv/kernel/entry.S      | 17 ++++++++++-------
> >  arch/riscv/kernel/stacktrace.c |  4 ++--
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 68a24cf9481a..c933460ed3e9 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -88,7 +88,6 @@ SYM_CODE_START(handle_exception)
> >  	call riscv_v_context_nesting_start
> >  #endif
> >  	move a0, sp /* pt_regs */
> > -	la ra, ret_from_exception
> >  
> >  	/*
> >  	 * MSB of cause differentiates between
> > @@ -97,7 +96,8 @@ SYM_CODE_START(handle_exception)
> >  	bge s4, zero, 1f
> >  
> >  	/* Handle interrupts */
> > -	tail do_irq
> > +	call do_irq
> > +	j ret_from_exception
> >  1:
> >  	/* Handle other exceptions */
> >  	slli t0, s4, RISCV_LGPTR
> > @@ -105,11 +105,14 @@ SYM_CODE_START(handle_exception)
> >  	la t2, excp_vect_table_end
> >  	add t0, t1, t0
> >  	/* Check if exception code lies within bounds */
> > -	bgeu t0, t2, 1f
> > -	REG_L t0, 0(t0)
> > -	jr t0
> > -1:
> > -	tail do_trap_unknown
> > +	bgeu t0, t2, 3f
> > +	REG_L t1, 0(t0)
> > +2:	jalr t1
> > +	j ret_from_exception
> > +3:
> > +
> 
> The whitespace is odd here, but nonetheless:
> 
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> > +	la t1, do_trap_unknown
> > +	j 2b
> >  SYM_CODE_END(handle_exception)
> >  ASM_NOKPROBE(handle_exception)
> >  
> > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> > index 528ec7cc9a62..5eb3d135b717 100644
> > --- a/arch/riscv/kernel/stacktrace.c
> > +++ b/arch/riscv/kernel/stacktrace.c
> > @@ -16,7 +16,7 @@
> >  
> >  #ifdef CONFIG_FRAME_POINTER
> >  
> > -extern asmlinkage void ret_from_exception(void);
> > +extern asmlinkage void handle_exception(void);
> >  
> >  static inline int fp_is_valid(unsigned long fp, unsigned long sp)
> >  {
> > @@ -70,7 +70,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> >  			fp = frame->fp;
> >  			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
> >  						   &frame->ra);
> > -			if (pc == (unsigned long)ret_from_exception) {
> > +			if (pc == (unsigned long)handle_exception) {
> >  				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> >  					break;
> >  
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

