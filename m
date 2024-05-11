Return-Path: <linux-kernel+bounces-176589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6188C31F6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998281F21767
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2356740;
	Sat, 11 May 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZurLr3OX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2856446
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439275; cv=none; b=qI49qvj1P/J55Sh8zkRUXr4fd3FQGUhUmQTbUra3PakZjrfiLxbRlhYDsirG0NfjpnVf19/4aNuhtEyuwvdPnBgX+tH38qJI5cYAMpDWjPNq7BMJTC21NQjOI/AyMjY0Y4tr7MosGXHtzXT8Ya28OawRqm6hJ+N1qt7D9jo70bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439275; c=relaxed/simple;
	bh=rubNTKa3Iwun2UymZEiP0WYCh3XNAOyMB5tCLTlUEFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwfp8FyGuqOleCNJNJRyq9r0cgP9xzSkZoQu2cXiIXs+bM+fvU06G8ZE/2czHIGRKGMTUKAkWPoi7y5GFLfr0U9xadIfRmZdoI4Siy3JvJi4aSEMu2j6df5kUXIv8SOSEk7EG9/JaQTTXbeq5nEkblcOsXt48+AWHFP7skBmu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZurLr3OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B401FC2BBFC;
	Sat, 11 May 2024 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715439274;
	bh=rubNTKa3Iwun2UymZEiP0WYCh3XNAOyMB5tCLTlUEFI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZurLr3OXzHvnrGXTC0m0EjbLQcWxLY8Sd8TfY83aiW61ZZyjC3/e9a5GbfnLII4JF
	 FCKllJgagsqPk15iOK2VWkzCZmj3LgADqytPr/xUK+PLOmy9LWyWiyayqjsBShNIDb
	 Bzr9KMT/T7u/hKYD03UhBobomiFLb/cS2nIyumnYQR0lT6LPBSNdhirExo+dph3oWh
	 M6O9zEvCuCx9S6AheT3VDcXuNBBgIH6TcV8sB8q/tgagCXjwE1OEuGEzS9XzekDbK0
	 t+AlY31dWNadimMISPDEx95SGQMPUqcx+KhON7uRXBSvxH9WuCqy3pg8rK5Rc91JB0
	 WbQxFumacovNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 595AECE0F8E; Sat, 11 May 2024 07:54:34 -0700 (PDT)
Date: Sat, 11 May 2024 07:54:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, andi.shyti@linux.intel.com,
	andrzej.hajda@intel.com, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com
Subject: Re: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <9a84b94c-34ff-4c3a-ab2b-2741a5755db9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240401213950.3910531-8-paulmck@kernel.org>
 <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>
 <Zj8VJZmQC7hRzDdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj8VJZmQC7hRzDdz@gmail.com>

On Sat, May 11, 2024 at 02:50:13AM -0400, Guo Ren wrote:
> On Thu, Apr 04, 2024 at 07:15:40AM -0700, Palmer Dabbelt wrote:
> > On Mon, 01 Apr 2024 14:39:50 PDT (-0700), paulmck@kernel.org wrote:
> > > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > > and two-byte cmpxchg() on riscv.
> > > 
> > > [ paulmck: Apply kernel test robot feedback. ]
> > 
> > I'm not entirely following the thread, but sounds like there's going to be
> > generic kernel users of this now?  Before we'd said "no" to the byte/half
> > atomic emulation routines beacuse they weren't used, but if it's a generic
> > thing then I'm find adding them.
> > 
> > There's a patch set over here
> > <https://lore.kernel.org/all/20240103163203.72768-2-leobras@redhat.com/>
> > that implements these more directly using LR/SC.  I was sort of on the fence
> > about just taking it even with no direct users right now, as the byte/half
> > atomic extension is working its way through the spec process so we'll have
> > them for real soon.  I stopped right there for the last merge window,
> > though, as I figured it was too late to be messing with the atomics...
> > 
> > So
> > 
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> F.Y.I Leonardo Bras <leobras@redhat.com>

I am carrying this in -rcu, but only for testing purposes, not for
inclusion into mainline.  Not that I know of anyone testing -rcu on
RISC-V, but still, I wouldn't want to do anything do discourage such
testing.

The reason that this patch is no longer intended for inclusion is that it
has been obsoleted by a patch that provides native support for one-byte
and two-byte cmpxchg() operations.  Which is even better!  ;-)

							Thanx, Paul

> > if you guys want to take some sort of tree-wide change to make the byte/half
> > stuff be required everywhere.  We'll eventually end up with arch routines
> > for the extension, so at that point we might as well also have the more
> > direct LR/SC flavors.
> > 
> > If you want I can go review/merge that RISC-V patch set and then it'll have
> > time to bake for a shared tag you can pick up for all this stuff?  No rush
> > on my end, just LMK.
> > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > > Cc: <linux-riscv@lists.infradead.org>
> > > ---
> > >  arch/riscv/Kconfig               |  1 +
> > >  arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index be09c8836d56b..4eaf40d0a52ec 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -44,6 +44,7 @@ config RISCV
> > >  	select ARCH_HAS_UBSAN
> > >  	select ARCH_HAS_VDSO_DATA
> > >  	select ARCH_KEEP_MEMBLOCK if ACPI
> > > +	select ARCH_NEED_CMPXCHG_1_2_EMU
> > >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> > >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> > >  	select ARCH_STACKWALK
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > index 2fee65cc84432..a5b377481785c 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/bug.h>
> > > 
> > >  #include <asm/fence.h>
> > > +#include <linux/cmpxchg-emu.h>
> > > 
> > >  #define __xchg_relaxed(ptr, new, size)					\
> > >  ({									\
> > > @@ -170,6 +171,12 @@
> > >  	__typeof__(*(ptr)) __ret;					\
> > >  	register unsigned int __rc;					\
> > >  	switch (size) {							\
> > > +	case 1:								\
> > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > +		break;							\
> > > +	case 2:								\
> > > +		break;							\
> > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > >  	case 4:								\
> > >  		__asm__ __volatile__ (					\
> > >  			"0:	lr.w %0, %2\n"				\
> > > @@ -214,6 +221,12 @@
> > >  	__typeof__(*(ptr)) __ret;					\
> > >  	register unsigned int __rc;					\
> > >  	switch (size) {							\
> > > +	case 1:								\
> > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > +		break;							\
> > > +	case 2:								\
> > > +		break;							\
> > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > >  	case 4:								\
> > >  		__asm__ __volatile__ (					\
> > >  			"0:	lr.w %0, %2\n"				\
> > > @@ -260,6 +273,12 @@
> > >  	__typeof__(*(ptr)) __ret;					\
> > >  	register unsigned int __rc;					\
> > >  	switch (size) {							\
> > > +	case 1:								\
> > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > +		break;							\
> > > +	case 2:								\
> > > +		break;							\
> > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > >  	case 4:								\
> > >  		__asm__ __volatile__ (					\
> > >  			RISCV_RELEASE_BARRIER				\
> > > @@ -306,6 +325,12 @@
> > >  	__typeof__(*(ptr)) __ret;					\
> > >  	register unsigned int __rc;					\
> > >  	switch (size) {							\
> > > +	case 1:								\
> > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > +		break;							\
> > > +	case 2:								\
> > > +		break;							\
> > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > >  	case 4:								\
> > >  		__asm__ __volatile__ (					\
> > >  			"0:	lr.w %0, %2\n"				\
> > 

