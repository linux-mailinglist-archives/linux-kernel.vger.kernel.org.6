Return-Path: <linux-kernel+bounces-202933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F868FD32D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2210D286D43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8418F2CD;
	Wed,  5 Jun 2024 16:54:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6947345F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606450; cv=none; b=DffK0QJ1L8KO9mr1fxu4rsZDjj46LuK6h/ec47lwR37NBKGl85ypXbm4Ok3Gl3WBg8XlG7JRzaMQz6+5d7lUpH4LO5vbV82CzllOiDTxgp/yPcBu4y1y0OLWaSzVyRQxOIb8zVy3gZ7CCvtbtw50yr1ga7Lc5x9VsyNBwze1rLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606450; c=relaxed/simple;
	bh=5NmN1f2AEJh0LktXBNeCrn4tGKM2lNuoyxqsJBurtgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/2dycl6dBbat4HimVNmwQcbFzlc8YyxrmrygIZsG8NjilbQW4ziItAQqq+ORvpwrRXqSQ7GEtujiz9JMWyMAHFIqslTe1JmP5d4CbS89nInhoex9HrN8E2LytsvyjhlI0GXZJEXwaYrzzpYszOLFCFDIGvuSZX0JrFg2iX5SuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA3DC2BD11;
	Wed,  5 Jun 2024 16:54:08 +0000 (UTC)
Date: Wed, 5 Jun 2024 17:54:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, anshuman.khandual@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <ZmCYLvb_JlkCuc_u@arm.com>
References: <20240604171516.2361853-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604171516.2361853-1-yang@os.amperecomputing.com>
X-TUID: XjFmVvSYx6v7

On Tue, Jun 04, 2024 at 10:15:16AM -0700, Yang Shi wrote:
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 8c0a36f72d6f..4e0aa6738579 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -325,6 +325,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>   * "-" means "don't care"
>   */
>  __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
>  
>  __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
>  __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
> @@ -345,6 +346,7 @@ __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
>  __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
>  __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
>  __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
> +__AARCH64_INSN_FUNCS(casp,	0xBFA07C00, 0x08207C00)
>  __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
>  __AARCH64_INSN_FUNCS(signed_ldr_reg, 0X3FE0FC00, 0x38A0E800)
>  __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
> @@ -549,6 +551,21 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
>  	       aarch64_insn_is_prfm_lit(insn);
>  }
>  
> +static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
> +{
> +	return aarch64_insn_is_cas(insn) ||
> +	       aarch64_insn_is_casp(insn);
> +}
> +
> +/* Exclude unallocated atomic instructions and LD64B/LDAPR */
> +static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
> +{
> +	return (((insn & 0x3f207c00) == 0x38200000) |
> +		((insn & 0x3f208c00) == 0x38200000) |
> +		((insn & 0x7fe06c00) == 0x78202000) |
> +		((insn & 0xbf204c00) == 0x38200000));

Please use the logical || instead of the bitwise operator. You can also
remove the outer brackets.

That said, the above is pretty opaque if we want to update it in the
future. I have no idea how it was generated or whether it's correct. At
least maybe add a comment on how you got to these masks and values.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8251e2fea9c7..1ed1b061ee8f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -519,6 +519,35 @@ static bool is_write_abort(unsigned long esr)
>  	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
>  }
>  
> +static bool is_el0_atomic_instr(struct pt_regs *regs)
> +{
> +	u32 insn;
> +	__le32 insn_le;
> +	unsigned long pc = instruction_pointer(regs);
> +
> +	if (!user_mode(regs) || compat_user_mode(regs))
> +		return false;
> +
> +	pagefault_disable();
> +	if (get_user(insn_le, (__le32 __user *)pc)) {
> +		pagefault_enable();
> +		return false;
> +	}
> +	pagefault_enable();
> +
> +	insn = le32_to_cpu(insn_le);
> +
> +	if (aarch64_insn_is_class_atomic(insn)) {
> +		if (aarch64_atomic_insn_has_wr_perm(insn))
> +			return true;
> +	}

Nitpick:

	if (aarch64_insn_is_class_atomic(insn) &&
	    aarch64_atomic_insn_has_wr_perm(insn))
		return true;

(less indentation)

> @@ -557,6 +587,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		/* It was write fault */
>  		vm_flags = VM_WRITE;
>  		mm_flags |= FAULT_FLAG_WRITE;
> +	} else if (is_el0_atomic_instr(regs)) {
> +		/* Force write fault */
> +		vm_flags = VM_WRITE;
> +		mm_flags |= FAULT_FLAG_WRITE;
> +		force_write = true;
>  	} else {
>  		/* It was read fault */
>  		vm_flags = VM_READ;
> @@ -586,6 +621,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	/* vma flags don't allow write, undo force write */
> +	if (force_write && !(vma->vm_flags & VM_WRITE)) {
> +		vm_flags |= VM_READ;
> +		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
> +			vm_flags |= VM_EXEC;
> +		mm_flags &= ~FAULT_FLAG_WRITE;
> +	}

Ah, this revert to the non-write flags doesn't look great as we
basically duplicate the 'else' block in the original check. So, it
probably look better as per your earlier patch to just do the
instruction read just before the !(vma->vm_flags & flags) check,
something like:

	if ((vma->vm_flags & VM_WRITE) && is_el0_atomic_instr(regs)) {
		vm_flags = VM_WRITE;
		mm_flags |= FAULT_FLAG_WRITE;
	}

This way we also only read the instruction if the vma is writeable. I
think it's fine to do this under the vma lock since we have
pagefault_disable() for the insn read.

-- 
Catalin

