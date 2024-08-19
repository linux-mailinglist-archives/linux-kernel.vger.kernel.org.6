Return-Path: <linux-kernel+bounces-291898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104439568AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E64EB22909
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C05161319;
	Mon, 19 Aug 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eynPzNdE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63181155316
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063966; cv=none; b=XJwISaTqONHGLAcGbZfG87vtvuxe3ecuwfe1SJ7mHr7UWOZMsHbdJ14OOxM2HqpA6g+4A9x6j4Hjmh7YORMdqBnUymqklLMZE3zKIcCWFM9KqrFVQLC5cNQslUYo83p/jny49eGOH/MnTExm1nK+IQuRk1eof8wRogG+1DCQ/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063966; c=relaxed/simple;
	bh=LfTs8mN+UJZ6czrqGLY3rirb9XCYnwsr8Du73oNkZgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6gNghvzQOXhiGDSrJT+bKAs3hhmdOA/BkQxfEgz3TXMjOgDGzT6JKfSihCHW4m7PWzY8ajKtgAx9hxccdYVD5OXCtW1FND4RhRsIU/0bQp36P+62664+Z/QVyRibhJkXPrtNE7bECR9kebo+F+2EJSkmGhaG/0Kl+ijtDWXN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eynPzNdE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724063963; x=1755599963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LfTs8mN+UJZ6czrqGLY3rirb9XCYnwsr8Du73oNkZgY=;
  b=eynPzNdEhHrq1QDP5A+OdHypF3pGMrwUsmqyZ1sIK7V8/9Hs3a0lCFiP
   etfxNZSgL9mVXtVrf12fRk8lvTj57humF/KAFZUnNiIax3Cr2FtkhW86M
   2S75X7HyUfFto6xdxZ6uN+9OUjwJivMI+ue8+p2HqFIVcw0pw8tCkyvAx
   8MOSKfLe0U1dku5EtQv++fm1p3BEkaEMyefmgq7gPlolW5PsYVJhnDH5s
   O31DOm7N7CVmSGSpVasj5RYnydJKBjOxo/+kXehQYslbKU3PZCa+U67V3
   9gNC5OOleu2Vj6AOmAL/M/6PR3iV4SnK1oxvLTitkDF9SG93CmZZxbQaB
   A==;
X-CSE-ConnectionGUID: AiyVXYN0Qq2a5cKRn2m3AQ==
X-CSE-MsgGUID: VdxZKemhRAWKvxG2tZCr/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32874991"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32874991"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:39:22 -0700
X-CSE-ConnectionGUID: 9EAS4sPoTMC3O2DDaLLxCA==
X-CSE-MsgGUID: VJtkDlwaQneAsdk1CVXemw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64722386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 19 Aug 2024 03:39:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C463D2D8; Mon, 19 Aug 2024 13:39:17 +0300 (EEST)
Date: Mon, 19 Aug 2024 13:39:17 +0300
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
Message-ID: <3jhsxclq2keesprq43jd7arhiteluppvscutzfdvkwcz3nr5pv@tix36bqw3b5j>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <f34a16af07be2bf33730ffa9da0c4eaa777087a1.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34a16af07be2bf33730ffa9da0c4eaa777087a1.1723807851.git.legion@kernel.org>

On Fri, Aug 16, 2024 at 03:43:52PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> Instructions from kernel space are considered trusted. If the MMIO
> instruction is from userspace it must be checked.
> 
> For userspace instructions, it is need to check that the INSN has not
> changed at the time of #VE and before the execution of the instruction.

Well, we cannot really check if the instruction changed under us. We can
only check if the parsed instruction does an MMIO operation that is
allowed for the process.

> 
> Once the userspace instruction parsed is enforced that the address
> points to mapped memory of current process and that address does not
> point to private memory.
> 
> After parsing the userspace instruction, it is necessary to ensure that:
> 
> 1. the operation direction (read/write) corresponds to #VE info;
> 2. the address still points to mapped memory of current process;
> 3. the address does not point to private memory.

I don't see where you check 3.

I guess you can add pte_decrypted(pte) check to get_phys_addr().

But I'm not sure it is strictly needed.

> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> ---
>  arch/x86/coco/tdx/tdx.c | 128 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 115 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index af0b6c1cacf7..86c22fec97fb 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/kexec.h>
> +#include <linux/mm.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -405,6 +406,84 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
>  			       EPT_WRITE, addr, val);
>  }
>  
> +static inline bool is_private_gpa(u64 gpa)
> +{
> +	return gpa == cc_mkenc(gpa);
> +}
> +
> +static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
> +{
> +	unsigned int level;
> +	pgd_t *pgdp;
> +	pte_t *ptep;
> +
> +	/*
> +	 * Address validation only makes sense for a user process. The lock must
> +	 * be obtained before validation can begin.
> +	 */
> +	mmap_assert_locked(current->mm);
> +
> +	pgdp = pgd_offset(current->mm, addr);
> +
> +	if (!pgd_none(*pgdp)) {
> +		ptep = lookup_address_in_pgd(pgdp, addr, &level);
> +		if (ptep) {
> +			unsigned long offset;
> +
> +			offset = addr & ~page_level_mask(level);
> +			*phys_addr = PFN_PHYS(pte_pfn(*ptep));
> +			*phys_addr |= offset;
> +
> +			*writable = pte_write(*ptep);
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
> +		       unsigned long vaddr)
> +{
> +	phys_addr_t phys_addr;
> +	bool writable = false;
> +
> +	/* It's not fatal. This can happen due to swap out or page migration. */
> +	if (get_phys_addr(vaddr, &phys_addr, &writable) || (ve->gpa != cc_mkdec(phys_addr)))

Too long line?

> +		return -EAGAIN;
> +
> +	/*
> +	 * Re-check whether #VE info matches the instruction that was decoded.
> +	 *
> +	 * The ve->gpa was valid at the time ve_info was received. But this code
> +	 * executed with interrupts enabled, allowing tlb shootdown and therefore
> +	 * munmap() to be executed in the parallel thread.
> +	 *
> +	 * By the time MMIO emulation is performed, ve->gpa may be already
> +	 * unmapped from the process, the device it belongs to removed from
> +	 * system and something else could be plugged in its place.
> +	 */
> +	switch (mmio) {
> +	case INSN_MMIO_WRITE:
> +	case INSN_MMIO_WRITE_IMM:
> +		if (!writable || !(ve->exit_qual & EPT_VIOLATION_ACC_WRITE))
> +			return -EFAULT;
> +		break;
> +	case INSN_MMIO_READ:
> +	case INSN_MMIO_READ_ZERO_EXTEND:
> +	case INSN_MMIO_READ_SIGN_EXTEND:
> +		if (!(ve->exit_qual & EPT_VIOLATION_ACC_READ))
> +			return -EFAULT;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported mmio instruction: %d", mmio);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
>  			     struct pt_regs *regs, struct ve_info *ve)
>  {
> @@ -489,7 +568,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	enum insn_mmio_type mmio;
>  	struct insn insn = {};
>  	unsigned long vaddr;
> -	int size;
> +	int size, ret;
>  
>  	/* Only in-kernel MMIO is supported */
>  	if (WARN_ON_ONCE(user_mode(regs)))
> @@ -505,6 +584,17 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
>  		return -EINVAL;
>  
> +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> +
> +	if (current->mm) {

Hm. This path will be taken for any MMIO if it is done in context of a
process, even in-kernel only. I don't think we want it. It is useless
overhead.

Use user_mode(regs) instead.

> +		if (mmap_read_lock_killable(current->mm))
> +			return -EINTR;
> +
> +		ret = valid_vaddr(ve, mmio, size, vaddr);
> +		if (ret)
> +			goto unlock;
> +	}
> +
>  	/*
>  	 * Reject EPT violation #VEs that split pages.
>  	 *
> @@ -514,30 +604,39 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	 *
>  	 * load_unaligned_zeropad() will recover using exception fixups.
>  	 */
> -	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> -	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)
> -		return -EFAULT;
> +	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE) {
> +		ret = -EFAULT;
> +		goto unlock;
> +	}
>  
>  	switch (mmio) {
>  	case INSN_MMIO_WRITE:
>  	case INSN_MMIO_WRITE_IMM:
>  	case INSN_MMIO_MOVS:
> -		return handle_mmio_write(&insn, mmio, size, regs, ve);
> +		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
> +		break;
>  	case INSN_MMIO_READ:
>  	case INSN_MMIO_READ_ZERO_EXTEND:
>  	case INSN_MMIO_READ_SIGN_EXTEND:
> -		return handle_mmio_read(&insn, mmio, size, regs, ve);
> +		ret = handle_mmio_read(&insn, mmio, size, regs, ve);
> +		break;
>  	case INSN_MMIO_DECODE_FAILED:
>  		/*
>  		 * MMIO was accessed with an instruction that could not be
>  		 * decoded or handled properly. It was likely not using io.h
>  		 * helpers or accessed MMIO accidentally.
>  		 */
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>  	default:
>  		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +unlock:
> +	if (current->mm)
> +		mmap_read_unlock(current->mm);
> +
> +	return ret;
>  }
>  
>  static bool handle_in(struct pt_regs *regs, int size, int port)
> @@ -681,11 +780,6 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  	}
>  }
>  
> -static inline bool is_private_gpa(u64 gpa)
> -{
> -	return gpa == cc_mkenc(gpa);
> -}
> -
>  /*
>   * Handle the kernel #VE.
>   *
> @@ -723,6 +817,14 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
>  		insn_len = virt_exception_user(regs, ve);
>  	else
>  		insn_len = virt_exception_kernel(regs, ve);
> +
> +	/*
> +	 * A special case to return to userspace without increasing regs->ip
> +	 * to repeat the instruction once again.
> +	 */
> +	if (insn_len == -EAGAIN)
> +		return true;
> +
>  	if (insn_len < 0)
>  		return false;
>  
> -- 
> 2.45.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

