Return-Path: <linux-kernel+bounces-228047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C6915A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA641C220E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4D1A2556;
	Mon, 24 Jun 2024 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qCm3Tj3B"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B512EBD7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269469; cv=none; b=m+M9Q4YkZrXW5yQJW9CG6QT299ImoGkusIR0qEa8QJH+LAkocZ8+u9Oe/uXQgAEyDvdrWnWFYHGLrb30xGaFMJE7MKM00gqx/i/Jo1FG9xXYfsgfefDm8juew0rCSyDlqbW0Oa2Q+BsRXSsZeJQbg6E2PrjEYtJ5B0aQ1JuOfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269469; c=relaxed/simple;
	bh=zvWzgsTq3P+0Mdgzi+iZmuD6UIRKkocR4ALPpJOB8bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU/K0vEfRCBpeRDB12hmxignXPfcxqT+XdFFUnZi8R+6oZfsZy+9Dgc13hY5KJMUQw8oHIWb3xn9D1EkUbkMhcMdcsF/uHWWVbr1EgCsCeMP6e9troHEhnfW5K/lmhmVoOI/aqtRSiK+mbvvHgF7aAjEbOsTsIt0QWy0UcNtjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qCm3Tj3B; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d518cdb252so2551674b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719269466; x=1719874266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSMLalLoG8lPuYSLVxw52g/GhJCfhMgtmpMfHHuN7E4=;
        b=qCm3Tj3BaQIsddSWC3pXyU8Akk3VoFis0Dt57fO97uAr9v9bcu06zCUy1lASRdQwP0
         EOJBSmRqa97goiGW9My2U++ZWS2lewJJQHASbFAHWTE71Tji2BdIWLFLt3GFPtj5D/zs
         Y26olSMUbt/kRU3sJeQmaUVUCELNxqFyzxXYkfy/4BExck78tad40fIvQgCrKnpUVl0K
         uicrHYNVKxPTgkk60+lk+/wtqBtS/QR/tS9FHh8csGRkb2tMTINIK2nCFleDF3ZVQrUp
         E07iKB3KYSKMxwwAxKTd636Ligk+QYSawKjqOuKt7KFxt5CZZoJ21bx0g7nJYBbD68Lg
         9acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719269466; x=1719874266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSMLalLoG8lPuYSLVxw52g/GhJCfhMgtmpMfHHuN7E4=;
        b=V/dejdM0FQovImO88iQjMcLsnSCTdz5YAkyiX584FRCMBuR91l54YN+yhXg64LT9IH
         gB9SN3MPSWTiFsE+zppXBfJWMWvlGBaZNi+C5Rt6z/TdrQlC5YTEAb/AASHR0maO9Yze
         rfWWC89Q/DT8/bWFKasHaPK08dtitl+idOlEcNscL4UE7LxRuf/Vlk7ocUEMzHAN+ExP
         rE2khqRJir5Jazj6P1Nta83iytteLv+ZGY7JQBXTPDSUzt712RObMr096c24+8PL9Z3/
         H1WtMMmGG9TUsSCwbxSfuE2kpDYrQ2kBDZMdrPPXSUr3aSpRuzoNDiAikD8YbAUA5ejc
         LE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXvj9Jaf0QO+P+wXBRKAa+IOMBbwDBSa9GsLVG+njz3y+0/GkeKRYdBhMPVB9FnmO3GEOdvczyZymtiPEnrX6RdcQHFK87xxgamrpsH
X-Gm-Message-State: AOJu0YzybHRf4WJdpehIXF42uRsRxVpGTOeSK2B1M4UYYNVcKh2rWUWV
	DKaALA7YrhlNjHF50b9WNsCR9nvaA4EdafSiagRwtSti2O9lhzUtuPcSWVOWH6o=
X-Google-Smtp-Source: AGHT+IFEgKMQ0KzJb3GzFBxAKLmZWqCWQSiAPzPkM5FnZP8YbirfIfWJTrgLNLNXsuor9teoG1ivgQ==
X-Received: by 2002:a05:6808:189c:b0:3d2:2780:1c8f with SMTP id 5614622812f47-3d54594f36fmr6962253b6e.4.1719269466564;
        Mon, 24 Jun 2024 15:51:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5344dde49sm1672731b6e.1.2024.06.24.15.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:51:06 -0700 (PDT)
Message-ID: <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
Date: Mon, 24 Jun 2024 17:51:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
To: Jerome Brunet <jbrunet@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
 <20240624173105.909554-3-jbrunet@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240624173105.909554-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/24 12:31 PM, Jerome Brunet wrote:
> Add support for the HW found in most Amlogic SoC dedicated to measure
> system clocks.
> 



> +static int cmsr_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
> +
> +	guard(mutex)(&cm->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = cmsr_measure_unlocked(cm, chan->channel);

Is this actually returning an alternating voltage magnitutde?
Most frequency drivers don't have a raw value, only frequency.

> +		if (*val < 0)
> +			return *val;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */

Shouldn't this be IIO_CHAN_INFO_FREQUENCY?

Processed is just (raw + offset) * scale which would be a voltage
in this case since the channel type is IIO_ALTVOLTAGE.

> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
> +		if (*val < 0)
> +			return *val;
> +		return IIO_VAL_INT_64;
> +
> +	case IIO_CHAN_INFO_SCALE:

What is this attribute being used for?

(clearly not used to convert the raw value to millivolts :-) )

Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
so far, that has only been used with light sensors.

> +		*val2 = cmsr_get_time_unlocked(cm);
> +		*val = 1000000;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

