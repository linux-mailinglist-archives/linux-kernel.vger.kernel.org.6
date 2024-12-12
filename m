Return-Path: <linux-kernel+bounces-443914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD779EFD79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C5628B5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1518E04D;
	Thu, 12 Dec 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMWLupDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033A1422D4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035499; cv=none; b=Rw7A+ZXuqadWmnI954a20p4xZi9dk5O2xEaVXZpHIypTptbU/XXOMXAqQpmJ/RSMshrwEUwTYjDzzmHTtsU+KOmt/xiZJCM/SQ9b+GHdzIVjTTd80aLVECqKK0SHNuFUuj6nG82forognrJie2/Ixky0VjxV3FvmjS/jUuKFTUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035499; c=relaxed/simple;
	bh=CueMbdhBBRN/E3nJAMpNrY1ck9YZIV4/Dfc8HiUOcbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peUH8LwrjWh3DTFUNLfRMo2fOTOcGAuSG8leP2AO/d9mwHijTudZkYhIVeTUBWl2Ai5dO8KhwfG5eXBdAdxHBjkaYJcv6++hVCl2Dxgq3uReqJrqzNOAzhVMKAK/o91+spHCLOy1AVIZh4OxVQVdp9aB03I3OYRzyA3+S7yQC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMWLupDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D46C4CECE;
	Thu, 12 Dec 2024 20:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734035498;
	bh=CueMbdhBBRN/E3nJAMpNrY1ck9YZIV4/Dfc8HiUOcbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMWLupDB0lyLNW85/ApiYYhd/Q1QhRuERiR7elsk9Pa9ccYEXuHvhM5WpvDtIizaD
	 0iw5tsbMk/7G4g+bjjwrgiO6cJoZ1h8RPVj54Fi116yDasFH520hRgfNxHna1/purW
	 jBi53RvPjLC1L1UEXvagSWvMXDO6o2CTRluUJHiHpTb27ozIntKH2XmEKfMfmbKvVP
	 wo5WNmRGa4YaRh8BdYQba4Y0hmznLA/dN4c3dUD/zC+eeYxcdAWzpi8x1hp2qUfjKD
	 j+xAfYPd1RNy0a5gC5wUMEpS74u7eZXh1Nav8sbX1pleJJljcTwnDQsg0EFsXNerxs
	 NQRNBWmRYH+jQ==
Date: Thu, 12 Dec 2024 13:31:32 -0700
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
Subject: Re: [PATCH] x86/kexec: Only write through identity mapping of
 control page
Message-ID: <20241212203132.GA1627368@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>

On Thu, Dec 12, 2024 at 08:11:19PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The virtual mapping of the control page may have been _PAGE_GLOBAL and
> thus its PTE might not have been flushed on the %cr3 switch and it might
> effectively still be read-only. Move the writes to it down into the
> identity_mapped() function where the same %rip-relative addressing will
> get the new mapping.
> 
> The stack is fine, as that's using the identity mapped address anyway.
> 
> Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of RWX")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219592
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/kernel/relocate_kernel_64.S | 32 +++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 553d67845b84..b9c80b3091c8 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -90,22 +90,17 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	movq	kexec_pa_table_page(%rip), %r9
>  	movq	%r9, %cr3
>  
> -	/* Save %rsp and CRs. */
> -	movq    %rsp, saved_rsp(%rip)
> -	movq	%rax, saved_cr3(%rip)
> -	movq	%cr0, %rax
> -	movq	%rax, saved_cr0(%rip)
> -	/* Leave CR4 in %r13 to enable the right paging mode later. */
> -	movq	%cr4, %r13
> -	movq	%r13, saved_cr4(%rip)
> -
> -	/* save indirection list for jumping back */
> -	movq	%rdi, pa_backup_pages_map(%rip)
> +	/*
> +	 * The control page still might not be writable because the original
> +	 * kernel PTE may have had the _PAGE_GLOBAL bit set. Don't write to
> +	 * it except through the *identmap* address.
> +	 */
>  
>  	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
>  	movq	%rcx, %r11
>  
>  	/* setup a new stack at the end of the physical control page */
> +	movq	%rsp, %rbp
>  	lea	PAGE_SIZE(%rsi), %rsp
>  
>  	/* jump to identity mapped page */
> @@ -118,6 +113,19 @@ SYM_CODE_END(relocate_kernel)
>  
>  SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	UNWIND_HINT_END_OF_STACK
> +
> +	/* Save original %rsp and CRs. */
> +	movq    %rbp, saved_rsp(%rip)
> +	movq	%rax, saved_cr3(%rip)
> +	movq	%cr0, %rax
> +	movq	%rax, saved_cr0(%rip)
> +	/* Leave CR4 in %r13 to enable the right paging mode later. */
> +	movq	%cr4, %r13
> +	movq	%r13, saved_cr4(%rip)
> +
> +	/* save indirection list for jumping back */
> +	movq	%rdi, pa_backup_pages_map(%rip)
> +
>  	/*
>  	 * %rdi	indirection page
>  	 * %rdx start address
> @@ -185,7 +193,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 *  - Machine check exception on TDX guest, if it was enabled before.
>  	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
>  	 *
> -	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> +	 * Use R13 that contains the original CR4 value
>  	 * PAE is always set in the original CR4.
>  	 */
>  	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> -- 
> 2.47.0
> 
> 



