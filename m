Return-Path: <linux-kernel+bounces-429675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5F9E21C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1FB46D79
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB31F6662;
	Tue,  3 Dec 2024 14:40:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D617BB16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236826; cv=none; b=MRTwcoZmyYFOj1WLslbxUEkPGaaalok8qRpZN9m3LXuAxj/4+wrnCarwtG43AsVZ4gCS3OUg8ahCTR+Hyh8abrShN0uGpCyddAqKUJSylTaWGUMdv3MABGiCAgCa2ygfqd3anT5pJvH/WdxzRS+HTTv9cOR/4NZYnubGMks+T78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236826; c=relaxed/simple;
	bh=ggkZp2gk+k+U7KWgPKDPqffqNctlzmnNifBEPHDISJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMY6YHqppsXV7saP/hGx746STWlmNA5aUAiEENqtxrbw8jw2m5VHnd6+8V6YT30qK9xICI6u6rj1JAtOR4Sd2tgZdTztTtsoqAm5niaaEFBq8lK66LLcWgOFCL5j4L9Spt/wxZndHBTngMKzWIrlYq01pGy6oumjgxcqd9Bowkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90959FEC;
	Tue,  3 Dec 2024 06:40:51 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD36C3F71E;
	Tue,  3 Dec 2024 06:40:22 -0800 (PST)
Date: Tue, 3 Dec 2024 14:40:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: Help with atomic fallback
Message-ID: <Z08YT5nD6uHC-PSm@J2N7QTR9R3.cambridge.arm.com>
References: <20241203003856.GJ1253388@nvidia.com>
 <Z0747n5bSep4_1VX@J2N7QTR9R3>
 <20241203130848.GK1253388@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203130848.GK1253388@nvidia.com>

On Tue, Dec 03, 2024 at 09:08:48AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 03, 2024 at 12:26:22PM +0000, Mark Rutland wrote:
> 
> > I'm assuming that's the report at:
> > 
> >   https://lore.kernel.org/oe-kbuild-all/202411301219.jHkzXdJD-lkp@intel.com/
> > 
> > ... for which the config is:
> > 
> >   https://download.01.org/0day-ci/archive/20241130/202411301219.jHkzXdJD-lkp@intel.com/config
> 
> Yeah, that is representative
> 
> > > Which is immediately because of a typo in atomic-arch-fallback.h code gen:
> > > 
> > > #if defined(arch_cmpxchg64_release)
> > > #define raw_cmpxchg64_release arch_cmpxchg64_release
> > > #elif defined(arch_cmpxchg64_relaxed)
> > > #define raw_cmpxchg64_release(...) \
> > > 	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
> > > #elif defined(arch_cmpxchg64)
> > > #define raw_cmpxchg64_release arch_cmpxchg64
> > > #else
> > > extern void raw_cmpxchg64_release_not_implemented(void);
> > >      ^^^^^^^^^^^^^^^^^^^^^
> > 
> > This means that arc isn't providing a suitable defintion to build
> > raw_cmpxchg64_release() from, or for some reason the header includes up
> > to this point haven't included the relevant definition.
> > 
> > From the ifdeffery, there's no definition of:
> > 
> >   arch_cmpxchg64_release
> >   arch_cmpxchg64_relaxed
> >   arch_cmpxchg64
> > 
> > ... and hence no way to build raw_cmpxchg64_release().
> > 
> > The intent here is to have a build failure at point of use, since some
> > architectures do not or cannot provide these, but we should clean this
> > up to be clearer. The mismatch is intentional and this isn't a typo, but
> > I agree it's not great.
> 
> It is not consistent..
> 
> For instance on ARC io-pgtable-arm.c compiles OK it calls:
> 
> 	old = cmpxchg64_relaxed(ptep, curr, new);
> 
> Which expands to:
> 
>  old = ({ typeof(ptep) __ai_ptr = (ptep); instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); raw_cmpxchg64_relaxed_not_implemented(); });
> 
> And no compiler error. Presumably it doesn't link, but my compiler
> ICE's before it gets that far.

I don't think that "my compiler ICE's" implies "compiles OK".

When building io-pgtable-arm.c for ARC (with your tree!) I see the same error:

| [mark@lakrids:~/src/linux]% git describe HEAD
| v6.13-rc1-19-gf81fe181dcfff
| [mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arc CROSS_COMPILE=arc-linux- drivers/iommu/io-pgtable-arm.o 
|   CC      kernel/bounds.s
|   CC      arch/arc/kernel/asm-offsets.s
|   CALL    scripts/checksyscalls.sh
|   CC      drivers/iommu/io-pgtable-arm.o
| drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
| drivers/iommu/io-pgtable-arm.c:387:13: error: void value not ignored as it ought to be
|   387 |         old = cmpxchg64_relaxed(ptep, curr, new);
|       |             ^
| make[4]: *** [scripts/Makefile.build:194: drivers/iommu/io-pgtable-arm.o] Error 1
| make[3]: *** [scripts/Makefile.build:440: drivers/iommu] Error 2
| make[2]: *** [scripts/Makefile.build:440: drivers] Error 2
| make[1]: *** [/home/mark/src/linux/Makefile:1989: .] Error 2
| make: *** [Makefile:251: __sub-make] Error 2

... so I suspect whatever is causing your toolchain to ICE is masking
that, and (AFAICT) the error is consistent.

Note that per drivers/iommu/{Kconfig,Makefile}, if you build with
CONFIG_GENERIC_ATOMIC64=y, then CONFIG_IOMMU_IO_PGTABLE_LPAE=n and so
io-pgtable-arm.o won't actually be built.

FWIW, I'm using the cross toolchains from:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/

> > In this case I think this is an oversight in the arc code, and arc *can*
> > provide a definition of arch_cmpxchg64(), as per the hack below (which
> > implicilty provides arch_atomic64_cmpxchg*()):
> > 
> > | diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
> > | index 9b5791b854713..ce3fdcb48b0f9 100644
> > | --- a/arch/arc/include/asm/atomic64-arcv2.h
> > | +++ b/arch/arc/include/asm/atomic64-arcv2.h
> > | @@ -137,12 +137,10 @@ ATOMIC64_OPS(xor, xor, xor)
> > |  #undef ATOMIC64_OP_RETURN
> > |  #undef ATOMIC64_OP
> > |  
> > | -static inline s64
> > | -arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> > | +static inline u64
> > | +__arch_cmpxchg64_relaxed(volatile void *ptr, u64 old, u64 new)
> > |  {
> > | -       s64 prev;
> > | -
> > | -       smp_mb();
> > | +       u64 prev;
> > |  
> > |         __asm__ __volatile__(
> > |         "1:     llockd  %0, [%1]        \n"
> > | @@ -152,14 +150,12 @@ arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
> > |         "       bnz     1b              \n"
> > |         "2:                             \n"
> > |         : "=&r"(prev)
> > | -       : "r"(ptr), "ir"(expected), "r"(new)
> > | -       : "cc");        /* memory clobber comes from smp_mb() */
> > | -
> > | -       smp_mb();
> > | +       : "r"(ptr), "ir"(old), "r"(new)
> > | +       : "memory", "cc");
> > |  
> > |         return prev;
> > |  }
> > | -#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
> > | +#define arch_cmpxchg64_relaxed __arch_cmpxchg64_relaxed
> > |  
> > |  static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
> > |  {
> 
> Okay, that is what I was expecting to find, so I can ping the arc
> folks on this direction and maybe get this resolved.. I'll send the
> above to them as a patch to start a discussion

Cool; please Cc me for that.

Mark.

