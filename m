Return-Path: <linux-kernel+bounces-522168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB174A3C6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69807166CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C5214A64;
	Wed, 19 Feb 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8kEseN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8002147E8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988079; cv=none; b=s5yMCk+KkwloKVRbP9Ri2xd2JJWYM6nx3+BUNFR2Hp3tHj795AESlshae4WMwIAsXNrj1NVF7ZsQgikA9bIoHe7YGZa3zv7clSxOT57zl+fGAxygbXEkQHk/MLKK9oG9a1bTFBCey8PvNR58dCWQsiavajrtWCBoZCFb/PIJviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988079; c=relaxed/simple;
	bh=7HTu4R9BL8sQr+iVoK4dHnBq6JEmTe0gDPs8zhXU3iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaMDMKoUI8liqR+kaTOekn1xzaiY5v3CvGmsidSkhiIMTgWug6aYfe+R2LgsFsg/ggSAdEIOvwbwG6UUQSCZRhRQ/wmFxskyRnguFNAZA/dLyeEt2/3oRnxB9+kE6kIASao0j/vfaf76nwEM02SXwPkmwOYLOisIRgSj0pe/AWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8kEseN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2424C4CED1;
	Wed, 19 Feb 2025 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988078;
	bh=7HTu4R9BL8sQr+iVoK4dHnBq6JEmTe0gDPs8zhXU3iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8kEseN8WUSQ460LmIEyAvWb3vKxbUBk0YUmm2rLiPbSxESZMC+IJtUE9bZU6yb9M
	 ADyWTQHshLVnZtdhj1PQw6cHyOVUGlsgm+02EGhugG9WQWwEuSrjFI4ThF9Dg0xYT4
	 95ICTmJK+rn9aTczk7YlY/zd38daE+e9yKPD6bAuC46afumqw4ofehdffU7P1AeLUm
	 5eaiser3IWZ2nOF8UlEpkJMvNuZ/4+OMXYIkk4SG8UDdUx1lSPFHzJfx0M1FxZ5Qs/
	 +X7+X7uMBC7fO4Bvz4cqc8c0P0iT5n7lkKfpKv9kgqp+k9QrcwbQtjCHpl/H13THdB
	 /ZCSNeu1GJA3Q==
Date: Wed, 19 Feb 2025 10:01:15 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
Message-ID: <202502190959.C414304@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.791951626@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.791951626@infradead.org>

On Wed, Feb 19, 2025 at 05:21:12PM +0100, Peter Zijlstra wrote:
> Scott notes that non-taken branches are faster. Abuse overlapping code
> that traps instead of explicit UD2 instructions.

Some kind of commenting is needed in here to explicitly call out the
embedded EA in the "subl" instruction. There is a tiny hint of it in the
disassembly dump of fineibt_preamble_start, but it's very subtle for
someone trying to understand this fresh.

> And LEA does not modify flags and will have less dependencies.
> 
> Suggested-by: Scott Constable <scott.d.constable@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

But it works!

Reviewed-by: Kees Cook <kees@kernel.org>

> ---
>  arch/x86/kernel/alternative.c |   58 ++++++++++++++++++++++++++----------------
>  arch/x86/net/bpf_jit_comp.c   |    5 +--
>  2 files changed, 39 insertions(+), 24 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1054,9 +1054,9 @@ early_param("cfi", cfi_parse_cmdline);
>   * __cfi_\func:					__cfi_\func:
>   *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
>   *	nop					     subl   $0x12345678,%r10d   // 7
> - *	nop					     jz     1f			// 2
> - *	nop					     ud2			// 2
> - *	nop					1:   nop			// 1
> + *	nop					     jne    __cfi_\func+6	// 2
> + *	nop					     nop3			// 3
> + *	nop
>   *	nop
>   *	nop
>   *	nop
> @@ -1068,37 +1068,47 @@ early_param("cfi", cfi_parse_cmdline);
>   *
>   * caller:					caller:
>   *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
> - *	addl	$-15(%r11),%r10d	 // 4	     sub    $16,%r11		// 4
> + *	addl	$-15(%r11),%r10d	 // 4	     lea    -0x10(%r11),%r11	// 4
>   *	je	1f			 // 2	     nop4			// 4
>   *	ud2				 // 2
> - * 1:	call	__x86_indirect_thunk_r11 // 5	     call   *%r11; nop2;	// 5
> + * 1:	cs call	__x86_indirect_thunk_r11 // 6	     call   *%r11; nop3;	// 6
>   *
>   */
>  
> -asm(	".pushsection .rodata			\n"
> -	"fineibt_preamble_start:		\n"
> -	"	endbr64				\n"
> -	"	subl	$0x12345678, %r10d	\n"
> -	"	je	fineibt_preamble_end	\n"
> -	"fineibt_preamble_ud2:			\n"
> -	"	ud2				\n"
> -	"	nop				\n"
> -	"fineibt_preamble_end:			\n"
> +/*
> + * <fineibt_preamble_start>:
> + *  0:   f3 0f 1e fa             endbr64
> + *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
> + *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
> + *  d:   0f 1f 00                nopl   (%rax)
> + */
> +asm(	".pushsection .rodata				\n"
> +	"fineibt_preamble_start:			\n"
> +	"	endbr64					\n"
> +	"	subl	$0x12345678, %r10d		\n"
> +	"	jne	fineibt_preamble_start+6	\n"
> +	ASM_NOP3
> +	"fineibt_preamble_end:				\n"
>  	".popsection\n"
>  );
>  
>  extern u8 fineibt_preamble_start[];
> -extern u8 fineibt_preamble_ud2[];
>  extern u8 fineibt_preamble_end[];
>  
>  #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
> -#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
> +#define fineibt_preamble_ud   6
>  #define fineibt_preamble_hash 7
>  
> +/*
> + * <fineibt_caller_start>:
> + *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> + *  6:   4d 8d 5b f0             lea    -0x10(%r11), %r11
> + *  a:   0f 1f 40 00             nopl   0x0(%rax)
> + */
>  asm(	".pushsection .rodata			\n"
>  	"fineibt_caller_start:			\n"
>  	"	movl	$0x12345678, %r10d	\n"
> -	"	sub	$16, %r11		\n"
> +	"	lea	-0x10(%r11), %r11	\n"
>  	ASM_NOP4
>  	"fineibt_caller_end:			\n"
>  	".popsection				\n"
> @@ -1429,15 +1439,15 @@ static void poison_cfi(void *addr)
>  }
>  
>  /*
> - * regs->ip points to a UD2 instruction, return true and fill out target and
> - * type when this UD2 is from a FineIBT preamble.
> + * When regs->ip points to a 0xEA byte in the FineIBT preamble,
> + * return true and fill out target and type.
>   *
>   * We check the preamble by checking for the ENDBR instruction relative to the
> - * UD2 instruction.
> + * 0xEA instruction.
>   */
>  bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
>  {
> -	unsigned long addr = regs->ip - fineibt_preamble_ud2;
> +	unsigned long addr = regs->ip - fineibt_preamble_ud;
>  	u32 hash;
>  
>  	if (!exact_endbr((void *)addr))
> @@ -1448,6 +1458,12 @@ bool decode_fineibt_insn(struct pt_regs
>  	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
>  	*type = (u32)regs->r10 + hash;
>  
> +	/*
> +	 * Since regs->ip points to the middle of an instruction; it cannot
> +	 * continue with the normal fixup.
> +	 */
> +	regs->ip = *target;
> +
>  	return true;
>  
>  Efault:
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -417,9 +417,8 @@ static void emit_fineibt(u8 **pprog, u32
>  
>  	EMIT_ENDBR();
>  	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
> -	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
> -	EMIT2(0x0f, 0x0b);				/* ud2			*/
> -	EMIT1(0x90);					/* nop			*/
> +	EMIT2(0x75, 0xf9);				/* jne.d8 .-7		*/
> +	EMIT3(0x0f, 0x1f, 0x00);			/* nop3			*/
>  	EMIT_ENDBR_POISON();
>  
>  	*pprog = prog;
> 
> 

-- 
Kees Cook

