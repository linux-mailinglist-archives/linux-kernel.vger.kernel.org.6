Return-Path: <linux-kernel+bounces-252585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E3931595
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441971C20B66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF718D4C8;
	Mon, 15 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yEq5yxV1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA618C334
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049638; cv=none; b=W5awacLHDuW7bsaL11hGjTAo71t/duMv92i5TPMwAEW2Myh1GxIUuFkOO9TligaKhjs5E8UYgDiSPZVcyUg+Cv+hIJ8hSMFsgspeS+oNRTqmgHGJ6kn7/nImsW7cfDq8N31fvJmCxgcE+BJMOT8vPgUa+z6KiqZrZo8k+zWhX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049638; c=relaxed/simple;
	bh=DKghIp3mdaF6wsn+ZKDLJpLvG1IF6GuDVGLTJivsIDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heBRYI0BSEpVqrYCOPErJuDwk+Ytq1R/Nbd/PFBmOgYYoe/wnQeVyu605BCqtV5rz0lUcN8sjuscCXo3uATWAY/O2VYovtxScYRUJW8w0SmZW50APZ73ZXYsrbhEjT1DayhniKXlsDZBbK7qpJy0gbefeJyjg7+uasRwOsmQfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yEq5yxV1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c4309fc8so551603166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721049635; x=1721654435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q/umhqYRQFF9gIX3sjpRcWSrKq6ad5xqF6eq9M8uvo=;
        b=yEq5yxV18k9CfK569hB+sE2+tIPJsIvBcjPNHGpO7htFuwVNIqnoWuvQc6/U/U40uD
         NticwcU/oi8MTZmIvUX7yCOo9+0QpXqo0Z8zKrfcaPlcfZNrT1/i/MtZsYoyfX0Qe8EQ
         Nbj1NLJEWDCBrOohfzRWSjIoIHJJMKVMce6GcigpHykneyanexQyC9PMTBldzizhy2gI
         qOZEOhd/XEYN6nJX5/hTFZkmB/NPLxHF+lNUi/QSRwjM/f6S4t5g2Ia9HSWWBxo87JjY
         5j53ayYTLpbnxDLF6lwo4IBbwLhma9GAZANvD2s3NdzERkSKvhpfESWa01Zxb9EN3Lcl
         WBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721049635; x=1721654435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q/umhqYRQFF9gIX3sjpRcWSrKq6ad5xqF6eq9M8uvo=;
        b=LrlddCKXf6PAUnkISVbG2TSigwxVeqGlNY7umV0Ptqd+N6bFGYe+83oQ9J07HZjM6t
         cAtciTxMzSKDMXbX3DyCwQGXYwMJ2kUoJZxihVca/J8xvkLtyZZpfnuMELod+ysJCmjg
         QbhKyH9Ne/y6y6qQDmtFIdgcye2tIfqrBkYpiWr6wOjeBIU1VEMspDV2AmRUmNtxvcZR
         Wk+UrplRCX+ZIFT3hqMdgfWh5+s0IAXn7szp+Z7Rqw6i0hriSpxWfalGcWSWie/zp6b2
         6mERmMIONHNhEJ11okOeoGS+X/9CfVujDmmGg3CIR9fcAJhirmTsvVOvkyULFN9BE8NE
         6DQg==
X-Forwarded-Encrypted: i=1; AJvYcCVGENeLKQV/GY+0S4B2bP/kb89HtOIRnkmj5zzdyFaajMuvfJ8AnhuJtOgHkvu1ESE3PuRFQWUXIm/iiZeVzEHUlNFWhjRtIpicDMii
X-Gm-Message-State: AOJu0YxjE4vRQboQtPmbk9yqRHZdF0hYZl88kV1FyI+WHR16xmJObAY9
	C0cyhFXCaUgbZjLyPHdLJCU1ge47OhefVLjP9OoFECr1dUHBEMxXTaHP+GuKIBMKSE1Ji/6J/EB
	10PbyvVgsqbnepL9mRePTh8OxE6lAngG5oL64zw==
X-Google-Smtp-Source: AGHT+IFdF+/LtyeYj3Tk4XoOO84vKXOBe831P7Ek8js3dWW0Y+/JENU6/4aF5U6MzfFFI+qsKGvMaDgUtV6qoyJuIy0=
X-Received: by 2002:a17:907:1c10:b0:a72:4b4a:a626 with SMTP id
 a640c23a62f3a-a780b89dde4mr1606680766b.68.1721049634725; Mon, 15 Jul 2024
 06:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-7-alexghiti@rivosinc.com> <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRiQ_zXDAa+Q7rQ4U8qfFGu_ab-y-cLSSOyUVyp0o8KvQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 15:20:23 +0200
Message-ID: <CAHVXubiVrNzSona97CyuT3rbFJjU4MFB_x8xxLrnce77KmABYA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
To: Guo Ren <guoren@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Wed, Jul 10, 2024 at 3:37=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Jun 26, 2024 at 9:10=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > This adds runtime support for Zabha in xchg8/16() operations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 33 +++++++++++++++++++++++++++++---
> >  arch/riscv/include/asm/hwcap.h   |  1 +
> >  arch/riscv/kernel/cpufeature.c   |  1 +
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index da42f32ea53d..eb35e2d30a97 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -11,8 +11,17 @@
> >  #include <asm/fence.h>
> >  #include <asm/alternative.h>
> >
> > -#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)          =
 \
> > +#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,      =
 \
> > +                          swap_append, r, p, n)                       =
 \
> >  ({                                                                    =
 \
> > +       __label__ zabha, end;                                          =
 \
> > +                                                                      =
 \
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                      =
 \
> > +               asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,           =
 \
> > +                                    RISCV_ISA_EXT_ZABHA, 1)           =
 \
> > +                        : : : : zabha);                               =
 \
> > +       }                                                              =
 \
> > +                                                                      =
 \
> Could we exchange the sequence between Zabha & lr/sc?
> I mean:
> nop -> zabha
> j -> lr/sc
>

Yes, you're right, it makes more sense this way. I'll do that.

Thanks,

Alex

>
> >         u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);                  =
   \
> >         ulong __s =3D ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE=
;  \
> >         ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)=
   \
> > @@ -28,12 +37,25 @@
> >                "        or   %1, %1, %z3\n"                            =
 \
> >                "        sc.w" sc_sfx " %1, %1, %2\n"                   =
 \
> >                "        bnez %1, 0b\n"                                 =
 \
> > -              append                                                  =
 \
> > +              sc_append                                               =
         \
> >                : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr32b))  =
     \
> >                : "rJ" (__newx), "rJ" (~__mask)                         =
 \
> >                : "memory");                                            =
 \
> >                                                                        =
 \
> >         r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);            =
   \
> > +       goto end;                                                      =
 \
> > +                                                                      =
 \
> > +zabha:
> jump lr/sc implementation because it's already slow.
>                                                                \
> > +       if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {                      =
 \
> > +               __asm__ __volatile__ (                                 =
 \
> > +                       prepend                                        =
 \
> > +                       "       amoswap" swap_sfx " %0, %z2, %1\n"     =
 \
> > +                       swap_append                                    =
         \
> > +                       : "=3D&r" (r), "+A" (*(p))                     =
   \
> > +                       : "rJ" (n)                                     =
 \
> > +                       : "memory");                                   =
 \
> > +       }                                                              =
 \
> > +end:;                                                                 =
 \
> >  })
> >
> >  #define __arch_xchg(sfx, prepend, append, r, p, n)                    =
 \
> > @@ -56,8 +78,13 @@
> >                                                                        =
 \
> >         switch (sizeof(*__ptr)) {                                      =
 \
> >         case 1:                                                        =
 \
> > +               __arch_xchg_masked(sc_sfx, ".b" swap_sfx,              =
 \
> > +                                  prepend, sc_append, swap_append,    =
 \
> > +                                  __ret, __ptr, __new);               =
 \
> > +               break;                                                 =
 \
> >         case 2:                                                        =
 \
> > -               __arch_xchg_masked(sc_sfx, prepend, sc_append,         =
 \
> > +               __arch_xchg_masked(sc_sfx, ".h" swap_sfx,              =
 \
> > +                                  prepend, sc_append, swap_append,    =
 \
> >                                    __ret, __ptr, __new);               =
 \
> >                 break;                                                 =
 \
> >         case 4:                                                        =
 \
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index e17d0078a651..f71ddd2ca163 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -81,6 +81,7 @@
> >  #define RISCV_ISA_EXT_ZTSO             72
> >  #define RISCV_ISA_EXT_ZACAS            73
> >  #define RISCV_ISA_EXT_XANDESPMU                74
> > +#define RISCV_ISA_EXT_ZABHA            75
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG     127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 5ef48cb20ee1..c125d82c894b 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >         __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> >         __RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> > +       __RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
> >         __RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >         __RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >         __RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
>  Guo Ren

