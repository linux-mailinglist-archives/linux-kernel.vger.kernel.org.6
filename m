Return-Path: <linux-kernel+bounces-247555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2692D121
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D669B2758E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A0191489;
	Wed, 10 Jul 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jHbGRvZw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B673190675
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612626; cv=none; b=biK4LCvb5rtVqfay/ZekBsUHid2ZDkmQrWNn/bkpodLhBFtlIXWW7rIUU4KATyP6h+FYiEfMaSYW7ZlF31PsXm+Bz50rdYyVQ+EwQmha0az1rSVKHv7Fltnd9ktFsEdU9j19L4qu5Lm76Z3HAoAyp+ZjRuXw4qH65JCT6ukrFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612626; c=relaxed/simple;
	bh=WsDlAVZcBSC+PHsEZqH18u+wQ7q/gzTehoBiGRVxn5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiIU9uMLb9vzoeUzo+VEKyf8LbUiDu7gH1VlPRqwKuOSCNKL3frJc47OCCLJsFfaBGdkVq2L85zdk8M/3xeYSu2s4nFYX8TsCNuOmPexdafnpjbA7OTJQpn86sCMMJhqmyT+HHgTuhHBQO8MIjJV2kTw1JGA3Rsz/iMxTN2Lc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jHbGRvZw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so82824011fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720612622; x=1721217422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwfoyeupSwjDIeqWgElN6yiHYZ67SywUBwzOBWbpi4M=;
        b=jHbGRvZw4Q4ynOGgQz5WTsPB0uAl0xSKqNdp4EclEJ4rX0Q9N6neiAushlS1yAhmIE
         UnvHPXeUqj1BM1juCQyB25y/JULYpZ06PDQGSO3jspn8TTBktX+nBakp9HjOBW4uB2+0
         FlILHHUHdDfc8Ku7NwG5V+fssYO5WP7KrSBL9JmRq784OhEClSjDNccUwjMpqqmsE47i
         AJRZ4bbspk+DtXPYDpJ0hqPxBF+djWGZe3Xdaj+kcyP8xj6qwmmQIp9AigtyGjHACW3/
         T6gG7IxpIE0ThbG3rnoa/A2h5ElJp1GBZKsiBIRx+C8JNy0cuaRjDS0gfKxUR6eCOORO
         UFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612622; x=1721217422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwfoyeupSwjDIeqWgElN6yiHYZ67SywUBwzOBWbpi4M=;
        b=c4TTFtzqTDqBCbLZZUeq0/iW8Put9oIurU0Ehe6ZHYvFitdvAsyhQEzvb32LbX6ZiR
         QF+C+5RNJG/lcfJUzkBY90JKCssLh3mpU+pNNFyXaO8Gk9QWq7YPane+vKM2K9LJ8QRp
         Eq5MQyDOQrDQITon14krdAFxQrVgS+GQfKeJoMOlTR2jbNvKW5a5Y6j93a1V1VhJyQVM
         kuLV1T9+/5WIyI16HfwQgQJlZFHSFzLCRfUXYatPeWPNAZ1z983/zkIlBdo0OkhK2x83
         THt3vku7LffQQD+xHBiAolxzISC/nCUL9hSDC4WPSke5ePb9ZHffg81PcSBg/Dc8SPiV
         By9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl0pZ3ukOQ07/Pm+NgqNTw8G5/a/UXzdIVfaaqzvNAglOHhiI9Q2FkcdiNDYW82OuPdGykSYFw6NGW+9JaCtPh/ipumYepY5UCj2UV
X-Gm-Message-State: AOJu0YzHLvbS4h3cqZMftQetfmwDEngZOpftb+kubHSjDZl32X7ynmh1
	uybl/aW6LbGolseIOlQWL7B77T2s/eVx6O9xk5QHvDiASyivfuMRpaboH7Yw3VRf/7AQJwmICGy
	MaKeXW5DwxNCiuFbyZBiNKe5AIVUrJwO2DTR0rw==
X-Google-Smtp-Source: AGHT+IHJGswK2Y+OebO2SiwrHVLpVQDHaAegDJkVw5rzzL9UruW2bK24KpA95w5gRrAvh8NQOgUtDeLzV9pkwgRp238=
X-Received: by 2002:a05:651c:b23:b0:2ee:8736:6c19 with SMTP id
 38308e7fff4ca-2eeb3102b5bmr42639441fa.30.1720612622161; Wed, 10 Jul 2024
 04:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710082813.2287329-1-nichen@iscas.ac.cn>
In-Reply-To: <20240710082813.2287329-1-nichen@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Jul 2024 13:56:51 +0200
Message-ID: <CAMRc=Mc=0LgyH432JWCfdTwty1sYPX=ZViuoL6u3K_1SW5RnDw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mc33880: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linus.walleij@linaro.org, grant.likely@secretlab.ca, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:28=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: c103de240439 ("gpio: reorganize drivers")

This is not correct. The commit that introduced that issue is
1e5db00687c1 ("gpio: add MC33880 driver"). I'll fix it when applying.

Bart

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Add Fixes tag.
> ---
>  drivers/gpio/gpio-mc33880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
> index 94f6fefc011b..5fb357d7b78a 100644
> --- a/drivers/gpio/gpio-mc33880.c
> +++ b/drivers/gpio/gpio-mc33880.c
> @@ -99,7 +99,7 @@ static int mc33880_probe(struct spi_device *spi)
>
>         mc->spi =3D spi;
>
> -       mc->chip.label =3D DRIVER_NAME,
> +       mc->chip.label =3D DRIVER_NAME;
>         mc->chip.set =3D mc33880_set;
>         mc->chip.base =3D pdata->base;
>         mc->chip.ngpio =3D PIN_NUMBER;
> --
> 2.25.1
>

