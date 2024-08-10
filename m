Return-Path: <linux-kernel+bounces-281974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F394DDB0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4402820B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80115854B;
	Sat, 10 Aug 2024 17:00:39 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD971366
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723309238; cv=none; b=ORfGikOEiTQW6+LK9QhkZZKD2WhwK1i01pbafJfBViKZp2zWxTmUl1OlHsxQq6vj9ICkukFene2UNQDEk3qPs+bG2rBD4EkSQuorowbDNMrDg4ZcV90W/thy9w9tReA9jOm8lT5Cb99cGOhGcvuF6+mMe1so++YKvrSn/Bt97sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723309238; c=relaxed/simple;
	bh=jeUoSqGnWGwLFZ+h8ieL7KcjYKdNgjT7EmiDJk/JWpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsqv0GQ64bxJbImJIha5exWeGxL/i02yKZwam/ekGO9AABicky7YjGxd+yY6bB6dqCdzUYCNO9qX/W0ukB4rFIlSX27u3FEUC38CnkXHQlqMqmSLYZMUko82FJJvyTTWnFiZRAoZ+mPztEINRHnZ+Az546JJ/ppoDlNJ3d00ooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47AH0Usv030601;
	Sat, 10 Aug 2024 19:00:30 +0200
Date: Sat, 10 Aug 2024 19:00:30 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <20240810170030.GA4461@1wt.eu>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
 <17ed9bf5-64da-418e-b40e-6e3d40c67769@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17ed9bf5-64da-418e-b40e-6e3d40c67769@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 10, 2024 at 06:45:19PM +0200, Thomas Weißschuh wrote:
> Iff we really want to support it, we could do use naked where available
> and fall back to toplevel asm otherwise.
> This should work on newer compilers and older ones without -flto.
> It looks horrible though.
> 
>   #define NOLIBC_ARCH_HAS_MEMSET
>   void *memset(void *dst, int c, size_t len);
>   
>   #if __nolibc_has_attribute(naked)
> 
>   __attribute__((weak,naked))
>   void *memset(void *dst __attribute__((unused)), int c __attribute__((unused)), size_t len __attribute__((unused))) {
> 
>   #else
> 
>   __asm__ (
>   ".section .text.nolibc_memset\n"
>   ".weak memset\n"
>   "memset:\n"
>   );
> 
>   #endif
> 
>   __asm__ (
>   	"xchgl %eax, %esi\n\t"
>   	"movq  %rdx, %rcx\n\t"
>   	"pushq %rdi\n\t"
>   	"rep stosb\n\t"
>   	"popq  %rax\n\t"
>   	"retq\n"
>   );
> 
>   #if __nolibc_has_attribute(naked)
>   }
>   #endif
> 
> (Or some impenetrable macro wrapper abstraction thereof)

One dangerous part above is that the compiler can reorder toplevel asm
statements, so having a label in one and the code in another may result
in random bugs.

> The memcpy / memmove combination could be split up into one real
> function and one C inline wrapper and then the same pattern would apply.
> 
> But to be honest I'd be fine with not supporting -flto on GCC.

That could also be a reasonable solution. The primary goal of nolibc
is to make it easy for developers to develop tests, and for those who
want to create pre-boot code to do so. By nature this code is prone to
bugs. If it becomes totally unreadable for very unlikely cases, it will
cause issues that are hard to debug by the users themselves. It's sure
that supporting a variety of compilers and setups is great, but we should
keep in mind the maintainability goal when thinking about this. I think
that LTO will mostly be used for testing, and in this case I think it's
totally reasonable to restrict the choice of compatible compilers.

Willy

