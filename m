Return-Path: <linux-kernel+bounces-314955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914D96BB75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79594284F11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305301D6191;
	Wed,  4 Sep 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aPBVrLlY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945513B58E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451383; cv=none; b=pEVUiYbEOEA9D7BY6Q707BkJoxIsMB++uIh4UCOMNru3Y4da5ccOsSaEB1mfAISc7dreoLdHnMVqX4CRNZIHv7rIeEX79Hs8KjWObFCfeYb2PDdDrTR5DvpcJh0jcqbSgbMRHcRe1E6zZpOa09u1/L+m4Xg1lbhHXwNaNlOO9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451383; c=relaxed/simple;
	bh=DuwkdyX79hVNS4+oaIn+EcYGas76m4q5fKNzc1LrUl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFoLeu4VIQU8Svq//L7CBXNA6YLnzIk2WD2Hxq0Ssr6BbjsNRU2yfDgH4yM7c/q2BVGRyliHM9R5DZ3yMOIH26PlnQSttDeuaK59l5xzvAbgOO8xhlEBfGMhcO93MgJYUL48bVi28vcC8XB9BRzKtNbIBmblZngMv3vIkVMkVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aPBVrLlY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so45397915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725451378; x=1726056178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvS627k5mguTl6HQhQd8bFFYU60r4VpnIC1+jtP2Fdw=;
        b=aPBVrLlYN4C9FPAGy0rrkZ5y7IRxnfZvnCfWuU2ZFdaP9q0aIJ2G1Yiq2fLakhTYO5
         /TMLpGpmOFp2LHHoNPYezjalG56ul5htl0SUHtyvNieZ16YNJXBk7bJDglOJtna7sGHO
         krPbc9U/MmvEgpMvoyuZfhana31jbSAJURDwu3cQfdZwfB/7dv8IzSw0WXk9Z+bOlBWV
         +imBw7B4+PlBCxgz/VGYhWGfEkd0H1dfIFdk8D4kAY236BAt+xTlH+fgjb+z3Qr9mNzV
         zCmhlccnOCjNlszkkqD+fEvI57MC4P9EQmsvGgmzHHFoOMdoTKZc9sGAbPoGtYAgmEm2
         /ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725451378; x=1726056178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvS627k5mguTl6HQhQd8bFFYU60r4VpnIC1+jtP2Fdw=;
        b=XVkbK4HDjc9JlcEGyHvmymi0dZTdeyAu78+ncuyRj7GHuqja1Hm7lIuWrLcH7aKAFq
         XxdfFTrJcuxdSfLAW1o165n/ejLo0Ov3EVrn1kyzgk8UndCAw2u/WtHtGb905OzKeTt8
         pixsQ7vBRKUCYh6e4Q1DJvlWaJMUcygqcH1HCTxAYrD20OuOGjTjTIegZjJTwIbmTG1t
         O0Yj0AJpJR1nq5cDUzeBAIRr7t3uTiFlzYyQiLE2hzIdcSww+T7brh4qIAX0Pw2yAVHt
         E6QxyCueuJyTl+SLkcgyAxYJwRJQWbKfS1udIR6D59mHofPpP+wzor3766jfqg8iVDHT
         slVA==
X-Forwarded-Encrypted: i=1; AJvYcCVxXW3rnDcex2LTA8W/tg3bu+RFNlK5QPyrALTij0M0QUFm2XIaKWCuE+VZJ6Fc/FkieAonKtm5hTXSO/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8acnkwrl7Pu0Ak8j20WM0Bqy99SHx4ebe337bfXlEFLjUq9DU
	FZM8YlZoFjx7+ViIKOIeAYpuy051n6ScAEnkOixAiO/cDAURap4/1VlCKb7Ez/s=
X-Google-Smtp-Source: AGHT+IGk8WHoR74IDQuzsi8pl8eeSyosTrzQ54iEQJwg3b8v7wrrUdSm5Dt6azgUY8kcqM6OtW+/Hw==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr160676335e9.15.1725451377986;
        Wed, 04 Sep 2024 05:02:57 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm16758198f8f.50.2024.09.04.05.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 05:02:56 -0700 (PDT)
Message-ID: <4826097d-b575-4895-9335-f587bbf3bc89@baylibre.com>
Date: Wed, 4 Sep 2024 14:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
 <20240831122313.4d993260@jic23-huawei>
 <0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
 <20240903201157.5352ec04@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240903201157.5352ec04@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On 03/09/24 9:11 PM, Jonathan Cameron wrote:
> On Mon, 2 Sep 2024 16:03:22 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> Hi Jonathan,
>>
>> thanks for the feedbacks,
>>
>> On 31/08/24 1:23 PM, Jonathan Cameron wrote:
>>> On Thu, 29 Aug 2024 14:32:00 +0200
>>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>>   
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> Extend backend features with new calls needed later on this
>>>> patchset from axi version of ad3552r.
>>>>
>>>> A bus type property has been added to the devicetree to
>>>> inform the backend about the type of bus (interface) in use
>>>> bu the IP.
>>>>
>>>> The follwoing calls are added:
>>>>
>>>> iio_backend_ext_sync_enable
>>>> 	enable synchronize channels on external trigger
>>>> iio_backend_ext_sync_disable
>>>> 	disable synchronize channels on external trigger
>>>> iio_backend_ddr_enable
>>>> 	enable ddr bus transfer
>>>> iio_backend_ddr_disable
>>>> 	disable ddr bus transfer
>>>> iio_backend_set_bus_mode
>>>> 	select the type of bus, so that specific read / write
>>>> 	operations are performed accordingly
>>>> iio_backend_buffer_enable
>>>> 	enable buffer
>>>> iio_backend_buffer_disable
>>>> 	disable buffer
>>>> iio_backend_data_transfer_addr
>>>> 	define the target register address where the DAC sample
>>>> 	will be written.
>>>> iio_backend_bus_reg_read
>>>> 	generic bus read, bus-type dependent
>>>> iio_backend_bus_read_write
>>>> 	generic bus write, bus-type dependent
>>>>
>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>> ---
>>>>    drivers/iio/industrialio-backend.c | 151 +++++++++++++++++++++++++++++++++++++
>>>>    include/linux/iio/backend.h        |  24 ++++++
>>>>    2 files changed, 175 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>>>> index a52a6b61c8b5..1f60c8626be7 100644
>>>> --- a/drivers/iio/industrialio-backend.c
>>>> +++ b/drivers/iio/industrialio-backend.c
>>>> @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct device *dev, struct iio_backend *back)
>>>>    	return 0;
>>>>    }
>>>   
>>>> +
>>>> +/**
>>>> + * iio_backend_buffer_enable - Enable data buffering
>>> Data buffering is a very vague term.  Perhaps some more detail on what
>>> this means?
>> for this DAC IP, it is the dma buffer where i write the samples,
>> for other non-dac frontends may be something different, so i kept it
>> generic. Not sure what a proper name may be, maybe
>>
>> "Enable optional data buffer" ?
> How do you 'enable' a buffer?  Enable writing into it maybe?

for the current case, this is done using the custom register
of the AXI IP, enabling a "stream".

return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
                    AXI_DAC_STREAM_ENABLE);

Functionally, looks like dma data is processed (sent over qspi)
when the stream is enabled.

Maybe a name as "stream_enable" would me more appropriate ?
"Stream" seems less generic btw.

>>
>>>> + * @back: Backend device
>>>> + *
>>>> + * RETURNS:
>>>> + * 0 on success, negative error number on failure.
>>>> + */
>>>> +int iio_backend_buffer_enable(struct iio_backend *back)
>>>> +{
>>>> +	return iio_backend_op_call(back, buffer_enable);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
>>>> +
>>>> +/**
>>>> +/**
>>>> + * iio_backend_bus_reg_read - Read from the interface bus
>>>> + * @back: Backend device
>>>> + * @reg: Register valule
>>>> + * @val: Pointer to register value
>>>> + * @size: Size, in bytes
>>>> + *
>>>> + * A backend may operate on a specific interface with a related bus.
>>>> + * Read from the interface bus.
>>> So this is effectively routing control plane data through the offloaded
>>> bus?  That sounds a lot more like a conventional bus than IIO backend.
>>> Perhaps it should be presented as that with the IIO device attached
>>> to that bus? I don't fully understand what is wired up here.
>>>   
>> Mainly, an IP may include a bus as 16bit parallel, or LVDS, or similar
>> to QSPI as in my case (ad3552r).
> ok.
>
> If this is a bus used for both control and dataplane, then we should really
> be presenting it as a bus (+ offload) similar to do for spi + offload.
>
>> In particular, the bus is physically as a QSPI bus, but the data format
>> over it is a bit different.
>>
>> So ad3552r needs this 5 lanes bus + double data rate to reach 33MUPS.
>>
>> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>
> Jonathan
>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


