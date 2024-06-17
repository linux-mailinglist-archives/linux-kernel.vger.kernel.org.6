Return-Path: <linux-kernel+bounces-218255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9090BBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77B41C23734
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA218F2E9;
	Mon, 17 Jun 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BiLsDW7i"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD418F2E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654836; cv=none; b=XwwXikGk3w8Fxj/SFEFWEZedtMc1sxUVVAOn8hV3PFIj2REbtMXr+0wJLjpjFfNymp62i03ZtR01IJzppeRb1WteUJLfmMLnaZCCc1GvnuiomY+8JZT8SHtUqwWpRJuuKnuMK1fPndA6ZA447eA8SgeWhHKy8nbyrVyHkpbN3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654836; c=relaxed/simple;
	bh=s2zJM/g9vyXju9U4Z9UniGkbGrLtR1iS2fCCS17YBeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVHdMLFOCev60dQguOD0ikVWHoMA3yN8XQzYBEomsMhSt9q7GtjfeAIf8Hev4Cl5SO3WnfOu8A/s8DRwdNYQgV3FpvMSM7GX9vAJ236VU23DZezeTxgiadjWYQgpJGynmm0rF94updNj0zu3zUTyxqOsCe01vVGGfIuXb3MlBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BiLsDW7i; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b06b78e716so29964756d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718654833; x=1719259633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpQL0yvq1dDs98zST/M1XEikwLlL17e1VjSWuuysSL4=;
        b=BiLsDW7isLfsp2DXo2v2XngWtsBAFpCCUvpS+xBgwq0mxk8dMyPhAMc391RYq1AJL+
         B4OVcddLTV8Rqay8o4BJi9uVdLwiHKYH28L8BgQ05pQ2f+lBMJl7rv5z2cf2J15S/OSO
         h+r0hVU91hZrwv3HZOx5eEHewJjkYEUofZhVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654833; x=1719259633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpQL0yvq1dDs98zST/M1XEikwLlL17e1VjSWuuysSL4=;
        b=CpB+1s7qJ+J3whYx9ODXSUWc5TpNq4eJwJuS0k40gKoM+RxW8MZfyuaTiOuaAzfdbD
         JT5+fNTYWvVXqvgVTYifQy+irP5avYN0l8rQIF2fkwJd2p6ETjc+RPPcsQZ9StrnbSkv
         RKhlmE7czI7a6Vv67fZPcNuS1PfQy61X8VNL7YlOHy14t8sEgY5gj4vWilBe3HeZ8kW/
         i9JB91DD94mmRTUYazl+I7vpM+5147zfKtoRuMnYhK8z60yh3CPn16IrjkZic9zSUKQi
         SA7lstfZTIRNbbpvix6bmZ7wdgjkd1IABCtSXXRSYAvmvTEpYXeu+FPicoNwHyOtn2VD
         IYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEm5sw4jXsjHdFMnw2C5klpSZcTrnhM7F8D2/p0F2b0xkwQ5HswU16iPvRRdz+GDnnR6S+hEVZ786CLnWEMRj7X2FDwemxWiVU839h
X-Gm-Message-State: AOJu0Yw0yNwJr6+Q1LXxtPk56rydgRYpLRqqhgNT6AazaGbww19DoetZ
	zeOfAEVqeIls1L0Ga8ckjxdG8+jRIW+CS9i3pOUD/6T9Tk3/mqwbCmhx7N/tct6biAejdUqe20k
	=
X-Google-Smtp-Source: AGHT+IFsovIVHfxR8SXuPqz/ppqNtItRosg4eLme94596nq293zvs3G0GodFl07f5Y2NLudUPxKQ/g==
X-Received: by 2002:a05:6214:a69:b0:6b0:7716:e9a4 with SMTP id 6a1803df08f44-6b2afc7747emr95246556d6.12.1718654833425;
        Mon, 17 Jun 2024 13:07:13 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5edbda8sm58524646d6.108.2024.06.17.13.07.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:07:12 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4405dffca81so171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh9m1t7ltK0YycVxScMcR6E6WOynSXZEu2nJU8sw6m9yB1tCk4wZb9U3Bp6A8tHqWuwBITBPUyY4l8U58PyPR0YDgGX34psVqdjH3X
X-Received: by 2002:a05:622a:1a17:b0:442:1b20:2a9a with SMTP id
 d75a77b69052e-4449daa1b48mr5921cf.23.1718654832085; Mon, 17 Jun 2024 13:07:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615093758.65431-1-tejasvipin76@gmail.com>
In-Reply-To: <20240615093758.65431-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Jun 2024 13:06:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com>
Message-ID: <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 15, 2024 at 2:40=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> @@ -168,48 +147,38 @@ static int rm692e5_prepare(struct drm_panel *panel)
>         struct rm692e5_panel *ctx =3D to_rm692e5_panel(panel);
>         struct drm_dsc_picture_parameter_set pps;
>         struct device *dev =3D &ctx->dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
>
> -       ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->sup=
plies);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enable regulators: %d\n", ret);
> -               return ret;
> +       dsi_ctx.accum_err =3D regulator_bulk_enable(ARRAY_SIZE(ctx->suppl=
ies), ctx->supplies);
> +       if (dsi_ctx.accum_err) {
> +               dev_err(dev, "Failed to enable regulators: %d\n", dsi_ctx=
.accum_err);
> +               return dsi_ctx.accum_err;
>         }

It would be my preference to get rid of the error print here since
regulator_bulk_enable() already prints an error message.


>         rm692e5_reset(ctx);
>
> -       ret =3D rm692e5_on(ctx);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +       dsi_ctx.accum_err =3D rm692e5_on(ctx);
> +       if (dsi_ctx.accum_err) {
> +               dev_err(dev, "Failed to initialize panel: %d\n", dsi_ctx.=
accum_err);

I'd probably change rm692e5_on() to take the "dsi_ctx" as a parameter
and then you don't need to declare a new one there.

...also, you don't need to add an error message since rm692e5_on()
will have already printed one (since the "multi" style functions
always print error messages for you).



>                 gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>                 regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->su=
pplies);
> -               return ret;
> +               return dsi_ctx.accum_err;

Not new for your patch, but it seems odd that we don't do this error
handling (re-assert reset and disable the regulator) for errors later
in the function. Shouldn't it do that? It feels like the error
handling should be in an "err" label and we should end up doing that
any time we return an error code... What do you think?


-Doug

