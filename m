Return-Path: <linux-kernel+bounces-428518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0889E0F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6094AB234B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423A1370;
	Tue,  3 Dec 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ovKzJy+Y"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085564D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184936; cv=none; b=ILy/09SJ9v/0W667DldqdBzR0m7N2uD3WGUuhvZ6mrcqrnFAOn0Sz8XJSNV+riQZnw1afCOVB3II3OSGUTDJQVpGQabxjtgx0EovRwIwOqQikq2QTXLeBprrIhl5r8VYp0QPJl3ZBT+7MUtMauCsADbBPuZrbFvsfydBPcVZtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184936; c=relaxed/simple;
	bh=r0YDfQRpMEbID59vFjWbfe/cgrEj5t8qE0gvWCUMUrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4S/4yPS81AQx1EFBCRVpbSiGmXsZBtaWfBz6bgSmN6NTee0mqgqZYLqk3qnlTFclDANmGdUUZ+3eBeoI/rNMOhQTwYq83oBiCABT8m9Su+dTis7QQEkq6E4qzFYx4puLbqfsCOr/vKIqFqG8ybF551xnT3qaFijHsWP4qAOW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ovKzJy+Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso4160542b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733184934; x=1733789734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+YlV66sEeV5Gi1JEnWTwo3a+A+kAB7BmLzMmDK0RYY=;
        b=ovKzJy+YOLwww/ObTOZTaGhWoyxvWJgWCkkFRPayduzbl3n3BThwwa8r+0wqRwMzWj
         T3vm2iZo1/26rDvBivf6sYnYPm0AyLJkHAFCjAXv3UiP3KsU5J3eZPxhJPJuXfPwOM6c
         rWfBe0hHCxl7uoyqzLdZjBF5DFdtGHKiTaxsCZlZrM3l67bfk4ch8BhjocILbpaNGNOs
         BHSINwFUapr25U0xWlFozAwk+GjQ0EbJfbcw2cPeiFJhQWo/FvYFniUArQUyVuxgOFeg
         UyO2QBPpGO67ZoGqCs4bS/jlOISEFkvq+32fADf8zOFZ8S+y0qu8pB4+k17MA6FAciXQ
         w8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184934; x=1733789734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+YlV66sEeV5Gi1JEnWTwo3a+A+kAB7BmLzMmDK0RYY=;
        b=di6FCKOkMdbDn8LU/C5GsF2VC419Umoq2j4slFo2SNM4HlwvGJSeS0mRbSSE1idpW2
         7DKKIdf0h6r7JchT0cbNevWBnxlB/21iZu/e3+j8/sVj05dexoOrlzTY3CvSSBg300dJ
         frRB9nkgrMgxThDkaiuDK4rt6i/Fyy1DGvjhSFHJ+NR427Uol5NwPVICVwiFit6Yb/S2
         K0A1yF/uB9nwjNsm+MhdoS+U/6X+yb9Ch2Cb/eVGQJOtmDa4MAypWVywmEmiEhHQHCZ8
         voEeFy0iNJoM66CP/FfT0tzhM0sC5SmE7rbZ75DjmTSaCGaBglWQFv3EwVTDV4u8mXuh
         znyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfOE5Vt6/p0ZEy5JE9bkUQHSjEPj0b9lMR3nAT0Os824Akl/EypuwcDWQOmBBAo3gP6qXLlVJ0vqbM/Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1IgzqJaApEPQGkYNRYh9L0yrA13RDg6vn/kzKgochRb+2sDv
	9FS0SCrQ9ynZIPwQkbRPLdK7rzrCOM2eCQE0ZjD2wf8mOQFem9MOaz1wFCl55a8eWGsWXeotOvr
	IF/k94guyuEbZz96o9v6nhttnFlC2zZK8nBZadg==
X-Gm-Gg: ASbGncvpEh3IFxVCL13ht09Jh6ca7wzpTsaT9ObuMkxoTWcvFOQjtfvQVM1FACc1LS6
	w+GabEcV8ZUd3jPBt+F2x7VU+HgKQgg==
X-Google-Smtp-Source: AGHT+IHkfSZg8nwRSMyT59R8Thc83SJq1L85mjo/aMDSMjUafqwNxe8ioi4sjLMkGcNLINNqRnY9VhmQH6Pl1GzeePc=
X-Received: by 2002:a17:90b:4f4e:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2ef012796c8mr807474a91.35.1733184934283; Mon, 02 Dec 2024
 16:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
 <20241119-pmu_event_info-v1-3-a4f9691421f8@rivosinc.com> <e124c532-7a08-4788-843d-345827e35f5f@sifive.com>
In-Reply-To: <e124c532-7a08-4788-843d-345827e35f5f@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 2 Dec 2024 16:15:23 -0800
Message-ID: <CAHBxVyEwkPUcut0L7K9eewcmhOOidU16WnGRiPiP3D7-OS7HvQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] drivers/perf: riscv: Add raw event v2 support
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:37=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Atish,
>
> On 2024-11-19 2:29 PM, Atish Patra wrote:
> > SBI v3.0 introduced a new raw event type that allows wider
> > mhpmeventX width to be programmed via CFG_MATCH.
> >
> > Use the raw event v2 if SBI v3.0 is available.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h |  4 ++++
> >  drivers/perf/riscv_pmu_sbi.c | 18 ++++++++++++------
> >  2 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 9be38b05f4ad..3ee9bfa5e77c 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -159,7 +159,10 @@ struct riscv_pmu_snapshot_data {
> >
> >  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
> >  #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
> > +/* SBI v3.0 allows extended hpmeventX width value */
> > +#define RISCV_PMU_RAW_EVENT_V2_MASK GENMASK_ULL(55, 0)
> >  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
> > +#define RISCV_PMU_RAW_EVENT_V2_IDX 0x30000
> >  #define RISCV_PLAT_FW_EVENT  0xFFFF
> >
> >  /** General pmu event codes specified in SBI PMU extension */
> > @@ -217,6 +220,7 @@ enum sbi_pmu_event_type {
> >       SBI_PMU_EVENT_TYPE_HW =3D 0x0,
> >       SBI_PMU_EVENT_TYPE_CACHE =3D 0x1,
> >       SBI_PMU_EVENT_TYPE_RAW =3D 0x2,
> > +     SBI_PMU_EVENT_TYPE_RAW_V2 =3D 0x3,
> >       SBI_PMU_EVENT_TYPE_FW =3D 0xf,
> >  };
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 50cbdbf66bb7..f0e845ff6b79 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -59,7 +59,7 @@ asm volatile(ALTERNATIVE(                            =
               \
> >  #define PERF_EVENT_FLAG_USER_ACCESS  BIT(SYSCTL_USER_ACCESS)
> >  #define PERF_EVENT_FLAG_LEGACY               BIT(SYSCTL_LEGACY)
> >
> > -PMU_FORMAT_ATTR(event, "config:0-47");
> > +PMU_FORMAT_ATTR(event, "config:0-55");
> >  PMU_FORMAT_ATTR(firmware, "config:62-63");
> >
> >  static bool sbi_v2_available;
> > @@ -527,18 +527,24 @@ static int pmu_sbi_event_map(struct perf_event *e=
vent, u64 *econfig)
> >               break;
> >       case PERF_TYPE_RAW:
> >               /*
> > -              * As per SBI specification, the upper 16 bits must be un=
used
> > -              * for a hardware raw event.
> > +              * As per SBI v0.3 specification,
> > +              *  -- the upper 16 bits must be unused for a hardware ra=
w event.
> > +              * As per SBI v3.0 specification,
> > +              *  -- the upper 8 bits must be unused for a hardware raw=
 event.
> >                * Bits 63:62 are used to distinguish between raw events
> >                * 00 - Hardware raw event
> >                * 10 - SBI firmware events
> >                * 11 - Risc-V platform specific firmware event
> >                */
> > -
> >               switch (config >> 62) {
> >               case 0:
> > -                     ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > -                     *econfig =3D config & RISCV_PMU_RAW_EVENT_MASK;
> > +                     if (sbi_v3_available) {
> > +                             *econfig =3D config & RISCV_PMU_RAW_EVENT=
_V2_MASK;
> > +                             ret =3D RISCV_PMU_RAW_EVENT_V2_IDX;
> > +                     } else {
> > +                             *econfig =3D config & RISCV_PMU_RAW_EVENT=
_MASK;
> > +                             ret =3D RISCV_PMU_RAW_EVENT_IDX;
>
> Shouldn't we check to see if any of bits 48-55 are set and return an erro=
r,
> instead of silently requesting the wrong event?
>

We can. I did not add it originally as we can't do much validation for
the raw events for anyways.
If the encoding is not supported the user will get the error anyways
as it can't find a counter.
We will just save 1 SBI call if the kernel doesn't allow requesting an
event if bits 48-55 are set.

> Regards,
> Samuel
>
> > +                     }
> >                       break;
> >               case 2:
> >                       ret =3D (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_F=
W << 16);
> >
>

