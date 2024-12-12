Return-Path: <linux-kernel+bounces-443833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3A9EFC67
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633BB28BE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C94198E7B;
	Thu, 12 Dec 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BcfgUSI0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF225168497
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031584; cv=none; b=hrVSUOJB2vy3WiBZycm3905+8cl6jqI0JrFECbhrp7lEy41oSZh76p7XhB9YKfSnpg6DCq3Jq5vwk/OLZX6K9rI3MXmUoz+i0MYyTAqM0tklqEA325aD9gLSDd+UgOtC9Bva+DRIWWTE5Z84qpx3xAZvkdH7yvsSvbvvKSOmoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031584; c=relaxed/simple;
	bh=0Dzy8TtHg0n1jyfUE0vkC6sIjgfvTWHkTmvH1lEEH0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap83zg8l17QCwPSkN92JlK809ZoU28EWtXjuxs2/BS20ntKlW15A1mAD62OYPteFDwLtR426+6/bWfChnWKEf82Uel60AXIpD4eC3aVGuHBoTA2gugm3HLExJVsCQnPbYOfrif2f8JGJvAUQHDMjrTofXFJ1jEz46A5GdUPtZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BcfgUSI0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so781870b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734031581; x=1734636381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPnFUIi4L999NoGrpXMp4CZPau9DfuDv5KGY4m1VIsY=;
        b=BcfgUSI0OIL9n81/jPjB8SWmtj6RWMOVcfxNDkmyI4EuM9sKQ5ea8f68l6kaBddOP3
         wnF8ARIf0sfUBMxg9g7R5JVDbdfs1eHpNp0FKqbeVWBxwRx5X3ZbACyfARW1z+0w1Gsf
         /gwm2fE5FHzuQzWiyEhd9SF78pvO90oEFhD0SPBZS3K8zZvbaWKygIcJsJ1G93ipXt4C
         m5GlGCYdqatBsWuUp+1PSbv4iYIKYpoFDGzmY+S2IQVr0Xtd8OAvQMlom7ItQoBBcGkS
         V6JAUihl9fjCXosflhlyPHZ7guNwZsGZlC/rnfXDxGeOpSsCaQ9OOphzivJewoRrgNUg
         kaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734031581; x=1734636381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPnFUIi4L999NoGrpXMp4CZPau9DfuDv5KGY4m1VIsY=;
        b=iPsuekGRLdUNudH/FoA/Q8rEz5FM7dugxV3nu2nK59HFYFQ+uYjQ+SxXRaiV6oKGle
         lVG7WXhO56hnGMoCmHAR1mdQ96EE/79IXZ0qbJUVv6I/7HOvH9oK4/gdyH6F4ZbSe4fb
         GNLOcqJw1mvs79MK7XJLl2B+xC8+Yizc6itNUIB4oJDrOjm/g4fmCe5GVfnUVUVtsn97
         Fm/s6r46M8CilYY+XVdLKtuKTsQ8P8ry1ibU7/JzHwduZwhxnV1Z3KpiTl/VuIor46ti
         O0hHghOYpprYXoif0fa6dEke2ExVHDjMfZUlDmcd/STTsg3vy7mlYdVywn3XMIKTVgY1
         z6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHtmMNZeTiW8Z05Sb9oKciohrVw6B9BuSqL+fpeFIMZkV8PoMbEuxl1jvwM3kBSDT4P2jsTppcKrQVTXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXpmycEO3zmFkhGx/BPEOGdKhgu518eokXTkcE/htDcBNIZVn
	ZNUQ7Z5XGIyWQkvlMjPvM+m+VQKiKtJ/8fT/P0+ShUFzYCS7hFwd67n39DpQwTWEFLAKB2qTCzf
	11V4B4tTDXPUvlTE53tWXMMR9XZEIyCZ3uwZRYw==
X-Gm-Gg: ASbGncuDVA4dLeKAzRpCzVi9pFd4HGZED6fzON9n45FY/JuVnkmH5fWObHIh+rHYA7p
	gNEIYFzfU713QP+xCs+VaYJssafIq0f+QGv3X
X-Google-Smtp-Source: AGHT+IEPwEWxyWAwEFjkiB40b7qB8uzvBeDQL6zpw5H+2169/UHZLb2L1T7jmdC2c1bF2UThDUzl7odEvBTht3Xeaik=
X-Received: by 2002:a05:6a00:9295:b0:725:30f3:67d8 with SMTP id
 d2e1a72fcca58-7290681d9c5mr1768378b3a.0.1734031581162; Thu, 12 Dec 2024
 11:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-pmu_event_fixes-v1-2-d9525e90072c@rivosinc.com>
 <mhng-1c6ec679-02bc-4aa3-9b23-bb4c5f5f9b81@palmer-ri-x1c9a>
 <CAHBxVyF445KnZfT9rPhTwKA76_GT0eT3+p=ot1oLQzUb7j7d7w@mail.gmail.com> <c094ae0b-ddf0-42fc-ad47-00fad84fb70d@sifive.com>
In-Reply-To: <c094ae0b-ddf0-42fc-ad47-00fad84fb70d@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 11:26:10 -0800
Message-ID: <CAHBxVyH-2+Jj2vrqvYJBG0mHGLjCJM61DnpfT3H7pUoiFMpETA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/perf: riscv: Do not allow invalid raw event config
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, atishp@atishpatra.org, 
	anup@brainfault.org, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	mchitale@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:06=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Atish,
>
> On 2024-12-11 3:10 PM, Atish Kumar Patra wrote:
> > On Wed, Dec 11, 2024 at 11:46=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt=
.com> wrote:
> >>
> >> On Mon, 09 Dec 2024 16:04:46 PST (-0800), Atish Patra wrote:
> >>> The SBI specification allows only lower 48bits of hpmeventX to be
> >>> configured via SBI PMU. Currently, the driver masks of the higher
> >>> bits but doesn't return an error. This will lead to an additional
> >>> SBI call for config matching which should return for an invalid
> >>> event error in most of the cases.
> >>>
> >>> However, if a platform(i.e Rocket and sifive cores) implements a
> >>> bitmap of all bits in the event encoding this will lead to an
> >>> incorrect event being programmed leading to user confusion.
> >>>
> >>> Report the error to the user if higher bits are set during the
> >>> event mapping itself to avoid the confusion and save an additional
> >>> SBI call.
> >>>
> >>> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> >>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>> ---
> >>>  drivers/perf/riscv_pmu_sbi.c | 10 ++++++----
> >>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sb=
i.c
> >>> index 3473ba02abf3..fb6eda90f771 100644
> >>> --- a/drivers/perf/riscv_pmu_sbi.c
> >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> >>> @@ -507,7 +507,7 @@ static int pmu_sbi_event_map(struct perf_event *e=
vent, u64 *econfig)
> >>>  {
> >>>       u32 type =3D event->attr.type;
> >>>       u64 config =3D event->attr.config;
> >>> -     int ret;
> >>> +     int ret =3D -ENOENT;
> >>>
> >>>       /*
> >>>        * Ensure we are finished checking standard hardware events for
> >>> @@ -536,8 +536,11 @@ static int pmu_sbi_event_map(struct perf_event *=
event, u64 *econfig)
> >>>
> >>>               switch (config >> 62) {
> >>>               case 0:
> >>> -                     ret =3D RISCV_PMU_RAW_EVENT_IDX;
> >>> -                     *econfig =3D config & RISCV_PMU_RAW_EVENT_MASK;
> >>> +                     /* Return error any bits [48-63] is set  as it =
is not allowed by the spec */
> >>> +                     if (!(config & ~RISCV_PMU_RAW_EVENT_MASK)) {
> >>> +                             *econfig =3D config & RISCV_PMU_RAW_EVE=
NT_MASK;
> >>> +                             ret =3D RISCV_PMU_RAW_EVENT_IDX;
> >>> +                     }
> >>>                       break;
> >>>               case 2:
> >>>                       ret =3D (config & 0xFFFF) | (SBI_PMU_EVENT_TYPE=
_FW << 16);
> >>> @@ -554,7 +557,6 @@ static int pmu_sbi_event_map(struct perf_event *e=
vent, u64 *econfig)
> >>>               }
> >>>               break;
> >>>       default:
> >>> -             ret =3D -ENOENT;
> >>>               break;
> >>>       }
> >>
> >> This doesn't have a Fixes, is it
> >>
> >>     Fixes: f0c9363db2dd ("perf/riscv-sbi: Add platform specific firmwa=
re event handling")
> >>
> >
> > I was not sure if a Fixes tag was worth it as the current
> > behavior(masking off the higher bits) is there from the beginning of
> > the driver.
> > perf tool throws a warning as well if a user tries to set any of the
> > upper 16 bits as event attributes is set to 0-47.
> >
> > If it should be backported, this is the correct fixes tag.
> > Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI
> > PMU extension")
>
> I would agree the masking isn't a real issue before changing the event at=
tribute
> from 48 to 56 bits wide. However, this patch also does a drive-by fix of =
a
> different bug introduced by f0c9363db2dd: there is no "case 1" or default=
 case,
> so the function would return an uninitialized value if the high bits are =
01.
> Maybe that should be a separate patch, with a Fixes tag?
>

Good eye ;). I will split this one into two with a fixes tag for the
switch case.

> Regards,
> Samuel
>

