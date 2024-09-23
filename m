Return-Path: <linux-kernel+bounces-335910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1597EC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701A41F21BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FF199E8F;
	Mon, 23 Sep 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qykN+miH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816638394
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098753; cv=none; b=iQtoMqMDDO36YjDNoZDuSJxfeJ4e1nLnOh0xF9AwbKChqii14EVCYh21wVKdvm4+2+Hqr/U///qUycagDG0CTgpqWv6Gl1eecY7fNeCt3LYttZPXL7J3VHZcK74Vym96lQTm4KfRmPs/I8E0wKgMtJBFvqCUcQb7xstTe1WTxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098753; c=relaxed/simple;
	bh=DhgIYcexJWXrGxwvMAfaJQr4zxmVMrudzj4seBmIkK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhqTfSz0QajwSSnoRCBbWJ+EJicfQPHKOYcyZ/nP0AU+k7257t1eLh/sueKbSN20KFePC4UNr4ONAxn8+YqSlRHjXcdiMl799qIYPfX/EeyVugwVmoVMTjBicu8iZwZ+8MKy5wbriOKcvUE2ECsqYV73d8lwaX35aoAR9408SB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qykN+miH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5237so748969a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727098750; x=1727703550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw7IRe11q1zvgtAIfUwyWyhAz+WbOXNiE5JcshO+fbk=;
        b=qykN+miHmeuVS4m8sW7y9wC+vRWcvwtYwnFC7fJ+0vY4yoFtaxCLA11aVtXLH9IqbU
         ZFdIKsttNKpayyQ2vLGxqnTQZu4PwyzvDrfJQKXGNgSku+0Fz7PbuSLu+YTt5YpJV79I
         k+VES4zgUr1rbdmJU7CrTtzT/IjZKA1kAHnv4+a694rIsca6W71CB2dTFPejP+kwc7YO
         DqZbqWi+a1HRk8WgQMSnOCFm/4cAHRu7nZKTmrHRZ2ODSd3FzweJjyQsFQ6LAA39SUMP
         eLUPp1LqO0RHjL0+v7aVUPpE4XaQSxFo03ue+UG4ZmcWRiA5ss2FHg8RRWQsYh5VIdN2
         zeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098750; x=1727703550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw7IRe11q1zvgtAIfUwyWyhAz+WbOXNiE5JcshO+fbk=;
        b=B1PQiUBWGkKeiSeHskTRDbpyGVL5pZ06v+5hDLYLwL7cwqlU45sriFeGq6ftlaPbVQ
         sdQUkEW+w/zu5qXv49CMaMq2Xj0wYwWOoYK/aHtxbtGklD8218sf2o2XNx/XVy4d35ZX
         8N2f+tVOc3LFhXKZ+GDeLi3nCNOTzm8KycUOpIUcEvMqIM0oE144NxzySjp6EP4VtzTg
         EQ/yijNo0QqLyzW9fOzizdYPI3MiEJTKwHB7uB0JpJganoMi39eQlNi2/Z9JDwHwQgZc
         Ytk5wDh0Gc3nWpgORbjs3GdLgRfExRdZDwHfugr579zS2FBaWIKQiaUCAN6VAUyTgFlG
         4cWw==
X-Forwarded-Encrypted: i=1; AJvYcCXD4nQN8tMXcqrTnGxFpwxcrS032zbBL7caTf7inpy4NAJTousvKGk+ysjkFSSq6IqW2wMpAjewtzWrLaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGiw5hxWWubTiANcDknNUqFsmmBEoLtAVWqgANOB4YxXsPKC+
	NGzvMENaRGZPtEFEHO+TEFjs8vtyN8jttlXntAmIYO4HgScUxIfX4lAySGbXRA8W7wbHNK+pDYM
	Ied63gyzR0Ka5HiYstzDhNz8mGlE9paSfxTE6mg==
X-Google-Smtp-Source: AGHT+IHe34L//STnNFdkZExOpf57WJIyU+TI74+0dDBUlm+CP+gn4q7WoyH811n2jON5HT5guRcuccPvcwENuEEvRJc=
X-Received: by 2002:a05:6402:4313:b0:5c4:24a4:8848 with SMTP id
 4fb4d7f45d1cf-5c464a5c24bmr3353651a12.4.1727098750253; Mon, 23 Sep 2024
 06:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <CAA8EJpqC5tQ45gj8-0bDutinCs7CoxiQVL1EAzwDK9RJTXYMcQ@mail.gmail.com>
 <CA+6=WdR6+nh9e2HCuCVdR6uw3vuJoWfKCG4gPjJMp9db+Quimw@mail.gmail.com> <ovmleeivshtixncuxwv3dink6l4fi242rcspklicl3u4qp73rx@km3nu4co4hen>
In-Reply-To: <ovmleeivshtixncuxwv3dink6l4fi242rcspklicl3u4qp73rx@km3nu4co4hen>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Mon, 23 Sep 2024 21:38:59 +0800
Message-ID: <CA+6=WdRMihx1f-kDYX-RngkQ-kDa2vLGSFU30C75jdFXGz88VQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:07=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Sep 23, 2024 at 05:22:20PM GMT, zhaoxiong lv wrote:
> > On Mon, Sep 16, 2024 at 1:15=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Same comment as the one that I've provided to the other patch, plus:
> > >
> > > On Sun, 15 Sept 2024 at 10:11, Zhaoxiong Lv
> > > <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> > > >
> > > > In order to meet the timing, remove the delay between "backlight of=
f"
> > > > and "display off", and reduce the delay between "display_off" and
> > > > "enter_sleep"
> > >
> > > Separate commit, separate _justification_. Why, not what.
> > >
> > > >
> > > > Removing variables: display_off_to_enter_sleep_delay_ms
> > >
> > > This phrase is useless.
> > >
> > hi Dmitry
> >
> > As in another patch reply, in order to solve a black screen problem,
> > the delay is reduced.
> > The panel spec:
> > 1. https://github.com/Vme5o/power-on-off-sequential
>
> It should be described in the commit message(s). You have removed one
> delay and added another one. Is that a single fix or two separate fixes?
hi Dmitry
We only modify one of the drivers (starry), and the other driver
(boe_th101mb31ig002) is just to keep the original value.

>
> >
> > > >
> > > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google=
.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 11 +++++---=
---
> > > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b=
/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > > index 0b87f1e6ecae..c2d0ec199829 100644
> > > > --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > > +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > > > @@ -29,7 +29,7 @@ struct panel_desc {
> > > >         bool lp11_before_reset;
> > > >         unsigned int vcioo_to_lp11_delay_ms;
> > > >         unsigned int lp11_to_reset_delay_ms;
> > > > -       unsigned int backlight_off_to_display_off_delay_ms;
> > > > +       unsigned int display_off_to_enter_sleep_delay_ms;
> > > >         unsigned int enter_sleep_to_reset_down_delay_ms;
> > > >         unsigned int power_off_delay_ms;
> > > >  };
> > > > @@ -184,12 +184,10 @@ static int boe_th101mb31ig002_disable(struct =
drm_panel *panel)
> > > >                                                       panel);
> > > >         struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->d=
si };
> > > >
> > > > -       if (ctx->desc->backlight_off_to_display_off_delay_ms)
> > > > -               mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_=
to_display_off_delay_ms);
> > > > -
> > > >         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> > > >
> > > > -       mipi_dsi_msleep(&dsi_ctx, 120);
> > > > +       if (ctx->desc->display_off_to_enter_sleep_delay_ms)
> > > > +               mipi_dsi_msleep(&dsi_ctx, ctx->desc->display_off_to=
_enter_sleep_delay_ms);
> > > >
> > > >         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> > > >
> > > > @@ -275,6 +273,7 @@ static const struct panel_desc boe_th101mb31ig0=
02_desc =3D {
> > > >                           MIPI_DSI_MODE_NO_EOT_PACKET |
> > > >                           MIPI_DSI_MODE_LPM,
> > > >         .init =3D boe_th101mb31ig002_enable,
> > > > +       .display_off_to_enter_sleep_delay_ms =3D 120,
> > > >  };
> > > >
> > > >  static const struct drm_display_mode starry_er88577_default_mode =
=3D {
> > > > @@ -302,7 +301,7 @@ static const struct panel_desc starry_er88577_d=
esc =3D {
> > > >         .lp11_before_reset =3D true,
> > > >         .vcioo_to_lp11_delay_ms =3D 5,
> > > >         .lp11_to_reset_delay_ms =3D 50,
> > > > -       .backlight_off_to_display_off_delay_ms =3D 100,
> > > > +       .display_off_to_enter_sleep_delay_ms =3D 50,
> > > >         .enter_sleep_to_reset_down_delay_ms =3D 100,
> > > >         .power_off_delay_ms =3D 1000,
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

