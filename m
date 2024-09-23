Return-Path: <linux-kernel+bounces-335909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102297EC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A02B21A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7E19993E;
	Mon, 23 Sep 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zq0KBvol"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805A199239
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098752; cv=none; b=DwN/zn1oXrI3JVmWb3/a8kmdJ40AL6GrPyMIKTaGjYVXbUBxwgLHzCesBizkoLjb7rVtUyJ63v6V+wdDo3vbt8ko3f6WjdY8q9DT66YWqM5MKPg6D0Ny3A1mJNnWGYFxJVT0ZbhRtxqFaXCTAWVhwaT4bdjEFjwNkyzDCSxnPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098752; c=relaxed/simple;
	bh=PNcLQ39X6f28aZibyzPp56CJqhJ2JlY5lGigCfON3EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+wM6IWT5RBW/4UbxlgJ6m8vtD6WpEYGlciwULzakIM2PZ5L2haHR/H1BrvohHo/g16vS0NvwE9qTzrHl3xM2l4AL4clLJQgfkn9BaoMWboaDN6lpNIn+yQxjx9bS2Wk8PaAq/KOZAWTorWk5WybMrXt6mTdZnfCOLBXyekZpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zq0KBvol; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24648e280so666173a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727098747; x=1727703547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jxxryawPG2WRoNsIiFqe8HMwXZCeIVaB5Utv67yYo8=;
        b=Zq0KBvolklThtUwv44jdL+eU6/O9K6uUHN2YaQgXw73GPnH9MwGvAmSHR3U4TkerAO
         2kR5uX7y3MtwsETJzTg40LBa4zUHMkn2JDEfGyfxIXwXAWz9aCyR99CcL1V1/Qr0WaqV
         C/H9bOkp/wEP9h3wm+pZ0GwfFEw1LviugYbFGVKgkxE9N+b4VU/x95hSBtJfV7RgcEKw
         K2n6/hQ4UYT4HVslboReugA7HjnphZr5TVxLOjU8K9rPekVUlS9EZU8CReo+KG5HVR4n
         bCR/NiWQIEjLjiwtYgh+Ou5YAIrFn4OsVxFpKKX/kBuhL6T094nZkcnNvPSPpWYeKO7C
         gyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098747; x=1727703547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jxxryawPG2WRoNsIiFqe8HMwXZCeIVaB5Utv67yYo8=;
        b=kaNYOz9nCjtdqryBiOCWlMT2BIGJ/c3+R+FRo17/hI9lav58x4RNzpcRYRq0YQDIth
         /ZIrRIgs5ol0RU4x51CRnXgN2ZodyAFvLbPcc61YxsPGmc6gHJVhUBA9hTVeQmth8Xus
         4HYqzeHV5Af8Oy+a4iQHoO3/JY9VfluS2ikANR2apeGIiYImHh8B7d38qKR2EYPIa5Wg
         QdWNSG6cP5W/Jhjt8tOzKRyNFzQfbEyJRHVzijfG7dCTWug8ImYg24E1SbaG9Tb+EeJF
         SS1ACUUvg7M7Br8qkYzk7gXA6rALaruC5zOo1zuQqv2AAtVF4q5LkF6/po01Fm6qxQvA
         m8ug==
X-Forwarded-Encrypted: i=1; AJvYcCVCdCJQl5zqROXTu1VjRpc5w3RzT5nB8tfhxprYb+JDbNSFDBZH8y6SlXStI9hXr0u2v6HEuS6looHF9D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkw4VjhdXTjy6YZjsSb9a8ydCoFdoiqNDzyH3En1G+yss91yB
	USVls8FMr4lWPdrn9ONfTsXSQaTiHE6NyIxj8YoR2S1nedyuuHxQkXdR6ov+gFkw5pUk3A6r1RQ
	D/BtVFSqCtr4u6012zSfYqLzfqCz3/tpNbt4ZFQ==
X-Google-Smtp-Source: AGHT+IFHR0YPBI+WpC/SVDkzcygKoAsQ/r5jHC9ny5l74u+ns6g3j6y41m5RZ1x0P5p5ddW4+uHmw6zs3SYDLAByqeE=
X-Received: by 2002:a05:6402:208a:b0:5c5:b9bb:c67d with SMTP id
 4fb4d7f45d1cf-5c5b9bbc766mr2935752a12.1.1727098747362; Mon, 23 Sep 2024
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <CAA8EJpp1ZHFFY9M3i47d658Q-m3ggJzhxSRUapX=tckgdAwcNg@mail.gmail.com>
 <CA+6=WdS4i3tWei=zzfS_-OW8hs-tgnifOLbNCirGpTx61xEtCQ@mail.gmail.com> <zqmpodwfmabxpjtyhbbuiqkkgaggv3sif7iidv4epjswfw7chp@jomwcvififxk>
In-Reply-To: <zqmpodwfmabxpjtyhbbuiqkkgaggv3sif7iidv4epjswfw7chp@jomwcvififxk>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Mon, 23 Sep 2024 21:38:56 +0800
Message-ID: <CA+6=WdRaTpEeKJRRARD77fVVQVhn3dUo4XrAQZLjyhf+2RYWpQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel: jd9365da: Modify Kingdisplay and Melfas
 panel timing
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Sep 23, 2024 at 05:22:11PM GMT, zhaoxiong lv wrote:
> > On Mon, Sep 16, 2024 at 1:11=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Sun, 15 Sept 2024 at 10:10, Zhaoxiong Lv
> > > <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> > > >
> > > > In order to meet the timing, remove the delay between "backlight of=
f"
> > > > and "display off"
> > > >
> > > > Removing variables: display_off_to_enter_sleep_delay_ms
> > >
> > > This is not enough. If this is a fix, then describe why the original
> > > commit is incorrect, provide necessary explanation, details, etc.
> > > Otherwise it looks as if you are removing the delay that was necessar=
y
> > > for other panels
> > >
> > > Also if this is a fix, it should be properly notated with the Fixes
> > > tag, maybe cc:stable, etc.
> > >
> > > In its current state: NAK.
> >
> > hi Dmitry
> >
> > Our machine encountered an issue where, after entering S3 in the black
> > screen state, there is a probability that the screen remains black
> > after waking up. It seems that the DRM runtime resume has not yet
> > completed, but the system has already started the suspend process.
> > After reducing the delay for disable, this issue no longer occurs,
> > Therefore, under the premise of meeting the timing requirements, we
> > removed the delay between "backlight off" and "display off".
> >
> > Previously,  "backlight_off_to_display_off_delay_ms" was added between
> > "backlight off" and "display off"  to prevent "display off" from being
> > executed when the backlight is not fully powered off, which may cause
> > a white screen. However, we removed this
> > "backlight_off_to_display_off_delay_ms" and found that this situation
> > did not occur. Therefore, in order to solve the problem mentioned
> > above, we removed this delay.
>
> This should go to the commit message, rewritten to use imperative
> language, with the appropriate Fixes tags.

hi Dmitry
OK, thank you for your correction, we will fix it in the next patch.

>
> >
> > This is the timing specification for the two panels:
> > 1.  Kingdisplay panel timing spec:
> > https://github.com/KD54183/-JD9365DA_Power-On-Off-Sequence_V0120240923
> > 2.  LMFBX101117480 timing spec: https://github.com/chiohsin-lo/TDY-JD_L=
IB
> >
> > thanks
> >
> > >
> > > >
> > > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google=
.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 6 ------
> > > >  1 file changed, 6 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/dri=
vers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > > > index 44897e5218a6..2f8af86bc2a0 100644
> > > > --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > > > +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > > > @@ -31,7 +31,6 @@ struct jadard_panel_desc {
> > > >         bool reset_before_power_off_vcioo;
> > > >         unsigned int vcioo_to_lp11_delay_ms;
> > > >         unsigned int lp11_to_reset_delay_ms;
> > > > -       unsigned int backlight_off_to_display_off_delay_ms;
> > > >         unsigned int display_off_to_enter_sleep_delay_ms;
> > > >         unsigned int enter_sleep_to_reset_down_delay_ms;
> > > >  };
> > > > @@ -69,9 +68,6 @@ static int jadard_disable(struct drm_panel *panel=
)
> > > >         struct jadard *jadard =3D panel_to_jadard(panel);
> > > >         struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard=
->dsi };
> > > >
> > > > -       if (jadard->desc->backlight_off_to_display_off_delay_ms)
> > > > -               mipi_dsi_msleep(&dsi_ctx, jadard->desc->backlight_o=
ff_to_display_off_delay_ms);
> > > > -
> > > >         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> > > >
> > > >         if (jadard->desc->display_off_to_enter_sleep_delay_ms)
> > > > @@ -858,7 +854,6 @@ static const struct jadard_panel_desc kingdispl=
ay_kd101ne3_40ti_desc =3D {
> > > >         .reset_before_power_off_vcioo =3D true,
> > > >         .vcioo_to_lp11_delay_ms =3D 5,
> > > >         .lp11_to_reset_delay_ms =3D 10,
> > > > -       .backlight_off_to_display_off_delay_ms =3D 100,
> > > >         .display_off_to_enter_sleep_delay_ms =3D 50,
> > > >         .enter_sleep_to_reset_down_delay_ms =3D 100,
> > > >  };
> > > > @@ -1109,7 +1104,6 @@ static const struct jadard_panel_desc melfas_=
lmfbx101117480_desc =3D {
> > > >         .reset_before_power_off_vcioo =3D true,
> > > >         .vcioo_to_lp11_delay_ms =3D 5,
> > > >         .lp11_to_reset_delay_ms =3D 10,
> > > > -       .backlight_off_to_display_off_delay_ms =3D 100,
> > > >         .display_off_to_enter_sleep_delay_ms =3D 50,
> > > >         .enter_sleep_to_reset_down_delay_ms =3D 100,
> > > >  };
> > > > --
> > > > 2.17.1
> > > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

