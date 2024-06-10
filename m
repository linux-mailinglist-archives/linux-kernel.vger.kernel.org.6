Return-Path: <linux-kernel+bounces-208438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989390252B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE607288BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC313D89D;
	Mon, 10 Jun 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6q9Xl16"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A213B5AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032503; cv=none; b=WqtCMbDu2LHxOYby7dpoRB9pTgxoaBlVJEi4JVrwL6YqI0t0NHuc6Caf614z64yd5BsQTxCJF3Mt0OPbvVxTB5Kqh2EQTMt/3eupJ7yQQARuWdqpuMJcccO9LzI5nBUq95mkFdDei6fRv3uQqE8QA0d0le1/2Dn/gFzBTZuUn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032503; c=relaxed/simple;
	bh=9PR0zCvzy8ICH7Fgb+Ht4qNGA8Q/0u+Qw+K2TG98Hxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htpORnpUTRZPzROdqWdebZf0PDhOzrrGMvXwuhTpwaxtFjlPk9hoqAEYN2EhWcgcvAYe+BkR5LB+xjixdXcYTMcTNjK1V6EJ1C5S7Aveosvz6+QMqrMerEN0Y3jqD31O/vz1kLkDtGF2FXtNekdQk5QbqTif0Ji1DBQv9v8oqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k6q9Xl16; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7953189e63aso275156285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718032498; x=1718637298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8k131QfovC2BNlbUq5Ew31XLDovv9vVvADmI61e7PE=;
        b=k6q9Xl16gGy36EkiLRGmUgmv9TKRiqYKyvnWm9JlE1IICbavddPXhKmjUEicJVYzYA
         FvHcQSAd88rRngNKXtHYil17sVVb4C/dJKX7NZT0/FsoOAZvklep0uBBKMO39qS3a7Z6
         fw8SVn5lg6iRkwii0VpXt9bHj/rldaft0PcEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032498; x=1718637298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8k131QfovC2BNlbUq5Ew31XLDovv9vVvADmI61e7PE=;
        b=bsdVMTNPBnOTwdfpDVb/+GphD1r/DNILQHxf7a+PXGa/2836V+BIaw83gBuhOxPN2e
         Rasnm5iKoGf+aAly8mUeZfNiokWsBCUezMJuSpvgUFPeD2rjpjZDA00mvr9eJjJ+M56O
         goGztWvs1rmYDVGlGi5ID3wJ+oNhySBIg/G1GAHJYXwgWhr5kkBel3C3u5jULjUIyE+6
         GZ0g4Emm5HqXTtWoW2dz4hBXsn6jaHQw4wmkOSmcuechOEkPonX0HdhXxsgQxLIc07ud
         c6EvAoaFqPptRLQTrlc0wCqwGFaBFIohpkDZey7nrhR6IBN98Qds9LDvcz0S1Qh2MuuE
         ozXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+vpi/4N9SKhqizdwWGlYcPJ9JQ1lcmntHsQ6tVnPSg3SP8ldnHzTuelNb3okqfgdGj7gPeIA0GdBbGPWaLwzVp58CAm6avUNPSQX
X-Gm-Message-State: AOJu0YzbFBp5zpMPNbxqLykQ9yUD+MQqVVODqHnwp7C5RqzzpHQv9KG1
	m/Qh9GOp/1V3GfzDKuRLjMFNvetuPnaApdSq3kkHO/V1Y6z1jcEGD73RTzJuEJL0t2kbfZ5DGmw
	=
X-Google-Smtp-Source: AGHT+IHv8znOGrL7W11ycLAqbjIcV+AxdXxQJNN5NKQx2TRoenZwBbNEJysnn4pJq9pHaYIE5ekVIQ==
X-Received: by 2002:a05:620a:248e:b0:795:15ed:1fcb with SMTP id af79cd13be357-7953c6ee86amr1187866385a.59.1718032497244;
        Mon, 10 Jun 2024 08:14:57 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955de5594dsm154352685a.54.2024.06.10.08.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 08:14:56 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44056f72257so574521cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpDOYPG4YqEXos/7TVgBGlcXw+dv/31nlXtS1k0tTlZkApM6T3q4tBkFjjr44h6f2Rc4KMwGksXpSksIPx5nFHsSuJvxqk9QsrxG+P
X-Received: by 2002:a05:622a:5986:b0:43f:f54d:8a6d with SMTP id
 d75a77b69052e-440562b2805mr6885921cf.4.1718032495826; Mon, 10 Jun 2024
 08:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com>
In-Reply-To: <485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 08:14:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZNQ8Beg7mZMNLh8FrenchGVt9SJAPdwHMZ8bPvo57mQ@mail.gmail.com>
Message-ID: <CAD=FV=UZNQ8Beg7mZMNLh8FrenchGVt9SJAPdwHMZ8bPvo57mQ@mail.gmail.com>
Subject: Re: Subject: [PATCH] drm/panel : truly-nt35521: transition to
 mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 8, 2024 at 3:57=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Use functions introduced in 966e397e4f603 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> sony tulip truly nt35521 panel.

Running "scripts/checkpatch.pl" will yell about the above. You're
supposed to write the word "commit" before the git hash. AKA:

Use functions introduced in commit 966e397e4f603  ("drm/mipi-dsi:
Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") for
the...


> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../panel/panel-sony-tulip-truly-nt35521.c    | 383 +++++++++---------
>  1 file changed, 183 insertions(+), 200 deletions(-)

The subject of your patch has an extra "Subject:" prefix. See:

https://lore.kernel.org/r/485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com

...where you can see "Subject: Subject:". Maybe use "b4" or "patman"
to help you send your patch?


> diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/dri=
vers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> index 6d44970dccd9..13472c7c37f5 100644
> --- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> +++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> @@ -44,248 +44,231 @@ static void truly_nt35521_reset(struct truly_nt3552=
1 *ctx)
>  static int truly_nt35521_on(struct truly_nt35521 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
>
>         dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
> -       mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x0=
0);
> -       mipi_dsi_generic_write_seq(dsi, 0xff, 0xaa, 0x55, 0xa5, 0x80);
> -       mipi_dsi_generic_write_seq(dsi, 0x6f, 0x11, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xf7, 0x20, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0x6f, 0x01);
> -       mipi_dsi_generic_write_seq(dsi, 0xb1, 0x21);
> -       mipi_dsi_generic_write_seq(dsi, 0xbd, 0x01, 0xa0, 0x10, 0x08, 0x0=
1);
> -       mipi_dsi_generic_write_seq(dsi, 0xb8, 0x01, 0x02, 0x0c, 0x02);
> -       mipi_dsi_generic_write_seq(dsi, 0xbb, 0x11, 0x11);
> -       mipi_dsi_generic_write_seq(dsi, 0xbc, 0x00, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xb6, 0x02);
> -       mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x0=
1);
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x09, 0x09);
> -       mipi_dsi_generic_write_seq(dsi, 0xb1, 0x09, 0x09);
> -       mipi_dsi_generic_write_seq(dsi, 0xbc, 0x8c, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xbd, 0x8c, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xca, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xc0, 0x04);
> -       mipi_dsi_generic_write_seq(dsi, 0xbe, 0xb5);
> -       mipi_dsi_generic_write_seq(dsi, 0xb3, 0x35, 0x35);
> -       mipi_dsi_generic_write_seq(dsi, 0xb4, 0x25, 0x25);
> -       mipi_dsi_generic_write_seq(dsi, 0xb9, 0x43, 0x43);
> -       mipi_dsi_generic_write_seq(dsi, 0xba, 0x24, 0x24);
> -       mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x0=
2);
> -       mipi_dsi_generic_write_seq(dsi, 0xee, 0x03);
> -       mipi_dsi_generic_write_seq(dsi, 0xb0,
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };

Please move the variable declaration above the line "dsi->mode_flags
|=3D MIPI_DSI_MODE_LPM;"


> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52=
, 0x08, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5=
, 0x80);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x11, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0x20, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x21);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x01, 0xa0, 0x10=
, 0x08, 0x01);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb8, 0x01, 0x02, 0x0c=
, 0x02);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x11, 0x11);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x00, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x02);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52=
, 0x08, 0x01);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x09, 0x09);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x09, 0x09);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x8c, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x8c, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x04);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbe, 0xb5);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x35, 0x35);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x25, 0x25);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x43, 0x43);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba, 0x24, 0x24);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52=
, 0x08, 0x02);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x03);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0,
>                                    0x00, 0xb2, 0x00, 0xb3, 0x00, 0xb6, 0x=
00, 0xc3,
>                                    0x00, 0xce, 0x00, 0xe1, 0x00, 0xf3, 0x=
01, 0x11);

Please adjust the indentation for the followup lines to match. Right
now they line up properly with the old function name, but not the new
one.


>  static int truly_nt35521_off(struct truly_nt35521 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
>
>         dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display off: %d\n", ret);
> -               return ret;
> -       }
> -       msleep(50);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };

Please move the variable declaration above the line "dsi->mode_flags
&=3D ~MIPI_DSI_MODE_LPM;"

-Doug

