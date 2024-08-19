Return-Path: <linux-kernel+bounces-291990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2159569D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8074B2842F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5216B3AB;
	Mon, 19 Aug 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIanD26u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812C15DBAB;
	Mon, 19 Aug 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068103; cv=none; b=YdeTPef1FHAnotHKiC66E0fcwzBnkNLiZ9nfObc3U1tph555yM3PtR4ok1RLKdItenBaDWl82jGVWcD7ZgGoQDwvrzadUk6e66YyFj85DK6nXHM9s/0M5dRSMoWsnN96EKBcJkh4ZToPZMk0kGC/MMRkf9a+dJRqriK/Qn0M4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068103; c=relaxed/simple;
	bh=di0tU9+wqu58rGgOr+Omj7d9W7rETeWgf/iaOGUVmHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKSiEH7GW5e498jZiq2MX/VJRO/aM1tTTe7jAj7v10mdguw7cUoF9vj2dNptwKv3mTGkLDOVczaOae+KgZbTohIsHDVAq/ItMfRARMw4A2nFdhHdDrB3bH9AxTVsN9wyKApmwwtuI7YvIlIE7qhk2yYXNYLN10r/QqzjWErFP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIanD26u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C25C32782;
	Mon, 19 Aug 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724068103;
	bh=di0tU9+wqu58rGgOr+Omj7d9W7rETeWgf/iaOGUVmHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIanD26u3zjalXAgyNxoh8mvcoQlNL+1sjaVUgNGRdO2jrdhee39iF/NKlWVeMV1m
	 DT1LGcPYM5KMiMXe2nnbjnqahgKJ89nOMlyfEm7/0nZJC429bKmM+tG0OaLFNR1Jbx
	 SKu1FlMO7fQIAWeeVwZx9KD62rBo1aqlzdvFv5umXw5+danOLLNFnd5MvNW/eTJGa9
	 t7tQqS+zO1pcM+DPgZtAIMSPMImg2lkMded86vpeUvxuUGVtAvxGEh/c8EKqPN5Bds
	 e6KsMM6WJ1gQAWW0EnF5HE680luBKBj66bkmSQZ+3WL2FGKOwlnTQoFFZKTHuALpWV
	 H/8MalhbbJJOA==
Date: Mon, 19 Aug 2024 13:48:16 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 02/10] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <ZsMxAGsYskX0o51m@example.org>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <f34a16af07be2bf33730ffa9da0c4eaa777087a1.1723807851.git.legion@kernel.org>
 <3jhsxclq2keesprq43jd7arhiteluppvscutzfdvkwcz3nr5pv@tix36bqw3b5j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3jhsxclq2keesprq43jd7arhiteluppvscutzfdvkwcz3nr5pv@tix36bqw3b5j>

On Mon, Aug 19, 2024 at 01:39:17PM +0300, Kirill A. Shutemov wrote:
> On Fri, Aug 16, 2024 at 03:43:52PM +0200, Alexey Gladkov wrote:
> > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > 
> > Instructions from kernel space are considered trusted. If the MMIO
> > instruction is from userspace it must be checked.
> > 
> > For userspace instructions, it is need to check that the INSN has not
> > changed at the time of #VE and before the execution of the instruction.
> 
> Well, we cannot really check if the instruction changed under us. We can
> only check if the parsed instruction does an MMIO operation that is
> allowed for the process.

We also check that the memory access (read/write) type matches. Yes, we
can't check the instruction itself, but we check the arguments.

> > 
> > Once the userspace instruction parsed is enforced that the address
> > points to mapped memory of current process and that address does not
> > point to private memory.
> > 
> > After parsing the userspace instruction, it is necessary to ensure that:
> > 
> > 1. the operation direction (read/write) corresponds to #VE info;
> > 2. the address still points to mapped memory of current process;
> > 3. the address does not point to private memory.
> 
> I don't see where you check 3.
> 
> I guess you can add pte_decrypted(pte) check to get_phys_addr().
> 
> But I'm not sure it is strictly needed.

(ve->gpa != cc_mkdec(phys_addr)

The ve->gpa was checked in the virt_exception_user/kernel().

> 
> > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 128 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 115 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index af0b6c1cacf7..86c22fec97fb 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/export.h>
> >  #include <linux/io.h>
> >  #include <linux/kexec.h>
> > +#include <linux/mm.h>
> >  #include <asm/coco.h>
> >  #include <asm/tdx.h>
> >  #include <asm/vmx.h>
> > @@ -405,6 +406,84 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
> >  			       EPT_WRITE, addr, val);
> >  }
> >  
> > +static inline bool is_private_gpa(u64 gpa)
> > +{
> > +	return gpa == cc_mkenc(gpa);
> > +}
> > +
> > +static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
> > +{
> > +	unsigned int level;
> > +	pgd_t *pgdp;
> > +	pte_t *ptep;
> > +
> > +	/*
> > +	 * Address validation only makes sense for a user process. The lock must
> > +	 * be obtained before validation can begin.
> > +	 */
> > +	mmap_assert_locked(current->mm);
> > +
> > +	pgdp = pgd_offset(current->mm, addr);
> > +
> > +	if (!pgd_none(*pgdp)) {
> > +		ptep = lookup_address_in_pgd(pgdp, addr, &level);
> > +		if (ptep) {
> > +			unsigned long offset;
> > +
> > +			offset = addr & ~page_level_mask(level);
> > +			*phys_addr = PFN_PHYS(pte_pfn(*ptep));
> > +			*phys_addr |= offset;
> > +
> > +			*writable = pte_write(*ptep);
> > +
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EFAULT;
> > +}
> > +
> > +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> > +		       unsigned long vaddr)
> > +{
> > +	phys_addr_t phys_addr;
> > +	bool writable = false;
> > +
> > +	/* It's not fatal. This can happen due to swap out or page migration. */
> > +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
> 
> Too long line?

All patches pass checkpatch without warnings.

> 
> > +		return -EAGAIN;
> > +
> > +	/*
> > +	 * Re-check whether #VE info matches the instruction that was decoded.
> > +	 *
> > +	 * The ve->gpa was valid at the time ve_info was received. But this code
> > +	 * executed with interrupts enabled, allowing tlb shootdown and therefore
> > +	 * munmap() to be executed in the parallel thread.
> > +	 *
> > +	 * By the time MMIO emulation is performed, ve->gpa may be already
> > +	 * unmapped from the process, the device it belongs to removed from
> > +	 * system and something else could be plugged in its place.
> > +	 */
> > +	switch (mmio) {
> > +	case INSN_MMIO_WRITE:
> > +	case INSN_MMIO_WRITE_IMM:
> > +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> > +			return -EFAULT;
> > +		break;
> > +	case INSN_MMIO_READ:
> > +	case INSN_MMIO_READ_ZERO_EXTEND:
> > +	case INSN_MMIO_READ_SIGN_EXTEND:
> > +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> > +			return -EFAULT;
> > +		break;
> > +	default:
> > +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> >  			     struct pt_regs *regs, struct ve_info *ve)
> >  {
> > @@ -489,7 +568,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	enum insn_mmio_type mmio;
> >  	struct insn insn = {};
> >  	unsigned long vaddr;
> > -	int size;
> > +	int size, ret;
> >  
> >  	/* Only in-kernel MMIO is supported */
> >  	if (WARN_ON_ONCE(user_mode(regs)))
> > @@ -505,6 +584,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
> >  		return -EINVAL;
> >  
> > +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > +
> > +	if (current->mm) {
> 
> Hm. This path will be taken for any MMIO if it is done in context of a
> process, even in-kernel only. I don't think we want it. It is useless
> overhead.

The kthread do not have a current->mm. As an example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/vfio/vfio_iommu_type1.c#n3053

Also documentation mention this as the way to check a user context:

  (which makes more sense anyway - the test is basically one of "do
  we have a user context", and is generally done by the page fault
  handler and things like that).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/mm/active_mm.rst#n80

> Use user_mode(regs) instead.

I can't use this. When nested exception happens in the handle_mmio_movs()
the regs will be not in the user mode.

I can make a flag that will be set either for user_mode or if we have a
nested exception.

> > +		if (mmap_read_lock_killable(current->mm))
> > +			return -EINTR;
> > +
> > +		ret = valid_vaddr(ve, mmio, size, vaddr);
> > +		if (ret)
> > +			goto unlock;
> > +	}
> > +
> >  	/*
> >  	 * Reject EPT violation #VEs that split pages.
> >  	 *
> > @@ -514,30 +604,39 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	 *
> >  	 * load_unaligned_zeropad() will recover using exception fixups.
> >  	 */
> > -	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > -	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
> > -		return -EFAULT;
> > +	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE) {
> > +		ret = -EFAULT;
> > +		goto unlock;
> > +	}
> >  
> >  	switch (mmio) {
> >  	case INSN_MMIO_WRITE:
> >  	case INSN_MMIO_WRITE_IMM:
> >  	case INSN_MMIO_MOVS:
> > -		return handle_mmio_write(&insn, mmio, size, regs, ve);
> > +		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
> > +		break;
> >  	case INSN_MMIO_READ:
> >  	case INSN_MMIO_READ_ZERO_EXTEND:
> >  	case INSN_MMIO_READ_SIGN_EXTEND:
> > -		return handle_mmio_read(&insn, mmio, size, regs, ve);
> > +		ret = handle_mmio_read(&insn, mmio, size, regs, ve);
> > +		break;
> >  	case INSN_MMIO_DECODE_FAILED:
> >  		/*
> >  		 * MMIO was accessed with an instruction that could not be
> >  		 * decoded or handled properly. It was likely not using io.h
> >  		 * helpers or accessed MMIO accidentally.
> >  		 */
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		break;
> >  	default:
> >  		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> >  	}
> > +unlock:
> > +	if (current->mm)
> > +		mmap_read_unlock(current->mm);
> > +
> > +	return ret;
> >  }
> >  
> >  static bool handle_in(struct pt_regs *regs, int size, int port)
> > @@ -681,11 +780,6 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> >  	}
> >  }
> >  
> > -static inline bool is_private_gpa(u64 gpa)
> > -{
> > -	return gpa == cc_mkenc(gpa);
> > -}
> > -
> >  /*
> >   * Handle the kernel #VE.
> >   *
> > @@ -723,6 +817,14 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
> >  		insn_len = virt_exception_user(regs, ve);
> >  	else
> >  		insn_len = virt_exception_kernel(regs, ve);
> > +
> > +	/*
> > +	 * A special case to return to userspace without increasing regs->ip
> > +	 * to repeat the instruction once again.
> > +	 */
> > +	if (insn_len == -EAGAIN)
> > +		return true;
> > +
> >  	if (insn_len < 0)
> >  		return false;
> >  
> > -- 
> > 2.45.2
> > 
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

-- 
Rgrds, legion


