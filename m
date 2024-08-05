Return-Path: <linux-kernel+bounces-274663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C82947B41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C41B2174D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F67158DD8;
	Mon,  5 Aug 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNSBz0B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177D1E495;
	Mon,  5 Aug 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862313; cv=none; b=Tht+iJYq+B6GWJxpe3n1MbKRXzPcE/FVeGMc9wxW4GAItIHFOqc4E+UB4w9IObrpwaQFTEysI943O56CydU/BXFLQswvr6wOa9aWFM+v1avKv60lWScuU+qcH41cic0OweMKJQaXqQIN/8A2YYxI6616ZsPeqHCCeDmyqIP+bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862313; c=relaxed/simple;
	bh=oKZEK53pQdGjBi5I4ihYLvFYrtWxRVnPOmNnctNMgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKmim/YBRSWiv0mlGIqVE6vgMolb+2qm1rL4vJGoAlibRfr3339NflBtnZSa7ghU+2Z9CK89LwGIs9aEufu19nu3BAFlYjGkkruXGzGDB2S6Cek9j/JPspEdb5ZhZnUOehJZ6YnxntAEkBfMDtlb+8VDxuxCImsAvQjDtH4bbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNSBz0B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D85C32782;
	Mon,  5 Aug 2024 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862313;
	bh=oKZEK53pQdGjBi5I4ihYLvFYrtWxRVnPOmNnctNMgnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNSBz0B6jdUhxnmE+Zu0g+6XsspSvW26Nz9B/Vmk5YeIAynm2u9K7OAjX/UP7wzIT
	 tPcfLkKEM7MRWOKzTE/aQ3m5snuDG/T1vxbFRSfu30VAeHg/3vWuSRABLHR0sDo5p6
	 Rsh0FgeYibx9ABUhvohYWJkBEU9LPoIzFkR6OFxn8Hfmv0Wa91p1ZDwtYTUidu2nIm
	 aVb3jElyf8ZV7INcLqLlDX17QNmrZmWUTFEmdvidI1F0JWUIVqKBRsbCcZhR3/FvfG
	 MBgI6MkB6WwwFTKyC75G4fhElssmjPKz9mRz44+Wws6YURSkloMspEwFAqd6mN/Av8
	 Jt12w2NuE142Q==
Date: Mon, 5 Aug 2024 14:51:45 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>, cho@microsoft.com,
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v1 4/4] x86/tdx: Implement movs for MMIO
Message-ID: <ZrDK4bP3LUm17ubK@example.org>
References: <cover.1722356794.git.legion@kernel.org>
 <c24855b0003df4397e3931f35d7ec285db5bc8bf.1722356794.git.legion@kernel.org>
 <871q3a7mf7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q3a7mf7.ffs@tglx>

On Tue, Jul 30, 2024 at 08:41:00PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
> > Adapt AMD's implementation of the MOVS instruction. Since the
> > implementations are similar, it is possible to reuse the code.
> >
> > MOVS emulation consists of dividing it into a series of read and write
> > operations, which in turn will be validated separately.
> 
> Please split this into two patches:
> 
>     1) Splitting out the AMD code
>     2) Adding it for Intel

Ok. Make sense.

> > @@ -369,72 +369,17 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
> >  static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
> >  				   char *dst, char *buf, size_t size)
> >  {
> > -	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
> > +	unsigned long error_code;
> > +	int ret = __put_iomem(dst, buf, size);
> 
> Variable ordering....
>   
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
> > +	WARN_ON_ONCE(!user_mode(regs));
> 
> Then it should return here and not try to continue, no?

Oops. I miss it. Thanks!

> > +int __get_iomem(char *src, char *buf, size_t size)
> > +{
> > +	/*
> > +	 * This function uses __get_user() independent of whether kernel or user
> > +	 * memory is accessed. This works fine because __get_user() does no
> > +	 * sanity checks of the pointer being accessed. All that it does is
> > +	 * to report when the access failed.
> > +	 *
> > +	 * Also, this function runs in atomic context, so __get_user() is not
> > +	 * allowed to sleep. The page-fault handler detects that it is running
> > +	 * in atomic context and will not try to take mmap_sem and handle the
> > +	 * fault, so additional pagefault_enable()/disable() calls are not
> > +	 * needed.
> > +	 *
> > +	 * The access can't be done via copy_from_user() here because
> > +	 * mmio_read_mem() must not use string instructions to access unsafe
> > +	 * memory. The reason is that MOVS is emulated by the #VC handler by
> > +	 * splitting the move up into a read and a write and taking a nested #VC
> > +	 * exception on whatever of them is the MMIO access. Using string
> > +	 * instructions here would cause infinite nesting.
> > +	 */
> > +	switch (size) {
> > +	case 1: {
> > +		u8 d1;
> > +		u8 __user *s = (u8 __user *)src;
> 
> One line for the variables is enough
> 
> 		u8 d1, __user *s = (u8 __user *)src;
> 
> No?

Yes.

> > +	case 8: {
> > +		u64 d8;
> > +		u64 __user *s = (u64 __user *)src;
> > +		if (__get_user(d8, s))
> 
> Lacks newline between variable declaration and code.
> 
> Thanks,
> 
>         tglx
> 

-- 
Rgrds, legion


