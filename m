Return-Path: <linux-kernel+bounces-260068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B476093A28A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD936B2440C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2C15442F;
	Tue, 23 Jul 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AgGodYIg"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAC15252E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744400; cv=none; b=nNWQva51KHrkQ3SH5V5TAL4uP5naDlM5MdWMWtBNuvirLCOmvHRFt0Hygq+tS17EvWZAsXTbYjdsseRYdlUgLXn3WZ5cS0IsK0+eVg2kHRRriw2bgh63zeWkGNgWQP01StHco8Yzc3F+QNgPDPo+fZKsua5nSn8iyGvErTjt/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744400; c=relaxed/simple;
	bh=jjnH4KpHZhT2haPQMe+bVgnA95htobOfsIhSzq7TUvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuASEphXRXVKcGRWJvEdck/8BBpTZHuAwYKSycbMU17CJqbIjkrPric7c+8KBIN3gOLf/4QIkbWr6Th8FeRJ9bFmOGyhmjMATwqSA/u+UlA3QK/IEqxmXcR93N9fj2K1SfgRAr5XBErHtIDzz0PjH8AelzjORzIUQwAthl3P2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AgGodYIg; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3dae221e42dso2329685b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721744397; x=1722349197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkDJYIw/vdlMnKLTUNbD0wYDl1VQ8cd/2JB1blgM3rw=;
        b=AgGodYIg0L/B6v4ipjsn6U15Q1Q3XoCxd+5bfBqMqm4qVCDVvojI6wjGhTQbflSg1b
         61bI5XmyelYIJLMouV+F5Zu00+uYJHGkvH/prFLUGToxqxrsixjvuKrN/r3G/84dJrD6
         xvmnL1jNeDDJpl3Zoi3o0nb+UkYX0N/BEBCqdDayKk0M/Ys577qA63mpCaANi21Tt4VK
         j8oMbxiB2jF6sNpSfBNb1uZShAsQfKEX7NxPAEGOoPjBw7qbtaNHK+PUfQwHQ4KkqDIV
         bQf70AUzGK9AFHMEmPyYKWvznVHHCFQwCmyRgnGzXTxo9N4z+jRxk89c1OzDitMAtL2v
         PawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721744397; x=1722349197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkDJYIw/vdlMnKLTUNbD0wYDl1VQ8cd/2JB1blgM3rw=;
        b=sFRbtxnRraP3tne/sFoq1cC5n0BYbkJjh7nyvp6+xmN5J+41XOrYnd6vu7u6DKUz1m
         xl/Y7D0zOwxK0SwKjcv7agEJiK8MlsTW6tAbKCfm9KJhjIbsl2OoMwdZnRNwNqpQqt0J
         nSNFzAdGedVr+AqKURqcs9phv/e7eiGOMU1hsr87G6L2b8sxtLqJjz0x5D+RbFdg00r4
         JgyBm+o0N1mk+6dN1IrGiqCLVubDlBw4ZIDQRnOxFPyENUcrvqBBP/Wh0OgnEsr4nsmh
         7nHlN1eyM/C2mr/xi352vAWOEo3kOdV9DQjSpNoObY/bTo70Rq8kY4vLjoWeYv+jsrZ1
         K13A==
X-Forwarded-Encrypted: i=1; AJvYcCX01tXc257DHxgIXpz246RDmX9ebizq25G2REvG4viYlt1ABOApws3bmUMu6t3gMbvdCrWLwEU9rc6x5Jt9wkpW6pkdV2oavejGKuGn
X-Gm-Message-State: AOJu0YzJ1r0Q8Ia4yyPVzRicD7Vf/y0tFzjqK5AsbjnXfXli2uxxcLAN
	HWxMDPE4mkveaCEFFXRYKx9qqMxSNiRyl7bo7cVKydn30VEIP+m2CFlULboSjVA=
X-Google-Smtp-Source: AGHT+IE7T5C6fJwK4ET9xVwmRjnoNNfEQHTQWnp+GuyNQ0Lv3Jq8gUsP+PLSTU4pWl4mxf1IK07wlA==
X-Received: by 2002:a05:6808:2119:b0:3db:331:9d4a with SMTP id 5614622812f47-3db0331a1bbmr1703151b6e.26.1721744395979;
        Tue, 23 Jul 2024 07:19:55 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae099012esm2010165b6e.31.2024.07.23.07.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 07:19:55 -0700 (PDT)
Message-ID: <ebfa05e7-2674-4869-bbfd-f0a6cf6b03fa@baylibre.com>
Date: Tue, 23 Jul 2024 09:19:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 6/9] spi: axi-spi-engine: implement offload support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-6-7420e45df69b@baylibre.com>
 <5b246e7628ea189be5f8430dac4cffde723b7907.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b246e7628ea189be5f8430dac4cffde723b7907.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/24 3:01 AM, Nuno Sá wrote:
> On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
>> This implements SPI offload support for the AXI SPI Engine. Currently,
>> the hardware only supports triggering offload transfers with a hardware
>> trigger so attempting to use an offload message in the regular SPI
>> message queue will fail. Also, only allows streaming rx data to an
>> external sink, so attempts to use a rx_buf in the offload message will
>> fail.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
> 
> ...
> 
> 
> I'm likely missing something but you already have:
> 
> priv = &spi_engine->offload_priv[args[0]];
> 
> which seems that from FW you already got the offload index you need. Can't we
> just save that index in struct spi_device and use that directly in the other
> operations? Saving the trouble to save the id string and having to always call 
> spi_engine_get_offload()?

Saving the index in the struct spi_device would assume 1. that all SPI
peripherals can only use one SPI offload instance and 2. that all SPI
offload providers have #spi-offload-cells = <1> where the cell is the
index. I don't think either of these are safe assumptions.

> 
>> +
>>
> 
> ...
> 
>> +}
>> +
>> +static void spi_engine_offload_unprepare(struct spi_device *spi, const char
>> *id)
>> +{
>> +	struct spi_controller *host = spi->controller;
>> +	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>> +	struct spi_engine_offload *priv;
>> +	unsigned int offload_num;
>> +
>> +	priv = spi_engine_get_offload(spi, id, &offload_num);
>> +	if (IS_ERR(priv)) {
>> +		dev_warn(&spi->dev, "failed match offload in unprepare\n");
>> +		return;
>> +	}
>> +
>> +	writel_relaxed(1, spi_engine->base +
>> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
>> +	writel_relaxed(0, spi_engine->base +
>> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
>> +
>> +	priv->prepared = false;
>> +}
>> +
>> +static int spi_engine_hw_trigger_mode_enable(struct spi_device *spi,
>> +					     const char *id)
>> +{
>> +	struct spi_controller *host = spi->controller;
>> +	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>> +	struct spi_engine_offload *priv;
>> +	unsigned int offload_num, reg;
>> +
>> +	priv = spi_engine_get_offload(spi, id, &offload_num);
>> +	if (IS_ERR(priv))
>> +		return PTR_ERR(priv);
>> +
>> +	reg = readl_relaxed(spi_engine->base +
>> +			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
>> +	reg |= SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
>> +	writel_relaxed(reg, spi_engine->base +
>> +			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
>> +
>> +	return 0;
>> +}
>> +
>> +static void spi_engine_hw_trigger_mode_disable(struct spi_device *spi,
>> +					       const char *id)
>> +{
>> +	struct spi_controller *host = spi->controller;
>> +	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>> +	struct spi_engine_offload *priv;
>> +	unsigned int offload_num, reg;
>> +
>> +	priv = spi_engine_get_offload(spi, id, &offload_num);
>> +	if (IS_ERR(priv)) {
>> +		dev_warn(&spi->dev, "failed match offload in disable\n");
>> +		return;
>> +	}
>> +
>> +	reg = readl_relaxed(spi_engine->base +
>> +			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
>> +	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
>> +	writel_relaxed(reg, spi_engine->base +
>> +			    SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
>> +}
>> +
> 
> I would expect for the enable/disable() operations to act on the trigger. In
> this case to enable/disable the clock...

I'm not opposed to doing that, but things would get more complicated if we
ever added more trigger types. Because then we would need to add some kind
of trigger device abstraction to wrap the enable and disable functions of
the various triggers.

It seems simpler to me to have the peripheral driver do it since it already
needs to get the clock device for other reasons anyway.

But I also got some internal feedback that it might make more sense to add
a trigger abstraction layer, so maybe that is something we should look into
more.

