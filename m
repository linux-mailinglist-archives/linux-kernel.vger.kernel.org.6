Return-Path: <linux-kernel+bounces-183530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A928C9A47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F211F212E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A071CA87;
	Mon, 20 May 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="QWQvGOym"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E23224EF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197082; cv=none; b=EeZ/pmby5puBd/ZzB1h4S4sH5Mrv2SuRjx39trt83timG63Fpcvj1woxQHA8ZnL3Zh3zk+68ut9hr69l5A3NBCg8JxgD+xvtBYxUhayXljFFRMBP5XTrIFlfa7Q2z7JyUQCetTxmDpfQipmNUKjj7pdCj7QX7EtqrSGYeHehnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197082; c=relaxed/simple;
	bh=Kklz+ktfWuEykTJ9eoIRUAH9YHToANc5MjGu7MgR/Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t72KzIkH9214S4AuxLpKlvNbZKxfupbCCW+vUd7P4VC9YnWDP8blkUy7knI5F3Wop3ivGocOKXWUMPoxU7RQZ9yfVr051ErrXAaQhtdSg0OWfx05RbUhlVpDAhkH3fZltFQaHwojuji6uXdmcQ2p3xCoRRpRaWBWNmCuGWqNO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=QWQvGOym; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6203f553e5fso21906527b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716197079; x=1716801879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTP4n3yhXyuKsvb8V/x0lwx2q2Y2QVn77xnb/moq0rY=;
        b=QWQvGOymw1sheGJuBHM3OYWQefvLW4graSAUnJi6Ds97fQn0NXAzT5EsxRb+qurOl7
         iohrMmoROWBDxPsnlKFnCxu7W17bXNuvQfBjaq+7PW25LMvLyDFmdGzL5J5QTAJ7mCYf
         F4SjjOrHXyYkdK9SppmqCpiKQNFgrDnVvvsRPAkwJ5E6g75s6Dv21ZRnd8L1mufIU0Wm
         71947uBf7NThiiyUENRWaVJ7AvLqc6ImuI49voqiAVuGhSmg1DTb9KEZvHMPKuiY3cxX
         7jJrmUG28xhKvNDOxsVczziBhVtkS5DlWtZKf/31JgbWO46SsHT0xK/fnAI73ARqItiR
         Pg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197079; x=1716801879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTP4n3yhXyuKsvb8V/x0lwx2q2Y2QVn77xnb/moq0rY=;
        b=R36IOR4wB/0Kalorb7FFpK9fh+iaw/+peZ7izgK3V8f728s4utP7uZ2FHpp6TkdJM9
         rmrsIzMxHbDSmBNTUQSmgIm9Mn3midJrS/KQggcsSw95Tj45ommZnvMKFUgLKnlr1Ryv
         KKkKKMJJ+JMsu1aaSCg6f96yBf7wL1i45KhPobszMnkx97S2f9d6xfL56+wQOlr4pGsP
         gfqi1GJgms26n9I10qsfURZu+mIjpmjkCz+eNmy2Xd2NEck5hQjlL7Ke/r/c7lMPuY0H
         fDE1gU2PbujOPlNIynw4bwrRMdfvnGwVKi+Wfzf4ZDxtzUEjYmRIlcNIu2PHrA05uBeG
         TJfQ==
X-Gm-Message-State: AOJu0Yy7SJ5jOJL25Qqm6sM9MM1mqQ7dIrQ5Y5IO3QdnEuK9RTfGejHT
	8JqOQAXY1jAVUuICsQWS0yBLyYB/oBxXpqZcukmZ0zSqQ8+N83rDE+v9mag457sln/Z2AApJA2H
	yhrg=
X-Google-Smtp-Source: AGHT+IE3+Bwy1rTW6LZBfxg21C3r33Glem2ZA5GLigMTgswBwDtpNI5ENvAnFkSHCBrmYUtqEjY+bg==
X-Received: by 2002:a05:690c:6c87:b0:615:9a1:602b with SMTP id 00721157ae682-622b00134e3mr281913707b3.44.1716197078867;
        Mon, 20 May 2024 02:24:38 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2592c2sm47692367b3.43.2024.05.20.02.24.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 02:24:38 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso1990846276.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:24:37 -0700 (PDT)
X-Received: by 2002:a25:84c4:0:b0:df3:88ee:799c with SMTP id
 3f1490d57ef6-df388ee85a4mr13302743276.7.1716197077534; Mon, 20 May 2024
 02:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net> <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
In-Reply-To: <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 20 May 2024 11:24:26 +0200
X-Gmail-Original-Message-ID: <CAAObsKDFDNV48XF1DobvVv04Q+DfBY=weBJPKbBewJPbPibRVA@mail.gmail.com>
Message-ID: <CAAObsKDFDNV48XF1DobvVv04Q+DfBY=weBJPKbBewJPbPibRVA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:34=E2=80=AFAM Lucas Stach <l.stach@pengutronix.d=
e> wrote:
>
> Hi Tomeu,
>
> Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> > If we expose a render node for NPUs without rendering capabilities, the
> > userspace stack will offer it to compositors and applications for
> > rendering, which of course won't work.
> >
> > Userspace is probably right in not questioning whether a render node
> > might not be capable of supporting rendering, so change it in the kerne=
l
> > instead by exposing a /dev/accel node.
> >
> > Before we bring the device up we don't know whether it is capable of
> > rendering or not (depends on the features of its blocks), so first try
> > to probe a rendering node, and if we find out that there is no renderin=
g
> > hardware, abort and retry with an accel node.
> >
> I thought about this for a while. My opinion is that this is the wrong
> approach. We are adding another path to the kernel driver, potentially
> complicating the userspace side, as now the NPU backend needs to look
> for both render and accel nodes.

Forgot to mention in my earlier reply today that with the proposed
solution no changes are needed in the Gallium drivers, only in the
pipeloader component in Mesa, and in the Gallium frontends.

But those changes are needed anyway to support the upcoming
compute-only NPUs, such as Rockchip's.

These are the changes I needed to make to the userspace to go with
this kernel patch:

https://gitlab.freedesktop.org/tomeu/mesa/-/commit/6b0db4cce406c574d2b77102=
08df9c8bd1ab6345

Cheers,

Tomeu

> While currently accel and drm are
> pretty closely related and we can share most of the driver, it might
> still be a maintenance hassle in the long run.
>
> On the other hand we already have precedence of compute only DRM
> devices exposing a render node: there are AMD GPUs that don't expose a
> graphics queue and are thus not able to actually render graphics. Mesa
> already handles this in part via the PIPE_CAP_GRAPHICS and I think we
> should simply extend this to not offer a EGL display on screens without
> that capability.
>
> Regards,
> Lucas
>
> > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > Cc: Oded Gabbay <ogabbay@kernel.org>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 46 ++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/et=
naviv/etnaviv_drv.c
> > index 6500f3999c5f..8e7dd23115f4 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/uaccess.h>
> >
> > +#include <drm/drm_accel.h>
> >  #include <drm/drm_debugfs.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_file.h>
> > @@ -488,10 +489,10 @@ static const struct drm_ioctl_desc etnaviv_ioctls=
[] =3D {
> >       ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
> >  };
> >
> > -DEFINE_DRM_GEM_FOPS(fops);
> > +DEFINE_DRM_GEM_FOPS(render_fops);
> > +DEFINE_DRM_ACCEL_FOPS(accel_fops);
> >
> > -static const struct drm_driver etnaviv_drm_driver =3D {
> > -     .driver_features    =3D DRIVER_GEM | DRIVER_RENDER,
> > +static struct drm_driver etnaviv_drm_driver =3D {
> >       .open               =3D etnaviv_open,
> >       .postclose           =3D etnaviv_postclose,
> >       .gem_prime_import_sg_table =3D etnaviv_gem_prime_import_sg_table,
> > @@ -500,7 +501,6 @@ static const struct drm_driver etnaviv_drm_driver =
=3D {
> >  #endif
> >       .ioctls             =3D etnaviv_ioctls,
> >       .num_ioctls         =3D DRM_ETNAVIV_NUM_IOCTLS,
> > -     .fops               =3D &fops,
> >       .name               =3D "etnaviv",
> >       .desc               =3D "etnaviv DRM",
> >       .date               =3D "20151214",
> > @@ -508,15 +508,20 @@ static const struct drm_driver etnaviv_drm_driver=
 =3D {
> >       .minor              =3D 4,
> >  };
> >
> > -/*
> > - * Platform driver:
> > - */
> > -static int etnaviv_bind(struct device *dev)
> > +static int etnaviv_bind_with_type(struct device *dev, u32 type)
> >  {
> >       struct etnaviv_drm_private *priv;
> >       struct drm_device *drm;
> > +     bool is_compute_only =3D true;
> >       int ret;
> >
> > +     etnaviv_drm_driver.driver_features =3D DRIVER_GEM | type;
> > +
> > +     if (type =3D=3D DRIVER_RENDER)
> > +             etnaviv_drm_driver.fops =3D &render_fops;
> > +     else
> > +             etnaviv_drm_driver.fops =3D &accel_fops;
> > +
> >       drm =3D drm_dev_alloc(&etnaviv_drm_driver, dev);
> >       if (IS_ERR(drm))
> >               return PTR_ERR(drm);
> > @@ -553,6 +558,18 @@ static int etnaviv_bind(struct device *dev)
> >
> >       load_gpu(drm);
> >
> > +     for (unsigned int i =3D 0; i < ETNA_MAX_PIPES; i++) {
> > +             struct etnaviv_gpu *g =3D priv->gpu[i];
> > +
> > +             if (g && (g->identity.minor_features8 & chipMinorFeatures=
8_COMPUTE_ONLY) =3D=3D 0)
> > +                     is_compute_only =3D false;
> > +     }
> > +
> > +     if (type =3D=3D DRIVER_RENDER && is_compute_only) {
> > +             ret =3D -EINVAL;
> > +             goto out_unbind;
> > +     }
> > +
> >       ret =3D drm_dev_register(drm, 0);
> >       if (ret)
> >               goto out_unbind;
> > @@ -571,6 +588,19 @@ static int etnaviv_bind(struct device *dev)
> >       return ret;
> >  }
> >
> > +/*
> > + * Platform driver:
> > + */
> > +static int etnaviv_bind(struct device *dev)
> > +{
> > +     int ret =3D etnaviv_bind_with_type(dev, DRIVER_RENDER);
> > +
> > +     if (ret =3D=3D -EINVAL)
> > +             return etnaviv_bind_with_type(dev, DRIVER_COMPUTE_ACCEL);
> > +
> > +     return ret;
> > +}
> > +
> >  static void etnaviv_unbind(struct device *dev)
> >  {
> >       struct drm_device *drm =3D dev_get_drvdata(dev);
>

