Return-Path: <linux-kernel+bounces-196980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBB8D648D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7FA1C238FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825336AF8;
	Fri, 31 May 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrabWhkT"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EC539AE3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165837; cv=none; b=dfNywXK1W71zNDgj5Z7sdMmTeXJgM88Y/kyEeBBEruE83qZpl7A2y34q8ndNm+eZNQ6Jms5exwRhTS0y/ulPooZgehudiWvwV06ir2Emz697SW3ZKwyvUJSWJCpioP3F6kjGMPu20w7Ce2xRpOH/Mrh40h9LXA07q8Lbtz42ASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165837; c=relaxed/simple;
	bh=ywj04P5Dn5JvXrMnyzC4fX5vp85Na6eQunWRydP+Cmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObFYnSODAFFaON1xp8QUBnAg0x5/Ueugp224IJ6fDgIcN3mS2cHRtmUyIgoM3UY0DoeoWlI2g75OL4jfA3HdKfI6WZopNvzFi3SITkZl0Cot2dIUZb4RLGyd8IJ31am5+PIbgfbMMQaCZG+kSHPt55QraCItL0unsxunVZWe3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrabWhkT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6893c33403so35741966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717165833; x=1717770633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWMyr9kO005m3g0tLgaFAeospX6jl2/YpDwLN0vxN1A=;
        b=WrabWhkTQyp19Yi/e7mx1XJUHb3KXMbQ3GW6euT61wKJDqHT5TXJS2KJKbePVy3eFh
         c/FBwL761PcW2S/2RuPIDPU9wB0ET94EzjpNE/VWVDDcvWHvXJjkzHniGscBcMjrSJfK
         7IcZ9548jZGSL7JSHCJfUsslLR1dChaKUDUbC+CPwPX7l1ozSNc1YW1JHlCYWwcgzxrT
         ZeKkL38VMXh/vX0QZJI8Wi+r8YviwVx2QzE13F++cHZIr83ASTm9uR1MsrdAquQqPyBp
         OKESQaCODxBfGhhD8nollAeeDK9tOq4riefJT0xGPxrzWW36WGsL1xlg91dVKM/dSv9y
         BzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165833; x=1717770633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWMyr9kO005m3g0tLgaFAeospX6jl2/YpDwLN0vxN1A=;
        b=aPYtYcroGBzsfiQzGhf169f6BGY2w+JwBR4IX/8rrf8TJpJoWrT/Mx4tdDI61BAA0o
         ylwxzrtjdcnwU0u675uZPB7fI/tcc8rutw7Aumcg+TLJxWaz7EyWJYW46OnreqCyZcrP
         dGEvai576tmmKyna2qR9KQP29gxGwBTm6aePbDZdUSM6Vt7d2m+IMzkTQhTIytkORjH3
         ib90gpHc+dyeNiCpoCTFzJgENrgde0kAx1t37RJY2xDuyqhJX7MhW8gJHWKJhlsLk+vn
         jJLUpuyrAqgem3eaVCZ/ps9wg42pZbL8OM7G9eFNPrIiRrIdAsa/uUXj02Me+FQg6txd
         8aIw==
X-Gm-Message-State: AOJu0YytAGr0fob0gzSlSxkp8e9e6b+edDnTVHV3j5ykpi8DiJnTFQab
	6Rrrt468qbyg5rjVmJuBAa7/nu3VPuT7WENYYLTW2jB/BXKakcVd
X-Google-Smtp-Source: AGHT+IEx02FRIqAYUpOGo6CvkrCi6kK/JIj2G0dg2Yv+DMdWpyi4Z5QkfQsOxwfpyoN/HztFDdmTzQ==
X-Received: by 2002:a17:906:3e8f:b0:a65:c143:b3d3 with SMTP id a640c23a62f3a-a681fc5d5b7mr164667166b.3.1717165832948;
        Fri, 31 May 2024 07:30:32 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f03b50sm93305066b.28.2024.05.31.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:30:32 -0700 (PDT)
Message-ID: <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>
Date: Fri, 31 May 2024 16:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/14] x86/alternatives: Add nested alternatives macros
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-3-bp@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240531123512.21427-3-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of making increasingly complicated ALTERNATIVE_n()
> implementations, use a nested alternative expression.
> 
> The only difference between:
> 
>    ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> 
> and
> 
>    ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
>                newinst2, flag2)
> 
> is that the outer alternative can add additional padding when the inner
> alternative is the shorter one, which then results in
> alt_instr::instrlen being inconsistent.
> 
> However, this is easily remedied since the alt_instr entries will be
> consecutive and it is trivial to compute the max(alt_instr::instrlen) at
> runtime while patching.
> 
> Specifically, after this the ALTERNATIVE_2 macro, after CPP expansion
> (and manual layout), looks like this:
> 
>    .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
>    740:
>    740: \oldinstr ;
>    741: .skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90 ;
>    742: .pushsection .altinstructions,"a" ;
>    	altinstr_entry 740b,743f,\ft_flags1,742b-740b,744f-743f ;
>    .popsection ;
>    .pushsection .altinstr_replacement,"ax" ;
>    743: \newinstr1 ;
>    744: .popsection ; ;
>    741: .skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90 ;
>    742: .pushsection .altinstructions,"a" ;
>    altinstr_entry 740b,743f,\ft_flags2,742b-740b,744f-743f ;
>    .popsection ;
>    .pushsection .altinstr_replacement,"ax" ;
>    743: \newinstr2 ;
>    744: .popsection ;
>    .endm
> 
> The only label that is ambiguous is 740, however they all reference the
> same spot, so that doesn't matter.
> 
> NOTE: obviously only @oldinstr may be an alternative; making @newinstr
> an alternative would mean patching .altinstr_replacement which very
> likely isn't what is intended, also the labels will be confused in that
> case.
> 
>    [ bp: Debug an issue where it would match the wrong two insns and
>      and consider them nested due to the same signed offsets in the
>      .alternative section and use instr_va() to compare the full virtual
>      addresses instead.
> 
>      - Use new labels to denote that the new, nested
>      alternatives are being used when staring at preprocessed output. ]
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lkml.kernel.org/r/20230628104952.GA2439977@hirez.programming.kicks-ass.net
> ---
>   arch/x86/include/asm/alternative.h | 110 ++++++++++++++++++++++++++++-
>   arch/x86/kernel/alternative.c      |  20 +++++-
>   tools/objtool/arch/x86/special.c   |  23 ++++++
>   tools/objtool/special.c            |  16 ++---
>   4 files changed, 158 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 6db78909180a..8554c2c339ff 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -161,8 +161,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   
>   #define alt_end_marker		"663"
>   #define alt_slen		"662b-661b"
> +#define n_alt_slen		"772b-771b"
> +
>   #define alt_total_slen		alt_end_marker"b-661b"
> +#define n_alt_total_slen	"773b-771b"
> +
>   #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
> +#define n_alt_rlen		"775f-774f"
>   
>   #define OLDINSTR(oldinstr, num)						\
>   	"# ALT: oldnstr\n"						\
> @@ -172,6 +177,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
>   	alt_end_marker ":\n"
>   
> +#define N_OLDINSTR(oldinstr)						\
> +	"# N_ALT: oldinstr\n"						\
> +	"771:\n\t" oldinstr "\n772:\n"					\
> +	"# N_ALT: padding\n"						\
> +	".skip -(((" n_alt_rlen ")-(" n_alt_slen ")) > 0) * "		\
> +		"((" n_alt_rlen ")-(" n_alt_slen ")),0x90\n"		\
> +	"773:\n"
> +
>   /*
>    * gas compatible max based on the idea from:
>    * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
> @@ -209,10 +222,25 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	" .byte " alt_total_slen "\n"			/* source len      */ \
>   	" .byte " alt_rlen(num) "\n"			/* replacement len */
>   
> +#define N_ALTINSTR_ENTRY(ft_flags)					      \
> +	".pushsection .altinstructions,\"a\"\n"				      \
> +	" .long 771b - .\n"				/* label           */ \
> +	" .long 774f - .\n"				/* new instruction */ \
> +	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
> +	" .byte " n_alt_total_slen "\n"			/* source len      */ \
> +	" .byte " n_alt_rlen "\n"			/* replacement len */ \
> +	".popsection\n"
> +
>   #define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
>   	"# ALT: replacement " #num "\n"						\
>   	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
>   
> +#define N_ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
> +	".pushsection .altinstr_replacement, \"ax\"\n"				\
> +	"# N_ALT: replacement\n"						\
> +	"774:\n\t" newinstr "\n775:\n"						\
> +	".popsection\n"
> +
>   /* alternative assembly primitive: */
>   #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
>   	OLDINSTR(oldinstr, 1)						\
> @@ -223,6 +251,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	ALTINSTR_REPLACEMENT(newinstr, 1)				\
>   	".popsection\n"
>   
> +/* Nested alternatives macro variant */
> +#define N_ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
> +	N_OLDINSTR(oldinstr)						\
> +	N_ALTINSTR_ENTRY(ft_flags)					\
> +	N_ALTINSTR_REPLACEMENT(newinstr)
> +
>   #define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
>   	OLDINSTR_2(oldinstr, 1, 2)					\
>   	".pushsection .altinstructions,\"a\"\n"				\
> @@ -234,11 +268,21 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
>   	".popsection\n"
>   
> +#define N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
> +	N_ALTERNATIVE(N_ALTERNATIVE(oldinst, newinst1, flag1),		\
> +		      newinst2, flag2)
> +
>   /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
>   #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
>   	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
>   		      newinstr_yes, ft_flags)
>   
> +/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
> +#define N_ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
> +	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
> +		      newinstr_yes, ft_flags)
> +
> +
>   #define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
>   			newinsn3, ft_flags3)				\
>   	OLDINSTR_3(oldinsn, 1, 2, 3)					\
> @@ -253,6 +297,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
>   	".popsection\n"
>   
> +
> +#define N_ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
> +		      newinst3, flag3)					\
> +	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
> +		      newinst3, flag3)
> +
>   /*
>    * Alternative instructions for different CPU types or capabilities.
>    *
> @@ -271,6 +321,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
>   	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
>   
> +#define n_alternative(oldinstr, newinstr, ft_flags)			\
> +	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
> +
> +#define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
> +	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
> +
>   /*
>    * Alternative inline assembly with input.
>    *
> @@ -288,11 +344,24 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
>   		: output : "i" (0), ## input)
>   
> +#define n_alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
> +	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
> +		: output : "i" (0), ## input)
> +
> +
>   /* Like alternative_io, but for replacing a direct call with another one. */
>   #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
>   	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
>   		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
>   
> +#define n_alternative_input(oldinstr, newinstr, ft_flags, input...)	\
> +	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
> +		: : "i" (0), ## input)
> +
> +#define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
> +	asm_inline volatile (N_ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
> +		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)

Please don't resurrect the %P modifier, use %c instead.

> +
>   /*
>    * Like alternative_call, but there are two features and respective functions.
>    * If CPU has feature2, function2 is used.
> @@ -307,6 +376,15 @@ static inline int alternatives_text_reserved(void *start, void *end)
>   		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
>   		  [new2] "i" (newfunc2), ## input)
>   
> +#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
> +			   output, input...)				      \
> +	asm_inline volatile (N_ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
> +		"call %P[new2]", ft_flags2)				      \
> +		: output, ASM_CALL_CONSTRAINT				      \
> +		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
> +		  [new2] "i" (newfunc2), ## input)

Here too, %P should be avoided in favor of %c.

Uros.

> +
>   /*
>    * use this macro(s) if you need more than one output parameter
>    * in alternative_io
> @@ -403,6 +481,27 @@ void nop_func(void);
>   	.popsection
>   .endm
>   
> +#define __N_ALTERNATIVE(oldinst, newinst, flag)				\
> +740:									\
> +	oldinst	;							\
> +741:									\
> +	.skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90	;\
> +742:									\
> +	.pushsection .altinstructions,"a" ;				\
> +	altinstr_entry 740b,743f,flag,742b-740b,744f-743f ;		\
> +	.popsection ;							\
> +	.pushsection .altinstr_replacement,"ax"	;			\
> +743:									\
> +	newinst	;							\
> +744:									\
> +	.popsection ;
> +
> +
> +.macro N_ALTERNATIVE oldinstr, newinstr, ft_flags
> +	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
> +.endm
> +
> +
>   #define old_len			141b-140b
>   #define new_len1		144f-143f
>   #define new_len2		145f-144f
> @@ -417,7 +516,6 @@ void nop_func(void);
>   #define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
>   #define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
>   
> -
>   /*
>    * Same as ALTERNATIVE macro above but for two alternatives. If CPU
>    * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
> @@ -445,6 +543,11 @@ void nop_func(void);
>   	.popsection
>   .endm
>   
> +.macro N_ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
> +	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
> +		      \newinstr2, \ft_flags2)
> +.endm
> +
>   .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
>   140:
>   	\oldinstr
> @@ -470,6 +573,11 @@ void nop_func(void);
>   	.popsection
>   .endm
>   
> +.macro N_ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
> +	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
> +		      \newinstr3, \ft_flags3)
> +.endm
> +
>   /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
>   #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
>   	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 89de61243272..37596a417094 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -432,6 +432,11 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
>   	return 5;
>   }
>   
> +static inline u8 * instr_va(struct alt_instr *i)
> +{
> +	return (u8 *)&i->instr_offset + i->instr_offset;
> +}
> +
>   /*
>    * Replace instructions with better alternatives for this CPU type. This runs
>    * before SMP is initialized to avoid SMP problems with self modifying code.
> @@ -447,7 +452,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>   {
>   	u8 insn_buff[MAX_PATCH_LEN];
>   	u8 *instr, *replacement;
> -	struct alt_instr *a;
> +	struct alt_instr *a, *b;
>   
>   	DPRINTK(ALT, "alt table %px, -> %px", start, end);
>   
> @@ -473,7 +478,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>   	for (a = start; a < end; a++) {
>   		int insn_buff_sz = 0;
>   
> -		instr = (u8 *)&a->instr_offset + a->instr_offset;
> +		/*
> +		 * In case of nested ALTERNATIVE()s the outer alternative might
> +		 * add more padding. To ensure consistent patching find the max
> +		 * padding for all alt_instr entries for this site (nested
> +		 * alternatives result in consecutive entries).
> +		 */
> +		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
> +			u8 len = max(a->instrlen, b->instrlen);
> +			a->instrlen = b->instrlen = len;
> +		}
> +
> +		instr = instr_va(a);
>   		replacement = (u8 *)&a->repl_offset + a->repl_offset;
>   		BUG_ON(a->instrlen > sizeof(insn_buff));
>   		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
> diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
> index 4134d27c696b..4ea0f9815fda 100644
> --- a/tools/objtool/arch/x86/special.c
> +++ b/tools/objtool/arch/x86/special.c
> @@ -9,6 +9,29 @@
>   
>   void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
>   {
> +	static struct special_alt *group, *prev;
> +
> +	/*
> +	 * Recompute orig_len for nested ALTERNATIVE()s.
> +	 */
> +	if (group && group->orig_sec == alt->orig_sec &&
> +	             group->orig_off == alt->orig_off) {
> +
> +		struct special_alt *iter = group;
> +		for (;;) {
> +			unsigned int len = max(iter->orig_len, alt->orig_len);
> +			iter->orig_len = alt->orig_len = len;
> +
> +			if (iter == prev)
> +				break;
> +
> +			iter = list_next_entry(iter, list);
> +		}
> +
> +	} else group = alt;
> +
> +	prev = alt;
> +
>   	switch (feature) {
>   	case X86_FEATURE_SMAP:
>   		/*
> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> index 91b1950f5bd8..097a69db82a0 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -84,6 +84,14 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
>   						  entry->new_len);
>   	}
>   
> +	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
> +	if (!orig_reloc) {
> +		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
> +		return -1;
> +	}
> +
> +	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
> +
>   	if (entry->feature) {
>   		unsigned short feature;
>   
> @@ -94,14 +102,6 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
>   		arch_handle_alternative(feature, alt);
>   	}
>   
> -	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
> -	if (!orig_reloc) {
> -		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
> -		return -1;
> -	}
> -
> -	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
> -
>   	if (!entry->group || alt->new_len) {
>   		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
>   		if (!new_reloc) {

