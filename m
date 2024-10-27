Return-Path: <linux-kernel+bounces-383415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CF9B1B71
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175C21C20826
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B82905;
	Sun, 27 Oct 2024 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LgHAYP1i"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8979163
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729987549; cv=none; b=NNRks8z8vJfHw478BXNF3u/rJcibb0Hi6o+Up9CixihwFsZSM7NuNJ1I+9Gug2Lci8RO/FZtzLj0d8VOa/zpWWxDNYiGi4q0nBgWmIKlTgdTCpyWOjK+FkkdRD8S84WyhfFv1NiH0BP5yE3DTltqC2otZLESC3sLSclVlr+ScNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729987549; c=relaxed/simple;
	bh=rhNqL6LpWEWixs6iOXUkMmfhp2PA67MLc6HniPmlhP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNZx/f3b7p/65l1x2FX/Ptx1Qvxs4AglyzQvWuci7zr/15uTw9Y5X+AzJ+Lb3ecCNI8PbL7XD/voTf0CUFIf7JHmX7h7b1wwJ++NnN3u7d3139z/CKH957CMcdy9OZpyFK2l4SlbjkpojYgDRcYQForDIS8drBh8lIToIZcQ2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LgHAYP1i; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71811aba576so2207109a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729987546; x=1730592346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBo+UfmYoZrzMsNQGjuBCfg8tOJuRj5Gpe5nBXU7kng=;
        b=LgHAYP1iX/+TLP10vWgNzWpuo7XrxPAfODUgLn8QiLBWRqZfQyoV40qa7ooAe3+baG
         Ra9KDIMDJ90CPPDE2YCSULSucFiqjkk0owOm2C+1JIMIqZhvT1eqMKwS6Y7MFWmnaKeS
         diSKGzjV0gS8hjGsJB79V41YfE+FuS4Y2AW6536RuC2LeCf7Pbpi8m+iu6bdML8JImmm
         bZ0CqRgbcg1xiD3EasV8txklgseT+1SROiq13ckFza+U7iy2eAf5/s4uQXf+XZ4vUloL
         ZfPPX+q30izU9pfC9IiRf/9sphUXIyx25IiTbuhQUDb/0rprxBOGjcRcWWrZk/xI3M7w
         I9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729987546; x=1730592346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBo+UfmYoZrzMsNQGjuBCfg8tOJuRj5Gpe5nBXU7kng=;
        b=h1WNSPlpI9ASK1t2Pya7T1ygbwNdvpWyku3z31G/qmbUlVcNyLkUMBZQqHbf1SQhup
         PE/A1KBL6r4Ootd1NZy0cRA9F2SmuEFXp35fuWsfWAM8ZyQsjt1m5Dj9DYr5W/KXLZbw
         oSnm3+zCaAd+BEWAaxnFIIeUoVnASiMx8HXrBiZehXwklH1zShXkUZmKWsgKD7NeX2qx
         ZYa526ajuYBe/HWB1ZArDxzzJQ/amlLieypP1K9gowxjzaCKu48Xmhj8+qe+Uc4k7KUZ
         /jsj0el8dOTio5u089wxt6GY/YGNthBfBLeu94HhAfrhbAmH7lY/iN8sctz3JXhaIbVm
         li8w==
X-Forwarded-Encrypted: i=1; AJvYcCV6IZz/RIHZFs5vqFuIK6ZyVKRzcoeMsieuv5eqxvWv6rJQUeuYBrmfGKSWD4J1gq7/d9CDg8kvSpTjxEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4slu2zEa3DvVUgGevg4t2mUPYNNnRWn2UyRIGDGkez/Jhjnol
	IZGJSmL8O4Dp50oP2meB+hZ3MlW9oMD7Q4zvjkY1f9jDGfhcYgxFSoXfh4pC8fQ=
X-Google-Smtp-Source: AGHT+IE+GC6LCWLQIl3WueQx+pYDMQMzcrUWE5ZDJ+B32lO2dzBpdBsOVz7+Dh/SfJSmobYphyJ0eQ==
X-Received: by 2002:a05:6830:6381:b0:718:823:cca8 with SMTP id 46e09a7af769-71858896259mr5651688a34.2.1729987546093;
        Sat, 26 Oct 2024 17:05:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71861506f3bsm933938a34.11.2024.10.26.17.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 17:05:44 -0700 (PDT)
Message-ID: <7700b27a-9ffc-474e-8390-a69428fe7607@baylibre.com>
Date: Sat, 26 Oct 2024 19:05:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
 <20241026170038.4b629cff@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241026170038.4b629cff@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/24 11:00 AM, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 15:59:22 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>>  static int ad4695_write_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *chan,
>>  			    int val, int val2, long mask)
>> @@ -779,6 +992,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
>>  			default:
>>  				return -EINVAL;
>>  			}
>> +		case IIO_CHAN_INFO_SAMP_FREQ: {
>> +			struct pwm_state state;
>> +
>> +			if (val <= 0)
>> +				return -EINVAL;
>> +
>> +			guard(mutex)(&st->cnv_pwm_lock);
>> +			pwm_get_state(st->cnv_pwm, &state);
> 
> What limits this to rates the ADC can cope with?
> 

Nothing at the moment. The "obvious" thing to do would
be to limit this to the max rate from the datasheet.

But that feels a little too strict to me since maybe the
PWM can't get exactly the max rate, but can get the max
rate + 1% or so. It seems like we should allow that too.
It's not like the ADC is going to not work if we go a
few Hz over the datasheet rating.

Maybe limit it to max + 10% or something like that?

