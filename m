Return-Path: <linux-kernel+bounces-283484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF794F588
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F421F21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6718754E;
	Mon, 12 Aug 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kLojXmA0"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD56CDBA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482099; cv=none; b=j17Z4tBDsFGKuZeNbzIgnBajKPsuHtyeHXBtxa/CSPaWg/RUaee6FUbIbmoDNnO1iX8zM4Bga1HF84EzLsLB9eqdP0sEdO73hu8AQKWlCxTLIA5g4cOX/XN+ZYby/LWiyCWpJUPIupny0kh+8xNjdO+JOx+fScoxe8zeQlO1pGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482099; c=relaxed/simple;
	bh=+/VqLJ027kNAU6UQyMaaFfT0RThTz9Uk7VOc0Tpnn30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnsB5Yv7XMTyUXMInaanmbpx+tH1QNsXAj5CQz04wrgY7IY7qkzY+tXFBsiyQblvO2z0hD8hJybazoghMbDfawms8EOe+8Geypj3ON+wLRx79b/8KjGaZltpsSEmEWZsbiYg2rG18KQX8lfDm7lVLF7lA6CvK9ngbi+Wf6Ch6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kLojXmA0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723482087;
	bh=+/VqLJ027kNAU6UQyMaaFfT0RThTz9Uk7VOc0Tpnn30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLojXmA0szLFWcpUCbzfdN59y0RAXpg3qTPt4iDCM+3llm7QfSTECGJFuOQlDxmeb
	 kzFpfyC4PEVkBYstakLhSXfNxevZ0huyiJVUHlqhKn3h3R0rB9Lxf4DK/oMhe2cOtG
	 S6Kf4Ar4wwfTZRY9dW/w16tOrsboglgJEWhRnZQg=
Date: Mon, 12 Aug 2024 19:01:26 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <65cf1965-841b-4fb1-9222-913c6bd9ccd4@t-8ch.de>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
 <17ed9bf5-64da-418e-b40e-6e3d40c67769@t-8ch.de>
 <20240810170030.GA4461@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810170030.GA4461@1wt.eu>

On 2024-08-10 19:00:30+0000, Willy Tarreau wrote:
> On Sat, Aug 10, 2024 at 06:45:19PM +0200, Thomas Weißschuh wrote:
> > Iff we really want to support it, we could do use naked where available
> > and fall back to toplevel asm otherwise.
> > This should work on newer compilers and older ones without -flto.
> > It looks horrible though.
> > 
> >   #define NOLIBC_ARCH_HAS_MEMSET
> >   void *memset(void *dst, int c, size_t len);
> >   
> >   #if __nolibc_has_attribute(naked)
> > 
> >   __attribute__((weak,naked))
> >   void *memset(void *dst __attribute__((unused)), int c __attribute__((unused)), size_t len __attribute__((unused))) {
> > 
> >   #else
> > 
> >   __asm__ (
> >   ".section .text.nolibc_memset\n"
> >   ".weak memset\n"
> >   "memset:\n"
> >   );
> > 
> >   #endif
> > 
> >   __asm__ (
> >   	"xchgl %eax, %esi\n\t"
> >   	"movq  %rdx, %rcx\n\t"
> >   	"pushq %rdi\n\t"
> >   	"rep stosb\n\t"
> >   	"popq  %rax\n\t"
> >   	"retq\n"
> >   );
> > 
> >   #if __nolibc_has_attribute(naked)
> >   }
> >   #endif
> > 
> > (Or some impenetrable macro wrapper abstraction thereof)
> 
> One dangerous part above is that the compiler can reorder toplevel asm
> statements, so having a label in one and the code in another may result
> in random bugs.

Indeed, let's scratch that then.

> > The memcpy / memmove combination could be split up into one real
> > function and one C inline wrapper and then the same pattern would apply.
> > 
> > But to be honest I'd be fine with not supporting -flto on GCC.
> 
> That could also be a reasonable solution. The primary goal of nolibc
> is to make it easy for developers to develop tests, and for those who
> want to create pre-boot code to do so. By nature this code is prone to
> bugs. If it becomes totally unreadable for very unlikely cases, it will
> cause issues that are hard to debug by the users themselves. It's sure
> that supporting a variety of compilers and setups is great, but we should
> keep in mind the maintainability goal when thinking about this. I think
> that LTO will mostly be used for testing, and in this case I think it's
> totally reasonable to restrict the choice of compatible compilers.

IMO LTO is useful for nolibc to reduce the size of the generated binaries.
For example the custom function sections that then can be combined with
--gc-sections to get rid of unused functions is all implicit in LTO.
And on top of that it can perform other size optimizations.

But the complications for GCC are not worth it.
And there seem general with LTO on GCC anyways as evidenced by the
constructor and duplicate-asm bugs.

After this discussion I think we should also change the __nolibc_naked
attribute back to __nolibc_entrypoint as it was before.
It is indeed not a replacement for a proper "naked".
What do you think about me rewriting the existing commits on nolibc-next
to fix this up?


Thomas

