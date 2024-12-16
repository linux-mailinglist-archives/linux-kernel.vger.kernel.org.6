Return-Path: <linux-kernel+bounces-448223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD99F3D21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7957D1886261
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA51D63E0;
	Mon, 16 Dec 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3FeAdsSF"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB171D63D8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386272; cv=none; b=ljf2B04ee3G/vCKwl/VguQPlc4FkOvshwKMTPV6GqX6kqaI84YlyJ+CoQnELnVFCJL1vybSQrKDuh1RC85ps8QaaelR0/X7vlF3S0e8T0sFgDnhu1zbPrg+GaPnRMYW/5lROkKWGXA3GAB46dQNSQ8i9rJnyeFaeP8NMyKufoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386272; c=relaxed/simple;
	bh=8rMjgRuVihNQt5T32hJGRBEMCzfZOnw4DNXhk2Ki1+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhOnCB4kPx1+dDFoxylvNFg9vPQquraGZBjSpdKgKJmjlJm4zvH/jXhguZnbGCxJFyTAUtD+H+vW1LX1Xqxmsuy8S/hKwdC7xCZ42WAru5P9c0lkhXemGUT1cY1AwKRwxGZohtcTJ2pUkp2s1gSW1cEmxj9e3ZOs/oKF2fWMVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3FeAdsSF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ebc678b5c9so422926b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734386267; x=1734991067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJ7JX9Gpdh7spzwrXAZK/HkmX7PEhbWKSdugnt63OEs=;
        b=3FeAdsSF/a1G9vXRpFxg1szI85HiYYmjhEQ+rugt6yWcAVR97FMG3MQyWFFh/Kkwaa
         io8Wiz/gS8Zuqt1t+H1JgyB3mdJIZNN41GSWpKIs1gdYk8PNoVcaNU4ZytyyIpIB+LAA
         rllEhroOKkZw88SDnxWPLDoLbyJA97DMezxUHlWy0XJ0mRDe+VjEFTtoAhK1FXt0LWoY
         qRfwdvrt7ahxgT126Ix8jlaXsslfrLJP/N5uq0Ycpj+1/kwopEkRJn0CfyMNmoaS2BPA
         /4XsmULRPps6Rzd1SLaSHOQKNJWIEr1tyLI3LHpNqyv/ZCyUW4lk9I0xrA47rkva7MzN
         msBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386267; x=1734991067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ7JX9Gpdh7spzwrXAZK/HkmX7PEhbWKSdugnt63OEs=;
        b=l5qVygxJM4lHvAMPvkhnfwTwgw+78t1LzHz0m3iXjbM8Rir9AN6gLl8TsxJmckBp/v
         Abs4eNUUHZ220sRCliTZGUQt7MKHrWtLQIJ+NVAcIM/Yh/lJvlP2ijHsTxPuc+b1spJM
         CQfcwtVqXt1LHL3+bA/WsAYP1FiQqUf2pOPGT6b7I3RAT0BZFjYKxsnnXSC1vDVoXLrF
         hdzyBZDfF0vMddHN7wFxMHtn4B+ab6Ys6ELABCAMkJP8N9ELfpFp559iTb9Z1IkkS6Fc
         n3pQ31SNsAtgXQiOk2GBuAxi3V2n3Bw31WlbBUiTV1pGFUbRiJVseATq8BHF5M8koh1W
         Tx5w==
X-Forwarded-Encrypted: i=1; AJvYcCVm2Nyefvs3XoGxjMRwtV3EBVJ40zPeMO3yPtWo6SqYLHw/ltf8j4jIbd98O9AJgTHLuEMow8Diy7+sgX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGjSP/mHrXHf7zOMSa+VGaY3fq8yt+FLx/rZnwhiadRj56T5W
	NPgkxvGlX4GgiJGjIpvMfNoeK35NmKy8RE07TT3xdTf8dkrlxB4d3bfAnembz0U=
X-Gm-Gg: ASbGncs1sgkn2Y2nhtXrvv4HaL5FYcu4PA6pe8cp/FEXKiQTKzlHxAPm+u9UnQ073Ty
	oZU3VHIpYFRBhjxwG+der6lagQYN0iZemkjLFyGVZURr7ESH9ubr2VDxI7uHJtjLf/Ofxh7052F
	8jmTjwcW0TU61rewJcDF+cxXSBYVdZFcvHs2nG2Jh+lr7nfgH8QWgdEv/GxdRu8nRkHmg0KrX0b
	Un7JAJl9ZMdMGAXFxFfcOVKToazrEvyh5mbMSP8EqONLAZuqEzfB2GM6TpTyxd+z55LUvTVMDwl
	XM1rizxwwf1Eja2kEg==
X-Google-Smtp-Source: AGHT+IEFNoscpJifUIbRm79CtTjEI1Z4p3K/K/Dr2dE8XHjjERVfWchWCXHJTO7qy4YXr0H8ApeneQ==
X-Received: by 2002:a05:6808:13cc:b0:3eb:619f:1aca with SMTP id 5614622812f47-3ebcb367939mr219224b6e.40.1734386267348;
        Mon, 16 Dec 2024 13:57:47 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb479d299sm1814982b6e.12.2024.12.16.13.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 13:57:45 -0800 (PST)
Message-ID: <5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>
Date: Mon, 16 Dec 2024 15:57:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional
 optimization for simplicity
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
 lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, jackoalan@gmail.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241214191421.94172-1-vassilisamir@gmail.com>
 <20241214191421.94172-4-vassilisamir@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241214191421.94172-4-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/24 1:14 PM, Vasileios Amoiridis wrote:
> Drop conditional in favor of always calculating the timestamp value.
> This simplifies the code and allows to drop usage of internal private
> variable "scan_timestamp" of the struct iio_dev.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index caa404edd9d0..6b86b5315694 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -8,6 +8,8 @@
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
>  #include "ssp_iio_sensor.h"
>  
>  /**
> @@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
>  int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>  			    unsigned int len, int64_t timestamp)
>  {
> -	__le32 time;
>  	int64_t calculated_time = 0;
>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
>  
> @@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>  	 */
>  	memcpy(spd->buffer, buf, len);
>  
> -	if (indio_dev->scan_timestamp) {
> -		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> -		calculated_time =
> -			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> -	}
> +	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;

Don't we still need to cast to 64 bit to avoid multiplication overflow?

>  
>  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
>  						  calculated_time);


