Return-Path: <linux-kernel+bounces-176728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3A8C33C6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1FC1C20A83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25F2230F;
	Sat, 11 May 2024 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVFBlu4o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F021CA82
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715460327; cv=none; b=l7KHYsH0dAMwoBjEDxjxbzQyAr58XMLk1x0j4AU2Prq/VTJ7Iyn9RkY1TcPT3LNfH47q8KHuDy4WtdfaVsvOfI7dXt0e+7RUqHLIOZEheIKhkdW/iP4MaEPIm2Bg9VqE6kCWiDXfFo9YG7sQljvhBfPK7lpLTs3ILCrggDKJbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715460327; c=relaxed/simple;
	bh=UUBRpIxqzJzv8CLrX7S/rTo83oADo+b3z/j9k+7/saI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=HjRORbJCUDdHeha82IHoPkXzm5GxB+BRud1S3jOtlrPsBtG1wazK3ztErQL+OJUmN4fO6vhDg77DFEmkFCGCIyt90z42fkD1HCNgZqtMaDQ6TmtFMneWiZ/MRfrsZdN5wH8l+wzyh1L27t/DiFO4O2jTctN7t1DIMpZEg7x+UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVFBlu4o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715460323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aytntv1qSTgscf/fVVlEX6NWoKqZCFoCqwsJ0PcuQPc=;
	b=fVFBlu4oLLpm50+Rhb+dnBVQh7K4LBG1MJROdsGafzgWM2y7XpNsowYuLQUyZ4Wl5VYAJc
	lDxoGhlBp3X63nlYL83hvIXIadk2HYA+GtKxdiWpANOz4lr8bwHCadrJo3dB/QUwolL41o
	pVfBbkZROI075g5BeBUBetUFfcqw/u0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-iwQYYHgmO02SN70ELjtrCQ-1; Sat, 11 May 2024 16:45:08 -0400
X-MC-Unique: iwQYYHgmO02SN70ELjtrCQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ec5ce555f6so29836225ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715460307; x=1716065107;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aytntv1qSTgscf/fVVlEX6NWoKqZCFoCqwsJ0PcuQPc=;
        b=t9u+2TVr21SLVKchvCRzWk8QbLAHxaeVdpyLtRsVmyh8OrlHLVTHNsl3+XL5p/mHr5
         QAJ8BjRHbFoptR+fWhKpl6q+r5DNFr0jC3oFDnV9cHBczY+Il4XulARLe/tv2AIEJLR5
         Txug/LxpWeH8kVVaP65orPFm31/osyPj41EwsfOaYvNQhie6je1ENHV1fIrfrsTIvyvK
         8u6mJZy3EL7uWc1c34CYVpN6JTiqgiXe1pkZezMzO7X1PKjYILh9bEhkd2dPKUQ9LXHD
         4d8joIvvYKSHijReYXp+QkteT57vewOjib/mJjKOo/I4nESGaEv2GihjCYbZi2heYX2z
         zO0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIUHX2IDANux6smpDgZZOMpOrbJ3upmdDBd56/1noJJDP3/QIUSKwQVY50gDck5z+gfhHHi1wbgjtbltd2GPIxxDtJxzei27tJ9VEm
X-Gm-Message-State: AOJu0YxXNljzfDIYegd/C8ZRoEPpyEmqRImv5tcqDimkt+1goA0iUACo
	aTLpirufSAigMRVPLZdKuVY/+/HFeppYWLDIHoRd0I7TDdVFgw4z0EjrOOPYjWpu46JGLaO1WPB
	FyccguMvTULpWM5w6KwQNxId/wHvc3Vd6N6c55wuIgMgnSCE0ONjay7aKUQZpmA==
X-Received: by 2002:a17:903:11c3:b0:1e1:a54:1fe8 with SMTP id d9443c01a7336-1ef4404fbf7mr74832685ad.53.1715460307056;
        Sat, 11 May 2024 13:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHd5kExNw6uk9rCQMxKchlCbKxofARlkPukmoGeSmHapRj2YEf/B/7sssUzviPfVwRSzUk8w==
X-Received: by 2002:a17:903:11c3:b0:1e1:a54:1fe8 with SMTP id d9443c01a7336-1ef4404fbf7mr74832535ad.53.1715460306663;
        Sat, 11 May 2024 13:45:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:a9e8:e01f:c640:3398:ffe5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2555casm52362025ad.284.2024.05.11.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 13:45:05 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	andi.shyti@linux.intel.com,
	andrzej.hajda@intel.com,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com
Subject: Re: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte cmpxchg
Date: Sat, 11 May 2024 17:44:46 -0300
Message-ID: <Zj_YvmjROzW6NAog@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <9a84b94c-34ff-4c3a-ab2b-2741a5755db9@paulmck-laptop>
References: <20240401213950.3910531-8-paulmck@kernel.org> <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a> <Zj8VJZmQC7hRzDdz@gmail.com> <9a84b94c-34ff-4c3a-ab2b-2741a5755db9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, May 11, 2024 at 07:54:34AM -0700, Paul E. McKenney wrote:
> On Sat, May 11, 2024 at 02:50:13AM -0400, Guo Ren wrote:
> > On Thu, Apr 04, 2024 at 07:15:40AM -0700, Palmer Dabbelt wrote:
> > > On Mon, 01 Apr 2024 14:39:50 PDT (-0700), paulmck@kernel.org wrote:
> > > > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> > > > and two-byte cmpxchg() on riscv.
> > > > 
> > > > [ paulmck: Apply kernel test robot feedback. ]
> > > 
> > > I'm not entirely following the thread, but sounds like there's going to be
> > > generic kernel users of this now?  Before we'd said "no" to the byte/half
> > > atomic emulation routines beacuse they weren't used, but if it's a generic
> > > thing then I'm find adding them.
> > > 
> > > There's a patch set over here
> > > <https://lore.kernel.org/all/20240103163203.72768-2-leobras@redhat.com/>
> > > that implements these more directly using LR/SC.  I was sort of on the fence
> > > about just taking it even with no direct users right now, as the byte/half
> > > atomic extension is working its way through the spec process so we'll have
> > > them for real soon.  I stopped right there for the last merge window,
> > > though, as I figured it was too late to be messing with the atomics...
> > > 
> > > So
> > > 
> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > F.Y.I Leonardo Bras <leobras@redhat.com>

Hi Guo Ren, thanks for bringing it to my attention.

I am quite excited about the inclusion of my patchset on riscv/cmpxchg, and 
I hope it can be useful both to your qspinlock implementation and on Paul's 
RCU improvement.

> 
> I am carrying this in -rcu, but only for testing purposes, not for
> inclusion into mainline.  Not that I know of anyone testing -rcu on
> RISC-V, but still, I wouldn't want to do anything do discourage such
> testing.
> 
> The reason that this patch is no longer intended for inclusion is that it
> has been obsoleted by a patch that provides native support for one-byte
> and two-byte cmpxchg() operations.  Which is even better!  ;-)
> 
> 							Thanx, Paul

Thanks Paul!
Months ago I have reworked cmpxchg and added those 1-byte and 2-byte 
{cmp,}xchg asm implementations using lr/sc, as they would be useful to Guo 
Ren's qspinlock, and I am thankful that you provided another use case, 
because it provides more proof of it's usefulness.

Thanks!
Leo

> 
> > > if you guys want to take some sort of tree-wide change to make the byte/half
> > > stuff be required everywhere.  We'll eventually end up with arch routines
> > > for the extension, so at that point we might as well also have the more
> > > direct LR/SC flavors.
> > > 
> > > If you want I can go review/merge that RISC-V patch set and then it'll have
> > > time to bake for a shared tag you can pick up for all this stuff?  No rush
> > > on my end, just LMK.
> > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > > > Cc: <linux-riscv@lists.infradead.org>
> > > > ---
> > > >  arch/riscv/Kconfig               |  1 +
> > > >  arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index be09c8836d56b..4eaf40d0a52ec 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -44,6 +44,7 @@ config RISCV
> > > >  	select ARCH_HAS_UBSAN
> > > >  	select ARCH_HAS_VDSO_DATA
> > > >  	select ARCH_KEEP_MEMBLOCK if ACPI
> > > > +	select ARCH_NEED_CMPXCHG_1_2_EMU
> > > >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> > > >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> > > >  	select ARCH_STACKWALK
> > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > > index 2fee65cc84432..a5b377481785c 100644
> > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/bug.h>
> > > > 
> > > >  #include <asm/fence.h>
> > > > +#include <linux/cmpxchg-emu.h>
> > > > 
> > > >  #define __xchg_relaxed(ptr, new, size)					\
> > > >  ({									\
> > > > @@ -170,6 +171,12 @@
> > > >  	__typeof__(*(ptr)) __ret;					\
> > > >  	register unsigned int __rc;					\
> > > >  	switch (size) {							\
> > > > +	case 1:								\
> > > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > > +		break;							\
> > > > +	case 2:								\
> > > > +		break;							\
> > > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > > >  	case 4:								\
> > > >  		__asm__ __volatile__ (					\
> > > >  			"0:	lr.w %0, %2\n"				\
> > > > @@ -214,6 +221,12 @@
> > > >  	__typeof__(*(ptr)) __ret;					\
> > > >  	register unsigned int __rc;					\
> > > >  	switch (size) {							\
> > > > +	case 1:								\
> > > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > > +		break;							\
> > > > +	case 2:								\
> > > > +		break;							\
> > > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > > >  	case 4:								\
> > > >  		__asm__ __volatile__ (					\
> > > >  			"0:	lr.w %0, %2\n"				\
> > > > @@ -260,6 +273,12 @@
> > > >  	__typeof__(*(ptr)) __ret;					\
> > > >  	register unsigned int __rc;					\
> > > >  	switch (size) {							\
> > > > +	case 1:								\
> > > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > > +		break;							\
> > > > +	case 2:								\
> > > > +		break;							\
> > > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > > >  	case 4:								\
> > > >  		__asm__ __volatile__ (					\
> > > >  			RISCV_RELEASE_BARRIER				\
> > > > @@ -306,6 +325,12 @@
> > > >  	__typeof__(*(ptr)) __ret;					\
> > > >  	register unsigned int __rc;					\
> > > >  	switch (size) {							\
> > > > +	case 1:								\
> > > > +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > > > +		break;							\
> > > > +	case 2:								\
> > > > +		break;							\
> > > > +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> > > >  	case 4:								\
> > > >  		__asm__ __volatile__ (					\
> > > >  			"0:	lr.w %0, %2\n"				\
> > > 
> 


