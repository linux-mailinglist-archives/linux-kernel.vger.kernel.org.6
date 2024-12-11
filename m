Return-Path: <linux-kernel+bounces-442116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40B9ED82C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AEB18847B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1D02036F6;
	Wed, 11 Dec 2024 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YTLRNuVm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B73259498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951421; cv=none; b=Qfv+4yfGa2VLaD6PtEu50DEBl2Csh4LnmSPJoV2doHjE16I3+CbDA4pdySuaLY0IFFHGwbJ1YdzjfpwoOtuq0OQq2urQv+vC0SjpceSrcF2USC8MnhLmJ+NBVvqUGGaT5wYOqwWFtNvyeOI66zlteB0g0Fvo7dyo7EI2utsFHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951421; c=relaxed/simple;
	bh=KPDl96YIWMcrRrcV+lg6vfhyXr3+vPgXEuHTonWRiRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9IgOMtM4XyQ0F2J4WPOerrJ5qOFas1dZqpXkhtfC3MvXb4VkISyoIhmAvyHHsZAxEy7YXJBypLmh4xIrEFfNR2fNIzomCr2+9G+hvWiJoVnJkEfPJCnDPLmoJH8p6a7SmB/U0106FLyNVCp9RuzySsB+vuyxsvwhVZSDqwkrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YTLRNuVm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7265c18d79bso3573561b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733951418; x=1734556218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUJ6E1dccY/UenqZ3HoN/Mh8eiUDPyCKSbZAwA4cbhs=;
        b=YTLRNuVmHCFKsSk1n8GejXzACNJIZ3n8Bux74qt18xllikvTPxOzwBugWsaanX726T
         mT3S1q55T9pQzG5L9NAp7r28WIwleAMmBozXNKlfkTx92thycHRXk1HLsud8GfkSHWQt
         Cx59qzQreQ9u3b+6G5LAgtjjD5f/CHkfolTq8su/Sm2qKm33EDEiZ/boVUIVKOdMy97R
         5GLXsKd0UcJbCrRJpI+DsbyQfJGI6mWTWl7P9p5Hra9DJHGYkxGq0hTYXtj0R1uEWS/W
         YeFxOIgjgEcHTM4tJDR+OWOsR5YKV4fT+5QuSwVtzWb5+VmXKWri9EIFljPTKAlVqaJG
         vL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951418; x=1734556218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUJ6E1dccY/UenqZ3HoN/Mh8eiUDPyCKSbZAwA4cbhs=;
        b=c8IM1dARJuIW7Gc3WFv9SC8j6CH2+JzBeAwBa7NO6+PXBpjzwaJc7LyLximjWLHgkM
         0LZtcgF/jtgY2CVqTIzburkUs72mV7gDKuqkkmBc2i4mf3erOzJuvbiJ+ZGAMijxFAZB
         atv//WM/FDEFxOISQHmHzAHA3HExn0LnqwOcBU9J4hESRMzKq+1FouqD1VLu/3exLUN1
         zyzinybRPr7BEeUkB8fFGWkDJdkJynZH0FFRPNXxBy1xaacfil+EXO0A5EzsfatUptjg
         SWzck94s+ltcJJ2VZPrbcxEzjBTVMrEu6FySm3XFRLKzfpUveASmajvhxUSrR4eTGvu9
         p6gg==
X-Forwarded-Encrypted: i=1; AJvYcCXNFCNjPlr3kRfNKT0EkMF66RT/vaoj24ohVDo/QTdWT2mqwVvKMWtT8gIS5Ie/dYUDGOx6Zb56hyeudOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqgIIlh8mSnqHsmNDm5LCUh0dsuC8NbkpHoFLsoiuh5kNmUjr
	M9YUqdyo4tVbkHmHDNe5dNM/xEZTHAwoou8Yg8xtINVxaAObHsEQ8QJg0EAFwYsMVNBu1g4yK6m
	sONCOdAkOnU8mm4asu71VnTXeJjuZ69XARWsbmw==
X-Gm-Gg: ASbGncul7qs5AGIaYjTc2+/+vYFh5ImukcMvkUJSduUf/6JtzltzN4sG6c4V+npR8+g
	e7/WSw3LiSigLZku2vkivvJJnz/18KI9f/g==
X-Google-Smtp-Source: AGHT+IGbytb2z6LDDkYKhPGNyqyAm3jA1eJq1+JKml7I0nFmrZCCwIKb2tSKtD6WnDFHkiV+jENJ+KJKRSAidtP2wIY=
X-Received: by 2002:a05:6a00:a8f:b0:728:ecab:521c with SMTP id
 d2e1a72fcca58-728faa19073mr995943b3a.6.1733951417743; Wed, 11 Dec 2024
 13:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-pmu_event_fixes-v1-2-d9525e90072c@rivosinc.com> <mhng-1c6ec679-02bc-4aa3-9b23-bb4c5f5f9b81@palmer-ri-x1c9a>
In-Reply-To: <mhng-1c6ec679-02bc-4aa3-9b23-bb4c5f5f9b81@palmer-ri-x1c9a>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 11 Dec 2024 13:10:07 -0800
Message-ID: <CAHBxVyF445KnZfT9rPhTwKA76_GT0eT3+p=ot1oLQzUb7j7d7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/perf: riscv: Do not allow invalid raw event config
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org, anup@brainfault.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, mchitale@ventanamicro.com, 
	samuel.holland@sifive.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:46=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Mon, 09 Dec 2024 16:04:46 PST (-0800), Atish Patra wrote:
> > The SBI specification allows only lower 48bits of hpmeventX to be
> > configured via SBI PMU. Currently, the driver masks of the higher
> > bits but doesn't return an error. This will lead to an additional
> > SBI call for config matching which should return for an invalid
> > event error in most of the cases.
> >
> > However, if a platform(i.e Rocket and sifive cores) implements a
> > bitmap of all bits in the event encoding this will lead to an
> > incorrect event being programmed leading to user confusion.
> >
> > Report the error to the user if higher bits are set during the
> > event mapping itself to avoid the confusion and save an additional
> > SBI call.
> >
> > Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 3473ba02abf3..fb6eda90f771 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -507,7 +507,7 @@ static int pmu_sbi_event_map(struct perf_event *eve=
nt, u64 *econfig)
> >  {
> >       u32 type =3D event->attr.type;
> >       u64 config =3D event->attr.config;
> > -     int ret;
> > +     int ret =3D -ENOENT;
> >
> >       /*
> >        * Ensure we are finished checking standard hardware events for
> > @@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *ev=
ent, u64 *econfig)
> >
> >               switch (config >> 62) {
> >               case 0:
> > -                     ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > -                     *econfig =3D config & RISCV_PMU_RAW_EVENT_MASK;
> > +                     /* Return error any bits [48-63] is set  as it is=
 not allowed by the spec */
> > +                     if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
> > +                             *econfig =3D config & RISCV_PMU_RAW_EVENT=
_MASK;
> > +                             ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > +                     }
> >                       break;
> >               case 2:
> >                       ret =3D (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE_F=
W << 16);
> > @@ -554,7 +557,6 @@ static int pmu_sbi_event_map(struct perf_event *eve=
nt, u64 *econfig)
> >               }
> >               break;
> >       default:
> > -             ret =3D -ENOENT;
> >               break;
> >       }
>
> This doesn't have a Fixes, is it
>
>     Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmware =
event handling")
>

I was not sure if a Fixes tag was worth it as the current
behavior(masking off the higher bits) is there from the beginning of
the driver.
perf tool throws a warning as well if a user tries to set any of the
upper 16 bits as event attributes is set to 0-47.

If it should be backported, this is the correct fixes tag.
Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI
PMU extension")


> ?

