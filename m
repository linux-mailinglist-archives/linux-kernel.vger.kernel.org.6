Return-Path: <linux-kernel+bounces-408540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEF9C802E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A972283793
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC481E009F;
	Thu, 14 Nov 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr/IgF0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4628382
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548803; cv=none; b=Mp4k2D/67bMYhGbSN86idBlzGG2eo5f4ufyz36K2hyVat/S8PKfSdphyxw/n08Grp5N9dRgyXmsvrH7xdHuVLwrv4skKft3urhazj/1BAz2HvyC81GqF7WJt5RQl73JOLv1ioqtNoaQbRxYFIxILpv8NNxrPNZ8ELddmx/F+gZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548803; c=relaxed/simple;
	bh=lx1rGQYtbHGSPS7VyhMeibitndHfkvrCdu82/io1N/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5M4hdLf06xK5z/TM/vvp+dMNQN+vlnTCod9FsKx7+Nm+Suf0/nEibmasjcY1Y6VYofzKVl0rvAi50MTnD3mrdrFh7BgPsF+0w31KHgThuui4Gt1RScjI1Pc1hGphcayyFTE77S7wiGS2DOisPYbYH0+HE+eidapAyASyNBHG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr/IgF0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6126C4CEC3;
	Thu, 14 Nov 2024 01:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731548803;
	bh=lx1rGQYtbHGSPS7VyhMeibitndHfkvrCdu82/io1N/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr/IgF0y3KYraVhqfntkGwRtaMnJQIObndIC4zsYzorJinmIZnRFy3jdZCACUO12e
	 XFWldrR/eGPUUAkCZgxN+mOXQfS7+mmUqYBp9M8UHW+oVJngCZ1EKxp9O14MEVk+d0
	 HoG7arZaj978lzFv4/C2o3iF5j1rdaoVBb1VVloNFOxr1jjDGlQrK/OfRYBIYnDfHt
	 sfwI3PNX1kvz7jtQN9TVZPDLc7UixVf2ZiZSa8jzH3/uPMMWU+hWBnUR5P8rEd9isz
	 X2W/0Zf8utndDqJlpgThdc3FmNkqC2z9QUBtciwxATWbdbVcLK7se+m/Kn77K2IuNt
	 30iq/Gk/2BRLg==
Date: Wed, 13 Nov 2024 17:46:41 -0800
From: jpoimboe <jpoimboe@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
	kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
Message-ID: <20241114014641.pmpdpq7gsowadpqs@jpoimboe>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
 <20241108052241.3972433-1-dwmw2@infradead.org>
 <20241108052241.3972433-2-dwmw2@infradead.org>
 <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
 <1e8f11982ad0754d8123c143a514969fa2a07c05.camel@infradead.org>
 <20241112101423.GO22801@noisy.programming.kicks-ass.net>
 <785f90158524228a32bc4c22bfb4425ceadb0197.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <785f90158524228a32bc4c22bfb4425ceadb0197.camel@infradead.org>

On Tue, Nov 12, 2024 at 10:45:05AM +0000, David Woodhouse wrote:
> On Tue, 2024-11-12 at 11:14 +0100, Peter Zijlstra wrote:
> > On Tue, Nov 12, 2024 at 08:44:33AM +0000, David Woodhouse wrote:
> > > On Fri, 2024-11-08 at 12:26 +0100, H. Peter Anvin wrote:
> > > > 
> > > > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > > > @@ -100,7 +100,7 @@ const_pcpu_hot = pcpu_hot;
> > > > >         . = ALIGN(PAGE_SIZE);                                   \
> > > > >         __relocate_kernel_start = .;                            \
> > > > >         *(.text.relocate_kernel);                               \
> > > > > -       *(.rodata.relocate_kernel);                             \
> > > > > +       *(.data.relocate_kernel);                               \
> > 
> > Why are we having data in the middle of the text section?
> 
> This is the relocate_kernel() page. It's the last thing the kernel
> calls on kexec.
> 
> The kernel first takes a *copy* of it and places it into the identity
> mapping page tables which are set up for kexec.
> 
> The relocate_kernel() function is then called at its *original*
> location in the kernel text. Before reloading %cr3, it stores some
> information which is going to become unavailable into its own page
> (currently using a bit of a nasty hack based on a hard-coded
> KEXEC_CONTROL_CODE_MAX_SIZE because we can't just use data symbol
> references).
> 
> Then it reloads %cr3 and jumps to the identity-mapped copy of itself.
> 
> Could we put .text.relocate_kernel and .data.relocate_kernel somewhere
> *other* than the main kernel text segment? Probably... it use use
> alternative instructions, but we could deal with that. And if we call
> from machine_kexec() directly into the *copy* (having marked it
> executable), maybe...?

I fetched your branch and only saw a "RET before UNTRAIN" warning, did
you happen to already fix the other warnings up?

Something like the below fixes the warning I saw.

Though, maybe it's better to just tell objtool to keep its paws off of
the problematic functions by use of the STACK_FRAME_NON_STANDARD macro?
Then you could get rid of all the unwind hints and annotations.


diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6604f5d038aa..9ba10530b9c7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4012,8 +4012,11 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			return 0;
 
 		case INSN_RETURN:
-			WARN_INSN(insn, "RET before UNTRAIN");
-			return 1;
+			if (!insn->retpoline_safe) {
+				WARN_INSN(insn, "RET before UNTRAIN");
+				return 1;
+			}
+			break;
 
 		case INSN_NOP:
 			if (insn->retpoline_safe)


