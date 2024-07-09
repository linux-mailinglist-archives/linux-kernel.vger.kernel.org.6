Return-Path: <linux-kernel+bounces-246152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7EC92BE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05336286417
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782619D08B;
	Tue,  9 Jul 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBlnyEja"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432619D089
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538788; cv=none; b=tblAXa/KlNoBGsZiA28Za6LBRyOhTVgtzHFmwamHBN91mjBIURZJYPyFlDxj5NtV/yf2TWjqTbUJqEqpYwRJ3iPoBp01b+eV+5z445AaokAarW12TtQfeYd/ptzIg8xugIRu/ml/Uuol4JqABr3YFUjoPzl4oYT1CI68kP6WZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538788; c=relaxed/simple;
	bh=mLzMudHN5SfC0yQJnGMuYVoiWhCV05Wi3/ccfdbygPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nl1h4j0RZ80sJHPg321cnoy3zu2HCCJIe7gzmos8UwSdJA1VuJzMeoUsM5iSBj8F4Cqu6/5p3898H0DT9UEXpQ8gCU1/mMhNWCGXn5L0ccW+ymAPbx+8otmDKwAhTU2/xCUavUElk1Bayec6Gp3olPsuPrsCFAfC3eQ/pHi0CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YBlnyEja; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5da2730efso31342486d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720538783; x=1721143583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj2kSla0vBt0/GLSIO8CQ/A6D734l7WrZXmLB07NQmU=;
        b=YBlnyEja2oNYdKdJTFFXJt3qAwcu76nVjzt/hGjz6e9J4gq7FIDkaqNqlvSTQFeOjf
         OKqUaQPDYtWDIuPDgkeJcsK0M2yo38c/G9KaC/9TM7TLKag0PASJpEI26pLkZE0tJRJ0
         urFn860KDg7zEpnoH9vS2q3CorAavojrazIbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538783; x=1721143583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj2kSla0vBt0/GLSIO8CQ/A6D734l7WrZXmLB07NQmU=;
        b=gJXoUL3Klf3AU98IXGoJwRFp5O3j4RzdIO4H7nmYEoUp4bx+Ppd2WhU0bhL7UXs2xh
         3KrsV0TautoVrKrEwPHY8yfArpkFbQ3JArzg7NOqoxzq51szvAHbN/ljF7F90XJpweQ6
         jk4HGJJt+qGXN5yIToZJtCFM3QKQ7P5k2yRkwb0sYgRobtTmc7tGQr9QfxUQKzXfZn27
         ZMvByQuOxTzJJqIf+4lkOgtXvlX/QouW+K7p4z2kvW/NfoCj7IYQkuxdUoyAfmWbR+C4
         MnxkaI01WV+whJ//DVCQOF7mTBA1IrT6KIcJFFktjfyE+bY7rpedivNdRfuGOZJWBa4N
         qnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSuqsKSJ5Z6axoZsq58SjrmwEw9ii1Ofcm4MX6WojbVgJI6C/bgPTQRN2QJiNvecvHuCoUoOXHhZl2bP8T8KtldKSXwSidesOQ2gfp
X-Gm-Message-State: AOJu0Yx12Bny1/guFbzmo53BU7vBbAqzYEiQmmfFHxa8Wybm0DzB1wZW
	entxi67W/cdn8UhB81ah9IxYDahMyNjTF0/A4hXxF82s1YDrZKYiy8rMvRI89ghAh22QV59Arka
	NzvGg
X-Google-Smtp-Source: AGHT+IF0nY+tse8OpMKMGex3FI9FRNPNixA3o7UuH63p8kjIzHgH+vhN4VIefrnAQs//N23j/sXtfQ==
X-Received: by 2002:a05:6214:29ce:b0:6b5:e6b3:72f9 with SMTP id 6a1803df08f44-6b61bc7f03dmr33801666d6.9.1720538783494;
        Tue, 09 Jul 2024 08:26:23 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9efb8dsm9665176d6.47.2024.07.09.08.26.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:26:22 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447f8aa87bfso470301cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:26:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWT4cgnh7mrLJM615W1mf2LwdwCxOclWnZeC5WG/uau2NIRbpVM6Cf3Otr+V/aAmATYo4BalIczPL+tuAaGY4OiP+ZcthNGIhtfg0Aw
X-Received: by 2002:ac8:45ce:0:b0:447:cebf:705 with SMTP id
 d75a77b69052e-447faede198mr3930761cf.0.1720538781555; Tue, 09 Jul 2024
 08:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708105221.1.I576751c661c7edb6b804dda405d10e2e71153e32@changeid>
 <ba539524-d0bf-4a22-9872-7c8347d88abd@linaro.org>
In-Reply-To: <ba539524-d0bf-4a22-9872-7c8347d88abd@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Jul 2024 08:26:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UU00oJ0Gi5fhOOk4gCFp1Cg55cA7Gy_GPpVgj95BNNbA@mail.gmail.com>
Message-ID: <CAD=FV=UU00oJ0Gi5fhOOk4gCFp1Cg55cA7Gy_GPpVgj95BNNbA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: sharp-lq101r1sx01: Fixed reversed "if" in remove
To: neil.armstrong@linaro.org
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, kernel test robot <lkp@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 9, 2024 at 12:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 08/07/2024 19:52, Douglas Anderson wrote:
> > Commit d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable
> > at shutdown/remove") had a subtle bug. We should be calling
> > sharp_panel_del() when the "sharp" variable is non-NULL, not when it's
> > NULL. Fix.
> >
> > Fixes: d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable =
at shutdown/remove")
> > Cc: Thierry Reding <treding@nvidia.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202406261525.SkhtM3ZV-lkp@intel.com/
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/=
gpu/drm/panel/panel-sharp-lq101r1sx01.c
> > index edc9425bb143..a0d76d588da1 100644
> > --- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
> > +++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
> > @@ -362,7 +362,7 @@ static void sharp_panel_remove(struct mipi_dsi_devi=
ce *dsi)
> >               dev_err(&dsi->dev, "failed to detach from DSI host: %d\n"=
, err);
> >
> >       /* only detach from host for the DSI-LINK2 interface */
> > -     if (!sharp)
> > +     if (sharp)
> >               sharp_panel_del(sharp);
> >   }
> >
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks! I've pushed to "drm-misc-next-fixes" since it's after -rc6 and
the problematic patch is in drm-next.

[1/1] drm/panel: sharp-lq101r1sx01: Fixed reversed "if" in remove
      commit: ec85147a3529fded4bba12b48623f3a2587af83f

