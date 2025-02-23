Return-Path: <linux-kernel+bounces-527655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C5A40DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76F9189571A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6DD20127F;
	Sun, 23 Feb 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot35b3B9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2F1EEA43
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304398; cv=none; b=c1IrhL+esR737maacVlr96eZzHUgFBjhOh/JuLmvbTcN8bTDV4qLOwB/cHZ3yZJ57iUgrA3PkXdjAXGjbL3MA/oHvlIPsRlvqR/HNbf/RCG0lxnLAHImVvKtgCzxE6N6TFrgy2RiBlXYi/RIWjdDzoM+uDSG+1ydBWFOXNrF48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304398; c=relaxed/simple;
	bh=K7CO8Lrs4keAG8R3V4xMDGh7oNAIoEsVthwZm0p0UA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPTLz+4c/8+ZahbbHMCIBEoZrxt8GKydE3bf2bCUmf8z+QiCDsfBnC0HUdoUHl10lJ1l9VGyisiK9L0f5nUYhWRmWBpwFoCAR8BRwYdkHPgAqUMG8Uq8seb7INkSV40hnz6H9Lg5Y42gtVPXADQIx9dcNTNx7S8EKAsicgu5gdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot35b3B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E7C4CEDD;
	Sun, 23 Feb 2025 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740304398;
	bh=K7CO8Lrs4keAG8R3V4xMDGh7oNAIoEsVthwZm0p0UA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot35b3B9o74y0ZW1yh9Xu17CwBgDZtTIRFy5wUdBX2QLt/goPhUli1fT0/nJTthvW
	 sKwCwWph3guEFEim3dXjdupAMUVxVTJg1v36mgWmiZvcN7+vnUsYGKMu1TJyTkc8nC
	 RFH+mGB0RClDnEONs7RrccKyLTuyj36Ft21hdmP5wOG5LkJgmQwT5vzC4K+yoyy+xB
	 dhBM7JtlDEQ2FzOocYA+zmY7BcTM5r8Fj8qdpmX3y0SNtd2K9TASYlUP/7OxT+xI+/
	 +DrLTruIU1VrBlfhtMMWtl1xzv09vrgEw7uFnhFN2SMMzGv4KgRuD+TUM5TW+Z4Owi
	 DvVqMVhZTHF3Q==
Date: Sun, 23 Feb 2025 10:53:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v6 2/7] x86/kexec: Debugging support: load a GDT
Message-ID: <Z7rwA-qVauX7lY8G@gmail.com>
References: <20250115191423.587774-1-dwmw2@infradead.org>
 <20250115191423.587774-3-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115191423.587774-3-dwmw2@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There are some failure modes which lead to triple-faults in the
> relocate_kernel function, which is fairly much undebuggable for normal
> mortals.
> 
> Adding a GDT in the relocate_kernel environment is step 1 towards being
> able to catch faults and do something more useful.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index af2cd06ff318..c62f03808f18 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
>  SYM_DATA(kexec_pa_swap_page, .quad 0)
>  SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
>  
> +#ifdef CONFIG_KEXEC_DEBUG
> +	.balign 16
> +SYM_DATA_START_LOCAL(kexec_debug_gdt)
> +	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
> +	.long   0
> +	.word   0
> +	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
> +	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
> +	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
> +SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
> +#endif /* CONFIG_KEXEC_DEBUG */

Yeah, so is there any reason (other than paranoia) why the early-early 
GDT and IDT shouldn't be unconditional? There's many ways for such an 
approach to bitrot, it's much better to not hide it behind a 
default-disabled debug option...

Some of the other bits, like the hard-coded serial debugging 
assumptions, probably need to be behind the debug option - but much of 
the new debug mechanism looks safe and generic and can be always-on, 
IMHO.

This would also throw regressions back into the face of whoever manages 
to introduce them, ideally. ;-)

Thanks,

	Ingo

