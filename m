Return-Path: <linux-kernel+bounces-394909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D89BB5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D381C20AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6288225A8;
	Mon,  4 Nov 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAPn/AMb"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4151F942
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726515; cv=none; b=Zeyv0DQ9SlFXbLM9Zof3KLlGAU9IvGROgJUeZZyZJaRWpF0SBKwG9pjoVGOj/zV6P1JMugvzOYG51oXo/VdH7PYRm3q9ZbQhpBDaa+dJr7SfYhha4gWWvj23yemjtnn0S18yothe6IKCdUuRK/r7+gQGUeo4DtFUcDznlI//18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726515; c=relaxed/simple;
	bh=IN3xdBm2Er4x/TlT931lq5tkhXG25PEhTOBwM1GBv38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRzE3C+4cPnC/FSnQ4P5U2dYIYPhjGaikIbIdotxh84XTF7OUtUCh+z1EbdYUqr8gkpGE5Xr3nXQriCSavIlOr2IVebSW7YNcUrJIWLtqZ3JQygBr4qfNxqoTIUFWJi6OQUEzi9xbuAo1ar22gRdneDDZjBxDKips5RpxvGqvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAPn/AMb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so2931301a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730726514; x=1731331314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fwlr0AaF9wjPiXZcT4v/0uyS6FKcGIJwRpciZvewDA=;
        b=HAPn/AMb41R+d+RfNYCw2kSsJLqfaQB7Gyr2LVxgpBfpFJqiRQLhAEOP/oi7tKLE1f
         3CVT+IZ8ocPlJE6MtjkX9a3hn/4dngegcO6ZH9iY2mCxGah4GJTYCqmrPRO2905j0Mfh
         7g7YpWu2kLjGwnUsNuyF2UoYaWjurcVlOSeesRAsVpUST/tgpmgFsD7CDDdL4c2RiJjM
         DR0GVkR7pu5IUBbatDI9M6RtnLtTMRkdULBTK/NF7ZslBbqvqv5D5O6QRhjl/P3wyzcj
         XsE+zrJKh80ZQk0FeR+hTQuQdoal+6BNrcEIPWY6OROeUkPxiii+ioLL1UnPJwocOWlR
         3IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726514; x=1731331314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Fwlr0AaF9wjPiXZcT4v/0uyS6FKcGIJwRpciZvewDA=;
        b=Gz9O3sfv9+KEuDFv1ZQBbyQqpppKuW+iCObXHf2e896FG0H+pMu2Ggr/YApQneKCr8
         8Vg0YB0PPwUFVBTuRRAITLpHKgZZnGB+/KeN2b8jQutITnPnFAp0AAQtgF7IU8Obg3X1
         G/utK1cbakHJmtPcneLvhALwwlUnF5SjO86uPi89N2g5mOFOg6hZVJ5/4LQOoJEgB9VQ
         OHuVFA+IWg2qrUNztafUKo5soXI1fbDW6njqQdjIodynA+J+RN2ctBVdTla1bzqkzMie
         dnFDDgLKTsGL4RBAtHt9KNtQnmm2q0Syx0p5ua7ftmFI9ZW1tU16IrrvD9HJf2CG55cl
         PvPA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0hs8qUPzT2ymkNnRsSBG0oYFaU+zfE5MWSeFzrNd9qvVUwRTA26pPvFqd0utYSxXbBs2xOZVkyvG7w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5Aklb8zW1RSHb/U6N5YGuvWTCbVOUj37Mda2xd2ThJME65Ra
	Du6b4C0ql2pth/YByR0p2MD9hKGIMEejZctfIhxGFJhY8cu1wMEFJGt7tjiiAOlf0jr8ksDEqVM
	El/C0J6jqMYSPz3WO2qqaHc4RHKo=
X-Google-Smtp-Source: AGHT+IHZjkq3Ie2iIyfuGufHHiIKI5Xxv0rEb6DJ4QCDY+AvB4y4PBqvaVcW2foSo8pwydHzUkD95Y0rng/FXH8j0iw=
X-Received: by 2002:a17:90b:278c:b0:2e3:bc3e:feef with SMTP id
 98e67ed59e1d1-2e93e0589dcmr22420715a91.3.1730726513505; Mon, 04 Nov 2024
 05:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031205140.541907-1-christian.gmeiner@gmail.com> <4c3eeaf2-218a-451b-aa51-f0e9f4bef0d6@igalia.com>
In-Reply-To: <4c3eeaf2-218a-451b-aa51-f0e9f4bef0d6@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 4 Nov 2024 14:21:42 +0100
Message-ID: <CAH9NwWcehP+9bekxMoxF3QdO_7j5zwNLuCmHNvd-JCCV_x85jA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel-dev@igalia.com, 
	Christian Gmeiner <cgmeiner@igalia.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ma=C3=ADra,

>
> Thanks for your patch! Just some small nits.
>

Thanks for your review.

> On 31/10/24 17:51, Christian Gmeiner wrote:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
> > configuration of a global performance monitor (perfmon).
> > Use the global perfmon for all jobs to ensure consistent
> > performance tracking across submissions.
>
> I'd mention how this feature can be useful for user-space (for example,
> the implementation of a Perfetto datasource).
>

That's a great idea .. will be done in V3.

> >
> > Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > ---
> > Changes in v2:
> > - Reworked commit message.
> > - Removed num_perfmon counter for tracking perfmon allocations.
> > - Allowing allocation of perfmons when the global perfmon is active.
> > - Return -EAGAIN for submissions with a per job perfmon if the global p=
erfmon is active.
> > ---
> >   drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
> >   drivers/gpu/drm/v3d/v3d_drv.h     |  8 ++++++++
> >   drivers/gpu/drm/v3d/v3d_perfmon.c | 34 ++++++++++++++++++++++++++++++=
+
> >   drivers/gpu/drm/v3d/v3d_sched.c   | 14 ++++++++++---
> >   drivers/gpu/drm/v3d/v3d_submit.c  | 10 +++++++++
> >   include/uapi/drm/v3d_drm.h        | 15 ++++++++++++++
> >   6 files changed, 79 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_dr=
v.c
> > index d7ff1f5fa481..3c89f0daa5b8 100644
> > --- a/drivers/gpu/drm/v3d/v3d_drv.c
> > +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> > @@ -214,6 +214,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[]=
 =3D {
> >       DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_VALUES, v3d_perfmon_get_values_=
ioctl, DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDE=
R_ALLOW | DRM_AUTH),
> >       DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counte=
r_ioctl, DRM_RENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_=
ioctl, DRM_RENDER_ALLOW),
> >   };
> >
> >   static const struct drm_driver v3d_drm_driver =3D {
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_dr=
v.h
> > index cf4b23369dc4..a0d920ec2b1d 100644
> > --- a/drivers/gpu/drm/v3d/v3d_drv.h
> > +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> > @@ -179,6 +179,12 @@ struct v3d_dev {
> >               u32 num_allocated;
> >               u32 pages_allocated;
> >       } bo_stats;
> > +
> > +     /* To support a performance analysis tool in user space, we requi=
re
> > +      * a single, globally configured performance monitor (perfmon) fo=
r
> > +      * all jobs.
> > +      */
> > +     struct v3d_perfmon *global_perfmon;
> >   };
> >
> >   static inline struct v3d_dev *
> > @@ -584,6 +590,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device =
*dev, void *data,
> >                                struct drm_file *file_priv);
> >   int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
> >                                 struct drm_file *file_priv);
> > +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> > +                              struct drm_file *file_priv);
> >
> >   /* v3d_sysfs.c */
> >   int v3d_sysfs_init(struct device *dev);
> > diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3=
d_perfmon.c
> > index 156be13ab2ef..bf42303c292b 100644
> > --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> > +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> > @@ -312,6 +312,9 @@ static int v3d_perfmon_idr_del(int id, void *elem, =
void *data)
> >       if (perfmon =3D=3D v3d->active_perfmon)
> >               v3d_perfmon_stop(v3d, perfmon, false);
> >
> > +     /* If the global perfmon is being destroyed, set it to NULL */
> > +     cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> > +
> >       v3d_perfmon_put(perfmon);
> >
> >       return 0;
> > @@ -451,3 +454,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_devic=
e *dev, void *data,
> >
> >       return 0;
> >   }
>
> [...]
>
> > index 87fc5bb0a61e..709724fe28e6 100644
> > --- a/include/uapi/drm/v3d_drm.h
> > +++ b/include/uapi/drm/v3d_drm.h
> > @@ -43,6 +43,7 @@ extern "C" {
> >   #define DRM_V3D_PERFMON_GET_VALUES                0x0a
> >   #define DRM_V3D_SUBMIT_CPU                        0x0b
> >   #define DRM_V3D_PERFMON_GET_COUNTER               0x0c
> > +#define DRM_V3D_PERFMON_SET_GLOBAL                0x0d
> >
> >   #define DRM_IOCTL_V3D_SUBMIT_CL           DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_V3D_SUBMIT_CL, struct drm_v3d_submit_cl)
> >   #define DRM_IOCTL_V3D_WAIT_BO             DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_V3D_WAIT_BO, struct drm_v3d_wait_bo)
> > @@ -61,6 +62,8 @@ extern "C" {
> >   #define DRM_IOCTL_V3D_SUBMIT_CPU          DRM_IOW(DRM_COMMAND_BASE + =
DRM_V3D_SUBMIT_CPU, struct drm_v3d_submit_cpu)
> >   #define DRM_IOCTL_V3D_PERFMON_GET_COUNTER DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_V3D_PERFMON_GET_COUNTER, \
> >                                                  struct drm_v3d_perfmon=
_get_counter)
> > +#define DRM_IOCTL_V3D_PERFMON_SET_GLOBAL  DRM_IOW(DRM_COMMAND_BASE + D=
RM_V3D_PERFMON_SET_GLOBAL, \
> > +                                                struct drm_v3d_perfmon=
_set_global)
> >
> >   #define DRM_V3D_SUBMIT_CL_FLUSH_CACHE             0x01
> >   #define DRM_V3D_SUBMIT_EXTENSION              0x02
> > @@ -765,6 +768,18 @@ struct drm_v3d_perfmon_get_counter {
> >       __u8 reserved[7];
> >   };
> >
> > +#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
> > +
> > +/*
>
> Please, use kernel-doc [1]. So, here is /**
>
> [1] https://docs.kernel.org/doc-guide/kernel-doc.html
>
> > + * struct drm_v3d_perfmon_set_global - ioctl to define a
>
> The colunm width is 80.
>
> > + * global performance counter that is used if a job has
>
> s/counter/monitor
>
> > + * not assigned one on its own.
>
> This description isn't really precise. When the global performance
> monitor is enabled, the job perfmon doesn't matter. Currently, we don't
> even allow a job perfmon to be submitted, but if we did, the global
> perfmon would be used even if the job had a perfmon.
>

I have rephrased this comment and should be more precise now.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

