Return-Path: <linux-kernel+bounces-222614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104D910490
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391F21C23098
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198C1AD3FB;
	Thu, 20 Jun 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA1Nm0sg"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39621AC792
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887855; cv=none; b=TMRxjGJkS1YJfs3YT21jVgXDUfdVz7gky3D04Ft6sZ7TFnbEjj+zYDxWBG10mX9Bs+lY8vVITgoC0qOihfGgt3UCG2Cl2y+7AJ4i2yGabyMOC5zV0+FxuwZzgITaMYAMWqEHw5TDrMbxd4w4uh7FFBN34FhSin9IT2xtT12EQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887855; c=relaxed/simple;
	bh=2HmyC/8aoZ2nPJoKWEKLwCfkQSZpd1ixf1AoMQ48fKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEqd3GNss6CGZve4DVkPEYpiWdDZ6aFLvDryKLPcd0yKT8itmcrOTxqvG4kG2EZMG2L04UuWrcmu/jXkbYpXPxm0A6KXKUk40KFALvnaDBUjL7QipNooJt3TyXXBgfHgtqPzPged8UsHJuZH8DZUYqXeCtSP0+gePhcqZZvicRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VA1Nm0sg; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so824918276.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718887852; x=1719492652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=VA1Nm0sg5UJAsKD6JV6BkbBZ5eCWivY8rCu8G5tU3I07UHRKOBMejLNz5Fq0Hsc0ZU
         CiiCC1bKRnIbRZ0tiFie+ov6PhsWVAhr/oEcUNQ1crM9vT068Wg1W4F0ZjBv8ilqb/Kn
         PS5QSWnd8/uhqydzS+J0rFpE8AhErg6QozuQf776qnWhkCc1vNKuzuvqJn95YgPAMJjm
         AY+3je9Y+6vCdVh9z/OM53FH3PEPPaFcLK3MT0cD+Fk90htAUTn9NXNTbZjhYukmx1ni
         aG537yNuavJ8wKetDfo+d3iG0/S8ckBm2Uxnjpx3Ean9djNdFyaS0MDnCcG8N5k/Gt5d
         G+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887852; x=1719492652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7Ui2B3eiuQfY6kcWseFEWEENplZ5Qoq4XUDUnDKk3A=;
        b=DgiwmW4KCZruGCvg14muZA60L9Yo6+HumPLKXnbWamdj42fAyHlFKtGJgOYYtlAyR0
         l7cZIsEsTaDuOTGa3Ix+NP3D5SGGZFOzF5dNVrP7/13cuibNnv1XzFSe5IkjWCnu288l
         T1b0IsvRaWwgLKRLfSjBcWWYQzHv7q/zqUnc1e2tjOS24yK0edUORhfWSnWApYLcXv02
         Qjw/7r+BdpFrk3Pspa+gkQw7c5F0aYjIZSIBwR7kKfxWs0HTMwquzsVQmICg5q/b4ijj
         D6LeuGqb+MCYC9G8IkoPz7N2+FVACv74qW95NP/ycEJsqva3wxRjbIRFrXO6ddEt12RS
         /Flw==
X-Forwarded-Encrypted: i=1; AJvYcCWht5mE17cmjMELX48u09lYhZQVp0/1XGGM6VcZA44hq5XjGvvNbylm5RsF6ceBydNmqk7vGQQFDJ1wjyROVyZsDDbq2JgwUg/GZ+Rv
X-Gm-Message-State: AOJu0YzZ6XGlsut8XjzqBR1xgPWV4LQKYZuLSLocVTHKRJFbQyEaEWnp
	3RDA4cV9uRxwX4GICDKfRwEFeiHRL9eDqniT3fD45NZeyf4cyeOwqqZyMsO9Wg3ZeOC6GRFZZDY
	8GPukFeJM3i3QFzH436COXVIa+9g7hbWUuWQbFA==
X-Google-Smtp-Source: AGHT+IFzwmTlSm83S3zIQ/NDj8ijWnvuzYb+Ls9TCG0adu2HJouriCBzHm65cuenwHGzeYmKw4gbmsjLNgVHCs5ygNw=
X-Received: by 2002:a25:81c6:0:b0:e02:b580:d0b with SMTP id
 3f1490d57ef6-e02be203e4dmr5411315276.40.1718887852518; Thu, 20 Jun 2024
 05:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
In-Reply-To: <20240612-dense-resample-563f07c30185@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 14:50:15 +0200
Message-ID: <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Some controllers may not be able to reach a bus clock as low as 400 KHz
> due to a lack of sufficient divisors. In these cases, the SD card slot
> becomes non-functional as Linux continuously attempts to set the bus
> clock to 400 KHz. If the controller is incapable of getting that low,
> set its minimum frequency instead. While this may eliminate some SD
> cards, it allows those capable of operating at the controller's minimum
> frequency to be used.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks reasonable to me. I assume you intend to send a non-RFC for
this, that I can pick up?

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 09d7a6a0dc1a..c9caa1ece7ef 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * that's the only reason not to use a few MHz for f_min (until
>          * the upper layer reads the target frequency from the CSD).
>          */
> -       mmc->f_min = 400000;
> +       if (spi->controller->min_speed_hz > 400000)
> +               dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
> +
> +       mmc->f_min = max(spi->controller->min_speed_hz, 400000);
>         mmc->f_max = spi->max_speed_hz;
>
>         host = mmc_priv(mmc);
> --
> 2.43.0
>

