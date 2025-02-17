Return-Path: <linux-kernel+bounces-517158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B9A37CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580C73AEBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5D19E968;
	Mon, 17 Feb 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swhK/EsN"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2419CD13
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780030; cv=none; b=LOhS2uNI7nElTu+EpiRG69m34+jtuQj6A5E88UKSAqc04rlOfGsNihBCt86blwySLBR9hrNIUIRXzRDJl+DO0J+k8hxLtAyaPU8735vqgXgDo4FwJb+Z3KGhsdwjrblEIz77824GekGgVyygpXSPFVXlGlW0N/95YErrgHDdvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780030; c=relaxed/simple;
	bh=2vvsH++oEpgrzni4cOBmpiTecWbiP1mZzNBQJfLduOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY13u1AdsZIoxVw7+t39iYB1o1fZpKOQaW/XgSQKeJr5sR3xrq10dTJDrdBX+eS2CLNFQ7S2XZKt7GSWn5QVbdJ2j7WImrUnfGc35byehStb3TcXq0EbzQSmEFXn8nITJRdVQ07fdYGU3Let5Y6Ou9NQ711Vm0LRx4iwgl8+/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swhK/EsN; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so4065854276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739780028; x=1740384828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vUvD6Wb4bKbXDA5rYCKjnBSk2CkpRNTlFl4Z6+I6yk=;
        b=swhK/EsNTxGla0Xy7CyXAsMcXkOOXrL3RuJNT0MbNVkZX066uW4mOHMDkroiohShaA
         K5NzmeUU05YkhxJHxW926A3xsZmXAmr2hFtqbP87YkVMLg8XNuGL8BXWutOughgF11Y6
         ge+o7WwJ2I7rf3hNqUMA17sghumRwYx0YllNUWNI1i23O8RFgt5iODqNl3MZcSRPU13H
         YE1VZO/jr85NSp4OrVN3gu/Yzv0KkrNGfNyThEbaNUkZWpZq2pvMKDFbP1ZV/+/pDoYc
         EQR+0SRJcFR/vIc3r636iCVsxDy+T0NUHP7VwQgpipwiGw3boUboab++ZaSmecz4rYKE
         Xdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739780028; x=1740384828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vUvD6Wb4bKbXDA5rYCKjnBSk2CkpRNTlFl4Z6+I6yk=;
        b=SRfbkD1kstPLwmvur2L7EEKBB2FscOmSHfGo7nR3TN7miW/vgCMPz5d1R3DHhPulGI
         U5r21ZA09/631x19GXCikjzjecO2vsEyDNx7KwCgwFt7W0jp/uOm5kD7Cshcgx1GCBri
         pQE7SgCY/fYFg2XCCopHWCwyK6byHjncTNkacmHnyNTlcg6Nh2NvNGjsZ+jNVDpEVxeu
         Xxqw7TWjRt1D7DTlIaVs1HvjNf0shMKiXogEFUVkHbIQGYoQDRje4r+wnqr+H1TO/oVq
         zFOP5pv1uTFVYACbaiQtK63ubvxEeImn30nNx9XdfLDypYkzZBUYxKoJwDnK1XXFf78J
         W2rw==
X-Forwarded-Encrypted: i=1; AJvYcCUOdCg9N2vZDGEm4e0Tet58Yf8bUISUGLD71VZDDoXdCfWKzEClJ9qgfIcCtVkmT8LXgU0FGYA6G5tj4Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTibX6LeGvqt54f5eT59HAPv5aZeribnbFxkBpe6DGxXpnrOf
	mpmK4Xmqry1+c8V1XdfmPZLhWeS5COcuGZIFOth8u2vSeJX7IgSazb+Dqa/tboqyGk9jDohpl7i
	34jYIW53JU4uY+i/YstErCKyQSUiR6kX/OoBsRw==
X-Gm-Gg: ASbGncswWQ8O6nEalK4C9EnmCVZqO2dxsJ9MO7DAxzK2A10kgDhXQo+PPVnhPFl7qOd
	pac6KUJ+JXwF3KVWQf9zZTFx0n7X+J6Nub9f0vm0zh7bz9tXUVt+eVbp33mgml7wHCjPX6vnCOo
	HalqjN6mMHd3rAy0JwY9QywAtN+Q==
X-Google-Smtp-Source: AGHT+IGhG4JmDjohhAOxK6zQC2HkB4OQJvmeeLoUtAY1aE04jtCBv0KkcdwOEK/nu8lJGd5cCt6O3CicDfDqEiyc1HQ=
X-Received: by 2002:a05:6902:72e:b0:e5d:dced:9ce3 with SMTP id
 3f1490d57ef6-e5ddced9e5amr3523969276.25.1739780027735; Mon, 17 Feb 2025
 00:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217145642.410f6a1c@canb.auug.org.au>
In-Reply-To: <20250217145642.410f6a1c@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 17 Feb 2025 09:13:36 +0100
X-Gm-Features: AWEUYZmKr-hV9zmc9eGWoJMPooRZiXyITAh8y2fKaHgSl5uWAQAPKS7Kw6ypn9I
Message-ID: <CACMJSesMvFBd3cvCZgD+02puEMbNgrxKgSvJtu23rt6fAAOMvw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the iio tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Angelo Dureghello <adureghello@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 04:56, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/iio/adc/ad7606_spi.c
>
> between commit:
>
>   d2477887f667 ("iio: adc: ad7606: move software functions into common file")
>
> from the iio tree and commit:
>
>   8203bc81f025 ("iio: adc: ad7606: use gpiod_multi_set_value_cansleep")
>
> from the gpio-brgl tree.
>
> I fixed it up (code was moved so I used the former version of this file
> and applied the following merge resolution patch) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> From a1072aac97bdaf3042fe2def4d7e6e7fa928cfbd Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 17 Feb 2025 14:52:30 +1100
> Subject: [PATCH] fix up for "iio: adc: ad7606: use gpiod_multi_set_value_cansleep"
>
> interacting with commit
>
>   d2477887f667 ("iio: adc: ad7606: move software functions into common file")
>
> from the iio tree.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/iio/adc/ad7606.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index cb3de1bd15b4..7d83bb320249 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1259,10 +1259,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
>          * in the device tree, then they need to be set to high,
>          * otherwise, they must be hardwired to VDD
>          */
> -       if (st->gpio_os) {
> -               gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
> -                                     st->gpio_os->info, os);
> -       }
> +       if (st->gpio_os)
> +               gpiod_multi_set_value_cansleep(st->gpio_os, os);
> +
>         /* OS of 128 and 256 are available only in software mode */
>         st->oversampling_avail = ad7606b_oversampling_avail;
>         st->num_os_ratios = ARRAY_SIZE(ad7606b_oversampling_avail);
> --
> 2.45.2
>
> --
> Cheers,
> Stephen Rothwell

Jonathan,

I'm repeating my offer here - I can drop the iio patches from my queue
and let you pick them up to avoid conflicts in next and during the
merge window. How does it sound? It's still pretty early into the
release cycle so I'm fine with rebasing my branch.

Bart

