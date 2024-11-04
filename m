Return-Path: <linux-kernel+bounces-394915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B11D9BB5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A97C1C21261
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59612C147;
	Mon,  4 Nov 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL4v0uxZ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D643224F0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726697; cv=none; b=YbKfuQ58KCnAK7CuBErViyUYq+OTJm6BdYjliUxooclaQMEZahjou6zL/8F62wAB7eqjdNVdJyYdp6025QYIHJA5yLQKnnuvw+zMUJiriS5cynTpABDwrkPL4Q1zgCsFNFg3/rBq0ceko21KQUPZWrpyNwqQGVbH9JmuQv5RbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726697; c=relaxed/simple;
	bh=JiQLuLwL03N2kJfahGoRDYXvBmstDEuRevmrVJEZSUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEZ+FYn2MeSTEXU83J3Cr+FlCVD4VmJVgvM62vjpxnP81CY/a9nELbz1P6Pu8ohZAuF2u9Zp0UdHQLO93govxoH6S5HFeb4jpDiniuRtaCMUQ0HPvxJD6tqjzgxDJ23/qevhmG4K00RUAxONm1KOou2SMajA03INYy87K1gQjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL4v0uxZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so3345906a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730726695; x=1731331495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyMarYMRnwtVEOuz49gw8N4olzvNdp83WA83rnbeLrI=;
        b=BL4v0uxZ7h/5/ZClqtsh1gCg32i+DzyO2jj61cscDxHjUV2uPMg/nux9Nb13QN65gx
         D1Aj+jvRu4wSfD4BgGaKXLaxie5zhHn6WSqncWBitApkZpOLuEt2+8Y4557KjqZQWYRX
         fJhl9IpA+7SqEl17HNMkNas8QE9o5oixqjn3AI9amFJSVlIwDRdbnT8/Pm0rS4RF5Q6L
         7j7RS3GsKsU2kS3GRdpYt6WsLWA9KgPaxE8GmhJoMaoTZ23JZM4nZ3p66tUh3YbsFHnN
         xzZIoK4TSV5cX23LnNr9zNElBOGUtHNKIKESqDURxXxmSVDiTen2rySBm3h+kYxF6Ugs
         xgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726695; x=1731331495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyMarYMRnwtVEOuz49gw8N4olzvNdp83WA83rnbeLrI=;
        b=EmTkqVd5q1CF7O7b2Mv0v2/TeG99wAAVP3xU2zAYQSAloxkURaBes/8UCWNi6ginMT
         9a+z5gitrTeB0juy+PV7hV3/dYhs9WGG8CQy+yvxC8BeDL9N7n7uycPljDBXbQ+69Nnm
         +Dm6kEVLu/w1MzuEkcXidguPWPgFdv+qXC17jS53gZfgkEDXQ97cfhWkm2S7EExMLy+0
         OPHihtWZ4RYutk3bHtIqV4KUZah0M7n5ajTfEq1jTxwMqGLMsANIG+Qj0PwfFn2geq5p
         nTnO8NAp+KwWWXmIvzfN2+XOt6k+j2h5Y6d7VBNgCI/TWXnoeph8I1lG8A0T9rp1iLNs
         Z9gw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHPK3GZv2umvY1AonVkynZ/G8h5Aw9MExYukX9nnHyUku8Cgs9qIXvCXWXi7+ml3T/AvIiyxUL7VrBc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXO6MIjALfyFExNKFePas9zce1MHqw4Ziii2YwPcO+XVRMXqv
	hJVFzR2y+GVahxtHj7POmhqBbH8YXIbCxkwHgX+DmArY6698T+fUsAf9PcV73rWBeibFxWGZprI
	NnFoSd7W3ZcEFeKwZAUVrQPRQSAE=
X-Google-Smtp-Source: AGHT+IFmj6tQvhRV7bo1U++FmRbmp5zJMc0V86u/uFsYr5oXIU3pXxUqBf1Q9vQIcVZR5UoPjNgknGCYVZY6pFjhG3Q=
X-Received: by 2002:a17:90a:b30e:b0:2e2:daab:cc69 with SMTP id
 98e67ed59e1d1-2e8f105e941mr33220797a91.12.1730726695528; Mon, 04 Nov 2024
 05:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031205140.541907-1-christian.gmeiner@gmail.com> <fe4056fd-6bb5-435f-aef3-176e301824ef@igalia.com>
In-Reply-To: <fe4056fd-6bb5-435f-aef3-176e301824ef@igalia.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 4 Nov 2024 14:24:44 +0100
Message-ID: <CAH9NwWde9aUwdzZ33qaS5-8OSJ+SNVxiBJpx1OK+a_DYH=TtmQ@mail.gmail.com>
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

> On 31/10/24 17:51, Christian Gmeiner wrote:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
> > configuration of a global performance monitor (perfmon).
> > Use the global perfmon for all jobs to ensure consistent
> > performance tracking across submissions.
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
>
> [...]
>
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
> > +
> > +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> > +                              struct drm_file *file_priv)
> > +{
> > +     struct v3d_file_priv *v3d_priv =3D file_priv->driver_priv;
> > +     struct drm_v3d_perfmon_set_global *req =3D data;
> > +     struct v3d_dev *v3d =3D to_v3d_dev(dev);
> > +     struct v3d_perfmon *perfmon;
> > +
> > +     if (req->flags & ~DRM_V3D_PERFMON_CLEAR_GLOBAL)
> > +             return -EINVAL;
> > +
> > +     perfmon =3D v3d_perfmon_find(v3d_priv, req->id);
> > +     if (!perfmon)
> > +             return -EINVAL;
> > +
> > +     /* If the request is to clear the global performance monitor */
> > +     if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
> > +             if (!v3d->global_perfmon)
> > +                     return -EINVAL;
> > +
> > +             xchg(&v3d->global_perfmon, NULL);
>
> I'm reading the userspace code now and I think you need to call
> `v3d_perfmon_stop` here to make sure that the active perfmon is no
> longer the global perfmon.
>

I will add a `v3d_perfmon_stop` call to `v3d_perfmon_destroy_ioctl` as it
seems a much better place.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

