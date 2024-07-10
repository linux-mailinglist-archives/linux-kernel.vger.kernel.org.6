Return-Path: <linux-kernel+bounces-247559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7892D12D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481D21C23295
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C55191F80;
	Wed, 10 Jul 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ASITmgEW"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358B19066E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612742; cv=none; b=mCHem3kSeY5eXYhPkDg5J9itI9l7cNeubfRPWVnJWYFqzvhhPHOsB/X82rH13TamYdCH0HSaavzfU0NL2ABuL2LpaOeBXP8ztrav2oeZKOdvL5WoDz9Ah/RRAzUFTkqs437rR1n4de74J1HjN3e3XCen6JY8WZJ4VDcW8c63+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612742; c=relaxed/simple;
	bh=SpQ/wq4iDk2wkrxG5x7QUsVs/DSkxz22VFMJoTOxUqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPcE/yh3ujT2ltpKD5oatxsAjd3XqHIwqtHDX2oFNoiWG//kzPTI7dPNLA0uvsIzOTOaQe5cffufAOOKJk7EVawywMqT0fqMVvxiQ0IhBGKcKhWJNoWpfDSrXUPOM82A/y49OamSffof1Ifw4FNKF2+xRfCwZw8FQT5jHlZhhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ASITmgEW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e6e60a879so207784fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720612740; x=1721217540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YwSacl49HZikhh7TpAVL5zSZM2Ig9YohILbbUy5PtM=;
        b=ASITmgEWidkUD6UBZUDgQkSckWRh9JeW33QYVQiB6Gs8nJUMLjI6i6XXOxXI/ZHvMQ
         gRFIZVL0f2f8wAn6ECkJ8Z9BO9w9ISHGQhmJrZw73qsP0MbogKIwwb79iEe6sl91ldwp
         t+uFfs+yX93OIesZox3qcBaJ3kV+sN3eBDVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612740; x=1721217540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YwSacl49HZikhh7TpAVL5zSZM2Ig9YohILbbUy5PtM=;
        b=gfVUnIqblMy6aSL0GSEmPB4pPYMoWKPYN0qVnKff2wj+/ZEjbnfc2+4CQzKwNlV02n
         dtxwv+dvYG31UsQGvN8deFIesvvfkDqJInfKZYHAYjnZ4ay2qB4+650TMT75YHyxNCMe
         qQQegVGkgMiXYVYlxL+3cshgTTJo2AyxrsMQ25U6Q29HNHNL0CvNlDMAUmrG7CCaf7AM
         GiB/6G5OlrDpzXLzGEIRplpxPWBaPc0zspBKVRNRyul8i+oSzZ7Z0gfE773+zO66pkNt
         P4j2y8peOB+vgr0vxhcsrPvsk4gONyQi3yQQD9ZLkNv/wQvxMrkD8mAVnkslUD3GH3hf
         GREQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGLLqtoQjJIM9PACXmQrvE5sNeHocjqC2WNSPwA0rabF33IP2qAikxQSSQyyiJ2iBkdmYZpbgM6DVu1uRB0apG/up1Avo1Dkcu7XYK
X-Gm-Message-State: AOJu0YwiaBjqqCzDzhvY8FD6w0Vp3e7HyvRA2RGloxMzYv+fWmOdatSj
	kIlQTzX+AUoxtoy85pWQIJ1PhdXBjjf+ZXDo4QuomgUYyZ7vdOF/H38gKI2bOJlr+R1LI204goT
	tSuisLwYlEK1CGI4iQHgl/gYDj/3LyfrIq4DXyg==
X-Google-Smtp-Source: AGHT+IEDb4E4R4JLvPaGkcDd2e1PnOfOAi8hfE4Q9IQEkktLnUcIxOmoAJGlW/KgY1cJtU5AbP/Am5hiG+biuNY4XSw=
X-Received: by 2002:a05:6870:82a4:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-25eae2f200fmr5688757fac.0.1720612739640; Wed, 10 Jul 2024
 04:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710093120.732208-1-daniel.vetter@ffwll.ch> <03f7e2ad-fd5c-4da7-a14c-34c2c158c513@amd.com>
In-Reply-To: <03f7e2ad-fd5c-4da7-a14c-34c2c158c513@amd.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 10 Jul 2024 13:58:48 +0200
Message-ID: <CAKMK7uFvCr2qcHun06LC-ON3GBqj8=mCpPGHuAOh9BEyr60fiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: Add might_fault to drm_modeset_lock priming
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 at 13:39, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 10.07.24 um 11:31 schrieb Daniel Vetter:
> > We already teach lockdep that dma_resv nests within drm_modeset_lock,
> > but there's a lot more: All drm kms ioctl rely on being able to
> > put/get_user while holding modeset locks, so we really need a
> > might_fault in there too to complete the picture. Add it.
>
> Mhm, lockdep should be able to deduce that when there might be faults
> under the dma_resv lock there might also be faults under the
> drm_modeset_lock.

You're not allowed to take a fault under dma_resv, because drivers
might need to take that lock to handle faults. So unfortunately in our
combined lockdep priming, there really seems to be no chain yet that
teaches about faults possibly happening while holding
drm_modeset_lock.
-Sima

>
> >
> > Motivated by a syzbot report that blew up on bcachefs doing an
> > unconditional console_lock way deep in the locking hierarchy, and
> > lockdep only noticing the depency loop in a drm ioctl instead of much
> > earlier. This annotation will make sure such issues have a much harder
> > time escaping.
> >
> > References: https://lore.kernel.org/dri-devel/00000000000073db8b061cd43=
496@google.com/
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
>
> On the other hand pointing it out explicitly doesn't hurts us at all, so
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/drm_mode_config.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mo=
de_config.c
> > index 568972258222..37d2e0a4ef4b 100644
> > --- a/drivers/gpu/drm/drm_mode_config.c
> > +++ b/drivers/gpu/drm/drm_mode_config.c
> > @@ -456,6 +456,8 @@ int drmm_mode_config_init(struct drm_device *dev)
> >               if (ret =3D=3D -EDEADLK)
> >                       ret =3D drm_modeset_backoff(&modeset_ctx);
> >
> > +             might_fault();
> > +
> >               ww_acquire_init(&resv_ctx, &reservation_ww_class);
> >               ret =3D dma_resv_lock(&resv, &resv_ctx);
> >               if (ret =3D=3D -EDEADLK)
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

