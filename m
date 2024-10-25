Return-Path: <linux-kernel+bounces-381581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3769B011D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350A61F22380
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A91FDF8B;
	Fri, 25 Oct 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cV7LfZbM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7D1FBF66
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855510; cv=none; b=HeC9E37IFNVo25G7SUcqa3eE/GB+Dhw9CDdQwZDssIyB9l+77I3oYfEW3EBeWbyiZEvQk4FK7ADpADW+HvLwrxlRzenX3P85nXE4Ifz/OHb9bIE6Fe3E8EwYRgdkp1IpyubBZe17Ugx7EpHBCrElE6vOyV+Abjdhb5FOFgCXUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855510; c=relaxed/simple;
	bh=rOxsN5DBrlrawsn7kEc1lVVH45aBQniUcXKtMuS2934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFuym1gLBurXUfOj6M6tzCwQ1ijV7PLRZvyAUs4BleE6vyAFw4iLX5CNo8zv6gKPiFHGw+e6GQnJfnS14Zz2rZX+HrEbNJKlOYHwe8MNa0f8g5MR4H9jGCYZeSEcLMoxc6+cU0s6ncsBijUx9iqBUwsZ+F45eBt7buiSoSiKdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cV7LfZbM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1329340E0285;
	Fri, 25 Oct 2024 11:25:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WdqHwixGTTls; Fri, 25 Oct 2024 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729855499; bh=rscGr9593KMEaumPgugwUpRLqbkH6N54FyzA2w1Y8LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV7LfZbMGQakvGvase+QTTqi3uXQN3sr1UXc1u8+XH5sXSaeo2dnJ4IFlR1nFfkND
	 dwDNP7IXpeBD4G5oEGBHO5nlDJAmq51ZQLD/cAJWgqSWMRZDpzwcMbA9llhK6u5DUg
	 CcxjLBjnK6/6kvodSYacWNoSMmTSLFfvg/q5eM+c4jbYoKL7+NnRcXzu50wNy85sTw
	 6rKFzGt5TbY/VEJg8oehtXEyK4xRs1X8/RYx2pTJH7vhD1S1dJw3LZKKMP/WoZV2wo
	 +cNw8vDQ/amIakqt30XA4Ac7/a3DfgaROaEmE5Iss/aLITXFG35ZaPaLqmFhs1rkyu
	 h6CAGTneP/vUN0M1TPOYk16BtK4WwegAuJjeeEx79YzUrSCj+1dOa+sF1JoQDsoCat
	 9l8XH3Ypd1aLlX6hE0tJvoUObOf0n2w7u/BpPvyAprwQxWGiP3KjJIg95OncB3njzh
	 hR7IU3YEr1onn4+Xm8Bt1zBgmqOuvGdJ37p/uU/3TLqjJeuSmj6hRBiBBa0BUL6CRJ
	 xKXx0oKFrZbftKFpU8TXzxZQZBJ+7pTzPH0F6HkjloRtFcALjqDLoEeh2jWIIDeMax
	 j8YIA9kPDKphRy/oWe4+9SNj/Fw3YZxm+KCtq9ugusghiKTQm1fQKcHqgD0qqfFtWy
	 UutstdZZ/P0YWBL41ENp7B2U=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 302DB40E0192;
	Fri, 25 Oct 2024 11:24:54 +0000 (UTC)
Date: Fri, 25 Oct 2024 13:24:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241025112448.GBZxuAAD3kjAFYM_3A@fat_crate.local>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
 <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
 <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>

On Thu, Oct 24, 2024 at 11:13:35AM -0700, Linus Torvalds wrote:
> Actually, I should also just remove the "or" and move that into C
> code. It will allow the compiler to decide which way it wants to do
> the bitwise 'or', which means that the compiler can pick whichever
> output register is a better choice.
>
> Probably never matters in practice, but leaving decisions like that to
> the compiler and avoiding one more fixed asm instruction is a good
> thing.

Yap, that's the impression I've got too from talking to compiler folks over
the years.

> It does result in a few more casts on the C side, since you can't just
> do bitwise 'or' on a pointer, but I think it's still the right thing
> to do. So that thing becomes
> 
>   static inline void __user *mask_user_address(const void __user *ptr)
>   {
>         unsigned long mask;
>         asm("cmp %1,%0\n\t"
>             "sbb %0,%0"
>                 :"=r" (mask)
>                 :"r" (ptr),
>                  "0" (runtime_const_ptr(USER_PTR_MAX)));
>         return (__force void __user *)(mask | (__force unsigned long)ptr);
>   }
> 
> which I'm certainly not claiming is a thing of beauty,

Bah, 2 insns in asm and an OR in C code? That's fine.

> but the generated code looks ok if you just ignore the #APP/#NOAPP noise:
> 
>   # ./arch/x86/include/asm/uaccess_64.h:71:                "0"
> (runtime_const_ptr(USER_PTR_MAX)));
>   #APP
>   # 71 "./arch/x86/include/asm/uaccess_64.h" 1
>         mov $81985529216486895,%rax     #, __ret
>   1:
>   .pushsection runtime_ptr_USER_PTR_MAX,"a"
>         .long 1b - 8 - .        #
>         .popsection
>   # 0 "" 2
>   # lib/strncpy_from_user.c:114: {
>   #NO_APP
>         pushq   %rbx    #
>         movq    %rdi, %r9       # tmp149, dst
>         movq    %rdx, %r11      # tmp151, count
>   # ./arch/x86/include/asm/uaccess_64.h:67:       asm("cmp %1,%0\n\t"
>   #APP
>   # 67 "./arch/x86/include/asm/uaccess_64.h" 1
>         cmp %rsi,%rax   # src, mask
>         sbb %rax,%rax   # mask
>   # 0 "" 2
>   # ./arch/x86/include/asm/uaccess_64.h:72:       return (__force void
> __user *)(mask | (__force unsigned long)ptr);
>   #NO_APP
>         orq     %rax, %rsi      # mask, _44
> 
> so you actually see gcc filling in variable names etc (well "variable
> names" may be a bit generous: "_44" is a pseudo for the new value of
> src,

Hmm, how did it come up with "src"?

Oh, strncpy_from_user(). That's actually nice.

> but that's just how compilers are with SSA - assignments create a
> whole new temporary).

Right.

> So legibility is very much in the eye of the beholder. You have to be
> pretty damn used to looking at the generated asm to find any of this
> even remotely legible.

Haha, yeah. Especially if one is curious to see what the compiler spits out.

In any case, yeah, that's readable enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

