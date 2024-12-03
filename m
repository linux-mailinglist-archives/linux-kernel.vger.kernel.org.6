Return-Path: <linux-kernel+bounces-428746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED649E12D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86016B2270E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41576148FED;
	Tue,  3 Dec 2024 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0WbgNkI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B126FC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202984; cv=none; b=iU7IibM2bzv992StqHk7H4JWuQ0TW0oWtGFOSeO9oYzmjkS347ZDVs++2iCxu3w8Cxq25wEkHyJ3/WFLJqynsSfMWw636+0Sq0mSZEqjvJr1I8QKCLLoikUXYFn6KdpJTcY9bzdtsAu0JEPDgWnniJbHrOgJmpXFEe3Mr2vWlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202984; c=relaxed/simple;
	bh=xCfEF98Wdb4WOiXtAKRVRdCxsHYHhkis1jPrw4TcuxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYbmSXaIBeG0udaUgZ7hTvRiFqRxLZG3Y9Azz/lBlag1kwjLVQrwE/XV7tXxoCAY/1jpTpbZxQxpzy7omx/fbLVQnyjbF5qFxf8u7hf+42JONJXY4KJk5sKDfAC66lNxdidqKPMV7hByOlAW+kcsV4vwkcYP/hycj1pJyo/+nM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S0WbgNkI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53ded167ae3so5549581e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 21:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733202981; x=1733807781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UD667MqVjs2PSeQOCIMQ6RaQb2wmVHS4BrEZxWWZe4=;
        b=S0WbgNkIZvI8g7CF+3oTZsAe8XlEHJbjmEt9qOue/m6jxs+tvQGl+bXcMC48nN3tJo
         A31icko5TznVQCsOfaoMH01GKTDvqC3tfYxN4vwI4lUrWQ9uEIfU+m1F1K+jZbVIZDg1
         WfeaGJRbgXCuno4rjX9RC7noMewr2M4U/dd3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202981; x=1733807781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UD667MqVjs2PSeQOCIMQ6RaQb2wmVHS4BrEZxWWZe4=;
        b=RrnHJWwVOfYMJDj/VQlbPm8e/v4m7rp5iqnna+dRSrCW8R36UVsGw7cUFLw4ivf650
         f8LudoF+wuvr/+jJpOsiLTm3YOj+jLtLSLddlnNPUB01YHiO+y5yXufYIUyuaMCDl7ns
         xK96BXNz8oLKwCN0v5t50yU5N7tFHZ1qMIO873AvaMbQg/1PxT67dVs6xgbWM4x2WaBa
         QSGCCsEkmOghPWQgQlgtQBgMepbwt/15plVDWeZwuQHtoVA8UPVCSoPc1E92J45Ok2aR
         mAmJRrFMHEAjqNKrXh+ZCkmHY8k5mF7GnBECgxZK+ime5x6OPOypJW5kFuBN8y82ARZH
         5MCw==
X-Forwarded-Encrypted: i=1; AJvYcCU2uXGbiPfKIAIf5UEKLUS0O39eXS1YCXagUXbeRcH4/uLTZSsuWvR+vfgYQS4ar/1y4rbVBIA1aRIW7wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQ+gF6CXc+0x/KYPo2zY4JMQc7DdqUWL+/gqnQH8IH8mS4dAD
	zgBp39kVP//keD7BhKzKPVJkumcMXB5b115tIAEjPsbUTnDaY36evBnJ8OoxPvJK4dGgK4tUEPm
	edfdMzLINTAB/YwhwEI8WeKb34nzGMWPawJ2+
X-Gm-Gg: ASbGncvbv2LcUlzbt7c1FAiHN0HCvV+Mtu+E6gK9qYNTSWoD2/2InjhAttWzKUEU2TD
	WiKKdVEjw7pBx0f8rH5HYdJ6gsx3WM5G4Bzlu6U4Ir25iAo29gLal3HwTip4=
X-Google-Smtp-Source: AGHT+IGm4FRj4d2L71/JkcWnh0KmpdTxb3WeZOy2aVhsku87ZrddGzpbk9L+0MSqJj7VAyzY1Vded+GyvFJFBZY/vh4=
X-Received: by 2002:a05:6512:2208:b0:53d:a292:92c with SMTP id
 2adb3069b0e04-53e12a264damr551253e87.43.1733202980809; Mon, 02 Dec 2024
 21:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202062449.65593-1-wenst@chromium.org> <h4nkbvwohp2izu4mzyv6nih42nqb4yspyxxqwyhojcgxvn5mj2@frar3tof42ds>
In-Reply-To: <h4nkbvwohp2izu4mzyv6nih42nqb4yspyxxqwyhojcgxvn5mj2@frar3tof42ds>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 3 Dec 2024 13:16:09 +0800
Message-ID: <CAGXv+5HNzr_aRLEei_O-XgixKUYDeCpZiymqLOa8ZwROY2gTyw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Remove redundant assignments
 of panel fields
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:50=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Dec 02, 2024 at 02:24:48PM +0800, Chen-Yu Tsai wrote:
> > drm_panel_init() was made to initialize the fields in |struct drm_panel=
|.
> > There is no need to separately initialize them again.
> >
> > Drop the separate assignments that are redundant.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/g=
pu/drm/panel/panel-visionox-rm69299.c
> > index 272490b9565b..1df5303eb57c 100644
> > --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> > +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> > @@ -193,7 +193,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_d=
evice *dsi)
> >
> >       mipi_dsi_set_drvdata(dsi, ctx);
> >
> > -     ctx->panel.dev =3D dev;
>
> No, this will break one of the following function calls. Please refactor
> them too.

You're right. And it mixes usage of `ctx->panel.dev` and `dev`.
I'll send v2 getting rid of `ctx->panel.dev`.

ChenYu

> >       ctx->dsi =3D dsi;
> >
> >       ctx->supplies[0].supply =3D "vdda";
> > @@ -215,8 +214,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_d=
evice *dsi)
> >
> >       drm_panel_init(&ctx->panel, dev, &visionox_rm69299_drm_funcs,
> >                      DRM_MODE_CONNECTOR_DSI);
> > -     ctx->panel.dev =3D dev;
> > -     ctx->panel.funcs =3D &visionox_rm69299_drm_funcs;
> >       drm_panel_add(&ctx->panel);
> >
> >       dsi->lanes =3D 4;
> > --
> > 2.47.0.338.g60cca15819-goog
> >
>
> --
> With best wishes
> Dmitry

