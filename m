Return-Path: <linux-kernel+bounces-195337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446298D4B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0C31C22D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2E17FAAB;
	Thu, 30 May 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NLJy8k+4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773017B420
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070749; cv=none; b=q3J9gPp9NpgrtUpUz2hHaVDFmmGSHsTwCmb3gMRDP16XIMVnKQBIr1wS277W9FoReZQGewGPvlDxXsgmThXanr+PFe8+Nkkjjh/lRxgA9lZ4ALcyrcOp8hnwb2u4sUydP3fawh2PRfqj8XE7z3ZxhwYDEpAFNknDPB9MCyj4G5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070749; c=relaxed/simple;
	bh=6DUJ8tsgfrpE7dMN5xMdCi4IdduLwN5+kaoGzysiLws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5Mhh90lE2hLxu/FIub/I19yMP7tTksW9bjtmUpRwChykD2SsuhzhNLKg7ejmyh3GOGb5h0a+XPHQyvazf01cpeeMY1qRRVW/LAWNelPbndpF25BftBCw1/Mv0scXr2iozUUN4OM1zKrOtKOmrscCxFG2DNuTu6K+34Sd/mqmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NLJy8k+4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a89787ea4so64917966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717070744; x=1717675544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Sz6gimwf1g/uM/VSKdjbih5l18TxYGdFz1hq8H1cc4=;
        b=NLJy8k+4nm+KGyY8I6C8gQYzhbfHVEhNlOgQX5NggMNeZENLtziBPvrD1xRC4cx6L1
         lA+IGNWZL7Axe1wpirFLOF0IFZtLOs9JIuqr9SIba6tlsp0YbzJ9mmVkeQ/+nFa5miB6
         jP61DyDmKqQ/cWi81In3RHkL2tymFiA+3K2Eu/byHjSXIiCmA/noRUP97R+TK6jxRx0L
         g0FPcatqI7KeDPPJVH5A1CPrL7uJOFz8tkG+BXyBPsLTXtr8wbNH0rI1O1ycSt9Zd58H
         HE1ACQL5vexebymvKAeuknNjSq/LfUyh8j6/44/IP8zCJAWWyNsyhNJ9jxFDeEp8atup
         T1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717070744; x=1717675544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Sz6gimwf1g/uM/VSKdjbih5l18TxYGdFz1hq8H1cc4=;
        b=ozEWxpRCmai1YhixidDrNQNawAPCClLER1e7jv+ptYCsCRur6V1HknQ/EOYWoL5oZ/
         sLEWR8m+pSM6OVqRGuMocPk3W+Jq960chrJqtG1xG1ovui9hpW3RsN1dYHK5VWQFLtLY
         LKNtuM54AeAoprgcO4y6EE/UQPzcTwhyVjF7ZqnHyOHgHsAWa2q2cV+QeIEb0v+rKu5h
         kB19tDyiRBCXxI3FLV6Hbl7r2DuHVv5zn8nREL106fyTl4zL1byP+GKcv/PHb+wAyfet
         SfygHNSobLv4J1/rp1482tKVFNmwFrjD7sQOhQwbwk3zq2I9hK34TUDhVIyKjS8VBfEw
         rQsA==
X-Forwarded-Encrypted: i=1; AJvYcCVdEl60ff9vLCcT+xDe0mr5uLCRiO4mz0sgnZaT4Gq4b0M0jcoBsBwDpMFTOuB+ndLT8fjMWTa+CzhSDy3Ysmdyv1+Hi2yy0rkGjkZW
X-Gm-Message-State: AOJu0Yz6NzQ7tvW2jRFyWEnhyKmAXpYuFcs/udQV6KrD98BdtxCQTYYP
	LjkHuG5H7R1dN9jS7aJM2WnPhA2hVVoPWysiFWxN3RKKHaBqMjswpfMVUzKP6fUTvg+CodRE/nJ
	PsUE3vJB9jijBJUhFsYsrdtmSyXDGoShKuLsSFw==
X-Google-Smtp-Source: AGHT+IG/YXSYNiT6o3H60M0bRLCqTArznAl+myxGGWTw4/86wdJCt5jT5bYBWxWt9IjzAEOIedJ5eSNcM/ArO6iW/iM=
X-Received: by 2002:a17:906:d784:b0:a59:b88c:2b2a with SMTP id
 a640c23a62f3a-a65e925021dmr114248066b.50.1717070744574; Thu, 30 May 2024
 05:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530075424.380557-1-alexghiti@rivosinc.com> <ZlhpA9NsgI0z6t/E@andrea>
In-Reply-To: <ZlhpA9NsgI0z6t/E@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 30 May 2024 14:05:32 +0200
Message-ID: <CAHVXubi+XW=v=MKDov5j0v2QG-cAMjWxdqMRhgfLmo1JhCkryQ@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix fully ordered LR/SC xchg[8|16]() implementations
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Leonardo Bras <leobras@redhat.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrea,

On Thu, May 30, 2024 at 1:54=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > -#define _arch_xchg(ptr, new, sfx, prepend, append)                   \
> > +#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend, append)       =
       \
> >  ({                                                                   \
> >       __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
> >       __typeof__(*(__ptr)) __new =3D (new);                            =
 \
> > @@ -55,15 +55,15 @@
> >       switch (sizeof(*__ptr)) {                                       \
> >       case 1:                                                         \
> >       case 2:                                                         \
> > -             __arch_xchg_masked(prepend, append,                     \
> > +             __arch_xchg_masked(sc_sfx, prepend, append,             \
> >                                  __ret, __ptr, __new);                \
> >               break;                                                  \
> >       case 4:                                                         \
> > -             __arch_xchg(".w" sfx, prepend, append,                  \
> > +             __arch_xchg(".w" swap_sfx, prepend, append,             \
> >                             __ret, __ptr, __new);                     \
> >               break;                                                  \
> >       case 8:                                                         \
> > -             __arch_xchg(".d" sfx, prepend, append,                  \
> > +             __arch_xchg(".d" swap_sfx, prepend, append,             \
> >                             __ret, __ptr, __new);                     \
> >               break;                                                  \
> >       default:                                                        \
> > @@ -73,16 +73,16 @@
> >  })
> >
> >  #define arch_xchg_relaxed(ptr, x)                                    \
> > -     _arch_xchg(ptr, x, "", "", "")
> > +     _arch_xchg(ptr, x, "", "", "", "")
> >
> >  #define arch_xchg_acquire(ptr, x)                                    \
> > -     _arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
> > +     _arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
> >
> >  #define arch_xchg_release(ptr, x)                                    \
> > -     _arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
> > +     _arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
> >
> >  #define arch_xchg(ptr, x)                                            \
> > -     _arch_xchg(ptr, x, ".aqrl", "", "")
> > +     _arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")
>
> This does indeed fix the fully-ordered variant of xchg8/16().  But this
> also changes the fully-ordered xchg32() to
>
>   amoswap.w.aqrl  a4,a5,(s1)
>   fence   rw,rw
>
> (and similarly for xchg64()); we should be able to restore the original
> mapping with the diff below on top of this patch.

And you already told me that privately...Sorry, my mind has been
elsewhere lately...I'll fix that right now.

Sorry again and thanks,

Alex

>
>   Andrea
>
> P.S. Perhaps expand the width of the macros to avoid newlines (I didn't
> do it keep the diff smaller).
>
> P.S. With Zabha, we'd probably like to pass swap_sfx and swap_append as
> well to __arch_xchg_masked().
>
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index e1e564f5dc7ba..88c8bb7ec1c34 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -46,7 +46,8 @@
>                 : "memory");                                            \
>  })
>
> -#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend, append)         =
       \
> +#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,                 =
       \
> +                  sc_append, swap_append)                              \
>  ({                                                                     \
>         __typeof__(ptr) __ptr =3D (ptr);                                 =
 \
>         __typeof__(*(__ptr)) __new =3D (new);                            =
 \
> @@ -55,15 +56,15 @@
>         switch (sizeof(*__ptr)) {                                       \
>         case 1:                                                         \
>         case 2:                                                         \
> -               __arch_xchg_masked(sc_sfx, prepend, append,             \
> +               __arch_xchg_masked(sc_sfx, prepend, sc_append,          \
>                                    __ret, __ptr, __new);                \
>                 break;                                                  \
>         case 4:                                                         \
> -               __arch_xchg(".w" swap_sfx, prepend, append,             \
> +               __arch_xchg(".w" swap_sfx, prepend, swap_append,        \
>                               __ret, __ptr, __new);                     \
>                 break;                                                  \
>         case 8:                                                         \
> -               __arch_xchg(".d" swap_sfx, prepend, append,             \
> +               __arch_xchg(".d" swap_sfx, prepend, swap_append,        \
>                               __ret, __ptr, __new);                     \
>                 break;                                                  \
>         default:                                                        \
> @@ -73,16 +74,16 @@
>  })
>
>  #define arch_xchg_relaxed(ptr, x)                                      \
> -       _arch_xchg(ptr, x, "", "", "", "")
> +       _arch_xchg(ptr, x, "", "", "", "", "")
>
>  #define arch_xchg_acquire(ptr, x)                                      \
> -       _arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
> +       _arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER, RISCV_ACQUI=
RE_BARRIER)
>
>  #define arch_xchg_release(ptr, x)                                      \
> -       _arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
> +       _arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
>
>  #define arch_xchg(ptr, x)                                              \
> -       _arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")
> +       _arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n", "")
>
>  #define xchg32(ptr, x)                                                 \
>  ({                                                                     \
>

