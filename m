Return-Path: <linux-kernel+bounces-199224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A488D8419
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E2B1F22F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42012D767;
	Mon,  3 Jun 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ZzNp5Jo"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBB15C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421816; cv=none; b=q0EMoDXzz2vDa5/5L7Bu5dmnXCARzRlQrn3TXPS8qTq2EfOCX+7OvxV7xMfHavnYKW3qnQvzecDVF3jp5fb4us9QPoWQ1ymmnnX6VTrWmsP4/rlvCgSnhjEw0xmRN+q+YEfFfXnLAXxEJh4UAikv2Ms7sQypyiVTYwB06Xmrask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421816; c=relaxed/simple;
	bh=ttcizD8aqzGdjnI2golwzJicIDJIicbP6XGksbPjSbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNoqIDq5U5v3ucu6wubiEpNPSmES0RMad3HN3lZokDuNvXzwiNTpoSo1c9tUVTYo47S8+P6uflthvE5n530uyjjYz+tKz/zZekgFnp6aXufNKhZiOdCc5kgorSUffgGf+tFkWcRDFkB/xUW+2GejP5ugbNQwrymy1mQYxdLuZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ZzNp5Jo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8ea563a46so2670785a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717421813; x=1718026613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1qq7UWn5K6k6IOKB88bjuVwYDqNTOU4W22ea0kVcM8=;
        b=0ZzNp5Jo4tBMEv1pSPq8zXUy3rXUlZXtqCeU55Pt0HxMCJ2/LVofO34H4APFhGPlsZ
         4g8SdgrtY7l9RgofhMgygdm4bAvQNpAZYgmgRGIQOiV5HWbRAXdrJnAK1ub2nEOx/95D
         jZ+jeJJtgonEhIw/2KDZgcpDls25PMjUujFh/6a01X5QBH+bVvkN0YpIl0pECbOPFbM8
         F7J1YiL6poc6u5A8LW1vh3xwmXuEiEaP8RoChmThEhefdrQPagDV/nozu17oJjnAC7xX
         I9/W3ubf5JJv5RH9ufhXvXHBCuMhKej5EK7VXPb9yt6j4kngURtw0ASRD7gCTA0Y/2WB
         0G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421813; x=1718026613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1qq7UWn5K6k6IOKB88bjuVwYDqNTOU4W22ea0kVcM8=;
        b=KtmW4v8tShPTng6azNxFLpkymHbNCDdSDikRRWQdwxuUiSgSukjbJzbUjFRxqH2gED
         gDzh0G508oUP9Tk4Lc/+MprQokOh6oKOyz8sUDIlwBrcTuKBmXQUSbBZyTooFR9GAA0L
         tlKd/BCgA17XcYh9T6SJOQZhwHHrkzKEakH8lM3ZX1fxQKXaTBhJ99o3G4UJPkjZDknH
         GpqAZMegKeIrpVGgp/hE7Z8b4VswTB4eAyLuMvKBkOqAloHqH2GDOaGBTiZXHNrIHodQ
         PBGalMFp8PdYT8++5B0Wq96+qXc7/JNlCqrQKEciDTfCaQxWPfnJZ3as/6s3axNw2KVz
         sTTg==
X-Forwarded-Encrypted: i=1; AJvYcCXHB286UYHFd3YEN4oY89sifBSk2VAcm1DZvewOA4Pm7Whxx+MRHndhRcwOj/0iroQfYLgPPIkwZYqbAUwQA9yAZrzZVmulJEak1Rpu
X-Gm-Message-State: AOJu0YzC72C+JKtkX/bZY1PWdTK/AgRMbAz61BOnRyvRqA/NOlRAElow
	rkiT2HUt1f4pmiMPZY2jNQQ0hsrtrNFOb1q7VebMhAiGWkJ/jycehVCHjftjqj8=
X-Google-Smtp-Source: AGHT+IF9WZpfibvv2GmZe4kUX8UKp4KjQFa3htZldW0WfM/LKDyRWEEaJwkOu3xrlySKML7GbL3LUw==
X-Received: by 2002:a05:6830:22fc:b0:6ee:23dd:7441 with SMTP id 46e09a7af769-6f911fb5639mr9510252a34.28.1717421813021;
        Mon, 03 Jun 2024 06:36:53 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054e9acsm1442812a34.35.2024.06.03.06.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:36:52 -0700 (PDT)
Message-ID: <9bcf9ed6-dcba-4e23-9845-a81cf39a3153@baylibre.com>
Date: Mon, 3 Jun 2024 08:36:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
 <20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
 <20240601134828.68c3acba@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240601134828.68c3acba@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 7:48 AM, Jonathan Cameron wrote:
> On Fri, 31 May 2024 16:19:32 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Error messages have changed slightly since there are now fewer places
>> where we print an error. The rest of the logic of selecting which
>> supply to use as the reference voltage remains the same.
>>
>> Also 1000 is replaced by MILLI in a few places for consistency.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Ouch diff didn't like this one much and it is a bit hard to read.
> 
> One case where I think this has an unintended side effect.
> See below.
> 

...

>> @@ -1219,74 +1211,54 @@ static int ad7192_probe(struct spi_device *spi)
>>  	 * Newer firmware should provide a zero volt fixed supply if wired to
>>  	 * ground.
>>  	 */
>> -	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
>> -	if (IS_ERR(aincom)) {
>> -		if (PTR_ERR(aincom) != -ENODEV)
>> -			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
>> -					     "Failed to get AINCOM supply\n");
>> -
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
>> +	if (ret == -ENODEV)
>>  		st->aincom_mv = 0;
>> -	} else {
>> -		ret = regulator_enable(aincom);
>> -		if (ret)
>> -			return dev_err_probe(&spi->dev, ret,
>> -					     "Failed to enable specified AINCOM supply\n");
>> +	else if (ret < 0)
>> +		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
>> +	else
>> +		st->aincom_mv = ret / MILLI;
>>  
>> -		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
>> +	/* AVDD can optionally be used as reference voltage */
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
>> +	if (ret == -EINVAL) {
>> +		/*
>> +		 * We get -EINVAL if avdd is a supply with unknown voltage. We
>> +		 * still need to enable it since it is also a power supply.
>> +		 */
>> +		ret = devm_regulator_get_enable(&spi->dev, "avdd");
> 
> What happens if the entry simply isn't there in the DT.
> Previously I think the regulator framework would supply a stub whereas
> the devm_regulator_get_enable_read_voltage() returns -ENODEV so isn't
> caught by the handling and I think it should be.

Ah, yes so:

if (ret == -EINVAL || ret == -ENODEV) {


