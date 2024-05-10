Return-Path: <linux-kernel+bounces-176256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979EE8C2C13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FE01F21C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372A13CF97;
	Fri, 10 May 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0ssYcVr"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3396481BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377636; cv=none; b=iJtDXux50CurB6TxmC/QsF+h8lnYG+h1RxNVk0Y2XjmydafTwO6vd/6oRWypkW0yNawbBaljU55oe885LZ+hWBueEVn/s+G7LU7wwV60FH3EBD06azv3Az1Ymj6f1EzxV1JEF45C/H6OVT9IsZ0Lh00Xbi4u8vqml848sF4awy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377636; c=relaxed/simple;
	bh=PczQFVKU2g8mbrPgOSIlEjPauyxY2U7QXL7opZRlBrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu3+Kwg4ZpaJUm6xhj4mkCrYJ5/FA+ngcTy120h97NzovhQuvQr4x1WyHoWLX/ujL1FrEtxNeC0eIwvux82w9mFvOHqhEqh1FZ02s2xVKm9I7Po7llezkFUrHRAxzmYIBl9UzHH0j8QyAO+CD3D80RFtyRsNs+7aHaXm25j09ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0ssYcVr; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a04c581ee3so8670186d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377631; x=1715982431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2YIl+MQvRGvQIN5Fz+YZaIiDbAnY60xDJHXBLWCOro=;
        b=h0ssYcVr0mp7avnRe6l1YSL5ZYyCWUr3zCA+aNoiai8IW9zyKdJLJknjcpjaiOTZcV
         DVE2nqaSicl7J+/ds4yxBlzWksduGuqFowXte1kPXNhAUbvOblsXhhf+Ya9uLJkfyXJL
         3RetHPIkHDm0pRW8Q1qudffMuZkeKwTsQmcyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377631; x=1715982431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2YIl+MQvRGvQIN5Fz+YZaIiDbAnY60xDJHXBLWCOro=;
        b=Jx+cBxiCAf6f2FiEQnSQGFgrGSUZZbzOZYrCotBQLOkj3IuRULSid680G5SW4iKGHf
         bIlJL7g3L/7z7gtn0RM/6FO+Z77aWUMyxYLg/SCyjwl9Q4ESvEyDvt7QOAn10Tvl2j0z
         lkiayzuu/N2HCauqSmWLBvzbE8LDUxnrA34R01rLcrMRI7zD/6GV5DLHChDq0a38oDGD
         0J0sHiimOvnyRLDFY++CI0r3zPHWPxTSxCjepTFt/FcQDrhwu9MqVzP3Zp6aIbN6NQ6y
         JZXizfIsMy21QVEnulYtvcJHkMpLtTbbDqUclSj0R58+QZiD+8vERFQYWb3hIUgT9144
         Jilw==
X-Forwarded-Encrypted: i=1; AJvYcCUe5ISBnTqibaLrCB/OUgcXjpjaW3YdeTuLzYOi2Q94exyQcbGQ55sYCOO9Dx00l4+xJeqGhHyPwEz1qu1BkRzjLYDCVLagqmlshm5h
X-Gm-Message-State: AOJu0Yzy+kKLBs0usDnv4Ab1T6u7M/oToQD7gBIJeXOz7nFhRAnO5sA4
	yEAd4LYeSPI/U+fJrTknFx7FK9WrD5h6yjVgo6piryNfhruMS7IfnaimVwpFPPqDH3vTeDQGyyk
	=
X-Google-Smtp-Source: AGHT+IG78q2PGlEcwQqhFzPohFbbt5pSkWevJfrhLFgo//25sEVu0QOOn1jk6DHiMrxWYA5SkDC49Q==
X-Received: by 2002:a05:6214:4288:b0:6a0:c79f:b5bb with SMTP id 6a1803df08f44-6a16817c457mr48269946d6.24.1715377631423;
        Fri, 10 May 2024 14:47:11 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194d16sm20670176d6.66.2024.05.10.14.47.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:47:00 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-439b1c72676so42111cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjHQny9ucYLpv/SNs9wT6awBJ68XY7u6H1lWlKR2SW26fAAMzRsf2agY8UjYgm8WVqnRxJUsDl4C7p/9WmWbhhNHZ+f6C6WSld9wLW
X-Received: by 2002:a05:622a:5883:b0:437:c89e:245b with SMTP id
 d75a77b69052e-43e0a1d2a53mr207461cf.15.1715377619819; Fri, 10 May 2024
 14:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-5-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-5-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:46:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VG7fSNoSo61T71PdciXHPVZhUE1Gr-8_sBXXsJZ9MGiw@mail.gmail.com>
Message-ID: <CAD=FV=VG7fSNoSo61T71PdciXHPVZhUE1Gr-8_sBXXsJZ9MGiw@mail.gmail.com>
Subject: Re: [PATCH RFC 5/7] drm/panel: novatek-nt36672e: use wrapped MIPI DCS functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 3:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
> simplify driver's init/exit code. This also includes passing context to
> the init_sequence() function instead of passing the DSI device.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 587 ++++++++++++-------=
------
>  1 file changed, 281 insertions(+), 306 deletions(-)

One note is that we might not be able to land ${SUBJECT} patch since
the patch it's based on [1] doesn't have any Reviewed-by tags. Just
sayin'. ;-)

[1] https://lore.kernel.org/r/20240508135148.v4.6.I3c08a7d02c467d2bc88da14e=
513ea4c8649fce45@changeid


> @@ -381,61 +377,40 @@ static int nt36672e_power_off(struct nt36672e_panel=
 *ctx)
>         return ret;
>  }
>
> -static int nt36672e_on(struct nt36672e_panel *ctx)
> +static int nt36672e_on(struct nt36672e_panel *panel)

Small nit that I think of the variable "panel" as referring to a
"struct drm_panel". I'd personally rather this be named something
else, like "nt36672e".


>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       const struct panel_desc *desc =3D ctx->desc;
> -       int ret =3D 0;
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D panel->dsi };
> +       struct mipi_dsi_device *dsi =3D panel->dsi;
> +       const struct panel_desc *desc =3D panel->desc;
>
>         dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
> -       if (desc->init_sequence) {
> -               ret =3D desc->init_sequence(dsi);
> -               if (ret < 0) {
> -                       dev_err(&dsi->dev, "panel init sequence failed: %=
d\n", ret);
> -                       return ret;
> -               }
> -       }
> +       if (desc->init_sequence)
> +               desc->init_sequence(&ctx);
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(&dsi->dev, "Failed to exit sleep mode: %d\n", ret=
);
> -               return ret;
> -       }
> -       msleep(120);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
> +       mipi_dsi_msleep(&ctx, 120);
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0) {
> -               dev_err(&dsi->dev, "Failed to set display on: %d\n", ret)=
;
> -               return ret;
> -       }
> -       msleep(100);
> +       mipi_dsi_dcs_set_display_on_multi(&ctx);
>
> -       return 0;
> +       mipi_dsi_msleep(&ctx, 100);
> +
> +       return ctx.accum_err;
>  }
>
> -static int nt36672e_off(struct nt36672e_panel *ctx)
> +static int nt36672e_off(struct nt36672e_panel *panel)
>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       int ret =3D 0;
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D panel->dsi };
>
> -       dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +       panel->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0) {
> -               dev_err(&dsi->dev, "Failed to set display off: %d\n", ret=
);
> -               return ret;
> -       }
> -       msleep(20);
> +       mipi_dsi_dcs_set_display_off_multi(&ctx);
> +       mipi_dsi_msleep(&ctx, 20);
>
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(&dsi->dev, "Failed to enter sleep mode: %d\n", re=
t);
> -               return ret;
> -       }
> -       msleep(60);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> +       mipi_dsi_msleep(&ctx, 60);
>
> -       return 0;
> +       return ctx.accum_err;
>  }

nit: similar to other patches in the series, the callers of
nt36672e_on() and nt36672e_off() should be able to get rid of their
error prints.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

