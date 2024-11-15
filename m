Return-Path: <linux-kernel+bounces-411490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3479CFAD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CFD1F2319E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF3192B75;
	Fri, 15 Nov 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9mcKu5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EC7346D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712016; cv=none; b=p+nn2APKOz1iqxPP28Lol+HxvXn9sXDMxIjuxanEhlDDF9dFRlt1J5Hr27ZRyvp1JcQPmAxRdA1zO0O7qsBBK1bAeoeeDQnzBh9itCD5ulr3AnO0YEVEH/5MWxuHKygV4UjUS3xilpZ1JjvO0TXUrS5hQ+PwJA7T7U8Y4yLDKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712016; c=relaxed/simple;
	bh=cjtwl0gGLi5MSlCyLv07Q+lWF52r2XQCMliJF3VOZDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4R/bP8EgDmYuHPsAwWyACA4WkVuYWaoHwCesHUo+88ZIngxGQI2POrLxBPUqfd61gj1N0FH2PToZCCHwBmisXhnwNiYgIwG9gkupcrrQWlc6jwIeiMshuazea5L5OkfFOmcJ3Qv3vFbQXa+TQeUC1POOwnw+/Bo76M2BElACFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9mcKu5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931C0C4CECF;
	Fri, 15 Nov 2024 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712016;
	bh=cjtwl0gGLi5MSlCyLv07Q+lWF52r2XQCMliJF3VOZDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9mcKu5pi9ubrMvJHG/FOv0+CJuVSkiPA+ZjL+u4TAzs1YScuoISsPqL2Rn1s1NtP
	 pg9gtVw3yENCC8pGssa+sJVTz/1g13Y4Yg3XP6jLseFdqUrMWAjX12mN7D9PpHgdid
	 j8MDI7ItYrOiAB7sjRqm3rlKO86nBEBPRScXP58/vDV0S/dDCLI+vC4vk+HsjwYK8u
	 oaRmIKxuQPkHnkCpjcq5ZRVvM7A9fVHBfyfInCgGPdYk2EcSY/KuMWEnZHFDymZRpJ
	 9WbnUBP0YT5+xnipx4Uiwbo78LeY9+dG9YrDhgqkQbXtilqfqNM4mhiAUk76yD6ivX
	 nbvGqPJKvG0sg==
Date: Fri, 15 Nov 2024 15:06:53 -0800
From: 'Josh Poimboeuf' <jpoimboe@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Message-ID: <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>

On Fri, Nov 08, 2024 at 05:12:53PM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > On Mon, Oct 28, 2024 at 06:56:15PM -0700, Josh Poimboeuf wrote:
> > > The barrier_nospec() in 64-bit __get_user() is slow.  Instead use
> > > pointer masking to force the user pointer to all 1's if a previous
> > > access_ok() mispredicted true for an invalid address.
> > 
> > Linus pointed out that __get_user() may be used by some code to access
> > both kernel and user space and in fact I found one such usage in
> > vc_read_mem()....

.. which sucks because I got a "will-it-scale.per_process_ops 1.9%
improvement" report for this patch.

It's sad that __get_user() is now slower than get_user() on x86, it kind
of defeats the whole point!

I know at least the "coco" code is misusing __get_user().  Unless
somebody wants to audit all the other callers, we could do something
horrific:

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

Yes, I know adding another access_ok() is bad, but it would be a
definite speedup.  And adding a WARN_ON() would root out any other bad
callers pretty quick.

> But I've wondered if access_ok() ought to be implemented using an
> 'asm goto with output' - much like get_user().
> 
> Then the use would be:
> 	masked_address = access_ok(maybe_bad_address, size, jump_label);
> with later user accesses using the masked_address.
> 
> Once you've done that __get_user() doesn't need to contain address masking.

Sure, we just need a volunteer to change all the access_ok() implementations
and callers tree-wide ;-)

> Given that clac/stac iare so slow should there are be something that
> combines stac with access_ok() bracketed with a 'user_access_end'
> or an actual fault.
> 
> I've sure there is code (maybe reading iovec[] or in sys_poll())
> that wants to do multiple get/put_user in a short loop rather that
> calling copy_to/from_user().

We already have this with user_access_begin() + unsafe_get_user().
There's also a version which masks the address: masked_user_access_begin().

We just need to start porting things over.

-- 
Josh

