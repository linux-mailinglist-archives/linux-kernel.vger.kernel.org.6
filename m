Return-Path: <linux-kernel+bounces-325563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDEB975B58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F37D1C22586
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D91BB69A;
	Wed, 11 Sep 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5laSjK6"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF981BAEF6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085238; cv=none; b=gVmmA4uMzI5mMqBMo0pQrw+6OTbGRN1FHQ3SkhVLlT+BcE92g2WaOyTmTqb5eEpTAtQD56zxO746EvRXkZl3xDir3CSkIkr+Ake6Q7k9yn1UkeHysTQKdu+5gKn+n//vAkZQ8Nl2Poq3Fc3Hqp6aEefMdtc8C5J8NwVATLaYdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085238; c=relaxed/simple;
	bh=VNo0yRAzOIrkVswRxbsNMPRjx13WVkIswNUBvauMAE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNjiK59FGF1kQTghtLyhC1lO8X1w7EHDb1Q1NdBpuN2fbPxuozszbmYzkGj7zWUmj5aWkaAAyQlz4YTuDsZPTOfuWlxiwsUsVUpYvWY843lJSXufq3ZNLZBl9Q4yiBEDdgRBfyZEf+CkrC4nC22p7vv4wht1eXRO2+16au17p8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5laSjK6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99a46af10so19182685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726085233; x=1726690033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZEn5VtcIx0UfHxk1R69xjZ7686TsPVIV/uPXWmkBAA=;
        b=d5laSjK6j8u4AuDEfv42sCHYcYao02LV9wKlwYVs7CBqawwAaI8zK9LUIA6xbqPYcj
         nFp0UK2uNuXSeG90CJWujCo37oG2JI4y1bybJxN8RDj03IlxbJoaYBzLpt/LJ6B/C0TN
         ylVtfjjdl4gYjycEktXVZg4I/qCx+49D3Okpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085233; x=1726690033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZEn5VtcIx0UfHxk1R69xjZ7686TsPVIV/uPXWmkBAA=;
        b=YgCvLJCwEqpmGhR4EUNJSNZoJAggD3zRVxjsYSNNZtscjBqqfW5AU1DhQgPmK1aW7h
         TSjdmXGZxYrzmEF9jQ8DTYz0bNqpfIgQd+sE4ffCWX//5l1hAmLdbh3w4ey2E+d2HY8e
         vaN9dRn93gEJdyoCLcB/DckQybwNJqgRR+gtp51Fjjo2dscST4PHRaz20iUGriLnRNLd
         9U19WolZVOJz4ezGnbLOMx4r8Kxo18bLDSuSw9o3UxonCzyV9QVsfY6SEj2z3mY+Y+Y0
         RpEDmosbGS/KnxvyBR/1GoAnOrOQw9c31FvL9pu1xLE/EuALmbZiDh1kdihN0qVmhjwJ
         xSRA==
X-Forwarded-Encrypted: i=1; AJvYcCVOcOFwOeOkNKtU5RnQCnvBfuEN+ePHdzpPYeqhJ8i/WFdH2szzHOYZWgBDXW3zeqleqy7OWL+jp/LQxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBm3f6f01ztP7tlYc5iBvPXbeP+u7wGXGrIFDs8hKrWRQEHY7
	P8qonsJXTTzGQvCQDJzxZ7nW4gG6S1cJZRClycnsrnRTxLU2Zx0D8XxudOirBxn2HCZD9/10c2A
	=
X-Google-Smtp-Source: AGHT+IFVtP73Nkx4LbBzpWMTmq3BZqleDY1KU3bKgAAqQR5kyKYXvHKcegyb3xSXX4WgsyvjscrfBw==
X-Received: by 2002:a05:620a:4110:b0:7a7:f873:1342 with SMTP id af79cd13be357-7a9e5edfb67mr70509385a.5.1726085233411;
        Wed, 11 Sep 2024 13:07:13 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f94119sm44916791cf.82.2024.09.11.13.07.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 13:07:12 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-457cfc2106aso1020591cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEblmv4epnzvJHdA6PzFQhFbH25QwR1grSo9EWJreIBsQN5S8+4JuRSTnBNnup+0hWVK/3U/WAg49xWqQ=@vger.kernel.org
X-Received: by 2002:a05:6214:5d85:b0:6c1:6a57:e7ee with SMTP id
 6a1803df08f44-6c57351a691mr8511636d6.16.1726085231567; Wed, 11 Sep 2024
 13:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com> <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
 <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com> <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
 <8f0227fb-1457-4464-810a-c6b915d9349a@linaro.org>
In-Reply-To: <8f0227fb-1457-4464-810a-c6b915d9349a@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 13:07:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WW4TCKY6-XGnGbf+x4T39OBAcUtaRo_WVzd=HTJpCkxg@mail.gmail.com>
Message-ID: <CAD=FV=WW4TCKY6-XGnGbf+x4T39OBAcUtaRo_WVzd=HTJpCkxg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped functions
To: neil.armstrong@linaro.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, Abhishek Tamboli <abhishektamboli9@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 11, 2024 at 12:41=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 10/09/2024 23:19, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, Sep 7, 2024 at 1:32=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.=
com> wrote:
> >>
> >> On 9/7/24 3:53 AM, Jessica Zhang wrote:
> >>>
> >>>
> >>> On 9/6/2024 3:14 PM, Jessica Zhang wrote:
> >>>>
> >>>>
> >>>> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
> >>>>> Changes the himax-hx83112a panel to use multi style functions for
> >>>>> improved error handling.
> >>>>>
> >>>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >>>>
> >>>> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >>>
> >>> Hi Tejas,
> >>>
> >>> Just a heads up, it seems that this might be a duplicate of this chan=
ge [1]?
> >>>
> >>> Thanks,
> >>>
> >>> Jessica Zhang
> >>>
> >>> [1] https://patchwork.freedesktop.org/patch/612367/?series=3D138155&r=
ev=3D1
> >>
> >> Ah, thanks for letting me know. I hadn't realized someone else had
> >> started working on this too.
> >>
> >> However, I would argue that my patch [2] is a better candidate for mer=
ging
> >> because of the following reasons:
> >>
> >> 1) Removes unnecessary error printing:
> >> The mipi_dsi_*_multi() functions all have inbuilt error printing which
> >> makes printing errors after hx83112a_on unnecessary as is addressed in
> >> [2] like so:
> >>
> >>> -     ret =3D hx83112a_on(ctx);
> >>> +     ret =3D hx83112a_on(ctx->dsi);
> >>>        if (ret < 0) {
> >>> -             dev_err(dev, "Failed to initialize panel: %d\n", ret);
> >>>                gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >>>                regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx-=
>supplies);
> >>> -             return ret;
> >>>        }
> >>
> >> [2] also removes the unnecessary dev_err after regulator_bulk_enable a=
s was
> >> addressed in [3] like so:
> >>
> >>>        ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->=
supplies);
> >>> -     if (ret < 0) {
> >>> -             dev_err(dev, "Failed to enable regulators: %d\n", ret);
> >>> +     if (ret < 0)
> >>>                return ret;
> >>> -     }
> >>
> >> 2) Better formatting
> >>
> >> The mipi_dsi_dcs_write_seq_multi statements in [1] aren't formatted
> >> quite right according to what has been done so far. They are written a=
s
> >> such in [1]:
> >>
> >>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> >>>                               0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa=
4, 0x0e);
> >>
> >> Where they should be written as such in [2]:
> >>
> >>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> >>> +                                  0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d=
, 0xa4, 0x0e);
> >>
> >> All in all, the module generated using my patch ends up being a teensy
> >> bit smaller (1% smaller). But if chronology is what is important, then
> >> it would at least be nice to see the above changes as part of Abhishek=
's
> >> patch too. And I'll be sure to look at the mail in the drm inbox now
> >> onwards :p
> >>
> >> [1] https://patchwork.freedesktop.org/patch/612367/?series=3D138155&re=
v=3D1
> >> [2] https://lore.kernel.org/all/20240904141521.554451-1-tejasvipin76@g=
mail.com/
> >> [3] https://lore.kernel.org/all/CAD=3DFV=3DXRZKL_ppjUKDK61fQkWhHiQCJLf=
mVBS7wSo4sUux2g8Q@mail.gmail.com/
> >
> > I would tend to agree that Tejas's patch looks slightly better, but
> > Abhishek's patch appears to have been posted first.
> >
> > Neil: any idea what to do here? Maybe a Co-Developed-by or something?
> > ...or we could land Abhishek and Tejas could post a followup for the
> > extra cleanup?
>
> Yeah usually I take the first one when they are equal, but indeed Tejas
> cleanup up a little further and better aligned the parameters so I think
> Tejas's one is a better looking version.
>
> In this case we should apply Teja's one, nothing personal Abhishek!

Pushed to drm-misc-next:

[1/1] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped functions
      commit: 32e5666b8a4d0f2aee39a0b2f8386cf9f86a8225

