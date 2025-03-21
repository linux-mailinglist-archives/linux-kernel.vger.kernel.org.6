Return-Path: <linux-kernel+bounces-571412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38746A6BCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287503B7F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC418E025;
	Fri, 21 Mar 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rBsrMy6n"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731470810
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566736; cv=none; b=g/ahINPbmf9zDShT0HZyANKSjs43EFDTECUCQkTkR/1+2DJ3wBv/a0u8f3F1oeGccMt9cqMPhrSZCX90T8jSWUC6LegQgybWTfjsSdUIepH7YJKknYB0HHPwJqhdo9qx+EuPntod3rr7ZJU7uXU2yr7SAIpRpghR+ztyYMH8cXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566736; c=relaxed/simple;
	bh=bfFRi4z/7jSJjPvsuOLCgub6ogXLiNJvQoKAD9aoDm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTfZOZoCueVVargAEZWSyWNTnoFwHFz8pPKW5/gxrPk7flOrDJUGgr1ou/u4VPkBM6f1Qqn7VhwZmI00SBdY3Bk7KzvlqyhJDm0HhhlDrrhdzuy7YcAXpvwXHkC5QHVhrieDFQdH30SiypioD7bAUrV7kKuI96fHfmKISyvKaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rBsrMy6n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1222057f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742566732; x=1743171532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTCuNlHeDEjqfiQIo2HNGd6+ErszhZgpd1Iv8erXCzE=;
        b=rBsrMy6nrvXBVBwFm1+CIYoJ9DiwwwCJlrGI0cVIePVp6cQP7fWIb1J5WjzAooO9hg
         9qzrw6QK5pwQuYBKtQFGOV0YGaBziTstS1QJ3Pv782EW7fK7xMDo88r4JJyL+hAbn8mI
         yzKOErgNvFHBVtXuV5a4y8245DioAupxs2AF9oiHm1m52kQAbRs6goqW+x7BFWAJDvVf
         10dXpart+oYh42kZtDMOxNwGkGAVYkn/jxiRiWHtb/wjJ55duV0/7JpCBdmKoNaCYdsV
         elIB224nxy7vimowTNMyJ6ixNIFC5n2s2I0EW6h2CCVPus2uxjS9Q7AwcPC8uF+VwIdx
         3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566732; x=1743171532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTCuNlHeDEjqfiQIo2HNGd6+ErszhZgpd1Iv8erXCzE=;
        b=iaqE7rCEjEDW71L9U5Id62NXt0EBlZbz8MwRroGaIA9TP1HYPSdACh3gPDXca6HOWW
         7NUmBmZ+7d9adMwLNoe9DG7JcITuR+onegH6uMcBFQ6grGHDzPADPu7ukAF0JaANF6DK
         7LeHYsUZZiCLBVKmwFRB1WzJUJcXGyI3jXVB1d/2HykMwMoNnhxRgufRywnJCSNlMjmL
         a8tD9/+z6CPfG35dCf0F/6UNb1lpxVfy9vhZWkRW6WjukjITqnM7RF7KI0+ub94wG6wJ
         UbjYXJ0qe78LHpE+4XZxAboM2RfHcbuMxZMCxnYzbCFz/WkzOSb9ppliYAAz22oaMNzT
         Svtw==
X-Forwarded-Encrypted: i=1; AJvYcCVU9U22g6WCs7IxRWVyBU09TgSsNi/ta815RxhMP7uq8UZpMUsA1Mb7Bhe3HQAWM+tA7QNEx8Vi3hzAX9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQk0Oa2Z8K8esSRzR+Fy76TYJqqZZZXbonaqrMEeVfpFIyIKHS
	xksvGwO/4WJd/S6cY6bUP8uVNjNWAFrj0Da65rkwAGsIMi419/y12BnMP9ISsro=
X-Gm-Gg: ASbGncsw3vtHUanH9NSQp7D5W1VaeR6z8idn4WEhwiyA8Hlyte8HfKjLKIi1xnqiGZJ
	Ily1FZxZehRJv4P3NrIJh/ZY7Ny09vLR4cp+yLkg2Td/49oof2pM9+/nxur5oLBrTN/H97WpV5R
	OYjawjRkyB5+wEaVay5SMW4+fReENCv0bPXXCUV4pIuWD2zudJEnwk8/DnNNTRyzldu86Z/s7Sv
	2HGwrlXzqU0f8ysBp3JrLyK/EDJVTGbwulhYVVSjt5ch5XLIB8vn7f5mK2w5X3kFkFEglOgJa2z
	QUWMKCuf6x5rD95DmHl3r7dPEgz3w1E9blIPbd9DoTXYqn3S7JGFklSJV9e5vVLAOQ2kcTj0bnQ
	RBZ4=
X-Google-Smtp-Source: AGHT+IHa7BgLygegVfy/7chkhJMYNIbp+e7r7rdlSTbhjyTD35Fk5o6wqITu97HanApN/HYlGGD+gQ==
X-Received: by 2002:a5d:64cc:0:b0:390:f0ff:2bf8 with SMTP id ffacd0b85a97d-3997f8f6555mr3776150f8f.10.1742566731818;
        Fri, 21 Mar 2025 07:18:51 -0700 (PDT)
Received: from dfj (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c90sm2556348f8f.36.2025.03.21.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:18:51 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:17:33 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
Message-ID: <7fcwd33q7ddeiwuga2hhsdc43zse736i6ka5i55lk2qbfdsgwc@gmgan46wcnrh>
References: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>

On 20.03.2025 11:21, David Lechner wrote:
> Move disabling of the SPI offload before attempting to use the SPI bus
> to write a register in ad7380_offload_buffer_predisable().
> 
> This caused a crash in the spi_engine_irq() interrupt handler due to
> being in an invalid state.
> 
> Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>

Thanks.

> ---
>  drivers/iio/adc/ad7380.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e297ad5d01d 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  	struct ad7380_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +
>  	if (st->seq) {
>  		ret = regmap_update_bits(st->regmap,
>  					 AD7380_REG_ADDR_CONFIG1,
> @@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  		st->seq = false;
>  	}
>  
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -
> -	spi_unoptimize_message(&st->offload_msg);
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

