Return-Path: <linux-kernel+bounces-292043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A68956A76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725C81F22C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B916C426;
	Mon, 19 Aug 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiFh+W/j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9816B74D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069278; cv=none; b=nIikodRfZcm2d4HwDWJWS59vR6wcJ8rMsA6xNtLyqcXMAck1wzRfAl0nneV+dKRM5STT5NXP2XAc2EuNNL6GpqKTBjYmzYbh9iZgFExMx8XWgj4eBjBOP3cGESUKkuTLHaiw/4WQLLhKI+TzW04auMan1d64OK+rY3LYA+7cKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069278; c=relaxed/simple;
	bh=tG5ilwo/bakGR9A+BWU574JcmdZ7leh7b2hTv2Xyb4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvKS1nclSQ0n4WM2EnIyTIY1Wf6/fgZwgTgSw+HZczfaNXbmdnew7JTZBhsOxxF3TTzjasWybfcuO2Yv+No6JbdS36XF/Vh8Sa85a/p51+wHuSp+hXPMZBVwYrA2bYkOTVik2Zdfi1KwrkvEeywSJeOveb2SeQMppEOVmSO5J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiFh+W/j; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724069277; x=1755605277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tG5ilwo/bakGR9A+BWU574JcmdZ7leh7b2hTv2Xyb4E=;
  b=XiFh+W/jiDKUbDmt5Z5aKAQXRwDnI3aB0TGlQGuSYCSi7SrcwL05L2k/
   pXI2sZkYC31jkj6w4jeHkzD35MDsjXSsGhZqom2e5lrQ1b9LogrRc8X5P
   3Xy+qdVx07WBi3aQIG1O4pyQah/XRFxzc1EDtReL13uuiZGyrMOLEkYCC
   TYnEErCu2y7d5MJ0gFSo2TzRBux2cNr687mbqkmbRiAjNiV6NCQfeYzoT
   nss1qbsyQ725kBReH4UPSZYSTV6xyu0AwpwXkSQ5mJQTX/rxzrQkg7pKU
   t3LNHKSaFxoCJya+3mYeiEL5PFmVj70ky1YZAXTjImTe4jKb4GZML66uL
   w==;
X-CSE-ConnectionGUID: drfBzBPoSA+gfE5yop/e/w==
X-CSE-MsgGUID: T9LTpP3oRv6dBVCS6KBzWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="13093422"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="13093422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:07:56 -0700
X-CSE-ConnectionGUID: EtuC1dyzTxOXTjkT38lxcA==
X-CSE-MsgGUID: w2JE6nhtSjuk1Hk8d/oMPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64744842"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 05:07:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 17D252D8; Mon, 19 Aug 2024 15:07:51 +0300 (EEST)
Date: Mon, 19 Aug 2024 15:07:50 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 02/10] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <n64tn2dai56kovscubbajub7ke26njnxnnqqb5n7nsh3rtzfmt@53xi25pcxlec>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <f34a16af07be2bf33730ffa9da0c4eaa777087a1.1723807851.git.legion@kernel.org>
 <3jhsxclq2keesprq43jd7arhiteluppvscutzfdvkwcz3nr5pv@tix36bqw3b5j>
 <ZsMxAGsYskX0o51m@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsMxAGsYskX0o51m@example.org>

On Mon, Aug 19, 2024 at 01:48:16PM +0200, Alexey Gladkov wrote:
> On Mon, Aug 19, 2024 at 01:39:17PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Aug 16, 2024 at 03:43:52PM +0200, Alexey Gladkov wrote:
> > > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > > 
> > > Instructions from kernel space are considered trusted. If the MMIO
> > > instruction is from userspace it must be checked.
> > > 
> > > For userspace instructions, it is need to check that the INSN has not
> > > changed at the time of #VE and before the execution of the instruction.
> > 
> > Well, we cannot really check if the instruction changed under us. We can
> > only check if the parsed instruction does an MMIO operation that is
> > allowed for the process.
> 
> We also check that the memory access (read/write) type matches. Yes, we
> can't check the instruction itself, but we check the arguments.
> 
> > > 
> > > Once the userspace instruction parsed is enforced that the address
> > > points to mapped memory of current process and that address does not
> > > point to private memory.
> > > 
> > > After parsing the userspace instruction, it is necessary to ensure that:
> > > 
> > > 1. the operation direction (read/write) corresponds to #VE info;
> > > 2. the address still points to mapped memory of current process;
> > > 3. the address does not point to private memory.
> > 
> > I don't see where you check 3.
> > 
> > I guess you can add pte_decrypted(pte) check to get_phys_addr().
> > 
> > But I'm not sure it is strictly needed.
> 
> (ve->gpa != cc_mkdec(phys_addr)
> 
> The ve->gpa was checked in the virt_exception_user/kernel().

phys_addr doesn't have shared bit. It is masked out on pte_pfn(). That's
the reason you use cc_mkdec() to compare with ve->gpa. Otherwise it would
fail.

> 
> > 
> > > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > > ---
> > >  arch/x86/coco/tdx/tdx.c | 128 ++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 115 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > > index af0b6c1cacf7..86c22fec97fb 100644
> > > --- a/arch/x86/coco/tdx/tdx.c
> > > +++ b/arch/x86/coco/tdx/tdx.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/io.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/mm.h>
> > >  #include <asm/coco.h>
> > >  #include <asm/tdx.h>
> > >  #include <asm/vmx.h>
> > > @@ -405,6 +406,84 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
> > >  			       EPT_WRITE, addr, val);
> > >  }
> > >  
> > > +static inline bool is_private_gpa(u64 gpa)
> > > +{
> > > +	return gpa == cc_mkenc(gpa);
> > > +}
> > > +
> > > +static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
> > > +{
> > > +	unsigned int level;
> > > +	pgd_t *pgdp;
> > > +	pte_t *ptep;
> > > +
> > > +	/*
> > > +	 * Address validation only makes sense for a user process. The lock must
> > > +	 * be obtained before validation can begin.
> > > +	 */
> > > +	mmap_assert_locked(current->mm);
> > > +
> > > +	pgdp = pgd_offset(current->mm, addr);
> > > +
> > > +	if (!pgd_none(*pgdp)) {
> > > +		ptep = lookup_address_in_pgd(pgdp, addr, &level);
> > > +		if (ptep) {
> > > +			unsigned long offset;
> > > +
> > > +			offset = addr & ~page_level_mask(level);
> > > +			*phys_addr = PFN_PHYS(pte_pfn(*ptep));
> > > +			*phys_addr |= offset;
> > > +
> > > +			*writable = pte_write(*ptep);
> > > +
> > > +			return 0;
> > > +		}
> > > +	}
> > > +
> > > +	return -EFAULT;
> > > +}
> > > +
> > > +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> > > +		       unsigned long vaddr)
> > > +{
> > > +	phys_addr_t phys_addr;
> > > +	bool writable = false;
> > > +
> > > +	/* It's not fatal. This can happen due to swap out or page migration. */
> > > +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))
> > 
> > Too long line?
> 
> All patches pass checkpatch without warnings.

Checkpatch is not the ultimate authority. But I am neither. :P

> > 
> > > +		return -EAGAIN;
> > > +
> > > +	/*
> > > +	 * Re-check whether #VE info matches the instruction that was decoded.
> > > +	 *
> > > +	 * The ve->gpa was valid at the time ve_info was received. But this code
> > > +	 * executed with interrupts enabled, allowing tlb shootdown and therefore
> > > +	 * munmap() to be executed in the parallel thread.
> > > +	 *
> > > +	 * By the time MMIO emulation is performed, ve->gpa may be already
> > > +	 * unmapped from the process, the device it belongs to removed from
> > > +	 * system and something else could be plugged in its place.
> > > +	 */
> > > +	switch (mmio) {
> > > +	case INSN_MMIO_WRITE:
> > > +	case INSN_MMIO_WRITE_IMM:
> > > +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> > > +			return -EFAULT;
> > > +		break;
> > > +	case INSN_MMIO_READ:
> > > +	case INSN_MMIO_READ_ZERO_EXTEND:
> > > +	case INSN_MMIO_READ_SIGN_EXTEND:
> > > +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> > > +			return -EFAULT;
> > > +		break;
> > > +	default:
> > > +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> > >  			     struct pt_regs *regs, struct ve_info *ve)
> > >  {
> > > @@ -489,7 +568,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > >  	enum insn_mmio_type mmio;
> > >  	struct insn insn = {};
> > >  	unsigned long vaddr;
> > > -	int size;
> > > +	int size, ret;
> > >  
> > >  	/* Only in-kernel MMIO is supported */
> > >  	if (WARN_ON_ONCE(user_mode(regs)))
> > > @@ -505,6 +584,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > >  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
> > >  		return -EINVAL;
> > >  
> > > +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > > +
> > > +	if (current->mm) {
> > 
> > Hm. This path will be taken for any MMIO if it is done in context of a
> > process, even in-kernel only. I don't think we want it. It is useless
> > overhead.
> 
> The kthread do not have a current->mm.

I am not talking about kthread. I am talking about initiating MMIO from
kernel, but within a process context. Like, you call an ioctl() on a
device fd and it triggers MMIO in kernel. This scenario would have
current->mm, but it is not userspace MMIO.

> > Use user_mode(regs) instead.
> 
> I can't use this. When nested exception happens in the handle_mmio_movs()
> the regs will be not in the user mode.
> 
> I can make a flag that will be set either for user_mode or if we have a
> nested exception.

Hm. Yeah. This is ugly. Let me think about it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

