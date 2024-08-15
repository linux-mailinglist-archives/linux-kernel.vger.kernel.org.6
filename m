Return-Path: <linux-kernel+bounces-288004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4AA952FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C221C24896
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719021A7065;
	Thu, 15 Aug 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U22Ze9XJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E17DA8A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728862; cv=none; b=Q2JX+BlerK/3brz1bh6bNUn0mkWMp1Nr+QKO2YryxCIXRKpEBWodxmeTKmqFM5pGRISI6v9J643Zg69aLPKn7YEGcyRZnnmACP8QoWGEYNbtqPf2HkCkg/aAdXaHojOMzhiVeyFLfqcnJREuVRyhAq5ukjyiaWnk/AwsslsDBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728862; c=relaxed/simple;
	bh=tbWsNgYrDIbnSK7YKq4tQxF5j6rIWuV0/RYeKfcHhxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQz/3xFBuWIOOCVGM6xLXc5RrNFmbUdegfaLmxq98yCOZP8eLDuCky1tcf0AAOx9ywgEibMiJJhvPVYkqmTFKmDM5dsnnIhYW8tkzS9Fy+/SnKQDgBuV+4ydUzrciMP4lneNGRlZcLOz6zE6a23I4JqQNmZ7N5+40s4h5c0R1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U22Ze9XJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1273607a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723728858; x=1724333658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uf+s/T5xCp+3fTbJjT+zyzmVlfgDLq1GD3LsWtGwKVU=;
        b=U22Ze9XJbVvkv6fIeuFD6h5ShFOWFYbcwAROPf8lDoI66/dGxabt+9O0q/54Skb8w1
         ThLky3gN+kGI12A/fANjMZsAnz1XXS0FoHD2vbgnDTzANJ9tLA1Zu5+gEWW2IMEaj54a
         wUlLo4lpfKdqmBAWeizdZpkrYCLQfy4dktvtpjYNYdFBsW+ypuKqMS8S/8xzlsd463H6
         YmO/hC7nWRthhkm3cY+XZujEDa14C7mr8PiTeNEPdiCRlej453AlluSF0K+Wx62el8/N
         Oaaw6ZtX0PQaXncYpdOci18B49WZvtvwgkGqtDXjS5X0He1pVRbrYj28sN40+o+fdQ6r
         YJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728858; x=1724333658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf+s/T5xCp+3fTbJjT+zyzmVlfgDLq1GD3LsWtGwKVU=;
        b=FfyGKrsWkZXjuZpZFWS5PVyYgMv44Jvib4ckO/0dI953o8gixdjGsTPi1CK8RY/FX7
         XM/Hvkd0rNs4JP4u08Urs4TxXRIsxsdncbITuTrxafWdpAGutynNXT8TGgX+b7bVwFOU
         WxtUC1Od1DVgw+2cgubZrurXqWhgIsbtqqPkeYWgmqtARYiK8h8n1djYiKFkvTFsc1wW
         mXmWAXaY4M5EsWjDvyabO1hsXQiciQCYqMIyPcjw96WOvTxERRrWbBVNlnjeocjLcGLA
         ygvIvZaemJI4Chgee9uSt6AsKJrqD8S5hhqjbcaY1Xfu8XWItt2hXG5Xh0Ud3dDVn2Ls
         mS6A==
X-Forwarded-Encrypted: i=1; AJvYcCW/0wxaDcVD4BBkPiE/NuhVMpqSyREwvRbDTV3EH/WqkN8WC5diVdkX0aXkIb0vHfcs6Q+6QPobwwiaeYyp1CHjRxVQ7iIWZw0tXDtD
X-Gm-Message-State: AOJu0Yz/C8YwmmGjZ45qDDedXj7umFFiar88QZQWi+l/3yO6HsCaSvJm
	1DHg3Mh2TK+LIHPnKUfgMxwiMqr7NEmubm/CAwdR3MPn0ZQnd9H78CyPrnnO8jg=
X-Google-Smtp-Source: AGHT+IGJZeX9x/BRQJo3d2wjrrZWdO+Zhhlxj0cF6zy/2fP9OXjfT0TWw6RvV17Cu+G0YZEVeHbTUw==
X-Received: by 2002:a05:6402:50cf:b0:5be:a05a:2e38 with SMTP id 4fb4d7f45d1cf-5bea1cad0a2mr4777968a12.27.1723728857600;
        Thu, 15 Aug 2024 06:34:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe2707sm910747a12.7.2024.08.15.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:34:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:34:16 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
Message-ID: <20240815-17cff9794dd6fb3440478622@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com>
 <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
 <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr>

On Thu, Aug 15, 2024 at 03:27:31PM GMT, Alexandre Ghiti wrote:
> Hi Andrew,
> 
> On 01/08/2024 08:53, Alexandre Ghiti wrote:
> > On Wed, Jul 31, 2024 at 5:29 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > On Wed, Jul 31, 2024 at 09:24:05AM GMT, Alexandre Ghiti wrote:
> > > > In order to produce a generic kernel, a user can select
> > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > > > spinlock implementation if Zabha or Ziccrse are not present.
> > > > 
> > > > Note that we can't use alternatives here because the discovery of
> > > > extensions is done too late and we need to start with the qspinlock
> > > > implementation because the ticket spinlock implementation would pollute
> > > > the spinlock value, so let's use static keys.
> > > > 
> > > > This is largely based on Guo's work and Leonardo reviews at [1].
> > > > 
> > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >   .../locking/queued-spinlocks/arch-support.txt |  2 +-
> > > >   arch/riscv/Kconfig                            | 29 +++++++++++++
> > > >   arch/riscv/include/asm/Kbuild                 |  4 +-
> > > >   arch/riscv/include/asm/spinlock.h             | 43 +++++++++++++++++++
> > > >   arch/riscv/kernel/setup.c                     | 38 ++++++++++++++++
> > > >   include/asm-generic/qspinlock.h               |  2 +
> > > >   include/asm-generic/ticket_spinlock.h         |  2 +
> > > >   7 files changed, 118 insertions(+), 2 deletions(-)
> > > >   create mode 100644 arch/riscv/include/asm/spinlock.h
> > > > 
> > > > diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > > index 22f2990392ff..cf26042480e2 100644
> > > > --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > > +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> > > > @@ -20,7 +20,7 @@
> > > >       |    openrisc: |  ok  |
> > > >       |      parisc: | TODO |
> > > >       |     powerpc: |  ok  |
> > > > -    |       riscv: | TODO |
> > > > +    |       riscv: |  ok  |
> > > >       |        s390: | TODO |
> > > >       |          sh: | TODO |
> > > >       |       sparc: |  ok  |
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index ef55ab94027e..c9ff8081efc1 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -79,6 +79,7 @@ config RISCV
> > > >        select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> > > >        select ARCH_WANTS_NO_INSTR
> > > >        select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > > > +     select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> > > Why do we need this? Also, we presumably would prefer not to have it
> > > when we end up using ticket spinlocks when combo spinlocks is selected.
> > > Is there no way to avoid it?
> > I'll let Andrea answer this as he asked for it.
> > 
> > > >        select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> > > >        select BUILDTIME_TABLE_SORT if MMU
> > > >        select CLINT_TIMER if RISCV_M_MODE
> > > > @@ -488,6 +489,34 @@ config NODES_SHIFT
> > > >          Specify the maximum number of NUMA Nodes available on the target
> > > >          system.  Increases memory reserved to accommodate various tables.
> > > > 
> > > > +choice
> > > > +     prompt "RISC-V spinlock type"
> > > > +     default RISCV_COMBO_SPINLOCKS
> > > > +
> > > > +config RISCV_TICKET_SPINLOCKS
> > > > +     bool "Using ticket spinlock"
> > > > +
> > > > +config RISCV_QUEUED_SPINLOCKS
> > > > +     bool "Using queued spinlock"
> > > > +     depends on SMP && MMU && NONPORTABLE
> > > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > > +     help
> > > > +       The queued spinlock implementation requires the forward progress
> > > > +       guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
> > > > +       LR/SC with Ziccrse provide such guarantee.
> > > > +
> > > > +       Select this if and only if Zabha or Ziccrse is available on your
> > > > +       platform.
> > > Maybe some text recommending combo spinlocks here? As it stands it sounds
> > > like enabling queued spinlocks is a bad idea for anybody that doesn't know
> > > what platforms will run the kernel they're building, which is all distros.
> > That's NONPORTABLE, so people enabling this config are supposed to
> > know that right?
> > 
> > > > +
> > > > +config RISCV_COMBO_SPINLOCKS
> > > > +     bool "Using combo spinlock"
> > > > +     depends on SMP && MMU
> > > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > > +     help
> > > > +       Embed both queued spinlock and ticket lock so that the spinlock
> > > > +       implementation can be chosen at runtime.
> > > nit: Add a blank line here
> > Done
> > 
> > > > +endchoice
> > > > +
> > > >   config RISCV_ALTERNATIVE
> > > >        bool
> > > >        depends on !XIP_KERNEL
> > > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > > > index 5c589770f2a8..1c2618c964f0 100644
> > > > --- a/arch/riscv/include/asm/Kbuild
> > > > +++ b/arch/riscv/include/asm/Kbuild
> > > > @@ -5,10 +5,12 @@ syscall-y += syscall_table_64.h
> > > >   generic-y += early_ioremap.h
> > > >   generic-y += flat.h
> > > >   generic-y += kvm_para.h
> > > > +generic-y += mcs_spinlock.h
> > > >   generic-y += parport.h
> > > > -generic-y += spinlock.h
> > > >   generic-y += spinlock_types.h
> > > > +generic-y += ticket_spinlock.h
> > > >   generic-y += qrwlock.h
> > > >   generic-y += qrwlock_types.h
> > > > +generic-y += qspinlock.h
> > > >   generic-y += user.h
> > > >   generic-y += vmlinux.lds.h
> > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > > new file mode 100644
> > > > index 000000000000..503aef31db83
> > > > --- /dev/null
> > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > @@ -0,0 +1,43 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > > +#define __ASM_RISCV_SPINLOCK_H
> > > > +
> > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > > +
> > > > +#define __no_arch_spinlock_redefine
> > > > +#include <asm/ticket_spinlock.h>
> > > > +#include <asm/qspinlock.h>
> > > > +#include <asm/alternative.h>
> > > We need asm/jump_label.h instead of asm/alternative.h, but...
> > > 
> > > > +
> > > > +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> > > > +
> > > > +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)                   \
> > > > +static __always_inline type arch_spin_##op(type_lock lock)           \
> > > > +{                                                                    \
> > > > +     if (static_branch_unlikely(&qspinlock_key))                     \
> > > > +             return queued_spin_##op(lock);                          \
> > > > +     return ticket_spin_##op(lock);                                  \
> > > > +}
> > > ...do you know what impact this inlined static key check has on the
> > > kernel size?
> > No, I'll check, thanks.
> 
> 
> So I have just checked the size of the jump table section:
> 
> * defconfig:
> 
> - ticket: 26928 bytes
> - combo: 28320 bytes
> 
> So that's a ~5% increase.
> 
> * ubuntu config
> 
> - ticket: 107840 bytes
> - combo: 174752 bytes
> 
> And that's a ~62% increase.
> 
> This is the ELF size difference between ticket and combo spinlocks:
> 
> * ticket: 776915592 bytes
> * combo: 786958968 bytes
> 
> So that's an increase of ~1.3% on the ELF.
> 
> And the .text section size:
> 
> * ticket: 12290960 bytes
> * combo: 12366644 bytes
> 
> And that's a ~0.6% increase!
> 
> Finally, I'd say the impact is very limited :)

Thanks for checking!

drew

