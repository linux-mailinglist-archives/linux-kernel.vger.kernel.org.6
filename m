Return-Path: <linux-kernel+bounces-273538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBB946A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062C91C20B80
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BAB1514C8;
	Sat,  3 Aug 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugoymLE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C261ABEA7;
	Sat,  3 Aug 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699068; cv=none; b=UWUbpg16msRvJ3L40EZsqq5KqIQSD+qm8SuHUYepubC9uEWgYJeuRu7BcAZb/angS6IQVBHTPLU9dV6YMhw+0IgvuGtE4P7WqOeuHiGQpf5F/S8MvlwCh2D8K41/Hn3H7Bku7MoUwtH+TjxV65OvcqkQZrCtZIDe785lGgWBfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699068; c=relaxed/simple;
	bh=PASu6Au3qgd9JCbfIasEpkylArSWHCZ5u9diCjgA8kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnwpBLSqyw/Phd7uKF+2f5PTqy/DaJ4TFdQWGnjyJXjkhM6ZOS0PKXgXXXBEk3pInk872x0ftsSoXYJS2YEV2zJSGVlVJnr996xWOGc59KBvkrFPkq3TlO86moW8NkTtdjbj2MP0bkXy6g7hOX333ntHkJmWIoM+MMrAlg7XJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugoymLE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3785C116B1;
	Sat,  3 Aug 2024 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722699067;
	bh=PASu6Au3qgd9JCbfIasEpkylArSWHCZ5u9diCjgA8kY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ugoymLE5lYJHcYes0J6f6GbEVWRaqmobmRJ9ASPnj4FId9kl89OWE2uAdPsCocPOC
	 EdCdJxABtKBaqJqT/KgM19oPwos25r4XcRCVLS+EgtzF1yFj4O7fPXBe8lh6m/JR64
	 kg+aUnq4hmhKpQIr9GcvTWIK816RKwM+RxrXDq5lYYfdfjM/45v02Ei8F+aG9ByhQR
	 6lg0KXr+mEaUi9w+PPcxi7mb6mrgmSBPFSJX83EEA80+F8Jx9HY+LSewMScoOfLZ3o
	 ZEnN3ystOTDLcw2PHOm8zFtEhZmtthmAkE8Igk8WkUjNHHbCDcpPN9is/rAOeceEcg
	 +xcT7m0FXsGbA==
Date: Sat, 3 Aug 2024 16:30:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: fix scale application in
 iio_convert_raw_to_processed_unlocked
Message-ID: <20240803163058.369cb426@jic23-huawei>
In-Reply-To: <20240730-iio-fix-scale-v1-1-6246638c8daa@gmail.com>
References: <20240730-iio-fix-scale-v1-1-6246638c8daa@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:11:53 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> When the scale_type is IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO
> the scale passed as argument is only applied to the fractional part of
> the value. Fix it by also multiplying the integer part by the scale
> provided.
> 
> Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Ouch.  I only vaguely recall the history of this, but I suspect that
extra 'scale' was an after thought and we messed it up.

Anyhow, applied to the fixes-togreg branch of iio.git and marked for
stable.

Jonathan

> ---
> I found out that after iio_hwmon switched to
> iio_read_channel_processed_scale() to convert the power channel value
> from milli-Watts to micro-Watts [1], lm-sensors started to show
> unexpected values for the power channel of the pac1921 iio driver I was
> testing. It looks the issue relies in the
> iio_convert_raw_to_processed_unlocked() function that only applies the
> given scale to the fractional part if the channel scale type is
> IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO.
> 
> For example with a raw power value of 71, a power scale type of
> IIO_VAL_INT_PLUS_NANO and power scale value of 9.775200000 (mW) the
> processed power value would be ~694 mW but when scaled to uW by the
> iio_hwmon calling iio_read_channel_processed_scale() with a scale of
> 1000, the processed power would wrongly result to ~55678 uW (~55mW) =
> 71*9 + 71*775200000*1000/1000000000. This because the scale of 1000 is
> only applied to the fractional part of the power value. Instead it
> should be 71*9*1000 + 71*775200000*1000/1000000000 = 694039 uW.
> 
> [1]: https://lore.kernel.org/linux-hwmon/20240620212005.821805-1-sean.anderson@linux.dev/
> ---
>  drivers/iio/inkern.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 9f484c94bc6e..151099be2863 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -647,17 +647,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  		break;
>  	case IIO_VAL_INT_PLUS_MICRO:
>  		if (scale_val2 < 0)
> -			*processed = -raw64 * scale_val;
> +			*processed = -raw64 * scale_val * scale;
>  		else
> -			*processed = raw64 * scale_val;
> +			*processed = raw64 * scale_val * scale;
>  		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
>  				      1000000LL);
>  		break;
>  	case IIO_VAL_INT_PLUS_NANO:
>  		if (scale_val2 < 0)
> -			*processed = -raw64 * scale_val;
> +			*processed = -raw64 * scale_val * scale;
>  		else
> -			*processed = raw64 * scale_val;
> +			*processed = raw64 * scale_val * scale;
>  		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
>  				      1000000000LL);
>  		break;
> 
> ---
> base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
> change-id: 20240729-iio-fix-scale-287b7630374e
> 
> Best regards,


