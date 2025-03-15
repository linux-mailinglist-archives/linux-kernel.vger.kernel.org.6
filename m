Return-Path: <linux-kernel+bounces-562499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1A4A629B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3653AEC8A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BC1D8E01;
	Sat, 15 Mar 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6wNpYGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3218DB10
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030054; cv=none; b=jyV5KbtQe57HpslZDEs4oqCw2bgsSCt6FQXhL3po+/9QskgEAHarQWDsNPQL17UZ1rqktWLZjugbjdylFPx8XTUHcSb0dyCySDK9RCxYI49emA8dueLqXXBVKSNHp3NG0spjaFFmGxIGgjiia8RTV1dLiNmTZl+9WmQ8jSz4u8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030054; c=relaxed/simple;
	bh=0uZeP+VNZohIP1anPEx6+VekExDunIBoOTEhdeUpMVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVdxZtCQaWIja9nkUHlReFLv7YBw/jo3je2Q1ZhODXhqhkHfsRsk5cxn4xirM6Y88zIIs0+R5ZFM27Ij/HgjeMWH9Y4ZYBsmP0YCdyga8mc7kbqLY9EmShiWmw0y8N9i4j0NtJ3pflIbQQOeURp9ewwUeY5sXenJ3JF6sN+DUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6wNpYGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F514C4CEE5;
	Sat, 15 Mar 2025 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742030053;
	bh=0uZeP+VNZohIP1anPEx6+VekExDunIBoOTEhdeUpMVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6wNpYGu4YenJ4gtWUzQA0xN45qKQk9HEyqMYm/N/AAB1Mz9spfG301OaHF485+0J
	 bTVvFkaK5iYsb9acK+ljgmOSxaOxRzXXRkB6UkqHV+v+g0oCGVIB75EHz0VqJefSO5
	 NbuVuffD4cyg9qXUiKnglKTE3afv+6mlDjgqMwVL310muWMbatUeXoJd5nhEwS+55U
	 uvf0aTgRlx6+Hmv/WK9lryYZPiYAseDy1pmbDhROtEgaoJ9eUtw1jqwC5+V16VSRAw
	 9rNh/1WA9AY0aLndnl+af5CUlSoF+X7lGrJoOfQ9hhLmVSai3FcK8zANJAfnsNBRUr
	 oLxOpfydXDVNA==
Date: Sat, 15 Mar 2025 10:14:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <Z9VE4Ls0vTJDeDMR@gmail.com>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Fri, Mar 14, 2025 at 01:49:48PM -1000, Linus Torvalds wrote:
> > So all of these patches look like good cleanups to me, but I do wonder
> > if we should
> > 
> >  (a) not use some naming *quite* as generic as 'ARG()'
> > 
> >  (b) make the asms use ARG_OUT/ARG_IN/ARG_CLOBBER() to clarify
> > 
> > because that ARG(), ARG(), ARGC() pattern looks odd to me.
> > 
> > Maybe it's just me.
> > 
> > Regardless, I do think the series looks like a nice improvement even
> > in the current form, even if that particular repeated pattern feels
> > strange.
> 
> So originally I had ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER, but I ended up
> going with ARG() due to its nice vertical alignment and conciseness:
> 
> 
> 	__asm_call(qual,						\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]),		\
> 			    X86_FEATURE_CX8),				\
> 		ARG([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
> 		    "+d" (old__.high)),					\
> 		ARG("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
> 		ARG("memory"));						\

Two nits:

1)

In justified cases we can align vertically just fine by using spaces:

  ASM_INPUT  ([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low)...
  ASM_OUTPUT ("b" (new__.low), "c" (new__.high), "S" (&(_var))),
  ASM_CLOBBER("memory")

But I don't think the vertical alignment of visually disjoint, 
comma-separated arguments is an improvement in this specific case.

A *truly* advanced typographically aware syntactic construct would be 
something like:

		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
			    "cmpxchg8b " __percpu_arg([var]),		\
			    X86_FEATURE_CX8),				\
									\
		  ASM_INPUT( [var] "+m" (__my_cpu_var(_var)),		\
				   "+a" (old__.low),			\
				   "+d" (old__.high)),			\
									\
		  ASM_OUTPUT(       "b" (new__.low),			\
				    "c" (new__.high),			\
				    "S" (&(_var))),			\
									\
		  ASM_CLOBBER(	    "memory"));

Note how horizontal and vertical grouping improves readability by an 
order of magnitude and properly highlights the only named operand and 
makes it very easy to review this code, should it be a new submission 
(which it isn't).

And as Knuth said, the intersection of the sets of good coders and good 
typographers is necessarily a tiny percentage of humanity 
(paraphrased), but I digress ...

2)

If 'ARGS' is included in the naming then I'd like to insist on the 
plural 'ARGS', not 'ARG', because the common case for more complicated 
asm() statements is multiple asm template constraint arguments 
separated by commas.

But I don't think we need the 'ARGS':

> Though ASM_OUTPUT/ASM_INPUT/ASM_CLOBBER isn't so bad either:
> 
> 	__asm_call(qual,						\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]),		\
> 			    X86_FEATURE_CX8),				\
> 		ASM_OUTPUT([var] "+m" (__my_cpu_var(_var)),		\
> 			   "+a" (old__.low), "+d" (old__.high)),	\
> 		ASM_INPUT("b" (new__.low), "c" (new__.high),		\
> 			  "S" (&(_var))),				\
> 		ASM_CLOBBER("memory"));					\
> 
> 
> That has the nice benefit of being more self-documenting, albeit more
> verbose and less vertically aligned.
> 
> So I could go either way, really.

I'd vote on:

	ASM_INPUT(),
	ASM_OUTPUT(),
	ASM_CLOBBER()

... because the ASM_ prefix is already unique enough visually to reset 
any cross-pollination from other well-known namespaces, and because in 
coding shorter is better, all other things equal.

Thanks,

	Ingo

