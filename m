Return-Path: <linux-kernel+bounces-249476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA992EC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27B21C214A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5216CD2A;
	Thu, 11 Jul 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4msgGtJ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E416C87E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713858; cv=none; b=g3nwHDb02DRVDuOroa5dygyn0WTZB1YqUWfroHBAxESo6Z8mnyFDF6UDMZeyHmiWTo+fHd8jj837/Qd0+Pc6LBABQx58eWOx5tADZL7MZGWwoyp9+VXjfSB7T2HVnupmr/ZymJeSdvQC9gxFEL0fWspxYOK8Lb75fKjlL9M9XU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713858; c=relaxed/simple;
	bh=jpbKiqH3kKUvMshKxMYVc4OVLI4AOxtAZ5oJiNPJbLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpDaoxI+YNJnUy1TflCfmDvp/3kHHjNafQP+S6SKFza97/XnUyhuMh2LdZCIWWgkYPmQXVI5fQ9jMh9njU8ZTKGhTqsYUkRBZivgs2TpPhLoFAPURU+io8GI0labZg22FBXLtD1DdXwA3LaYvhrWp3A0GM5S6eCd4zvXCw0hgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4msgGtJ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6518f8bc182so16366417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713856; x=1721318656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bFU5vBShjHpyztO92AZLYt9Y5qSP92FmSsQShXmlGY=;
        b=J4msgGtJ5HkZcOrYe1q23lGOybkVY8z/eph6v7bXvd9fvN6q/5+WOWAltRkj95LgG7
         0Hwi8t4B9y288wcJrzW3+XGa+OByb9X0XzfHUL0bwnYUQ8LjuT11XvENDtjLzDoYgq3T
         ouoxoYJZldz4zmmy6WsS5Rn3UeMQoTyC8QZveEvvg1Ud10uANAPZYnUG2ozmr+aOw20D
         yZ1BoQxJeBJ8/VSpYhktPAibN2OOem00+c8uO8+yvOCupyFmB9Ziy0ry9UMzEgAHAhqx
         vtVlGW6y/EK1oIat+RLRkJ6V1TDgp1qMsEDcvjp4IOWLKWtpAn6NyJ/aCJrTpWEAYco9
         nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713856; x=1721318656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bFU5vBShjHpyztO92AZLYt9Y5qSP92FmSsQShXmlGY=;
        b=fhXePcZplsc1r0LKyMumiF/i5VOYxJHAoEzRWvHFWlp3XVejpswgIxdUkKGUK5HElI
         glM0DUcFt2ApyJMNU9vS93QRoq9sgi0pfU3p2ht90iUqfLHXsuOoNhfNzPXrNr5FpOhe
         an913sgGplwMXhL3L81Gy5mu44C9YxIGmTy2dQqaPLytdBgD1bCX2IKDuuiVkfQa4Ykt
         eobx112A2XmICKzegR0/+eqzzq3IlLsRLjm7v5wLJa+9ay+AVCl74VtAOVkPU6TaVgVu
         8IP4zRun35Zu+awCGyEnbva3wglYn4t2RvI4ZuQEyLJApEYm8PJuTVY32d4ycTMd+DdZ
         VA6w==
X-Forwarded-Encrypted: i=1; AJvYcCXFtaa+oFQ3RKgVI/oW5cefRNte42SfPRGgLKaCYjR0pgD3u/+UqXHxv768NyFxC6ci7BWaBJZUC3x6a+cH9m8r6koKF0OBbN7SYVzw
X-Gm-Message-State: AOJu0YyXKu8NA9ylkybiJOOO5Q9Oc4F4A6oC5Eva6DtpzB1J0KV7CO/V
	MJBOvZh+op96cD3UmjMn2KJfzaaB7kdvuZURyRlTJy9SYljuYsYYM3hOMe82G9TeTPct1fZkzki
	es/nNO96AzvLlELWSdTLSQ8SVOf5bY7FQcOaXhw==
X-Google-Smtp-Source: AGHT+IE4d6cBzpPVohcjaR5Xa/utvEbwflISMEB60yRcirDYtMeU02JdhTCn2YMO0gfrY8BH8Vv2cw6mFvXVO8qUmgc=
X-Received: by 2002:a25:8041:0:b0:e03:a439:c333 with SMTP id
 3f1490d57ef6-e058a49bf93mr114250276.11.1720713856046; Thu, 11 Jul 2024
 09:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com> <20240711081838.47256-3-bastien.curutchet@bootlin.com>
In-Reply-To: <20240711081838.47256-3-bastien.curutchet@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:40 +0200
Message-ID: <CAPDyKFr5X9+sL7y3vCrb3P0vXnBM_56GEzX+eD9zL12VRbh5og@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: davinci_mmc: report all possible bus widths
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Christopher Cordahi <christophercordahi@nanometrics.ca>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:18, Bastien Curutchet
<bastien.curutchet@bootlin.com> wrote:
>
> A dev_info() at probe's end() report the supported bus width. It never
> reports 8-bits width while the driver can handle it.
>
> Update the info message at then end of the probe to report the use of
> 8-bits data when needed.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c302eb380e42..9cbde800685d 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1187,7 +1187,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>         struct mmc_davinci_host *host = NULL;
>         struct mmc_host *mmc = NULL;
>         struct resource *r, *mem = NULL;
> -       int ret, irq;
> +       int ret, irq, bus_width;
>         size_t mem_size;
>         const struct platform_device_id *id_entry;
>
> @@ -1317,9 +1317,14 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>
>         rename_region(mem, mmc_hostname(mmc));
>
> +       if (mmc->caps & MMC_CAP_8_BIT_DATA)
> +               bus_width = 8;
> +       else if (mmc->caps & MMC_CAP_4_BIT_DATA)
> +               bus_width = 4;
> +       else
> +               bus_width = 1;
>         dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
> -               host->use_dma ? "DMA" : "PIO",
> -               (mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1);
> +                host->use_dma ? "DMA" : "PIO", bus_width);
>
>         return 0;
>
> --
> 2.45.0
>

