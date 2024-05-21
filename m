Return-Path: <linux-kernel+bounces-184884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3678CAD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C81C21FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EA762F7;
	Tue, 21 May 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LJd+J3Ac"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2676045
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291400; cv=none; b=kIEdlbdvgp4FfnzJf2NE560wj7FZHU8G5F9I+WEMqW2Yu4+Fzda4L38yNUhyb/Y1SGtNysNR9kn3j2lRLu2Ir7nPJ36F5jmhyqzsur3Q5Pk4JkOuUZBrONhe3DuTSe+cZx6JyjsqV615WJmEx+rqjnAu4MgAdeBthdPl/btNYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291400; c=relaxed/simple;
	bh=0rcapEqxs41vbAZ49qSA1BOwKQuSDi260jCQiTRZpvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeHyCBAiWiBVGuiPQXpm5oxdqq0CWQHyEurmQauxJz4MqSG9gRgvkyj0grthbflW13GS44054M7eQUeOJ5PPGTFD7crnMAsbFOq4tIyGffiMjImJNtquDh10MdW2Wc3j9KMK6J5a7DKmoTvvO+uDUgW+rWeVsbXJbJ+oOgoYnsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LJd+J3Ac; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so4801605e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716291396; x=1716896196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezMc5cGqBhnSYyOCv9DNerv8NGnihO5D5RjJ4Az87aw=;
        b=LJd+J3AcX74CMPT0Vb3NQH8TIBKsh3CHfxPIT52k1zRzqAFUACqT2YBhze/C0bwBGa
         YlXlCfoGRnIG2padIYRISgbuvFxPVFv76ZvTDzTjNAlioJ3T4WgUfwILxKA50nOzx8CR
         yACOrwB2RYdhsWdsvqdyFefY9ffH/A7duEN9MikJVr30pY6OtrgQRGfJqjPNyjvIQUlr
         2RMguXzyT903e7C+QOUyM4QKAF36nPM1CxOGvYfKbd1IVvbzRU8/TSXrtwYrFvcOSyOt
         U9JqNkmCqU3srMpH0BmSzjm9B6T4ry9u+KWs//PClcVrpx6ehEn+H9sKCIUApFzTxZD2
         ueig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716291396; x=1716896196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezMc5cGqBhnSYyOCv9DNerv8NGnihO5D5RjJ4Az87aw=;
        b=v3TxiDZ2X5PPqwQZ9u5XBe/fp65B9/FbUMYLBhBJc41Pd2uymX9DAxXFpZlag6ko+X
         rUSa5nsJqXYfcISPeGfTjlH8O5PP5DEZCYH6iTnESh/ATnR1vfGl6rVJ9eaNdmuC6ms9
         PVGOgUVwCYDRRIUY2u18qsEinY7/OSEGebpFnXMU4tMT9Jnfa1DKwfsvkQ6AsLSklwEz
         SzT7rBBnQzvrKcIFF8CiFqCD+8Zj6my6ctLQagB2OuNSaVTQ3eYqPf9/IChWxSgivnZA
         WLzxV22a7O9Y4pK2/GJOpVfbJKcOBnC+xeSPQuY4d/J6/2P/7feY7d03OvNIhlhuL3J4
         Ri8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlA0iJX86hp4tvPxp3MJJKMbyjGs9s8whXqwTF98RoId5kR4qNNVIpj3bhqk6LpeFbwm2rsxyIsIN7cmRQWd2zbKd6El6U9qJ3Lryk
X-Gm-Message-State: AOJu0YxzCWSe9It4G2mr+R+SvisNcpfl7vFNnH8Q3RfytgB8y8R8n5PT
	Wv/GrbDom+BuW4TK5ku/rd20PBlUlnEg93eQuEEYtnB3BzkbCicd7S0r53qE2Xcnjv0cunpwsvP
	F+aPkzFRvi27NM7DzBrHZRo0P4slE7LcE2qqT7Q==
X-Google-Smtp-Source: AGHT+IFcwwn5F3Xk+dILhbEtFsSpbcx0pGZVENIcfIkUlhSvs22WEVvtdtuLNFtg/lNaqWzYjYFx9XnbWSspw0LL+LM=
X-Received: by 2002:a05:6512:114d:b0:516:be0a:58b with SMTP id
 2adb3069b0e04-524079a820emr3611763e87.6.1716291396003; Tue, 21 May 2024
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519144920.14804-1-egyszeregy@freemail.hu>
 <CAMRc=MctEsMiRgaV5UTiaxjoFDa2izX9wnLAU07=G8gBEcSKoQ@mail.gmail.com> <3c0f28a0-9d07-4e15-ad8e-ad22f25ff979@freemail.hu>
In-Reply-To: <3c0f28a0-9d07-4e15-ad8e-ad22f25ff979@freemail.hu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 May 2024 13:36:24 +0200
Message-ID: <CAMRc=MeiDJoZe+X8CzGduFdSs4dTo8L3FPPd30LW07VpH_wG7A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Introduce "linux,gpiochip-name" property for
 device tree of GPIO controller.
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 6:41=E2=80=AFPM Sz=C5=91ke Benjamin <egyszeregy@fre=
email.hu> wrote:
>
> 2024. 05. 19. 19:27 keltez=C3=A9ssel, Bartosz Golaszewski =C3=ADrta:
> > On Sun, May 19, 2024 at 4:49=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
> >>
> >> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> >>
> >> Optionally, a GPIO controller may have a "linux,gpiochip-name" propert=
y.
> >
> > Oh, may it really?
> >
> > $ git grep "linux,gpiochip-name" Documentation/devicetree/bindings/
> > $
> >
> > Doesn't look like it.
> >
> >> This is a string which is defining a custom suffix name for gpiochip i=
n
> >> /dev/gpiochip-<name> format. It helps to improve software portability
> >> between various SoCs and reduce complexities of hardware related codes
> >> in SWs.
> >>
> >> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> >> ---
> >>   drivers/gpio/gpiolib.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> >> index ce94e37bcbee..e24d8db1d054 100644
> >> --- a/drivers/gpio/gpiolib.c
> >> +++ b/drivers/gpio/gpiolib.c
> >> @@ -860,6 +860,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *g=
c, void *data,
> >>                                 struct lock_class_key *lock_key,
> >>                                 struct lock_class_key *request_key)
> >>   {
> >> +       const char *name;
> >>          struct gpio_device *gdev;
> >>          unsigned int desc_index;
> >>          int base =3D 0;
> >> @@ -896,7 +897,16 @@ int gpiochip_add_data_with_key(struct gpio_chip *=
gc, void *data,
> >>                  goto err_free_gdev;
> >>          }
> >>
> >> -       ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id)=
;
> >> +       /*
> >> +        * If "linux,gpiochip-name" is specified in device tree, use /=
dev/gpiochip-<name>
> >> +        * in Linux userspace, otherwise use /dev/gpiochip<id>.
> >> +        */
> >> +       ret =3D device_property_read_string(gc->parent, "linux,gpiochi=
p-name", &name);
> >> +       if (ret < 0)
> >> +               ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", g=
dev->id);
> >> +       else
> >> +               ret =3D dev_set_name(&gdev->dev, GPIOCHIP_NAME "-%s", =
name);
> >> +
> >>          if (ret)
> >>                  goto err_free_ida;
> >>
> >> --
> >> 2.39.3
> >>
> >
> > NAK, this is udev's task in user-space if you need this.
> >
> > Bart
>
> Hi,
>
> Goal of this patch is to introduce this new mode to assign a custom name =
from
> lowlevel device tree to a gpio bank.
>

The goal of this patch seems to be to push some unnecessary downstream
functionality into the mainline kernel.

> It is more maintainable then use udev in userspace for it.
> For example there are three different SoCs: i.MX7, i.MX9, ZynqMP.
>
> In Yocto project, the Linux image's SW environment is nicely configurable
> independently from what is the target MACHNIE. But if i like to deploy a =
SW
> which uses peripheries like gpiobanks, i2c-dev, spidev these /dev/... nam=
e will
> be totally different on each SoCs, more over in ZynqMP and any other Adap=
tive
> SoC platform, the index number for the gpiobanks or other can be not
> deterministic if it probed in run-time. Goal is to easily make a Linux OS=
 image
> which can support multiple SoCs and in SW point of view it is flexible.
>
> So, in Yocto project point of view the best, if any Machine specific sett=
ings is
> stored in the device tree files of the target MACHNIEs in driver levels/c=
onfig,
> because it will be deterministic in 100% sure and it will be nicely separ=
ated
> from the SW meta layers which may not contains any machine specific hacki=
ng with
> udev and so on for building image.
>
> So this way to assign a custom name for a gpiobanks from device tree is m=
ore
> efficient and more maintainable in SW developing point of view in
> Yocto/buildroot world because i need to just define a name like
> linux,gpiochip-name =3D "expander"; then use it with a fixed name in my g=
eneric SW
> under /dev/gpiochip-expander name. And there are no need to care about wh=
at will
> be the index number of this banks randomly after boot and how need to mak=
e an
> ugly append layer for udev and make it for all of machine variants which =
are the
> target to use with the same SW.
>
> My opinion udev is ugly to use for it and more complicated, and no longer
> beneficial for new Adaptive SoCs where they can be not deterministic what=
 kind
> of index number they got in driver probing (you will not know what index =
need to
> mapping for what custom name). It is much better to assign this suffix/na=
me
> explicitly from device tree.
>

The information you want to store here is already accessible in the
chip's label (set by the relevant driver) that you can retrieve using
libgpiod (or sysfs if you must) and create appropriate links using
udev. This is how it's done for other devices, I see no reason to make
GPIO a special case.

Bart

