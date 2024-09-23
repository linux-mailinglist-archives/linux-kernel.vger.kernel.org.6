Return-Path: <linux-kernel+bounces-335649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4C97E88A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BB1F21E99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE005194C69;
	Mon, 23 Sep 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7pjSNdF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E71946B4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083355; cv=none; b=uJ1cIOeaDrOu9gpQVN0xgiBrPy0vtpUwxbf/fnlbAgIew1+aOkg+a3B29D+ohQ/hAHJLlV95mZOZxEtDKae0tVS+bVADsdyelzGrzx2J0cwbXI52XF2NZ57euSKHicW46frYuKGOaSJComI499ZhYVOm1lfO3w2coAkZ4kwAopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083355; c=relaxed/simple;
	bh=20yp7UF2xtMSFNSWQTwGzQ8Y8WUwoVW0ItEvgc5XuQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgPJmCrR+OSsopVHPdx2K7PnTN5BgZiR9lmI6kRpBqEazHvkcd1cPcsGIoFYvBujZqx1wqS/vPAkQxaEnOt59B5Fr2JbaDwfT72U5fFVGIbhJay3bYucVpJ1g8e3PR2PELx+Aur6D0/Xe5BJk8WpDZJk3Q7B3EZzPCu9SgbMKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7pjSNdF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42bad4eb9so666964a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083352; x=1727688152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7cmHyBl9nc6KTcNNqA/aAzbevaaSNsmEu/DrICna2o=;
        b=I7pjSNdFJYe6YZm0VcPzmyo9R6/zUSooPfKv+oWlBvPcoo9xJK8FO7EACbf+NrUSMA
         X+0MMmxlRedPh50qmvtRu2qZyLGOufZpGbfiZDVRe6SNvOq0Vrs/0jwnviHseiaZRH9n
         ruorIrdn+RXjnvZg/w+tyHvIPbXgC0Bm/LrzGDJI338MbSOt8AtZDZ9Qv+fZTPnCiFc/
         BHYd6kI4Oq6B9hXvrXnqeY+LHH3UmpOnqyu7xLSmkWtXHCbGIe3QZPrWPDfKDJaGbeO2
         0yLfyVEITlQZ8E4QETYzaK6COomZec1vZrhVQ86+s2KfukkjGcnupooNa+a6Vk/VCvdq
         p4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083352; x=1727688152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7cmHyBl9nc6KTcNNqA/aAzbevaaSNsmEu/DrICna2o=;
        b=j5/CaLoglbw1aoZA+vxqtEOse7fHyk1daV4I+8NAQwoxp0sQbpO84Cmj4bDAdExJV5
         n2bmDukV1uLgDCMt5Blprff0pHQxFRhyHM7Mj226lsJ5XGuLguSuNj/lwfVa56k1xl7o
         rOIjwc22bFGfyHzrFF26WS5K5qIHn1LKl94lssWAKnhLhfDDf6WG23pv7yBhOSl+OPwM
         oy+7X22ZOtBEIKb7crB555s3AnTy71nQMJqEE/N6Ib8fah5zGr7juIqppyi9Fw+jlLlW
         jTeJosOjOjytYgZt24v/+/YyUOgMjeaNAAD5DGdrQj9sfZAwDhdK3nFCpe9KWn6qzXOc
         eOuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJV3vj7a8oqazJyKzdI7zO6KflCYMrZCxjgM8yEnf9WMm/NwxChIkSArzezBuSXVXX07NmvujHAL2PLOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsMijf3CQhup6PgYbSA85ts4VGbg5DJsdTKkV6v0OuUDFjJL5
	ccAG0tm9Uqzeh3HNc/hJdJtrOSj3OMyPUU1SnYYUO8zchrriZKJde4pZbG+TRi3tpDKVBYhltl7
	ypGQbsE2Allj5+B0ZiVlwZa8cn1lN+t7atMKWxAbwsAhxpPmwJ2bUjw==
X-Google-Smtp-Source: AGHT+IHhp17g5Fbe+7A2S2wLr+KiDdABA/q1DteOxMrJXmxR3bBqCME6Ga+w6RWL0BpYabZkxl8ORE3TkRZB3gZj4dU=
X-Received: by 2002:a05:6402:268b:b0:5c5:c5fc:1aa6 with SMTP id
 4fb4d7f45d1cf-5c5c5fc1b0amr152694a12.5.1727083351600; Mon, 23 Sep 2024
 02:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com> <CAA8EJpqC5tQ45gj8-0bDutinCs7CoxiQVL1EAzwDK9RJTXYMcQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqC5tQ45gj8-0bDutinCs7CoxiQVL1EAzwDK9RJTXYMcQ@mail.gmail.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Mon, 23 Sep 2024 17:22:20 +0800
Message-ID: <CA+6=WdR6+nh9e2HCuCVdR6uw3vuJoWfKCG4gPjJMp9db+Quimw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dianders@chromium.org, hsinyi@google.com, 
	awarnecke002@hotmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 1:15=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Same comment as the one that I've provided to the other patch, plus:
>
> On Sun, 15 Sept 2024 at 10:11, Zhaoxiong Lv
> <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> >
> > In order to meet the timing, remove the delay between "backlight off"
> > and "display off", and reduce the delay between "display_off" and
> > "enter_sleep"
>
> Separate commit, separate _justification_. Why, not what.
>
> >
> > Removing variables: display_off_to_enter_sleep_delay_ms
>
> This phrase is useless.
>
hi Dmitry

As in another patch reply, in order to solve a black screen problem,
the delay is reduced.
The panel spec:
1. https://github.com/Vme5o/power-on-off-sequential

> >
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
> > ---
> >  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/dri=
vers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > index 0b87f1e6ecae..c2d0ec199829 100644
> > --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> > @@ -29,7 +29,7 @@ struct panel_desc {
> >         bool lp11_before_reset;
> >         unsigned int vcioo_to_lp11_delay_ms;
> >         unsigned int lp11_to_reset_delay_ms;
> > -       unsigned int backlight_off_to_display_off_delay_ms;
> > +       unsigned int display_off_to_enter_sleep_delay_ms;
> >         unsigned int enter_sleep_to_reset_down_delay_ms;
> >         unsigned int power_off_delay_ms;
> >  };
> > @@ -184,12 +184,10 @@ static int boe_th101mb31ig002_disable(struct drm_=
panel *panel)
> >                                                       panel);
> >         struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi }=
;
> >
> > -       if (ctx->desc->backlight_off_to_display_off_delay_ms)
> > -               mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_to_d=
isplay_off_delay_ms);
> > -
> >         mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> >
> > -       mipi_dsi_msleep(&dsi_ctx, 120);
> > +       if (ctx->desc->display_off_to_enter_sleep_delay_ms)
> > +               mipi_dsi_msleep(&dsi_ctx, ctx->desc->display_off_to_ent=
er_sleep_delay_ms);
> >
> >         mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> >
> > @@ -275,6 +273,7 @@ static const struct panel_desc boe_th101mb31ig002_d=
esc =3D {
> >                           MIPI_DSI_MODE_NO_EOT_PACKET |
> >                           MIPI_DSI_MODE_LPM,
> >         .init =3D boe_th101mb31ig002_enable,
> > +       .display_off_to_enter_sleep_delay_ms =3D 120,
> >  };
> >
> >  static const struct drm_display_mode starry_er88577_default_mode =3D {
> > @@ -302,7 +301,7 @@ static const struct panel_desc starry_er88577_desc =
=3D {
> >         .lp11_before_reset =3D true,
> >         .vcioo_to_lp11_delay_ms =3D 5,
> >         .lp11_to_reset_delay_ms =3D 50,
> > -       .backlight_off_to_display_off_delay_ms =3D 100,
> > +       .display_off_to_enter_sleep_delay_ms =3D 50,
> >         .enter_sleep_to_reset_down_delay_ms =3D 100,
> >         .power_off_delay_ms =3D 1000,
> >  };
> > --
> > 2.17.1
> >
>
>
> --
> With best wishes
> Dmitry

