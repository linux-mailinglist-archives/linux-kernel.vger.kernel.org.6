Return-Path: <linux-kernel+bounces-523501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3DCA3D7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880013B9A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276521F151E;
	Thu, 20 Feb 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+v0SVip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB41F1527
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049155; cv=none; b=gXZmp8wKrgKTgZQOoeQE9ogcZQXWYZrN5BRBb6CW/xfBibYkPM06M2yB5Meag8EDzsMoyeP11sV4taJykYzyIyMIehulzHh/kmlfY6MuGg6Su7wg8o/g2FmyN61s6jOgUqcsbAQ94Fa3MvkKPvZMIkSh9G5jNfV2tTCalWeLTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049155; c=relaxed/simple;
	bh=SC0EXh8iaTliM0LEU5Zr21k4rRx7S164le5NgnscGH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X72ndrxI9Od0adlLthVmtnC8VP1QT6Mfvn8gALS2b+WfOd/EBUnMVCQ0FMJh5VBVtaKyj/QpqB8Y2o/BFYkZ92lLTxcFqB7MH71aQxheNC2bC7dEYEk+h+wx550rEk55OxcgRZJO3f+hBYsN59EikP+LtLijrbgFYJw8XAhf2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+v0SVip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F20C4CEE3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049154;
	bh=SC0EXh8iaTliM0LEU5Zr21k4rRx7S164le5NgnscGH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+v0SVipN9PC3SR1nkqUAfFSfiGNJ3xJ+JXIfXrPfKomUu4f6KODgcsLrrbj6dmLg
	 eDSZQM+rel4CwP8kXeNBuy3OzYV54ySrYwCHxU4yUq+C4NL2vNPlz2HSBN4UmrsnMc
	 xoAO1S94g6BTUD+FQw7EhJSPABmVrxEvYcraG0wG222eYXLPX9QhWf33jF/CiGhXXH
	 fVhpNlfV4v0gYkiJak76u5OFTbJxD1JpZZoP/pkQt1fdfcxVyTNqdVjSV83mQUHarC
	 sh8cDx4fiCZefalQiF8PgZ8zfttguDKD2FvE+7Rpnq6a0OW8k0ulTB7OOxwUXJvoVL
	 dS9TpeIEOtxtg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f40ad1574fso538055b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:59:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdGUpBYHhnQYmu50VKVBsyLWr3V95gBXjdm3RXA6/YkJ/4O7o9EGvwmFqKX4pDvO9+/03dExSUD+/XUO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DCY21hbSBkkKe5dL9EaaFPHhXLAcWQrQPIDTuEFf4KmeY+a4
	VSla6z2kXh4Ukhw0QIzgJgGLnAYbHy8obCCFE15bBG5gUPn6resKI0opcAe3bEjmeNYq8e6PUw4
	9D1upWLqXjRhvstbmmHl7hogS0N0=
X-Google-Smtp-Source: AGHT+IGGFJswTW6F02DODxnhumJFxu61dR3VJAoHNC2qEKrPIeEWvee1M1Hft3So8uJq2kOyohBAMzlh1yFIcmrhU5U=
X-Received: by 2002:a05:6808:21a7:b0:3f3:ae8c:c926 with SMTP id
 5614622812f47-3f40f2325b3mr5983037b6e.29.1740049154065; Thu, 20 Feb 2025
 02:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com> <20250220064647.2437048-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20250220064647.2437048-2-dmitry.torokhov@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 11:59:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0geh6yAfOgo+ayvXaTTpq=ubQkM-qU22ETB6b24EOULLg@mail.gmail.com>
X-Gm-Features: AWEUYZk54nGsVh2ONXhEN1H5e0UZoK_-HtpTjsy2u3FhugEnCrif7HQ1D1mW_GQ
Message-ID: <CAJZ5v0geh6yAfOgo+ayvXaTTpq=ubQkM-qU22ETB6b24EOULLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: fix potential NULL pointer dereference
 in dev_uevent()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:47=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> If userspace reads "uevent" device attribute at the same time as another
> threads unbinds the device from its driver, change to dev->driver from a
> valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
> when fetching the pointer, and take bus' drivers klist lock to make sure
> driver instance will not disappear while we access it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/base.h |  1 +
>  drivers/base/bus.c  |  2 +-
>  drivers/base/core.c | 32 ++++++++++++++++++++++++++++++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 8cf04a557bdb..91b786891209 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp=
)
>                 kset_put(&sp->subsys);
>  }
>
> +struct subsys_private *bus_to_subsys(const struct bus_type *bus);
>  struct subsys_private *class_to_subsys(const struct class *class);
>
>  struct driver_private {
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 6b9e65a42cd2..c8c7e0804024 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struc=
t device *dev,
>   * NULL.  A call to subsys_put() must be done when finished with the poi=
nter in
>   * order for it to be properly freed.
>   */
> -static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
> +struct subsys_private *bus_to_subsys(const struct bus_type *bus)
>  {
>         struct subsys_private *sp =3D NULL;
>         struct kobject *kobj;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 9f4d4868e3b4..670f77b9b378 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2623,6 +2623,34 @@ static const char *dev_uevent_name(const struct ko=
bject *kobj)
>         return NULL;
>  }
>
> +/*
> + * Try filling "DRIVER=3D<name>" uevent variable for a device. Because t=
his
> + * function may race with binding and unbinding device from a driver we =
need to
> + * be careful. Binding is generally safe, at worst we miss the fact that=
 device
> + * is already bound to a driver (but the driver information that is deli=
vered
> + * through uevents is best-effort, it may become obsolete as soon as it =
is
> + * generated anyways). Unbinding is more risky as driver transitioning t=
o NULL,
> + * so READ_ONCE() should be used to make sure we are dealing with the sa=
me
> + * pointer, and to ensure that driver structure is not going to disappea=
r from
> + * under us we take bus' drivers klist lock. The assumption that only re=
gistered
> + * driver can be bound to a device, and to unregister a driver bus code =
will
> + * take the same lock.
> + */
> +static void dev_driver_uevent(const struct device *dev, struct kobj_ueve=
nt_env *env)
> +{
> +       struct subsys_private *sp =3D bus_to_subsys(dev->bus);
> +
> +       if (sp) {
> +               scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
> +                       struct device_driver *drv =3D READ_ONCE(dev->driv=
er);

I think you need to use a matching WRITE_ONCE() on the update side
because you don't want to READ_ONCE() a partially updated memory
location.

> +                       if (drv)
> +                               add_uevent_var(env, "DRIVER=3D%s", drv->n=
ame);
> +               }
> +
> +               subsys_put(sp);
> +       }
> +}
> +
>  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env=
 *env)
>  {
>         const struct device *dev =3D kobj_to_dev(kobj);
> @@ -2654,8 +2682,8 @@ static int dev_uevent(const struct kobject *kobj, s=
truct kobj_uevent_env *env)
>         if (dev->type && dev->type->name)
>                 add_uevent_var(env, "DEVTYPE=3D%s", dev->type->name);
>
> -       if (dev->driver)
> -               add_uevent_var(env, "DRIVER=3D%s", dev->driver->name);
> +       /* Add "DRIVER=3D%s" variable if the device is bound to a driver =
*/
> +       dev_driver_uevent(dev, env);
>
>         /* Add common DT information about the device */
>         of_device_uevent(dev, env);
> --

