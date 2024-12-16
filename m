Return-Path: <linux-kernel+bounces-446832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA439F29B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9981164DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA31BC08B;
	Mon, 16 Dec 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF94hWv+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6281C5480
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328189; cv=none; b=VCrYkisnKptQu7O7XYLCpjFhjCYmaZsMblmC82G9LksgXAMxLnbFVx4qnX1hdfYVhhUQhJqBV4UQKz2Gyuc2dId0YZWFe/Kw1PviHwcLBEQQ1ft4aD54lOMAeEf/oqhUePp98ta35myBzFLhOmq4BmKWGKUNMzv+UvHHoD9GsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328189; c=relaxed/simple;
	bh=g/eQnsT9d+ygJl/82h3fLUtDP8Njeoli4JMtLP8reOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfNvEYzYJkOebXYZhpzJQXSzdQvTIMppXh3XEy0ORUOhra75lMwqqCIeBlPx79EAgmiU54KeT56YJG8SKzWL0t42cs/VDyWCsbp5lGEKm1YOija27YKJ19mtQJdSQaYNUi3CGyXM8YY5e7OIxz/DoicNIwcz8n40VlOdng0dRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF94hWv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3501CC4CED0;
	Mon, 16 Dec 2024 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734328188;
	bh=g/eQnsT9d+ygJl/82h3fLUtDP8Njeoli4JMtLP8reOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF94hWv+qjQgdzWrg7LqPH+9O3h2VbLE4gwcWpxEBiwW1tlztsiDpea8CymcviOp6
	 g5Rrt4RkaQCP0rJgqMzS2OgTV6sXL2HJoPP7m7+At7smMo2sfH+NBoNlVpd5GCcRC7
	 QuxkJgbvRqq7RLcNqivHMyaqyW45pg5Bb23aTiAlH90S9wK0Hz2JWSMgiKMuEtFAYa
	 y7k1hhOyhgSvq2zGgGqtAsYxCir9ZWPAW5G1Q/4BTbuOqKsbGuf5JoZoqyNr/VAt6/
	 rEebGMilh/9uPCFWDtfokAhhSIFG5OS0IaAyZ3b+03x7vPtnQD3cuTwhemts3KXHTL
	 BnbgTsFFp7L0Q==
Date: Sun, 15 Dec 2024 22:49:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel()
 instead of the original
Message-ID: <20241216054942.GA25019@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-8-dwmw2@infradead.org>
 <20241214230818.GA677337@ax162>
 <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>

On Sun, Dec 15, 2024 at 10:09:57AM +0000, David Woodhouse wrote:
> On Sat, 2024-12-14 at 16:08 -0700, Nathan Chancellor wrote:
> > 
> > I guess this seems somewhat unavoidable because control_page is just a
> > 'void *', perhaps machine_kexec() should just be marked as __nocfi? This
> > diff resolves that issue for me.
> 
> The patch below seems to work too. I already wanted to deal with the

Can confirm, thanks for the quick fix. With your fix for the first issue
I reported, the fix I sent for LTO, and this patch below, I can kexec on
a CFI and LTO enabled kernel without any issues.

> case where relocate_kernel isn't at the start of the page, so it forces
> me to do that.
> 
> For some reason it also started complaining
> vmlinux.o: warning: objtool: relocate_kernel+0x6a: return with modified stack frame
> ... which is easy to fix just by turning it into a jmp *%rsi; I have no
> idea why it was done with a ret like that in the first place.
> 
> I don't know why it puts 16 bytes of NOPs between __reloc_start and
> __cfi_relocate_kernel (in addition to the 16 before relocate_kernel
> itself), and space is *fairly* tight in the control page, but it's
> tolerable.

I think this is something to do with FineIBT IIRC? PeterZ might have
more details.

> To make the CFI check actually give useful output if it triggers, I'm
> tempted to do the IDT/GDT invalidation relocate_kernel itself, instead
> of before the call.
> 
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index ccb297765e08..e6befd11fee4 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -6,6 +6,7 @@
>  
>  #include <linux/linkage.h>
>  #include <linux/stringify.h>
> +#include <linux/cfi_types.h>
>  #include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
> @@ -61,7 +62,10 @@ SYM_DATA_END(kexec_debug_idt)
>  
>  	.section .text.relocate_kernel,"ax";
>  	.code64
> -SYM_CODE_START_NOALIGN(relocate_kernel)
> +__reloc_start:
> +	ANNOTATE_NOENDBR
> +
> +SYM_TYPED_FUNC_START(relocate_kernel)
>  	UNWIND_HINT_END_OF_STACK
>  	ANNOTATE_NOENDBR
>  	/*
> @@ -115,10 +119,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	lea	PAGE_SIZE(%rsi), %rsp
>  
>  	/* jump to identity mapped page */
> -	addq	$(identity_mapped - relocate_kernel), %rsi
> -	pushq	%rsi
> -	ANNOTATE_UNRET_SAFE
> -	ret
> +	addq	$(identity_mapped - __reloc_start), %rsi
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rsi
>  	int3
>  SYM_CODE_END(relocate_kernel)
>  
> @@ -263,7 +266,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  
>  	/* get the re-entry point of the peer system */
>  	popq	%rbp
> -	leaq	relocate_kernel(%rip), %r8
> +	leaq	__reloc_start(%rip), %r8
>  	movq	kexec_pa_swap_page(%rip), %r10
>  	movq	pa_backup_pages_map(%rip), %rdi
>  	movq	kexec_pa_table_page(%rip), %rax
> @@ -272,7 +275,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	movq	$1, %r11	/* Ensure preserve_context flag is set */
>  	call	swap_pages
>  	movq	kexec_va_control_page(%rip), %rax
> -	addq	$(virtual_mapped - relocate_kernel), %rax
> +	addq	$(virtual_mapped - __reloc_start), %rax
>  	pushq	%rax
>  	ANNOTATE_UNRET_SAFE
>  	ret
> 



