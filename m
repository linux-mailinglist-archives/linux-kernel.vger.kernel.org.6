Return-Path: <linux-kernel+bounces-279890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A597194C31A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70561C21ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA619048A;
	Thu,  8 Aug 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tijxg9yV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5918DF70;
	Thu,  8 Aug 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136008; cv=none; b=oE98uIeN7n9gouDs9bHMtPvvhHWMDMLffYhpmqiD/EPc5Ji612dpocWEKVqWTTkk02/4BBvYS+nBA+YvdKldCqkcTcgbav3Obyd/SL/8Ap2EkUpLBTOVNbXzOlfYNGp7BxpwkfN0SI+9vje37zkcmNduGXZP2I39uGGFDiJGiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136008; c=relaxed/simple;
	bh=2G8acm99ctNGrHgg9Ur12SMR39ZkWeRqcgqvmBWQQHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta8AAo4q2lY0JeM3ZbWF9WBO66J0YL1zkr7tbYQBcIq6ZJejbWhfByqrebtZV3p3zvNlXhQGS94ld0W8t9PV8zsWmSf4uSdCJeAtJ3JnvbjZAH61ethsAIeTAzWRaWmCyL9njhJtXAiW/AHTNx9bIzmKEnUCo7T3vNBBEDUq/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tijxg9yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872ADC32782;
	Thu,  8 Aug 2024 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723136008;
	bh=2G8acm99ctNGrHgg9Ur12SMR39ZkWeRqcgqvmBWQQHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tijxg9yVJ20yKgrdC4mZ6DbB4+ZrLOD9EmDq25CH2aL2UXtVvCNwUHS1TDBNMNRbH
	 990b9pDJYh/M9Vz7XVys8q2d6BCdW0KhL44xuuBln40wRPp2K02fHQBq8t2Sdux8D+
	 Jx3s3lQDdr5GFRcXIs37WqmeKXnHqoRvfkWei3zZUTyg/c2aqUqI7qV3gt4guDy9xy
	 P30LxibWkKKkDP3mf/nz358Tzb7YKMiI59bTWuJHQVJYhLv8ut/BZE32uNyrwfL2AB
	 OHieHKADOmd9MHubPOvKKXIT6inZTWnN2sVtPlyZMFc+OFFVILRdk6SiQ/2Crv47tX
	 oO/EHPJ5Ei8yA==
Date: Thu, 8 Aug 2024 18:53:20 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v2 5/5] x86/tdx: Implement movs for MMIO
Message-ID: <ZrT4ABCJWbdO5Ui9@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <83aa03c8f95ef00a6cf2fd6fa768c4b13e533d1c.1722862355.git.legion@kernel.org>
 <bb34abeb-c26e-7f72-2e3f-1c189c1ed871@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb34abeb-c26e-7f72-2e3f-1c189c1ed871@amd.com>

On Thu, Aug 08, 2024 at 08:48:26AM -0500, Tom Lendacky wrote:
> On 8/5/24 08:29, Alexey Gladkov (Intel) wrote:
> > Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> > consists of dividing it into a series of read and write operations,
> > which in turn will be validated separately.
> > 
> > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 57 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 53 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 4e2fb9bf83a1..8573cb23837e 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -509,6 +509,54 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
> >  	return 0;
> >  }
> >  
> > +static int handle_mmio_movs(struct insn *insn, struct pt_regs *regs, int size, struct ve_info *ve)
> > +{
> > +	unsigned long ds_base, es_base;
> > +	unsigned char *src, *dst;
> > +	unsigned char buffer[8];
> > +	int off, ret;
> > +	bool rep;
> > +
> > +	/*
> > +	 * The in-kernel code must use a special API that does not use MOVS.
> > +	 * If the MOVS instruction is received from in-kernel, then something
> > +	 * is broken.
> > +	 */
> > +	if (WARN_ON_ONCE(!user_mode(regs)))
> > +		return -EFAULT;
> > +
> > +	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
> > +	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
> > +
> > +	if (ds_base == -1L || es_base == -1L)
> > +		return -EINVAL;
> > +
> > +	rep = insn_has_rep_prefix(insn);
> > +
> > +	do {
> > +		src = ds_base + (unsigned char *) regs->si;
> > +		dst = es_base + (unsigned char *) regs->di;
> > +
> > +		ret = __get_iomem(src, buffer, size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = __put_iomem(dst, buffer, size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		off = (regs->flags & X86_EFLAGS_DF) ? -size : size;
> > +
> > +		regs->si += off;
> > +		regs->di += off;
> > +
> > +		if (rep)
> > +			regs->cx -= 1;
> > +	} while (rep || regs->cx > 0);
> > +
> > +	return insn->length;
> > +}
> > +
> >  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> >  			     struct pt_regs *regs, struct ve_info *ve)
> >  {
> > @@ -530,9 +578,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
> >  		return insn->length;
> >  	case INSN_MMIO_MOVS:
> >  		/*
> > -		 * MMIO was accessed with an instruction that could not be
> > -		 * decoded or handled properly. It was likely not using io.h
> > -		 * helpers or accessed MMIO accidentally.
> > +		 * MOVS is processed through higher level emulation which breaks
> > +		 * this instruction into a sequence of reads and writes.
> >  		 */
> >  		return -EINVAL;
> >  	default:
> > @@ -602,6 +649,9 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
> >  		return -EINVAL;
> >  
> > +	if (mmio == INSN_MMIO_MOVS)
> > +		return handle_mmio_movs(&insn, regs, size, ve);
> 
> You check the address in the non-MOVS case using valid_vaddr(), but you
> don't seem to be doing that in the MOVS case, was that intentional?

Ah. You mean that read/write operations will be performed in kernel space
context and no checks will be made.

I guess you're right.

> Thanks,
> Tom
> 
> > +
> >  	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> >  
> >  	if (user_mode(regs)) {
> > @@ -630,7 +680,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	switch (mmio) {
> >  	case INSN_MMIO_WRITE:
> >  	case INSN_MMIO_WRITE_IMM:
> > -	case INSN_MMIO_MOVS:
> >  		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
> >  		break;
> >  	case INSN_MMIO_READ:
> 

-- 
Rgrds, legion


