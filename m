Return-Path: <linux-kernel+bounces-175377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097188C1EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF781C21843
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881415E5D2;
	Fri, 10 May 2024 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0yIwXJT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D515217A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325047; cv=none; b=ffo96dq9MjdvOx3ddqfJNddS3dymHGzDqd4RRj75Iw3LTNKsAtEbUNYr3tNC3ZXKgI0mSaEcQP4NOPQP+YlZD9Iz/mGXEmURQbbJAiLz7KyXj334xWsMld9fjCVirSmpSsl8B4YgR3n/EYIskN0yUDFdeAHuSIZv14h9WGBWPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325047; c=relaxed/simple;
	bh=ue7jMTgddF+8Izjutih7fFIKqxvyCwXaYGnYdXk7WUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trH5vCCKVRfrL4TGxLZuh1Jd9LjP15vrC07mLkdsX86sOuFd7R9+6bayzIyGcMVvCt8WleT0H5+ZVEJCUXrMHXGd+VGrn17qw7L4yHRAvpudtaquH2P3Pmwy+KAhNZjJUCpt79kfq2HbJHrZU9I10T/hhuLMXJuCUxt3VYmMdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0yIwXJT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1266368a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325045; x=1715929845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVljsLizj8mP9c78/jZ2/IPg3S8NkJuDIppx14crPK4=;
        b=m0yIwXJTA9Px+KLfRWt+qb+vaF6QtZTPFZpwoteBr5hIni9+OMmC1nP1B5gRT3VtfV
         G0pLIRp9reRmtOKr6+Q7KbKgNkmwBS1r7TDo9jNN6N2p+xVrg8BOIrbejKkMZ+vG4oRe
         1BKJlPq19l9F+XooU8B5Tocu0XDUwAxcve3xbj2ULmxb2VcMUu04fPgyN0TpAA2bqowV
         yPhkaXLimTf7XBg8NoO0PrCYADinWXXuh+nblUWnZILoeGtUB4qSHougWOdDgl7IfhL7
         CRJ+xgZN/T5g7ITX5kX8Qf/LRGS0O2HGwaOhBE0Mrq20ZZVZj6dPW2RleCLY6qA4A7XS
         70wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325045; x=1715929845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVljsLizj8mP9c78/jZ2/IPg3S8NkJuDIppx14crPK4=;
        b=gsR9be5pqGndfyRHdj7R8sSZlsl1lw7mZQuTNzfLecAAdOhwbtiCgqjFoXssN7e5Qr
         ozpNAirBrlUcWIOcaIjUHQFmEUxfOhXyA/mYC2FVhB8OHtWPjxFwxcgwl93zcUqqtxDH
         HJ0zofqVjt3bzdSndCcFBvIDlL7mvjvbUdtUNqLAZd/QrtNUxrf7Hy70d1PiSSuL4Imp
         yuRU7HjCQHdCXiHiAi75o2F+V3VU38aTISYw2rJNXaJEXxYLvNNV6xut2UNvtYpzdEuB
         VJyErayje8MGOKq77BCiNRXKoNyv9dnYxH+KDGYfFr62K+ajVAd4V59bc72z1BRY4Ege
         NgJw==
X-Forwarded-Encrypted: i=1; AJvYcCXFWJEs+0BSPYD+WWt10QUJBLWDcOuDKrG8gzQyTayfv/sPAe2NpXb+Tsz8NOJjBdvqTFCdYexacRyqDxcMk3K6Xo/dYJJekDYNGx/v
X-Gm-Message-State: AOJu0YzGozgvTZinsZQTLqgStAWTPnM7j8niReFebfk/vSw7GwVOcduX
	hhjqy7tFgJMVwLBiA4BaklV0JV1pnnIRsdGoJaUNH+TYzh418jxR9V4gXRI4+eccMwI3v6Ejyd8
	ldBMl5qPVSc9dtPxhehFAkms6f4k=
X-Google-Smtp-Source: AGHT+IF9rZ9n8tSjSA58jwlP66LzJNDN8/JzJWa7zXl65JzLQFRx/MPhn99g9O+7T+04G3i6KEDTkfwPRzgbC+cuBuI=
X-Received: by 2002:a17:90a:4589:b0:2a5:2ef2:4ce4 with SMTP id
 98e67ed59e1d1-2b6ccd85d1amr1723878a91.41.1715325045544; Fri, 10 May 2024
 00:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>
 <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx> <CAGsSOWWAotJPz+o8HSYTrXtq6H7Vrw9KXZX1jDZLgqfudKsnyg@mail.gmail.com>
In-Reply-To: <CAGsSOWWAotJPz+o8HSYTrXtq6H7Vrw9KXZX1jDZLgqfudKsnyg@mail.gmail.com>
From: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Date: Fri, 10 May 2024 09:10:34 +0200
Message-ID: <CAGsSOWX9YcuBpxQZ5kPm6zbMbM6iZqPK3bk=dgKyUZPjq++GXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to disable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:46=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n <tra=
barni@gmail.com> wrote:
>
> On Fri, May 10, 2024 at 2:56=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, May 09, 2024 at 08:14:07PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1=
n wrote:
> > > Move DCS off commands from .unprepare to .disable so that they
> > > actually reach the DSI host.
> > >
> > > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > I don't think this is correct. If the driver sends enable commands in
> > prepare, it should be able to send commands during unprepare too.
> >
> It cannot send commands in unprepare, there are multiple panel drivers
> what do the same.
> Every panel drivers which have DCS commands to be sent in unprepare
> has similar error messages with mdp5/dpu.
>
> [   92.322564] panel-td4320-boeplus c994000.dsi.0: sending command
> 0x28 failed: -22
> [   92.322635] panel-td4320-boeplus c994000.dsi.0: Failed to
> un-initialize panel: -22
>
>
Here is the error messages, these are comes from unprepare by every panel o=
ff:
[  121.295290] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed: -22
[  121.295368] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
un-initialize panel: -22
[  184.783019] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed: -22
[  184.783066] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
un-initialize panel: -22
with this patch these errors no more.
prepare works because of this flag ctx->panel.prepare_prev_first =3D true;
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/g=
pu/drm/panel/panel-jdi-fhd-r63452.c
> > > index 483dc88d16d8..f7222974d6ed 100644
> > > --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> > > +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> > > @@ -169,6 +169,15 @@ static int jdi_fhd_r63452_prepare(struct drm_pan=
el *panel)
> > >  }
> > >
> > >  static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
> > > +{
> > > +     struct jdi_fhd_r63452 *ctx =3D to_jdi_fhd_r63452(panel);
> > > +
> > > +     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int jdi_fhd_r63452_disable(struct drm_panel *panel)
> > >  {
> > >       struct jdi_fhd_r63452 *ctx =3D to_jdi_fhd_r63452(panel);
> > >       struct device *dev =3D &ctx->dsi->dev;
> > > @@ -178,8 +187,6 @@ static int jdi_fhd_r63452_unprepare(struct drm_pa=
nel *panel)
> > >       if (ret < 0)
> > >               dev_err(dev, "Failed to un-initialize panel: %d\n", ret=
);
> > >
> > > -     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > > -
> > >       return 0;
> > >  }
> > >
> > > @@ -219,6 +226,7 @@ static int jdi_fhd_r63452_get_modes(struct drm_pa=
nel *panel,
> > >  static const struct drm_panel_funcs jdi_fhd_r63452_panel_funcs =3D {
> > >       .prepare =3D jdi_fhd_r63452_prepare,
> > >       .unprepare =3D jdi_fhd_r63452_unprepare,
> > > +     .disable =3D jdi_fhd_r63452_disable,
> > >       .get_modes =3D jdi_fhd_r63452_get_modes,
> > >  };
> > >
> > >
> > > ---
> > > base-commit: 704ba27ac55579704ba1289392448b0c66b56258
> > > change-id: 20240509-jdi-use-disable-ee29098d9c81
> > >
> > > Best regards,
> > > --
> > > Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > >
> >
> > --
> > With best wishes
> > Dmitry

