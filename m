Return-Path: <linux-kernel+bounces-567010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF2A67FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BED817F1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CAF202971;
	Tue, 18 Mar 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVI8J6/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E61AF0B4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336978; cv=none; b=XaB4FB8J2ifa2mmk+x2+vRvXFg6nw109UaiDal5qq4WwelNmr+tsQXt4q6vliOWemFKoTJ6MpBcmxuOm/IA45xqav5XqeMF1tddaVmx7GbeKfez2t+V4gWOHIOjxgqC6qU4sxR+SKWL7JcHQyTwtXNUaoUg3bnQU6e0aLrJaxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336978; c=relaxed/simple;
	bh=oTP/Fl6LqMcu8vagM5EziDbzt0IZ1VCnJ4i1f5Xu8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afZEoJ6XFiEaNT6hz5mvVzTroXqscx/GA1fLZ5Vx7bjhdFvTqiMYxZdBdkw8ofGDTcnT26Br/uEmGeHfZiG61HoDAnfYYP0zeAkxgoN0nFdzCmW684UtD8iRLbyQeTjzRSXT2eH6QZMm0AKi3xwdB3kyR+ovof93h1BcQ0v9Tmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVI8J6/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B02C4CEDD;
	Tue, 18 Mar 2025 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742336977;
	bh=oTP/Fl6LqMcu8vagM5EziDbzt0IZ1VCnJ4i1f5Xu8Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVI8J6/+sdEZ4Q/VV/OkIM7Bajz1FoEp5pBMO3ylnGmEp7pvjNhLXQx+qMrKVW28Z
	 R3S/dJ+/qiqW7WNGHQSb215DqClRGWuZ+n7AybXz6BqF+l9MJRZVNkxDgTnitrvzbe
	 C8ToDW+YrcUtrP0KqiOQpQ+O1/9KQ1Uv8LIpQUuOyEdnYgY9qd7//iz5EwxIOXhW9M
	 cruJCHfUMV5ElFf1m+0G3YBw7LEjAIFvD/u7akyyFXYNIWbG2nY07DTW1R678SGn9H
	 c6lAQwUcWrb7FD2gOlEP8JVzjLWQTF8M/0/GYs3zjDafKStYN/svERwhUornWii2tp
	 Ivtdex55gDNKA==
Date: Tue, 18 Mar 2025 15:29:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <6n4x75ounp3uvpy46ezejoyhteelkodq3ailpqcpheimeoqjpz@hr57al3q2ok2>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
 <20250317200432.1a076d6a@pumpkin>
 <rvrdr6yefc6fbbsuhamf7ri4nlrxvmafcqpmgg6duwpj2blhad@a2wrcdspyvip>
 <20250318220605.6ac40f6d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318220605.6ac40f6d@pumpkin>

On Tue, Mar 18, 2025 at 10:06:05PM +0000, David Laight wrote:
> > > So with:
> > > #define __asm_call(qual, alt, out, in, clobber) \
> > > 	asm("zzz", ARG out, ARG in, ARG clobber)
> > > 
> > > __asm_call(qual, ALT(), \
> > > 		([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
> > > 		    "+d" (old__.high)),					\
> > > 		("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
> > > 		("memory"));
> > > 
> > > would get expanded the same as the line below.  
> > 
> > Interesting idea, though I still prefer the self-documenting ASM_OUTPUT
> > / ASM_INPUT / ASM_CLOBBER macros which are self-documenting and make it
> > easier to read and visually distinguish the constraint lists.
> 
> Except that non of this really makes it easier to get out/in in the correct
> order or to use the right constraints.

At least it's still no worse than asm() itself in that respect.

> So are you just adding 'syntactic sugar' for no real gain?

Some wrappers need to modify their constraint lists, so the sugar does
have a functional purpose.  The new alternative_io() (or whatever it
will be called) interface will especially be needed for the followup to
this patch set which introduces asm_call() to try to fix an
ASM_CALL_CONSTRAINT mess.

> Looking back at one of the changes:
> -#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
> -				      X86_FEATURE_XMM2) ::: "memory", "cc")
> +#define mb() alternative_io("lock addl $0,-4(%%esp)",			\
> +			    "mfence", X86_FEATURE_XMM2,			\
> +			    ARG(),					\
> +			    ARG(),					\
> +			    ARG("memory", "cc")) 
> 
> is it really an improvement?

The motivation here is to use the alternative*() wrappers whenever
possible.  It helps achieve consistent behaviors and also removes the
ugly nested ALTERNATIVE() macro.

In fact, the change in your example actually improves code generation:
it changes the asm() to asm_inline() which prevents GCC from doing crazy
things due to the exploded size of the asm string.

-- 
Josh

