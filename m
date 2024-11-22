Return-Path: <linux-kernel+bounces-417609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563F9D5691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013E2282B61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3EEC4;
	Fri, 22 Nov 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPvBLq/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD9625
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234348; cv=none; b=fYqENsvmrMBe6K0ICxg/akWWtro3+F6+UffySd7YDvTuIYB1Fyd0JOkRKnV01i64SEdoGp9lumtr0g13HZZ/Z+QTr1sAh9N1YRyBwsgRXNlYC14mJQoWStII/UwWBb6O4qOrQFVS/zgfdawrNjwlsFelJr4g85OrJ13TGDiqKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234348; c=relaxed/simple;
	bh=2bFBvlIANNzsnG/eRsTTpVDynDBFhvmqfTYpO+NZfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqvGtx1vkabP52smTVViHTnya6DNRBb8XAo/ambp5oC/QfFn8U93M32qV6Hj8I9LAEt7An8dx+fFmNXAueiNCAWEY744+jC6sebS2lvurgzp80+KJ0eGoZjFdhc4hw3kvnTXAUqG5asuzgu1HXcaOvGDRAVtlrfJ16bUtgdFSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPvBLq/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC93C4CECC;
	Fri, 22 Nov 2024 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732234345;
	bh=2bFBvlIANNzsnG/eRsTTpVDynDBFhvmqfTYpO+NZfkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPvBLq/tcrhkeqbB0/yVI/tV87vKr2sAGORr2D8/7v7r7psgNnkWrRvsPMYebv6B2
	 15ElUn+MQL4/txvkJztS1pG4/PTqHZ25X7wEF75z0NtuJ8AhSqgxRgz/iNjTzVHmfj
	 +7tCWlKvdv4+8JeotVLkfoKkXJ5C0a0rXTS6ySeSTjs4b4ZiSqvBgQ619jtBtkjAHt
	 4YketKrp4iZOdc6kmaiMWZ92avl2P3NJdvei+7Bjmp69wv7cXYrVxtU9KxEbEIJzM9
	 Oh11rkkHbJnHNHlktaJU8sn665wD8gti5WM3rn681061IaA3SISQH3bSasqZW4AxnE
	 fgaZSQpXRci9A==
Date: Thu, 21 Nov 2024 16:12:23 -0800
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
Message-ID: <20241122001223.t4uywacusrplpefq@jpoimboe>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
 <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe>
 <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>

On Thu, Nov 21, 2024 at 02:16:12PM -0800, Linus Torvalds wrote:
>     mov    %gs:0x0,%rax                 # current
>     incl   0x1a9c(%rax)                 # current->pagefault_disable++
>     movabs $0x123456789abcdef,%rcx      # magic virtual address size
>     cmp    %rsi,%rcx                    # address masking
>     sbb    %rcx,%rcx
>     or     %rsi,%rcx
>     stac                                # enable user space acccess
>     mov    (%rcx),%ecx                  # get the value
>     clac                                # disable user space access
>     decl   0x1a9c(%rax)                 # current->pagefault_disable--
>     mov    %ecx,(%rdi)                  # save the value
>     xor    %eax,%eax                    # return 0
>     ret

The asm looks good, but the C exploded a bit... why not just have an
inline get_user()?

> If you can test this and verify that it actually help, I'll take it as
> a patch. Consider it signed-off after testing.

Let me see if I can recreate the original report (or get the automatic
testing to see the commit).

> > Also, is there any harm in speeding up __get_user()?  It still has ~80
> > callers and it's likely to be slowing down things we don't know about.
> 
> How would you speed it up?  We definitely can't replace the fence with
> addressing tricks. So we can't just replace it with "get_user()",
> because of those horrid architecture-specific kernel uses.

I'm not sure if you saw the example code snippet I posted up-thread,
here it is below.

It adds a conditional branch to test if it's a user address.  If so, it
does pointer masking.  If not, it does LFENCE.  So "bad" users get the
slow path, and we could even add a WARN_ON().

Yes, another conditional branch isn't ideal, but it's still much faster
than the current code, and it would root out any bad users with a
WARN_ON() so that eventually it can just become a get_user() alias.

.macro __get_user_nocheck_nospec
#ifdef CONFIG_X86_64
	movq $0x0123456789abcdef, %rdx
 1:
.pushsection runtime_ptr_USER_PTR_MAX, "a"
	.long 1b - 8 - .
.popsection
	cmp %rax, %rdx
	jb 10f
	sbb %rdx, %rdx
	or %rdx, %rax
	jmp 11f
10:	/*
	 * Stop access_ok() branch misprediction -- both of them ;-)
	 *
	 * As a benefit this also punishes callers who intentionally call this
	 * with a kernel address.  Once they're rooted out, __get_user() can
	 * just become an alias of get_user().
	 *
	 * TODO: Add WARN_ON()
	 */
#endif
	ASM_BARRIER_NOSPEC
11:
.endm

/* .. and the same for __get_user, just without the range checks */
SYM_FUNC_START(__get_user_nocheck_1)
	__get_user_nocheck_nospec
	ASM_STAC
	UACCESS movzbl (%_ASM_AX),%edx
	xor %eax,%eax
	ASM_CLAC
	RET
SYM_FUNC_END(__get_user_nocheck_1)
EXPORT_SYMBOL(__get_user_nocheck_1)

-- 
Josh

