Return-Path: <linux-kernel+bounces-282011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9B94DE3B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35CA1C20A32
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF713D283;
	Sat, 10 Aug 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="e5IFxK+q"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597E13CF9F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723317368; cv=none; b=ZY6Hiqf+Blg1A7QQONmvFPndJ7YbSF0k3S0dHomGxGjJbGar+/G4wzDcJmCAQDdDpy2685565fdhFWSBEPpGCei4ZngI6cvZU2TgXnbhnwUFqSgVBMYGyJWJ8B/JaiSBCPYqC30L7/I+nkj9aUuhOdLgedGMU4o6EocU9AyEMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723317368; c=relaxed/simple;
	bh=DWI5/i1gcih62QcaPKvmUPtnRL2UIguA6bigNj7n39U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLoxUtDPh2ZMALpZnVqo01XopJNkgLcfShemmEIh8LY7qvgjpRiGjmndQKNYQlcwDE9id0eUj6LF3N3TgBL4R33WGa4eYeao+EpWazDYVBlJaJJCG2TjC3yvt6Cw2iVdxnfbqlNABq0hSLbFpqYgu4OY/EPaQwg6GEGxu0541Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=e5IFxK+q; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1723317366;
	bh=DWI5/i1gcih62QcaPKvmUPtnRL2UIguA6bigNj7n39U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e5IFxK+qzl5vdOz+YnpbHgLIcLtrdte539n12i9fG7Lhfg1gFFEwfYOHfITUHersW
	 wuG8y8orVrV+NqiF/qFA2P55L0vzwwmmvfm1mVDoj9shpIIPcu8nBmEm+uy7Uu4Xb3
	 1icTQoYMF8hHOi3wjU/1gaxCGLEKNhzWsRW5JFglSkL0tA6Zw95R5LGEUi+AtHWyE9
	 nwaXZORNiaBMvnRgqdnHizi3EgdD/jbDIGfD5LSwTop+6OprV2acskzUjgMk0bhHJf
	 TUM4i+nwx7uSti7eoFqUxknm0dpopPkaQ2aYxJEvMgd0aqrJwPLPnliWXp0wWpiKrY
	 T+8K63T6MM/rw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.223])
	by gnuweeb.org (Postfix) with ESMTPSA id A732324D069;
	Sun, 11 Aug 2024 02:16:04 +0700 (WIB)
Date: Sun, 11 Aug 2024 02:16:00 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <Zre8cPOKetof24nJ@biznet-home.integral.gnuweeb.org>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Sat, Aug 10, 2024 at 06:04:36PM +0200, Thomas Weißschuh wrote:
> On 2024-08-10 16:35:56+0000, Willy Tarreau wrote:
> > See how rdi and rdx were expected to be preserved after the first call
> > but were not? This was with gcc-9.5 (which supports naked but it's for
> > illustration purposes of the risk of leaving unconstrained asm like this).
> 
> To be honest, I don't see it. Not enough asm experience I guess, but
> I'll look at it some more.

Let me shed some light on what is going wrong in that form.

First, let's revisit the System V ABI x86-64 calling convention:

  - %rdi holds the 1st argument
  - %rsi holds the 2nd argument
  - %rdx holds the 3rd argument
  - %rax is used for the return value

Take a look at the assembly code that Willy sent. The second memmove()
call is receiving incorrect arguments from the previous memmove() call.

The issue arises because your memmove() function doesn't inform the
compiler that it modifies %rdi and %rdx. As far as the compiler is
concerned, your memmove() function:

  Does not alter any registers.

Consequently, the compiler assumes that the values in %rdi and %rdx
remain unchanged after the memmove() function returns. With this
assumption, and since memmove() is within the same translation unit as
the caller, the compiler optimizes the register moves without preserving
the values in %rdi and %rdx.

To properly inform the compiler that certain registers are being
modified, you need to use constraints and a clobber list. Here's an
example (note: this is untested, only compiled on Godbolt):

Link: https://godbolt.org/z/WTz1nvn1h

```
void *memmove(void *dst, const void *src, size_t len)
{
	void *rax;

	__asm__ goto volatile (
		"movq	%%rdx, %%rcx\n\t"
		"movq	%%rdi, %%rax\n\t"
		"movq	%%rdi, %%rdx\n\t"
		"subq	%%rsi, %%rdx\n\t"
		"cmpq	%%rcx, %%rdx\n\t"
		"jb	.Lbackward_copy\n\t"
		"rep movsb\n\t"
		"jmp	%[out]\n\t"
	".Lbackward_copy:\n\t"
		"leaq	-1(%%rdi, %%rcx, 1), %%rdi\n\t"
		"leaq	-1(%%rsi, %%rcx, 1), %%rsi\n\t"
		"std\n\t"
		"rep movsb\n\t"
		"cld"
		: "+D"(dst), "+S"(src), "+c"(len), "=a"(rax)
		:
		: "rdx", "memory", "cc"
		: out
	);

out:
	return rax;
}
```

This approach helps the compiler correctly handle the register
modifications, ensuring that the generated code behaves as expected.

Notes:

  constraints (binding C variables):
    - "+D": Read and Write %rdi
    - "+S": Read and Write %rsi
    - "+c": Read and Write %rcx
    - "=a": Write %rax

  clobber list:
    - "rdx": Write %rdx
    - "memory": Read and Write memory (pointed to by dst and src)
    - "cc": Write %rflags (This might be optional for x86-64)

I believe we can do better code than that. I can't pull Linux git tree
as well for now. I'll be fully available for work on Tuesday morning
(13 August 2024).

-- 
Ammar Faizi


