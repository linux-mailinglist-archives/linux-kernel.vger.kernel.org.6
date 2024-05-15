Return-Path: <linux-kernel+bounces-179716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B499F8C6404
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6791D282F38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B659151;
	Wed, 15 May 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmWbDqtN"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4473B78D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766334; cv=none; b=C1NIed+n15OjUfAWCn3+TvAN9m+zFXv9zUfRVwC4jTLnrb/j7kM/vs7b2C3zsxGXcQvmdROcGs9WL8hVpAcPAdWxFPWC1qI9+Han0bRbHDqcc+GW8EsZWGnJTOFsh2GWtLKKapwhYZeRbH8NIOJLHMF22t+I93odYCRQnY60n3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766334; c=relaxed/simple;
	bh=JRLsaes2n+fx1g7fTVlLvO0GErQiuRGa5Ukv0jsD8JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udb3Cgnci6nvbBHXdNU4qweFXa8NYbqMrLz9sETtS7NMwpMcHPn7PV478sq0AtbmBAo+3p3NuCH3ycGZtVNni7/kyM9REEcuryJl+M6rYPAXDvyClu/nIYmw5i+gfcKArDbEBw7vQtGHhOhCgTeiOpL6VIhXaxLjZVRcBFOcz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmWbDqtN; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-244d692e9b9so1649052fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715766332; x=1716371132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6EkIVd0v6k33+WDHvOH1msWEs1FiIcoXhRYw7Xr9mg=;
        b=WmWbDqtNry4Gl2cIJTlpeGQQlf6abdKndgdSRP+G47fnyyeddMNCL5MMusKIshNxE7
         w5in/ubKi5tcx4bYpA1SgUgceRAkJQSCXUXyZYkiKopfXWImD/mTD4ZAa6vah0qXjVn/
         awBBHoYd587s/6sGKblc3FqHtRZAJWTDb2NNzBPRTTxBpG6HknqcA+dzU2U5SUHiFWWE
         1u8UJqqRZ02o77FAFXCi9pgJepkH7nB/Rz42cDhn87OrPQfioavGQlzIGix8EeuhP/h+
         N4sf+pM22p0ov4wXj1DFKghk8uirc/LKp/NUOvBwmOx1qvzPY/+Axkel+Hal6ohCzdw3
         7Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766332; x=1716371132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6EkIVd0v6k33+WDHvOH1msWEs1FiIcoXhRYw7Xr9mg=;
        b=pdUmW//iH+uvxcSf/ONF9UPcnLOImAzdvNm7K1LevMlaTR6L8rwgsXmROWLlsOb20U
         QwH3cFHX19GjBHIVxt7RDJISiRxce33vYYZXVHaPHAeLpzA4AvRPc3Xxno/wwMSwl13/
         s8hirsU9I5OcfeuSY7xNjSh5t03BIx46C8fqWvNGBrpF+gTSsq4a0cwDIpLdjCPubZAE
         zO1Pm0cogyDGJD7yvd3PgonME7sPWzpgCzhbiDUqWY07NwCVhtS95npU1t4lMx8jsZkw
         ydaC+5M1Qpg7+JlVEIVBEe6fvZDsZ/dUQgFQmswS4pmONX+wg9L91952On7dMjNOIWvA
         UhZg==
X-Gm-Message-State: AOJu0YwVytrFICChxl7uh+iO5yvXG9cTvDyPVs1BDiwmHpmNbm24mr0C
	iRuCoBpCJeRL1ZH1r6F1GsNE2O45lO0NMflag1WC2xG57S2dmwBDqzzBf312oetbIioNaLxyQ1H
	5O50IjQnUV49I5WvrHzXH6ubWDNN5i3x4avmHpQ==
X-Google-Smtp-Source: AGHT+IFA1vxSoRZCoQ+lFYHsLhSUmYQ1wNrbJVvrzY97iQcCxrXCA1lV/tz8D1PjoD7etTD3pYPf5QhBB5GJyU5irx4=
X-Received: by 2002:a05:6870:8552:b0:23c:ca10:cc23 with SMTP id
 586e51a60fabf-24172f84d1emr16783291fac.51.1715766331748; Wed, 15 May 2024
 02:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
 <20240507091619.2208810-2-jens.wiklander@linaro.org> <2024051424-shack-blinking-547a@gregkh>
 <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com> <2024051544-clarinet-baffle-c9d6@gregkh>
In-Reply-To: <2024051544-clarinet-baffle-c9d6@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 15 May 2024 11:45:20 +0200
Message-ID: <CAHUa44FwksL_1506TLv-06UMub_7Ot43bcSPuhkP=dX9CZhESg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Manuel Traut <manut@mecka.net>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 15, 2024 at 09:51:32AM +0200, Jens Wiklander wrote:
> > On Tue, May 14, 2024 at 5:45=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> > > > A number of storage technologies support a specialised hardware
> > > > partition designed to be resistant to replay attacks. The underlyin=
g
> > > > HW protocols differ but the operations are common. The RPMB partiti=
on
> > > > cannot be accessed via standard block layer, but by a set of specif=
ic
> > > > RPMB commands. Such a partition provides authenticated and replay
> > > > protected access, hence suitable as a secure storage.
> > > >
> > > > The initial aim of this patch is to provide a simple RPMB driver
> > > > interface which can be accessed by the optee driver to facilitate e=
arly
> > > > RPMB access to OP-TEE OS (secure OS) during the boot time.
> > > >
> > > > A TEE device driver can claim the RPMB interface, for example, via
> > > > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB drive=
r
> > > > provides a callback to route RPMB frames to the RPMB device accessi=
ble
> > > > via rpmb_route_frames().
> > > >
> > > > The detailed operation of implementing the access is left to the TE=
E
> > > > device driver itself.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  MAINTAINERS              |   7 ++
> > > >  drivers/misc/Kconfig     |  10 ++
> > > >  drivers/misc/Makefile    |   1 +
> > > >  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> > > >  5 files changed, 387 insertions(+)
> > > >  create mode 100644 drivers/misc/rpmb-core.c
> > > >  create mode 100644 include/linux/rpmb.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 8999497011a2..e83152c42499 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> > > >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-=
de2-rotate.yaml
> > > >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> > > >
> > > > +RPMB SUBSYSTEM
> > > > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > > > +L:   linux-kernel@vger.kernel.org
> > > > +S:   Supported
> > > > +F:   drivers/misc/rpmb-core.c
> > > > +F:   include/linux/rpmb.h
> > > > +
> > > >  RPMSG TTY DRIVER
> > > >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > > >  L:   linux-remoteproc@vger.kernel.org
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -104,6 +104,16 @@ config PHANTOM
> > > >         If you choose to build module, its name will be phantom. If=
 unsure,
> > > >         say N here.
> > > >
> > > > +config RPMB
> > > > +     tristate "RPMB partition interface"
> > > > +     depends on MMC
> > > > +     help
> > > > +       Unified RPMB unit interface for RPMB capable devices such a=
s eMMC and
> > > > +       UFS. Provides interface for in-kernel security controllers =
to access
> > > > +       RPMB unit.
> > > > +
> > > > +       If unsure, select N.
> > > > +
> > > >  config TIFM_CORE
> > > >       tristate "TI Flash Media interface support"
> > > >       depends on PCI
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > index ea6ea5bbbc9c..8af058ad1df4 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         +=3D lkdtm/
> > > >  obj-$(CONFIG_TIFM_CORE)              +=3D tifm_core.o
> > > >  obj-$(CONFIG_TIFM_7XX1)              +=3D tifm_7xx1.o
> > > >  obj-$(CONFIG_PHANTOM)                +=3D phantom.o
> > > > +obj-$(CONFIG_RPMB)           +=3D rpmb-core.o
> > > >  obj-$(CONFIG_QCOM_COINCELL)  +=3D qcom-coincell.o
> > > >  obj-$(CONFIG_QCOM_FASTRPC)   +=3D fastrpc.o
> > > >  obj-$(CONFIG_SENSORS_BH1770) +=3D bh1770glc.o
> > > > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > > > new file mode 100644
> > > > index 000000000000..e42a45debc76
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rpmb-core.c
> > > > @@ -0,0 +1,233 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved=
.
> > > > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > > > + */
> > > > +#include <linux/device.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/rpmb.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +static struct list_head rpmb_dev_list;
> > > > +static DEFINE_MUTEX(rpmb_mutex);
> > > > +static struct blocking_notifier_head rpmb_interface =3D
> > > > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > > > +
> > > > +/**
> > > > + * rpmb_dev_get() - increase rpmb device ref counter
> > > > + * @rdev: rpmb device
> > > > + */
> > > > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > > > +{
> > > > +     if (rdev)
> > > > +             get_device(rdev->parent_dev);
> > >
> > > Odd, why are you thinking the parent reference has anything to do wit=
h
> > > this device's reference?
> > >
> > > Why isn't this a "real" device and part of the driver model properly?
> > > This way of "hanging onto" a device and attempting to influence it's
> > > reference count is odd, please make this real and not "fake".
> >
> > I did this in response to
> > https://lore.kernel.org/lkml/CAPDyKFqNhGWKm=3D+7niNsjXOjEJE3U=3Do7dRNG=
=3DJqpptUSo9G-ug@mail.gmail.com/
>
> And I would argue, "Yes, we do need yet-another class and sysfs entry".
>
> This is a "device" that a driver controls, it is NOT the parent device,
> it is a class device, so as such, make it one.  That's what the driver
> model is for.  Trying to avoid it causes problems.
>
> > Perhaps "parent_dev" isn't the best name. The struct rpmb_dev can be
> > seen as another representation of the underlying device.
>
> I.e. a class device.  So use that :)

I see your point.

>
> > The life
> > cycle of struct rpmb_dev is tied to the underlying device with
> > rpmb_dev_register() and rpmb_dev_unregister(). Just as
> > rpmb_route_frames() forwards the frames to the device, rpmb_dev_{get,
> > put}() does the corresponding thing.
>
> You should never be modifying the reference count of a device you really
> do not control, unless you are trying to make sure it is present to use
> it yourself.
>
> > > Bonus, you get that notifier callback "for free" if you do that.  But
> > > really, notifier callbacks are a pain, are you sure you want that?
> >
> > Yes, they are needed because the device may show up late and the
> > OP-TEE driver doesn't know if any device will show up. As Ulf pointed
> > out in the link above, at this point, there's no need to tell user
> > space about this kernel internal abstraction.
>
> If this is a representation of how the device is interacted with, then
> yes, you do need to represent that.

Thanks for straightening out this. I'll bring back the class device in
the next version

Cheers,
Jens

