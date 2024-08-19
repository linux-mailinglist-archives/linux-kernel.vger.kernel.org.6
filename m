Return-Path: <linux-kernel+bounces-292099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA50F956B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F12B246CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EF16BE23;
	Mon, 19 Aug 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQujDowC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE316B74C;
	Mon, 19 Aug 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071201; cv=none; b=XYxDWbvnlCtOjZJOZGCjQuxDYaTMqkd3vVv3+N4viyrz/zTvaksaqTQTXNfSjZwO4Hh2ue3oBpMVtWrGQ/ngmWf9WoONWinfi0062Ufwmx8o6BpUxiiSHaP8pT6ieJZeqefag2CokKOqqHHgQJpWQQl0OcyCGHpILrdvWZWfL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071201; c=relaxed/simple;
	bh=/fVH32vHz/WVmeS0OIKKvhxCwD0V14e7/z9dKE0uQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s39uIWPiaZCvhIXJG8lQ8y/7HKm8RsNwaUlkj67ZQiVSbiyqeyOdu41Gx0/zcN0KmFCYa5ATxVF3OoWoa2sh38VhizNbSw4EEYjdGf2F3UZfug1oUVKuP1PrwMj5l8u5Y7bEnohp4SkV2GtRimT0uTpUYnaodERqowJwTGGjecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQujDowC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE7C4AF09;
	Mon, 19 Aug 2024 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724071201;
	bh=/fVH32vHz/WVmeS0OIKKvhxCwD0V14e7/z9dKE0uQN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQujDowCPw54cF/4PRxg/MOC4XBL5DAeZglRxHU8KpfYxP0J0U3C80OLp8we+9FBN
	 Gkt9dQjqcbCNWoUxTEUrr4hzgu6mkSryh+1SlDKEA62ABf+jf+n8nd8PLBZtHJqZ9N
	 nGc+rNrEvnuG9tMegHOpHqRDk7hLd0sO3EWJdQEOWexn7YuDHESWaNyokrQn0wIpMX
	 hLcu/JukHKTLg6FRe0fwjXTszpugFwWS4+pqOpc7YPSnKEujOj3N0xO4Zjh6PpsSzw
	 0LbYXYEHCe+GzLlAlgMReVdMVz45Q95ycSAOvv709HV7mCskmEt4esOrrYeOiNjLH1
	 K7ZsR9sLxjruQ==
Date: Mon, 19 Aug 2024 14:39:54 +0200
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
Message-ID: <ZsM9GpHoD-RQNTLN@example.org>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <f34a16af07be2bf33730ffa9da0c4eaa777087a1.1723807851.git.legion@kernel.org>
 <3jhsxclq2keesprq43jd7arhiteluppvscutzfdvkwcz3nr5pv@tix36bqw3b5j>
 <ZsMxAGsYskX0o51m@example.org>
 <n64tn2dai56kovscubbajub7ke26njnxnnqqb5n7nsh3rtzfmt@53xi25pcxlec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n64tn2dai56kovscubbajub7ke26njnxnnqqb5n7nsh3rtzfmt@53xi25pcxlec>

On Mon, Aug 19, 2024 at 03:07:50PM +0300, Kirill A. Shutemov wrote:
> On Mon, Aug 19, 2024 at 01:48:16PM +0200, Alexey Gladkov wrote:
> > On Mon, Aug 19, 2024 at 01:39:17PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Aug 16, 2024 at 03:43:52PM +0200, Alexey Gladkov wrote:
> > > > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > > > 
> > > > Instructions from kernel space are considered trusted. If the MMIO
> > > > instruction is from userspace it must be checked.
> > > > 
> > > > For userspace instructions, it is need to check that the INSN has not
> > > > changed at the time of #VE and before the execution of the instruction.
> > > 
> > > Well, we cannot really check if the instruction changed under us. We can
> > > only check if the parsed instruction does an MMIO operation that is
> > > allowed for the process.
> > 
> > We also check that the memory access (read/write) type matches. Yes, we
> > can't check the instruction itself, but we check the arguments.
> > 
> > > > 
> > > > Once the userspace instruction parsed is enforced that the address
> > > > points to mapped memory of current process and that address does not
> > > > point to private memory.
> > > > 
> > > > After parsing the userspace instruction, it is necessary to ensure that:
> > > > 
> > > > 1. the operation direction (read/write) corresponds to #VE info;
> > > > 2. the address still points to mapped memory of current process;
> > > > 3. the address does not point to private memory.
> > > 
> > > I don't see where you check 3.
> > > 
> > > I guess you can add pte_decrypted(pte) check to get_phys_addr().
> > > 
> > > But I'm not sure it is strictly needed.
> > 
> > (ve->gpa != cc_mkdec(phys_addr)
> > 
> > The ve->gpa was checked in the virt_exception_user/kernel().
> 
> phys_addr doesn't have shared bit. It is masked out on pte_pfn(). That's
> the reason you use cc_mkdec() to compare with ve->gpa. Otherwise it would
> fail.

Ok. I think I've confused myself. I will add pte_decrypted(). 

> 
> > 
> > > 
> > > > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > > > ---
> > > >  arch/x86/coco/tdx/tdx.c | 128 ++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 115 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > > > index af0b6c1cacf7..86c22fec97fb 100644
> > > > --- a/arch/x86/coco/tdx/tdx.c
> > > > +++ b/arch/x86/coco/tdx/tdx.c
> > > > @@ -8,6 +8,7 @@
> > > >  #include <linux/export.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/kexec.h>
> > > > +#include <linux/mm.h>
> > > >  #include <asm/coco.h>
> > > >  #include <asm/tdx.h>
> > > >  #include <asm/vmx.h>
> > > > @@ -405,6 +406,84 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
> > > >  			       EPT_WRITE, addr, val);
> > > >  }
> > > >  
> > > > +static inline bool is_private_gpa(u64 gpa)
> > > > +{
> > > > +	return gpa == cc_mkenc(gpa);
> > > > +}
> > > > +
> > > > +static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
> > > > +{
> > > > +	unsigned int level;
> > > > +	pgd_t *pgdp;
> > > > +	pte_t *ptep;
> > > > +
> > > > +	/*
> > > > +	 * Address validation only makes sense for a user process. The lock must
> > > > +	 * be obtained before validation can begin.
> > > > +	 */
> > > > +	mmap_assert_locked(current->mm);
> > > > +
> > > > +	pgdp = pgd_offset(current->mm, addr);
> > > > +
> > > > +	if (!pgd_none(*pgdp)) {
> > > > +		ptep = lookup_address_in_pgd(pgdp, addr, &level);
> > > > +		if (ptep) {
> > > > +			unsigned long offset;
> > > > +
> > > > +			offset = addr & ~page_level_mask(level);
> > > > +			*phys_addr = PFN_PHYS(pte_pfn(*ptep));
> > > > +			*phys_addr |= offset;
> > > > +
> > > > +			*writable = pte_write(*ptep);
> > > > +
> > > > +			return 0;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return -EFAULT;
> > > > +}
> > > > +
> > > > +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> > > > +		       unsigned long vaddr)
> > > > +{
> > > > +	phys_addr_t phys_addr;
> > > > +	bool writable = false;
> > > > +
> > > > +	/* It's not fatal. This can happen due to swap out or page migration. */
> > > > +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
> > > 
> > > Too long line?
> > 
> > All patches pass checkpatch without warnings.
> 
> Checkpatch is not the ultimate authority. But I am neither. :P
> 
> > > 
> > > > +		return -EAGAIN;
> > > > +
> > > > +	/*
> > > > +	 * Re-check whether #VE info matches the instruction that was decoded.
> > > > +	 *
> > > > +	 * The ve->gpa was valid at the time ve_info was received. But this code
> > > > +	 * executed with interrupts enabled, allowing tlb shootdown and therefore
> > > > +	 * munmap() to be executed in the parallel thread.
> > > > +	 *
> > > > +	 * By the time MMIO emulation is performed, ve->gpa may be already
> > > > +	 * unmapped from the process, the device it belongs to removed from
> > > > +	 * system and something else could be plugged in its place.
> > > > +	 */
> > > > +	switch (mmio) {
> > > > +	case INSN_MMIO_WRITE:
> > > > +	case INSN_MMIO_WRITE_IMM:
> > > > +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> > > > +			return -EFAULT;
> > > > +		break;
> > > > +	case INSN_MMIO_READ:
> > > > +	case INSN_MMIO_READ_ZERO_EXTEND:
> > > > +	case INSN_MMIO_READ_SIGN_EXTEND:
> > > > +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> > > > +			return -EFAULT;
> > > > +		break;
> > > > +	default:
> > > > +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> > > >  			     struct pt_regs *regs, struct ve_info *ve)
> > > >  {
> > > > @@ -489,7 +568,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > > >  	enum insn_mmio_type mmio;
> > > >  	struct insn insn = {};
> > > >  	unsigned long vaddr;
> > > > -	int size;
> > > > +	int size, ret;
> > > >  
> > > >  	/* Only in-kernel MMIO is supported */
> > > >  	if (WARN_ON_ONCE(user_mode(regs)))
> > > > @@ -505,6 +584,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > > >  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
> > > >  		return -EINVAL;
> > > >  
> > > > +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > > > +
> > > > +	if (current->mm) {
> > > 
> > > Hm. This path will be taken for any MMIO if it is done in context of a
> > > process, even in-kernel only. I don't think we want it. It is useless
> > > overhead.
> > 
> > The kthread do not have a current->mm.
> 
> I am not talking about kthread. I am talking about initiating MMIO from
> kernel, but within a process context. Like, you call an ioctl() on a
> device fd and it triggers MMIO in kernel. This scenario would have
> current->mm, but it is not userspace MMIO.

Ok. I will use user_mode here and in the movs patch I will add a special
flag to perform checks in case of nested exceptions.

> > > Use user_mode(regs) instead.
> > 
> > I can't use this. When nested exception happens in the handle_mmio_movs()
> > the regs will be not in the user mode.
> > 
> > I can make a flag that will be set either for user_mode or if we have a
> > nested exception.
> 
> Hm. Yeah. This is ugly. Let me think about it.

Yes, it's not very good.

-- 
Rgrds, legion


