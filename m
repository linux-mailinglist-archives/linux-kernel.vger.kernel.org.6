Return-Path: <linux-kernel+bounces-379769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D247E9AE377
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742B5B21532
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6831CB9F8;
	Thu, 24 Oct 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TA6dnRK1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C41B3944
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768125; cv=none; b=J1yM/mfxY4GwZj7pmosF0QIG9h7dzOSNughQkcb+GsHzQVc6bQOO/1mkSXoKPhv3BYx8MDRBZ/dLO5w+lVCRSSdY76ZtoX3YD3Dfc8gAjaFM7NQgsMu/z3Yl9rwJxmxtEMj/mzFWlEpkmjNvjMbKTqn/10i6B9GuK4rPLBQD8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768125; c=relaxed/simple;
	bh=50PyotcpZSYMVmhqJM1ft0lu99XfnUtOsWgo7Xs4DCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAUsF6CgA8Wc/3qsauny+3FtjlbSOrBHahy8sZmeeWBLNsjImIXyMrAdJfhHf2HGP2IPa+LkBEJDDctIdGLgAQZCJnyfNe7UjV33IfZvNWpNt/ywhmmf44Pkwb7Q973pQHKbnx8/urQpi4H6kr+GycZOHz6pKeP36sERPWZmeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TA6dnRK1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 131D340E0285;
	Thu, 24 Oct 2024 11:08:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 89HJWMkgiQb2; Thu, 24 Oct 2024 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729768114; bh=P40tq+4GGt+XVwRPrmS8lbtdxP5D3LEpF3/Kzt1RpZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA6dnRK17A++gP1xFU/zNeE1DK9YU3uaKf3XA4yVqakHRhkiY7h9aheZHsqOowW/V
	 JMwoZIg1KBlT8fUCk31UyICmIRrJjNl3BzRrRWgEYQqly4dF1LfkzznGdeftYqx0vc
	 FojLj4za+pOY3FsxaHlHugpDFSssBYqNRI693lFqg+L/iusldAuyJPPXniuHCd3fOD
	 BNbxO+TVGI+0NntScdFwD4J/HozfO+gplfP0rMdZGrDsYrG8/sBnRLZ9xPIVWmyBJB
	 /LR2ehPTvIfQV7Q5aJc3ZrnhNSlFwPswfSVIOvXIjPA9WhLfn0/Oj2H+RWJpNeDb7b
	 8NtL0i6vE+EHtcNAZHOIfhSCCF4TsRC2sd8v4F98p/I7ICYo8D2ag6ikA9p4BfsJjP
	 6dd/SIshA81JajAu2+23E1D2b5fzaP9XTU43DIOpkSbbIWtZpMfCZNJ9FSa948dVf+
	 4z6VJ4mNeqEQsJ/CpNg4+mEhs8LMBW82E8YGVsI8CU8ay46+k833TEFcoYfK4iGEdw
	 t3jkvje1undl0JjAFrpAwXUbxdSclxBa1PZA2p6s0tjFYVjY30d2DUcjg6h/tLMoXy
	 BQTTEu2yLwVm51or2ApU+r/puvCBb233wErMAihkdrf8pizenVBF66kT9/WFw6IrXm
	 i3XqBCRpFhIg7GMnlbdc7FSQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4CF140E0198;
	Thu, 24 Oct 2024 11:08:28 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:08:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024013214.129639-1-torvalds@linux-foundation.org>

On Wed, Oct 23, 2024 at 06:31:59PM -0700, Linus Torvalds wrote:
> +static inline void __user *mask_user_address(const void __user *ptr)
> +{
> +	void __user *ret;
> +	asm("cmp %1,%0; sbb %0,%0; or %1,%0"
> +		:"=r" (ret)
> +		:"r" (ptr),
> +		 "0" (runtime_const_ptr(USER_PTR_MAX)));
> +	return ret;
> +}

Can we make this more readable pls?

Something like this:

static inline void __user *mask_user_address(const void __user *ptr)
{       
        void __user *ret;

        asm("cmp %[ptr],%[ret]\n\t"
            "sbb %[ret],%[ret]\n\t"
            "or  %[ptr],%[ret]"
                : [ret] "=r" (ret)
                : [ptr] "r" (ptr),
                  "0" (runtime_const_ptr(USER_PTR_MAX)));

        return ret;
}

This way the compiler-generated asm is more readable too due to the newlines
and tabs.

In any case, it looks good, I single-stepped strnlen_user() and I got:

# move the constant
movabs $0x7ffffffff000,%rdi

# the user pointer: rax = 0x7ffcb6839fdf
cmp    %rax,%rdi

sbb    %rdi,%rdi
# rdi = 0x0

or     %rax,%rdi
# rdi = 0x7ffcb6839fdf

stac

and user pointer is in %rdi.

Then, on the next breakpoint, I modified the user pointer:

gdb> set $rax = 0xfffcb6839fd9
cmp    %rax,%rdi

sbb    %rdi,%rdi
# rdi = 0xffffffffffffffff  -1

# flags are set
eflags         0x297               [ IOPL=0 IF SF AF PF CF ]

or     %rax,%rdi

# user pointer is -1, do_strnlen_user() will try to work with -1 and fault...

> @@ -2389,6 +2390,15 @@ void __init arch_cpu_finalize_init(void)
>  	alternative_instructions();
>  
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> +		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
> +
> +		/*
> +		 * Enable this when LAM is gated on LASS support
> +		if (cpu_feature_enabled(X86_FEATURE_LAM))
> +			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> +		 */
> +		runtime_const_init(ptr, USER_PTR_MAX);

Looking at Documentation/arch/x86/x86_64/mm.rst, 5 level page tables define
USR_PTR_MAX as 0x00ffffffffffffff, i.e., bits [55:0].

So I guess that USER_PTR_MAX needs to look at X86_FEATURE_LA57, no?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

