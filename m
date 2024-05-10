Return-Path: <linux-kernel+bounces-175766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A68C2493
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FDE1C20954
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD816F0DA;
	Fri, 10 May 2024 12:11:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6016E894
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343094; cv=none; b=cduasNLzAQFZHvZ6cwsLMzBzT4bkR/IA/d0IF3Q9tSDu37J1/GGKpOQ3KXspuVs38s+xymeODqggtmVIFdy6lmaHhu+153Esn+DqLQeGbHlN9bixXAEsuljMkS7Go1NaUiOwTU+Oq0bdoAS7s4HuxC6vZH9fk35L+xLCiCFn9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343094; c=relaxed/simple;
	bh=2eN1chDHuxk2s8CGL9ekbuCvXjRVXTjl0Qr8rBzv0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoc9cTGwTFhnz3BT1ckW8699526zYYpnuzbVv4h1Zq2UX2POz5S8OxjTyqLsjIBEWumXWns/TFXVJW2anPGqlPcZ0rxec3pqgQJz5LlvrS+O74wKDEDLKNfG3+1MhhIbcOroXEhsEDe2puIWryyCymw28kkcziNzhuHNCDP9EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2A2C113CC;
	Fri, 10 May 2024 12:11:32 +0000 (UTC)
Date: Fri, 10 May 2024 13:11:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Message-ID: <Zj4O8q9-bliXE435@arm.com>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507223558.3039562-1-yang@os.amperecomputing.com>

On Tue, May 07, 2024 at 03:35:58PM -0700, Yang Shi wrote:
> The atomic RMW instructions, for example, ldadd, actually does load +
> add + store in one instruction, it may trigger two page faults, the
> first fault is a read fault, the second fault is a write fault.
> 
> Some applications use atomic RMW instructions to populate memory, for
> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
> at launch time) between v18 and v22.

I'd also argue that this should be optimised in openjdk. Is an LDADD
more efficient on your hardware than a plain STR? I hope it only does
one operation per page rather than per long. There's also MAP_POPULATE
that openjdk can use to pre-fault the pages with no additional fault.
This would be even more efficient than any store or atomic operation.

Not sure the reason for the architecture to report a read fault only on
atomics. Looking at the pseudocode, it checks for both but the read
permission takes priority. Also in case of a translation fault (which is
what we get on the first fault), I think the syndrome write bit is
populated as (!read && write), so 0 since 'read' is 1 for atomics.

> But the double page fault has some problems:
> 
> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>    readonly PTE for the read fault.  The write fault will trigger a
>    write-protection fault (CoW).  The CoW will allocate a new page and
>    make the PTE point to the new page, this needs TLB invalidations.  The
>    tlb invalidation and the mandatory memory barriers may incur
>    significant overhead, particularly on the machines with many cores.

I can see why the current behaviour is not ideal but I can't tell why
openjdk does it this way either.

A bigger hammer would be to implement mm_forbids_zeropage() but this may
affect some workloads that rely on sparsely populated large arrays.

> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index db1aeacd4cd9..5d5a3fbeecc0 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>   * "-" means "don't care"
>   */
>  __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)

This looks correct, it covers the LDADD and SWP instructions. However,
one concern is whether future architecture versions will add some
instructions in this space that are allowed to do a read only operation
(e.g. skip writing if the value is the same or fails some comparison).

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8251e2fea9c7..f7bceedf5ef3 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>  	unsigned long addr = untagged_addr(far);
>  	struct vm_area_struct *vma;
> +	unsigned int insn;
>  
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
> +		goto continue_fault;

I'd avoid the goto if possible. Even better, move this higher up into
the block of if/else statements building the vm_flags and mm_flags.
Factor out the checks into a different function - is_el0_atomic_instr()
or something.

> +
> +	pagefault_disable();

This prevents recursively entering do_page_fault() but it may be worth
testing it with an execute-only permission.

> +
> +	if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
> +		pagefault_enable();
> +		goto continue_fault;
> +	}
> +
> +	if (aarch64_insn_is_class_atomic(insn)) {
> +		vm_flags = VM_WRITE;
> +		mm_flags |= FAULT_FLAG_WRITE;
> +	}

The above would need to check if the fault is coming from a 64-bit user
mode, otherwise the decoding wouldn't make sense:

	if (!user_mode(regs) || compat_user_mode(regs))
		return false;

(assuming a separate function that checks the above and returns a bool;
you'd need to re-enable the page faults)

You also need to take care of endianness since the instructions are
always little-endian. We use a similar pattern in user_insn_read():

	u32 instr;
	__le32 instr_le;
	if (get_user(instr_le, (__le32 __user *)instruction_pointer(regs)))
		return false;
	instr = le32_to_cpu(instr_le);
	...

That said, I'm not keen on this kernel workaround. If openjdk decides to
improve some security and goes for PROT_EXEC-only mappings of its text
sections, the above trick will no longer work.

-- 
Catalin

