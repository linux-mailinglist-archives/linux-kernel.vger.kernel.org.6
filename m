Return-Path: <linux-kernel+bounces-449479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05E9F4F95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B631883312
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0D1F75A5;
	Tue, 17 Dec 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPU2Y2U/"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129A1F708C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449764; cv=none; b=nXggo1Nsbcxl/R4WmRXU3H3RDLCHcznpAUu/cIVfbl7Ke13ZBbycdedTffy3udF4l0dmxVoBMLsqN6Eg7WgcHOruhcZYI8F3F41zeoGoIJiRYM79r5zCDWsswhorGfplICyhl9nNOAspcr+ZkiAKOlPJEj9VpzbttEl89Emuv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449764; c=relaxed/simple;
	bh=Cfm9tPZMQuiDcp8WcnIHSSo2kAMsYiiKt/FMI+6TXQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwlB3NGomgFlOzmO3UDxGOGtUsroNQ6ZOrbOv8A/IVmTmhR5f7GuQY6v1hTG+ZpTHCg/kxtyl0OTwOQa6KHzt54pWbBiOdhBkHsZFChfWjH4s/uw2NSKs7/pot0QaiDXHPQHfjsExbtbJ/yCx4/OPegjp/iN2MSTnCR/liEL3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PPU2Y2U/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e3167b90dso2453615a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734449762; x=1735054562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=PPU2Y2U/EkWg1+Xnuj8cdx/1XPrW0dZj2TY/BZkpz6jLspAj0RZNLro9vBsQoRNruC
         TZwS7vEkbkBwuKE70CwgJjgxkbioEvygkQFIqWNqfZD+i85ZBxNsIXLL7KNYEn/GAD+U
         48dMvgvloDXw9/6/vu5ut6qZL+Mc+wXoZ3k4L2EDtHMO7q0nGjEOs+9hpuVrdW2XLKwo
         zAbnh6DzZBzdSBIcFbpvuG78w46eAEsnUtTZirEk/rfMC+/pVtLOj60bDvVBqHo94uH5
         Gh0r28fEqCDHRNeOoBJFMf3Y5obqFllTUAOGAh8WFblEamhDf4OE4ryr5004gT3mgePZ
         j+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449762; x=1735054562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hSccYkNiVo5Ab7I2cIln/5c0RMqcFycYPtpUe98zEE=;
        b=GmJJz1m/BPsaSGiTWmzmxD1yNDfMcNBCHBogwGfom1P4NrazEfevlWJK0yS6r5i6lr
         yPrtc7wJ1s2ZFv/9IZGdKnuHLIDKsnvVJjakeSr19Y0ZWOsCLtDHGvs1i1CR6P8urWdQ
         1KKc7ET+/EZt4uwu698zBq4HbuUTiKWJKmQltbwOMZcwcRNX1kmmRLI1hFI2VJleJjTa
         XfPWr/3XpWo2rmIeTyKsob6LPBVzrZVQRX9oqkMuTErEBIqZx055TCwLOV1Pm9QhrAQd
         k+2WUpz4pluwXmbkitrXK7uCqba595sVo2v7gQoEcE4+9qZKZrPDJ1sohNfO2rnTSnV1
         c3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU9P3mwBYFh09aP0Er6SilVBfE4dXAwI5gxRCgMiHtNfMK5FbvDQ/Vdl3BsPO9yZxGvzxrRrOQ1LFP5hEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RKliMzAG5ngHt4qIR1JGOH7O+fMscn3SE1SVIoclgWgzflYw
	9Rb1ObUEbvkudUkXdDHAgIAyKnynkMlWyJZR+M7e5mMXD9nCJlA0NDctIjDQnHo=
X-Gm-Gg: ASbGncv2g29gI1qmddd7UUk6AfpWZGTKtixUPb63/45g2Usfl1v3WfSGSPCs4RzxDmd
	/uznEIOZVg8/3NhaKJ8bd7qeyF5pdrgGbDz7OAMOuPVUWZkJVcwORFEBFpsZp2Lw6AiQIwffWmU
	+HmCXorWP5LyNNvtBUAtNPUrOkIql/ZOr1AoRZuPxrJnDzX9KKrKXiHdcSJr/mjwjaDrp9wocLY
	ZdtqEA91SMWZfexuDODrNMJAbnku2U1U7wPS7/pJMRt6IvQxmvV2McYSgjo4/bSuB2JwxrSh6+9
	UngOoL9EL4YR6Trw0g==
X-Google-Smtp-Source: AGHT+IH/2b6LqFTsioT5QNM6/l8WG+PKjU9zlTFidwxxoump2J5Z1nfbAzJbXJkDBI/fgk1AuuDE9Q==
X-Received: by 2002:a05:6830:3890:b0:71d:50f0:afc5 with SMTP id 46e09a7af769-71e3ba3afbfmr11522547a34.21.1734449761967;
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307815sm2069053a34.9.2024.12.17.07.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:36:01 -0800 (PST)
Message-ID: <8dc22c7a-f1d2-483e-8b69-cb5dc494feae@baylibre.com>
Date: Tue, 17 Dec 2024 09:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/17] spi: offload: add support for hardware triggers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
 <20241211-dlech-mainline-spi-engine-offload-2-v6-2-88ee574d5d03@baylibre.com>
 <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 5:30 AM, Nuno Sá wrote:
> On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
>> Extend SPI offloading to support hardware triggers.
>>

...

>> +static struct spi_offload_trigger
>> +*spi_offload_trigger_get(enum spi_offload_trigger_type type,
>> +			 struct fwnode_reference_args *args)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	bool match = false;
>> +	int ret;
>> +
>> +	guard(mutex)(&spi_offload_triggers_lock);
>> +
>> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
>> +		if (trigger->fwnode != args->fwnode)
>> +			continue;
>> +
>> +		match = trigger->ops->match(trigger, type, args->args, args-
>>> nargs);
>> +		if (match)
>> +			break;
>> +	}
>> +
>> +	if (!match)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	guard(mutex)(&trigger->lock);
>> +
>> +	if (!trigger->ops)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (trigger->ops->request) {
>> +		ret = trigger->ops->request(trigger, type, args->args, args-
>>> nargs);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>> +	kref_get(&trigger->ref);
> 
> maybe try_module_get() would also make sense...

Even if a module had more than one trigger? Or do you mean
in addition to the kref_get()?

> 
>> +
>> +	return trigger;
>> +}
>> +
>> +/**
>> + * devm_spi_offload_trigger_get() - Get an offload trigger instance
>> + * @dev: Device for devm purposes.
>> + * @offload: Offload instance connected to a trigger.
>> + * @type: Trigger type to get.
>> + *
>> + * Return: Offload trigger instance or error on failure.
>> + */
>> +struct spi_offload_trigger
>> +*devm_spi_offload_trigger_get(struct device *dev,
>> +			      struct spi_offload *offload,
>> +			      enum spi_offload_trigger_type type)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	struct fwnode_reference_args args;
>> +	int ret;
>> +
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(offload-
>>> provider_dev),
>> +						 "trigger-sources",
>> +						 "#trigger-source-cells", 0,
>> 0,
>> +						 &args);
> 
> I guess at some point we can add these to fwlinks?
> 

Yes. Although we'll need to investigate how it would affect
leds since they use the same binding. So perhaps we can save
that for later since the rest of this series seems ready now.


