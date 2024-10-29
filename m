Return-Path: <linux-kernel+bounces-386441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC49B438B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967CB2811CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F61CCB33;
	Tue, 29 Oct 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i/1LFc2m"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A92010F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188364; cv=none; b=d2nPfdJwslUTyejlGzoyaUJ/mtIYj03R0pMwHMV7CXrQ+Fl2M97bFal/103IbNWbTZL6P1oSDhesfvI91O4/wZcCJq5V5FMOE5YvRe4vFBRo3vb/JzcmGlKEm5AVschv0ck/gO0fgH2FajwASpSCRYeAl0wRhoaRN2vI0K6MyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188364; c=relaxed/simple;
	bh=PjkBvTTYwOiWazejEqU9482wFOSVZFs6iPyNkUYLrSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7pbRjwDFZnN4e3lob4MTibqe4m+7qE4NSzewmQ51vpXb6gAtGPwnQ0u9SbBnxfEwcRYmnoFhG+4nQqBeDuq8BElyBsO1z1lGauSDu5bUWadnpI9buJJA12hONyXk/e6XF/cl9VsS3gMDI3OfStKHqbMv5nENGvCCsYlw+d80eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i/1LFc2m; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-28c7f207806so2310389fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730188361; x=1730793161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rbp3tWipnS9n1DED0E9JncApTpU6NEKrzZwh6VcEEY=;
        b=i/1LFc2msEtxXgPB3Trp9GnXTmgxFP7JOr4XYxHWO4yuOaOkwkddkAqs1CNjjgxnCh
         NRSXncSUMARypugVO6QJko/YFRCOiAigXDHDmEaOWLB+zVmSkyVQJegcG/ULttWNiufw
         bDKqGyo358cmXktusfUETCMDe2O8OEjEhojUawFgxI2rziOcIWFFjN2KgLSrpCYz+oC2
         Wju7m/+NFmg+bjHy0komNFimuHpsmbKgPafdcCL2sOPs5djfArhychICMPYzQwt00xCj
         kx2ZwxYzZ+wNCjMm8ji/NU05SqyMRukjB4+VbvQy2+SomSYwvUayONTEPBdvnfuzSjvO
         BQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188361; x=1730793161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rbp3tWipnS9n1DED0E9JncApTpU6NEKrzZwh6VcEEY=;
        b=jqlsE6+DtAxSnld6BUoFnmmWDuYOf3FYBBDp1NaadHyjCO1mYRHAHDkI9zafhZToY2
         MfOt+CCbUdTYih8MsnWuXt40ZVx2WzEde8HTfJfYYsbsrLP5mlNmCVLyeLuqj0Bs3Saw
         gs2Su6IhNj1bttBn5Jtvu1IUEjB0EV5+w7TT7pp6CydpDaWu3KUqMx7m9ZJV5Je1mm4a
         IOZqYiGbaRKAl+YCIlzZGCi8ObJJ4p42nEQetZAsSg8p7ZsQ0Gwex4E3MGYTh6hLK/2a
         eI9xqCOWlYgme8r/tc0VPHToAggfwMTlP7Wy0vG5G8RdCkOEv+JdeLVpkX1txtqdXj1V
         HJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWwvAYSuhSQHjsUSg0jLbxKzVFXBFKy0mmDMS2CAFTt5irMTWlJvB590AsfLFJBJwlATSdolaOyiDd+CwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bf+Xv1+Nuett4Njjw2ulDakX3mtL6Xmbe/ixHrdAQy0kK44X
	ZYoaxJFhnN42JTL5O7IxJ7GEhAziRE3TF3LHarB7t3FUyudmPZpTpo2F+hTrUWr90jJHfNR3AA/
	kiz3mw+Zf3Lm7coQCooj0hOXbhVVYALWO7/m2wA==
X-Google-Smtp-Source: AGHT+IHcE0Z//RMNpx9Ji2VGSBbKrOfXkqpktFDkWF0oOow3SiBDbyLJpaYAaQNfcMF3HWuiO8z58Zejjdv6FocygCo=
X-Received: by 2002:a05:6870:82a1:b0:277:cc56:2300 with SMTP id
 586e51a60fabf-29051b4d708mr9099951fac.12.1730188360819; Tue, 29 Oct 2024
 00:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028033928.223218-1-nick.hu@sifive.com> <20241028033928.223218-3-nick.hu@sifive.com>
 <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
In-Reply-To: <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 29 Oct 2024 15:52:30 +0800
Message-ID: <CAKddAkBRhtUhue7meUFy2ZDyERpcG4ua=Wyb0q-ZaBzmHZCD0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 28, 2024 at 5:44=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/10/2024 04:39, Nick Hu wrote:
> > Stop the timer when the cpu is going to be offline otherwise the
> > timer interrupt may be pending while performing power-down.
> >
> > Suggested-by: Anup Patel <anup@brainfault.org>
> > Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifi=
ve.com/T/#u
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > ---
> >   drivers/clocksource/timer-riscv.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/ti=
mer-riscv.c
> > index 48ce50c5f5e6..166dee14e46b 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int c=
pu)
> >   static int riscv_timer_dying_cpu(unsigned int cpu)
> >   {
> >       disable_percpu_irq(riscv_clock_event_irq);
> > +     /*
> > +      * Stop the timer when the cpu is going to be offline otherwise
> > +      * the timer interrupt may be pending while performing power-down=
.
> > +      */
> > +     riscv_clock_event_stop();
> > +
> >       return 0;
> >   }
>
> Should it not be the opposite?
>
> First stop the clock which clears the interrupt and then disable the irq?
>
SIE.STIE =3D 0 ->
Mtimer interrupt comes -> trap to m-mode -> raise STIP ->
stop the clock
Is the above case you are concerned about?

>
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

