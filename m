Return-Path: <linux-kernel+bounces-245023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8A92AD1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F96828159F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CC2AE69;
	Tue,  9 Jul 2024 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZPnhvpM1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5628399
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484892; cv=none; b=CuEO4gbxCQizKD9bcy0oFmtq27iedoBkIAPiP4SojY5PeXFmQWIUSwmp+C3XUwbP7ABDku8/j5euploYApNoM/0eWvWzGMEtsIF2B3AD+Ho8SyWoRB8aLFisbXvYXxBuoo+CwaDK/yOyh1bNCUOZfobyWLq3RL/YTrxT599mtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484892; c=relaxed/simple;
	bh=IsZ6oW7Trf+eW/3lDR+xG2zNK36LG6LP59CDpe+n3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKvfMMcW81b7CpTe6SW8fi/kL4QWdFkOYdFEaZ2s+KVC4IHXH0H55JFxOYOLO/K2j29nIHiorezpcktp4JgCprblGqdGQGSwQytGKGHXlTvwt5rddTBfCuLf97ZSg+Y/90sQiBxp5Oip58mG7K/8oUeU+GkeKclJncZwYvp0eN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZPnhvpM1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e04196b7603so760136276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720484886; x=1721089686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYM3zw5Ilnu3cOqCw9QUJr0rFrT7FZCvEIIlOa+MUGg=;
        b=ZPnhvpM1WBQWuqvSHmlSpkGpvGbagNItv0FZyzPm6lJsL2Pkzgi+pORceCEWp3FP0x
         PkKoX0znyewdZvs6YuRH7yBP00WZpWADuVuQhZ6ZZAXCVt4c1IidQtEgjjCNK+RTR3Tn
         DvmbTgAx4Ym/5OjdSHCtwwr6v+744HFtOL3vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484886; x=1721089686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYM3zw5Ilnu3cOqCw9QUJr0rFrT7FZCvEIIlOa+MUGg=;
        b=PTLd0QsLqyjc6qa7oejiQvLV2FyO2HRyIdnQlzCX5k98Kwhcgg0YCgQ3bmRBhpq90T
         UnVrUNmH0gxHlyUptUAcVg+5ATvc6iGYX0bMQrnTqdEpQ8twWc2g54tYVsNSjxWDe6Wo
         JLZ39lvpqhCthF5g8/ga0nTHnLHek4Dr8R2hsm8ofpab7S3amb45bEmuNpruuNHyDRm/
         LEmcg2xxAbhcXnMPXYNJOQ5vf6V+QfusRfvGXg3jycadD0Pjpdn8U/5mocpe+LIWiSax
         0T5QjaC85d5j+caB82K9wMGBDu6Z/ZlcwjP1D7P+JVNoQwwD1cv5QQncZzubK/nDFgkU
         pZZA==
X-Forwarded-Encrypted: i=1; AJvYcCWblkjyCL3mcdLAwhfe7zFatdNSEAWxVMHaDb7UgYlDqKl0kJy5m+mO5NdqhKScK8j+fhzSP+eEBC1c9qzRIc0l7eJ66S2Svz3yRI1O
X-Gm-Message-State: AOJu0YyY3EDj86Bl9BsJ9xp79+nn+X9yAR1LmV2k4QJak1UD8x5qu0QD
	Agjto1sgcB2kMi9nsV1OfaeojcE4Kc/RAp9mXXRDZevlZXiPEQlN1OncXT+uAcl7Nt1dDvdmWqL
	m/U1Z
X-Google-Smtp-Source: AGHT+IF38fAeYNCBTDccs4Raa0u1u/PZvGqzsc7Q8HkmO25bPvuXBIxX429jEWY216jXLPAETevyNg==
X-Received: by 2002:a25:3187:0:b0:dff:3058:e30f with SMTP id 3f1490d57ef6-e041b0597bamr1347037276.21.1720484886413;
        Mon, 08 Jul 2024 17:28:06 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4c0dsm4241706d6.15.2024.07.08.17.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 17:28:03 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44664ad946eso62751cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXl9FgTCSZsFbPPt9jTI5xcu+yMCMuAor4go1C21MjHCogjmwjw0JJDSAvVYR7d2ZXIuTusqlLSkgBazWowtciMkz1irNDTebTvqJ5M
X-Received: by 2002:ac8:7a83:0:b0:447:ed90:7396 with SMTP id
 d75a77b69052e-447fba65e4cmr1638641cf.24.1720484883356; Mon, 08 Jul 2024
 17:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628182428.171031-1-tejasvipin76@gmail.com> <20240628182428.171031-3-tejasvipin76@gmail.com>
In-Reply-To: <20240628182428.171031-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 17:27:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=YJu-QS9qck-Q89UxwEEfitJHyk6-gGX7zCGNz9xF0w@mail.gmail.com>
Message-ID: <CAD=FV=U=YJu-QS9qck-Q89UxwEEfitJHyk6-gGX7zCGNz9xF0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: startek-kd070fhfid015: transition to
 mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 28, 2024 at 11:25=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> @@ -52,92 +52,63 @@ static inline struct stk_panel *to_stk_panel(struct d=
rm_panel *panel)
>  static int stk_panel_init(struct stk_panel *stk)
>  {
>         struct mipi_dsi_device *dsi =3D stk->dsi;
> -       struct device *dev =3D &stk->dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D {.dsi =3D dsi};
>
> -       ret =3D mipi_dsi_dcs_soft_reset(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to mipi_dsi_dcs_soft_reset: %d\n", r=
et);
> -               return ret;
> -       }
> -       mdelay(5);
> +       mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
> -               return ret;
> -       }
> -       msleep(120);
> +       if (!dsi_ctx.accum_err)
> +               mdelay(5);

I'm curious: why isn't the above just "mipi_dsi_msleep(5)" and get rid
of the "if" test?


> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>
> -       mipi_dsi_generic_write_seq(dsi, DSI_REG_MCAP, 0x04);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_MCAP, 0x04);
>
>         /* Interface setting, video mode */
> -       mipi_dsi_generic_write_seq(dsi, DSI_REG_IS, 0x14, 0x08, 0x00, 0x2=
2, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, DSI_REG_IIS, 0x0C, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, DSI_REG_CTRL, 0x3A, 0xD3);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_IS, 0x14, 0x08=
, 0x00, 0x22, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_IIS, 0x0C, 0x0=
0);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_CTRL, 0x3A, 0x=
D3);

nit: While touching these lines, it'd be nice to transition them to
lower case hex (3a vs 3A).


> -       ret =3D mipi_dsi_dcs_set_display_brightness(dsi, 0x77);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to write display brightness: %d\n", =
ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x77);
>
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> -                              MIPI_DCS_WRITE_MEMORY_START);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DIS=
PLAY,
> +                                    MIPI_DCS_WRITE_MEMORY_START);
>
> -       ret =3D mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set pixel format: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
>
> -       ret =3D mipi_dsi_dcs_set_column_address(dsi, 0, stk->mode->hdispl=
ay - 1);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set column address: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, stk->mode->hdi=
splay - 1);
>
> -       ret =3D mipi_dsi_dcs_set_page_address(dsi, 0, stk->mode->vdisplay=
 - 1);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to set page address: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, stk->mode->vdisp=
lay - 1);

Nice to get rid of all of these special case "if" tests and error handling!=
 :-)

optional nit: it feels like there are two many blank lines separating
single line statements. Maybe get rid of a few of the blank lines?

>
> -       return 0;
> +       return dsi_ctx.accum_err;
>  }
>
>  static int stk_panel_on(struct stk_panel *stk)
>  {
>         struct mipi_dsi_device *dsi =3D stk->dsi;
> -       struct device *dev =3D &stk->dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D {.dsi =3D dsi};
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0)
> -               dev_err(dev, "failed to set display on: %d\n", ret);
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>
> -       mdelay(20);
> +       if (!dsi_ctx.accum_err)
> +               mdelay(20);

Like above, not sure why this isn't mipi_dsi_msleep(20).


-Doug

