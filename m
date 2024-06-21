Return-Path: <linux-kernel+bounces-224766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A239126A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5B287B00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99125155C84;
	Fri, 21 Jun 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="joVfdosG"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38315531E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976404; cv=none; b=WhqZCL5A9jDCsGmrVW8ZGYFVNKPVhq1pDMQHG14nIcZAtP0C1TSt9D9pxLBwEis4DBEWq1NLFA/LZKSviwBkaKZnJeswAKus2rlZfzz9XOHI2AoU4xBTHbBrvscuarLFVVZ9Z8jjFhArmctUqAT+JaxNGowSWlyQLBOyLitQPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976404; c=relaxed/simple;
	bh=M8ICS2gUnqSAKdwVYa3WwNL+rTtc7oafu3hZ4D7sEm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgEiRXkx43hd6Xr+XCU+2DjiaIo5nQYGQMwvxSraamQgxU5u6r6ciGDU2rbRrfcJS2s/wk/Rjm8hEQ1WExIEs4ufwAfF/pRDUeGyhvkmeSyA64BBm57EpT3shV93Ay9dVCLmraAq3Qpq/bGvpcqjGX0KObqXH6ZSYWRHkCNRVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=joVfdosG; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48c37216a1cso87027137.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718976400; x=1719581200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxkGI4IDUNtwkih25Bt66Jpt1EbuMgTL6TuQaswoa08=;
        b=joVfdosGXl0ihqrtc4WgzxFrW9QIEhqYAtH9OU+7zwyi/jX2bG+1pPZHVlSNWQq3dn
         0e8V/Hy1WJy3Pn+AjxMdOc3Q5pm33s99AXkmGUixAaFxRy94wEASz4uoyaUdcaZSVQlK
         6g/9LUxH2hdNCuZ2bH7jYkUjLy1wyWszjOA7ydJyDiyy04B/9hhpl2MZz6xCE+f/9kHm
         gqbH25VPQqrFg4mlN4ur9GBUqp1FIeJ51iaZJip1+rJjpqNY/4niTiYMisVHhok+uNzy
         a6XLl/og8WfbZtkMPQX8wAS6rHcSOw9lFPifFgu748VlyWuTVpCNmIv4HOpdC9Cyt8a/
         TTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718976400; x=1719581200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxkGI4IDUNtwkih25Bt66Jpt1EbuMgTL6TuQaswoa08=;
        b=cwS0zmhRkjhswWAnZEDYO95WQVXM+pOlkmNnyxW2JqHIiLFwpEjlmmjlKIgCSQuBof
         B3wtetllN8kk4M6b6HElIiOkpNAWfWx2eK5K1ud/TukkKng7TA9AYfYHBvyPQTAzcW1+
         NRUDQMdhMvgu4LQ/iOaftkvFe5hV8WGjTx0aKXOSnJqgDUAJNZpUBsCWUHF4AD+L3hNm
         m0oDeqp1kGfylVvhAH0k6MUpsd8DOsty+zzU48NFUp8faNPW6TqjesOzXt3FUtJqbQOT
         yQccbPQ9EBB8CSw2rBD1FKuQ7OCvUcXt5byR2co/ki8+NXRBg/8cwpEgGXclH7r9Q+P1
         wcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/fadPyIgoFXRHLOxLObQOaxU/xgoki5vTi1Wl2oYMsZpwrxjuLTH9aMBjk2sKYbB2U1+9nAFLlQ//bTgDA61LilZgwOmSIIDei48
X-Gm-Message-State: AOJu0YwUPI7NHPKwMBC4TBL3gs1jxaRQENAmKcT9l/IP1lSmgQwM83+e
	iZO8vGFLoEbA2Uch5aRj0Z5aKRUbGwsBaqQIof4FZAPtudral+qryxMQfoysuWVDodAHvQRV1eJ
	+7LCHQbJWHikwceW2b6foUBEEsMIPNUgVT4ZwKA==
X-Google-Smtp-Source: AGHT+IFJFLnbZtfruK6baf9YWIg4LeyaPPP4GvccEFGIJqLdkPRkvc9ZCu4GwSE7nESYwJfha+my+CzBCme0z4pjarg=
X-Received: by 2002:a05:6102:54a0:b0:48d:b0a3:fe34 with SMTP id
 ada2fe7eead31-48f131a9f6cmr8780548137.2.1718976400058; Fri, 21 Jun 2024
 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621120539.31351-1-dumitru.ceclan@analog.com>
In-Reply-To: <20240621120539.31351-1-dumitru.ceclan@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Fri, 21 Jun 2024 16:26:29 +0300
Message-ID: <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, dumitru.ceclan@analog.com0, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 3:05=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@gmail=
.com> wrote:
>
> The ADC ad7192 is a sigma delta ADC with a sequencer that does not
> require a disable_one callback as all enable channel bits are within
> the same register.
>
> Remove the requirement of the disable_one callback for sigma delta ADCs
> with a sequencer.
>
> This patch could be squashed with the commit that it fixes from patch
> series: Add support for AD411x
>

This fix looks fine.
But, then this raises a question if this needs be to extended to the
`disable_all` and maybe `indio_dev->info->update_scan_mode` check.
And if so, how should this be handled?

For example:
drivers/iio/adc/ad7124.c:    .disable_all =3D ad7124_disable_all,
drivers/iio/adc/ad7173.c:    .disable_all =3D ad7173_disable_all,
drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,

And:
drivers/iio/adc/ad7124.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
&ad7124_sigma_delta_info);
drivers/iio/adc/ad7173.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
&ad7173_sigma_delta_info);
drivers/iio/adc/ad7192.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi,
st->chip_info->sigma_delta_info);
drivers/iio/adc/ad7780.c:    ad_sd_init(&st->sd, indio_dev, spi,
&ad7780_sigma_delta_info);
drivers/iio/adc/ad7791.c:    ad_sd_init(&st->sd, indio_dev, spi,
&ad7791_sigma_delta_info);
drivers/iio/adc/ad7793.c:    ad_sd_init(&st->sd, indio_dev, spi,
&ad7793_sigma_delta_info);

At least the ad7791.c & ad7793.c drivers support parts with more than
1 channel, and there does not seem to be any `disable_all` hook
defined (at least in iio/testing).
I have not gone too deep with `indio_dev->info->update_scan_mode`, but
it would be worth to do a check there as well


> Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callback"=
)
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index d6b5fca034a0..8c062b0d26e3 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, s=
truct iio_dev *indio_dev,
>                         dev_err(&spi->dev, "ad_sigma_delta_info lacks dis=
able_all().\n");
>                         return -EINVAL;
>                 }
> -
> -               if (!info->disable_one) {
> -                       dev_err(&spi->dev, "ad_sigma_delta_info lacks dis=
able_one().\n");
> -                       return -EINVAL;
> -               }
>         }
>
>         if (info->irq_line)
> --
> 2.43.0
>
>

