Return-Path: <linux-kernel+bounces-222856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E56519108AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6026B1F22975
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042411AE087;
	Thu, 20 Jun 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYkvN9aw"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1419B3E1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894581; cv=none; b=G3rsGRTksJTWyND7OOA9MpjSNsgep2DGdaeB8Of7922T+V8zS38NpagOnE7SFREUhx0Alf7GVL8fuHYUrbUEi3ijoSBHPnUcRspBzZDWUs7/ESzZVZy7gTYIv/dhfKdkc5fcgM2stcVTcY1GFyw7D8fXldAdvxMEJQPnWPiXqnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894581; c=relaxed/simple;
	bh=IJYxraytYookZc/ISG2dLtwW9nN2Q/gjhhl/349yosw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4f9tBa6pGkf1lu6hx990MRQUaAxD7GLmvljFz2mtafb69DZxYHbBefGH2qbzCu6mE8H2Ymm8OxGZp+uYSJ8W1AQqtktkqkXAgrptDcKHtkH9GKBUOFp/hhANXIMoOi7oK3P1XsUnPDlnE6k1al1jc4kGyjRhthy8bpTThVVcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYkvN9aw; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d21e00d9cfso543169b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718894577; x=1719499377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTqruObpt/HIvpDQMuAjEvg89Qw86zRssV1fyDgz0Hc=;
        b=BYkvN9awUwt2Mr56oJ65NxOepwJeITu2wrw7e0A4w/6gnDFqjIhdk4gbDd0U4FWVXa
         yWQkhuQy3xz3KpFM9UraUTvl2gwuvoZzI9Q+g+ov6lTeHJm44+3/dxjzGYiAnSWh2kEs
         eh8UDkpOPjia4hvh3kQEnYFAtji6gUvCVXEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894577; x=1719499377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTqruObpt/HIvpDQMuAjEvg89Qw86zRssV1fyDgz0Hc=;
        b=G7hS8FmJDcw39T0I9QENErgj1rEubkHqGDiA5PpOt5+emb5H3NRYx4KTsSkC2cOi+N
         8RS9zkMY58uQxiFDSJ/O4ebeoB5EtDSUjiv5LNJtEqadSN3qCtlnAjf4yjYMSV+NYJP+
         zlUe4HXfBzz0vpZX8xRHHncNUxxJ8iy83df5D+xexTUeBY+pe4E62q9vXP4Vhl07OaEi
         qwnm6pEDZwF9jKA8oBDjGK+cxhIGCqxP3inP1nsXhPOiAoPFBmadIHHyNj7KnBVgf8ZJ
         WmeKgDTf9mQICgDBRjIRsuB4d+YTotwYfuawVcVCDUm5sTzdDAkt7hKD6awr4ItWiUoX
         0qNw==
X-Forwarded-Encrypted: i=1; AJvYcCW487MGWYCyNz9rR2z11ilDsY9o20XMyhiAKCUE56zpe2BP2tRf3ID+vZRPTGQpGDFYK4K8MEF8um/eojfI/0q9tCoHGGRLcWSd26Gi
X-Gm-Message-State: AOJu0YyzvYqnc2A9V/wmyAhPTKsmEG43vpqIHNds+RzDXwICyYLAbKs3
	iK+0YmmQzXhh6RnKBqFuz5kN81yu016+rW0ueJbWAB9/MchT0NXJuNjJLkAM1pwy20+IwEfUAIk
	=
X-Google-Smtp-Source: AGHT+IGAG4jGyIsq7J1qK/AGOIAzENf21H4VqY1rpeQJRtOIWRCSXiwQidRbgaIVIktR0lXxIZTxKg==
X-Received: by 2002:a05:6808:f07:b0:3d2:21a7:8629 with SMTP id 5614622812f47-3d51bac4b56mr6115906b6e.41.1718894577158;
        Thu, 20 Jun 2024 07:42:57 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe48449sm701519185a.104.2024.06.20.07.42.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:42:56 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-443586c2091so870391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULaHGlRx7EUwO3Dlabx9TgTQZTryC5j2of3nEHNRWxB1lwOqpqtMqkUWmYeznH7F0YnWnoNhkcmn0ha+zZFbGxN9bqadpxjBrGQn4R
X-Received: by 2002:a05:622a:1301:b0:443:1cdd:7859 with SMTP id
 d75a77b69052e-444a8f6e1e0mr6647671cf.12.1718894575312; Thu, 20 Jun 2024
 07:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619033351.230929-1-tejasvipin76@gmail.com>
 <mozxxkpqlboh2w7bf55bezgcy5b2jfgepmgullgd24dtmwfva2@mghwg3c5an5y> <a9312102-44c1-4529-b3ef-a7831392c42f@gmail.com>
In-Reply-To: <a9312102-44c1-4529-b3ef-a7831392c42f@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Jun 2024 07:42:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJA5R1SKZe1vmRWc4=GXPbFOsT3gdj+x9cwR7YCQ8GfQ@mail.gmail.com>
Message-ID: <CAD=FV=VJA5R1SKZe1vmRWc4=GXPbFOsT3gdj+x9cwR7YCQ8GfQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 12:23=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
>
>
> On 6/19/24 12:06 PM, Dmitry Baryshkov wrote:
> > On Wed, Jun 19, 2024 at 09:03:49AM GMT, Tejas Vipin wrote:
> >> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introd=
uce
> >> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> >> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> >> raydium rm692e5 panel.
> >>
> >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >> ---
> >> Changes in v2:
> >>     - Change rm692e5_on to return void and take mipi_dsi_multi_context
> >>       as an argument.
> >>     - Remove unnecessary warnings.
> >>     - More efficient error handling in rm692e5_prepare
> >>
> >> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gm=
ail.com/
> >> ---
> >>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++---------=
-
> >>  1 file changed, 99 insertions(+), 138 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/g=
pu/drm/panel/panel-raydium-rm692e5.c
> >> index 21d97f6b8a2f..9936bda61af2 100644
> >> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> >> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> >
> >>  static int rm692e5_prepare(struct drm_panel *panel)
> >>  {
> >>      struct rm692e5_panel *ctx =3D to_rm692e5_panel(panel);
> >>      struct drm_dsc_picture_parameter_set pps;
> >> -    struct device *dev =3D &ctx->dsi->dev;
> >> -    int ret;
> >> +    struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> >>
> >> -    ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->sup=
plies);
> >> -    if (ret < 0) {
> >> -            dev_err(dev, "Failed to enable regulators: %d\n", ret);
> >> -            return ret;
> >> -    }
> >> +    dsi_ctx.accum_err =3D regulator_bulk_enable(ARRAY_SIZE(ctx->suppl=
ies), ctx->supplies);
> >> +    if (dsi_ctx.accum_err)
> >> +            return dsi_ctx.accum_err;
> >
> > int ret, please. Let's leave dsi_ctx.accum_err for DSI errors only.
> > LGTM otherwise.
>
> Is this really necessary seeing how regulator_bulk_enable returns
> 0 on success anyways? It saves creating a new variable for a single
> check. In case you do think its necessary, should it be changed in
> himax_hx83102 too?

Right. I made the same choice as Tejas did when I wrote commit
a2ab7cb169da ("drm/panel: himax-hx83102: use wrapped MIPI DCS
functions"). In that commit message, I wrote:

It can also be noted that hx83102_prepare() has a mix of things that
can take advantage of _multi calls and things that can't. The cleanest
seemed to be to use the multi_ctx still but consistently use the
"accum_err" variable for error returns, though that's definitely a
style decision with pros and cons.

In my mind trying to juggle half the cases having the error in "ret"
and half in the DSI context was a recipe for getting mixed up and
returning the wrong error. On the other hand, it felt awkward using
the "dsi_ctx.accum_err". In the end I felt that the extra awkwardness
was worth it if it meant that I was less likely to "return ret" when
the error code was actually in "dsi_ctx.accum_err"...


-Doug

