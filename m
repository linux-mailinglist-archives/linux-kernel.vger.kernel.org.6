Return-Path: <linux-kernel+bounces-417730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BA9D5876
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCFB221A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325861FD8;
	Fri, 22 Nov 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSTXFiP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF523098F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245079; cv=none; b=qqhJCnJHbQgBRriICxelmgMlrbXZayT4AEaIeS6hLme8NlOp5HNdOzL95AAt+FgYBuxM0ED63z0tgIHZk7pCXw6hR+ebvljvOcercI5ugshbHKUSIswGoZXD80wYme5FnsmNdur+UJPZmGSrwslsZ7gDOPJThUiD3JZuKX0QIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245079; c=relaxed/simple;
	bh=IUhxd0IcT2Lj2KpR6+uvQi+ilwU7y5ewL8ZEtVXyC5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btm/8BnvvHCy1XlgK972EKsgUUu3ktRqP0vF3XMDYnlZusz8nSPkoebOQrfgXR2Y+5FcBv1YUeNb53vMj1xdKK3JLklcZte7QtjHd9wtpTaF8PVaML70wdrxE7AiqCBOkkad73l9OXnYjUYnNu+yrX1aTUbF3eeKwSrzPwkB7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSTXFiP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C0C4CECC;
	Fri, 22 Nov 2024 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732245078;
	bh=IUhxd0IcT2Lj2KpR6+uvQi+ilwU7y5ewL8ZEtVXyC5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSTXFiP68Ry5QJ3h+0r3JOvjC2xO5B+9MVz+QGA8uO6TmiMPg509cnS0jgXHZS70p
	 +AkCrOexC4/DgwAIFlh2wH8TlK9AjhIn7mWJq8v6MDNQic/8dFUszmRTTjbBpwpBe/
	 2iTV9XeM4EPmZT+accttHkQLOWwCsAz/Y/XivdN9QWn+YJpuRtkFncgHMJOGfCpyi+
	 GKGJVJc2JcTyzRHB2iBR8b2srdrb/cKtWrylQBmQOv45Q5Jmoj3SBKpk/lO1nx8V9j
	 k24gi9wzR2pSrQUbiEo4cUjeKD1pGUiA8rpZB54nB7bv35v+irQy9XKTE/kah5XSlF
	 fr897EDCVSwjQ==
Date: Thu, 21 Nov 2024 19:11:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Message-ID: <20241122031115.5aasuktqrp2sidfj@jpoimboe>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
 <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe>
 <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe>
 <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>

On Thu, Nov 21, 2024 at 05:02:06PM -0800, Linus Torvalds wrote:
> [ Time passes ]
> 
> Ugh. I tried it. It looks like this:
> 
> #define inlined_get_user(res, ptr) ({                           \
>         __label__ fail2, fail1;                                 \
>         __auto_type __up = (ptr);                               \
>         int __ret = 0;                                          \
>         if (can_do_masked_user_access())                        \
>                 __up = masked_user_access_begin(__up);          \
>         else if (!user_read_access_begin(__up, sizeof(*__up)))  \
>                 goto fail1;                                     \
>         unsafe_get_user(res, ptr, fail2);                       \
>         user_access_end();                                      \
>         if (0) {                                                \
> fail2:  user_access_end();                                      \
> fail1:  __ret = -EFAULT;                                        \
>         }                                                       \
>         __ret; })

That actually doesn't seem so bad, it's easy enough to follow the logic.
And it contains the ugly/fidgety all in one place so the callers' hands
don't have to get dirty.

We could easily use that macro in size-specific inline functions
selected by a macro with a sizeof(type) switch statement -- not so bad
IMO if they improve code usage and generation.

So all the user has to do is get_user_new_and_improved() -- resolving to
get_user_new_and_improved_x() -- and the compiler decides on the
inlining.  Which on average is hopefully better than Joe Developer's
inlining decisions?  Otherwise we've got bigger problems?

Then all the arches have to do is implement unsafe_*_user_{1,2,4,8} and
the "one good implementation" idea comes together?

BTW, looking at some other arches, I notice that get_user() is already
unconditionally inline for arm64, riscv, powerpc, and s390.

I also see that arm64 already defines get_user() to __get_user(), with
__get_user() having an access_ok().

It would be really nice to have the same behavior and shared code across
all the arches.

-- 
Josh

