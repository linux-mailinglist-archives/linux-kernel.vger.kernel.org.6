Return-Path: <linux-kernel+bounces-443585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29C9EF917
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66551189D0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C62253EB;
	Thu, 12 Dec 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2jxWGOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB6222D72
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025370; cv=none; b=APBPLVhex+Luna0SDuh1ILaUt9CH8edycR1WXCoY0SmQ48s83btLnkpOJZT0Uhi5UNxYemV5yBVRo2fdJAukQMjld15NEvNPnc0VABmDVl4zhSS4fcopM23mLpjnlZc+yai6aNIBBGoAZUb0C5LpvC0Im5p+A9BT1YMXB795rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025370; c=relaxed/simple;
	bh=mL38+B3WmzlGzE9gik8JWUe5iqxZz7gEor3abGo0zA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX+8QUiSyCebV4hpRUZnQ9+PopytS0e6ecyTpKxitDWUNLnzBd10NUrHX0QmBe+P2tBgGImL6evksjOHC2Pcjtk/SIJsXBu1Be7IVYUjN6F9/cqzeO2aK6RBPGUd5FOeUMBmLwAOoUYIcOsP83wfFZ2c/LG0dXrjYJbjmV6EpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2jxWGOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68A0C4CEE7;
	Thu, 12 Dec 2024 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734025369;
	bh=mL38+B3WmzlGzE9gik8JWUe5iqxZz7gEor3abGo0zA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2jxWGObLV/p6Q0fXx7esNLeLmx4/iZ9pXCBJDATMddk0JmxUVDaUwiS+CHOV+1Z3
	 VMk1NkdnIe0CEXI5zpTp7X4dE1C8GvvuRECzzp1SB+y19WJFSoDX3j812dxUo4X2PK
	 oVeTKPt8e5+L03+51DZ/ip4v5ZL+lXE4dQ1mT6IXfA005iIc5WVDP741bT+L5Dv/4L
	 Mx3BNL6eIfSI9nOGNeU9e4a0CkwMk+tw+Uvl12ZQbLeqdlml37X7hLZoUvz9TM36mU
	 QXUZfEHYOkPn3OeDnwvzkQFKyPKaVmOnB8n51DO4m91ZK7W9/Kh9r2n2f3dzL6Gzvc
	 /RlxDEwPFu8vg==
Date: Thu, 12 Dec 2024 10:42:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
Message-ID: <20241212174243.GA2149156@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>

On Thu, Dec 12, 2024 at 05:00:00PM +0000, David Woodhouse wrote:
> > 
> > Here is the output that I see with that patch applied when rebooting via
> > 'systemctl kexec':
> > 
> > RAX=000000010c070001 RBX=0000000000000000 RCX=0000000000000000 RDX=000000047fffb1a0
> > RSI=000000011c444000 RDI=000000011c450002 RBP=ff1cd0424d6e8c00 RSP=ff4178d5c5aebc60
> > R8 =0000000000000000 R9 =000000011c446000 R10=ffffffff909f3e00 R11=0000000000000003
> > R12=0000000000000000 R13=0000000000000001 R14=00000000fee1dead R15=0000000000000000
> > RIP=ff1cd0425c44401c RFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> > ES =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> > CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> > SS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> > DS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> > FS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> > GS =0018 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> > LDT=0000 0000000000000000 ffffffff 00c00000
> > TR =0040 fffffe043fedb000 00004087 00008b00 DPL=0 TSS64-busy
> > GDT=     0000000000000000 00000000
> > IDT=     0000000000000000 00000000
> > CR0=80050033 CR2=ff1cd0425c4441de CR3=000000011c446000 CR4=00771ef0
> > DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> > DR6=00000000fffe0ff0 DR7=0000000000000400
> > EFER=0000000000000d01
> > Code=41 57 9c 6a 00 9d 0f 20 d8 4c 8b 0d ee 01 00 00 41 0f 22 d9 <48> 89 25 bb 01 00 00 48 89 05 c4 01 00 00 0f 20 c0 48 89 05 b2 01 00 00 41 0f 20 e5 4c 89
> 
> ...
> 
> > I have attached the output of 'objdump -S'. Please let me know if you
> > would like any other information or testing.
> 
> 	/* Switch to the identity mapped page tables */
> 	movq	%cr3, %rax
>    e:	0f 20 d8             	mov    %cr3,%rax
> 	movq	kexec_pa_table_page(%rip), %r9
>   11:	4c 8b 0d 00 00 00 00 	mov    0x0(%rip),%r9        # 18 <relocate_kernel+0x18>
> 	movq	%r9, %cr3
>   18:	41 0f 22 d9          	mov    %r9,%cr3
> 
> 	/* Save %rsp and CRs. */
> 	movq    %rsp, saved_rsp(%rip)
>   1c:	48 89 25 00 00 00 00 	mov    %rsp,0x0(%rip)        # 23 <relocate_kernel+0x23>
> 	movq	%rax, saved_cr3(%rip)
> 
> 
> So it's faulting when it tries to write to saved_rsp, which is the
> first instruction after it loads the new page tables into %cr3.
> 
> Before loading %cr3, the CPU is running on the original kernel page
> tables, It's running from the *virtual* address of the control page,
> which in your case is ff1cd0425c444000. In those old page tables, this
> control page is read-only.
> 
> But in the newly-loaded page tables, this control page should be read-
> write. 
> 
> What CPU is this? Shouldn't loading %cr3 have caused the existing TLB
> entry to be flushed?

The machine I have mainly been reproducing and testing this issue on is
an Intel Xeon Gold 6314U but I initially noticed this problem on a few
consumer AMD and Intel chips that I have locally.

> Can you tell me what happens if we don't write through *that* virtual
> mapping of the page, but instead do it a few instructions later through
> the identity mapping of the same page (which surely *won't* have an
> older, non-writeable TLB entry already...)?

Applying that diff on top of 5a82223e0743 makes the issue go away for
me.

> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 8bc86a1e056a..2763c509e513 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -70,6 +70,18 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	movq	kexec_pa_table_page(%rip), %r9
>  	movq	%r9, %cr3
>  
> +	/* setup a new stack at the end of the physical control page */
> +	lea	PAGE_SIZE(%rsi), %rsp
> +
> +	/* jump to identity mapped page */
> +	addq	$(identity_mapped - relocate_kernel), %rsi
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rsi
> +	int3
> +SYM_CODE_END(relocate_kernel)
> +
> +SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> +	UNWIND_HINT_END_OF_STACK
>  	/* Save %rsp and CRs. */
>  	movq    %rsp, saved_rsp(%rip)
>  	movq	%rax, saved_cr3(%rip)
> @@ -85,19 +97,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
>  	movq	%rcx, %r11
>  
> -	/* setup a new stack at the end of the physical control page */
> -	lea	PAGE_SIZE(%rsi), %rsp
> -
> -	/* jump to identity mapped page */
> -	addq	$(identity_mapped - relocate_kernel), %rsi
> -	pushq	%rsi
> -	ANNOTATE_UNRET_SAFE
> -	ret
> -	int3
> -SYM_CODE_END(relocate_kernel)
> -
> -SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> -	UNWIND_HINT_END_OF_STACK
>  	/*
>  	 * %rdi	indirection page
>  	 * %rdx start address
> 



