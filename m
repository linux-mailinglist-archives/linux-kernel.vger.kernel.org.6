Return-Path: <linux-kernel+bounces-183467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54988C996B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF3C1C2122C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810B1B947;
	Mon, 20 May 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="VUq7uEZV"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05C12B8B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190774; cv=none; b=dD2iDotccLBpzfe/i0jw/VjFfOJ4k3Nn6j4MBpU8yPm7g/HjgzMtCQN0W7YXBd3Ro5+NZqjH+F8UVzVDxEUzWvMszUxQCGpC2pa4AipB/DiC6xvi7iNXmm9GglOyjpYpNeA8o4qY7RFlyB5NyMYh8rDytt+fkx2eX6+J0Oip6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190774; c=relaxed/simple;
	bh=WRqNQmkeBXWEg2UTCKs1N47PBMF2gpbISiVst4YMDU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WD+7ythXHnYTujmppN3QffZlKDTbrVXT3BiHhKh2K/jH1NOgeG+Dhxq+b1oxNQEetDQxxgYITDLCQYkPQtZmy8hRfPG/NbeB9cWDYdjttx0Z4q38Ql2EDxB8NTkdOS8WeVdEne3vgtpRaT8P+wMpizZNg2lZW7mnv+VlbFTp8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=VUq7uEZV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61ae4743d36so21028397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716190770; x=1716795570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow9jbuVKIW09zvKzQpjf809fGluRD4ku6Wkb2RBqfMs=;
        b=VUq7uEZVbmeaKatkIZrEcvMXoHYSP9eoa52Q3br/CnAsX+PRqpr3BvA90EQdHzKEd1
         v+2aNv4lrhZJ8ouhYbUGTTBOaRIUcPaE0F9b+4zCUGdDA2/OtNFyz4RCqtfd8WT1WHCC
         /1wlG0pVvx7dXKN9wKdqSveMeqrpdI3v5BRdsrPxwdkwuoe68qseThq8lhtynNmA3gLi
         Y3ky3T6Htf7dgLxQMzrvr2aJJIaNWMl397vZYdRcSbeHjoneHgNa5tQLrHaYqoRGnPDw
         RqldVJ/k6Cowqjq8kEv9e/KrYWsXyIByOLYlloOkdvHfppw68eN2Elv5OD8YJyAhhm2q
         vsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190770; x=1716795570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow9jbuVKIW09zvKzQpjf809fGluRD4ku6Wkb2RBqfMs=;
        b=hTHt7y82LXOjvRjewgx6tzD4DFEKSpOtJHy1rjbejIaQQWEjv361ouxWC3MxaLGSpR
         e0RDPum5LHyG2j4hTmWgEhLuGUJACo0oFyuPkHL9KgsFwM0vNSYyOWoQjwNFBo35Q7xh
         frDtIAlzY0nSpCh2ZDfZsTXiGRVkqQtEsWp6PsqKS2rxf8dC7OCEIwFyfJlO/J15Pmdo
         0OGmocfvFhJp8cuWT/YD1RCXVszfr8WgrlECWUamYPk84p+X2dPH8naImeJNl5H7d7ae
         rp4k/3utraGqMJTOiAJdfowBcqcWX4Jk1bQeiCoXFE5uPeUoHs2lqAgs2FwVrb24PPe3
         L2gQ==
X-Gm-Message-State: AOJu0YzcGPbrCaP0ZJn27IDw6oT65lodvlXSnYzf48ETRMtkvAg5dcyj
	0ysYI+cqdduJ57D2a+oQJS21+9C7uq1rs8tiYyMWOIFO9jr4gHaHVBOWAbsY4M9d6Fj2a7957q5
	z6pE=
X-Google-Smtp-Source: AGHT+IGlvR1qYI7pBJLxlhhwcQ4XDl0RTF0wB3i5yGS9/n74Xe7qd8A+hOcYfpXHQs8KfpBGKkV/7g==
X-Received: by 2002:a25:9b86:0:b0:de0:de50:d6d4 with SMTP id 3f1490d57ef6-dee4f1831f5mr24942813276.8.1716190769989;
        Mon, 20 May 2024 00:39:29 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd38293bfsm4798754276.52.2024.05.20.00.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 00:39:29 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dee9943a293so2071313276.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:39:29 -0700 (PDT)
X-Received: by 2002:a5b:7c6:0:b0:df4:969f:3dcd with SMTP id
 3f1490d57ef6-df4969f3f35mr3728366276.50.1716190768803; Mon, 20 May 2024
 00:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net> <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
In-Reply-To: <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 20 May 2024 09:39:17 +0200
X-Gmail-Original-Message-ID: <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
Message-ID: <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>, 
	Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

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
> for both render and accel nodes. While currently accel and drm are
> pretty closely related and we can share most of the driver, it might
> still be a maintenance hassle in the long run.
>
> On the other hand we already have precedence of compute only DRM
> devices exposing a render node: there are AMD GPUs that don't expose a
> graphics queue and are thus not able to actually render graphics. Mesa
> already handles this in part via the PIPE_CAP_GRAPHICS and I think we
> should simply extend this to not offer a EGL display on screens without
> that capability.

The problem with this is that the compositors I know don't loop over
/dev/dri files, trying to create EGL screens and moving to the next
one until they find one that works.

They take the first render node (unless a specific one has been
configured), and assumes it will be able to render with it.

To me it seems as if userspace expects that /dev/dri/renderD* devices
can be used for rendering and by breaking this assumption we would be
breaking existing software.

Which is what I understood to be the whole point behind the decision
to create a new device file hierarchy for accelerators. Or am I
missing something?

Adding Daniel Stone to CC in case he wants to give his opinion from
the compositor point of view.

Cheers,

Tomeu

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

