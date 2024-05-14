Return-Path: <linux-kernel+bounces-178565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB88C504C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BDEB20D84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C40213B2B3;
	Tue, 14 May 2024 10:39:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80257CBC
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683166; cv=none; b=txf17jWCJs7ZG1/NzX2NL39tXqP33MJoCiUcS5ADC6Kw3KzGc169Y78RR89B3YvukgDhp6yAV8aD/CyqptKYGr4iMS4iw9oWDfpW25psYRaGeSB1LGRg+Mdt85n5U9xCLIziQ+culdMP9CxWTSBFROmnBR4FHwDBQaob5sVQh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683166; c=relaxed/simple;
	bh=txS2G0u54enaXo4z12t/FbcJbf5DOqfdEI0CmKzi+5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br2OyZ5nIpkqyEBGe931tsAWLZ9v3806LYXpvZnj1crO4F6tYgyCLuJkEKM21UGlsNr7Rq8WotwW9nkxhwhXUa7o0nQlggrI4vQ5BWQrOdVM+ei1HjCvKTR8PHhbNlUENUlUTkVowOnOfqDq8TND26o8JeVAWZSKsx7EYUCiUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D6C32781;
	Tue, 14 May 2024 10:39:24 +0000 (UTC)
Date: Tue, 14 May 2024 11:39:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Message-ID: <ZkM_WXxEQo51mrK5@arm.com>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>

On Fri, May 10, 2024 at 10:13:02AM -0700, Yang Shi wrote:
> On 5/10/24 5:11 AM, Catalin Marinas wrote:
> > On Tue, May 07, 2024 at 03:35:58PM -0700, Yang Shi wrote:
> > > The atomic RMW instructions, for example, ldadd, actually does load +
> > > add + store in one instruction, it may trigger two page faults, the
> > > first fault is a read fault, the second fault is a write fault.
> > > 
> > > Some applications use atomic RMW instructions to populate memory, for
> > > example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
> > > at launch time) between v18 and v22.
> > I'd also argue that this should be optimised in openjdk. Is an LDADD
> > more efficient on your hardware than a plain STR? I hope it only does
> > one operation per page rather than per long. There's also MAP_POPULATE
> > that openjdk can use to pre-fault the pages with no additional fault.
> > This would be even more efficient than any store or atomic operation.
> 
> It is not about whether atomic is more efficient than plain store on our
> hardware or not. It is arch-independent solution used by openjdk.

It may be arch independent but it's not a great choice. If you run this
on pre-LSE atomics hardware (ARMv8.0), this operation would involve
LDXR+STXR and there's no way for the kernel to "upgrade" it to a write
operation on the first LDXR fault.

It would be good to understand why openjdk is doing this instead of a
plain write. Is it because it may be racing with some other threads
already using the heap? That would be a valid pattern.

> > Not sure the reason for the architecture to report a read fault only on
> > atomics. Looking at the pseudocode, it checks for both but the read
> > permission takes priority. Also in case of a translation fault (which is
> > what we get on the first fault), I think the syndrome write bit is
> > populated as (!read && write), so 0 since 'read' is 1 for atomics.
> 
> Yeah, I'm confused too. Triggering write fault in the first place should be
> fine, right? Can we update the spec?

As you noticed, even if we change the spec, we still have the old
hardware. Also, changing the spec would probably need to come with a new
CPUID field since that's software visible. I'll raise it with the
architects, maybe in the future it will allow us to skip the instruction
read.

> > > But the double page fault has some problems:
> > > 
> > > 1. Noticeable TLB overhead.  The kernel actually installs zero page with
> > >     readonly PTE for the read fault.  The write fault will trigger a
> > >     write-protection fault (CoW).  The CoW will allocate a new page and
> > >     make the PTE point to the new page, this needs TLB invalidations.  The
> > >     tlb invalidation and the mandatory memory barriers may incur
> > >     significant overhead, particularly on the machines with many cores.
> > I can see why the current behaviour is not ideal but I can't tell why
> > openjdk does it this way either.
> > 
> > A bigger hammer would be to implement mm_forbids_zeropage() but this may
> > affect some workloads that rely on sparsely populated large arrays.
> 
> But we still needs to decode the insn, right? Or you mean forbid zero page
> for all read fault? IMHO, this may incur noticeable overhead for read fault
> since the fault handler has to allocate real page every time.

The current kernel mm_forbids_zeropage() is a big knob irrespective of
the instruction triggering the fault.

> > > diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> > > index db1aeacd4cd9..5d5a3fbeecc0 100644
> > > --- a/arch/arm64/include/asm/insn.h
> > > +++ b/arch/arm64/include/asm/insn.h
> > > @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
> > >    * "-" means "don't care"
> > >    */
> > >   __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
> > > +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
> > 
> > This looks correct, it covers the LDADD and SWP instructions. However,
> > one concern is whether future architecture versions will add some
> > instructions in this space that are allowed to do a read only operation
> > (e.g. skip writing if the value is the same or fails some comparison).
> 
> I think we can know the instruction by decoding it, right? Then we can
> decide whether force write fault or not by further decoding.

Your mask above covers unallocated opcodes, we don't know what else will
get in there in the future, whether we get instructions that only do
reads. We could ask for clarification from the architects but I doubt
they'd commit to allocating it only to instructions that do a write in
this space. The alternative is to check for the individual instructions
already allocated in here (after the big mask check above) but this will
increase the fault cost a bit.

There are CAS and CASP variants that also require a write permission
even if they fail the check. We should cover them as well.

> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 8251e2fea9c7..f7bceedf5ef3 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> > >   	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
> > >   	unsigned long addr = untagged_addr(far);
> > >   	struct vm_area_struct *vma;
> > > +	unsigned int insn;
> > >   	if (kprobe_page_fault(regs, esr))
> > >   		return 0;
> > > @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> > >   	if (!vma)
> > >   		goto lock_mmap;
> > > +	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
> > > +		goto continue_fault;
[...]
> > > +
> > > +	pagefault_disable();
> > 
> > This prevents recursively entering do_page_fault() but it may be worth
> > testing it with an execute-only permission.
> 
> You mean the text section permission of the test is executive only?

Yes. Not widely used though.

A point Will raised was on potential ABI changes introduced by this
patch. The ESR_EL1 reported to user remains the same as per the hardware
spec (read-only), so from a SIGSEGV we may have some slight behaviour
changes:

1. PTE invalid:

   a) vma is VM_READ && !VM_WRITE permission - SIGSEGV reported with
      ESR_EL1.WnR == 0 in sigcontext with your patch. Without this
      patch, the PTE is mapped as PTE_RDONLY first and a subsequent
      fault will report SIGSEGV with ESR_EL1.WnR == 1.

   b) vma is !VM_READ && !VM_WRITE permission - SIGSEGV reported with
      ESR_EL1.WnR == 0, so no change from current behaviour, unless we
      fix the patch for (1.a) to fake the WnR bit which would change the
      current expectations.

2. PTE valid with PTE_RDONLY - we get a normal writeable fault in
   hardware, no need to fix ESR_EL1 up.

The patch would have to address (1) above but faking the ESR_EL1.WnR bit
based on the vma flags looks a bit fragile.

Similarly, we have userfaultfd that reports the fault to user. I think
in scenario (1) the kernel will report UFFD_PAGEFAULT_FLAG_WRITE with
your patch but no UFFD_PAGEFAULT_FLAG_WP. Without this patch, there are
indeed two faults, with the second having both UFFD_PAGEFAULT_FLAG_WP
and UFFD_PAGEFAULT_FLAG_WRITE set.

-- 
Catalin

