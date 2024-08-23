Return-Path: <linux-kernel+bounces-298514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752995C84B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105F7283D39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C314A632;
	Fri, 23 Aug 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZiyUVRLB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540314A4FC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402451; cv=none; b=MlUcyxHIwGA536SkUuchZk5JNhW1YB5RkM7L9vQrwJk8Lmixt9awF3XsvYR7k9yWwJiaC00QE44Vzol7UDc2ZOYoFpbDxYQXPSu2ymQHjyrcm/9DHnJan+KrcP7SXbJXplBd1Cd1pdAtugUJTm8HAUnZMPaPEK0S4qqf3kIbM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402451; c=relaxed/simple;
	bh=rSAxoLAIxNnhMmXj0OKHqhTBO3NIzJKSbDvnn5YHufM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phmkg3dwn0PcuqtP6sntEt3xnV3DS8tyJiAXcqsiQ1yD0U33uyqTs+F6HgshNSo0ZJ2km3/DH5cG+J9JMXEcA2Sq++gbOFdziBxO1zwyRXQGfSsKw7mZjxeGpVYwqNVOZ5PWnV52tPMX1S6uNKGzgaqVkW6w7zk9+PWUMt0L9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZiyUVRLB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533496017f8so2288791e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724402447; x=1725007247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giON8Q4LjGFF8ELEjzDZqXiqE5K5VOG4OBV3cUf5KM0=;
        b=ZiyUVRLBKiTQhhyZ80u6eKtR3BPW82pbcR/5U+AZ/q7fsuKYdfOZMhTkRhr3H6nlno
         bcb2A4amj9zQwLhN8DDgKlcWp25dXLWXrTyH7earzdhWc0elHDCl4CaU6K1nR+od5E8H
         DqwN8sgT/doUSCytrOyhzmlGcPcwGK1jS+sNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402447; x=1725007247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giON8Q4LjGFF8ELEjzDZqXiqE5K5VOG4OBV3cUf5KM0=;
        b=sCDnztzKdWpum5sAq8hYx4q9uDEbSj+IPESjNwpsplAI7GABnpiGq3HuXxND/GmJOH
         knRWV9R3A/tnzijhm4MTJA7O9b9W/GEp+zM5EjRXv4o8Gkhjf6Agt1Dfp3wZBQRrjVWY
         GBODvfaoNnlyzPaEcC35eIu9KMpLr7XpHbZT4u+0R7kmgVOg9JnuhlzfZi4+cpkxhE+h
         J8zuoHwQL/rjoB+KyI5CrSD0pLPwEnX94wiw0hmqfpusrMgq4EIYK86nepIbuN6ehr8n
         gKfBsZ+9njQiI4Db1woAkYhLmraDEmMEC9WgcnOsq65Io8ca40Y5jDnycp4mQFyCny05
         TfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgTMpd6PGt9plj1g2ZH56d1ICBv6vgW+0adwID33Rv0O5ocLYM3jYo23QAhxFsdmI0spUIPqklNOvOnBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGzIoyQToMHCx9bQXHb4pAR+Cn0pZ0vjXZ+5taHKFIj9QkWO5
	SDgYRIkflMU+gcRfClTD+Mylo9cUoLHm54s4aDZGlAzKa4qaPEDzK+4AlDN0GH4BdgyytJkp5TY
	DSwUCq2Fj/HPaXyKIVlb7G6wXxj5O1MKury9i
X-Google-Smtp-Source: AGHT+IFnhIjmtVb9vM0UayOlpRV8Kz6kcZZB1TNIceqcnBHabmU8gzY4wCKbVc+Nrlh5/jdYTbjbi55KO9/vc0BqWDo=
X-Received: by 2002:a05:6512:b01:b0:52e:9fd3:f0ca with SMTP id
 2adb3069b0e04-5343883a3a8mr1006281e87.33.1724402447359; Fri, 23 Aug 2024
 01:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822092006.3134096-1-wenst@chromium.org> <20240822092006.3134096-7-wenst@chromium.org>
 <ZsdE0PxKnGRjzChl@smile.fi.intel.com>
In-Reply-To: <ZsdE0PxKnGRjzChl@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 23 Aug 2024 16:40:36 +0800
Message-ID: <CAGXv+5HtjWi60OnMrjR3fnO3T=7uyMazr1aKBFjuPmWuE9NK6g@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] i2c: Introduce OF component probe function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 22, 2024 at 05:19:59PM +0800, Chen-Yu Tsai wrote:
> > Some devices are designed and manufactured with some components having
> > multiple drop-in replacement options. These components are often
> > connected to the mainboard via ribbon cables, having the same signals
> > and pin assignments across all options. These may include the display
> > panel and touchscreen on laptops and tablets, and the trackpad on
> > laptops. Sometimes which component option is used in a particular devic=
e
> > can be detected by some firmware provided identifier, other times that
> > information is not available, and the kernel has to try to probe each
> > device.
> >
> > This change attempts to make the "probe each device" case cleaner. The
> > current approach is to have all options added and enabled in the device
> > tree. The kernel would then bind each device and run each driver's prob=
e
> > function. This works, but has been broken before due to the introductio=
n
> > of asynchronous probing, causing multiple instances requesting "shared"
> > resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> > time, with only one instance succeeding. Work arounds for these include
> > moving the pinmux to the parent I2C controller, using GPIO hogs or
> > pinmux settings to keep the GPIO pins in some fixed configuration, and
> > requesting the interrupt line very late. Such configurations can be see=
n
> > on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> > Lenovo Thinkpad 13S.
> >
> > Instead of this delicate dance between drivers and device tree quirks,
> > this change introduces a simple I2C component probe. function For a
> > given class of devices on the same I2C bus, it will go through all of
> > them, doing a simple I2C read transfer and see which one of them respon=
ds.
> > It will then enable the device that responds.
> >
> > This requires some minor modifications in the existing device tree. The
> > status for all the device nodes for the component options must be set
> > to "failed-needs-probe". This makes it clear that some mechanism is
> > needed to enable one of them, and also prevents the prober and device
> > drivers running at the same time.
>
> ...
>
> > --- a/drivers/i2c/Makefile
> > +++ b/drivers/i2c/Makefile
> > @@ -9,6 +9,7 @@ i2c-core-objs                         :=3D i2c-core-bas=
e.o i2c-core-smbus.o
> >  i2c-core-$(CONFIG_ACPI)              +=3D i2c-core-acpi.o
> >  i2c-core-$(CONFIG_I2C_SLAVE)         +=3D i2c-core-slave.o
> >  i2c-core-$(CONFIG_OF)                +=3D i2c-core-of.o
> > +i2c-core-$(CONFIG_OF_DYNAMIC)        +=3D i2c-core-of-prober.o
>
> Seems like all the above (except ACPI) have the same issue, i.e. TABs/spa=
ces
> mixture.

I was lazy and just copied the previous line. I'll fix the new line for now=
.

> ...
>
> > +     ret =3D of_changeset_apply(ocs);
> > +     if (!ret) {
>
> Why not positive conditional?

No real reason. I suppose having the error condition come first is more
common. Not sure if it makes any difference in this case though?


Thanks
ChenYu


> > +             /*
> > +              * ocs is intentionally kept around as it needs to
> > +              * exist as long as the change is applied.
> > +              */
> > +             void *ptr __always_unused =3D no_free_ptr(ocs);
> > +     } else {
> > +             /* ocs needs to be explicitly cleaned up before being fre=
ed. */
> > +             of_changeset_destroy(ocs);
> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

