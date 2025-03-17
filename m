Return-Path: <linux-kernel+bounces-564597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FFEA657FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8B163E13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5119D09C;
	Mon, 17 Mar 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYufZBM8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209E17A2E9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228832; cv=none; b=avzlVRoRF1/Y3uIoQn9+RISZIWzluxMV8uMbCuNjn6tr30tHqJ6GkbW+arWozTYoVxmqwR5inrv3wzXht8KEJxgg3vqNkAEGVVO8aFWTThnt7RCSJ2WTVcWUkq6T4OuM3HYDWe21GMW3ETZlqZ+Bg1cf1Coqbr1HIOFjtZ1vmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228832; c=relaxed/simple;
	bh=lBOGSdxpn7jqeZbA3P/MADGdmeM1ewsl4IppL+NykdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwUt1HRAjD2slh7mWcXWGm6ImqZL1hXYjid1kDFRoBg8UVps4Rhtci85QW7xEC+mrpWwA9ZYGLez5l0Y+VBL0Y/fEsghVciC92PGIiYuNDCtFRmhcj/shrlL45PvG9mYAhF+pcdmWhUI7wVMIRNUB5PBHmZhjAWINLlH1V/IUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OYufZBM8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so59093741fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742228828; x=1742833628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9th5vgX4dWb9XCR4ZHNIQSuw33Mm+jd8Ej6CRSdV6U=;
        b=OYufZBM8quHR3jk3yXVwMWVOsDWg9rOEnfUfzln0rOJN25jK3gClkxUmCNwQ4twXEk
         NYAJ2x2Bn+5Qw5qvxwCA3LyRjZ3nD4wARQy+MUYjJCJE5V8RUMWciE9jdD8jqLvd/pKT
         vJCe5cUGoM3Gz0y42SjfbWqP/35zLCNpa9hSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228828; x=1742833628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9th5vgX4dWb9XCR4ZHNIQSuw33Mm+jd8Ej6CRSdV6U=;
        b=K0vXMKuUmvcqV5jEuUzpQUPTeHLcif2TG47vWDCfRx7PjUv3aWeb+kVAS0ZgOKgOBz
         YfoWFj/jTqUPNVECXVzEElbEbAWCxKMiQhIdntEvhe2fCIu/3FrUIUI+X3yVldCi1kwI
         1CxPb/Gmguz94DfwVPUSWSIVeleYNBqPF9aFr0jbaAITMvWWCOEu7I1o5SQShGA0HpGP
         k9IMKTuRcXdie1hz+5SRYZkyLLCPnU4WQiI0IXkzx1gWHgF0LkkrVt2riYCsLuy2Ewar
         8OSKTLxI5TyCGefwx0oK6eWMzvvInSw8uE2b7Jrs3J27AXqHyxc5Sf0Y+BJL3BKilODm
         wQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGRTPY/ydsiIYqCMqhaBM+lKn7PAWUvWtDbaVtNL53Bdi7TMg5PPr/CwwBYDoRMx3vvLx58gLRsoha5w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoC7WV5iByGX49rDj1OT9Mkhst4BNG+kufcVZBleMrMK2vKoJ
	+qdb7Ch392gBcD9HSmNR9PfukfmExj0KX7BWB1hjgPu5JA3B8scnriCjneL3EcPGz275DEx8Kce
	E1w==
X-Gm-Gg: ASbGnctum1gvRW7Ez6WVoFEv8L7ds6gOIv0k+3U9pMQ8i1JrU19zPbBN2BxZlVgn2/C
	ntf3WKZA2/6V4cB/vRKEXmwSltMesaSafgwIaq+35/KyB8VIIH2NwYD61J6jgfuUhWlQvkWm+0w
	6pTIzEpVPb1oZ5XeS5Vk9YT76at1ya7ViMFHAgCj3HVesOI7rSm0BZx6ZtdrwMeyBoxmNgj7e3c
	wKpidIxRvLPb10rkWkXWRXyX8dkTZeRvOmPu8acNrXWTQOmvY/UhmsPN8Lg3KJ0nmP4kFfww+yQ
	Ymb7yoBkQjtM9oyv6zV7sC+KAdctsyz76d4E+wJSr3yIHk46GRESV25XqHKVmxkzD9eRtAkk4+n
	Uq8P5plE0
X-Google-Smtp-Source: AGHT+IFhLpE4SzKO7ipJyzpUxicdo/Ndqd7bPjt8QPO/rEVMzyGxDaK33et3CxFhysc4409Fy5xk5A==
X-Received: by 2002:a05:6512:281a:b0:549:4ca4:504a with SMTP id 2adb3069b0e04-54a304713b4mr123460e87.4.1742228827559;
        Mon, 17 Mar 2025 09:27:07 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c192bsm1349742e87.89.2025.03.17.09.27.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 09:27:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54991d85f99so5855893e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:27:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUp4+Jfp1aUPcSEP1XCR7tU2a7Wnnq3byHUbpjX7F+U3HWoVgFeyF8PfxpnVNvZbIezqGIR169Gi1fS0nk=@vger.kernel.org
X-Received: by 2002:a05:6512:1244:b0:549:903d:b8d8 with SMTP id
 2adb3069b0e04-54a30475b3emr112201e87.8.1742228826202; Mon, 17 Mar 2025
 09:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316045024.672167-1-tejasvipin76@gmail.com>
In-Reply-To: <20250316045024.672167-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Mar 2025 09:26:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xk6hYmJGLhW2ruvWwOETfmCAQX000WX4LrC3CPCZJMJQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrBrTk4sVBXsj3dmm7M114VmKW881GUc4grvUi98QYdB5nlyFUkRHGglwY
Message-ID: <CAD=FV=Xk6hYmJGLhW2ruvWwOETfmCAQX000WX4LrC3CPCZJMJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	aweber.kernel@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 15, 2025 at 9:50=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> @@ -62,93 +62,66 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>         msleep(50);
>  }
>
> -static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
> +static void s6d7aa0_lock(struct s6d7aa0 *ctx, struct mipi_dsi_multi_cont=
ext *dsi_ctx, bool lock)
>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       if (dsi_ctx->accum_err)
> +               return;

nit: I don't think you need this extra check, do you? The entire
function is "multi" calls so just let them be no-ops. It may seem like
an optimization to have the extra check at the start of the function,
but it's better to optimize for the "no error" case and let the
"error" case be a little slower.


>  static int s6d7aa0_on(struct s6d7aa0 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
> -       ret =3D ctx->desc->init_func(ctx);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +       ctx->desc->init_func(ctx, &dsi_ctx);
> +       if (dsi_ctx.accum_err < 0)
>                 gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -               return ret;
> -       }
>
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display on: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>
> -       return 0;
> +       return dsi_ctx.accum_err;

Not something new to your patch, I wonder if the setting of the reset
GPIO should actually be _below_ the call to turn the display on. Seems
like if that fails you should also be setting the reset GPIO. That
would be a change in behavior but seems more correct?

Given that it's a change in behavior, I'd be OK w/ leaving it as-is or
changing it (and mentioning it in the commit message). I'd be curious
if anyone else has opinions here.

...oh, actually, you should just delete the reset GPIO stuff from this
function. The one caller of this function is already setting the reset
GPIO, right?


Everything else looks good to me.

-DOug

