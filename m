Return-Path: <linux-kernel+bounces-444340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B19F0506
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38C9188A816
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B418DF80;
	Fri, 13 Dec 2024 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kst1OZoT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497D18C03B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072475; cv=none; b=NK2MNFJFpsyAN80Qlcv5kbaHbFaETBiuGqQ0H4dgXav6l/GG7euS0aqqLn5ulTS4nWX8AfMLN5BbEWfQYrUKhn23HhTILU+l+ov46FFL9pqff2XmT2yYAqWgmwnHX4kyPV3XY5hZtgaJ0rNoX0/sJsrGRvqHd+boR1wtQLoUlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072475; c=relaxed/simple;
	bh=dxlMeg8yLvyobF5BZCphZMShNNgJBFWKM/5XKIOYuOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaAeybdanGCsOOt6/u6dEv/9AhckfXWdnuzqScryapdDn9UVOHnpsLBmbb/JIxEVCPX6RDxKEeCydl2btBunzrmOR1IG9A2w5PpTE8EBI3cERUq6WjbQqpaSGppugLP2+Ej7qJk3o+l0q2pMf7eIKxRXUMvnuJBWdoUENK2CMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kst1OZoT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734072474; x=1765608474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxlMeg8yLvyobF5BZCphZMShNNgJBFWKM/5XKIOYuOs=;
  b=kst1OZoTCz60LxY4u9BKSkiyUOjCr/WE4mzNcoOVmlt2VYDZC7DsANLK
   N7h6t/NBVIs7Q7ghAl/VlaumGyehNpcdqF8OhQDIkfPK9FqQnpZfSDAaj
   PQGxLzMnwY3ZLDb2gGu0P2a36W3T0+NZDMeQlbC4iZPvbD+XYEZPaINjc
   MROuWHD8W0KjC8tenm288JABlAHJnM5SdI+s6UwZCdsJS3QRSdzR67xjX
   FOjEYBF/2NUZBvPqaEYg0FE2zH9qPS3g0UIBd8oNahXfxP0c2gS9A0gLd
   xki/AuoY38B8lN7r8IpMEh0OJNUM3w8o29CWINsf6F9yIUx4kjG5jDlGc
   A==;
X-CSE-ConnectionGUID: HK/jtsyIQ5aHFIiB6IAP9g==
X-CSE-MsgGUID: iGzz6TABRXSnv/yzELjGUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45206655"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="45206655"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:47:53 -0800
X-CSE-ConnectionGUID: UIg6JalIS36H2HNE5PapfQ==
X-CSE-MsgGUID: 3BLv8ClPSyWs4NAL/sPCDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96687135"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:47:48 -0800
Message-ID: <a0e4a3e6-254b-468b-9e59-accc35b4a606@linux.intel.com>
Date: Fri, 13 Dec 2024 14:47:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Only write through identity mapping of control
 page
To: David Woodhouse <dwmw2@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/13 4:11, David Woodhouse wrote:
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

Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>

> ---
>   arch/x86/kernel/relocate_kernel_64.S | 32 +++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 553d67845b84..b9c80b3091c8 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -90,22 +90,17 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>   	movq	kexec_pa_table_page(%rip), %r9
>   	movq	%r9, %cr3
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
>   	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
>   	movq	%rcx, %r11
>   
>   	/* setup a new stack at the end of the physical control page */
> +	movq	%rsp, %rbp
>   	lea	PAGE_SIZE(%rsi), %rsp
>   
>   	/* jump to identity mapped page */
> @@ -118,6 +113,19 @@ SYM_CODE_END(relocate_kernel)
>   
>   SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	UNWIND_HINT_END_OF_STACK
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
>   	/*
>   	 * %rdi	indirection page
>   	 * %rdx start address
> @@ -185,7 +193,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 *  - Machine check exception on TDX guest, if it was enabled before.
>   	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
>   	 *
> -	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> +	 * Use R13 that contains the original CR4 value
>   	 * PAE is always set in the original CR4.
>   	 */
>   	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d


