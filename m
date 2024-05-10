Return-Path: <linux-kernel+bounces-175345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8A8C1E59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02532853DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FDD15ECCF;
	Fri, 10 May 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVkW4SRA"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9114B09F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323635; cv=none; b=mZP0UdiXbwsB8FaJNdH4JouzWIPBJOf//8ikMXVNYTBAPcORo+GsrGe9QbLrQmc4MX6tKg+yI9GWO0GNlhhmD0BNBN+w7EKj8JmOBEd9knTF3TNpLM1WKJoSbgpo+ZTis5jvVlLrH5gM+LX9xiLJGOSHjhyy2Zi8vHK+PiYk5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323635; c=relaxed/simple;
	bh=4WGLjBTyR/7rXFpxQYH92xTWCiP4xe0xHhFZBljOkyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM94uTgxyqyK1O9TISWYtZDyjx6mMAQj8aPsdjX8QIC9iHkEMY/N0SwqxjFZGowqd+5x2qRBwHUg9FIVRJEG92MVPw15LMPjnTnrBDYqHFP+8SPAJUaNuYyMTUV5naslecyY5ccIeutMbp59HUNwxhWidcT9lHcCtES26qaYcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVkW4SRA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b3f5fcecc1so1414374a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715323626; x=1715928426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBCt7hEw3xnKO8V8Yx6BUx3zL0FQuskSiNDFxdqn1dw=;
        b=jVkW4SRAMbVmc3OE3M6o9Shy9Os9XB5P6TvPcft62ICHcqSyBw5StVPtVQzf+FITns
         lSH+zSjMCT/fNkeLTFL1YqxlolASms1AMDt3jUrB7fFaoZd5lhPUxXh45LH0eWnftIGS
         waAhv1ukyUtb9gfrnzLZFFqDwFFEEAgpBpr7gQGkhK5BXsHh85TzwjX5qQMZXbqA5zXJ
         k9o9AnKZ3N6jrWbGTFujD9EDv8DDaDeJ9DrNiXJotGkNjzpqWc0BXPlgPbZVN6gDgyB3
         N/oBSqekFJ36fSGg9Og0CpkAI5Rq2/wPs+/nO9RArse2hnXgFDpjjtE95sKgph7+u6i2
         elRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715323626; x=1715928426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBCt7hEw3xnKO8V8Yx6BUx3zL0FQuskSiNDFxdqn1dw=;
        b=oWag0eRKEnMXwUfb73AtiXXiYxSBt5wzuAjBuLsXR0Bu8MZqIxB1uw6zwseyaFQM3O
         W6+iVfy3Bqka2nvrxI8LGaFgeB+VnKjIJnfGduUjyx+uB6ZJ+2SYPY2IZgEKgZRaqfBQ
         q4BJeika0uc9XvH8RUrLmphkDnWiZ6LooVSIIG6+USIj8Kd3HYn2hCAcZvMWIJ3l9nG2
         nwWpVQd+sN43RfNDFz9HY2wAsVjCFJ2ecY5PDS8OsE4zQ9YUhNT65X2RiW6Cv0/fbZao
         htuZEDaBQ/Z/REdsYFKGR6L1d2Uc1JhATQhKtvK/Zc0c9gCLETjiGrzS373Go5NECr5C
         3Fyw==
X-Forwarded-Encrypted: i=1; AJvYcCUM0zAU2CpuxRz04gDOz3Y9dRgROViLm3JGzny85/cRJdazKKwRuLAxRZ/uQrUsyDXdArllE/gFPC9utWvSmwdRtMVgf49aGmAi2cEK
X-Gm-Message-State: AOJu0YwmtqLQFB3d6Kje01TylTCFoxbN1fJIZ6+fc+4YOnxACbgU4E8R
	1x69KSnxjbpqbJYV6X75U9FM0H0Wt3ujpONaaH8sB2bycPm6qL+SF03dUGXx1QpvphOj0pYBybQ
	qiQJWyW3cdMfu5mH+Nt/AUmH42/0=
X-Google-Smtp-Source: AGHT+IGNLD+9hQhByE/EztiLG2Xy1YFt5qfzKCrrLqgcm5OcHvlEy/8DCfsm0OHnO7Wb8zNWGPNBuzHNY1619CPAEKs=
X-Received: by 2002:a17:90a:fc89:b0:2b2:468c:9fdd with SMTP id
 98e67ed59e1d1-2b6cc3429ecmr1732360a91.8.1715323625926; Thu, 09 May 2024
 23:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com> <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx>
In-Reply-To: <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx>
From: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Date: Fri, 10 May 2024 08:46:54 +0200
Message-ID: <CAGsSOWWAotJPz+o8HSYTrXtq6H7Vrw9KXZX1jDZLgqfudKsnyg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to disable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:56=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, May 09, 2024 at 08:14:07PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n =
wrote:
> > Move DCS off commands from .unprepare to .disable so that they
> > actually reach the DSI host.
> >
> > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
>
> I don't think this is correct. If the driver sends enable commands in
> prepare, it should be able to send commands during unprepare too.
>
It cannot send commands in unprepare, there are multiple panel drivers
what do the same.
Every panel drivers which have DCS commands to be sent in unprepare
has similar error messages with mdp5/dpu.

[   92.322564] panel-td4320-boeplus c994000.dsi.0: sending command
0x28 failed: -22
[   92.322635] panel-td4320-boeplus c994000.dsi.0: Failed to
un-initialize panel: -22


> >
> > diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu=
/drm/panel/panel-jdi-fhd-r63452.c
> > index 483dc88d16d8..f7222974d6ed 100644
> > --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> > +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> > @@ -169,6 +169,15 @@ static int jdi_fhd_r63452_prepare(struct drm_panel=
 *panel)
> >  }
> >
> >  static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
> > +{
> > +     struct jdi_fhd_r63452 *ctx =3D to_jdi_fhd_r63452(panel);
> > +
> > +     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static int jdi_fhd_r63452_disable(struct drm_panel *panel)
> >  {
> >       struct jdi_fhd_r63452 *ctx =3D to_jdi_fhd_r63452(panel);
> >       struct device *dev =3D &ctx->dsi->dev;
> > @@ -178,8 +187,6 @@ static int jdi_fhd_r63452_unprepare(struct drm_pane=
l *panel)
> >       if (ret < 0)
> >               dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> >
> > -     gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > -
> >       return 0;
> >  }
> >
> > @@ -219,6 +226,7 @@ static int jdi_fhd_r63452_get_modes(struct drm_pane=
l *panel,
> >  static const struct drm_panel_funcs jdi_fhd_r63452_panel_funcs =3D {
> >       .prepare =3D jdi_fhd_r63452_prepare,
> >       .unprepare =3D jdi_fhd_r63452_unprepare,
> > +     .disable =3D jdi_fhd_r63452_disable,
> >       .get_modes =3D jdi_fhd_r63452_get_modes,
> >  };
> >
> >
> > ---
> > base-commit: 704ba27ac55579704ba1289392448b0c66b56258
> > change-id: 20240509-jdi-use-disable-ee29098d9c81
> >
> > Best regards,
> > --
> > Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> >
>
> --
> With best wishes
> Dmitry

