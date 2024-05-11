Return-Path: <linux-kernel+bounces-176439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56118C2FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70A6B20FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504974C65;
	Sat, 11 May 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGkVoDnU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B388A55
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715410219; cv=none; b=H6xccpi6riu4CD6CG7aR3t9aSQ2OSu1BbjoSN91aNWcTN9XjsLDub/uaMpR9kwEEYp96FqlpdkeNVHEYGszA1mpq9br29gYXSQvKhD9PwWtZ84Y6OvVSRgkR8MPLD8vhAzLdTpLVLXBEttwhDW1rtbIY4OrW5nPZ68CbX1g7PZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715410219; c=relaxed/simple;
	bh=lblVBvZuddzuH51cR8bOvxbCQSkyGJaGFeuYszSiyVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZaPrPTTpwj3qlpHh6SMyuXplx5Hz67eFRd3AssXVPkBga4iusei5nzbgMSue70u9y0XWUeIkoOYm6rfYVH9eoyNq/LSTtO8otPGPiMc9I6Q+fAcI2SnQR/PNvMwGrNLogWW8Wb7Bm98DS0qPgZtBhIJV0Gtb3jf65eEycmIaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGkVoDnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270FEC2BD10;
	Sat, 11 May 2024 06:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715410219;
	bh=lblVBvZuddzuH51cR8bOvxbCQSkyGJaGFeuYszSiyVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGkVoDnUyxFEG56w7+HuB2jpgmBVaJMMe6Fv4rXtMdyTjoVePK7lwdsQN6/yRI4zC
	 fF4GtCGRoWEI/y6eom0/Wx6eUsQj02VA/s2biezFods6BpGUs3nhJn8hghTDmbwNyx
	 LI5kuaTCMtvLNluAbzC/eXJQ+BZlLiN2xA6BN0NeHkJWQZuJEwlDqqVELHU0Yo84nR
	 mH0ezWfY9CbT7B88ziN7GTsrLuyIc3kZSBaAfKUvy9oJKWFJvxcae0sh+qXNshrPJB
	 3sZ7Q/YFs+qD2RCS0xMjl2sTQMbMj+7st0WeeiDdKyGVu+CElQu48tpS9lXWUY4ioY
	 gMMhUwb5yMsSQ==
Date: Sat, 11 May 2024 02:50:13 -0400
From: Guo Ren <guoren@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
	linux-riscv@lists.infradead.org, palmer@dabbelt.com
Subject: Re: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <Zj8VJZmQC7hRzDdz@gmail.com>
References: <20240401213950.3910531-8-paulmck@kernel.org>
 <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>

On Thu, Apr 04, 2024 at 07:15:40AM -0700, Palmer Dabbelt wrote:
> On Mon, 01 Apr 2024 14:39:50 PDT (-0700), paulmck@kernel.org wrote:
> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > and two-byte cmpxchg() on riscv.
> > 
> > [ paulmck: Apply kernel test robot feedback. ]
> 
> I'm not entirely following the thread, but sounds like there's going to be
> generic kernel users of this now?  Before we'd said "no" to the byte/half
> atomic emulation routines beacuse they weren't used, but if it's a generic
> thing then I'm find adding them.
> 
> There's a patch set over here
> <https://lore.kernel.org/all/20240103163203.72768-2-leobras@redhat.com/>
> that implements these more directly using LR/SC.  I was sort of on the fence
> about just taking it even with no direct users right now, as the byte/half
> atomic extension is working its way through the spec process so we'll have
> them for real soon.  I stopped right there for the last merge window,
> though, as I figured it was too late to be messing with the atomics...
> 
> So
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
F.Y.I Leonardo Bras <leobras@redhat.com>

> 
> if you guys want to take some sort of tree-wide change to make the byte/half
> stuff be required everywhere.  We'll eventually end up with arch routines
> for the extension, so at that point we might as well also have the more
> direct LR/SC flavors.
> 
> If you want I can go review/merge that RISC-V patch set and then it'll have
> time to bake for a shared tag you can pick up for all this stuff?  No rush
> on my end, just LMK.
> 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: <linux-riscv@lists.infradead.org>
> > ---
> >  arch/riscv/Kconfig               |  1 +
> >  arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56b..4eaf40d0a52ec 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -44,6 +44,7 @@ config RISCV
> >  	select ARCH_HAS_UBSAN
> >  	select ARCH_HAS_VDSO_DATA
> >  	select ARCH_KEEP_MEMBLOCK if ACPI
> > +	select ARCH_NEED_CMPXCHG_1_2_EMU
> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> >  	select ARCH_STACKWALK
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 2fee65cc84432..a5b377481785c 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/bug.h>
> > 
> >  #include <asm/fence.h>
> > +#include <linux/cmpxchg-emu.h>
> > 
> >  #define __xchg_relaxed(ptr, new, size)					\
> >  ({									\
> > @@ -170,6 +171,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -214,6 +221,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -260,6 +273,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			RISCV_RELEASE_BARRIER				\
> > @@ -306,6 +325,12 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> > +	case 2:								\
> > +		break;							\
> > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> 

