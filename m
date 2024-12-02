Return-Path: <linux-kernel+bounces-428171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E79E0C00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C45AB3F0AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936391DE2A7;
	Mon,  2 Dec 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qDfrXbBu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026F1DDC39
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163986; cv=none; b=kDq6Aos94ZjareFhWPvduChsVp3kXbjtNKX4o6iCJdG38dMU82qV6VXv5OluwO17jKN70HstXJoiihiIbnDLVUi/GBj+0rmZubav5a8sCSsPgZPCh0VzGvTdaTQGEzAg/xq4/JFkE5J9eJ+eFQ2Lo+0BboTbYlETnQDkpzZRI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163986; c=relaxed/simple;
	bh=vGodzCJVBpdbhBU4jIgckviiIENNu2tjMRs7JzTqFBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6uq93wj5xEKqAVKVibLscqNkXicNocT8Buj/IZzeY6rkEcJd7Wt0caj+IfpzJ/dKnX8nouHKC5c4ErVIVPMEpJQLRBZh5kBoTsU3H4APEBA1GJp7A9bNR70aTyFhJJYtr9ulx26S0X7tZkXccwevdx0m5Y1PLpXP6yu7yrPq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qDfrXbBu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21290973bcbso45783835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733163984; x=1733768784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1fSjzDB3EYral3FJfD5w5SvZiqHwVm4ThrouSzXoG0=;
        b=qDfrXbButJqmhV8jhzv1kZ+BR61N+60b7GaCLBJkW0cx4digV75LEO8nqFKT6GwvPF
         oK0uC4YwDFaMWcFnUQcvmkp4sogyA+vp9QKxUCO2MG8ufudsIXHcPqNb6xfNdsnz/JC0
         9RaEzi1dUAumbCuviDU7L5kXxOue1iHXk6EtpAQVkJt4mcjlpeu0P94G+eSTmgAuuJJ3
         UFctMOvAkEvJpevYErnac6CG3cOgm0Grg6Nl+yVIDSqKqRPaQCL3ubgIcVvz0MExW2Gt
         0XuzSPQWzDKzxeKUb5O9zwMBOY124fIJOwXP8DKhN6BGcPd/ZWivGtvv0E2KFPuJPTto
         dwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163984; x=1733768784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1fSjzDB3EYral3FJfD5w5SvZiqHwVm4ThrouSzXoG0=;
        b=dxOX71Y73XZDiUX0l5Lpr4iTzo8kZpkZl7/twKrbAXE/8Ww3bJtDAJvXezSoRX4AZc
         Wi+9tWc7z6UpmB+8cgfISfKqBalplP7xQyWm/7OZB+vNWZe0ze5R4/WrnQ6jY8LfiC4S
         M/8xcMOzEWmB0inSnZekCyDE/E+WPBBKidU8nMW5hUNiGNQy3yn3G+qzBsDoo/UhEBBH
         sD3Jzr0NMRml5xchlrSDV1djVdFZvW+fMbdQ1OquTpJ676gz2QkQhN1hGtm6iC5Czhc5
         Fl4TFf3e4W6/nwCcfDuaCIK8XDhXSmYW4rke4Gjz0qSdR9ste7Dn0ahRPKh6SgfdXQY7
         CMNg==
X-Forwarded-Encrypted: i=1; AJvYcCXS3qWhK1qyfS+N3Bz63t4Ero79ZQRne7sZy5aFzDVPc8nuvYy2St4mdUW/gjG8IFhbTH7SZjNyNn71KmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrmKogWqa6+Al1EToBnrRqcG3uzI4BcqDiaHvEr0b0DQdfHZ2
	htwnGh1KpWTr3QC19BzZ8cQ/xnKEqXaRLaPDk9j2bdD6qRuEkMI/LR3m3b/lIFhQBOyy9rGjtQR
	wHYNJG+nRVS0QHgPQPaJrWdPA114SOEf/SVr2+g==
X-Gm-Gg: ASbGncvFkcRyDFKxLkYAu2lUvw4H9PRbj1iMSrO0rYwQSb7kvdCJAIbddmi2TzhnH1E
	8GT9WiLY9yUZQkU2hs88JEePrSGursA==
X-Google-Smtp-Source: AGHT+IHisvs3rWpMuRQOWixPnTvVtgjxW+u1yNS90T+VjRikLrDQHeBjU8J20X11uqJqFe47EIY9Qqlj+A9dyAN+3sc=
X-Received: by 2002:a17:902:f54c:b0:215:8695:ef91 with SMTP id
 d9443c01a7336-2158695f663mr92656975ad.6.1733163984202; Mon, 02 Dec 2024
 10:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
 <20241119-pmu_event_info-v1-2-a4f9691421f8@rivosinc.com> <77b7b44f-e05a-4845-8d45-0e0d831bb8e7@ghiti.fr>
In-Reply-To: <77b7b44f-e05a-4845-8d45-0e0d831bb8e7@ghiti.fr>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 2 Dec 2024 10:26:13 -0800
Message-ID: <CAHBxVyHZvLrKNCAPJfHxYYn30Mm++J=mff+tVU9GZ_8rt3WnEg@mail.gmail.com>
Subject: Re: [PATCH 2/8] drivers/perf: riscv: Fix Platform firmware event data
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:10=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Atish,
>
> On 19/11/2024 21:29, Atish Patra wrote:
> > Platform firmware event data field is allowed to be 62 bits for
> > Linux as uppper most two bits are reserved to indicate SBI fw or
> > platform specific firmware events.
> > However, the event data field is masked as per the hardware raw
> > event mask which is not correct.
> >
> > Fix the platform firmware event data field with proper mask.
> >
> > Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware ev=
ent handling")
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/sbi.h |  1 +
> >   drivers/perf/riscv_pmu_sbi.c | 12 +++++-------
> >   2 files changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 98f631b051db..9be38b05f4ad 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -158,6 +158,7 @@ struct riscv_pmu_snapshot_data {
> >   };
> >
> >   #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
> > +#define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
> >   #define RISCV_PMU_RAW_EVENT_IDX 0x20000
> >   #define RISCV_PLAT_FW_EVENT 0xFFFF
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index cb98efa9b106..50cbdbf66bb7 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -508,7 +508,6 @@ static int pmu_sbi_event_map(struct perf_event *eve=
nt, u64 *econfig)
> >   {
> >       u32 type =3D event->attr.type;
> >       u64 config =3D event->attr.config;
> > -     u64 raw_config_val;
> >       int ret;
> >
> >       /*
> > @@ -529,21 +528,20 @@ static int pmu_sbi_event_map(struct perf_event *e=
vent, u64 *econfig)
> >       case PERF_TYPE_RAW:
> >               /*
> >                * As per SBI specification, the upper 16 bits must be un=
used
> > -              * for a raw event.
> > +              * for a hardware raw event.
> >                * Bits 63:62 are used to distinguish between raw events
> >                * 00 - Hardware raw event
> >                * 10 - SBI firmware events
> >                * 11 - Risc-V platform specific firmware event
> >                */
> > -             raw_config_val =3D config & RISCV_PMU_RAW_EVENT_MASK;
> > +
> >               switch (config >> 62) {
> >               case 0:
> >                       ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > -                     *econfig =3D raw_config_val;
> > +                     *econfig =3D config & RISCV_PMU_RAW_EVENT_MASK;
> >                       break;
> >               case 2:
> > -                     ret =3D (raw_config_val & 0xFFFF) |
> > -                             (SBI_PMU_EVENT_TYPE_FW << 16);
> > +                     ret =3D (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_F=
W << 16);
> >                       break;
> >               case 3:
> >                       /*
> > @@ -552,7 +550,7 @@ static int pmu_sbi_event_map(struct perf_event *eve=
nt, u64 *econfig)
> >                        * Event data - raw event encoding
> >                        */
> >                       ret =3D SBI_PMU_EVENT_TYPE_FW << 16 | RISCV_PLAT_=
FW_EVENT;
> > -                     *econfig =3D raw_config_val;
> > +                     *econfig =3D config & RISCV_PMU_PLAT_FW_EVENT_MAS=
K;
> >                       break;
> >               }
> >               break;
> >
>
> It seems independent from the other patches, so I guess we should take
> it for 6.13 rcX.
>

Yes. This patch doesn't have any SBI v3.0 dependencies. I will send
this patch separately
so that it can be applied for 6.13 rcX

> Let me know if that's not the case.
>
> Thanks,
>
> Alex
>

