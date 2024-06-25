Return-Path: <linux-kernel+bounces-228719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B99165E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12971F21AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04714AD2C;
	Tue, 25 Jun 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zra+vPBh"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7931494A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313983; cv=none; b=m8+WWEbNB74MnznrSVh2EovL6TBb+QQkl/b70AyL02ldLMHdWO6ZAjZ9I9gIVCGz4hQ1OdGompP0TZ0UCCf2tX3sDTAaslOrZIEzoOLMxxTFZiRVy4vzb1B9smF4GqU5w1cwaSRxfsvr3KC5FeAZEwIc4oaJcj6F5Bo+u0QbUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313983; c=relaxed/simple;
	bh=ZPOD4YjlpbiEJX/ltS7DkVMVnGceP4CuYQ83WTgqyEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVHgW1hHb1Og7gnUILJ6y3NfkDhD/CTTSWdgcrK5bHdZpCrHBoOo8M0dUOnWdlMvKbDjOgP/nXgGntp1C9yhUxKXn91EwEznrluDzN5bZY47wJVPWCqRN3tYStgPlDv6/iepf7nV5qVRef9xWy2TUB7waRexKZND8bJ0IT0gKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zra+vPBh; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ef6b201bf2so85127e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719313980; x=1719918780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUdVCzPrKxaha8DCYOqNe6BhofBEMrLm8EHJxR09Qzk=;
        b=zra+vPBhjcV5lDNyDqPbYB94gSDfl0Ki3iz1Q74HF2xrKTLyJqYr/OtQJopB7tbIQX
         lAV3AL/pN43G9tYV2e6+L2ah2ecS3jHzsNMS5DgWop788ZAfZ/RS1dMPyMLM0ZUUIuz4
         jGErah7FFaVquvjv5ju8zgk/nLrDZLMacZWINRk+G+NV9/JKpW9WzR7qDxiamWjdZYDb
         edVi7Xsc3hcOvhzoGjIbGozkJWcOxAoluuoKzjeV1wtiIondHvrlpx6+GjjO2DB+Ba0U
         Ev5b95zoyQNx4QrL7qDWq1QdBKM73FgKjVsghXI6L16m0tScOkWWypkfw1cgaFvleYdz
         jh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313980; x=1719918780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUdVCzPrKxaha8DCYOqNe6BhofBEMrLm8EHJxR09Qzk=;
        b=TLomNciE3U/ARxNUIvzs3W/zqpgq44etSsOFzk5l2UoMzklwu0typZkztXh7YhxWbr
         LPVHeS+NTzdW5q42IzoBkuNWhHnaKN4KoirnbI9j8EiUL9EhxJxQwBVf54yvNkKkL61+
         nPmHqlsVJQD9YDn/B4DSWe262G2ZftBslOHiIxu5TJ+rAHnS08K7p1D7IqK6whzBn0C2
         oKUE3KGaEkt2VgGw2+stDY+y1kb/Sx0Zsw4Fuy+Regi7G9XXk9rdBduQ1+duyubAG8bJ
         0+Yi2Ah0auva2xVFpmJGVog7jJrZXAbpA0iwlHb4SnoNb0QMvi+FaDD4Mp1dPb55CW2B
         +Z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRSd9DR/BtLI+hXqzJh42sSKnKhGDWEnID0UTsYnT4Wm0Aq4tCLICIx2z5W3ifkQSUzA3J9XT4HcNqcfCTZpuOq01fR1tsqZCtWz/V
X-Gm-Message-State: AOJu0Yz5JfpFX7IFvXU0MVVPBYnr6bVUHfyam8N1DQR7lcOU44/RtcwN
	wXaS3m7yPjn50kT72oINC8EVRx6kpsuEUE6q7fNXKiT4A59zhwvTE5FifHn76AgopY+xGRFMO2P
	Np6wJtuZLLzPIX+Rr6nKyXw8EmrvAbcpjxqnJNA==
X-Google-Smtp-Source: AGHT+IHpe8LdBovfaRlXpDtzomRv1Bjvca6P5F6RiEUH4J/fnXdzVhMiVhAsyolKVTaZ0xuC+GqLv55SLpkJWswGfz0=
X-Received: by 2002:a05:6122:6025:b0:4eb:106:217e with SMTP id
 71dfb90a1353d-4ef612ca047mr7207047e0c.1.1719313980334; Tue, 25 Jun 2024
 04:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621120539.31351-1-dumitru.ceclan@analog.com>
 <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com> <7f61333b-1d43-4321-aa51-79273255454c@gmail.com>
In-Reply-To: <7f61333b-1d43-4321-aa51-79273255454c@gmail.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 25 Jun 2024 14:12:48 +0300
Message-ID: <CA+GgBR8JoeUPKVs6h3-ucJk_AuzKyn6TWb0ZozsXYqcxSsmFuw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, dumitru.ceclan@analog.com0, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:45=E2=80=AFPM Ceclan, Dumitru
<mitrutzceclan@gmail.com> wrote:
>
> On 21/06/2024 16:26, Alexandru Ardelean wrote:
> > On Fri, Jun 21, 2024 at 3:05=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@g=
mail.com> wrote:
> >>
> >> The ADC ad7192 is a sigma delta ADC with a sequencer that does not
> >> require a disable_one callback as all enable channel bits are within
> >> the same register.
> >>
> >> Remove the requirement of the disable_one callback for sigma delta ADC=
s
> >> with a sequencer.
> >>
> >> This patch could be squashed with the commit that it fixes from patch
> >> series: Add support for AD411x
> >>
> >
> > This fix looks fine.
> > But, then this raises a question if this needs be to extended to the
> > `disable_all` and maybe `indio_dev->info->update_scan_mode` check.
> > And if so, how should this be handled?
> >
> > For example:
> > drivers/iio/adc/ad7124.c:    .disable_all =3D ad7124_disable_all,
> > drivers/iio/adc/ad7173.c:    .disable_all =3D ad7173_disable_all,
> > drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
> > drivers/iio/adc/ad7192.c:    .disable_all =3D ad7192_disable_all,
> >
> > And:
> > drivers/iio/adc/ad7124.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > &ad7124_sigma_delta_info);
> > drivers/iio/adc/ad7173.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > &ad7173_sigma_delta_info);
> > drivers/iio/adc/ad7192.c:    ret =3D ad_sd_init(&st->sd, indio_dev, spi=
,
> > st->chip_info->sigma_delta_info);
> > drivers/iio/adc/ad7780.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7780_sigma_delta_info);
> > drivers/iio/adc/ad7791.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7791_sigma_delta_info);
> > drivers/iio/adc/ad7793.c:    ad_sd_init(&st->sd, indio_dev, spi,
> > &ad7793_sigma_delta_info);
> >
> > At least the ad7791.c & ad7793.c drivers support parts with more than
> > 1 channel, and there does not seem to be any `disable_all` hook
> > defined (at least in iio/testing).
> > I have not gone too deep with `indio_dev->info->update_scan_mode`, but
> > it would be worth to do a check there as well
> >
> >
>
> disable_all and update_scan_mode callbacks are required only when the ADC
> features a sequencer, as in you can enable more than one channel at a tim=
e
> and the ADC will automatically cycle conversions through all enabled chan=
nels.
>
> This feature is signaled by setting the ad_sigma_delta_info.num_slots att=
ribute
> to a value >1. The only drivers that set .num_slot from what I see are:
> ad7173, ad7192, ad7124. So only these 3 are relevant in this discussion.
>
> For ad7192, disable_all() is useless as both ad7192_set_channel() and
> ad7192_update_scan_mode() actually set to 0 other channel enable bits.
>
> I do not see any reason at this moment to extend this to disable_all and
> update_scan_mode.

Ack.
Thanks for the explanation :)
I think I also misread the code there; I was thinking num_slots is
related to the number of channels.

>
> >> Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callba=
ck")
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >>  drivers/iio/adc/ad_sigma_delta.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sig=
ma_delta.c
> >> index d6b5fca034a0..8c062b0d26e3 100644
> >> --- a/drivers/iio/adc/ad_sigma_delta.c
> >> +++ b/drivers/iio/adc/ad_sigma_delta.c
> >> @@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta=
, struct iio_dev *indio_dev,
> >>                         dev_err(&spi->dev, "ad_sigma_delta_info lacks =
disable_all().\n");
> >>                         return -EINVAL;
> >>                 }
> >> -
> >> -               if (!info->disable_one) {
> >> -                       dev_err(&spi->dev, "ad_sigma_delta_info lacks =
disable_one().\n");
> >> -                       return -EINVAL;
> >> -               }
> >>         }
> >>
> >>         if (info->irq_line)
> >> --
> >> 2.43.0
> >>
> >>
>

