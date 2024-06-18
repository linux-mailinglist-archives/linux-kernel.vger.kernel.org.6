Return-Path: <linux-kernel+bounces-220074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AD90DC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996221C2281E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AC1662EF;
	Tue, 18 Jun 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="An9P9Ci9"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D0161901
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738808; cv=none; b=OByrevc+wBT7RchhZ1YHUGpZc/MyVKYpSJOpOeUjEBPtvcAuaEnMESxvZv41mHRt/rZsxKS1TD28qrYcU6N3KNrbDQYErGGc01R34d31vsQ04xtEA8PRIxiTK7Xh3i4mtBNkwyyS91EsC55+qWoJbdE6Jr0JlNEf7GXqpEz/IHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738808; c=relaxed/simple;
	bh=+FyiA+pYK8APwK75QeRcyo/HcZRVxSHlp1CzDFB8ZR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMIBIxpfzGzzhRJTe//sNcLUFWEp+QAoq+EJD2fJdePVuB29jLb1w+wP6gsev4DxB9TDURs6hgRakNWR2vIWrIP6NVtkkTACdXb5JW9SKFAEYiK0b5EYNZtU4CCGIy/vAHyA3raSTzcl6N+Y6nAo69uoGv/3dPDV6aGUxDWzdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=An9P9Ci9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso6215578276.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718738806; x=1719343606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JdIhONv4P+97AjtXHbls42T4V6PxnxrDwc043W4vOo=;
        b=An9P9Ci9QQ1c5s7gcjCkRnfqnMy/q/1l90M1HEk38mkKcMwJZBQlZMctXfkqRwSUXs
         GoPq7wRdaI6U/3SLlTkld9O9xMIEW898NrHgJ5ZvD1Lr4OmxwqBuJAsW4yM+pHXzJxpR
         7nD63JgJO44ZJKs1g6sf+ebcMpAbxWguzEbmvWFUt6OuCOSTSw2BrzfsPEWdzsY7707j
         rWtNw7QDxpd2TlVGM3WjuBNYx87Rt4Hj18CLPXNFWmlDM/cNLmXbHS6zJMOeVvQP/YkL
         HANnyn/aSn8+kyhCDH07N21Yr/MZbZIFYuSshUVYPxj9n/ophLf8LjeOLU0DkbmqJDPG
         EPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718738806; x=1719343606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JdIhONv4P+97AjtXHbls42T4V6PxnxrDwc043W4vOo=;
        b=rvuPlX2pRTSpwtwUsVH+JA7yvjfDB2aH8aQgw8XrAo8K16LqE/sSY1mbWicEyjCWdp
         dveUZ2UxMadEQ9xbyyc6pzRRyxVA7v1P7hF4yB0VTQnpQdnZ595W3KZtycGCQkQp+qeB
         gqLTIhoZBtLxQqfR9SKbt2GSnW2VjImg84FUV5D1quFWdX8gCRghtpp/MEfN4bSVy4UQ
         GPCBLgDroZxpZ2BKKInDz+goK5v3fPTf5X6tzZ8T/kcFT3Vz54AIScrx6CGRyAyiqvay
         3XiBNwXGjjkOqI6xUM5lIeJXYAPZsH9vZzdhJRPpBxnJ+eEMFeXsS0cAoOMCQ6PkSWvG
         yXSA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Pxi/bMr6NvxMnHDKKGTWZ/7LPRzADAILWuWNahwhqD80O6VA5QP8LZ7yUSzGSZmwTmU9kk86LHruhdwm3vMxliTLJKReXr/MF51x
X-Gm-Message-State: AOJu0YxUfhlW1cNst0X6WByq3ffoexL050XQI2kBqzyu/6qVamc9khv7
	5VCpFnwCCl0G+8gl3fVhQgvPr/kK2EI/xNUXevxSLPiOQUGrpJWph6w8BLwgbOVfiN2aPt1vE/F
	6xz6+udqHlKoy+6QX/+y/qzuExvClIhB2x43Hng==
X-Google-Smtp-Source: AGHT+IEgckfSzpfRkRk3dzsXY6WG0jQp3J3r598HIt7lADXYgT+sH/QiHeZPNODRKExgkh5yZnVfoB+gxVSZC+8vuoE=
X-Received: by 2002:a5b:c4d:0:b0:dfd:c928:cc9f with SMTP id
 3f1490d57ef6-e02be142117mr988991276.26.1718738805816; Tue, 18 Jun 2024
 12:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003743.2975-1-semen.protsenko@linaro.org>
 <20240618003743.2975-5-semen.protsenko@linaro.org> <CANAwSgSaYip=oqtLfTzFMq_HWGJMMbEXOqKWC8ANzxNZmBFXTw@mail.gmail.com>
In-Reply-To: <CANAwSgSaYip=oqtLfTzFMq_HWGJMMbEXOqKWC8ANzxNZmBFXTw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 18 Jun 2024 14:26:34 -0500
Message-ID: <CAPLW+4kGH+WJS5x6ujGacD_uhsUb9Mi7w1F+ocnc6hZz628kew@mail.gmail.com>
Subject: Re: [PATCH 4/7] hwrng: exynos: Implement bus clock control
To: Anand Moon <linux.amoon@gmail.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:26=E2=80=AFPM Anand Moon <linux.amoon@gmail.com>=
 wrote:
>
> Hi Sam,
>
> On Tue, 18 Jun 2024 at 06:08, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> >
> > Some SoCs like Exynos850 might require the SSS bus clock (PCLK) to be
> > enabled in order to access TRNG registers. Add and handle optional PCLK
> > clock accordingly to make it possible.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/char/hw_random/exynos-trng.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_ran=
dom/exynos-trng.c
> > index 88a5088ed34d..4520a280134c 100644
> > --- a/drivers/char/hw_random/exynos-trng.c
> > +++ b/drivers/char/hw_random/exynos-trng.c
> > @@ -47,7 +47,8 @@
> >  struct exynos_trng_dev {
> >         struct device   *dev;
> >         void __iomem    *mem;
> > -       struct clk      *clk;
> > +       struct clk      *clk;   /* operating clock */
> > +       struct clk      *pclk;  /* bus clock */
> >         struct hwrng    rng;
> >  };
> >
> > @@ -141,10 +142,23 @@ static int exynos_trng_probe(struct platform_devi=
ce *pdev)
> >                 goto err_clock;
> >         }
> >
> > +       trng->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
>
> Use devm_clk_get_optional_enabled to avoid clk_prepare_enable
>

Thanks for pointing that out! Will fix in v2.

> > +       if (IS_ERR(trng->pclk)) {
> > +               ret =3D dev_err_probe(&pdev->dev, PTR_ERR(trng->pclk),
> > +                                   "cannot get pclk");
> > +               goto err_clock;
> > +       }
> > +
> > +       ret =3D clk_prepare_enable(trng->pclk);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Could not enable the pclk.\n");
> > +               goto err_clock;
> > +       }
> > +
> >         ret =3D clk_prepare_enable(trng->clk);
>
> Use devm_clk_get_enabled for this clock
>
> >         if (ret) {
> >                 dev_err(&pdev->dev, "Could not enable the clk.\n");
> > -               goto err_clock;
> > +               goto err_clock_enable;
> >         }
> >
> >         ret =3D devm_hwrng_register(&pdev->dev, &trng->rng);
> > @@ -160,6 +174,9 @@ static int exynos_trng_probe(struct platform_device=
 *pdev)
> >  err_register:
> >         clk_disable_unprepare(trng->clk);
> >
> > +err_clock_enable:
> > +       clk_disable_unprepare(trng->pclk);
> > +
> >  err_clock:
> >         pm_runtime_put_noidle(&pdev->dev);
> >
> > @@ -174,6 +191,7 @@ static void exynos_trng_remove(struct platform_devi=
ce *pdev)
> >         struct exynos_trng_dev *trng =3D platform_get_drvdata(pdev);
> >
> >         clk_disable_unprepare(trng->clk);
> > +       clk_disable_unprepare(trng->pclk);
> >
> >         pm_runtime_put_sync(&pdev->dev);
> >         pm_runtime_disable(&pdev->dev);
> > --
> > 2.39.2
> >
> >
>
> Thanks
> -Anand

