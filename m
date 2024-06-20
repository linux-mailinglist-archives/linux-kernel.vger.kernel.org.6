Return-Path: <linux-kernel+bounces-222878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250A910912
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FAD1C20CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCDB23774;
	Thu, 20 Jun 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guMoXxaw"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DF1AE0B3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895283; cv=none; b=RajD5lWRP/RSN/w8M2bXbhj398A69hZdehDaS3C90ed6HQVWokVz+gFBMxlD1Shp0JQ4dfXEhFXvENmKq9N/jppjxH5x6Y6Qgm3z1Bblt6f5C07O9RYpZ4GE4KGwW8x8IoF6kEhWs9XtyXmH+Q8zOyJuWihUvcPdulZG3Wf6KMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895283; c=relaxed/simple;
	bh=a6jtFV0GRFPJfbicWsU7u3WpmytnPitMFmbPZlvY/KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqoOgATbROaIP/hIChuDePx/RC9mYXb8Xe8CYVGbwzcNY7io6+FE/t26r48h9XX2Denm6UoERm/AJwfJ9hHtfFz7kUW30AbA+d2Di2eeQZ0em3UQzamdb8ymXz6KjiFGnXwlap97veYv+JYmwStI0POKGBNpIdERlJZSr90mngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guMoXxaw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63bf3452359so9899977b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718895281; x=1719500081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UZg6z2ZV7fEWVr/cuuO7y2J8t4KdG2GG3PzRAtJBxs=;
        b=guMoXxawyFHr+KoTkwC9X3OwIeDrwGtxfZGO3rUCC843BJXSPhX66NRWVZFtMnb56+
         ukNA2Qw4sr+7R1Zx50NCyLfxC22VD6pozTh9bkSlWobubnXFJ8vuO/4NTkVtI2RirPiV
         ndxO6TfBzlKebc3i+dQssFIiUDj1JZo0tJVx677z/BqmPOxJ384Ilm4NoP7j12vcUzlN
         tLDAHkEC5DFt4puDU8lHLEguqvLlbWCYObYjNR9d2Ffk5CtbL0X1bdBUqRCM3CSnXm+x
         JS1RQW0q+QJSTBZCGeYhS7flfjNeTYn+P7b/XXI16z4pEzETiW2PvMEwEt3H02mivEdP
         KQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895281; x=1719500081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UZg6z2ZV7fEWVr/cuuO7y2J8t4KdG2GG3PzRAtJBxs=;
        b=Kjp4gHjQe6wgximMhZ/k1UiK61PI6fVuzEZJPeu6aYKjoHrvatg4dhSYxDpOSTN1RU
         Qy5Oy9qdmOYuzvo5h31uSmmYaYS0LrHwn64wtYK4BZ1hIHngghbtoZRqArAJh8yNdtdm
         VUPcwoJXAX4+9UgeDcdAvv3bJ+gF7aUOvcoHyBkdxQZ7RVtDLpriqGbiVzGDwMniZhXP
         gAKBbl3NU159oC1Gtz0UQWcDwijY5R7rPxOVz5F8BdzVyc+tIGe22EWrX+D1NXDnoB5m
         yB3zMCxp2Ys2/jw+4grvJNRmqMzfsO2NVb73Dstbcv0+DprbedK/TlLnBX5JTZDga2tU
         2fFg==
X-Forwarded-Encrypted: i=1; AJvYcCUtq5y2TBM3Xr0s2kqJwz2zJ4v88QpWHdI/gzRW1FJpuObFfiY9fcF+4rvy3ltBCfuL6aEtY6XEEpKpXKdHro7R+EiEagqiMSbxTDAM
X-Gm-Message-State: AOJu0YwSZ6nSvKNFFBNPgvRh1MMY7rWsgkzb0ukkcEvSPBzkEsBHvTGt
	gH6eBsF1Fv0pQNeFn3o5GO9r0Qjz9AwzCehDKa/OKNccJFkhHaEyQy6dIyPifNgrS5YoARDSjK5
	TzSrkYJOM+X2V1p6q+tPVtoGAEMiWo+h6BGQAwg==
X-Google-Smtp-Source: AGHT+IEEEALjTBQPo0s0Uauc0UaOOzy70kfdrSt7ddTWFNqet+lDyn9cqCJ27AkvRYxTAqRJyw/n1fgD1JSmJCuDlS0=
X-Received: by 2002:a0d:f484:0:b0:61a:d846:9858 with SMTP id
 00721157ae682-63a8e1dacb1mr58152777b3.20.1718895280821; Thu, 20 Jun 2024
 07:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619033351.230929-1-tejasvipin76@gmail.com>
 <mozxxkpqlboh2w7bf55bezgcy5b2jfgepmgullgd24dtmwfva2@mghwg3c5an5y>
 <a9312102-44c1-4529-b3ef-a7831392c42f@gmail.com> <CAD=FV=VJA5R1SKZe1vmRWc4=GXPbFOsT3gdj+x9cwR7YCQ8GfQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VJA5R1SKZe1vmRWc4=GXPbFOsT3gdj+x9cwR7YCQ8GfQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Jun 2024 17:54:30 +0300
Message-ID: <CAA8EJpr_HYkXnP3XR9LpDhi1xkQfE_CKJzfzGrO5qd_pQYtiOw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 at 17:42, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jun 19, 2024 at 12:23=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.=
com> wrote:
> >
> >
> >
> > On 6/19/24 12:06 PM, Dmitry Baryshkov wrote:
> > > On Wed, Jun 19, 2024 at 09:03:49AM GMT, Tejas Vipin wrote:
> > >> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Intr=
oduce
> > >> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> > >> ("drm/mipi-dsi: wrap more functions for streamline handling") for th=
e
> > >> raydium rm692e5 panel.
> > >>
> > >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >>     - Change rm692e5_on to return void and take mipi_dsi_multi_conte=
xt
> > >>       as an argument.
> > >>     - Remove unnecessary warnings.
> > >>     - More efficient error handling in rm692e5_prepare
> > >>
> > >> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@=
gmail.com/
> > >> ---
> > >>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++-------=
---
> > >>  1 file changed, 99 insertions(+), 138 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers=
/gpu/drm/panel/panel-raydium-rm692e5.c
> > >> index 21d97f6b8a2f..9936bda61af2 100644
> > >> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> > >> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> > >
> > >>  static int rm692e5_prepare(struct drm_panel *panel)
> > >>  {
> > >>      struct rm692e5_panel *ctx =3D to_rm692e5_panel(panel);
> > >>      struct drm_dsc_picture_parameter_set pps;
> > >> -    struct device *dev =3D &ctx->dsi->dev;
> > >> -    int ret;
> > >> +    struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi }=
;
> > >>
> > >> -    ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->s=
upplies);
> > >> -    if (ret < 0) {
> > >> -            dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > >> -            return ret;
> > >> -    }
> > >> +    dsi_ctx.accum_err =3D regulator_bulk_enable(ARRAY_SIZE(ctx->sup=
plies), ctx->supplies);
> > >> +    if (dsi_ctx.accum_err)
> > >> +            return dsi_ctx.accum_err;
> > >
> > > int ret, please. Let's leave dsi_ctx.accum_err for DSI errors only.
> > > LGTM otherwise.
> >
> > Is this really necessary seeing how regulator_bulk_enable returns
> > 0 on success anyways? It saves creating a new variable for a single
> > check. In case you do think its necessary, should it be changed in
> > himax_hx83102 too?
>
> Right. I made the same choice as Tejas did when I wrote commit
> a2ab7cb169da ("drm/panel: himax-hx83102: use wrapped MIPI DCS
> functions"). In that commit message, I wrote:
>
> It can also be noted that hx83102_prepare() has a mix of things that
> can take advantage of _multi calls and things that can't. The cleanest
> seemed to be to use the multi_ctx still but consistently use the
> "accum_err" variable for error returns, though that's definitely a
> style decision with pros and cons.
>
> In my mind trying to juggle half the cases having the error in "ret"
> and half in the DSI context was a recipe for getting mixed up and
> returning the wrong error. On the other hand, it felt awkward using
> the "dsi_ctx.accum_err". In the end I felt that the extra awkwardness
> was worth it if it meant that I was less likely to "return ret" when
> the error code was actually in "dsi_ctx.accum_err"...

Fair point.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--=20
With best wishes
Dmitry

