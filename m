Return-Path: <linux-kernel+bounces-232420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447391A8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570691C20BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01F195814;
	Thu, 27 Jun 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdEtE9y3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486A188CC6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497194; cv=none; b=QSwhw8P78sk+qIXhHAVm52Bq6oF/4TE3w7S9QdGvNTcpYad/916Ha3uftN3lU9oawGFrcLDynEE+1hGKjipJIJuvxkzJlmuABUL/hRGeP7+t1TCpWlx7v7dW4X0zfbIrg0UOGTGOufftSt34NMUYph0ecIVmsjtNggSZ4XA7DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497194; c=relaxed/simple;
	bh=TE6rn4Ih44MSAjx5J6Tc55I16zqSK3OeJqhbd6MwgGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ene1ixm+5M9g3yLAF0Yd4MzHW83BTOEhXbzNRlXg/B9GsTX+GfeZ0eyJmrk56QIjOIOa4lXjfVSfJpaO7uipY5rlYImSeowc1BjHmfUVif0TyTVfUEOP+cvO1u9bVhp6F3TKOPjPaDjmBrt7pRcithe2HzHmEUcDzDk3GpaDCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdEtE9y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F1C4AF0A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497194;
	bh=TE6rn4Ih44MSAjx5J6Tc55I16zqSK3OeJqhbd6MwgGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NdEtE9y3Hp/lRxVSp/C33bUq6oDb2MGeRUXqlk8mfedRjkkZBqA30uBHw17KGU21E
	 MeD4GaobzQ2mdFzIZFVZk5zE2JwCkjngZYmBxaFGvsZ65jvXAVf3HiLnqVZfx9tskb
	 kd2nEX9PEv2qyy1PHY/DrDZzxtXq/FQvCM9TovbbEJA1UmOM7WclN3iJWWccwFugVg
	 J9v0/dVWKgNWihiv4J2W1X3gaMZt9qPuGbZ+1ddmbtu9Zkw73Epe9qTbnaYTLKAO8K
	 oIN/WIJr76hp/nZEQ/Qx8m79v5lLQPanVmzoQUYPtD5FsdJQRMXX+UjmG4LSxwwrsR
	 0T1q/yptOkgUw==
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706524adf91so4959690b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:06:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLvwh90f/i2MhZ2ga2LB9yzYAfHC0H5EWVpg++v4BOGyCtCcsdqhaHN0nZWdry7/eaW5pA1mxEHn7WqPboz/pvqiIBWMQArDIP8npJ
X-Gm-Message-State: AOJu0YxFVD7piT7yDUT5RQvl+I9jv6lhthGyqC9rgOLD1NkGL8OijaLT
	X41lhNNw1BCF+pMN16i+KWahAIMUCLkcbj7I19tC2vA67A7hksLWPOlx3xPHfGLBs4B8RPVzIiM
	wAy3xztgeDSRC83zG77+0tisD+w==
X-Google-Smtp-Source: AGHT+IGg7Mr4cXoq5WOSFVrPMPWaDX/kDfw90F1EkZqJ3y+/livDXtBL9FA46AkaqRYXT5znHubjRjUp+8ZK0lSTCdg=
X-Received: by 2002:a05:6a20:3d86:b0:1b5:d477:fcd5 with SMTP id
 adf61e73a8af0-1bcf44a7d6emr17490707637.25.1719497192972; Thu, 27 Jun 2024
 07:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-mtk-disp-rdma-dev-err-probe-v2-1-3898621767b8@collabora.com>
In-Reply-To: <20240606-mtk-disp-rdma-dev-err-probe-v2-1-3898621767b8@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 27 Jun 2024 22:06:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-ObBB7Jg=g9Q2pYk4cy6wL1d_XzHhgyNbtD7ovhwRzAw@mail.gmail.com>
Message-ID: <CAAOTY_-ObBB7Jg=g9Q2pYk4cy6wL1d_XzHhgyNbtD7ovhwRzAw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Log errors in probe with dev_err_probe()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Nicolas:

N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> =E6=96=BC 2024=E5=B9=
=B46=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:52=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Use dev_err_probe() to log errors in the probe function of all drm
> mediatek drivers. This avoids -EPROBE_DEFER return values from being
> logged as errors, like the following:
>
>   mediatek-disp-rdma 1c002000.rdma: Failed to add component: -517
>
> As a side benefit it also standardizes the format of the error in the
> log messages.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Converted all dev_err() in probe functions to dev_err_probe() instead
>   of just the ones in the component_add() error path
> - Link to v1: https://lore.kernel.org/r/20240605-mtk-disp-rdma-dev-err-pr=
obe-v1-1-91259e1d3a93@collabora.com
> ---
>  drivers/gpu/drm/mediatek/mtk_cec.c              | 28 ++++++++-----------=
---
>  drivers/gpu/drm/mediatek/mtk_disp_aal.c         | 18 +++++++-------
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c       | 18 +++++++-------
>  drivers/gpu/drm/mediatek/mtk_disp_color.c       | 18 +++++++-------
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c       | 18 +++++++-------
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c       | 25 +++++++++----------=
-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 24 ++++++++-----------
>  drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 31 +++++++++++--------=
------
>  drivers/gpu/drm/mediatek/mtk_dp.c               |  8 +++----
>  drivers/gpu/drm/mediatek/mtk_ethdr.c            | 19 +++++++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi.c             | 31 ++++++++++---------=
------
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c         | 21 ++++++-----------
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 18 +++++++-------
>  drivers/gpu/drm/mediatek/mtk_padding.c          | 20 +++++++---------
>  15 files changed, 125 insertions(+), 176 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediate=
k/mtk_cec.c
> index 8519e9bade36..2de248443147 100644
> --- a/drivers/gpu/drm/mediatek/mtk_cec.c
> +++ b/drivers/gpu/drm/mediatek/mtk_cec.c
> @@ -195,18 +195,14 @@ static int mtk_cec_probe(struct platform_device *pd=
ev)
>         spin_lock_init(&cec->lock);
>
>         cec->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(cec->regs)) {
> -               ret =3D PTR_ERR(cec->regs);
> -               dev_err(dev, "Failed to ioremap cec: %d\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(cec->regs))
> +               return dev_err_probe(dev, PTR_ERR(cec->regs),
> +                                    "Failed to ioremap cec\n");
>
>         cec->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(cec->clk)) {
> -               ret =3D PTR_ERR(cec->clk);
> -               dev_err(dev, "Failed to get cec clock: %d\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(cec->clk))
> +               return dev_err_probe(dev, PTR_ERR(cec->clk),
> +                                    "Failed to get cec clock\n");
>
>         cec->irq =3D platform_get_irq(pdev, 0);
>         if (cec->irq < 0)
> @@ -216,16 +212,12 @@ static int mtk_cec_probe(struct platform_device *pd=
ev)
>                                         mtk_cec_htplg_isr_thread,
>                                         IRQF_SHARED | IRQF_TRIGGER_LOW |
>                                         IRQF_ONESHOT, "hdmi hpd", dev);
> -       if (ret) {
> -               dev_err(dev, "Failed to register cec irq: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register cec ir=
q\n");
>
>         ret =3D clk_prepare_enable(cec->clk);
> -       if (ret) {
> -               dev_err(dev, "Failed to enable cec clock: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable cec cloc=
k\n");
>
>         mtk_cec_htplg_irq_init(cec);
>         mtk_cec_htplg_irq_enable(cec);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/me=
diatek/mtk_disp_aal.c
> index 3ce8f32b06d5..59fb9a08d54b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -175,16 +175,14 @@ static int mtk_disp_aal_probe(struct platform_devic=
e *pdev)
>                 return -ENOMEM;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get aal clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get aal clk\n");
>
>         priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap aal\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap aal\n");
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> @@ -197,9 +195,9 @@ static int mtk_disp_aal_probe(struct platform_device =
*pdev)
>
>         ret =3D component_add(dev, &mtk_disp_aal_component_ops);
>         if (ret)
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_aal_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/=
mediatek/mtk_disp_ccorr.c
> index df35e90dd25f..9b75727e0861 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -160,16 +160,14 @@ static int mtk_disp_ccorr_probe(struct platform_dev=
ice *pdev)
>                 return -ENOMEM;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get ccorr clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get ccorr clk\n");
>
>         priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap ccorr\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap ccorr\n");
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> @@ -182,9 +180,9 @@ static int mtk_disp_ccorr_probe(struct platform_devic=
e *pdev)
>
>         ret =3D component_add(dev, &mtk_disp_ccorr_component_ops);
>         if (ret)
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_ccorr_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/=
mediatek/mtk_disp_color.c
> index 7f0085be5671..2fd5e7dc9e24 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -104,17 +104,15 @@ static int mtk_disp_color_probe(struct platform_dev=
ice *pdev)
>                 return -ENOMEM;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get color clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get color clk\n");
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap color\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap color\n");
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
>         if (ret)
> @@ -126,9 +124,9 @@ static int mtk_disp_color_probe(struct platform_devic=
e *pdev)
>
>         ret =3D component_add(dev, &mtk_disp_color_component_ops);
>         if (ret)
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_color_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/=
mediatek/mtk_disp_gamma.c
> index ca8d1f3aca03..f0b38817ba6c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -264,17 +264,15 @@ static int mtk_disp_gamma_probe(struct platform_dev=
ice *pdev)
>                 return -ENOMEM;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get gamma clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get gamma clk\n");
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap gamma\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap gamma\n");
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> @@ -287,9 +285,9 @@ static int mtk_disp_gamma_probe(struct platform_devic=
e *pdev)
>
>         ret =3D component_add(dev, &mtk_disp_gamma_component_ops);
>         if (ret)
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_gamma_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/=
mediatek/mtk_disp_merge.c
> index 77c057e0e671..435e5d9c8520 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> @@ -316,22 +316,19 @@ static int mtk_disp_merge_probe(struct platform_dev=
ice *pdev)
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap merge\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap merge\n");
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get merge clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get merge clk\n");
>
>         priv->async_clk =3D devm_clk_get_optional(dev, "merge_async");
> -       if (IS_ERR(priv->async_clk)) {
> -               dev_err(dev, "failed to get merge async clock\n");
> -               return PTR_ERR(priv->async_clk);
> -       }
> +       if (IS_ERR(priv->async_clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->async_clk),
> +                                    "failed to get merge async clock\n")=
;
>
>         if (priv->async_clk) {
>                 priv->reset_ctl =3D devm_reset_control_get_optional_exclu=
sive(dev, NULL);
> @@ -354,9 +351,9 @@ static int mtk_disp_merge_probe(struct platform_devic=
e *pdev)
>
>         ret =3D component_add(dev, &mtk_disp_merge_component_ops);
>         if (ret !=3D 0)
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_merge_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index b552a02d7eae..4dd8bb8e8457 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -523,17 +523,15 @@ static int mtk_disp_ovl_probe(struct platform_devic=
e *pdev)
>                 return irq;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get ovl clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get ovl clk\n");
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap ovl\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap ovl\n");
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
>         if (ret)
> @@ -545,20 +543,18 @@ static int mtk_disp_ovl_probe(struct platform_devic=
e *pdev)
>
>         ret =3D devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
>                                IRQF_TRIGGER_NONE, dev_name(dev), priv);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to request irq %d: %d\n", irq, ret);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to request irq %d\=
n", irq);
>
>         pm_runtime_enable(dev);
>
>         ret =3D component_add(dev, &mtk_disp_ovl_component_ops);
>         if (ret) {
>                 pm_runtime_disable(dev);
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_ovl_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gp=
u/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 02dd7dcdfedb..0744da867d4e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -612,10 +612,10 @@ static int mtk_disp_ovl_adaptor_probe(struct platfo=
rm_device *pdev)
>         ret =3D component_add(dev, &mtk_disp_ovl_adaptor_comp_ops);
>         if (ret !=3D 0) {
>                 pm_runtime_disable(dev);
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_ovl_adaptor_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 7b1a6e631200..634bbba5d43f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -326,17 +326,15 @@ static int mtk_disp_rdma_probe(struct platform_devi=
ce *pdev)
>                 return irq;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get rdma clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get rdma clk\n");
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap rdma\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap rdma\n");
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
>         if (ret)
> @@ -347,10 +345,9 @@ static int mtk_disp_rdma_probe(struct platform_devic=
e *pdev)
>                 ret =3D of_property_read_u32(dev->of_node,
>                                            "mediatek,rdma-fifo-size",
>                                            &priv->fifo_size);
> -               if (ret) {
> -                       dev_err(dev, "Failed to get rdma fifo size\n");
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to get rdma fifo siz=
e\n");
>         }
>
>         /* Disable and clear pending interrupts */
> @@ -359,10 +356,8 @@ static int mtk_disp_rdma_probe(struct platform_devic=
e *pdev)
>
>         ret =3D devm_request_irq(dev, irq, mtk_disp_rdma_irq_handler,
>                                IRQF_TRIGGER_NONE, dev_name(dev), priv);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to request irq %d: %d\n", irq, ret);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Failed to request irq %d\=
n", irq);
>
>         priv->data =3D of_device_get_match_data(dev);
>
> @@ -373,10 +368,10 @@ static int mtk_disp_rdma_probe(struct platform_devi=
ce *pdev)
>         ret =3D component_add(dev, &mtk_disp_rdma_component_ops);
>         if (ret) {
>                 pm_runtime_disable(dev);
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_disp_rdma_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 536366956447..ed335d888b2f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2655,11 +2655,9 @@ static int mtk_dp_probe(struct platform_device *pd=
ev)
>                 mutex_init(&mtk_dp->update_plugged_status_lock);
>
>                 ret =3D mtk_dp_register_audio_driver(dev);
> -               if (ret) {
> -                       dev_err(dev, "Failed to register audio driver: %d=
\n",
> -                               ret);
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to register audio dr=
iver\n");
>         }
>
>         ret =3D mtk_dp_register_phy(mtk_dp);
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/media=
tek/mtk_ethdr.c
> index 156c6ff547e8..b367a080500c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -325,25 +325,24 @@ static int mtk_ethdr_probe(struct platform_device *=
pdev)
>         if (priv->irq) {
>                 ret =3D devm_request_irq(dev, priv->irq, mtk_ethdr_irq_ha=
ndler,
>                                        IRQF_TRIGGER_NONE, dev_name(dev), =
priv);
> -               if (ret < 0) {
> -                       dev_err(dev, "Failed to request irq %d: %d\n", pr=
iv->irq, ret);
> -                       return ret;
> -               }
> +               if (ret < 0)
> +                       return dev_err_probe(dev, ret,
> +                                            "Failed to request irq %d\n"=
,
> +                                            priv->irq);
>         }
>
>         priv->reset_ctl =3D devm_reset_control_array_get_optional_exclusi=
ve(dev);
> -       if (IS_ERR(priv->reset_ctl)) {
> -               dev_err_probe(dev, PTR_ERR(priv->reset_ctl), "cannot get =
ethdr reset control\n");
> -               return PTR_ERR(priv->reset_ctl);
> -       }
> +       if (IS_ERR(priv->reset_ctl))
> +               return dev_err_probe(dev, PTR_ERR(priv->reset_ctl),
> +                                    "cannot get ethdr reset control\n");
>
>         platform_set_drvdata(pdev, priv);
>
>         ret =3D component_add(dev, &mtk_ethdr_component_ops);
>         if (ret)
> -               dev_notice(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_ethdr_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 6e1cca97a654..3790d0b433cc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1713,26 +1713,22 @@ static int mtk_hdmi_probe(struct platform_device =
*pdev)
>                 return ret;
>
>         hdmi->phy =3D devm_phy_get(dev, "hdmi");
> -       if (IS_ERR(hdmi->phy)) {
> -               ret =3D PTR_ERR(hdmi->phy);
> -               dev_err(dev, "Failed to get HDMI PHY: %d\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(hdmi->phy))
> +               return dev_err_probe(dev, PTR_ERR(hdmi->phy),
> +                                    "Failed to get HDMI PHY\n");
>
>         mutex_init(&hdmi->update_plugged_status_lock);
>         platform_set_drvdata(pdev, hdmi);
>
>         ret =3D mtk_hdmi_output_init(hdmi);
> -       if (ret) {
> -               dev_err(dev, "Failed to initialize hdmi output\n");
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to initialize hdmi output\n"=
);
>
>         ret =3D mtk_hdmi_register_audio_driver(dev);
> -       if (ret) {
> -               dev_err(dev, "Failed to register audio driver: %d\n", ret=
);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to register audio driver\n")=
;
>
>         hdmi->bridge.funcs =3D &mtk_hdmi_bridge_funcs;
>         hdmi->bridge.of_node =3D pdev->dev.of_node;
> @@ -1743,15 +1739,12 @@ static int mtk_hdmi_probe(struct platform_device =
*pdev)
>
>         ret =3D mtk_hdmi_clk_enable_audio(hdmi);
>         if (ret) {
> -               dev_err(dev, "Failed to enable audio clocks: %d\n", ret);
> -               goto err_bridge_remove;
> +               drm_bridge_remove(&hdmi->bridge);
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to enable audio clocks\n");
>         }
>
>         return 0;
> -
> -err_bridge_remove:
> -       drm_bridge_remove(&hdmi->bridge);
> -       return ret;
>  }
>
>  static void mtk_hdmi_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/me=
diatek/mtk_hdmi_ddc.c
> index 52d55861f954..8e60631d4cd2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
> @@ -279,20 +279,17 @@ static int mtk_hdmi_ddc_probe(struct platform_devic=
e *pdev)
>                 return -ENOMEM;
>
>         ddc->clk =3D devm_clk_get(dev, "ddc-i2c");
> -       if (IS_ERR(ddc->clk)) {
> -               dev_err(dev, "get ddc_clk failed: %p ,\n", ddc->clk);
> -               return PTR_ERR(ddc->clk);
> -       }
> +       if (IS_ERR(ddc->clk))
> +               return dev_err_probe(dev, PTR_ERR(ddc->clk),
> +                                    "get ddc_clk failed\n");
>
>         ddc->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &me=
m);
>         if (IS_ERR(ddc->regs))
>                 return PTR_ERR(ddc->regs);
>
>         ret =3D clk_prepare_enable(ddc->clk);
> -       if (ret) {
> -               dev_err(dev, "enable ddc clk failed!\n");
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "enable ddc clk failed!\n"=
);
>
>         strscpy(ddc->adap.name, "mediatek-hdmi-ddc", sizeof(ddc->adap.nam=
e));
>         ddc->adap.owner =3D THIS_MODULE;
> @@ -304,8 +301,8 @@ static int mtk_hdmi_ddc_probe(struct platform_device =
*pdev)
>
>         ret =3D i2c_add_adapter(&ddc->adap);
>         if (ret < 0) {
> -               dev_err(dev, "failed to add bus to i2c core\n");
> -               goto err_clk_disable;
> +               clk_disable_unprepare(ddc->clk);
> +               return dev_err_probe(dev, ret, "failed to add bus to i2c =
core\n");
>         }
>
>         platform_set_drvdata(pdev, ddc);
> @@ -316,10 +313,6 @@ static int mtk_hdmi_ddc_probe(struct platform_device=
 *pdev)
>                 &mem->end);
>
>         return 0;
> -
> -err_clk_disable:
> -       clk_disable_unprepare(ddc->clk);
> -       return ret;
>  }
>
>  static void mtk_hdmi_ddc_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/me=
diatek/mtk_mdp_rdma.c
> index 925cbb7471ec..7c1a8c796833 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> @@ -301,16 +301,14 @@ static int mtk_mdp_rdma_probe(struct platform_devic=
e *pdev)
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         priv->regs =3D devm_ioremap_resource(dev, res);
> -       if (IS_ERR(priv->regs)) {
> -               dev_err(dev, "failed to ioremap rdma\n");
> -               return PTR_ERR(priv->regs);
> -       }
> +       if (IS_ERR(priv->regs))
> +               return dev_err_probe(dev, PTR_ERR(priv->regs),
> +                                    "failed to ioremap rdma\n");
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get rdma clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get rdma clk\n");
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> @@ -324,9 +322,9 @@ static int mtk_mdp_rdma_probe(struct platform_device =
*pdev)
>         ret =3D component_add(dev, &mtk_mdp_rdma_component_ops);
>         if (ret !=3D 0) {
>                 pm_runtime_disable(dev);
> -               dev_err(dev, "Failed to add component: %d\n", ret);
> +               return dev_err_probe(dev, ret, "Failed to add component\n=
");
>         }
> -       return ret;
> +       return 0;
>  }
>
>  static void mtk_mdp_rdma_remove(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/med=
iatek/mtk_padding.c
> index 85bc6768b6bc..bbda590ca76e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_padding.c
> +++ b/drivers/gpu/drm/mediatek/mtk_padding.c
> @@ -103,23 +103,19 @@ static int mtk_padding_probe(struct platform_device=
 *pdev)
>                 return -ENOMEM;
>
>         priv->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(priv->clk)) {
> -               dev_err(dev, "failed to get clk\n");
> -               return PTR_ERR(priv->clk);
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk),
> +                                    "failed to get clk\n");
>
>         priv->reg =3D devm_platform_get_and_ioremap_resource(pdev, 0, &re=
s);
> -       if (IS_ERR(priv->reg)) {
> -               dev_err(dev, "failed to do ioremap\n");
> -               return PTR_ERR(priv->reg);
> -       }
> +       if (IS_ERR(priv->reg))
> +               return dev_err_probe(dev, PTR_ERR(priv->reg),
> +                                    "failed to do ioremap\n");
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         ret =3D cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
> -       if (ret) {
> -               dev_err(dev, "failed to get gce client reg\n");
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to get gce client =
reg\n");
>  #endif
>
>         platform_set_drvdata(pdev, priv);
>
> ---
> base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
> change-id: 20240605-mtk-disp-rdma-dev-err-probe-ef9c10a1a91e
>
> Best regards,
> --
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>

