Return-Path: <linux-kernel+bounces-429437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5589E1C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B55128350B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F31E5000;
	Tue,  3 Dec 2024 12:26:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D711E47A6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228798; cv=none; b=ceNr8AoNnicVuAx+/WWZYVgtTo8t6wHiYUqa4YjFm10V46FD0aKAU6wbHOR/6lZArDMKfcuIbVarxB6ut3xG8sAQrlzE9KLNnp8U1kIm3BHcP/Uzr15zZYfV3ypykinKBzJIhP44CVffZdSfPMmTlIsgQ7+H/fk8hT7hwfoMb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228798; c=relaxed/simple;
	bh=4RnOKptB94SO2bFhv67ipSP7R0mT3WdRHm7+gxkVwy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDJ7lSum0VA/pY5m7xN3loRh7zQabz8n2YEW+6C/hv9p6Ez+67CsA8Q/mYEynAVB5TiaAIiyKn3f9vXkKbVsHqJfL2Yicoco3HSVNYzE6r6pRANmTvplucIOqf0/6g/ma4SS+hIv6GYxhTc67+nDaE+WUykfFyKQJ+JGwjaOqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0137BFEC;
	Tue,  3 Dec 2024 04:27:02 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E2AC3F58B;
	Tue,  3 Dec 2024 04:26:32 -0800 (PST)
Date: Tue, 3 Dec 2024 12:26:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: Help with atomic fallback
Message-ID: <Z0747n5bSep4_1VX@J2N7QTR9R3>
References: <20241203003856.GJ1253388@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203003856.GJ1253388@nvidia.com>

On Mon, Dec 02, 2024 at 08:38:56PM -0400, Jason Gunthorpe wrote:
> Hi Mark/Uros,

Hi Jason,

> I hope one of you can help me unravel this, I'm trying to use
> try_cmpxchg64_release() from driver code and 0-day is saying arc
> compiles explode:
> 
>    In file included from include/linux/atomic.h:80,
>                     from drivers/iommu/generic_pt/fmt/../pt_defs.h:17,
>                     from drivers/iommu/generic_pt/fmt/iommu_template.h:35,
>                     from drivers/iommu/generic_pt/fmt/iommu_armv8_4k.c:13:
>    drivers/iommu/generic_pt/fmt/../pt_defs.h: In function 'pt_table_install64':
> >> include/linux/atomic/atomic-arch-fallback.h:295:14: error: void value not ignored as it ought to be
>      295 |         ___r = raw_cmpxchg64_release((_ptr), ___o, (_new)); \
>          |              ^
>    include/linux/atomic/atomic-instrumented.h:4937:9: note: in expansion of macro 'raw_try_cmpxchg64_release'
>     4937 |         raw_try_cmpxchg64_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/iommu/generic_pt/fmt/../pt_defs.h:144:16: note: in expansion of macro 'try_cmpxchg64_release'
>      144 |         return try_cmpxchg64_release(entryp, &old_entry, table_entry);

I'm assuming that's the report at:

  https://lore.kernel.org/oe-kbuild-all/202411301219.jHkzXdJD-lkp@intel.com/

... for which the config is:

  https://download.01.org/0day-ci/archive/20241130/202411301219.jHkzXdJD-lkp@intel.com/config

> Which is immediately because of a typo in atomic-arch-fallback.h code gen:
> 
> #if defined(arch_cmpxchg64_release)
> #define raw_cmpxchg64_release arch_cmpxchg64_release
> #elif defined(arch_cmpxchg64_relaxed)
> #define raw_cmpxchg64_release(...) \
> 	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
> #elif defined(arch_cmpxchg64)
> #define raw_cmpxchg64_release arch_cmpxchg64
> #else
> extern void raw_cmpxchg64_release_not_implemented(void);
>      ^^^^^^^^^^^^^^^^^^^^^

This means that arc isn't providing a suitable defintion to build
raw_cmpxchg64_release() from, or for some reason the header includes up
to this point haven't included the relevant definition.

From the ifdeffery, there's no definition of:

  arch_cmpxchg64_release
  arch_cmpxchg64_relaxed
  arch_cmpxchg64

... and hence no way to build raw_cmpxchg64_release().

The intent here is to have a build failure at point of use, since some
architectures do not or cannot provide these, but we should clean this
up to be clearer. The mismatch is intentional and this isn't a typo, but
I agree it's not great.

> That should return int to make the compiler happy, but then it will
> fail to link (I think, my cross compiler ICEs before it gets there)
> 
> However, arc defines:
> 
> static inline s64
> arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> {
>
> And I see a:
> 
> static __always_inline s64
> raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
> {
> #if defined(arch_atomic64_cmpxchg_release)
> 	return arch_atomic64_cmpxchg_release(v, old, new);
> #elif defined(arch_atomic64_cmpxchg_relaxed)
> 	__atomic_release_fence();
> 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
> #elif defined(arch_atomic64_cmpxchg)
> 	return arch_atomic64_cmpxchg(v, old, new);
> 
> Which seems to strongly imply that arc can do the cmpxchg64_release
> primitive.
> 
> But I haven't been able to figure out what is expected here for
> arch_atomic64 vs try_cmpxchg64 to guess what is missing part here :\

In this case I think this is an oversight in the arc code, and arc *can*
provide a definition of arch_cmpxchg64(), as per the hack below (which
implicilty provides arch_atomic64_cmpxchg*()):

| diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
| index 9b5791b854713..ce3fdcb48b0f9 100644
| --- a/arch/arc/include/asm/atomic64-arcv2.h
| +++ b/arch/arc/include/asm/atomic64-arcv2.h
| @@ -137,12 +137,10 @@ ATOMIC64_OPS(xor, xor, xor)
|  #undef ATOMIC64_OP_RETURN
|  #undef ATOMIC64_OP
|  
| -static inline s64
| -arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
| +static inline u64
| +__arch_cmpxchg64_relaxed(volatile void *ptr, u64 old, u64 new)
|  {
| -       s64 prev;
| -
| -       smp_mb();
| +       u64 prev;
|  
|         __asm__ __volatile__(
|         "1:     llockd  %0, [%1]        \n"
| @@ -152,14 +150,12 @@ arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
|         "       bnz     1b              \n"
|         "2:                             \n"
|         : "=&r"(prev)
| -       : "r"(ptr), "ir"(expected), "r"(new)
| -       : "cc");        /* memory clobber comes from smp_mb() */
| -
| -       smp_mb();
| +       : "r"(ptr), "ir"(old), "r"(new)
| +       : "memory", "cc");
|  
|         return prev;
|  }
| -#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
| +#define arch_cmpxchg64_relaxed __arch_cmpxchg64_relaxed
|  
|  static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
|  {

However, there are other cases where cmpxchg64 doesn't exist or cannot
be used, and the existing (x86-specific) system_has_cmpxchg64() isn't
ideal. I suspect we need both a Kconfig symbol and a runtime check to
handle this properly.

I think if we fix up arc along the lines of the above (with xchg too,
and handled in the cmpxchg header), then we can rely on the Kconfig
check that the existing io-pgtable code has:

  depends on !GENERIC_ATOMIC64    # for cmpxchg64()

... and we'll (separately) need to figure out what to do for the runtime
system_has_cmpxchg64() check.

Mark.

