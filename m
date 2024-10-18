Return-Path: <linux-kernel+bounces-371274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DD9A3905
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F37F1C23616
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771F5190054;
	Fri, 18 Oct 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRDr5Lu"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13E18EFF1;
	Fri, 18 Oct 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241217; cv=none; b=Pkrl7bs/gqutoIAsULzxzawFpB/p1ZYrU7w4cyvQvpO2a1YKW7BFT4rQz/7sVYfrfq/gGLph6+AuGxK5Je6JyM+oLdSWgGjmNyGTiaC+Cg1rzciMDUJZk45/nUKlOCr5rlE7370WOa0MnysHysxASpV4xpyJM9qDVoflaTgAns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241217; c=relaxed/simple;
	bh=tfE4V3W8ykmNE09bvwGw+LdTUj5YFdV78WhZB/lzxR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgGnR1+USbOyVF8hQUZNOb21yDjTmyfCn1uUkQbasWVh4OPUtkOLjZ9mSUWOkeZn29kNx/u6hBQCwCft0SYV1284Na0UhO4WV1N8vZLGwqdC+q4ZcgGFYo3j6EWc+UDNaEkrmaE27Sfs48WAU0bUOfc3+Jn15KRtMC4fMQQotzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRDr5Lu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso19334181fa.2;
        Fri, 18 Oct 2024 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729241214; x=1729846014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftsjmpU0affWST2ixW5xYnYew3ZAwBw9E/4OsheRmi8=;
        b=fhRDr5LuL+r5j+pmpagL/+glG2lj5zgm+ErqVXvfsjBUm8MHMmk+WSzIHytYq+qTgm
         OT3XxEerpnFfAyZ+jlEdbieqv/thVquj9npRuTSt80NiBw2Lro2kBWokjeiUdz3srq6+
         q/CpPnH4CTNiGxB6u2EtftW3UWV7boRoV8t9uKG2gaSWLZQt6ypNVmZwVIE+Lnpmoj7O
         0SgniLxJLNHUsIXR7Cr2Cxa3Kv9+pKx8uTrd7uKGc5yCdNtSaBNDQuWCBmP60LtUpjXq
         rODcXT1LwuuxlX+4PmSc9lmvmnI2X4UtIGcFZM9RkWemTPZssXjkv+mZvPSSrwI+Q5fs
         HA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729241214; x=1729846014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftsjmpU0affWST2ixW5xYnYew3ZAwBw9E/4OsheRmi8=;
        b=DAGLDAbpMIS+pmCx/SNyZShDGU2GOtMZBun4+ldP5BxR3zBxX1t3XwnrrIe5//6Uue
         +B0J4tkE7PM6vBqiYddompDD5szLXGGfai5AHO2kybcANKyxJyiGeiOX1MDLrzqV4Zfc
         yURA1dasFVplBdRK5mmTNGFPNIvbFjieeEvUz9oxPQbBD93xW82L2bx5tkSJE/AS1q/u
         10f3rhmxIgj0yKE7IzlLTZVPl6bG75cN1pDJeUCM16V0LHyeqIR1AEecmkpsaIL1Kun4
         pg8IoISR9RpE7WOVkUAaCYWEk+S80OvoKK0VwjmGQjqF9AALmSGb7wy1ocH14nLQvazQ
         ouqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcaALFTUaxdaATezby4ffYuWS0c1v3nA9a26uW5WvvFWsRMr1hNQXUxaKfMfFoHx9asFR2uk77YWKjqtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWp+oTSeLYcAG36FPPU47dQG/E4ljflX1ObSGIRiC0ACK8VHTA
	mgwtwHMFmgNpPEi3lz4FnLCEcur8k4LXL1/giPXSAcRDX80yNbTIP8rNQvLcY2joweaNqBhonW3
	Vl0RreKYCfP85hsF626sAejI4p2zG8ZneiQdl1sDg
X-Google-Smtp-Source: AGHT+IEXYTlUVTz6d9hr6wtJg18uXsksAynXi0Q8ifViYQ6L4DUtCzdSzNGLed1bEO0ib551F1BEc3HUTw69WFEA1x4=
X-Received: by 2002:a2e:4a19:0:b0:2fa:d84a:bd83 with SMTP id
 38308e7fff4ca-2fb82fb1e9dmr5696031fa.24.1729241213929; Fri, 18 Oct 2024
 01:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008054615.43062-1-yang.li85200@gmail.com>
 <20241016095626.8162-1-yang.li85200@gmail.com> <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
 <CA+N+=zu0=scmv9w7iZE2ZebxBVpvVb1eeoJ-qi=vhac-JhLthg@mail.gmail.com>
In-Reply-To: <CA+N+=zu0=scmv9w7iZE2ZebxBVpvVb1eeoJ-qi=vhac-JhLthg@mail.gmail.com>
From: yang li <yang.li85200@gmail.com>
Date: Fri, 18 Oct 2024 16:46:42 +0800
Message-ID: <CA+N+=zsB=wd2G-nsYT9xxvsgBMtnOMUJb8ru8XHaqusX2nzzEg@mail.gmail.com>
Subject: Re: [PATCH v2] csky: fix csky_cmpxchg_fixup not working
To: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo Ren:
I used the readelf tool to view the address of csky_cmpxchg_ldw,
and used printk("0x%x\n",csky_cmpxchg_ldw) and
printk("0x%x\n",&csky_cmpxchg_ldw) to print it out in the code.
 The result is that printk("0x%x\n",&csky_cmpxchg_ldw) prints the
correct result.

include/linux/linkage.h
#define GLOBAL(name)  \
        .globl name ASM_NL \
        name:
#endif

arch/csky/kernel/atomic.S:
GLOBAL(csky_cmpxchg_ldw)
so
.globl  csky_cmpxchg_ldw   --->globl symbol
csky_cmpxchg_ldw:             --->label symbol


yang li <yang.li85200@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Guo Ren:
> I used the readelf tool to view the address of csky_cmpxchg_ldw,
> and used printk("0x%x\n",csky_cmpxchg_ldw) and
> printk("0x%x\n",&csky_cmpxchg_ldw) to print it out in the code.
>  The result is that printk("0x%x\n",&csky_cmpxchg_ldw) prints the
> correct result.
>
> include/linux/linkage.h
> #define GLOBAL(name)  \
>         .globl name ASM_NL \
>         name:
> #endif
>
> arch/csky/kernel/atomic.S:
> GLOBAL(csky_cmpxchg_ldw)
> so
> .globl  csky_cmpxchg_ldw   --->globl symbol
> csky_cmpxchg_ldw:             --->label symbol
>
>
>
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8817=E6=97=A5=
=E5=91=A8=E5=9B=9B 14:05=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Oct 16, 2024 at 5:56=E2=80=AFPM Yang Li <yang.li85200@gmail.com>=
 wrote:
>> >
>> > In the csky_cmpxchg_fixup function, it is incorrect to use the global
>> >  variable csky_cmpxchg_stw to determine the address where the exceptio=
n
>> >  occurred.The global variable csky_cmpxchg_stw stores the opcode at th=
e
>> >  time of the exception, while &csky_cmpxchg_stw shows the address wher=
e
>> >  the exception occurred.
>> >
>> > Signed-off-by: Yang Li <yang.li85200@gmail.com>
>> > ---
>> > V1 -> V2:Eliminate compilation warnings
>> >
>> >  arch/csky/mm/fault.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
>> > index a885518ce1dd..5226bc08c336 100644
>> > --- a/arch/csky/mm/fault.c
>> > +++ b/arch/csky/mm/fault.c
>> > @@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs=
 *regs)
>> >         if (trap_no(regs) !=3D VEC_TLBMODIFIED)
>> >                 return;
>> >
>> > -       if (instruction_pointer(regs) =3D=3D csky_cmpxchg_stw)
>> > -               instruction_pointer_set(regs, csky_cmpxchg_ldw);
>> > +       if (instruction_pointer(regs) =3D=3D (unsigned long)&csky_cmpx=
chg_stw)
>> > +               instruction_pointer_set(regs, (unsigned long)&csky_cmp=
xchg_ldw);
>> csky_cmpxchg_ldw(stw) is a label symbol, not a variable.
>>
>> arch/csky/kernel/atomic.S:
>> GLOBAL(csky_cmpxchg_ldw)
>> GLOBAL(csky_cmpxchg_stw)
>>
>> Your modification does not affect the ASM output.
>>
>> (gdb) p main
>> $1 =3D {void (void)} 0x5fa <main>
>> (gdb) p &main
>> $2 =3D (void (*)(void)) 0x5fa <main>
>>
>> >         return;
>> >  }
>> >  #endif
>> > --
>> > 2.34.1
>> >
>>
>>
>> --
>> Best Regards
>>  Guo Ren

