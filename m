Return-Path: <linux-kernel+bounces-374731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6679A6F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C143128316E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495C1D0174;
	Mon, 21 Oct 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Ok4IF/8m"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9629408
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527077; cv=none; b=Czk2J7glUAcV9vc2EVWeeg6fuOjgKfDlYyZXma9hU2oiWePvMkQ8tnoErbz/CSGCUvsiVuv9KB0SX5rjlTDoXrEq0+BzffG8UH+hvywcHRjq4JQTTO2x0/1/f3p/saDMHvfVj+WTqAz/Cf12PLB1U1Mss9dGSj7YsIi59g5RLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527077; c=relaxed/simple;
	bh=cZKs4ubBotkkXS5Wnwk+PcczuZZPeiV15E2zkT/8Z4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyqvFj8CldAaSRadXgjUAbrP7fpwVtNg3Qi6nlk+trgPQXvOH8y3d4XVIZal7leVY1KGJC/+lYB5ItakCrDAKWYH/YcmjVMU+kNHUK7rfzSUVJMFnsxUFpJR0lhxHXMEJeXvvriiyPHI86iuHL9KeH+yd8GZ3VzauRu1iaLGbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Ok4IF/8m; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e35f08e23eso42502607b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729527074; x=1730131874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLarjVGAZYFr9G6LDtG3NeEVj6TR9gyCIIm1pC11MuQ=;
        b=Ok4IF/8m00xfRLIICcNX330z76zALqvX2dhC++CCn9AbIczbYdSuVk+8XFCExvfqc4
         hdX0m0y7zE6PGstdxsXoRZsgIZ+lgONfrzK/LGANTaJSZYiOji2kB+rltKctg30KcSuG
         /dUZjH6wtoV+k8m6j4VuGE4b7Z2TvVfQOLM10O/z7Al5/BEQfiAvWQZVW2r9MNrVJCgI
         P1cQhQtCOlVPIsQhXC156VO4a8flTN93IwXORIC7R9/doilhHhzyWMjFxD2hw1HmncJf
         7pU7GamUcGsVzgO68Og6RIIm5/sAe72HK8HmuWc5VfAUXfPNAuheJXQPjRfGng8SXq2q
         APQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527074; x=1730131874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLarjVGAZYFr9G6LDtG3NeEVj6TR9gyCIIm1pC11MuQ=;
        b=Ge0FABtfkVzwSHuMLxSHMMVaXtkk45hWpLfoNe55IVHbzihaZC+TI4DJ8QaGtsUGLe
         dpysx6I0sdyoJtAaVJEiIsr4HxFL0/bHIysncSwVSa6Dnz97DsraOqTeZVEIWq+P1f1P
         LYchmeDkYhs+LmUdrgdqCrojbSu3BiC9x1/JC0qnGJSMO796fUWQjv1Bd+10yrUuqF9f
         imiadOKMINLCdfCh5dj7D/H6MumiK6nO4iLlJfFhRUTk00DJjlakpxyfUVB1XAfJVosO
         77dCzZ1CAZrdJVazGz5xVDGk+b9H6S2HbvGmMYvM3HQ94MA4ShEbKKDeXU5ttk8Z0D8R
         1JMA==
X-Forwarded-Encrypted: i=1; AJvYcCXS8Cc/p4YCK/Ox/nsgE5uhxT+fe5Kv79U0o6eDSOXsUF4ZTqFLvHgvgKaOsU+8X1mIjinVOA/p56+gJ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTLvD/ErZq8DCNIZTXV2dbGh2d6q4ncN41p5zW4ZUFtK7rZMT
	77pCbThTFeNK9HE7AnSXSMrHsiZ33u6gvLeeOOSCuNu8yiYkM8MKLBvSBaw6n3ai6W3cornVFTQ
	bnBgbq7qyS23SjEwhuLsWE6JRkhx8iHuNgTxNaQ==
X-Google-Smtp-Source: AGHT+IH6DdrcYaXPP0mChPDBwLUR+WGY3uRjOTHPRavp++JQS8rWKbIt/tCRrjaIgu43SO89ByRFTbqpJEuDqSJqcxs=
X-Received: by 2002:a05:690c:a8d:b0:6db:cf6c:a7c4 with SMTP id
 00721157ae682-6e5bfd8b1acmr97052717b3.45.1729527074457; Mon, 21 Oct 2024
 09:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
 <20241002-vc4_fbdev_fix-v1-1-8737bd11b147@raspberrypi.com>
 <b1d76661-41b9-4841-80f4-452654d9cd6b@igalia.com> <CAPY8ntDgkyQ6ijdgB2Qmd45ArtXqYFwfmpvYgQhobnw=bUnd-Q@mail.gmail.com>
In-Reply-To: <CAPY8ntDgkyQ6ijdgB2Qmd45ArtXqYFwfmpvYgQhobnw=bUnd-Q@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 21 Oct 2024 17:10:57 +0100
Message-ID: <CAPY8ntDc_s4pxBAVbSdDRDHMVWZHEdWw-283GxCiguz81NYBow@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vc4: Run default client setup for all variants.
To: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime & Thomas.

Sorry, I'm still learning the processes.

This patch and the 3 from
https://patchwork.freedesktop.org/series/139716/ are in drm-misc-next,
but they are fixes needed for 6.12.
Am I right in thinking I need to "dim cherry-pick" them to
drm-misc-fixes so they get merged there?

Thanks

  Dave

On Wed, 9 Oct 2024 at 13:15, Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> On Wed, 9 Oct 2024 at 12:02, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> >
> > Hi Dave,
> >
> > On 10/2/24 12:06, Dave Stevenson wrote:
> > > Commit 45903624e9fc ("drm/vc4: Run DRM default client setup")
> > > only added DRM_FBDEV_DMA_DRIVER_OPS for the vc4 (Pi0-3) driver
> > > definition, which caused an issue on vc5 (Pi4) as there was no
> > > fbdev_probe function defined.
> > >
> > > Fixes: 45903624e9fc ("drm/vc4: Run DRM default client setup")
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >
> > Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> Applied to drm-misc-next.
>
> > Best Regards,
> > - Ma=C3=ADra
> >
> > > ---
> > >   drivers/gpu/drm/vc4/vc4_drv.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_=
drv.c
> > > index 13a1ecddbca3..a238f76a6073 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_drv.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> > > @@ -238,6 +238,7 @@ const struct drm_driver vc5_drm_driver =3D {
> > >   #endif
> > >
> > >       DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vc5_dumb_create),
> > > +     DRM_FBDEV_DMA_DRIVER_OPS,
> > >
> > >       .fops =3D &vc4_drm_fops,
> > >
> > >

