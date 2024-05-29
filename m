Return-Path: <linux-kernel+bounces-194002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF198D354F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A391C22046
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D617F375;
	Wed, 29 May 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qkxEt2P3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0DD16A373
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981478; cv=none; b=H1Mtcxmty/SSS9UkoRuNdrr97PoGBT3/uh7oThGeuLuJ9Hix/qkDRRI1l47e/5h1G4wq0edUnUTYM5903OxEZFF7Bpi1+gMCihjEBN+YcKNSIcbTzygDRAjZP2K6eINgrMlIAoYJAw4fQUepPgmobk8X6a9bt0coGa8C5AGLM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981478; c=relaxed/simple;
	bh=ap8WB7zJyNfSEZFkt5CFPXf10NgEIEKXQoueXOl5NTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HMu36N9PBTEsn1FmKyE/cMEJpAz5H6jfx6brbTEhRwT4AD+XTLThypNOPaV2Sp6iIsT4ysjHqTOtUTnBVt7MGjEtjbuxZFVKlktBcVEa0VjkhzPdgI/1ocwAdt8Lc8SaOMigK03CcW+puDC+Q4++/Je2pxrhJWbl87D2asbuJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qkxEt2P3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e716e302bdso21676081fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716981475; x=1717586275; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MhVoCfE1qgvS+Rea5BqmdotkpaOmhiJt3ApwJZvK6g=;
        b=qkxEt2P3adFTJtuzDLbIH6SSwFOKrVl0HEgTksvLXSvkR4tg+zI5ZkxIx9XHu6uAjM
         DH+n7UiG4OGtN/zujP/a0j8uhNvp/HI14tB7QtFNc7C1u6CzY5jgGX6FNOm2P7fDZrbQ
         o2L6QvapdtLaq7LEraFDR6PtshcphQbsyy+o1JedpZF2ZtglfDO2lX0hTzxe9BGiqpu2
         PzEdWto9gV68S2FQl39wX5RY6V6BnYwWuMui2f++Po4oWtBqQZTvl2YDqXbxhimYRtyv
         xHLoCbTpVeohICTMaFX6XjxDi76Mt+K6UGg9bRCBXDlByFnTgo15ynOZrZliCTMIFsSz
         0M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981475; x=1717586275;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MhVoCfE1qgvS+Rea5BqmdotkpaOmhiJt3ApwJZvK6g=;
        b=wjBCyHoVupBlIEC7RNhYtHvDmvHfvNjz2jzPOOmf455s5feTFPSL0jriqS8vMwG5g7
         MgV5+di4qRa3cIO9XYEMChzIkJcZvKCg4gD/QMzdWy7Y+URGtZnUXrZNCgWvQJthyY3q
         p5oxJqGzzsvgWDkuaii4VGYyWkYvFzSo63gopADJQweimSnpqBrm6Jqm2/uQrM1dPtNf
         leGgV33yCYBIiVyCfewpdfufeiFuIWIvbfT2nvV88UbA09fmqCj4FWc2WBT1qQnXMYYe
         80H9tMFwkLFTF/Ub54O1nXzsvqiG557zkUIbXb/DDP/l1Q9dODaGjHBiCjr0ChxdSHK+
         2VvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7DRgsFgnRJwSB4fjEvtn+4F6nPQcrhm/8L9eGi2a9vKPAfOxrKn3sWiXV2cc4Pfq3thYmCreVdz6IpcUJwledfpXGU8ClMx/4jFDD
X-Gm-Message-State: AOJu0YxKjaDUqy5UcNQfCaeYs3MRrVEUZC6GFb8mbHN0w8NOmeGp6xWT
	O6oQHWbBr64dML0BbPpMcdgyzboDqQn/qeaiwaFr/47QwklmliN6ZXG5pua83yxmBF6OX9XMRai
	YukGSov1EiEiC3365UJB8wy8uDU8bnM28jwLNwg==
X-Google-Smtp-Source: AGHT+IHLzzi26MzrXuTKHQDrvAQBQ126kwDvkstzBaFuSnwmW3mJAe0gxhCqHTcr838fp4HizAyBeHV6zAEkI9sAPJM=
X-Received: by 2002:a05:651c:1a0b:b0:2e5:8685:8b13 with SMTP id
 38308e7fff4ca-2e95b0c22b6mr99628191fa.25.1716981474863; Wed, 29 May 2024
 04:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
In-Reply-To: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 May 2024 13:17:43 +0200
Message-ID: <CAMRc=Md9osTYohZU_CJkaU8zto5P4v9_Nfp7quqVXm_YM+2Y0Q@mail.gmail.com>
Subject: Re: [PATCH] gpio-syscon: do not report bogus error
To: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, etienne.buira@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:48=E2=80=AFPM Etienne Buira <etienne.buira@free.f=
r> wrote:
>
> Do not issue "can't read the data register offset!" when gpio,syscon-dev
> is not set albeit unneeded.  gpio-syscon is used with rk3328 chip, but
> this iomem region is documented in
> Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> does not require gpio,syscon-dev setting.
>
> v3:
>   - moved from flag to parent regmap detection
>

Don't make the changelog part of the commit message, please.

Bart

> Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> ---
>  drivers/gpio/gpio-syscon.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 6e1a2581e6ae..3a90a3a1caea 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -208,6 +208,7 @@ static int syscon_gpio_probe(struct platform_device *=
pdev)
>         struct syscon_gpio_priv *priv;
>         struct device_node *np =3D dev->of_node;
>         int ret;
> +       bool use_parent_regmap =3D false;
>
>         priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -216,24 +217,28 @@ static int syscon_gpio_probe(struct platform_device=
 *pdev)
>         priv->data =3D of_device_get_match_data(dev);
>
>         priv->syscon =3D syscon_regmap_lookup_by_phandle(np, "gpio,syscon=
-dev");
> -       if (IS_ERR(priv->syscon) && np->parent)
> +       if (IS_ERR(priv->syscon) && np->parent) {
>                 priv->syscon =3D syscon_node_to_regmap(np->parent);
> +               use_parent_regmap =3D true;
> +       }
>         if (IS_ERR(priv->syscon))
>                 return PTR_ERR(priv->syscon);
>
> -       ret =3D of_property_read_u32_index(np, "gpio,syscon-dev", 1,
> -                                        &priv->dreg_offset);
> -       if (ret)
> -               dev_err(dev, "can't read the data register offset!\n");
> +       if (!use_parent_regmap) {
> +               ret =3D of_property_read_u32_index(np, "gpio,syscon-dev",=
 1,
> +                                                &priv->dreg_offset);
> +               if (ret)
> +                       dev_err(dev, "can't read the data register offset=
!\n");
>
> -       priv->dreg_offset <<=3D 3;
> +               priv->dreg_offset <<=3D 3;
>
> -       ret =3D of_property_read_u32_index(np, "gpio,syscon-dev", 2,
> -                                        &priv->dir_reg_offset);
> -       if (ret)
> -               dev_dbg(dev, "can't read the dir register offset!\n");
> +               ret =3D of_property_read_u32_index(np, "gpio,syscon-dev",=
 2,
> +                                                &priv->dir_reg_offset);
> +               if (ret)
> +                       dev_dbg(dev, "can't read the dir register offset!=
\n");
>
> -       priv->dir_reg_offset <<=3D 3;
> +               priv->dir_reg_offset <<=3D 3;
> +       }
>
>         priv->chip.parent =3D dev;
>         priv->chip.owner =3D THIS_MODULE;
>
> base-commit: 4cece764965020c22cff7665b18a012006359095
> --
> 2.43.0
>

