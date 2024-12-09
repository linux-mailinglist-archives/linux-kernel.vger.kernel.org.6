Return-Path: <linux-kernel+bounces-438089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60229E9CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5C165DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD814BF92;
	Mon,  9 Dec 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PUvfvsb0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EA14AD22
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764171; cv=none; b=Qg324pYXTWWg5+ijMfmfIMwwZ8gOiFgREiFlvzeq+iSOCsPMflLdkWiIvFq5cFq240QiJVEmumYjDcmh+G2CBtYDiNNV9ZBAQo+nVCoWWaQABrqVH0OJikOvD2jcOb/oRk41eMqIi2bllEAbY1Kx1car2vCPT/NqemZu3be+LTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764171; c=relaxed/simple;
	bh=5dO0bHCkiOuMyRRsOtUMU9n5Sh4eTa7inauhZAnT2uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jbbj4JpTcnLvrv3EyGGP5sgUr0os0ocZgX+OmAZNNC93qGX+44Xl74DmLMNW/eTSwGgKhl9EJEvcLHkGm6wExDMrnR5HZUhhySb3v5e3qQioCLFcJxwNOATro9lrDeAKRlUBrDdnE8uKYey85eWD9ODWAxOutbsr1yt4ZlYCw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PUvfvsb0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so2965895e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733764167; x=1734368967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dQoNlSLU0HPpFMCspBWlxi64Lg9FL6brLFfxEcaxG8=;
        b=PUvfvsb0Io0/FchTsZqTfmPadC3BGEZYv4xrxMc6cVOG4KPDeJcXDnfAicXRwFfzkz
         v6DkFQhUrSoyzxRQQ9BRAEwZ+uzDXW6je7CWyOuXmgKNSbA/LUIyJ0EvAw2fofgTeYTd
         Yz0IHNLlhaXvg0Lppn2V3y6ZsbhXvZr+FDgKLzAZX+9UpGvpWbIUBnCB5xRlP16gFbgP
         67L8knH44tNvQk98c4dV7IIH5A9KagEuF84o1qeFNc4UCuzGn2HCgRrfD52ae+lOBQsO
         9HaQPlWmpp4T/BC66D/Xk/Lh4efaQyp3q2LS7Q0YYRS5+irPcQO7uwcxQu/Z94xoXJJG
         uyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764167; x=1734368967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dQoNlSLU0HPpFMCspBWlxi64Lg9FL6brLFfxEcaxG8=;
        b=Equ9ri/Pc7ajADD2QgXK0GQmgNJ27sUUUHZAAhSXly0AluBJzasYrRfucBv5IA2pYq
         aMnmfyl3x2slzyDB849EwBPmNnuaq3CvoeKniwva9gu3ly/9avikkPMPP51mkvOkFNrm
         t1JpQ51ukzr6MK4iUuVhsZUBJUtuJ2EP7kQR2mpa49YJfDFBLqGchK6TkogemN1OzQHD
         OYGJgEZ6fl072OgpzUF8g+kACUFC+3eoAeGKHF91RMsqcWb6dePS458wEiVKdm50UCdk
         QRPvhip3Ik4F6n+Ev9sx5DItSgNb+qHr28OfclQjpvjd4xjWDuzuIXFhge1PHAwuKZS0
         P3jw==
X-Forwarded-Encrypted: i=1; AJvYcCVNtQsdsKliGmtMFDFHEDb67S9wkRk5KuBnNTMaYoxAUKJgcv7lTX7s/YElhwh//lD8cgZcBH1AD71GQLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06nY8LfgRQdydnO1kpL6aO8jw1E3QRnDIWeEt54rqCbL5PE2B
	VXEiDYq6XcI0uHts4YNnuh77AOcHUR/CfI/bumCWnAt1/qmqj3+hsETXr+NwOErRh8UWhQ/J/bP
	ijTCpaEw/TTU8Uo2kA1mBOS23MOQ6G3uR1cb5aw==
X-Gm-Gg: ASbGncv7Q6gvqOtycUclZNepxnoLgmKaQcgB+vw7pQAxwOT7+bAR/HFSIrdLN5kh5Mk
	H707G3e/xwtpZ2eATURUP6AaanK+HdXBeMw==
X-Google-Smtp-Source: AGHT+IG6uSRDfPHJzHiWWjwtpQy8M4+4XudoroPlj5CXYPC49kBjcmD0V2caDVBsCTaJa23u6C6/4BVZxa5RJ8VB4hc=
X-Received: by 2002:a05:6512:acc:b0:53e:3740:4a8d with SMTP id
 2adb3069b0e04-53e37404c0emr3635765e87.3.1733764167141; Mon, 09 Dec 2024
 09:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208150711.297624-1-apatel@ventanamicro.com>
 <20241208150711.297624-2-apatel@ventanamicro.com> <875xnuq6dc.ffs@tglx>
 <CAK9=C2VqU2mdLL-R20bdgvDHi0WcuNyUSqRo7Pztsu-8X1wVvw@mail.gmail.com> <87r06gq2di.ffs@tglx>
In-Reply-To: <87r06gq2di.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 9 Dec 2024 22:39:16 +0530
Message-ID: <CAK9=C2UZKgkA_xZPs2=RBo7bUDKpeY2gBA2j3+S4i4xSLqC5BQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] irqchip/riscv-imsic: Handle non-atomic MSI updates
 for device
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:23=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Anup!
>
> On Mon, Dec 09 2024 at 17:38, Anup Patel wrote:
> > On Mon, Dec 9, 2024 at 1:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> There is no guarantee that set_affinity() runs on the original target
> >> CPU (CPU 1). Your scheme only works, when CPU1 vector 0x20 is not used
> >> by some other device. If it's used, you lost as CPU1 will consume the
> >> vector and your pending check is not seeing anything.
> >>
> >> x86 ensures CPU locality by deferring the affinity move to the next
> >> device interrupt on the original target CPU (CPU1 in the above
> >> example). See CONFIG_GENERIC_IRQ_PENDING.
> >
> > I agree with you.
> >
> > The IMSIC driver must do the affinity move upon the next device
> > interrupt on the old CPU. I will update this patch in the next revision=
.
> >
> > BTW, I did not find CONFIG_GENERIC_IRQ_PENDING. Is the
> > name correct ?
>
> CONFIG_GENERIC_PENDING_IRQ is close enough :)
>
> >> The interrupt domains which are not affected (remap) set the
> >> IRQ_MOVE_PCNTXT flag to avoid that dance and don't use that affinity
> >> setter code path at all.
> >
> > Yes, setting the IRQ_MOVE_PCNTXT flag in the remap domain
> > makes perfect sense.
> >
> > I suggest adding IRQ_MOVE_PCNTXT usage as part of Drew's
> > irqbypass series which adds a remap domain in the IOMMU
> > driver. Unless you insist on having it as part of this series ?
>
> You need to look at the other RISC-V controllers. Those which do not
> need this should set it. That's historically backwards.

I will update the RISC-V APLIC MSI-mode driver in the next revision.
This driver is a good candidate to use IRQ_MOVE_PCNTXT and
IRQCHIP_MOVE_DEFERRED.

>
> I think we can reverse the logic here. As this needs backporting, I
> can't make a full cleanup of this, but for your problem the patch below
> should just work.
>
> Select GENERIC_PENDING_IRQ and GENERIC_PENDING_IRQ_CHIPFLAGS and set the
> IRQCHIP_MOVE_DEFERRED flag on your interrrupt chip and the core logic
> takes care of the PCNTXT bits.

Sure, I will update.

Thanks,
Anup


>
> I'll convert x86 in a seperate step and remove the PCNTXT leftovers and
> the new config knob once the dust has settled.
>
> Thanks,
>
>         tglx
> ---
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -567,6 +567,7 @@ struct irq_chip {
>   *                                    in the suspend path if they are in=
 disabled state
>   * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before sta=
rtup
>   * IRQCHIP_IMMUTABLE:                Don't ever change anything in this =
chip
> + * IRQCHIP_MOVE_DEFERRED:            Move the interrupt in actual interr=
upt context
>   */
>  enum {
>         IRQCHIP_SET_TYPE_MASKED                 =3D (1 <<  0),
> @@ -581,6 +582,7 @@ enum {
>         IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND        =3D (1 <<  9),
>         IRQCHIP_AFFINITY_PRE_STARTUP            =3D (1 << 10),
>         IRQCHIP_IMMUTABLE                       =3D (1 << 11),
> +       IRQCHIP_MOVE_DEFERRED                   =3D (1 << 12),
>  };
>
>  #include <linux/irqdesc.h>
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -31,6 +31,10 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
>  config GENERIC_PENDING_IRQ
>         bool
>
> +# Deduce delayed migration from top-level interrupt chip flags
> +config GENERIC_PENDING_IRQ_CHIPFLAGS
> +       bool
> +
>  # Support for generic irq migrating off cpu before the cpu is offline.
>  config GENERIC_IRQ_MIGRATION
>         bool
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const
>                 return -EINVAL;
>
>         desc->irq_data.chip =3D (struct irq_chip *)(chip ?: &no_irq_chip)=
;
> +
> +       if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
> +               if (chip->flags & IRQCHIP_MOVE_DEFERRED)
> +                       irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
> +               else
> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
> +       }
>         irq_put_desc_unlock(desc, flags);
>         /*
>          * For !CONFIG_SPARSE_IRQ make the irq show up in
> @@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq,
>         trigger =3D irqd_get_trigger_type(&desc->irq_data);
>
>         irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
> -                  IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
> +                  IRQD_TRIGGER_MASK | IRQD_LEVEL);
>         if (irq_settings_has_no_balance_set(desc))
>                 irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
>         if (irq_settings_is_per_cpu(desc))
>                 irqd_set(&desc->irq_data, IRQD_PER_CPU);
> -       if (irq_settings_can_move_pcntxt(desc))
> -               irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
>         if (irq_settings_is_level(desc))
>                 irqd_set(&desc->irq_data, IRQD_LEVEL);
>
> +       /* Keep this around until x86 is converted over */
> +       if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
> +               irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
> +               if (irq_settings_can_move_pcntxt(desc))
> +                       irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
> +       }
> +
>         tmp =3D irq_settings_get_trigger_mask(desc);
>         if (tmp !=3D IRQ_TYPE_NONE)
>                 trigger =3D tmp;
>
>
>

