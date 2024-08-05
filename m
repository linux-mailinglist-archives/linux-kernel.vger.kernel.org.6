Return-Path: <linux-kernel+bounces-274103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E142694736E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110EC1C20D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DD3398B;
	Mon,  5 Aug 2024 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YbBErYaL"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EB358A7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722825806; cv=none; b=l/M/IngErLorF99BIrblh6Cja1jkeC6PthQzddzaQJtYkN5B5LD121Zj5TMF5XFg+oCelX8bX1ULqujTbNqEgm+zz1/AKC7sReNIlbpopfWiaVX9DIF7EEg2x7qjQCixmSa0PbGTKini2Rwy+7Qr1lqRD8RDV2eGi2i0d1GK3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722825806; c=relaxed/simple;
	bh=uLbYEn6EIRDSw/yIxntzvlG0gg0CHWAaX9JxK+0AYUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaEpNQwK2hrGwwjZ28LtGSMAvJkyyrHLzkDhXFtaBzmB64SZ1TLg6cYR2Cha0ARSmGTA+B9TptFTBjwzj33pNJ5LFNuoocEKpcqj5ypl1bNtuckQ4eZOPwaZlYd2OLH1bU2Ot03OVdVVsIVM/3vPh2vXT1gAyZfmXmjWxM0NZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YbBErYaL; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6d35d59ccso3021795e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722825804; x=1723430604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RUbuXruRNtWApv98U15wtspxV+T0FPx34KxK0+1UN0=;
        b=YbBErYaLFSlpvcRHi7IpNasexFN89Ib2GqC7Dc7UgGJxdwDddXpOzZFJCbEEIpWyTn
         pZ7Z/g8fKvos18ukhbFoGmHtLv6dK1rgFIBnHQNOSSVqpCyXu2k9N9YRcJC1H0INX3c0
         nHLOP+jN1K1QsUWS3aMOSO74HC9JXFZjx4YefseO8Y9xsyqNxudj5Bzkc3Mn5EPvzFcl
         0VMkCZ+Ox8xa5aFSys5/aIe0xFWQLfM9lxD6ACFdR3oTh/ClD80DoiV8JT8Th0RyYEVA
         tleF9DT8xwKVlRLzkD6V9NhHr1nT8sAOmDhsgCuJaTfMNyysyvNlQRVs9Tjc5jesxBBR
         72vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722825804; x=1723430604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RUbuXruRNtWApv98U15wtspxV+T0FPx34KxK0+1UN0=;
        b=kMU9d4zmuGm3hes/QWTauEXrEPO8+G5gQSIKvGBT8BM9xHyBF05eOm4hsLCNwkIqH/
         E1G5VYsigSHE97C9XCqWQenB57nQQibRcF72F58It8zOtR/qaRro3Wnz8DHNVg5+WkEu
         9PpHDq7WjKymuV1sqpvLKehgSYP/nUVvetg9V5BocIVhDnhnD0P65/Uj0XLgm7zZ9um9
         Mw7UXK8x9bw6JyVbHQUbiboszcxrTMq8AlsE84OVTenRHHOtMh2CIAkdNgSHEIfvDxRQ
         tdy5ZArdABIdKwvbvaFFNosJHH/zLAjCG+umcDuUbZ9RTX4oJ+Oz9OtdAacuHJgz0Hrx
         QUnA==
X-Forwarded-Encrypted: i=1; AJvYcCW9/wtCWfcZZZD8Gp6Xk9iJjqorWw7mBI4AXTfi9G3SqEryw1BWQxYpw48SCba5ty7pFzQ5A5MCNTMz9uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/7N70L/biopNy68QwftOT9xO8vZXZ+ebPZU7D+P70QLPkBLO
	tQb3zYswy5h2ThPI3MXych9++EQVALV8oU2QaVCfFDmx6UlyjeDWPKevYQkLi79sYs4RpHylILy
	y23jEsG9KIisw+Gv23/Mz8H2zwlXgLNc/Cwgs4A==
X-Google-Smtp-Source: AGHT+IFatLCWN4zrFNBHE1t5jL8w0qqILbkTgFOCDN0JsQgmZ98A50+LWII2Fcw05mlKNHwYXyzA3S7DZAKol9OE0rk=
X-Received: by 2002:a05:6122:4692:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-4f8a00189b6mr8055589e0c.9.1722825803776; Sun, 04 Aug 2024
 19:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802075741.316968-1-vincent.chen@sifive.com> <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
In-Reply-To: <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Mon, 5 Aug 2024 10:43:12 +0800
Message-ID: <CABvJ_xgcbyQKa1+U1MC7cLEB-SUzzNaWqKdXFp+13mni0YSvNw@mail.gmail.com>
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
To: Anup Patel <anup@brainfault.org>
Cc: tglx@linutronix.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:03=E2=80=AFPM Anup Patel <anup@brainfault.org> wro=
te:
>
> On Fri, Aug 2, 2024 at 1:27=E2=80=AFPM Vincent Chen <vincent.chen@sifive.=
com> wrote:
> >
> > When the debug message of driver/base/dd.c is enabled, the following
> > error messages are present in the boot log:
> >
> > [    0.207941] platform d000000.aplic: error -EPROBE_DEFER: supplier
> > 28000000.imsics not ready
> > [    0.208115] platform d000000.aplic: Added to deferred list
>
> We are relying on fw_devlink implemented by Linux DD core to do the
> probe ordering. The above prober defer message implies that the
> Linux DD core is doing its job correctly.
>
> >
> > The reason for this error message is that the probe of APLIC is execute=
d
> > earlier than IMSIC. This error also causes all the platform devices
> > connected to the APLIC to be added to the deferred list. Because both
> > APLIC and IMSIC are registered by device_initcall, this patch adjusts t=
he
> > compile order of APLIC and IMSIC to ensure that the probe of IMSIC is
> > executed earlier than the probe of APLIC.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  drivers/irqchip/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 15635812b2d6..3c09666569d6 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -96,9 +96,9 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D ir=
q-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic-state.o ir=
q-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_RISCV_APLIC)              +=3D irq-riscv-aplic-main.o irq=
-riscv-aplic-direct.o
> >  obj-$(CONFIG_RISCV_APLIC_MSI)          +=3D irq-riscv-aplic-msi.o
> > -obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic-state.o ir=
q-riscv-imsic-early.o irq-riscv-imsic-platform.o
>
> First of all there is no issue here.
>

Hi Anup,
I understood that the defer message implies that the Linux DD core is
doing its job correctly. I also agree with you that there is no issue
here because I still can boot kernel successfully. I just hope this
process becomes smoother by adjusting the probe order because the
APLIC will depend on IMSIC when it is present.

> Secondly, changing compilation order in Makefile to influence
> the probe order will not help in any way.
>
I was confused here. If possible, hope you can help me clarify it.
The following is the backtrace of really_porbe() dumped by GDB.
#0  0xffffffff8092318a in really_probe ()
#1  0xffffffff80923516 in __driver_probe_device.part.0 ()
#2  0xffffffff8057c856 in driver_probe_device ()
#3  0xffffffff8057c9ba in __driver_attach ()
#4  0xffffffff8057aaa4 in bus_for_each_dev ()
#5  0xffffffff8057c3ea in driver_attach ()
#6  0xffffffff8057bc4a in bus_add_driver ()
#7  0xffffffff8057d75a in driver_register ()
#8  0xffffffff8057e83c in __platform_driver_register ()
#9  0xffffffff80a2455e in imsic_platform_driver_init ()
#10 0xffffffff8000212c in do_one_initcall ()
#11 0xffffffff80a01188 in kernel_init_freeable ()
#12 0xffffffff80928d80 in kernel_init ()

According to this result, the source to call really_probe is
do_one_initcall(), regardless of whether it is APLIC or IMSIC. The
do_one_initcall() function follows the placed order of the
initialization functions in the __initcall6 section to invoke them.
The compile order determines the order of the __initcall6 section.
Therefore, I try to adjust the compile order to influence the probe
order between IMSIC and APLIC. Do I misunderstand something?


> >  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_STARFIVE_JH8100_INTC)     +=3D irq-starfive-jh8100-intc.o
> >  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> > --
> > 2.34.1
> >
>
> Regards,
> Anup

