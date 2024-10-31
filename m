Return-Path: <linux-kernel+bounces-391291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD79B84CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D34281234
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384D1CCB4E;
	Thu, 31 Oct 2024 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMjT0LfM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B31BBBC1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408398; cv=none; b=GYqGOC9Oc0uiQAIULpfCVngpCQESA5tWDMZ45WyBSN61ChWro5y9GQCmj2XX5xdggMuC0EWnt2/opRQSg3eQAhOeAEOvf+SGV+9C7vADfpXGiM75KkKijHbimv3G/Nze5GYlIA+uSkJ1/r0/24TT8Q0hdyGgDNjRpLjGXQPbgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408398; c=relaxed/simple;
	bh=i1gEsVd4qqBrQgYogd2sBLsQPjC49si6pgYU4NXOqug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvSROgKrD0EJQRodeAOmo57QMZVg4e8Q0793S1KTEIVGm+tiJQ4YXuWG2v3WAw/9Vb5DcrvktjfAn06uVmMpOqrvw02s4E8bJH3vGdPJlYsPKCOVPRIHO2y8SSdqVBzYOFjpJg9WR5m4CxTAKaS4bb2U2X7qd78WtgKzft9bJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMjT0LfM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso1040873a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730408392; x=1731013192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGab+KxLHPuFXQ9hG7daF5kjEcZZ8gRZMKHDGf/QQdc=;
        b=YMjT0LfM24JU+hFoUvZU8eqsvv6pPKkkMp+8Az+UMunh90Kb5Uy94I4uCjrrBMarhN
         ZVOOKkMrzzpjt9VzM85CgTup0d9aSWJQAytDTuy2B9A2ihyvyL6Uc6caEt+RrOA3E3Jr
         DsEYLj0KOHEYkmVAVfH4OS8wlAyIkXtRrmwwUGQEBtmQuQhp68CNJT8UtKFNSt7Dntxn
         k+k+0WO6q7RXB3SBC7G7DwYy8iJiyZ3yaiUskbjiurokfKRCFMRB75tl4alxviu14Et5
         eUmtce3c51JCKVtLyYFIcrn9+cKptozkkUVMFLP+2buzOorrSy0nJWq9ADVViJPvDlVr
         2uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408392; x=1731013192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGab+KxLHPuFXQ9hG7daF5kjEcZZ8gRZMKHDGf/QQdc=;
        b=UWIvnurWEcmef4hS4lA0nEOlP321t6bmhACmdokcRoO/8pCNfMbT/SQNtsBD8BLyfw
         kLPPiywq/wWGvZfFTbqLzyBG/44h9wQLuYXN+5ojnJv6PTFPAHQp/7kMTzBqo/SujAGK
         7TCxhihMgZN808S3458JJpxb3FE9MrttRClVP3xl7LW4t7Gs4Pk6FDmOTw2qwNbMSHvO
         tCYISnyPqOOn8ZVS2p3skNu5bMbUsuAny6sqL0UgfpXCGeHVNU0NVjBjAFuK+tQqBfkU
         snJXaX/K1YYC4Ndx7+W6CPWdd0Q9sW1pZpYQ1AwmKiZSjtVZkdB3L1lHPsoa8x1JfYO+
         X9+w==
X-Forwarded-Encrypted: i=1; AJvYcCXX5cbkOAUuTboWl1G4Jm+yHz+jSKLC3STnSR8m0RHlUJyrA/jv2zkcf2pHudh86/Q0XE2KgdH7RPukExY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd05AfdjjmuvzED290Nd2DmdFQpq2FFkzlWTX5zmTB/CNpIii6
	6vhMfxpVIEPG2FnenRvw4VpNWGrDSfGNPKyPZ8K+OY+uyUqud32Safs+zWlK3bvJjhnel+mjxok
	5hAmPS8KH5auyKfAW0gSrKjV0kaY=
X-Google-Smtp-Source: AGHT+IE+jpP0JfCSCbQvbKZeCa03Zlrpa7LsOh+lzNCvcuY1bcZXXG8bDmJYLuycfQgzWZe4txy04PHQL3ByX8zNh18=
X-Received: by 2002:a17:90b:4a42:b0:2e2:e2f8:100 with SMTP id
 98e67ed59e1d1-2e94c531243mr1674463a91.38.1730408391666; Thu, 31 Oct 2024
 13:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020204156.113853-1-christian.gmeiner@gmail.com> <c6899aa3-84cc-4288-866d-533dcb478b4c@igalia.com>
In-Reply-To: <c6899aa3-84cc-4288-866d-533dcb478b4c@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 31 Oct 2024 21:59:39 +0100
Message-ID: <CAH9NwWe7mrcV4RQTiKL+05bqbgVRTO_Nqb0iLhGcCd=6rY2LpA@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: kernel-dev@igalia.com, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Melissa Wen <mwen@igalia.com>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Christian Gmeiner <cgmeiner@igalia.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

>
> Em 20/10/2024 17:41, Christian Gmeiner escreveu:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > This patch adds a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, which
> > allows the configuration of a global performance monitor (perfmon).
> > The global perfmon is used for all jobs, ensuring consistent performanc=
e
> > tracking across submissions.
>
> Usually we write in the imperative form:
>
> Add a new ioctl, ...
>

I switched to imperative from v2.

> >
> > Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> > ---
> >   drivers/gpu/drm/v3d/v3d_drv.c                 |  3 ++
> >   drivers/gpu/drm/v3d/v3d_drv.h                 | 10 ++++
> >   drivers/gpu/drm/v3d/v3d_perfmon.c             | 49 ++++++++++++++++++=
+
> >   .../gpu/drm/v3d/v3d_performance_counters.h    |  6 +++
> >   drivers/gpu/drm/v3d/v3d_sched.c               | 10 +++-
> >   include/uapi/drm/v3d_drm.h                    | 15 ++++++
> >   6 files changed, 91 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_dr=
v.c
> > index d7ff1f5fa481..f1753ee2af25 100644
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
> > @@ -350,6 +351,8 @@ static int v3d_platform_drm_probe(struct platform_d=
evice *pdev)
> >       if (ret)
> >               goto drm_unregister;
> >
> > +     atomic_set(&v3d->num_perfmon, 0);
> > +
> >       return 0;
> >
> >   drm_unregister:
> > diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_dr=
v.h
> > index cf4b23369dc4..9491d730d99f 100644
> > --- a/drivers/gpu/drm/v3d/v3d_drv.h
> > +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> > @@ -61,6 +61,8 @@ struct v3d_queue_state {
> >       struct v3d_stats stats;
> >   };
> >
> > +struct v3d_dev;
> > +
>
> Forward declarations go in the beginning of the file, along with the
> other ones:
>
> struct clk;
> struct platform_device;
> struct reset_control;
> +struct v3d_dev;
>

I am happy that I do not need this in v2 anymore.

> >   /* Performance monitor object. The perform lifetime is controlled by =
userspace
> >    * using perfmon related ioctls. A perfmon can be attached to a submi=
t_cl
> >    * request, and when this is the case, HW perf counters will be activ=
ated just
> > @@ -68,6 +70,9 @@ struct v3d_queue_state {
> >    * done. This way, only events related to a specific job will be coun=
ted.
> >    */
> >   struct v3d_perfmon {
> > +     /* Pointer back to v3d instance this perfmon belongs. */
> > +     struct v3d_dev *v3d;
> > +
> >       /* Tracks the number of users of the perfmon, when this counter r=
eaches
> >        * zero the perfmon is destroyed.
> >        */
> > @@ -179,6 +184,9 @@ struct v3d_dev {
> >               u32 num_allocated;
> >               u32 pages_allocated;
> >       } bo_stats;
> > +
> > +     /* Keep track of current number of allocated perfmons. */
> > +     atomic_t num_perfmon;
> >   };
> >
> >   static inline struct v3d_dev *
> > @@ -584,6 +592,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device =
*dev, void *data,
> >                                struct drm_file *file_priv);
> >   int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
> >                                 struct drm_file *file_priv);
> > +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> > +                              struct drm_file *file_priv);
> >
> >   /* v3d_sysfs.c */
> >   int v3d_sysfs_init(struct device *dev);
>
> [...]
>
> > diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> > index 87fc5bb0a61e..960d392d75a3 100644
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
> > +/**
>
> Using /** means that you are writting a kernel-doc comment [1], so make
> sure to describe each struct member, otherwise it's going to generate
> build warnings with W=3D1.
>

Learned something new - thanks for sharing.

> > + * struct drm_v3d_perfmon_set_global - ioctl to define a
> > + * global performance counter that is used if a job has
> > + * not assigned one on its own.
> > + */
> > +
> > +#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
>
> I would keep this define above the struct comment.
>

Sure .. have done it in v2 of the patch.

> > +struct drm_v3d_perfmon_set_global {
> > +     __u32 flags;
> > +     __u32 id;
> > +};
> > +
> >   #if defined(__cplusplus)
> >   }
> >   #endif
>
> [1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
>

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

