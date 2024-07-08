Return-Path: <linux-kernel+bounces-244848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4A92AA47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186741C211EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6C1474D4;
	Mon,  8 Jul 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OioRHqSR"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED11CF9B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469080; cv=none; b=kWLPNOR1eBmHxY30FvQreXb6dTaV7oXR+ROE5/SKWLbv3KnCd+0bGlnd0rQFxGy/oqC1VjxFLH7wBsh42I1CZ87qj8+VdXXJzjId/ShIlG7/3XfqidXK2S/ynU12d8WxWCH9coM1FCgUXtQ+EE1GlM/VtmGQjC94NuQT13TbL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469080; c=relaxed/simple;
	bh=xjmk/dH/FYb97SYHbofjRLmIMf7HeZ/fziMC3AWkA1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEFIhYyiipruft0PBxIt8HmFnUJTnofLtbtk6V77hzX9mRSy1LM7JitZjHR4O+1b2//gvmFw8p+mh1E+CLD1ZIoz0JIRplRj0szXOryNxSPe/BIGO0VgQEcVOrQYPvVgYPAexD5m4AABWzxFctrqR6ka1AUz7FZFjsBsKnnv20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OioRHqSR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-707040e3017so2908232a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720469078; x=1721073878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W49Ts2h7IXoKSnNhKTlkJLMbVTeV+7YxvdVcGt2FXk=;
        b=OioRHqSR65/dcC95ZYNvSYTX3nZj1yGlvMUthnzC0mdbvEIQfsJEZizRkg1f6VTJWW
         M9fTNPjcEGtC/ba4MJG4cQe1EeAE9T7lPVN8fU3V16ixSH4bLl9f+yeJ/mEgqUpLKOX/
         6K8m4tRxu8LlRwnMhf4HqKMc0HdnyyQDA67TTNnDOCsvTwgTiQMZTzzzRRNepopHFolk
         fnNUysA3io8baysJFZi97L+XWzx4tp3BxA24BbSx4SFNdY3WH2w5K8ijys1Mvwl6VLwa
         anB4jcIHsPTqMZDF1e69364eMBCqdsjSc7/9aK9111/DI2gTGN8bD6b+Bjcqkz+v8aju
         bqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469078; x=1721073878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W49Ts2h7IXoKSnNhKTlkJLMbVTeV+7YxvdVcGt2FXk=;
        b=u2ihFzTVpDIPc7hKKpVjzyYMFPgQbPLFeZrto9eTzbFd5LzjdE/t30SF7gwE380TWP
         MtzRQxfRx79mND/jP3WryJtz8XKWtn27LSNIwuy5N/rJJnLjXDzeIa+q9tAh1GuZ2gwW
         +Va2xfManfSDic5OfMwwtSGgsYedYnqlblyPKefMpfbyXR0IfH3hAqiWUD1nCIHJjeOE
         4SnBnIiPCRE/iuujiJra2N1ZmfgNJpz75kvD59Nl9UR3Ap1G686WW2i6eEsUgB9ZltXm
         7/qLuEUlCqPC21j097uIIrv3K5RcPApgFjUJVZn5sRTcE0tZivZ1QmXiUoArzVw+EMYL
         p0ug==
X-Forwarded-Encrypted: i=1; AJvYcCX6z4r2bCifG2v9+mRMHlgOpG/CUuNwd2dhE5wHl+BkyP9PSNhRYpayLOtzc8QajxFrMNztXuy4Wa3voS+pKUP8XjTj55u7SaPVavSt
X-Gm-Message-State: AOJu0YxED5fkkiuISPWQ65q2UNZLyE5ClFDL0uIYzosPW7+uZoX6xScq
	GvEzwbOatZa+lq2uHw4sBbSk88F15U4vW03bzvtLEXgumlTuZ0HLnzsQoQg7NIBHQ71iQTj3GzI
	UoHZM1dLMlt47j75KIEFLzGf5ZzE=
X-Google-Smtp-Source: AGHT+IG+RG9sKH282j1PUR1uFtwEkAUIQDyBg0mzm5Zr7D1Y3mFiNCPk0xP+P9igu7ELI0aPhLclO7bBMc3MaJ4qawk=
X-Received: by 2002:a17:90b:1fcd:b0:2c8:db8b:7247 with SMTP id
 98e67ed59e1d1-2ca35be7c77mr668245a91.9.1720469078305; Mon, 08 Jul 2024
 13:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630165949.117634-1-wuhoipok@gmail.com> <20240630165949.117634-7-wuhoipok@gmail.com>
 <3ecb6fb4-ff60-4c49-8199-b76b4f297ecf@suse.de>
In-Reply-To: <3ecb6fb4-ff60-4c49-8199-b76b4f297ecf@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jul 2024 16:04:26 -0400
Message-ID: <CADnq5_NNhVZ481RJMcAchxh-66vCOqcp_kOx9HLO2g2agyWOKA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Wu Hoi Pok <wuhoipok@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Wed, Jul 3, 2024 at 4:55=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
>
>
> Am 30.06.24 um 18:59 schrieb Wu Hoi Pok:
> > "drm_dev_alloc" is deprecated, in order to use the newer "devm_drm_dev_=
alloc",
> > the "drm_device" is stored inside "radeon_device", by changing "rdev_to=
_drm(rdev)"
> > other functions still gain access to the member "drm_device". Also, "de=
vm_drm_dev_alloc"
> > is now allocating "radeon_device", allocation inside "radeon_driver_loa=
d_kms" has to be
> > removed.
> >
> > In "radeon_device_init", it originally assigned "rdev->dev" etc. Howeve=
r it is already
> > done right after "devm_drm_dev_alloc" as you can see down below. It is =
better remove them.
> >
> > Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon.h        |  4 ++--
> >   drivers/gpu/drm/radeon/radeon_device.c |  3 ---
> >   drivers/gpu/drm/radeon/radeon_drv.c    | 12 +++++++++---
> >   drivers/gpu/drm/radeon/radeon_kms.c    |  8 +-------
> >   4 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index ae35c102a487..fd8a4513025f 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -2297,7 +2297,7 @@ typedef void (*radeon_wreg_t)(struct radeon_devic=
e*, uint32_t, uint32_t);
> >
> >   struct radeon_device {
> >       struct device                   *dev;
> > -     struct drm_device               *ddev;
> > +     struct drm_device               ddev;
> >       struct pci_dev                  *pdev;
> >   #ifdef __alpha__
> >       struct pci_controller           *hose;
> > @@ -2478,7 +2478,7 @@ void cik_mm_wdoorbell(struct radeon_device *rdev,=
 u32 index, u32 v);
> >
> >   static inline struct drm_device *rdev_to_drm(struct radeon_device *rd=
ev)
> >   {
> > -     return rdev->ddev;
> > +     return &rdev->ddev;
> >   }
> >
> >   /*
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index 32851632643d..554b236c2328 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1285,9 +1285,6 @@ int radeon_device_init(struct radeon_device *rdev=
,
> >       bool runtime =3D false;
> >
> >       rdev->shutdown =3D false;
> > -     rdev->dev =3D &pdev->dev;
> > -     rdev->ddev =3D ddev;
> > -     rdev->pdev =3D pdev;
> >       rdev->flags =3D flags;
> >       rdev->family =3D flags & RADEON_FAMILY_MASK;
> >       rdev->is_atom_bios =3D false;
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/rade=
on/radeon_drv.c
> > index 7b8aa8406751..f36aa71c57c7 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -260,6 +260,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
> >   {
> >       unsigned long flags =3D 0;
> >       struct drm_device *ddev;
> > +     struct radeon_device *rdev;
> >       int ret;
> >
> >       if (!ent)
> > @@ -300,9 +301,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
> >       if (ret)
> >               return ret;
> >
> > -     ddev =3D drm_dev_alloc(&kms_driver, &pdev->dev);
> > -     if (IS_ERR(ddev))
> > -             return PTR_ERR(ddev);
> > +     rdev =3D devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*rdev=
), ddev);
> > +     if (IS_ERR(rdev))
> > +             return PTR_ERR(rdev);
> > +
> > +     rdev->dev =3D &pdev->dev;
> > +     rdev->pdev =3D pdev;
> > +     ddev =3D rdev_to_drm(rdev);
> > +     ddev->dev_private =3D rdev;
> >
> >       ret =3D pci_enable_device(pdev);
> >       if (ret)
> > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/rade=
on/radeon_kms.c
> > index a16590c6247f..645e33bf7947 100644
> > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -104,15 +104,9 @@ void radeon_driver_unload_kms(struct drm_device *d=
ev)
> >   int radeon_driver_load_kms(struct drm_device *dev, unsigned long flag=
s)
> >   {
> >       struct pci_dev *pdev =3D to_pci_dev(dev->dev);
> > -     struct radeon_device *rdev;
> > +     struct radeon_device *rdev =3D dev->dev_private;
> >       int r, acpi_status;
> >
> > -     rdev =3D kzalloc(sizeof(struct radeon_device), GFP_KERNEL);
> > -     if (rdev =3D=3D NULL) {
> > -             return -ENOMEM;
> > -     }
> > -     dev->dev_private =3D (void *)rdev;
> > -
> >   #ifdef __alpha__
> >       rdev->hose =3D pdev->sysdata;
> >   #endif
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

