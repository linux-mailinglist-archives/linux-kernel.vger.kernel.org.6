Return-Path: <linux-kernel+bounces-281940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94394DD4A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB861C20DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F61586CF;
	Sat, 10 Aug 2024 14:36:11 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B2922083
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723300571; cv=none; b=msdOHxnJKUeGzW1mbkLwgr35Y907LFU3jFXqCbRLrWO6ED02UOtVFrx//2X5aceTuxV4fauGzG2uCYp7no4xzxZQomOczYCa14SSOcq0jtkQJHyS838LNEN91qmPmW3oW/Jus5Tax/dMzzGstfxTc/2suze4QdcH29wCb/7t5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723300571; c=relaxed/simple;
	bh=PzfXXXMz7myJoIUnuK7PqQe+htxIpCqZp3531r3G4+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epnJoOSeh83shkQcCf9yqAcRNksvRP/ji9bzcQ1/NsqjuWN99RBmf7MzXfxcijAb2GggdZu3/Zf7eT50YfO1CK7vfK1mqnE6AX4NB0XygHsBB0JnrXpyYOcWgdtIQxPWaDZ3ph2KhQhEjOOwSqXdGIO2lH2Ztp4DKvWgS693STM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47AEZu7v009464;
	Sat, 10 Aug 2024 16:35:56 +0200
Date: Sat, 10 Aug 2024 16:35:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <20240810143556.GA9168@1wt.eu>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sat, Aug 10, 2024 at 02:37:19PM +0200, Thomas Weißschuh wrote:
> On 2024-08-10 19:12:25+0000, Ammar Faizi wrote:
> > On Sat, Aug 10, 2024 at 12:54:46PM +0200, Thomas Weißschuh wrote:
> > > +__attribute__((weak,unused,section(".text.nolibc_memmove")))
> > > +__nolibc_naked __no_stack_protector
> > > +void *memmove(void *dst __attribute__((unused)),
> > > +	      const void *src __attribute__((unused)),
> > > +	      size_t len __attribute__((unused)))
> > > +{
> > > +	__asm__ volatile (
> > > +		"movq %rdx, %rcx\n\t"
> > > +		"movq %rdi, %rax\n\t"
> > > +		"movq %rdi, %rdx\n\t"
> > > +		"subq %rsi, %rdx\n\t"
> > > +		"cmpq %rcx, %rdx\n\t"
> > > +		"jb   .Lbackward_copy\n\t"
> > > +		"rep movsb\n\t"
> > > +		"retq\n"
> > > +		".Lbackward_copy:"
> > > +		"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
> > > +		"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
> > > +		"std\n\t"
> > > +		"rep movsb\n\t"
> > > +		"cld\n\t"
> > > +		"retq\n"
> > > +	);
> > > +	__nolibc_naked_epilogue();
> > > +}
> > 
> > NAK for this patch.
> 
> Thanks for the feedback!
> 
> (I'm not an assembler programmer, so regard my notes with a grain of salt)
> 
> > This approach appears highly dangerous, particularly when the compiler
> > inlines the call. When using inline assembly within a function, it's
> > crucial to define proper constraints and a clobber list to ensure the
> > arguments are correctly bound to the inline assembly.
> 
> Aren't the constraints a feature of Extended Asm?
> This is a Basic Asm block.
> Indeed naked functions only support Basic Asm, so there is no way to
> explicitly bind arguments to their registers.

That's indeed what is said in GNU docs, but a quick test with gcc 9 and 11
shows me that both accept both naked and extended asm. However clang doesn't
seem happy about it.

The problem here is dual:
  - first, the naked attribute can be emulated if not supported by the
    compiler and we'll only have optimize(-Os,-fomit-frame-pointer), and
    in this case the compiler does not respect well the registers (I'm
    seeing bad code being emitted in callers if I mark the function
    static for example).

  - second, nothing prevents the compiler from inlining that function
    and in this case, as Ammar says, we have no control over what
    registers arguments will be placed into since the main purpose of
    inlining precisely is to build optimal code that limits register
    moves. However, in my tests, it appears that when marked naked,
    the compiler never inlines it and even emits a warning if I try
    to mark it inline, saying it was already noinline. So maybe naked
    implies noinline.

In any case, depending on the availability of naked, we have two clearly
different layouts to deal with :-/

We could imagine not marking it naked and keeping the optimize(Os...)
stuff only, then using extended asm like in other functions maybe.
Otherwise this could require two versions, which is less fun.

> Looking at the object code for various on both gcc and clang show always
> the same object code.
> (Although GCC adds a "ud2" after the "ret")

It *seems* so as well for me but in the not-really-naked case, you
really have zero control over it. Also one thing it does to me in the
not-naked-case is that registers are not saved by the caller and are
clobbered by the asm statement:

  void *memmove2(void *dst __attribute__((unused)),
                 void *src __attribute__((unused)),
                 size_t len __attribute__((unused)))
  {
        memmove(dst, src, len);
        memmove(src, dst, len);
        return 0;
  }

Gives me this with the naked attribute:
0000000000000025 <memmove2>:
  25:   55                      push   %rbp
  26:   48 89 f5                mov    %rsi,%rbp
  29:   50                      push   %rax
  2a:   48 89 14 24             mov    %rdx,(%rsp)
  2e:   e8 00 00 00 00          callq  33 <memmove2+0xe>
  33:   48 8b 14 24             mov    (%rsp),%rdx
  37:   48 89 ef                mov    %rbp,%rdi
  3a:   48 89 c6                mov    %rax,%rsi
  3d:   e8 00 00 00 00          callq  42 <memmove2+0x1d>
  42:   31 c0                   xor    %eax,%eax
  44:   5a                      pop    %rdx
  45:   5d                      pop    %rbp
  46:   c3                      retq   

But the alternate form (optimize(-Os...)):
0000000000000024 <memmove2>:
  24:   49 89 f0                mov    %rsi,%r8
  27:   e8 00 00 00 00          callq  2c <memmove2+0x8>
  2c:   48 89 fe                mov    %rdi,%rsi
  2f:   4c 89 c7                mov    %r8,%rdi
  32:   e8 00 00 00 00          callq  37 <memmove2+0x13>
  37:   31 c0                   xor    %eax,%eax
  39:   c3                      retq   

See how rdi and rdx were expected to be preserved after the first call
but were not? This was with gcc-9.5 (which supports naked but it's for
illustration purposes of the risk of leaving unconstrained asm like this).

I also managed to get clang to complain about the .Lbackward_copy label
being already defined, but I don't know how I managed to do it. I think
we should not leave it as a global label like this and instead just use
the regular numbered labels if the asm is inlined.

Also I'm wondering why there are errors about memcpy and memmove being
already defined with -flto, because these ones are marked "weak". Maybe
we need to add something else, that gcc emits with the functions when
using lto ?

Just my two cents,
Willy

