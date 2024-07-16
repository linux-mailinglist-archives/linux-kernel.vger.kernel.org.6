Return-Path: <linux-kernel+bounces-253756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DB932669
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964211F22F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270D19923E;
	Tue, 16 Jul 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m81PWCUS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844B17CA15
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132413; cv=none; b=Lg8oVW0YXk4udjD6TfM+9VchH4HVmvfuqE71X7pkyJjLJ9VRXeiE28Bq9Hdz00cCsj5RTqi3rpDgFyofHUxhMx6DmyxfLSczI4wcG7C3cAhwb+nTREHFiM00nzvbZVHGG4vOCqBbTeuGmyutotctNeGgLcotuSgl6g4MBZzvMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132413; c=relaxed/simple;
	bh=NPFmz/N6G3Ip3lB/40h8jCNz3HQpYtZd62s4Uir8yVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJtP2QKapnRuafEx0TAxZUYx9y6c1rShTnQbkvSyPuYZWvFlWcpaO4cRJjKakNEr+e9y1EnRAO3FoL9y6zQxGYsI0WaJzz1FBHz/xrmRB2vEbX8Ifcve8dobZqkLFkAPgfqMtE7uEfEdYOjcKUwq5HYgL3xtofKlL3KrBFWUbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m81PWCUS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77cb7c106dso634501866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721132409; x=1721737209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wgyK3rI/+GRYXc3I3puXIGSeacbfUlZLjUaC5dlWKs=;
        b=m81PWCUSKVoucZp1MciQ0ROjqMYeWq30mutTME71+Ze4PetsOU/Po1WY64iGU3Cq0f
         uJYmkSmn9zLARYfzqWhiCfNFy29fljpudhlUwT2ptODTh25buk9XKGOGF7YUBHu+YeId
         KREfsUbYrnYRE03IFqRjj/yHU3rd1hxzlEq2T5mE6URyjBAQSdNrA/YysAAMhvxU2fXQ
         QYV/fu+mhL4T/xilppRMbll5NdNYZu+XsSPn+KuAGbLpf+F79d9Otzwc2J5DEEDbZa5f
         2q03ZPG0iDTXLCte1jqnnW0fbRGwLGgLK19ufdkiENM7yALZ9TVtwEdWug5kC5sbFiBK
         588g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721132409; x=1721737209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wgyK3rI/+GRYXc3I3puXIGSeacbfUlZLjUaC5dlWKs=;
        b=r4+RvSzf9uHxfUAAaJ4ejsZqtPP0yBYLeQExcG10WzzWlS28Do7zqSXKm25P9/D0Mg
         jkKddz0fvuV4vwDV8hCgBKw3yVN3H9Qan7O6U7uku5FXz4TEtrcQi9uYrH23eIjzI4FO
         8Z3V+pxWCL4SV7uL4JNlih5TbUuzLBRSYjxHrzzpgbZgGV43dgok4TZpl7qjj+hkzdh4
         BTI6pETgxxji+HQqel6fOhuewOrph5f2u2po+l8+kGfWdifyK9GA6Mp+Q65umiY6e0NO
         xErdpVp31W4AtKRmZ2azn5RnWkOhlEFxnxY11en/6TLMGQB/TqROUvIJ9M6nGHea8VTh
         Eg1g==
X-Forwarded-Encrypted: i=1; AJvYcCVCyJpAOITgMHT/oex9WLJPZE5DLCkFquLutozlEd3tA35jdVtKaM1M1SmKZEjcCDjM+uPo/sXOyhjx9okmmuGI0bDTuH0oSddaM0As
X-Gm-Message-State: AOJu0YyIOLJzdeReF8FRLrNVOuWMQeKkJCwCrggyOFqRyIJAHxIalP81
	USlmZnRkfVA+37420hxjf8GXWjw2ZkfvP5GV6Hc8CxyLEtGYmU/o+0bFT6DA3RSZEKt3FVrS/CC
	16O1/3eWXmgdO78bCLytPdGO7tkvIKGKJopjIZw==
X-Google-Smtp-Source: AGHT+IG9FrD1fBVgqj60WTDAt3AQCQU/Sf+dX7Y3PES5xjXq+TMnTztj457Qr4E/dPajDDm9BXML7CFjSdsFPn+WNxQ=
X-Received: by 2002:a17:906:2409:b0:a6f:c268:ff2e with SMTP id
 a640c23a62f3a-a79ea3d7952mr139799466b.5.1721132408420; Tue, 16 Jul 2024
 05:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-2-alexghiti@rivosinc.com>
 <202407041157.odTZAYZ6-lkp@intel.com> <20240705172750.GF987634@thelio-3990X>
In-Reply-To: <20240705172750.GF987634@thelio-3990X>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 16 Jul 2024 14:19:57 +0200
Message-ID: <CAHVXubhvk_CbBX=hWFGt+1HEM4cj=cAc1NsCEknn=B8UDcXVSQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
To: Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Fri, Jul 5, 2024 at 7:27=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Thu, Jul 04, 2024 at 11:38:46AM +0800, kernel test robot wrote:
> > Hi Alexandre,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on soc/for-next]
> > [also build test ERROR on linus/master v6.10-rc6 next-20240703]
> > [cannot apply to arnd-asm-generic/master robh/for-next tip/locking/core=
]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/=
riscv-Implement-cmpxchg32-64-using-Zacas/20240627-034946
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for=
-next
> > patch link:    https://lore.kernel.org/r/20240626130347.520750-2-alexgh=
iti%40rivosinc.com
> > patch subject: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Z=
acas
> > config: riscv-randconfig-002-20240704 (https://download.01.org/0day-ci/=
archive/20240704/202407041157.odTZAYZ6-lkp@intel.com/config)
> > compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7c=
bf1a2591520c2491aa35339f227775f4d3adf6)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240704/202407041157.odTZAYZ6-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto s=
tatement to one of its possible targets
> >                    if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UN=
SET))
> >                        ^
> >    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded fr=
om macro 'try_cmpxchg'
> >            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> >            ^
> >    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded fr=
om macro 'raw_try_cmpxchg'
> >            ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
> >                   ^
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded fr=
om macro 'raw_cmpxchg'
> >    #define raw_cmpxchg arch_cmpxchg
> >                        ^
> >    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'a=
rch_cmpxchg'
> >            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw=
\n")
> >            ^
> >    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_=
arch_cmpxchg'
> >                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,  =
    \
> >                    ^
> >    arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '_=
_arch_cmpxchg'
> >                    asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,        =
    \
> >                    ^
> >    kernel/sched/core.c:11840:7: note: possible target of asm goto state=
ment
> >            if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
> >                 ^
> >    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded fr=
om macro 'try_cmpxchg'
> >            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> >            ^
> >    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded fr=
om macro 'raw_try_cmpxchg'
> >            ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
> >                   ^
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded fr=
om macro 'raw_cmpxchg'
> >    #define raw_cmpxchg arch_cmpxchg
> >                        ^
> >    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'a=
rch_cmpxchg'
> >            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw=
\n")
> >            ^
> >    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_=
arch_cmpxchg'
> >                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,  =
    \
> >                    ^
> >    arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '=
__arch_cmpxchg'
> >                                                                        =
    \
> >                                                                        =
    ^
> >    kernel/sched/core.c:11872:2: note: jump exits scope of variable with=
 __attribute__((cleanup))
> >            scoped_guard (irqsave) {
> >            ^
> >    include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_gu=
ard'
> >            for (CLASS(_name, scope)(args),                             =
    \
> >                              ^
> >    kernel/sched/core.c:11840:7: error: cannot jump from this asm goto s=
tatement to one of its possible targets
> >            if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
> >                 ^
> >    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded fr=
om macro 'try_cmpxchg'
> >            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> >            ^
> >    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded fr=
om macro 'raw_try_cmpxchg'
> >            ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
> >                   ^
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded fr=
om macro 'raw_cmpxchg'
> >    #define raw_cmpxchg arch_cmpxchg
> >                        ^
> >    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'a=
rch_cmpxchg'
> >            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw=
\n")
> >            ^
> >    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_=
arch_cmpxchg'
> >                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,  =
    \
> >                    ^
> >    arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '_=
_arch_cmpxchg'
> >                    asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,        =
    \
> >                    ^
> >    kernel/sched/core.c:11873:7: note: possible target of asm goto state=
ment
> >                    if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UN=
SET))
> >                        ^
> >    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded fr=
om macro 'try_cmpxchg'
> >            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> >            ^
> >    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded fr=
om macro 'raw_try_cmpxchg'
> >            ___r =3D raw_cmpxchg((_ptr), ___o, (_new)); \
> >                   ^
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded fr=
om macro 'raw_cmpxchg'
> >    #define raw_cmpxchg arch_cmpxchg
> >                        ^
> >    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'a=
rch_cmpxchg'
> >            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw=
\n")
> >            ^
> >    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_=
arch_cmpxchg'
> >                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,  =
    \
> >                    ^
> >    arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '=
__arch_cmpxchg'
> >                                                                        =
    \
> >                                                                        =
    ^
> >    kernel/sched/core.c:11872:2: note: jump bypasses initialization of v=
ariable with __attribute__((cleanup))
> >            scoped_guard (irqsave) {
> >            ^
> >    include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_gu=
ard'
> >            for (CLASS(_name, scope)(args),                             =
    \
> >                              ^
> >    2 errors generated.
>
> Ugh, this is an unfortunate interaction with clang's jump scope analysis
> and asm goto in LLVM releases prior to 17 :/
>
> https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1645979=
992
>
> Unfortunately, 'if (0)' does not prevent this (the analysis runs early
> in the front end as far as I understand it), we would need to workaround
> this with full preprocessor guards...

Thanks for jumping in on this one, I was quite puzzled :)

>
> Another alternative would be to require LLVM 17+ for RISC-V, which may
> not be the worst alternative, since I think most people doing serious
> work with clang will probably be living close to tip of tree anyways
> because of all the extension work that goes on upstream.

Stupid question but why the fix in llvm 17 was not backported to
previous versions?

Anyway, I'd rather require llvm 17+ than add a bunch of preprocessor
guards in this file (IIUC what you said above) as it is complex
enough.

@Conor Dooley @Palmer Dabbelt WDYT? Is there any interest in
supporting llvm < 17? We may encounter this bug again in the future so
I'd be in favor of moving to llvm 17+.

Thanks again Nathan,

Alex

>
> I am open to other thoughts though.
>
> Cheers,
> Nathan

