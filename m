Return-Path: <linux-kernel+bounces-227293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B4914ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CBB2141C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158DC14037E;
	Mon, 24 Jun 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pz91OPMj"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75B145B33
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235988; cv=none; b=dKGPRYfi5bGsqXMBvtfmZWIT6o+SG2TxYJd1d7O+iY4Wwt9TA7zv00Q+iAF8TZo4LlQ+YlIDeZON9Cw+08+kFbk1n/L4tkvba8JN9VxZGaExXqYvgF3QEy2zrx9p/t+8gNcqmoOPYWob/AmtiONWCbLfkGci+QXwSvyM/GgQiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235988; c=relaxed/simple;
	bh=W8I5P5mQ4gTk+N2ilXD5cs6B6MzlVlbx9bJ8spbSQgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMSlNmYG105s3afnpIDNPvDfStFX5yZ1xWQE8H+RfHsv88n0ZRxWrnsb7u2rSbNs6dQ+vUsDe7Fxv+rSyB5h6xGbRjU256Dab+VPjJmf7NhKHqQZsTHqirjkpng09GJcuP988EJ6VQXBobm02aox94vTkaTcV7hOJIFmBs1ZaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pz91OPMj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4079632f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719235983; x=1719840783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWfDyGDcFNAxTxsQp6Q20zmxjVRAYUqme+mlYdreR20=;
        b=pz91OPMj2iUnOqzeEgYFpbSEafoz6oyUju146hNa0a4PfKs2f0z6v+VXWBi7QjEToN
         fuKI607iOR4b2CEUC1dYDBu5UdyytYFfW7/MWTtUGaJ7iiToxg3JAK9YZvgLO+ciSNMV
         AWvhE4Awg7tPyva9Oy+Fuf0+hJWDOePfj+32xuve4SmT8rI8k56gtPihMVi14qjR63Vb
         0ZwDX/XUmxEoLhtvfc/mruFijhh+61IKPIXNcVR5eo65OIGcL/Ct5e6NLlPvjvy6GORv
         oUb7QhFVyPdoY0XzWOQXvGXFk+PU7FvAno+izOSuPQZWWgQJLGIKq2E77Sp+2Dnh1t/I
         ItmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235983; x=1719840783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWfDyGDcFNAxTxsQp6Q20zmxjVRAYUqme+mlYdreR20=;
        b=K+3/eTT5wi7qGr1lXZ/6FDv/+SGetZFNuKDnOeldIrm2mETxICGxVcXH+mUBNyZ5Wo
         7g0yXieBJzlGZjm9bCZqU0ScAsufS3iM9JW9HQgvne/cVt3rrHD+R4xFMUOnoEtoQERp
         KW/DC5eD0PTux9nBD15mUWDknoiCVKoQ6wZAhR94K0vqZETc6+EXR7rW82A4EWbzI+2g
         c3f+4e6qgKEBf5+bnOTmkpJDkoqjaDk57BvjaO84b8YivoxhpEPr0BQO8aZl78F9nm+k
         RPqTDv5vwONPS9rsB6pn7HFy1U/MGormfySI0aKjc2lP0aVT4OjCcD3onGPRl9LlykE/
         myag==
X-Forwarded-Encrypted: i=1; AJvYcCVcb9BPbX0QmcAl6QaMcWoYFsyD3JlFPgSnKh2OYeeY/wxkz1MzOY82KLUMX3niZXZxzmkuAdbQceIMsAwiSDXsJTDuLHrT4s4a4d+V
X-Gm-Message-State: AOJu0Yz7VnxDlVwwOql2U0/BRTazIaTRKwQUEpk8mXXY1Sy3EjmEcoNv
	cQCyhGtFe0tS06u0oJys0tN30dNkNffCgXGeo0XfnK7+Px+IGzjCEyK2/SP1QQs=
X-Google-Smtp-Source: AGHT+IGe0gm9OM+NRg50jGHaHWnbBA7Oet31hE0xxGLwue7vnzn3gUmRoP2BUtvpMXWKGZeth+FhuA==
X-Received: by 2002:a5d:4686:0:b0:363:7816:7568 with SMTP id ffacd0b85a97d-366e9661d46mr2643541f8f.70.1719235983059;
        Mon, 24 Jun 2024 06:33:03 -0700 (PDT)
Received: from [10.2.5.170] (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7dd8sm10126461f8f.99.2024.06.24.06.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:33:02 -0700 (PDT)
Message-ID: <4a6b3c28-deb4-44bb-869f-0604a17be2ec@baylibre.com>
Date: Mon, 24 Jun 2024 15:33:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7606: remove frstdata check for serial
 mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstephan@baylibre.com, dlechner@baylibre.com
References: <20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com>
 <20240623165424.164b341b@jic23-huawei>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20240623165424.164b341b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/23/24 17:54, Jonathan Cameron wrote:
> On Tue, 18 Jun 2024 13:45:00 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>
>> Frstdata pin is set high during the first sample's transmission and then
>> set low.  This code chunk attempts to recover from an eventual glitch in
>> the clock by checking frstdata state after reading the first channel's
>> sample.  Currently, in serial mode, this check happens AFTER the 16th
>> pulse, and if frstdata is not set it resets the device and returns EINVAL.
>> According to the datasheet, "The FRSTDATA output returns to a logic low
>> following the 16th SCLK falling edge.", thus after the 16th pulse, the
>> check will always be true, and the driver will not work as expected.  Thus
>> it must be removed for serial mode.
> when you say will not work as expected, is this is normal circumstances, or
> when dealing with a clock glitch?  i.e. should this have a fixes tag and
> got upstream asap or is it just cleaning up a corner case and can wait for
> now?
>
> One trivial comment inline.
>
> Jonathan

It completely prevents the driver to work when adi, first-data 
(optional) is defined in the DT.

So I guess anyone having the driver working with the serial interface 
right now did not define frstdata in the DT.

However, for someone new that sets adi, first-data in the DT, it is not 
very straightforward to spot where the issue is.

>
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>> ---
>> Changes in v2:
>>   - Remove frstdata check only for the serial interface as suggested by
>>     Michael Hennerich.
>>   - Link to v1: https://lore.kernel.org/r/20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com
>> ---
>>   drivers/iio/adc/ad7606.c     | 28 ++-----------------------
>>   drivers/iio/adc/ad7606.h     |  2 ++
>>   drivers/iio/adc/ad7606_par.c | 49 +++++++++++++++++++++++++++++++++++++++++---
>>   3 files changed, 50 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>> index 3a417595294f..c321c6ef48df 100644
>> --- a/drivers/iio/adc/ad7606.c
>> +++ b/drivers/iio/adc/ad7606.c
>> @@ -49,7 +49,7 @@ static const unsigned int ad7616_oversampling_avail[8] = {
>>   	1, 2, 4, 8, 16, 32, 64, 128,
>>   };
>>   
>> -static int ad7606_reset(struct ad7606_state *st)
>> +int ad7606_reset(struct ad7606_state *st)
>>   {
>>   	if (st->gpio_reset) {
>>   		gpiod_set_value(st->gpio_reset, 1);
>> @@ -60,6 +60,7 @@ static int ad7606_reset(struct ad7606_state *st)
>>   
>>   	return -ENODEV;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
>>   
>>   static int ad7606_reg_access(struct iio_dev *indio_dev,
>>   			     unsigned int reg,
>> @@ -88,31 +89,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
>>   {
>>   	unsigned int num = st->chip_info->num_channels - 1;
>>   	u16 *data = st->data;
>> -	int ret;
>> -
>> -	/*
>> -	 * The frstdata signal is set to high while and after reading the sample
>> -	 * of the first channel and low for all other channels. This can be used
>> -	 * to check that the incoming data is correctly aligned. During normal
>> -	 * operation the data should never become unaligned, but some glitch or
>> -	 * electrostatic discharge might cause an extra read or clock cycle.
>> -	 * Monitoring the frstdata signal allows to recover from such failure
>> -	 * situations.
>> -	 */
>> -
>> -	if (st->gpio_frstdata) {
>> -		ret = st->bops->read_block(st->dev, 1, data);
>> -		if (ret)
>> -			return ret;
>> -
>> -		if (!gpiod_get_value(st->gpio_frstdata)) {
>> -			ad7606_reset(st);
>> -			return -EIO;
>> -		}
>> -
>> -		data++;
>> -		num--;
>> -	}
>>   
>>   	return st->bops->read_block(st->dev, num, data);
>>   }
>> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
>> index 0c6a88cc4695..6649e84d25de 100644
>> --- a/drivers/iio/adc/ad7606.h
>> +++ b/drivers/iio/adc/ad7606.h
>> @@ -151,6 +151,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>>   		 const char *name, unsigned int id,
>>   		 const struct ad7606_bus_ops *bops);
>>   
>> +int ad7606_reset(struct ad7606_state *st);
>> +
>>   enum ad7606_supported_device_ids {
>>   	ID_AD7605_4,
>>   	ID_AD7606_8,
>> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
>> index d8408052262e..1f7050297b64 100644
>> --- a/drivers/iio/adc/ad7606_par.c
>> +++ b/drivers/iio/adc/ad7606_par.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/types.h>
>>   #include <linux/err.h>
>> @@ -21,8 +22,30 @@ static int ad7606_par16_read_block(struct device *dev,
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct ad7606_state *st = iio_priv(indio_dev);
>>   
>> -	insw((unsigned long)st->base_address, buf, count);
>>   
>> +	/*
>> +	 * On the parallel interface, the frstdata signal is set to high while
>> +	 * and after reading the sample of the first channel and low for all
>> +	 * other channels.  This can be used to check that the incoming data is
>> +	 * correctly aligned.  During normal operation the data should never
>> +	 * become unaligned, but some glitch or electrostatic discharge might
>> +	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
>> +	 * allows to recover from such failure situations.
>> +	 */
>> +	int num = count;
>> +	u16 *_buf = buf;
>> +
>> +	if (st->gpio_frstdata) {
>> +		insw((unsigned long)st->base_address, _buf, 1);
>> +		if (!gpiod_get_value(st->gpio_frstdata)) {
>> +			ad7606_reset(st);
>> +			return -EIO;
>> +		}
>> +		_buf++;
>> +		num--;
>> +	}
>> +	insw((unsigned long)st->base_address, _buf, num)
>> +;
> Seems this slipped onto the next line.
> Make sure to run checkpatch which I would have thought would catch this.
>
>>   	return 0;
>>   }
>>   
>> @@ -35,8 +58,28 @@ static int ad7606_par8_read_block(struct device *dev,
>>   {
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct ad7606_state *st = iio_priv(indio_dev);
>> -
>> -	insb((unsigned long)st->base_address, buf, count * 2);
>> +	/*
>> +	 * On the parallel interface, the frstdata signal is set to high while
>> +	 * and after reading the sample of the first channel and low for all
>> +	 * other channels.  This can be used to check that the incoming data is
>> +	 * correctly aligned.  During normal operation the data should never
>> +	 * become unaligned, but some glitch or electrostatic discharge might
>> +	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
>> +	 * allows to recover from such failure situations.
>> +	 */
>> +	int num = count;
>> +	u16 *_buf = buf;
>> +
>> +	if (st->gpio_frstdata) {
>> +		insb((unsigned long)st->base_address, _buf, 2);
>> +		if (!gpiod_get_value(st->gpio_frstdata)) {
>> +			ad7606_reset(st);
>> +			return -EIO;
>> +		}
>> +		_buf++;
>> +		num--;
>> +	}
>> +	insb((unsigned long)st->base_address, _buf, num * 2);
>>   
>>   	return 0;
>>   }
>>
>> ---
>> base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
>> change-id: 20240416-cleanup-ad7606-161e2ed9818b
>>
>> Best regards,

