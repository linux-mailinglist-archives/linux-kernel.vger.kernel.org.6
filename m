Return-Path: <linux-kernel+bounces-512051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB374A33365
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F281641E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A11209F55;
	Wed, 12 Feb 2025 23:32:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E41EF0B9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403164; cv=none; b=CO5gifDVbShdQ+QhUSaCKxmvPzVksS/d44nC8FphTa847heSq8/rv2MhQUI5qsKW3dx8vlSpWQqn2BTXD43e3IdWyKjVH/hl6u4SXPSncHLJNqRVkXhh6tr5H3z3evduETbV9p7SKvRLFjUoPFoigml9CDvPu4uCjHq2VHdQ2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403164; c=relaxed/simple;
	bh=2c9L7o/NOWe5sQeiJ8Ja5INnXAHyzsmTZ1faqR2gQZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzaOlTUcnq+ygHrP6k2Qn0ikXLzbQ9m9N2VxHW6zlyEeBbtaf3rEfh+aUSqepBArIyDHoR9DU4gnXlFbYsPAi1NQ6U1xI6HTYcj0kZk/NNsPf2yFu4XLY8On2KTE2xFBQIHRhNIxwANXVika7XdvauTjgXwLIHmTrRaLWSFZdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC61C4CEDF;
	Wed, 12 Feb 2025 23:32:44 +0000 (UTC)
Date: Wed, 12 Feb 2025 15:32:42 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler: remove stringification from __ADDRESSABLE_ASM()
Message-ID: <20250212233242.pnzazr3lxu3f6p6e@jpoimboe>
References: <561c52d6-9728-4dfc-a629-353dc2488c8b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <561c52d6-9728-4dfc-a629-353dc2488c8b@suse.com>

On Wed, Feb 12, 2025 at 04:11:51PM +0100, Jan Beulich wrote:
> __ADDRESSABLE_ASM_STR() is where the necessary stringification happens.
> As long as "sym" doesn't contain any odd characters, no quoting is
> required for its use with .quad / .long. In fact the quotation gets in
> the way with gas 2.25; it's only from 2.26 onwards that quoted symbols
> are half-way properly supported.
> 
> Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org
> ---
> I think that __ADDRESSABLE_ASM{,_STR}() better would have a separate
> comment, as that presently kind of shared with {_,}__ADDRESSABLE() isn't
> really applicable to assembly code.
> 
> Is data allocation actually necessary in __ADDRESSABLE_ASM()? Aiui the
> sole goal is to have sym in the symbol table. That could be achieved by
> a simple .global (or e.g. .hidden) directive.

Hm, yes, but isn't that a bug?  It shouldn't be defining the symbol, as
that will already be defined elsewhere.  So it would link to the local
symbol instead of the actual static key defined in another object.

Even worse, the local symbol gets discarded during linking?  Not sure
how that works without a linker error...

.global sounds like it would work, then we can just remove all the
__ADDRESSABLE_ASM() cruft.

> Shouldn't Xen's __ADDRESSABLE_xen_hypercall use STATIC_CALL_KEY() rather
> than open-coding it?

Indeed...

> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -245,7 +245,7 @@ static inline void *offset_to_ptr(const
>  #define __ADDRESSABLE_ASM(sym)						\
>  	.pushsection .discard.addressable,"aw";				\
>  	.align ARCH_SEL(8,4);						\
> -	ARCH_SEL(.quad, .long) __stringify(sym);			\
> +	ARCH_SEL(.quad, .long) sym;					\
>  	.popsection;
>  
>  #define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))

-- 
Josh

