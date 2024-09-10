Return-Path: <linux-kernel+bounces-323275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C389D973A80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52299B25B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352119993B;
	Tue, 10 Sep 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GS9Pj4g6"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858A2AEF1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979690; cv=none; b=L87T4xCW17x7J1SW9rmg7vW24LSMcBWjQoHzQPZB8ZbPVBa8aC1lSCI+LW/oFe8Eq0J/xu/1M47M25F0uwNZyBj90RlFyJi4amxdzHes4+IG+Iyz293py+VNkRL/Tx5sFmfIEPl3DnVrc8s37TRvp9zcViCFMK2zNRWOYpnVRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979690; c=relaxed/simple;
	bh=d97KkvNsGxzcO1XDWiqXYbtbtxw43aIFAw8kkoANEDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9YcepC4ygICwB+pL+NgYbj0lgl9P6V+S09uD2O9t7LfTbr1V9h+F07Yed4bPH2rZbr7JgMhXCY2PWDH5zaHzUmZhBj/3/cjBtQXhplWcc9jdj0dmVNMmF87LhIx1UnrmmLuR9Hjx3PjojSweULVMufOHWv/h5zvcpP3avCQ1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GS9Pj4g6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582b71df40so262071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979688; x=1726584488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXuvHsDaQa5JaJy5jQ+KF3M9U1DYD4thlJa2X3LO3FE=;
        b=GS9Pj4g6p45dOeTTQ3x8noENNBX8OtqIXXnGcdoXsn/GoxyCKMk4WgE28eis/g0joT
         xRj5teVru5Izd0tQWwunymxxdyIqS7oHXxmm5xVlJna3XtD0d+i/uRErq0czmMXLImWb
         dqMdNbn9UnJEC83hI4zUQxpDDIuwwy2M459YND1AmcOBRejvh7V0vMkl9J26xvi4iWpO
         WDgTpEMkJ1mBmixiWCyXpSfp+C2rCfRLqzTneem3cS8bvhdVvitPx4MRF3HDKb27os0S
         ri2VFw5hevukbjfZ6AsQNjaf6tomPvtRRgbsqSfC34da+rnyu/i0jSXZM4BPODCv1dsv
         y3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979688; x=1726584488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXuvHsDaQa5JaJy5jQ+KF3M9U1DYD4thlJa2X3LO3FE=;
        b=OSgE2Oose3wzI2EQ+tkz2TZG0fxjCpva3xjJpOyT7CVfepAG460q7QCxY2JKsbAfoF
         8vOQQyuoVRB3G96lMcufiYmKNtGmtD2Y1JG1O2IFmugmnRheLUUPzCxvFlIMQRg6ZN+5
         YEWEMhgXgrO3cqfHYW60MLD51GwXSJAtyxvyFJQ1vyhZuxJUL4ueKpZA+yWamx2IyhMo
         bCEkQeljCWjdPa0c6702jL7d6uy/YL62u5bA+UtEnHOJdqwnlF7c5Ao/bZMCxwHyE2g/
         Sru8X1hi/t1B6NGI65GWoVWh1NMcOYMFCc8PVK7trx2gx6R+sSGHDEgkxpBk37Lg7mNC
         uWaA==
X-Forwarded-Encrypted: i=1; AJvYcCV2S2VGZyYIQUXYTbqMIJfycmgUWIF5bJHYIh91vfiaPRlmA13dmT3la/ZXSyAVtt1qIHsvDtoBNsgdBgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JrDCFXYT/CXcCpz5PmJfBY4L9XqkSGIY1KQ0wGyYQZtYP3Tt
	EHLk6tYYBLBix2Q8t4HclvcWao60NTMXAI8NNfuWkjAgaLfmuYC0QSGqL5r2mPb2YQgcxrNk9Jy
	kRoVT81IKMmykiRriS/cSuSNIu/Pr4gsgnUk8
X-Google-Smtp-Source: AGHT+IEq/HMZp5o3EyXBDHxohcy+QIAG1sIzXY3bhN/i50uhErJAdEz/UfNt8X3xCTRPtpghCBVQVMyvOC3kysU9hnI=
X-Received: by 2002:ac8:5dc6:0:b0:456:7ef1:929d with SMTP id
 d75a77b69052e-4583d0600f1mr4023421cf.12.1725979687336; Tue, 10 Sep 2024
 07:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909205400.3498337-1-tjmercier@google.com>
 <c970dfb2-078c-4bf1-8b50-6e535cf4adf7@ursulin.net> <7aef07b2-9859-40a8-ba5b-22aba68c2d9c@amd.com>
In-Reply-To: <7aef07b2-9859-40a8-ba5b-22aba68c2d9c@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 10 Sep 2024 07:47:54 -0700
Message-ID: <CABdmKX2JRi-7x_pkSrkuwjzzjDnDQyMEcZmfWrn2AXLuOHQ6Qw@mail.gmail.com>
Subject: Re: [PATCH] drm/syncobj: Fix syncobj leak in drm_syncobj_eventfd_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Simon Ser <contact@emersion.fr>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	Xingyu Jin <xingyuj@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:30=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.09.24 um 09:26 schrieb Tvrtko Ursulin:
> >
> > On 09/09/2024 21:53, T.J. Mercier wrote:
> >> A syncobj reference is taken in drm_syncobj_find, but not released if
> >> eventfd_ctx_fdget or kzalloc fails. Put the reference in these error
> >> paths.
> >>
> >> Reported-by: Xingyu Jin <xingyuj@google.com>
> >> Fixes: c7a472297169 ("drm/syncobj: add IOCTL to register an eventfd")
> >> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >> ---
> >>   drivers/gpu/drm/drm_syncobj.c | 17 +++++++++++++----
> >>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_syncobj.c
> >> b/drivers/gpu/drm/drm_syncobj.c
> >> index a0e94217b511..4fcfc0b9b386 100644
> >> --- a/drivers/gpu/drm/drm_syncobj.c
> >> +++ b/drivers/gpu/drm/drm_syncobj.c
> >> @@ -1464,6 +1464,7 @@ drm_syncobj_eventfd_ioctl(struct drm_device
> >> *dev, void *data,
> >>       struct drm_syncobj *syncobj;
> >>       struct eventfd_ctx *ev_fd_ctx;
> >>       struct syncobj_eventfd_entry *entry;
> >> +    int ret;
> >>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
> >>           return -EOPNOTSUPP;
> >> @@ -1479,13 +1480,15 @@ drm_syncobj_eventfd_ioctl(struct drm_device
> >> *dev, void *data,
> >>           return -ENOENT;
> >>         ev_fd_ctx =3D eventfd_ctx_fdget(args->fd);
> >> -    if (IS_ERR(ev_fd_ctx))
> >> -        return PTR_ERR(ev_fd_ctx);
> >> +    if (IS_ERR(ev_fd_ctx)) {
> >> +        ret =3D PTR_ERR(ev_fd_ctx);
> >> +        goto err_fdget;
> >> +    }
> >>         entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> >>       if (!entry) {
> >> -        eventfd_ctx_put(ev_fd_ctx);
> >> -        return -ENOMEM;
> >> +        ret =3D -ENOMEM;
> >> +        goto err_kzalloc;
> >>       }
> >>       entry->syncobj =3D syncobj;
> >>       entry->ev_fd_ctx =3D ev_fd_ctx;
> >> @@ -1496,6 +1499,12 @@ drm_syncobj_eventfd_ioctl(struct drm_device
> >> *dev, void *data,
> >>       drm_syncobj_put(syncobj);
> >>         return 0;
> >> +
> >> +err_kzalloc:
> >> +    eventfd_ctx_put(ev_fd_ctx);
> >> +err_fdget:
> >> +    drm_syncobj_put(syncobj);
> >> +    return ret;
> >>   }
> >>     int
> >
> > Easy enough to review while browsing the list:
> >
> > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Looks reasonable to me as well.
>
> Reviewed-by. Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks!

> CC: stable?

Yes, I think we should. 6.6 and 6.10

> Let me know when you need someone to push it to drm-misc-fixes.

Anytime is good, no rush for this one.

>
> Regards,
> Christian.
>
> >
> > Regards,
> >
> > Tvrtko
>

