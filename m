Return-Path: <linux-kernel+bounces-249158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E3A92E7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038781C212F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE515957E;
	Thu, 11 Jul 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQ5oynFP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AF156993
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699175; cv=none; b=aWKs5S3o7A0vJRgUkNJIEEoBebp8Prjviqusk48xm5E2qm0tZ6x+jzgeDlA6tAQz4Baht5bj7/zBzPgSa36tzo/lGpIii6N1Z5wngGV08+agYvEIU9IA7LxtmxVCFdmLEUcX5REoeXMJ0c1c2X+Zw5dCYJXPCbgZkbxk25iUbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699175; c=relaxed/simple;
	bh=hgVajsSMleVzgg4GLptF7/bEsjil7cS35tYtJx5AJHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhCfHUq8sqEDq+uerRPFgHwDrZDcmC/KJB+1FmiXe0/AlGWp5aO4He1KQy/hBQ0SsiYVNMpT/GrKBTVMVo6EzDQetl0JTbhgR7dJaOLnX3F1wiKlrdYaF0+wdzEctEVVNiyO+Jdww1zVra+h4V0FIeYiXZmd6cWfvoN/mrvJFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQ5oynFP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1393356a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720699172; x=1721303972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=werTonj7QNq+ua51haeygUPcm9W0ZEoCpESBneEXr5U=;
        b=lQ5oynFPk0e8HbFc/9rxReNX9i7FB3tiIHG8nfMyR2JPmxydCLvq6T/4U4ga5v9vaj
         yL6lOt9cNNrIrB4qLohA29U8ErzMPnBjeyUsLrZKLQIrKPAz8vwNLTV0oi8+iXW+ywxU
         ddOt3kAl+rI4jkuZqYoOBG/5WjEGTruINGehnW3AoAWaT3T3ymvCBi55N5Lg4MiVTgjn
         ivih4T3UBaVmYbyt1EfX54pB1GoRa3dpg/DRv6HoV53pAWSYNEmJH9cFyKgqUsRn3SVG
         tPbvENzbdaqg8lIFujBsw7aMBvCJ2UXRzP3xkuxoBoLJNaf1Fs1/LbmJ+E9P0vVEZJNF
         dcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699172; x=1721303972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=werTonj7QNq+ua51haeygUPcm9W0ZEoCpESBneEXr5U=;
        b=WcdGfT4EXu9MAMJa7MjTJ2W4H65J55rgEl9UByrVBze8iO63GpbxNpBJDvQ+CaK9r/
         M15zdosXWvQ+m8u5WVMT/IhOjQGKGI5/OmNnhDip21nnh0nkvk6qJ3zAoiKv9H0NVoQS
         cFuUfc3gWSGi08PqxKAMpHZFi9v3z9TF+XtdJul4sKM7N8VYNKimeQg0xCzZXmpRuqUx
         tuZ6lAzKFA6aYBA0jQyZowcOyqRQIOted4vwuAvL5omkWQSY3WW59gpbB2Ab9uBM6BtQ
         TeuBA2YAKORHoV9ToRObQsHioUyq/Vy9YuuAP39Zqp7RfNy+EsPpwLA6+kffGyWF1I2b
         Dr5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCCIa0eBuX+YjnKF+VfBBZHSkPebaEUGSBl/0H9CsM044hi+t0tDTqNnu49LWnZQxTYeP0cm5HY/E4Zsn3pZ+KOIyIlRptrwKPgGrI
X-Gm-Message-State: AOJu0Ywf6hL55g1wIQ0xw5iFVEw2AIuBh+ZoEXfEegvfE0/jvxwJ0DGQ
	R653cBpt1Cy4q0XXm9SuXuqtX8VEI+mb+KjO4tprx4nsTl+9v1BmYYYg2XITuVHS3NDX13svAGC
	9a5K+2iQ9S/Sa00bi9nyBwqQyH/6AlDln3qKr1g==
X-Google-Smtp-Source: AGHT+IHoRn575wSFRpHdhPoGsIQtDx3qlYWl74xlQ60nrZPI28oD6g5R4UE+O1SA6Aq4WQmMbZWG2mYCINhvt4c3a7o=
X-Received: by 2002:a05:6402:2813:b0:57c:603a:6b2b with SMTP id
 4fb4d7f45d1cf-5980e547f6amr1736371a12.21.1720699171546; Thu, 11 Jul 2024
 04:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720690278.git.mchehab+huawei@kernel.org>
 <b9cd4a65d3389102def662a8bc09ffaa622265f7.1720690278.git.mchehab+huawei@kernel.org>
 <20240711075332-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240711075332-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 12:59:20 +0100
Message-ID: <CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm/virt: Wire up GPIO error source for ACPI / GHES
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
	Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
	Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, linux-edac@kernel.org, 
	linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 12:54, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 11, 2024 at 11:52:03AM +0200, Mauro Carvalho Chehab wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Creates a GED - Generic Event Device and set a GPIO to
> > be used or error injection.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
> >  hw/arm/virt.c            | 12 +++++++++++-
> >  include/hw/boards.h      |  1 +
> >  3 files changed, 37 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index e10cad86dd73..b6f2e55014a2 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -63,6 +63,7 @@
> >
> >  #define ARM_SPI_BASE 32
> >
> > +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
> >  #define ACPI_BUILD_TABLE_SIZE             0x20000
> >
> >  static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
> > @@ -155,9 +156,14 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
> >
> >      Aml *aei = aml_resource_template();
> >      /* Pin 3 for power button */
> > -    const uint32_t pin_list[1] = {3};
> > +    uint32_t pin = 3;
> >      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> > -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> > +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> > +                                 "GPO0", NULL, 0));
> > +    pin = 6;
> > +    /* Pin 8 for generic error */
>
> For real? Code says 6, comment says 8.
>
> Comments must come before the code they comment, not after it,
> then this kind of thing won't happen.

It might also be nice to have a symbolic constant for the
pin number somewhere, so we don't rely on the magic number here and...

> > @@ -1014,6 +1021,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
> >  {
> >      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> >                                          qdev_get_gpio_in(pl061_dev, 3));
> > +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> > +                                          qdev_get_gpio_in(pl061_dev, 6));

...here being the same.

Then if the code says "pin = VIRT_GPIO_ERROR_PIN" or something
similar the comment isn't required because the code is clear
without it.

(This is already a problem for the power-button pin 3, so we could
do an initial cleanup patch to sort out pin 3 first).

thanks
-- PMM

