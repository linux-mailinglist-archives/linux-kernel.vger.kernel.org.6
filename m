Return-Path: <linux-kernel+bounces-323684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3C9741BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120AC1C25471
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C11A3026;
	Tue, 10 Sep 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IfACzZsg"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EC194C6A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991850; cv=none; b=uirEeZKcG/5i7CljWmLZKFIh5W+u+DlQOeGOWGVj1TGgXSDLCjKbpG01IFANUJyZxFG7dARWsnvApQAob03ol3jL0KLQt/3TLJolSrwgS7NzKFKxKarq5sljb9rKOOP720ca27CRZ4ZaWBRqjIFOTpFcL17F/6n46MenpkvNW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991850; c=relaxed/simple;
	bh=X/usYFDHIZN6RRCaRHWNcJUemLIZWI8rzvZchONFm1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuCWbnUVNr/yff0EyTf9oyng2lTwN35SC5UBDei9ksARlfVo6lyCQHnly4eGz8K1eRLnqO1+iIeIPswDgVGDVOZ6ZZpaSNltR3xAEXaon+kqaVTFGE9zitms7U2w1yxq99rHPPPz63ZH6JOyX+R7wAnDUiHyEiOaB9FRHfoJGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IfACzZsg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725991833;
	bh=X/usYFDHIZN6RRCaRHWNcJUemLIZWI8rzvZchONFm1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfACzZsgVTrZtjHrmqaxPFUgeyEGzYP6QP3FTEz6qNLouUoS5VK8HFoj3ebtWmDIs
	 ydVxfGusYUdgtKyiRCxd+D7mD6mJLoNYryfK751fiQZHeTomRyH0coc5gZIUPPvKEn
	 EXcZuEUvElzcnPi+z3gFCRTXVR3URfKNo5w7pwHI=
Date: Tue, 10 Sep 2024 20:10:33 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] x86: vdso: Remove redundant ifdeffery around
 in_ia32_syscall()
Message-ID: <5f32ff04-5e3a-49b2-8d97-c95c149d001f@t-8ch.de>
References: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
 <20240910-x86-vdso-ifdef-v1-2-877c9df9b081@linutronix.de>
 <8734m7d1bt.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734m7d1bt.fsf@email.froward.int.ebiederm.org>

Hi Eric,

On 2024-09-10 09:34:46+0000, Eric W. Biederman wrote:
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > The ifdefs only guard code that is also guarded by in_ia32_syscall(),
> > which already contains the same ifdefs itself.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/x86/entry/vdso/vma.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index 9059b9d96393..ab2b011471e0 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -75,7 +75,6 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
> >  static void vdso_fix_landing(const struct vdso_image *image,
> >  		struct vm_area_struct *new_vma)
> >  {
> > -#if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
> >  	if (in_ia32_syscall() && image == &vdso_image_32) {
> >  		struct pt_regs *regs = current_pt_regs();
> >  		unsigned long vdso_land = image->sym_int80_landing_pad;
> > @@ -86,7 +85,6 @@ static void vdso_fix_landing(const struct vdso_image *image,
> >  		if (regs->ip == old_land_addr)
> >  			regs->ip = new_vma->vm_start + vdso_land;
> >  	}
> > -#endif
> >  }
> >  
> >  static int vdso_mremap(const struct vm_special_mapping *sm,
> > @@ -339,7 +337,6 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
> >  
> >  bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> >  {
> > -#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
> >  	const struct vdso_image *image = current->mm->context.vdso_image;
> >  	unsigned long vdso = (unsigned long) current->mm->context.vdso;
> >  
> > @@ -348,7 +345,6 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> >  		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
> >  			return true;
> >  	}
> > -#endif
> >  	return false;
> >  }
> 
> Have you tested to verify that after this change
> arch_syscall_is_vdso_signature compiles out the "image" and "vdso"
> variables?

Yes, I did:

$ objdump --disassemble=arch_syscall_is_vdso_sigreturn arch/x86/entry/vdso/vma.o
arch/x86/entry/vdso/vma.o:     file format elf64-x86-64

Disassembly of section .text:

00000000000007f0 <arch_syscall_is_vdso_sigreturn>:
 7f0:	f3 0f 1e fa          	endbr64
 7f4:	e8 00 00 00 00       	call   7f9 <arch_syscall_is_vdso_sigreturn+0x9>
 7f9:	31 c0                	xor    %eax,%eax
 7fb:	e9 00 00 00 00       	jmp    800 <arch_syscall_is_vdso_sigreturn+0x10>


> 
> If the compilers don't it might be worth it rearrange the code as:
> 	if (in_ia32_syscall()) {
> 		const struct vdso_image *image = current->mm->context.vdso_image;
> 		unsigned long vdso = (unsigned long) current->mm->context.vdso;
> 
> 		if (image == &vdso_image_32) {
>                 	....
>                         return true;
>                 }
> 	}
>         return false.
> 
> Making the variables depend upon in_ia32_syscall() so you can be certain
> they are compiles out.

If that structure is preferred I can send a v2.


Thomas

