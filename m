Return-Path: <linux-kernel+bounces-325704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04CD975D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297741F23734
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4B1B655A;
	Wed, 11 Sep 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPiGBpKi"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE68185B59
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095219; cv=none; b=GiAJUhfynjXJftU/K7BxR1q/FGRr2qU3SQczypNzmg9VIm/VorvIvK+ZnpZPHffDgWWcniaZxDqctUSUEgOPTNjEcWW99jMyawwovwuNQJfebrroM/uT/T+dQ5ushhEfNKNIgPIBfeMPVOWD0nAysvL1yZLDwN9yE1gkUTkOI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095219; c=relaxed/simple;
	bh=45IXIPTAOc8PJXg27R4j5XHZ9p7NgIDlaFlLDAUK4DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuMJWsAzznOREzFqAWYlirpx9BCZIuoC0xvGTFLCc4U6XYj9Z7F7UweWEEdWXjrmkEZAwDJRT5TqoA7cZG9rZSKfceujgZZ7TZtfAoxfA1VgxOZLE9XdVEI8KbsQaJSJVatdwXZ/5GuE85Sz1j/9PuB1nxEHaIHptPYhHb3FV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LPiGBpKi; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5010c0e16baso112004e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726095214; x=1726700014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDV9Gdw17sp7pxrHjPWpyYBnJQ+f3bFcm/nUMPqV794=;
        b=LPiGBpKiw9JgwwjNGFm8K5JTNVfbP5u+asrUDyREgbT3nG/tEaX0x5tqqFlpl4aUwW
         nUt8/+CdBRGX1m2oAFi1gq0MaNY3a8BSICDsjGKOP3lcT6CC4Th+ngH/MdU8PjA6qbAT
         Ji4zWzOaaVlWxbuIAkP2TXSl30vtFs30o7mWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726095214; x=1726700014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDV9Gdw17sp7pxrHjPWpyYBnJQ+f3bFcm/nUMPqV794=;
        b=MHzHRFtVrpR/VLkKsdq0jzBVboFjPOfil9QoLpSMJEtxaOwhUqO4KYZelwuc7cUY9U
         oal9b+s07kZ/ag5yVB8PAnrPNSQwVHzTPB3fZiv+4NBGBmTv6w84zqY22AFyht4g4Ary
         TiWlHsIs67WIB6/qAnjhD0IVjLI3R4w8BkpB7LpVyJpbaRl0n63gb0Yk7m3J2CinSsjN
         LSutTy3rp7T3SpKOX+BBPpSgi+lohCZGps3yJVvEzeHURyg618as/OmnAqGb/XFqC8gu
         JKthbRdsx1aeiu1TuTQIYoAx9GkkwOsq0GJbYAtB8/eZqtw/7R+im6To1xTyvcIEiV4L
         gnIA==
X-Forwarded-Encrypted: i=1; AJvYcCWv5XLdEiW+VylId6Pw0Zem2twYqlHt5LUWc5dqxrlI1+3t+V+pLmvhKPkrZGOhrjFEnJ3+1+khbWdsu/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OeBN5RKnE/TSlnnMlZNvt59LCcLoKkFFcckGEFVC+koGJd9Y
	5mhSR51w89Sa2FCX+g2ix7IQJwAHKDk9RPOtn04X9aQsJW8OCxUBu4wNW+aPyrsNF+SqSPXF1Jo
	=
X-Google-Smtp-Source: AGHT+IFqhVofjHX23d7GoioUAUAp2/r5djXgYI7kGT8qwtg0BrdipZ9DQgWzDsi826xWXh8uWy+pFQ==
X-Received: by 2002:a05:6122:3bd2:b0:4ec:f8e4:e0bf with SMTP id 71dfb90a1353d-5032d3b4f8bmr1379556e0c.2.1726095214147;
        Wed, 11 Sep 2024 15:53:34 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a0368esm473574385a.93.2024.09.11.15.53.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 15:53:33 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35a23b378so2049496d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:53:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9ZsNEILRwNqZZB7mHG2xvAl0URulurRRvebzDW7MrMVvOQ+Wux9zHVjqSvyU9apxWQY34AX++vvO1RKE=@vger.kernel.org
X-Received: by 2002:a05:6214:5d06:b0:6c5:1f23:33a3 with SMTP id
 6a1803df08f44-6c573484f55mr16827546d6.0.1726095212185; Wed, 11 Sep 2024
 15:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909132810.1296786-1-ruanjinjie@huawei.com> <20240909132810.1296786-4-ruanjinjie@huawei.com>
In-Reply-To: <20240909132810.1296786-4-ruanjinjie@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 15:53:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
Message-ID: <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, vkoul@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 9, 2024 at 6:19=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> Use devm_pm_runtime_enable(), devm_request_irq() and
> devm_spi_register_controller() to simplify code.
>
> And also register a callback spi_geni_release_dma_chan() with
> devm_add_action_or_reset(), to release dma channel in both error
> and device detach path, which can make sure the release sequence is
> consistent with the original one.
>
> 1. Unregister spi controller.
> 2. Free the IRQ.
> 3. Free DMA chans
> 4. Disable runtime PM.
>
> So the remove function can also be removed.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Correct the "data" of devm_add_action_or_reset().
> v3:
> - Land the rest of the cleanups afterwards.
> ---
>  drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 6f4057330444..5cb002d7d4a6 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_ma=
ster *mas)
>         return ret;
>  }
>
> -static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
> +static void spi_geni_release_dma_chan(void *data)
>  {
> +       struct spi_geni_master *mas =3D data;
> +
>         if (mas->rx) {
>                 dma_release_channel(mas->rx);
>                 mas->rx =3D NULL;
> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *=
pdev)
>         if (ret)
>                 return ret;
>
> +       ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, =
mas);
> +       if (ret) {
> +               dev_err(dev, "Unable to add action.\n");
> +               return ret;
> +       }

Use dev_err_probe() to simplify.

ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
if (ret)
  return dev_err_probe(dev, ret, "Unable to add action.\n");


Personally I'd also rather that you do the devm_add_action_or_reset()
call straight in spi_geni_grab_gpi_chan(). That makes it much more
obvious what's happening. You can still use dev_err_probe() in there
since it's called (indirectly) from probe. In that case you'd probably
replace the "return 0;" in that function with just "return
dev_err_probe(...)".


> @@ -1146,33 +1154,15 @@ static int spi_geni_probe(struct platform_device =
*pdev)
>         if (mas->cur_xfer_mode =3D=3D GENI_GPI_DMA)
>                 spi->flags =3D SPI_CONTROLLER_MUST_TX;
>
> -       ret =3D request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi=
);
> +       ret =3D devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name=
(dev), spi);
>         if (ret)
> -               goto spi_geni_release_dma;
> +               return ret;
>
> -       ret =3D spi_register_controller(spi);
> +       ret =3D devm_spi_register_controller(dev, spi);
>         if (ret)
> -               goto spi_geni_probe_free_irq;
> +               return ret;
>
>         return 0;

You no longer need the "if" statement or even to assign to "ret". Just:

return devm_spi_register_controller(dev, spi);


Those are just nits, though. I'd be OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...since Mark has already landed the first two patches, your v5 would
just contain this one patch.

-Doug

