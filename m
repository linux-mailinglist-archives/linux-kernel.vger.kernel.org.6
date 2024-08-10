Return-Path: <linux-kernel+bounces-282015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E094DE4F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF141C21655
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E513D279;
	Sat, 10 Aug 2024 19:45:54 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B989107A0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723319153; cv=none; b=Wa3M0NwMKuZUugl/kP+PtMeRDbJdzkC+UJ9dlZGS+WC6mmk5rRrUW1TUZYDUEFWJVulTY+tk/D3jnGswKysZb+nSOHWnRh9siTYThCQuV1ZILrABq6P5eN5rBBxo9V0KOR001inKVszj3iQKurcF57b2lWgbFep+yADmliSAO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723319153; c=relaxed/simple;
	bh=vTZaU+h3ISxtbx0LaYJoFrw0jzLm79Gcus0kEGs3hMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjETrzFTxU90RTZj99EsSFGBemrIKGo3hDC3clXdHfc/FrwN67liViuH8Lbjjm2qvTLsl2k9P8UizfKqXWBBmF5NNQcb8KNhUdVHEayWZNP80W+ZYMCYbmgjiMukwAXefl7N/PZHUCc8sGUrno2FhDmaLopA24tfJHtmG+q3LrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47AJjj2w005069;
	Sat, 10 Aug 2024 21:45:45 +0200
Date: Sat, 10 Aug 2024 21:45:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <20240810194545.GA5065@1wt.eu>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
 <Zre8cPOKetof24nJ@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zre8cPOKetof24nJ@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Ammar,

On Sun, Aug 11, 2024 at 02:16:00AM +0700, Ammar Faizi wrote:
> On Sat, Aug 10, 2024 at 06:04:36PM +0200, Thomas Weißschuh wrote:
> > On 2024-08-10 16:35:56+0000, Willy Tarreau wrote:
> > > See how rdi and rdx were expected to be preserved after the first call
> > > but were not? This was with gcc-9.5 (which supports naked but it's for
> > > illustration purposes of the risk of leaving unconstrained asm like this).
> > 
> > To be honest, I don't see it. Not enough asm experience I guess, but
> > I'll look at it some more.
> 
> Let me shed some light on what is going wrong in that form.
> 
> First, let's revisit the System V ABI x86-64 calling convention:
> 
>   - %rdi holds the 1st argument
>   - %rsi holds the 2nd argument
>   - %rdx holds the 3rd argument
>   - %rax is used for the return value
> 
> Take a look at the assembly code that Willy sent. The second memmove()
> call is receiving incorrect arguments from the previous memmove() call.
> 
> The issue arises because your memmove() function doesn't inform the
> compiler that it modifies %rdi and %rdx. As far as the compiler is
> concerned, your memmove() function:
> 
>   Does not alter any registers.
> 
> Consequently, the compiler assumes that the values in %rdi and %rdx
> remain unchanged after the memmove() function returns. With this
> assumption, and since memmove() is within the same translation unit as
> the caller, the compiler optimizes the register moves without preserving
> the values in %rdi and %rdx.
> 
> To properly inform the compiler that certain registers are being
> modified, you need to use constraints and a clobber list. Here's an
> example (note: this is untested, only compiled on Godbolt):
> 
> Link: https://godbolt.org/z/WTz1nvn1h
> 
> ```
> void *memmove(void *dst, const void *src, size_t len)
> {
> 	void *rax;
> 
> 	__asm__ goto volatile (
> 		"movq	%%rdx, %%rcx\n\t"
> 		"movq	%%rdi, %%rax\n\t"
> 		"movq	%%rdi, %%rdx\n\t"
> 		"subq	%%rsi, %%rdx\n\t"
> 		"cmpq	%%rcx, %%rdx\n\t"
> 		"jb	.Lbackward_copy\n\t"
> 		"rep movsb\n\t"
> 		"jmp	%[out]\n\t"
> 	".Lbackward_copy:\n\t"
> 		"leaq	-1(%%rdi, %%rcx, 1), %%rdi\n\t"
> 		"leaq	-1(%%rsi, %%rcx, 1), %%rsi\n\t"
> 		"std\n\t"
> 		"rep movsb\n\t"
> 		"cld"
> 		: "+D"(dst), "+S"(src), "+c"(len), "=a"(rax)
> 		:
> 		: "rdx", "memory", "cc"
> 		: out
> 	);
> 
> out:
> 	return rax;
> }
> ```
> 
> This approach helps the compiler correctly handle the register
> modifications, ensuring that the generated code behaves as expected.
> 
> Notes:
> 
>   constraints (binding C variables):
>     - "+D": Read and Write %rdi
>     - "+S": Read and Write %rsi
>     - "+c": Read and Write %rcx
>     - "=a": Write %rax
> 
>   clobber list:
>     - "rdx": Write %rdx
>     - "memory": Read and Write memory (pointed to by dst and src)
>     - "cc": Write %rflags (This might be optional for x86-64)
> 
> I believe we can do better code than that. I can't pull Linux git tree
> as well for now. I'll be fully available for work on Tuesday morning
> (13 August 2024).

The constraints are trivial, the problem is that they're not supposed to
be used in a naked function. I tried, as you can guess. gcc accepted
them without complaining but clang not at all. However what's interesting
is that the compiler being aware of our unability to inform it about the
clobber list, it did consider everything clobbered and saved the registers
in the caller in this case. That does make sense, otherwise it would be
impossible to use asm in naked functions. However we need to restrict
this use case to true naked functions, not the ones we were doing ourselves
before the existence of the naked attribute.

Willy

