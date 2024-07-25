Return-Path: <linux-kernel+bounces-262126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C993C119
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF811C214FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405291991D9;
	Thu, 25 Jul 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dTYeIO2d"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DE3C3C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908203; cv=none; b=SvfYpQyOA1vdxWn1YTd5DPkFxDzA/asjbM0r4mdvRewsAcjFj+tmGq1tJ7b3EnhjgruSQKSJ0OM82HoxJJ2cE6D6FGrFDqyQIdgv3SKqSjXcV/NA1tPunY6JJaY6on3MWl0fXvKXj5qs8fIvz1+7G6yIhXoh04iRSmo5A+h789w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908203; c=relaxed/simple;
	bh=dHvts43YcRpHLy+11rLZcq+luC8QcsTdqBYPc8w9EgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UY2Sm2IvZizZvcly998OpBXfvvxPH0ZnlXO71VRZdYqtPecmDe5FyJrfNmDztpiJ7F8jc94mxEYwB944PgYvnAUNo8wBF0AxTQ4MQhMehn9shr6xNAQNREIVD5mkDprvWCOmZr2c7RSfc3FtRoCXSp0h7i4v5GzNBwqFMiTtSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dTYeIO2d; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF702C0002;
	Thu, 25 Jul 2024 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721908192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEcpK5EfotI2bD6x19tILgTi/WvaO6fYgyHtzzWjiQc=;
	b=dTYeIO2dmmQKTlQ5kOGEzsuDDyCzzX1wEoaUP53U07DmbFtW6tT90NUL3PkFDjgZuDFsEa
	y9ZvQUIFzT9lglhuAApbmaHkzZHN/LO0JOHPWbMOLdJcI19uIG1w0l/IE4fcK1PkNdP4y6
	1YrzraGyrjCJvh6ac/qJRpD6RRsK0/2m6zTD4s1xOwdgzzQdVEuiu3glKLZ8+lMFZ2kRqf
	EYU3UEWNudklvQZTakEkW1Ew329DPs4ZET9s9gXzWp+C6gX3xGCT2IQRbr3p6BsfmIzoy4
	Eo4p8UPv7Zlhu12Bt9fVmz8rNw1ixDuf8ZEGgW2BP1B35qbdJ+K3fGn6XG/ZWA==
Date: Thu, 25 Jul 2024 13:49:51 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: LAN966X_OIC should depend on SOC_LAN966 ||
 MFD_LAN966X_PCI
Message-ID: <20240725134951.1f4ac87e@bootlin.com>
In-Reply-To: <CAMuHMdUanrrZW5_MOXO=oMi7efAAYVAWjJb1dFd8vQ_JHhfCSQ@mail.gmail.com>
References: <578dafcbdf8287e73dd30e96e23814b8c029ea96.1721719060.git.geert+renesas@glider.be>
	<20240725092757.2d062719@bootlin.com>
	<CAMuHMdUanrrZW5_MOXO=oMi7efAAYVAWjJb1dFd8vQ_JHhfCSQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Thu, 25 Jul 2024 09:47:46 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hervé,
> 
> On Thu, Jul 25, 2024 at 9:27 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Tue, 23 Jul 2024 09:17:53 +0200
> > Geert Uytterhoeven <geert+renesas@glider.be> wrote:  
> > > The Microchip LAN966x outband interrupt controller is only present on
> > > Microchip LAN966x SoCs.  However, when used as a PCI endpoint, all
> > > peripherals of the LAN966x SoC can be accessed by the PCI host.  Hence
> > > add dependencies on SOC_LAN966 and MFD_LAN966X_PCI, to prevent asking
> > > the user about this driver when configuring a kernel without Microchip
> > > LAN966x SoC and PCIe support.  
> >
> > I would expect a make olddefconfig silently disable LAN966X_OIC.
> > This is not the case ?  
> 
> I guess it does.  However, I never use that, as it would cause me
> to miss new symbols that I do want to enable for my target platforms.
> 
> Quoting Linus Torvals[1]:
> 
>     I use "make oldconfig" for every single machine I boot, because
> why wouldn't I?
>     Isn't that what everybody does?
> 
> "make oldconfig" is what I have been using for ages, too...
> 
> > > Fixes: 3e3a7b35332924c8 ("irqchip: Add support for LAN966x OIC")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > The patch defining MFD_LAN966X_PCI has not been accepted yet.
> > > Hence my initial thought was to add a dependency on PCI instead, but
> > > that wouldn't make much sense, as the OIC driver cannot be used without
> > > the MFD driver anyway.  Alternatively, the MFD_LAN966X_PCI dependency
> > > could be dropped for now, requiring a follow-up patch later.
> > >
> > > "[PATCH v2 18/19] mfd: Add support for LAN966x PCI device"
> > > https://lore.kernel.org/all/20240527161450.326615-19-herve.codina@bootlin.com/
> > > ---
> > >  drivers/irqchip/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > index bac1f0cb26e67a2b..b8d5ca3183824c93 100644
> > > --- a/drivers/irqchip/Kconfig
> > > +++ b/drivers/irqchip/Kconfig
> > > @@ -171,6 +171,7 @@ config IXP4XX_IRQ
> > >
> > >  config LAN966X_OIC
> > >       tristate "Microchip LAN966x OIC Support"
> > > +     depends on SOC_LAN966 || MFD_LAN966X_PCI || COMPILE_TEST
> > >       select GENERIC_IRQ_CHIP
> > >       select IRQ_DOMAIN
> > >       help  
> >
> > SOC_LAN966 is used only for the SOC mode of the LAN966x.
> > In that case, the LAN966x OIC driver is not used. Indeed, this
> > driver is used only in LAN966x PCI endpoint mode.  
> 
> IC. From the description in the bindings (and the commit message of
> 3e3a7b35332924c8), I was under the impression it is used for both:
> 
>   The Microchip LAN966x outband interrupt controller (OIC) maps the internal
>   interrupt sources of the LAN966x device to an external interrupt.
>   When the LAN966x device is used as a PCI device, the external interrupt is
>   routed to the PCI interrupt.
> 
> Perhaps it should be reworded, e.g.:
> 
>     The Microchip LAN966x outband interrupt controller (OIC) maps the internal
>     interrupt sources of the LAN966x device to a PCI interrupt when the LAN966x
>     device is used as a PCI device.
> 
> Or perhaps I misunderstood completely, and the internal interrupt
> sources can be mapped to a different external interrupt for other use
> cases, too?

You understood correctly.
And I agree, the description could be reworded.

> 
> > depends on MFD_LAN966X_PCI is indeed correct but, as you mentioned
> > it, patch defining MFD_LAN966X_PCI has not been accepter yet and
> > MFD_LAN966X_PCI is probably going to be renamed (the driver is
> > going to move from drivers/mfd to drivers/misc).  
> 
> IC. So a dependency on PCI is currently the best option?

Probably yes and this dependencies will have to be updated to MFD_LAN966X_PCI
or equivalent as soon as MFD_LAN966X_PCI or equivalent is available.

Best regards,
Hervé

