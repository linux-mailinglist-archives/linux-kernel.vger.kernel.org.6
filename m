Return-Path: <linux-kernel+bounces-261881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71B93BD52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D05283D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00839172796;
	Thu, 25 Jul 2024 07:48:04 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE642746C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893683; cv=none; b=ZwMlWaRDyfwH81rwmPpN/8/PCoXsPXcnE0xnynlAGfUX/oC1nnyTMUdHZk6GbldB46VqZGY4l4cKMTFj9tULKqogWyH8Shc+bX7K15BdZZnsToV4/g5YEHfVfF5dCRWr5ne8r01/DXyuEytblMKSkmxXjAuodS0B0Kl38jSb27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893683; c=relaxed/simple;
	bh=qbaFtf/9fhPyd7Ys7bVx5jIbo3OTmEh2tq8Bd7lME+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnCoI7EnNDyvje8+sDQLNsyT0KL1cqJgm2ETBIDzCtXL/e8ESy3aOuPwAY/BQNStVXzReyDmDTeIGmk2hn1OoSuJIfptNTClZxaCRt8jSUM+cfrNNJ/8S/33CCO99OE1Whai/RB6uvb9swzFREOzjMLGylHQVdf87DMyqy0Ou1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66c7aeac627so6910727b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893679; x=1722498479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT+mi+VVs0OXeh4RipXbGeW6Cs6PjcVF3A2qy0tP5JU=;
        b=QCdzondWg7ToiuuZqjWNDv0VcOrcxMLX2pscHuU8iLvw0V9SLBKnLEKdHuDL9X5+Nl
         gH9jJCm2t8XcDBgbXOCB4Ggkleq6nrq57Pd8XUsyOSboFkR9SkYPRo3tndKilcEOzi3h
         yQwtBbh8MpNlAgRflFdixEE8Zetxs0pz5+rgmhOhRm13diQvyEh9EC33DdE8xnRsMIrX
         gFLQEUNyfEehvjjjeIzgNnr9rRGos/dm2fX4PJstmW82V20myb/aL6RwBOWkBPUBtp8y
         /BA+0qY9A4t7v4Wt3C6q490rtABa8jgxS98oaFPgcOnVqkf1vVWfi7RDAl1SmFUTz5Y5
         /qrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeS9D/9kEiDi/72DzlEJvumivORqqB3xxhU3jnWOrC3d9ahMAn928xppDGIMDgz28X+pEAIeom/mnpozN0GUQjtvJbLlBX3vQCdzfm
X-Gm-Message-State: AOJu0YxWQe1su2DRl9a5jWdpSLnnmsZ5F1zxC0nLqRcFvpma8FHUwBPZ
	X7m3xOh0UUhPLsAMB8apw1FBpCDb8Ld5NaeuT0MSdiNSi1F74Iyu9K3mIzkW
X-Google-Smtp-Source: AGHT+IEvfapHTbNehA0HQTxaqun/SCgcFXlH6pUG7ShOd+3RlWSH6hXb/ssDyhBIhmSymskKgzSeqw==
X-Received: by 2002:a81:a24f:0:b0:61b:e645:3e94 with SMTP id 00721157ae682-675b38232b5mr11461217b3.5.1721893678864;
        Thu, 25 Jul 2024 00:47:58 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd9043sm2545557b3.16.2024.07.25.00.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 00:47:58 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64b29539d86so6174727b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:47:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAfLp7vyIZ/6kDS5hlkYlRpVEzeAoVG3NdFBzlvWtLMXBVfbBk3AsP0fUUDbAhZEOm8pdEmEKmkkZ5AfSqegoHf1G/z67sniuun+LO
X-Received: by 2002:a0d:d206:0:b0:632:c442:2316 with SMTP id
 00721157ae682-675b3823daamr10984047b3.3.1721893678344; Thu, 25 Jul 2024
 00:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <578dafcbdf8287e73dd30e96e23814b8c029ea96.1721719060.git.geert+renesas@glider.be>
 <20240725092757.2d062719@bootlin.com>
In-Reply-To: <20240725092757.2d062719@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2024 09:47:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUanrrZW5_MOXO=oMi7efAAYVAWjJb1dFd8vQ_JHhfCSQ@mail.gmail.com>
Message-ID: <CAMuHMdUanrrZW5_MOXO=oMi7efAAYVAWjJb1dFd8vQ_JHhfCSQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: LAN966X_OIC should depend on SOC_LAN966 || MFD_LAN966X_PCI
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, Jul 25, 2024 at 9:27=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
> On Tue, 23 Jul 2024 09:17:53 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > The Microchip LAN966x outband interrupt controller is only present on
> > Microchip LAN966x SoCs.  However, when used as a PCI endpoint, all
> > peripherals of the LAN966x SoC can be accessed by the PCI host.  Hence
> > add dependencies on SOC_LAN966 and MFD_LAN966X_PCI, to prevent asking
> > the user about this driver when configuring a kernel without Microchip
> > LAN966x SoC and PCIe support.
>
> I would expect a make olddefconfig silently disable LAN966X_OIC.
> This is not the case ?

I guess it does.  However, I never use that, as it would cause me
to miss new symbols that I do want to enable for my target platforms.

Quoting Linus Torvals[1]:

    I use "make oldconfig" for every single machine I boot, because
why wouldn't I?
    Isn't that what everybody does?

"make oldconfig" is what I have been using for ages, too...

> > Fixes: 3e3a7b35332924c8 ("irqchip: Add support for LAN966x OIC")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > The patch defining MFD_LAN966X_PCI has not been accepted yet.
> > Hence my initial thought was to add a dependency on PCI instead, but
> > that wouldn't make much sense, as the OIC driver cannot be used without
> > the MFD driver anyway.  Alternatively, the MFD_LAN966X_PCI dependency
> > could be dropped for now, requiring a follow-up patch later.
> >
> > "[PATCH v2 18/19] mfd: Add support for LAN966x PCI device"
> > https://lore.kernel.org/all/20240527161450.326615-19-herve.codina@bootl=
in.com/
> > ---
> >  drivers/irqchip/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index bac1f0cb26e67a2b..b8d5ca3183824c93 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -171,6 +171,7 @@ config IXP4XX_IRQ
> >
> >  config LAN966X_OIC
> >       tristate "Microchip LAN966x OIC Support"
> > +     depends on SOC_LAN966 || MFD_LAN966X_PCI || COMPILE_TEST
> >       select GENERIC_IRQ_CHIP
> >       select IRQ_DOMAIN
> >       help
>
> SOC_LAN966 is used only for the SOC mode of the LAN966x.
> In that case, the LAN966x OIC driver is not used. Indeed, this
> driver is used only in LAN966x PCI endpoint mode.

IC. From the description in the bindings (and the commit message of
3e3a7b35332924c8), I was under the impression it is used for both:

  The Microchip LAN966x outband interrupt controller (OIC) maps the interna=
l
  interrupt sources of the LAN966x device to an external interrupt.
  When the LAN966x device is used as a PCI device, the external interrupt i=
s
  routed to the PCI interrupt.

Perhaps it should be reworded, e.g.:

    The Microchip LAN966x outband interrupt controller (OIC) maps the inter=
nal
    interrupt sources of the LAN966x device to a PCI interrupt when the LAN=
966x
    device is used as a PCI device.

Or perhaps I misunderstood completely, and the internal interrupt
sources can be mapped to a different external interrupt for other use
cases, too?

> depends on MFD_LAN966X_PCI is indeed correct but, as you mentioned
> it, patch defining MFD_LAN966X_PCI has not been accepter yet and
> MFD_LAN966X_PCI is probably going to be renamed (the driver is
> going to move from drivers/mfd to drivers/misc).

IC. So a dependency on PCI is currently the best option?

[1] https://lore.kernel.org/all/CAHk-=3DwiqETvfxW_mG6++9uX4tY5gYbqqXsMURDw1=
nQy0q0qohw@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

