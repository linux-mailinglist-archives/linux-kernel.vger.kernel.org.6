Return-Path: <linux-kernel+bounces-244326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136C92A2B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91529B23011
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785A135A6D;
	Mon,  8 Jul 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6yzKALS"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059B80635
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441466; cv=none; b=MMAqmNS6NoqghcRUxI4KOr3aFlMz7PRC0H7NfSgUlOKieD2wcneQJZYjemEuKb96kFNMyPdyuZMG3oUa6ceBGJYU/5IdIXDmU1R6lzMoD7yG+oAFJaZm76no8vN3Ykq501pLBnFsp/oRN11IKhNGvAZhnPKNjgNyTrk6Bz15nPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441466; c=relaxed/simple;
	bh=1xFKym8dQ8FXh+MVHNBwonqkHzr6DWBX3Kyt4hlGpiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0CraLvaWLcl8ZrL50Yovfsr/CmzOlfhw0T6kv6uFFbdT5K/eanS0P3rDos41//mPApwnnjiiL+vwMjo+KD7kNc7vna3egZWKx5D9wESrAENn3wWjGpctwpp/0GAmNQ3Jee56Hg1HZ17QdEYdq9gHqNc0q2AXgNnBbm/Kj88XOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6yzKALS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03618fc78bso3743011276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441463; x=1721046263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ1ByCKJaiGZVgPD6N72f5VJmXfUYBIFakOZFv4yIy0=;
        b=n6yzKALSlfEj8SXDR9BzNCKnuLis5d4Vpa859AWztKYs1E7xp0RUgugodp1mdqpZ9I
         yXBuZyyqQsCm/Xh7FoI9ov8nJwVOvmbNAcfeslsGM4q3EwBxiP6mq9hNP6ABt8wqBhCG
         n9udafhjSFGl5Cqq8CoiGtct78mLt8ThTcFpPN+BrhcDiEkigoYixielTPWDXyjPRVDN
         dVkgHzso66T+xtZDm71CNFKaKh2GUiyVfIID1O4fkic33gdgdOotD29j7XtDuRcg030w
         iMzsRqIBj+k0EmGY4p0l8FCMbtVJ1B/AXtYv/LbnW/TM/4tCUGvyfE3Uv6fjaZQZODke
         NICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441464; x=1721046264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ1ByCKJaiGZVgPD6N72f5VJmXfUYBIFakOZFv4yIy0=;
        b=Lzc7J3n0N57cW7pae2NzCLU4hwfNqY0YRWo93ntYFGlJcb9lPrxXMjEs2nuYTkG0/D
         qm+yXNtRhGFEZrx/wZvvlWK3jCl+KlGvvOF80SuYHt+WXJ0DdlBdzc8i398GZC3V6uJI
         UY0AtD2m53brdXroOOb4hC+4vet9t0aNTW39WhQ1vVY6eYPTw0B71a7u6luU1Iem66QA
         5XQoGti7drFX2CnFgcCXmQEOkvHYAiA4zvA9OUiAD0t/HNpfTDHCp850pWaxtIV5I2ne
         azn+QOHh/isIJLPer1jO+MAQZzxdWjTHRlZmiwqYmU3TOhBvnKWTJC9D1lokq4QcrwbX
         nNeA==
X-Gm-Message-State: AOJu0YwUHAizkK7nLocw+RokOkf56ariyCEiTkRtt7xvuNS7VfZMhs3K
	PAn1CCYo4qCRPrJf4oXDgGmWTl9hr5MdGxsHl8g83ZMwCIIvYOTFe7+Xw6Y+kD77zyMwtzmm6CW
	IiJgW5fqEyg3TEG+Fv+7zr4SCnxYZvM2i+a9Ang==
X-Google-Smtp-Source: AGHT+IHXRCpDO5w5I6A8pgDd0kHVsaSbPwgXD0RiAPY/CcfQGVwHI08Dh7BT8l+lLl1/7EtPVj7YMrFfreV6YKbUjqo=
X-Received: by 2002:a25:dc01:0:b0:e03:6544:1678 with SMTP id
 3f1490d57ef6-e03c1a006bemr12917519276.56.1720441463735; Mon, 08 Jul 2024
 05:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-gigantic-frown-1ef4afa3e6fa@wendy>
In-Reply-To: <20240625-gigantic-frown-1ef4afa3e6fa@wendy>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:23:47 +0200
Message-ID: <CAPDyKFoswLvgopz+cXCsxjZs4VRg-mrA66HTmfux57eY=--JMw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, conor@kernel.org, 
	Cyril Jean <cyril.jean@microchip.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 14:34, Conor Dooley <conor.dooley@microchip.com> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Without the RFC tag, but otherwise unchanged.
>
> rfc/v1: https://lore.kernel.org/all/20240612-dense-resample-563f07c30185@spud/
>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Cyril Jean <cyril.jean@microchip.com>
> CC: linux-mmc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/mmc_spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 09d7a6a0dc1aa..c9caa1ece7ef9 100644
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
> 2.43.2
>

