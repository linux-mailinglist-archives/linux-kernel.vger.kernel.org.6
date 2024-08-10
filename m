Return-Path: <linux-kernel+bounces-281967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1494DD94
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D80B215B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439C160796;
	Sat, 10 Aug 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GlmRtO9N"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2473C062
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723305887; cv=none; b=ojNVJMRp2iCPm25rclJd5EqIg/PaJe4vQEICh3HZ4RiXKrhj0uRQo7BUf0nEPmGvBMeYas/hLvJG2Yq+X6mA+x1H1/0iYntyTiS+QZYTJWfBascYsLRuEZfjk6Z0roi+3gDJyh5Dq5og/IJDyr5RW+XCgtye2NrfaiShShSNg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723305887; c=relaxed/simple;
	bh=AjNZFW4boODP/HK3hCLHDgFiARPS9nX9uOKEiJ9b/oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFwxMJUsxb+cCq164wt2wZF4gB+xM5UMTMkYYIIrnsZ9Sx34rE3kpbh8XF3BaGOE3FNsL8ZpEI7/fERnSVIVsB3m8dqI7NUoUz8ZxWaTwolsvi+xjzam1IKP7fv/0SlxJcmVgztgbDSD043AiZEZdF0CtW8GkaLWEkIoP8kpjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GlmRtO9N; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723305876;
	bh=AjNZFW4boODP/HK3hCLHDgFiARPS9nX9uOKEiJ9b/oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlmRtO9N1XPHKWbG2smXh4Tuf1Wcxpszt+CyIMyzsuSo939eXmo/VtgBRM5wpO4V/
	 lMJq80WGhyrqnKS2UOSkxP665IeOk3ZYe5y0p/g8StFjdgY31fNPld7FXCpCez9jrL
	 zpTxpVJ4JqbPLTE13X5SpJ4B1aAXT7hby6gSfI8s=
Date: Sat, 10 Aug 2024 18:04:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810143556.GA9168@1wt.eu>

On 2024-08-10 16:35:56+0000, Willy Tarreau wrote:
> On Sat, Aug 10, 2024 at 02:37:19PM +0200, Thomas Weißschuh wrote:
> > On 2024-08-10 19:12:25+0000, Ammar Faizi wrote:
> > > On Sat, Aug 10, 2024 at 12:54:46PM +0200, Thomas Weißschuh wrote:
> > > > +__attribute__((weak,unused,section(".text.nolibc_memmove")))
> > > > +__nolibc_naked __no_stack_protector
> > > > +void *memmove(void *dst __attribute__((unused)),
> > > > +	      const void *src __attribute__((unused)),
> > > > +	      size_t len __attribute__((unused)))
> > > > +{
> > > > +	__asm__ volatile (
> > > > +		"movq %rdx, %rcx\n\t"
> > > > +		"movq %rdi, %rax\n\t"
> > > > +		"movq %rdi, %rdx\n\t"
> > > > +		"subq %rsi, %rdx\n\t"
> > > > +		"cmpq %rcx, %rdx\n\t"
> > > > +		"jb   .Lbackward_copy\n\t"
> > > > +		"rep movsb\n\t"
> > > > +		"retq\n"
> > > > +		".Lbackward_copy:"
> > > > +		"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
> > > > +		"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
> > > > +		"std\n\t"
> > > > +		"rep movsb\n\t"
> > > > +		"cld\n\t"
> > > > +		"retq\n"
> > > > +	);
> > > > +	__nolibc_naked_epilogue();
> > > > +}
> > > 
> > > NAK for this patch.
> > 
> > Thanks for the feedback!
> > 
> > (I'm not an assembler programmer, so regard my notes with a grain of salt)
> > 
> > > This approach appears highly dangerous, particularly when the compiler
> > > inlines the call. When using inline assembly within a function, it's
> > > crucial to define proper constraints and a clobber list to ensure the
> > > arguments are correctly bound to the inline assembly.
> > 
> > Aren't the constraints a feature of Extended Asm?
> > This is a Basic Asm block.
> > Indeed naked functions only support Basic Asm, so there is no way to
> > explicitly bind arguments to their registers.
> 
> That's indeed what is said in GNU docs, but a quick test with gcc 9 and 11
> shows me that both accept both naked and extended asm. However clang doesn't
> seem happy about it.
> 
> The problem here is dual:
>   - first, the naked attribute can be emulated if not supported by the
>     compiler and we'll only have optimize(-Os,-fomit-frame-pointer), and
>     in this case the compiler does not respect well the registers (I'm
>     seeing bad code being emitted in callers if I mark the function
>     static for example).

Ack.

Would it help to mark the function as non-inlineable?

>   - second, nothing prevents the compiler from inlining that function
>     and in this case, as Ammar says, we have no control over what
>     registers arguments will be placed into since the main purpose of
>     inlining precisely is to build optimal code that limits register
>     moves. However, in my tests, it appears that when marked naked,
>     the compiler never inlines it and even emits a warning if I try
>     to mark it inline, saying it was already noinline. So maybe naked
>     implies noinline.

I did not manage yet to get it inlined.
With __attribute__((always_inline)) gcc even gives:

sysroot/x86_64/include/arch.h:214:1: error: ignoring attribute 'always_inline' because it conflicts with attribute 'noinline' [-Werror=attributes]

> In any case, depending on the availability of naked, we have two clearly
> different layouts to deal with :-/

Indeed...

> We could imagine not marking it naked and keeping the optimize(Os...)
> stuff only, then using extended asm like in other functions maybe.
> Otherwise this could require two versions, which is less fun.

Note: __attribute__((naked)) on gcc x86_64 is supported since gcc 8.1.

> > Looking at the object code for various on both gcc and clang show always
> > the same object code.
> > (Although GCC adds a "ud2" after the "ret")
> 
> It *seems* so as well for me but in the not-really-naked case, you
> really have zero control over it. Also one thing it does to me in the
> not-naked-case is that registers are not saved by the caller and are
> clobbered by the asm statement:
> 
>   void *memmove2(void *dst __attribute__((unused)),
>                  void *src __attribute__((unused)),
>                  size_t len __attribute__((unused)))
>   {
>         memmove(dst, src, len);
>         memmove(src, dst, len);
>         return 0;
>   }
> 
> Gives me this with the naked attribute:
> 0000000000000025 <memmove2>:
>   25:   55                      push   %rbp
>   26:   48 89 f5                mov    %rsi,%rbp
>   29:   50                      push   %rax
>   2a:   48 89 14 24             mov    %rdx,(%rsp)
>   2e:   e8 00 00 00 00          callq  33 <memmove2+0xe>
>   33:   48 8b 14 24             mov    (%rsp),%rdx
>   37:   48 89 ef                mov    %rbp,%rdi
>   3a:   48 89 c6                mov    %rax,%rsi
>   3d:   e8 00 00 00 00          callq  42 <memmove2+0x1d>
>   42:   31 c0                   xor    %eax,%eax
>   44:   5a                      pop    %rdx
>   45:   5d                      pop    %rbp
>   46:   c3                      retq   
> 
> But the alternate form (optimize(-Os...)):
> 0000000000000024 <memmove2>:
>   24:   49 89 f0                mov    %rsi,%r8
>   27:   e8 00 00 00 00          callq  2c <memmove2+0x8>
>   2c:   48 89 fe                mov    %rdi,%rsi
>   2f:   4c 89 c7                mov    %r8,%rdi
>   32:   e8 00 00 00 00          callq  37 <memmove2+0x13>
>   37:   31 c0                   xor    %eax,%eax
>   39:   c3                      retq   
> 
> See how rdi and rdx were expected to be preserved after the first call
> but were not? This was with gcc-9.5 (which supports naked but it's for
> illustration purposes of the risk of leaving unconstrained asm like this).

To be honest, I don't see it. Not enough asm experience I guess, but
I'll look at it some more.

> I also managed to get clang to complain about the .Lbackward_copy label
> being already defined, but I don't know how I managed to do it. I think
> we should not leave it as a global label like this and instead just use
> the regular numbered labels if the asm is inlined.

Ack, this was easy to fix.

> Also I'm wondering why there are errors about memcpy and memmove being
> already defined with -flto, because these ones are marked "weak". Maybe
> we need to add something else, that gcc emits with the functions when
> using lto ?

I think normally .weak would only be resolved by the linker.
What happens here is that the assembler is already presented with
duplicate definitions which it is not prepared to handle.
(See below for an example)

It works on gcc without -flto and on clang with and without -flto.
It seems like a compiler bug to me. If you agree I'll open a ticket
against GCC.
Then we can fix only the label to make it work on clang and wait for a
fixed GCC.


Example:

$ cat a.c
#include "func.h"

int main(void)
{
	return 0;
}

$ cat b.c 
#include "func.h"

$ cat func.h 
__asm__(
	".weak foo\n"
	"foo:\n"
	"retq\n"
);

$ gcc -flto -save-temps a.c b.c
./a.ltrans0.ltrans.s: Assembler messages:
./a.ltrans0.ltrans.s:28: Error: symbol `foo' is already defined
lto-wrapper: fatal error: gcc returned 1 exit status
compilation terminated.
/usr/bin/ld: error: lto-wrapper failed
collect2: error: ld returned 1 exit status

$ cat ./a.ltrans0.ltrans.s
	.file	"<artificial>"
	.text
#APP
	.weak foo
foo:
retq

#NO_APP
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
#APP
	.weak foo
foo:
retq

	.ident	"GCC: (GNU) 14.2.1 20240805"
	.section	.note.GNU-stack,"",@progbits

