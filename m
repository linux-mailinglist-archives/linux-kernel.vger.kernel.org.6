Return-Path: <linux-kernel+bounces-549492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B63A55334
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0237F174C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CB32147FD;
	Thu,  6 Mar 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DkMS0lhD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDAD23DE85
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282659; cv=none; b=CLpeI5MHtbPQy6Dl4Ia82J6gTAE5GkTy600pLgeFKq/sFKO+myqLVqBoDSbnfZQ1Ng/a3+baORFlU6ZmuPcDzrty4fuYx0BGfUaaJORvBiel3pBYGztRXZbZqXHAmAz+Cn7++nP8EzRq/yV8wA3Gc/26L7bv9Oo6beQ4EHr23yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282659; c=relaxed/simple;
	bh=tZs7bToH6ztHS7athUEVvXOupeqt0NCIvGjMsyM88Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnT6EgOtWhPZZmSmmcZCKrhhpgCuIsPdrgYcvAZ7rLZhVCK1Q5sh9YADqyDF7mStGD57DwgIfc6mDk1BSwKg+yJn7s7JA6otxDLCBDGy9tbEx4h8wcCu1e9EaGRlrbcud4N6T4O4ZDoH9lmsfyyRthWS4HxY8uEDL3IXJ1TJKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DkMS0lhD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5495888f12eso1180559e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741282654; x=1741887454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrmy4N2N6H45SCFx9m0r+IsEyPbwtHoe5bS5CVO84lo=;
        b=DkMS0lhDbFbIQp5igdgHPb2visXXePAV72NgXI9QmGoSeZsyCROBCJqpOLSU4PxElk
         NNKV6Vcl3gTlXlB8m9iA5avjy634TmgjaCXgbTUfLf+26N0cn6hA1kQLEfhhILKKorcH
         tkHptxx79sbZFs7Qr289gLZ959MIeJ+3+b18k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282654; x=1741887454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrmy4N2N6H45SCFx9m0r+IsEyPbwtHoe5bS5CVO84lo=;
        b=pA3MPo3atDLTwXFT88XMrCOZflIv79dB6c2GL0C7e4719KeuLxZq5PAdiPn9SfpJ3C
         WEbS8lqfcU8mPn5TW3D1+fZ88GD7esS3/dwQhdh3/ECw0hvaYa6gA2A5d1r2yE7IShAY
         T10r8NSKljxu+nW4khznj7aHN6IEpWshzbtGbwQqqcnmobEayoFMlBzhheiTfOYfSqjg
         Qg5f8rxmtZZOAhWZXj/EN1p1VSUyQftxsDhpuP7abDC37b6lh8m1dTTRxOoDmu1aqMiL
         XdbUvVWbh+R6CmGIj/u1WTjFL80MMWBq6FPVuna8W05aabdoKtUnqq4ktXbQM38JElbg
         vsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9AZqgi7Olw7RSyhT1P00BX3+7ZQNh87vNsUGNN4LM8GhpmUYz689OrapvwQYWCIFqcZeNdzeyRp3zD24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIZjxyY5yXmuSXIC+b4a7r8VKtDnPJbQtAxYuuccTDU12+GJu
	F6XWdTmnF4d+GMTB3uaAlJjBOJKd9LteiYhxqRH8iKDVfy76OlO9xGqlD3scQZQaqODASMD1hVz
	6+SRy
X-Gm-Gg: ASbGncuYR4Fj/h0s39kLiMymXGcRgunPMljoBkwnbMsh893I+xXATh0ZC0TncseyldE
	b727F5XYXG/Fi9SX8Nwy6EVVHIG/9FtMKFiOa46AXU51O+hTlV2lX/pTvOxkBZkfFz5O7ojQvEC
	xwDURAT70dVWEWplHWA8rKgmq+tVp25z0M08NqSF5qeD7EHq0xJld4PIDjBiIFR41tets6cUWaK
	xTvkGjG47fAQvTWRY8jlQMg5+l8WRNzCeIXCKMAGE+nPtprbbnJf7wEjGsJ7SifeU0SNTntspMS
	Kx+jJYL8PPltWmH6uJu6Wq6RBDnP0jS+xBtSReH5UsHnjWnJ4dAC5TY8fZzT42icZK0ER3xMLl+
	l9cBuUrDC
X-Google-Smtp-Source: AGHT+IFSpkLrw+82ErECnBrIIkwa4G26u8b7mDcc6/hEsSGfAt5IbN2/xC0sGwlRuXX/tJou7WyYIg==
X-Received: by 2002:a05:6512:68d:b0:549:57ae:ab44 with SMTP id 2adb3069b0e04-54990e672f0mr4843e87.26.1741282653944;
        Thu, 06 Mar 2025 09:37:33 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2856sm238887e87.216.2025.03.06.09.37.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:37:31 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5495888f12eso1180349e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:37:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKb20YyZlYD9CffYdhAPdWSkUwm5UnvHOGkI55AGBa9z86CcbdvNBPuR495FXrcAxAdnlspUaF7a48STo=@vger.kernel.org
X-Received: by 2002:a05:6512:ba3:b0:545:1d96:d702 with SMTP id
 2adb3069b0e04-5497d380ca6mr3503371e87.48.1741282650614; Thu, 06 Mar 2025
 09:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org> <p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb>
In-Reply-To: <p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Mar 2025 09:37:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XyOwoMmdvFA565AzGRUSNwonQ-5Ke2H6jc2ki9Sz+0Pg@mail.gmail.com>
X-Gm-Features: AQ5f1JrjbFVtoGA2nDwsNiD6Pg8ldMrCyTA0zDfBVytct4PwWSu2rnonE6kHuA0
Message-ID: <CAD=FV=XyOwoMmdvFA565AzGRUSNwonQ-5Ke2H6jc2ki9Sz+0Pg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lujianhua000@gmail.com, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025 at 8:33=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Mar 06, 2025 at 03:05:10PM +0100, neil.armstrong@linaro.org wrote=
:
> > On 06/03/2025 14:43, Tejas Vipin wrote:
> > > Changes the novatek-nt36523 panel to use multi style functions for
> > > improved error handling.
> > >
> > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > ---
> > >   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++------=
---
> > >   1 file changed, 823 insertions(+), 860 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/=
gpu/drm/panel/panel-novatek-nt36523.c
> > > index 04f1d2676c78..922a225f6258 100644
> > > --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > @@ -23,10 +23,12 @@
> > >   #define DSI_NUM_MIN 1
> > > -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        =
\
> > > -           do {                                                 \
> > > -                   mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> > > -                   mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> > > +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, s=
eq...)      \
> > > +           do {                                                     =
       \
> > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq)=
;      \
> > > +                   dsi_ctx1.accum_err =3D dsi_ctx0.accum_err;       =
         \
> > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq)=
;      \
> > > +                   dsi_ctx0.accum_err =3D dsi_ctx1.accum_err;       =
         \
> >
> > Just thinking out loud, but can't we do :
> >
> > struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
> >
> > #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq=
...)      \
> >               do {
> >                       dsi_ctx.dsi =3D dsi0;                            =
         \
> >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);=
       \
> >                       dsi_ctx.dsi =3D dsi1;                            =
         \
> >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);=
       \
> >
> > ?
> >
> > So we have a single accum_err.
>
> I'd say that can be counter-prodactive. If only one of the links falls
> apart, then the second link still can be initialized (and by observing a
> half of the screen the user / devloper can make several assumptions).
> In case of using just one context the driver will fail on the first
> error and skip the rest of the init for both halves.
>
> I'd have a different suggestion though: what about passing two contexts
> to the init_sequence callback and letting nt36523_prepare() handle each
> of the error separately?

IMO that's a bit outside the scope of what Tejas is doing since it's a
functional change. Unless something is a super obvious bugfix it feels
like doing the conversions like we're doing here should not include
functionality changes and should be straight conversions.

Also: I don't have tons of experience with dual MIPI panels, but I'm
not totally sure how your suggestion would work in the end. Would you
expect that if one panel succeeded and the other didn't that the
prepare/enable calls in the panel should return "success"? If they
don't then higher levels will assume that the single "panel" that
they're aware of didn't initialize at all and won't continue to do
more. That means the user wouldn't have a chance to observe half the
screen working.

I could believe that, for all practical purposes, we could keep the
errors separate and then just return the if either panel got an error
in the end. It probably wouldn't make a huge difference and would
shrink the code side. ...but that I think that should probably be the
second patch in the series and not squahsed into the conversion.


Oh, also: Tejas, please make sure you CC Anusha on your patches. :-) Added =
here.

