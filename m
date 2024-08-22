Return-Path: <linux-kernel+bounces-296622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA795ACE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C65B21516
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2048955885;
	Thu, 22 Aug 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOXmH8En"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570F2E3EE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304755; cv=none; b=MYlOZEcMKQZZcaFIw98ryIlRyFdM9ysLqh7Vfmh03LqmM8ggLQzA0vX9qjc+LTypzBa0euKuLIR4K3qGSMXRrUf6e89leFa/2JO64iUFlYfeMly3qpb3p6SyweuXTOjIGFba6FGg0/0mj0HzvIQ49rvOgCe2wHbwcF++/DMZJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304755; c=relaxed/simple;
	bh=oGuBlGASeDM0PAhYo5Tsh4jwNm5LAU+oys0vcLq7MUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO5725dyPBvQCUUJRKffSJ+aN5ygwJhRM6+BLANCK+vb1ei38w8MLgxp7fXuQ+eJPnYPJr3HSFvSrWbbmtAV/A2xxeJgLS8ejSkLxsBufdWzj6A1cOeK7CguvJAa5cvQsWkH8RF5ALxm289ocbBXg005GtdBQDaxnJP5UbxYRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOXmH8En; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dc16d00ba6so253980b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724304752; x=1724909552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UrNcon8FxQ69dF6b3a0HOOhGowvaUdP7iX4oRD7w0ns=;
        b=ZOXmH8EnQjdASTiK5D+yrZs2L4NKnbuhzb0IpfADSF+2l8xucewyvQNth8d+M4+QCG
         x1KfCwsBp9a6THUe0kBfsOOtrALU+BDJtX2HeTSGT82OinBgo900qmlCjgfSJ7WHulBk
         jCmcK49AG1LEgfEMzgEElcczvVkeV23pTIRUIIxFRWd57LPgp1NusPn4uqtB4zDCqOXk
         EcfbiRDZGvx7HoGkCxoI5mGVBeoNSRFEaVkVCbRgOEPZ1+YVrCrLnW6+iEJRCWhfoALp
         LVKQnuLaLpaB1Ts0VwXgoQyrZsWbIdPSfSrpcqOxF1DduT38oIAqV+ffAQaRUNimz7wf
         v3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724304752; x=1724909552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrNcon8FxQ69dF6b3a0HOOhGowvaUdP7iX4oRD7w0ns=;
        b=CjdcfUTB2iM/OAUMw8YxKpK0HArvgCK8uG5x/V5lyDUjzg5Pz9pNJ2lXovmwfMnbJF
         Fv/0+YLdnHzrC6nfPMcX2RXguRw6eVTKpU/0z9gZxFoCqV1gFFFVrMzJaLhP+eoQAv9s
         vbNa4pbQBZhELf2wFE3lc9G7WmFh8JiGRJPz7jL/rICixR5HIC7pvDA5jD1W/Uetk0eB
         SqBsbOIzq7TtzzEU/irlJcu8A7txMBP3B5KqUfyD86l8kltULayWlp+LE6kjX1OHcSB6
         +ewSW8HEzCBLQaqPAVCTBdYi8Bbv137lEapW7p11/SYam+zIhqimw9UIA5gzgZ+m1GNc
         BFpw==
X-Forwarded-Encrypted: i=1; AJvYcCUgqrFM8VDxzkH4YdlhT7kB8k22bXt9rz8EpiL1KiwpSPgOydd8pB3fkimGdTuhogKnLyD8X+HuYw7/3vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIM5cNz+UYE9GtGnHpkudsxj6rSd5CITfARqUdMcdTnSn62ECb
	XjOfYc9bydAir0w9TlGurFQ5Upul9MLa5raKpbi7bDxj/fakdPWQZaGIh7QvAOWDjPAtezc4WJF
	aJrn8LNSWX/qad40ZEJXtZ5iZm1U=
X-Google-Smtp-Source: AGHT+IF8wUe9zW9RcIEjiBnPyx9kIJJy5aif9535MDtTffLfG4WtqgzHMWlBveNmITDMjDwayfjZPgCEac3kl0Nqkbg=
X-Received: by 2002:a05:6870:3924:b0:260:f5ab:62ff with SMTP id
 586e51a60fabf-2738bebec4emr4674262fac.44.1724304751615; Wed, 21 Aug 2024
 22:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820125840.9032-1-rongqianfeng@vivo.com>
In-Reply-To: <20240820125840.9032-1-rongqianfeng@vivo.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 22 Aug 2024 11:02:16 +0530
Message-ID: <CANAwSgR8i2BbNkQtDXTWi+kOfWtxwHe9E=sLa_8ZSU2bvTO-Yg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: Use devm_clk_get_enabled() helpers
To: Rong Qianfeng <rongqianfeng@vivo.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

On Tue, 20 Aug 2024 at 18:30, Rong Qianfeng <rongqianfeng@vivo.com> wrote:
>
> Replace devm_clk_get() and clk_prepare_enable() with
> devm_clk_get_enabled() that also disables and unprepares it on
> driver detach.
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 13 +++----------
>  drivers/gpu/drm/sun4i/sun6i_drc.c         | 15 ++++-----------
>  drivers/gpu/drm/sun4i/sun8i_mixer.c       | 13 +++----------
>  3 files changed, 10 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index ab6c0c6cd0e2..057dceaf079e 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -284,16 +284,11 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
>                 return PTR_ERR(fsl_dev->regmap);
>         }
>
> -       fsl_dev->clk = devm_clk_get(dev, "dcu");
> +       fsl_dev->clk = devm_clk_get_enabled(dev, "dcu");
>         if (IS_ERR(fsl_dev->clk)) {
>                 dev_err(dev, "failed to get dcu clock\n");
>                 return PTR_ERR(fsl_dev->clk);

You can use dev_err_probe it will be fine in all cases for clocks.to
get enabled.
         return dev_err_probe(dev, PTR_ERR(fsl_dev->clk),
                                "failed to get duc clock\n");

Thanks
-Anand
>         }
> -       ret = clk_prepare_enable(fsl_dev->clk);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to enable dcu clk\n");
> -               return ret;
> -       }
>
>         pix_clk_in = devm_clk_get(dev, "pix");
>         if (IS_ERR(pix_clk_in)) {
> @@ -311,8 +306,7 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
>                         div_ratio_shift, 8, CLK_DIVIDER_ROUND_CLOSEST, NULL);
>         if (IS_ERR(fsl_dev->pix_clk)) {
>                 dev_err(dev, "failed to register pix clk\n");
> -               ret = PTR_ERR(fsl_dev->pix_clk);
> -               goto disable_clk;
> +               return PTR_ERR(fsl_dev->pix_clk);
>         }
>
>         fsl_dev->tcon = fsl_tcon_init(dev);
> @@ -341,8 +335,7 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
>         drm_dev_put(drm);
>  unregister_pix_clk:
>         clk_unregister(fsl_dev->pix_clk);
> -disable_clk:
> -       clk_disable_unprepare(fsl_dev->clk);
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/sun6i_drc.c
> index 0d342f43fa93..f263ad282828 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_drc.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
> @@ -42,33 +42,28 @@ static int sun6i_drc_bind(struct device *dev, struct device *master,
>                 return ret;
>         }
>
> -       drc->bus_clk = devm_clk_get(dev, "ahb");
> +       drc->bus_clk = devm_clk_get_enabled(dev, "ahb");
>         if (IS_ERR(drc->bus_clk)) {
>                 dev_err(dev, "Couldn't get our bus clock\n");
>                 ret = PTR_ERR(drc->bus_clk);
>                 goto err_assert_reset;
>         }
> -       clk_prepare_enable(drc->bus_clk);
>
> -       drc->mod_clk = devm_clk_get(dev, "mod");
> +       drc->mod_clk = devm_clk_get_enabled(dev, "mod");
>         if (IS_ERR(drc->mod_clk)) {
>                 dev_err(dev, "Couldn't get our mod clock\n");
>                 ret = PTR_ERR(drc->mod_clk);
> -               goto err_disable_bus_clk;
> +               goto err_assert_reset;
>         }
>
>         ret = clk_set_rate_exclusive(drc->mod_clk, 300000000);
>         if (ret) {
>                 dev_err(dev, "Couldn't set the module clock frequency\n");
> -               goto err_disable_bus_clk;
> +               goto err_assert_reset;
>         }
>
> -       clk_prepare_enable(drc->mod_clk);
> -
>         return 0;
>
> -err_disable_bus_clk:
> -       clk_disable_unprepare(drc->bus_clk);
>  err_assert_reset:
>         reset_control_assert(drc->reset);
>         return ret;
> @@ -80,8 +75,6 @@ static void sun6i_drc_unbind(struct device *dev, struct device *master,
>         struct sun6i_drc *drc = dev_get_drvdata(dev);
>
>         clk_rate_exclusive_put(drc->mod_clk);
> -       clk_disable_unprepare(drc->mod_clk);
> -       clk_disable_unprepare(drc->bus_clk);
>         reset_control_assert(drc->reset);
>  }
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index bd0fe2c6624e..ebf00676a76d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -507,19 +507,18 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>                 return ret;
>         }
>
> -       mixer->bus_clk = devm_clk_get(dev, "bus");
> +       mixer->bus_clk = devm_clk_get_enabled(dev, "bus");
>         if (IS_ERR(mixer->bus_clk)) {
>                 dev_err(dev, "Couldn't get the mixer bus clock\n");
>                 ret = PTR_ERR(mixer->bus_clk);
>                 goto err_assert_reset;
>         }
> -       clk_prepare_enable(mixer->bus_clk);
>
> -       mixer->mod_clk = devm_clk_get(dev, "mod");
> +       mixer->mod_clk = devm_clk_get_enabled(dev, "mod");
>         if (IS_ERR(mixer->mod_clk)) {
>                 dev_err(dev, "Couldn't get the mixer module clock\n");
>                 ret = PTR_ERR(mixer->mod_clk);
> -               goto err_disable_bus_clk;
> +               goto err_assert_reset;
>         }
>
>         /*
> @@ -530,8 +529,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>         if (mixer->cfg->mod_rate)
>                 clk_set_rate(mixer->mod_clk, mixer->cfg->mod_rate);
>
> -       clk_prepare_enable(mixer->mod_clk);
> -
>         list_add_tail(&mixer->engine.list, &drv->engine_list);
>
>         base = sun8i_blender_base(mixer);
> @@ -592,8 +589,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>
>         return 0;
>
> -err_disable_bus_clk:
> -       clk_disable_unprepare(mixer->bus_clk);
>  err_assert_reset:
>         reset_control_assert(mixer->reset);
>         return ret;
> @@ -606,8 +601,6 @@ static void sun8i_mixer_unbind(struct device *dev, struct device *master,
>
>         list_del(&mixer->engine.list);
>
> -       clk_disable_unprepare(mixer->mod_clk);
> -       clk_disable_unprepare(mixer->bus_clk);
>         reset_control_assert(mixer->reset);
>  }
>
> --
> 2.39.0
>
>

