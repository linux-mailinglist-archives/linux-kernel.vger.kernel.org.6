Return-Path: <linux-kernel+bounces-288102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BD9534DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A011C237DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1292772A;
	Thu, 15 Aug 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VkAxjQuS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69B19FA7A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732268; cv=none; b=knFk+F2gvkGssoLwXtFQcOnHuA2AOJAIJGtBJDxuols+1sFM4NAswHzL3BfZ3AP3Gt03CvEdqxBJZ7q1m8JhqjIQncNWitQ43F0qDrHhAq4cfCkWkLAZqCymXl1Rm/LjRKL7ZIONfOTDeRf0d1hgleGYtvyVDsexpbCFUy2wNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732268; c=relaxed/simple;
	bh=BhGULGGpAdf8wP4DjjGL3HVL/NqyEAatMCDWKJlrDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGSjpZPC3aSvCL6puEWX4a5273GS2YBy9yb2+EZ12Dgfhleagb3TroL0U6UAKB+5vjfgdPaNHDZ4504OJyWIydb5X/km65cmvIwPniP3kLQr2Zi6+dBkTKpTRwMHq4Z4c5Q4fYSjJxX0ycrvDXd000KOtJ3UusvMjm6vzZFOkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VkAxjQuS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f149845d81so9101441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723732263; x=1724337063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcvq8uUHmuPOGUnHdS7s6bm/DqUE1vyfs2Wujf+gaVI=;
        b=VkAxjQuSIENjUsPvOLAPB0xxTwOY+iQvwfHhEcTVJAllfhYH6P3C02UTEj9C8ZguOD
         RidmGS84BrM06tdEsfqMdGgs24poPzwyaNDC8/dALTevADkYdae5XeIoCgVZS/wU1LLq
         UOQchrZyW0JDwpczmIxlA5UhtXJNKUZNotgMyL1WPdBXMpm66CEIcKNZqTpj9qEs4O3L
         2KI+BFjLHiyK3E3WM2OdL40NFwcPqtDSRVYKq3ypGtUZRM+wSLAXqk/ncEZy9X7aBYtQ
         QFw+kqoNDZ1N4qWC0NunawjJsHET79hw3A0VB4ml7/cbjkHyBdmXIdhceKJaUCHAoD/M
         Ecpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723732263; x=1724337063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcvq8uUHmuPOGUnHdS7s6bm/DqUE1vyfs2Wujf+gaVI=;
        b=cXFhujLAeplFyDxsA6ge2T4303wU3dYKQ+WiiZ/B/siGurd0myBDmMVIBpQv4fbDPG
         15sdenYzu/UT8X5WBafVLWqwEXcgIebrrHL/7l5WNuSQtnRFhPdOlLnMweJNhNGvuWM+
         /Sj29ET1Frd21wnD5eFiQlzOU8ew8n9YohMukhikzKRnysnGo2TrteqN6dqu54gqlapX
         hR/H8gR4UUeHlXnjxSDaQVw3skX6qXIWl+dM4F9RTe8c+k2QOYXAKpdB0c05Y2+CfleB
         lxxhXDGBWZcdzdzfGfjwfLCfdW3FnOLwZRbaiTr4mKjMrKlAoF+nUKomNwyqzJ9xXyKo
         pjzA==
X-Forwarded-Encrypted: i=1; AJvYcCVOLP6B5SEGWoNSsdru6mm2sBAj5RTP8vVgZvaZU+ce/sEmiDbtt8b0TZ6awXPFqPqAg/K50D+2WK07I9OFacoQBHKF4qmRvCX6ul5b
X-Gm-Message-State: AOJu0YyWkCUi6REVebVcXbb9fxvrC/QJZvnW4QAnlHpNeQ1GECgpt2qC
	Rk+6sy9AP3afS+s63AGup/7hizI9ujgUBbO8c9c7sh89ZFAAmfdXoWQzVx3FrQDFy9hwCp6JMPY
	KqCv+Xx6kZ9WwFUliRPyxOuecrWGDXvYuGr5QDg==
X-Google-Smtp-Source: AGHT+IHAAccVfpcl3odE8dq7FIsrDS4Zdmdj/lG6qMcWh0FaS2LCp/xk2oU88/wFffkyqJb9KTSOpeFaSgJ/4p3CnT4=
X-Received: by 2002:a05:6512:23a1:b0:530:e228:779c with SMTP id
 2adb3069b0e04-532eda6d816mr4514750e87.19.1723732262175; Thu, 15 Aug 2024
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
In-Reply-To: <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Aug 2024 20:00:50 +0530
Message-ID: <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:02=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Thomas, Emil,
>
> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> > On Thu, Aug 15 2024 at 05:14, Emil Renner Berthing wrote:
> >> Emil Renner Berthing wrote:
> >>> 6.11-rc3 + these reverts:  https://us01.z.antigena.com/l/Er4kZWDmvL5-=
bLzHHJoZv0k71iwW2jCD5qNpiz0x0XdYY6oORF_nXh7U7jw6oubhi~32HI4i71jUW9v8~NvSvPe=
UWrdYx3WJBr2GPDUjOu6LYPCOBfR2dVQuMWvlNj4tDjXFp3QEQAmeawZflD4JrIJjtSYIbKfe6v=
-tgH7SEuHMeSSriU633Lv
> >>> 6.11-rc3 + Samuel's patch: https://us01.z.antigena.com/l/EULtAYky6Zvg=
qZ49KGS-WBsYTg~Ht1NoQtEYmUVb56ymS9jDagqYHLK90WDjnVt69GfB4IX5NSRQXmSfkNsTzB8=
lJmFvDihHQmGrsCv9FzlorD9yGfXDlQ6rG6vmn5BNDwlipmssGaOGfh9yko8n9ArWR4TLhEf~f9=
ODqme~NXXwA9DLLc9p
> >>
> >> I think this confirms what Charlie found here:
> >> https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/
> >
> > Yes. So the riscv timer is not working on this thing or it stops
> > somehow.
>
> That's correct. With the (firmware) devicetree that Emil is using, the Op=
enSBI
> firmware does not have a timer device, so it does not expose the (optiona=
l[1])
> SBI time extension, and sbi_set_timer() does nothing.

OpenSBI uses platform specific M-mode timer (mtime and mtimecmp) to
provide SBI time extension to Linux.

The RISC-V privileged specification (v1.10 or higher) requires platform to
provide a M-mode timer (mtime and mtimecmp).

This platform not having any M-mode timer is yet another RISC-V spec
violation by this platform.

Regards,
Anup

>
> I wrote a patch (not submitted) to skip registering riscv_clock_event whe=
n the
> SBI time extension is unavailable, but this doesn't fully solve the issue
> either, because then we have no clockevent at all when
> check_unaligned_access_all_cpus() is called.
>
> How early in the boot process are we "required" to have a functional cloc=
kevent?
> Do we need to refactor check_unaligned_access_all_cpus() so it works on s=
ystems
> where the only clockevent is provided by a platform device?
>
> Regards,
> Samuel
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/intro.=
adoc
>
> > Can you apply the debug patch below and check whether you see the
> > 'J: ....' output at all and if so whether it stops at some point.
> >
> > Thanks,
> >
> >         tglx
> >
> > ---
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -2459,6 +2459,9 @@ static void run_local_timers(void)
> >  {
> >       struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_LOCAL]=
);
> >
> > +     if (!(jiffies & 0xFF))
> > +             pr_info("J: %lx\n", jiffies);
> > +
> >       hrtimer_run_queues();
> >
> >       for (int i =3D 0; i < NR_BASES; i++, base++) {
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>

