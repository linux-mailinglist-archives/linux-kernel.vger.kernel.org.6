Return-Path: <linux-kernel+bounces-222025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31D290FBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950051F229EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0422F1E;
	Thu, 20 Jun 2024 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Op1gH3Ib"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF831B974
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855410; cv=none; b=hRy4BqfZxefszYgORZg92jY0EvSM20dbc5QJNsD4R7h0KrbMFR8FrwBumo2KYM7BprA1EY6k6DDtLND/8uBPh75qGNu5+jFa+JorsWu6zTRWK+2aF8v3A8tfoY6LrlylzxqaGHMbANxjPK21M6zsm1uoCrm7vNo6eYXet2apBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855410; c=relaxed/simple;
	bh=4pIaraKFetquRvi+mIlKYaMEGmlqA2bMssNDSHn5oFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQbkP596wGYcjpRu+Wn7R7Z4mphJyCfpPKFSW7ldS3LFkaI7RzAvTCfH21gHCMcpwR0pqdyQg1aKD1kNoB0P6aujBsYYFiprr3kwb5+wIO7bDwBFAcTH77RcTXyxHFXAHvSqSMBTKuNGZtn6KCkw0QfPxsfFiQocFZjrRZFxnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Op1gH3Ib; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3761f8d689fso1709025ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1718855407; x=1719460207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hZE/Tf0Mi1j/+dmuzm/OBES5k0vYl42V/5iV4/vGMw=;
        b=Op1gH3Ibh2LOUEjXZaeRdt8IV+oPqBaDRMXf4QTMMV6LP+pdNp6vOhyvKrXE+fZ+Fm
         h9EvaCYQwAeJFT7KnAYE7FZlDul6dYc8BMtalKmHUSCo1WoKOFTB5oxD6NgNpzJC2qwJ
         vWirGxNiWyPijcytcHNIvGzVOQH1kSPb2XB+HGL6fjE1BMEJp5dc2Ll/BJIq0xtsS3qS
         qBbFPxp+WNwBCJuuFjUlI6Qm+S+XFD5d1fqZHwkE8gM7KcZGKdRMSOwK7zoVeDB6yQRr
         KRWfk0QFHaPan/Y9Z9LIYaDGd9ycB3rhIdgA4tyfZ3uvRgd0qeVvgW0iF12T7GyUbdkO
         wjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718855407; x=1719460207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hZE/Tf0Mi1j/+dmuzm/OBES5k0vYl42V/5iV4/vGMw=;
        b=i+eyr4799vp0fzPLrKmOIxpgAlYiS8hf/m0Y5Mq1QsObx6FL61KWR2kUD3jGURpOvJ
         ty8xjwX4A9z7RkiRKI8LoGDfbPhoOwLwwgS3jXlXzQgc1jgTPcwwnXmC5gchO+7Qldnu
         Y2Y5CeouYYBC/BtadShRIZZjNPCGf23VI9VGdrxAOrfDJhHi5CvH79NmE+g8Oz5fmUV6
         Yjg/mHagphk0PHdsACb0xStE38jKP31R8+/hG2UjaNc//Sj0EgkPGubxA9a1GfwdvSiV
         39Pivh/Z006hjS8qc5KO0Y1RhsmJ9KREIjwaoWR9McfjYBD1ysU+etK6v35OfPui8eJl
         ykNA==
X-Forwarded-Encrypted: i=1; AJvYcCVkGJ75ZzO53RqF5jBFhcc7QUys8fyUpct4ZHi8UsaLBd+8ocuN5kJ7xXVf1eux3JMnNbBoX1AF3/Tq7lawprkaEuqQsGIzsTjj2M9j
X-Gm-Message-State: AOJu0YxI4CnIbbmlZ9bxSMjxZ6y/9aj+tmSxo92vBV77ofeKF6wvox5p
	4g82PSvrA90kEGeQKBBHGKmFD8JAKoOV0oVdJyHQk7its06Zb1WlxJw0CPnn9SbUwHpIvsOEMVL
	h00Wl1E8LZWNfZWjclRCyyaWKuk304m4dJYJ+Hg==
X-Google-Smtp-Source: AGHT+IGhhLlYZ82l6gl3X+EsNLlepkGD/eRveXzBhTVRmQD8rg+O0oCrJyGSf1cCkIdlCknUK5+bVyVkBaulCaQoMcM=
X-Received: by 2002:a05:6e02:1545:b0:376:148f:d6c6 with SMTP id
 e9e14a558f8ab-3761d70d4b9mr43611515ab.24.1718855407480; Wed, 19 Jun 2024
 20:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
 <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com> <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com>
In-Reply-To: <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 20 Jun 2024 09:19:56 +0530
Message-ID: <CAAhSdy1pesbdTfWnFURMJRcy2ujjX+cXtt-cfLDj2CQf2Ua_gw@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:16=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Anup Patel wrote:
> > On Tue, Jun 18, 2024 at 7:00=E2=80=AFPM Emil Renner Berthing
> > <emil.renner.berthing@canonical.com> wrote:
> > >
> > > Anup Patel wrote:
> > > > The PLIC driver does not require very early initialization so conve=
rt
> > > > it into a platform driver.
> > > >
> > > > After conversion, the PLIC driver is probed after CPUs are brought-=
up
> > > > so setup cpuhp state after context handler of all online CPUs are
> > > > initialized otherwise PLIC driver crashes for platforms with multip=
le
> > > > PLIC instances.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >
> > > Hi Anup,
> > >
> > > Sorry for the late reply to the mailing list, but ever since 6.9 wher=
e this was
> > > applied my Allwinner D1 based boards no longer boot. This is the log =
of my
> > > LicheeRV Dock booting plain 6.10-rc4, locking up and then rebooting d=
ue to the
> > > the watchdog timing out:
> > >
> > > https://pastebin.com/raw/nsbzgEKW
> > >
> > > On 6.10-rc4 I can bring the same board to boot by reverting this patc=
h and all
> > > patches building on it. Eg.:
> > >
> > >   git revert e306a894bd51 a7fb69ffd7ce abb720579490 \
> > >              956521064780 a15587277a24 6c725f33d67b \
> > >              b68d0ff529a9 25d862e183d4 8ec99b033147
> >
> > Does your board boot with only SBI timer driver enabled ?
>
> I'm not 100% sure this is what you mean, but with this change I can disab=
le
> CONFIG_SUN4I_TIMER:
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index f51bb24bc84c..0143545348eb 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -39,7 +39,6 @@ config ARCH_SUNXI
>         bool "Allwinner sun20i SoCs"
>         depends on MMU && !XIP_KERNEL
>         select ERRATA_THEAD
> -       select SUN4I_TIMER
>         help
>           This enables support for Allwinner sun20i platform hardware,
>           including boards based on the D1 and D1s SoCs.
>
>
> But unfortunately the board still doesn't boot:
> https://pastebin.com/raw/AwRxcfeu

I think we should enable debug prints in DD core and see
which device is not getting probed due to lack of a provider.

Just add "#define DEBUG" at the top in drivers/base/core.c
and boot again with "loglevel=3D8" kernel parameter (along with
the above change).

Regards,
Anup

