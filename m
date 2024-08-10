Return-Path: <linux-kernel+bounces-281903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7F94DCD1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E242F1F218CF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6157182D8;
	Sat, 10 Aug 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bRUvfYHu"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B0158552
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723293444; cv=none; b=JDL4XBuEGyQgtq8NKqYZOTHafRvWI0TGFkBVIt42xo57tpdsKrUCzJPpXk7yd29Ko7I+SYHnYaPvMxW+WnZ+4Gtt3X7h+F6US06Keq0C/d66HAmEYm4HQLDfkRj9pajIz436r4ScYqlufgPavMUiTNNz6edUCrqA/pWr5x379fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723293444; c=relaxed/simple;
	bh=QNRQdtQjv2pE1wqbDdQ7/ZG/vWctN7xJv2AR7zCUqnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZrwRz2Jn2/v7iooZtMwnbDJNCVEPQ/mzvboJOtyf2vOhizc7/ci/NWCeN/LAyfhuS37zueC0SSOtqRpQDvksk8RMm+aMK01BVVme0WrII9EmKba2TuS/tOW8Z7AmDZHdhw6d2118URf9S7d63JYkAYhm5i5vhLjWe8w8kytERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bRUvfYHu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723293440;
	bh=QNRQdtQjv2pE1wqbDdQ7/ZG/vWctN7xJv2AR7zCUqnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRUvfYHukZd5ayjjnh4qtNrRxHbWEQJtnvZrbcslRANP9nJg1/QXZT3oDv3f0ws3p
	 TcQNj5ObVmoK3oxKxsyFQNOyX1K7D8lRcm7JkewJTLtGmXceoUzKuJyqwTl3E4LjLh
	 b1b0sasvCx0gKnrGpa48Q1nCRQNOAK8L2r+u83fE=
Date: Sat, 10 Aug 2024 14:37:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>

On 2024-08-10 19:12:25+0000, Ammar Faizi wrote:
> On Sat, Aug 10, 2024 at 12:54:46PM +0200, Thomas Weißschuh wrote:
> > +__attribute__((weak,unused,section(".text.nolibc_memmove")))
> > +__nolibc_naked __no_stack_protector
> > +void *memmove(void *dst __attribute__((unused)),
> > +	      const void *src __attribute__((unused)),
> > +	      size_t len __attribute__((unused)))
> > +{
> > +	__asm__ volatile (
> > +		"movq %rdx, %rcx\n\t"
> > +		"movq %rdi, %rax\n\t"
> > +		"movq %rdi, %rdx\n\t"
> > +		"subq %rsi, %rdx\n\t"
> > +		"cmpq %rcx, %rdx\n\t"
> > +		"jb   .Lbackward_copy\n\t"
> > +		"rep movsb\n\t"
> > +		"retq\n"
> > +		".Lbackward_copy:"
> > +		"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
> > +		"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
> > +		"std\n\t"
> > +		"rep movsb\n\t"
> > +		"cld\n\t"
> > +		"retq\n"
> > +	);
> > +	__nolibc_naked_epilogue();
> > +}
> 
> NAK for this patch.

Thanks for the feedback!

(I'm not an assembler programmer, so regard my notes with a grain of salt)

> This approach appears highly dangerous, particularly when the compiler
> inlines the call. When using inline assembly within a function, it's
> crucial to define proper constraints and a clobber list to ensure the
> arguments are correctly bound to the inline assembly.

Aren't the constraints a feature of Extended Asm?
This is a Basic Asm block.
Indeed naked functions only support Basic Asm, so there is no way to
explicitly bind arguments to their registers.

Looking at the object code for various on both gcc and clang show always
the same object code.
(Although GCC adds a "ud2" after the "ret")

> Moreover, as it stands, there is no indication to the compiler that the
> inline assembly modifies registers such as %rax, %rdi, %rsi, %rdx, %rcx,
> or "memory", which could lead to unpredictable behavior.

> Unfortunately, I can't spend more time on this right now as I'm
> currently traveling. I'll get back to it later when I'm in transit.

There is no urgency on this, I'll wait on your further feedback.

Thanks again,
Thomas

