Return-Path: <linux-kernel+bounces-349133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9898F16E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DEE1F21A76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773B19D07D;
	Thu,  3 Oct 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcQcPu8C"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC21E515
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965865; cv=none; b=ke0C/Na0g+buxzEv5+NWFKp2M6VcSdRB9gxyUGnl9a8QVfcWdi11YektLNhDQPgEAlq3RwSxVm9/Na/4bCWPJiPwvakUj43V6ONfp44yqWLmAsHN81tufELC8hLVSlMQqvIGrtn5cKVdAqkEgi9HsFzjg+lH4eJ2nM5wyWpp5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965865; c=relaxed/simple;
	bh=GWhJkqunMFIuaDhHIcOlPzIMJIvE2boSB3FZqCxYtsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0LX3mV07Td6ipsdzElly95APAxqtIHcGASn0iovpE/+DPzaG7q41zijwKg6HBYc8hGYx0GQKTyljG1lDuoVO4DpMUTCPYfZLtJgyItKQ4nFU16cGzmJrIq4JQfliJtNTs/+A9LUdfd6twV2ewU0T39MIGAbwM0rrDuZlEMw0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcQcPu8C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2dbde420d15so75920a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727965863; x=1728570663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6GWsPuyO7eiVtI5Yq1OrqwVQGfqKX2+l2pbM1VOTnc=;
        b=CcQcPu8CDh3AG+OZ50GdbqETyQYuA6Zb/Db+cAWjg+c7dl/QBnv+MrEeds6bWOEyBZ
         kj51sVuBEpRJxoMoOEsfUmKXefNbLcto6iD1dstwCupbFKDFeV9LKVNaOLIvTAEa7ZPm
         niLRWfHNMdQTYuYpqtxpIigXdYJtI4yBmIGPWDUA40QJ9FzzdfNrHzC2tmv3mULslafX
         Y31feYZlFeU7KrqM3RjLgAFWgkAZ0nlJ7X3anpkvHEc/Ci8IJ3sDBORzgbnfaL6gdzrA
         654k9awXtg1od7pKCA+hIG5oT86ry54XykXMp6UyikZS0/P7pkFpO0/e7NPlmafIWxzd
         AW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965863; x=1728570663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6GWsPuyO7eiVtI5Yq1OrqwVQGfqKX2+l2pbM1VOTnc=;
        b=ZnLykViU5uwxK1r3riuvAe5xYnN0zrg7DIBZx2lgfQwF+jGCbYuzfkgWxU4u5w9inh
         ERMiwKBZWxMUHOZ6UR9P5CirQMYcJQacESyC1Xsn8hFWokTA6h41VQsMIXnyuHphZlBg
         I12lLJ32TJF1yFjbTad/ZzCJS+ZZTJmlVKPuhCqmydvObGpqz/R9TN8H3y36Gc7naRY/
         2S4pQVxkWBv+3iej7SuDQ84Ma/as6egDbOMjdJV124kVa0XgNCEOhkhmcegxV3rUhkEC
         Aa6bTcfpUZ0IPlLfIA8uSWOVG6paY+zgTZnZodwoSekz63E2b2k69dU7/L4/9TN2RdQC
         4LhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJTAhtOpTXMJ3FmsBuoQhP8LkEWS5lzjfRX4NTwRMvJgfEtiL2Vx1PuHvXr3L9obNhrYUfrhFw/d0/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJfWZhGtx0HZEoj1iM2NLSsPQVHe1G+WHBvsYpMUfHvAWoNFu
	iwO+zBU0l17L1h5EGAdRrOY+sxDX1mHr/Csy8uOJB+4PgDeRJLk0lpap5HdbOAklIZ1OPX3QWBa
	kF04gMvpg8GmxAIaameFGPTjvtvU=
X-Google-Smtp-Source: AGHT+IHgk4lnbQzZRLNA83q4AzzEtRY6b5eh7Vd/ZM/vfllF40D+lBPBUt5Iwy9xLn69MSwgx/fIAxt/+QKtmP7+fZA=
X-Received: by 2002:a17:90a:e2d5:b0:2e1:682b:361e with SMTP id
 98e67ed59e1d1-2e184a5a874mr3358673a91.4.1727965862995; Thu, 03 Oct 2024
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3ea9a6-575e-4fe5-98d9-6e53803188fa@amd.com> <20241002130149.1607979-1-Igor.A.Artemiev@mcst.ru>
 <20241003-271275e284694a8c82dac508-pchelkin@ispras.ru>
In-Reply-To: <20241003-271275e284694a8c82dac508-pchelkin@ispras.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Oct 2024 10:30:50 -0400
Message-ID: <CADnq5_O3bb38L=rh1OxYj0jdqq21wRM9C7uX35xTkSvm=UQu4Q@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH v2] drm/amd/pm: check return value of amdgpu_irq_add_id()
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>, Alex Deucher <alexander.deucher@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>, lvc-project@linuxtesting.org, 
	Xinhui Pan <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:28=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> On Wed, 02. Oct 16:01, Igor Artemiev wrote:
> > amdgpu_irq_ad_id() may fail and the irq handlers will not be registered=
.
> > This patch adds error code check.
> >
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
> >
> > Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> > ---
> > v2: Remove the cast to struct amdgpu_device as Christian K=C3=B6nig
> > <christian.koenig@amd.com> suggested.
> >
> >  .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> > index 79a566f3564a..50a3085c00aa 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> > @@ -647,28 +647,41 @@ int smu9_register_irq_handlers(struct pp_hwmgr *h=
wmgr)
> >  {
> >       struct amdgpu_irq_src *source =3D
> >               kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
> > +     int ret;
> >
> >       if (!source)
> >               return -ENOMEM;
> >
> >       source->funcs =3D &smu9_irq_funcs;
> >
> > -     amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> > +     ret =3D amdgpu_irq_add_id(hwmgr->adev,
> >                       SOC15_IH_CLIENTID_THM,
> >                       THM_9_0__SRCID__THM_DIG_THERM_L2H,
> >                       source);
> > -     amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> > +     if (ret)
> > +             goto err;
> > +
> > +     ret =3D amdgpu_irq_add_id(hwmgr->adev,
> >                       SOC15_IH_CLIENTID_THM,
> >                       THM_9_0__SRCID__THM_DIG_THERM_H2L,
> >                       source);
> > +     if (ret)
> > +             goto err;
> >
> >       /* Register CTF(GPIO_19) interrupt */
> > -     amdgpu_irq_add_id((struct amdgpu_device *)(hwmgr->adev),
> > +     ret =3D amdgpu_irq_add_id(hwmgr->adev,
> >                       SOC15_IH_CLIENTID_ROM_SMUIO,
> >                       SMUIO_9_0__SRCID__SMUIO_GPIO19,
> >                       source);
> > +     if (ret)
> > +             goto err;
> >
> >       return 0;
> > +
> > +err:
> > +     kfree(source);
>
> Oh, the calltrace looks like:
>
> hwmgr_sw_init()
>   phm_register_irq_handlers()
>     ->register_irq_handlers()
>     smu9_register_irq_handlers()
>
> And the return value of phm_register_irq_handlers() is not processed and
> the error is not reported anywhere, so I guess there is a risk of
> use-after-free: the source pointer may have been already registered by
> some of amdgpu_irq_add_id() calls before the error occured.
>
> The similar code exists in smu7_register_irq_handlers(), maybe should be
> fixed as well.
>
> Alex, is https://gitlab.freedesktop.org/agd5f/linux a public repo this
> patch should go in? I'd suggest to drop the patch and ask Igor to do a
> complete fix or, if dropping is not possible now, fix it by another patch=
.
> For the latter one I can do this myself but it would be nice to refer to
> the current patch via a git hash (it's probably not published yet in your
> repo).

Dropped.  Thanks.

Alex

>
> > +
> > +     return ret;
> >  }
> >
> >  void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *siz=
e,
> > --
> > 2.39.2

