Return-Path: <linux-kernel+bounces-323892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C449744B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5D51C24A90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE11AAE38;
	Tue, 10 Sep 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNco/Hn7"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0323774
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003218; cv=none; b=SK7/1bvjOap1dksSZVXW5nTM9kg1ppE3dZf+kPm0pUuoIRWx3rfQJwK7a77OGRR8FDoMwxvXIzIRbzuwpAfTrXZA4MqgzzOmzpskxltfK/Z6qbuXLDJ+dBJyNpsHLsXTHsZInLLuoWWrwnS4XRUoO3ThEnG4W1CaSmqUk1rbecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003218; c=relaxed/simple;
	bh=jL2FhLcMvpbAygDJoqpWz7U4BjBOVUcyAjcMHjAsjK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLp2MACQWh2mj6pxA4IGF5WCob4G8ka3fD0Iozu76p6U8OIxlDIpnX1upKgjCTV6CJHxIfl2jlezCxl8hT0VDu9iT++SRJ3qZjZvgjFtLd7bMMdblvKdhdE6chYXd8wUj8nNaFwLK5hsu967TFCW5x9bhI0kMcj8U6I7xIlLxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TNco/Hn7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99e8c32c0so339754685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726003213; x=1726608013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLUmgdzEq+2+OB6qY0gPHsSbUC+SX5+BHRNu1RdMAF0=;
        b=TNco/Hn7kRQIaPEInFoBY+IOrZdFW+xXJyshRX/Ns/H1N4M4efckrSZ6ovMLa++XgM
         cwyLem64ZY+u2hMAmcCMWUykJnXSf4nUceTgf3IdY/yq1jdPmK2Vb0DnBRKxlrO4Tipd
         K7i45Nur8001neIR81N6q56aE5UH+0OkIa028=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726003213; x=1726608013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLUmgdzEq+2+OB6qY0gPHsSbUC+SX5+BHRNu1RdMAF0=;
        b=wnqlE7vo2FB09clZTMKWpjQA4+OKkUQpeg6MmfHBa6v21dRGbg4gmmjQuUm9aHeQfB
         /onRltCfU0O6aDRafdCi/z5IJ1J7m93WX1DMj+Wy1Tpxkxs1KU+QxFnHIDojVKlzizAu
         fISanaBsaCAB7Y7X537w/KYADYrMfg9sVQ5pV3uDmViqcVUu/bko/pB7eBatN5FOArOO
         LJ8J8C4ulcADdr2pF0zrCx0tE4ILOQo1oG8COeA5MthpmxYLK0e52/fMzdy4rP/omFav
         RgDzXA2uH2H2rePV2EpevfUpin+Nuv+TnNM6qYt0U5yMSpsOIjQSXMDqMKO6d/vxNPLx
         R8og==
X-Forwarded-Encrypted: i=1; AJvYcCW86+tSfj9lEfyfET4FyuYvuxkqtW3ETXiUjQSP+5AucM4g3eIgLFKM+t61/MvU/g+QhB1SzmjoERAh8t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4s/OsDZxj3YGUzqQTCVcYEdRm5/BFnUeS5LRb8/cYdHxCIKQ
	Jzo8Mf/QCm60KBk4QTqyW/BYmbH8lK6pt40XhH+rwtUCHLpxAFPIgattI5PwdHJ/ceBRPqBRayc
	=
X-Google-Smtp-Source: AGHT+IGrVhpVHk1Nudg+iV+FJZ0K2K0ER7TdqOz07AEXT7LwdDgIJCOzTsorvPH819MYPJJoodzAtg==
X-Received: by 2002:a05:620a:2491:b0:7a9:ad7b:c8db with SMTP id af79cd13be357-7a9ad7bcf1amr1517657185a.62.1726003213154;
        Tue, 10 Sep 2024 14:20:13 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1da85sm343456285a.114.2024.09.10.14.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:20:12 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c51d1df755so36650786d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:20:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFTYtotLs9PeiN5xHkPE/aishV5toL9x0FFvbJi7LItPDW5ZvJpeF2M8+WU3BhG8UBaA00h/iuVKv6R48=@vger.kernel.org
X-Received: by 2002:a05:6214:3213:b0:6bf:6ef6:22d5 with SMTP id
 6a1803df08f44-6c5283f8ecdmr222283746d6.17.1726003211375; Tue, 10 Sep 2024
 14:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com> <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
 <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com>
In-Reply-To: <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Sep 2024 14:19:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
Message-ID: <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>, neil.armstrong@linaro.org, 
	Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 7, 2024 at 1:32=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> On 9/7/24 3:53 AM, Jessica Zhang wrote:
> >
> >
> > On 9/6/2024 3:14 PM, Jessica Zhang wrote:
> >>
> >>
> >> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
> >>> Changes the himax-hx83112a panel to use multi style functions for
> >>> improved error handling.
> >>>
> >>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >>
> >> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >
> > Hi Tejas,
> >
> > Just a heads up, it seems that this might be a duplicate of this change=
 [1]?
> >
> > Thanks,
> >
> > Jessica Zhang
> >
> > [1] https://patchwork.freedesktop.org/patch/612367/?series=3D138155&rev=
=3D1
>
> Ah, thanks for letting me know. I hadn't realized someone else had
> started working on this too.
>
> However, I would argue that my patch [2] is a better candidate for mergin=
g
> because of the following reasons:
>
> 1) Removes unnecessary error printing:
> The mipi_dsi_*_multi() functions all have inbuilt error printing which
> makes printing errors after hx83112a_on unnecessary as is addressed in
> [2] like so:
>
> > -     ret =3D hx83112a_on(ctx);
> > +     ret =3D hx83112a_on(ctx->dsi);
> >       if (ret < 0) {
> > -             dev_err(dev, "Failed to initialize panel: %d\n", ret);
> >               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >               regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->su=
pplies);
> > -             return ret;
> >       }
>
> [2] also removes the unnecessary dev_err after regulator_bulk_enable as w=
as
> addressed in [3] like so:
>
> >       ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->sup=
plies);
> > -     if (ret < 0) {
> > -             dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > +     if (ret < 0)
> >               return ret;
> > -     }
>
> 2) Better formatting
>
> The mipi_dsi_dcs_write_seq_multi statements in [1] aren't formatted
> quite right according to what has been done so far. They are written as
> such in [1]:
>
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> >                              0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, =
0x0e);
>
> Where they should be written as such in [2]:
>
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> > +                                  0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, =
0xa4, 0x0e);
>
> All in all, the module generated using my patch ends up being a teensy
> bit smaller (1% smaller). But if chronology is what is important, then
> it would at least be nice to see the above changes as part of Abhishek's
> patch too. And I'll be sure to look at the mail in the drm inbox now
> onwards :p
>
> [1] https://patchwork.freedesktop.org/patch/612367/?series=3D138155&rev=
=3D1
> [2] https://lore.kernel.org/all/20240904141521.554451-1-tejasvipin76@gmai=
l.com/
> [3] https://lore.kernel.org/all/CAD=3DFV=3DXRZKL_ppjUKDK61fQkWhHiQCJLfmVB=
S7wSo4sUux2g8Q@mail.gmail.com/

I would tend to agree that Tejas's patch looks slightly better, but
Abhishek's patch appears to have been posted first.

Neil: any idea what to do here? Maybe a Co-Developed-by or something?
...or we could land Abhishek and Tejas could post a followup for the
extra cleanup?

Abhishek: are you planning to post more _multi cleanups? If so, please
make sure to CC Tejas (who has been posting a bunch of them) and
perhaps me since I've been helping to review them a bit.

-Doug

