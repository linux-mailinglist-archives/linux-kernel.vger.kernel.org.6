Return-Path: <linux-kernel+bounces-250213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03F92F541
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B1CB20DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBF137914;
	Fri, 12 Jul 2024 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8mX7n1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A324136E39
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763582; cv=none; b=Z8/BLB45D7OW2WzD8u4tCzSSp5qhAQg8W4r6ttPlDv6K1pD8eQVBF6EkACqhCERjF/ZzaEGzTPNu607XtPc4NmWVKk9ogUYN+rouF3NYFgbKoJSH4BD7YHrAB5u7LBXPmYMapdyq6NMCK7sDgCfBdYO+AdWe4XzDbg48am2CApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763582; c=relaxed/simple;
	bh=OsnxxtZ8aNzoHaRaBj666PxT5Qr4RTk3qJYfN72D0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4w2Pqp+bf8sMaQiJkr6npenTbHL2y/DCBlhGJt988NRWLWCTZXLC56YuwZzJJHPjcbPYyDeKXujwi0rQq3Yp3QjMVd3CcM28ub5WSroktwvFEVW6CwyMa7ralL5Hy0yKd1Vt3VgjooeKdBV80A/wAVuj19mqgrawzm9JAPM6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8mX7n1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570D0C3277B;
	Fri, 12 Jul 2024 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720763582;
	bh=OsnxxtZ8aNzoHaRaBj666PxT5Qr4RTk3qJYfN72D0hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8mX7n1s54ENYm8KJks55dNzdK6Lfov0Mdh9l11y1xCWHYSOZJL5FPDtJXr+64jsA
	 fF32OxVM+xZMKDjWtkpi0WMD715qEHbYCJhb29tXkcda9zAlHrZx+cwHbLqihdM1jo
	 FX8ZHIuqcZlhnL9JRhjNnsaK90IuS0DMR0feZBHQLlcO05oMcnplqDF9HZBAwI0rqn
	 EF7x26i/kXuBQYaJodreHb7KTcWolsbJa6XuhI7l6iESH+Gr5vqH9A5q6iFycCyvSr
	 I8vwKQqJ2AV6W4dekH7NjwDfRKG0MzKOSB1OvAKsZ1QfZfCfM8p2Pz327Nji+5DZXo
	 Uv4O+GvAckwqg==
Date: Fri, 12 Jul 2024 07:52:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin
 Murphy <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v12 1/6] uaccess: add generic fallback version of
 copy_mc_to_user()
Message-ID: <20240712075253.05e548d9@foz.lan>
In-Reply-To: <20240711155343.3729bc30@foz.lan>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
	<20240528085915.1955987-2-tongtiangen@huawei.com>
	<20240711155343.3729bc30@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 11 Jul 2024 15:53:43 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Tue, 28 May 2024 16:59:10 +0800
> Tong Tiangen <tongtiangen@huawei.com> escreveu:
> 
> > x86/powerpc has it's implementation of copy_mc_to_user(), we add generic
> > fallback in include/linux/uaccess.h prepare for other architechures to
> > enable CONFIG_ARCH_HAS_COPY_MC.
> > 
> > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/include/asm/uaccess.h | 1 +
> >  arch/x86/include/asm/uaccess.h     | 1 +
> >  include/linux/uaccess.h            | 8 ++++++++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> > index de10437fd206..df42e6ad647f 100644
> > --- a/arch/powerpc/include/asm/uaccess.h
> > +++ b/arch/powerpc/include/asm/uaccess.h
> > @@ -381,6 +381,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
> >  
> >  	return n;
> >  }
> > +#define copy_mc_to_user copy_mc_to_user  
> 
> Such define looks weird on my eyes. What to do you want to do here?

Ok, other places at uaccess.h have the same pattern. After
sleeping over it, it is now clear to me the rationale:

you're using an inline to enforce typecast check, as using just a
macro won't be doing cast checks.

The define will let to use gcc preprocessor #if/#ifdef logic to check 
if the symbol was defined or not, which makes sense as not all
architectures have it.

Clever.

Patch LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> >  #endif
> >  
> >  extern long __copy_from_user_flushcache(void *dst, const void __user *src,
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index 0f9bab92a43d..309f2439327e 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -497,6 +497,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
> >  
> >  unsigned long __must_check
> >  copy_mc_to_user(void __user *to, const void *from, unsigned len);
> > +#define copy_mc_to_user copy_mc_to_user  
> 
> Same here.
> 
> >  #endif
> >  
> >  /*
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 3064314f4832..0dfa9241b6ee 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -205,6 +205,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
> >  }
> >  #endif
> >  
> > +#ifndef copy_mc_to_user
> > +static inline unsigned long __must_check
> > +copy_mc_to_user(void *dst, const void *src, size_t cnt)
> > +{
> > +	return copy_to_user(dst, src, cnt);
> > +}
> > +#endif
> > +
> >  static __always_inline void pagefault_disabled_inc(void)
> >  {
> >  	current->pagefault_disabled++;  
> 
> 
> 
> Thanks,
> Mauro



Thanks,
Mauro

