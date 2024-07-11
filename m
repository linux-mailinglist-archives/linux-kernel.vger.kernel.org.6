Return-Path: <linux-kernel+bounces-249491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5292EC63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837D71F24C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14F16D31B;
	Thu, 11 Jul 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pNMks953"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B416B392
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714297; cv=none; b=mZohLvXqXtspHSWnRHx6mU3QuZvHoldrRIl47y58N3G7jErIVT3qmnPB3rR/r/mwSIPc31Kj/HTlUGB+Z2K0aved/4V/OauHdpW4UxMukpxWdBJc0Y3qLZ3oQ1hfPJNDEJ3qeFcdYYTTOknghjOkvKpdfL93SdFMkk/2gGrrEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714297; c=relaxed/simple;
	bh=RRwESqfur9hjuj4i+nTtpR38U3Kz44Xajo3B8ZD7Kg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUY1Y1cW4Qzlk/w7rFvfXf57fLwfl+liuiS7YgABHfkhY+vZvuGrbf42FgmIxVU8UrS1ZZ9KMHMajbDNtxoMvNjhmEQlcb6CumS71FZwh/hkmkT+HIJTEnT1p2gW1YCRqvuba8kWrlYUP2duqyw+ekodaPH3pSPoQZgM9DEh57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pNMks953; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9234b77dfso478136b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720714294; x=1721319094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoNnDXcZA2Pho5pGFkRE/EwXRyBHfQQdctIQQyizVyE=;
        b=pNMks953QGk94QoHHKD0Lce0pwov1e4tScjATNeUNi8BzhU2pO288Al9WySil0ub4G
         2kJYizs93Wfb/DWiJPI0Q0DFCsIUaAEWgbkBrPbMPlOW3FvbJkVXaioCYJl6qPVCWqc0
         4Jt5vt50oCfbt1T4rgs/lODz/yDq1oHdoHsI1HUO1yxCGkvRJEjTb3DvRU3f2JjBvNy/
         zvvbnvYcU/9h9T80DGT/BkmzEsf1UtCovL6AV42jcazxnv7MS+EXM1gydXLs6VUfwfI/
         43cirTu0qvFQXnEbW0QbrAaPCWSz3eO9DDw19vAzsTs86ZCsBznTC8dhTC11fmtIPx1z
         hCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714294; x=1721319094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoNnDXcZA2Pho5pGFkRE/EwXRyBHfQQdctIQQyizVyE=;
        b=g6q07SJgouGCEaMg2KRLku2GPkDMyRs62WDX8vKeEQn0knnyXEV3L1yie00veq1hLc
         gG63Csg1YjfpoLB26N8CLS7pIri4tRqpPJmGYFOxeZLI1uy3qxIvIbMXlrH7jRat9v3c
         ll4vFH27wmF9PTLptw1zInmlwepFVMaLmvo/02kFrY5oUaJOtm1oCuuLJXePDlr8h1+9
         a8XPhvq5GKvpzV2sDCabR/lBp/1hXClcrdX67oIPc5ddQYlLUmorpm7CFcK+iAbSqHAB
         MZnCeeKkIv7z4uDviPEWuBGABfrxHuaBquiQV36qVMm5jup38NcPeFemaQPj+ff0nK1Z
         Ri6w==
X-Forwarded-Encrypted: i=1; AJvYcCXP+tLeUqaNNIHTgAVTxzYqUPUWWGI2Re/zLgzZcqbN/mx3M302/fGiRdOfJWL1rqrrBJ6wV+tZJFvo9YkLBNFYzM9WnesqsQCSsKg3
X-Gm-Message-State: AOJu0Yz1jLsRx1/nidR6ZQTzp7aHFkE6o1FdqHXo1zxi3bbX2BihxStc
	1iCqf6xNtbHQ89UqpsHp2d46aTUq55emkSwL1RDCjdUwED8SHJdmeIlYp7kv0/gk/VRxnGwELSx
	Z
X-Google-Smtp-Source: AGHT+IG5JmkBdbNyGrb7Fgc/ruuuW4qvTAb5wDj98aD29n/TX0gIJrTNfnFqyrY1biP0mOEFCNiCCA==
X-Received: by 2002:a05:6808:15a3:b0:3da:a16e:1764 with SMTP id 5614622812f47-3daa16e1f72mr1604710b6e.4.1720714294529;
        Thu, 11 Jul 2024 09:11:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f882f0sm1251113a34.39.2024.07.11.09.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:11:34 -0700 (PDT)
Message-ID: <14695107-a119-4f68-b55a-509cbcf8a64a@baylibre.com>
Date: Thu, 11 Jul 2024 11:11:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
 <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
 <20240629202003.1b72f0d0@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240629202003.1b72f0d0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:20 PM, Jonathan Cameron wrote:
> On Mon, 24 Jun 2024 17:01:54 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>> +
>> +/**
>> + * ad4695_read_one_sample - Read a single sample using single-cycle mode
>> + * @st: The AD4695 state
>> + * @address: The address of the channel to read
>> + *
>> + * Upon return, the sample will be stored in the raw_data field of @st.
>> + *
>> + * Context: can sleep, must be called with iio_device_claim_direct held
>> + * Return: 0 on success, a negative error code on failure
>> + */
>> +static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
>> +{
>> +	struct spi_transfer xfer[2] = { };
>> +	int ret;
>> +
>> +	ret = ad4695_set_single_cycle_mode(st, address);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Setting the first channel to the temperature channel isn't supported
>> +	 * in single-cycle mode, so we have to do an extra xfer to read the
>> +	 * temperature.
>> +	 */
>> +	if (address == AD4695_CMD_TEMP_CHAN) {
>> +		/* We aren't reading, so we can make this a short xfer. */
> I'd be tempted to let the compiler figure out it can combine storage for xfer and
> do something like
> 		struct spi_transfer xfer[2] = {
> 			{
> 				.bits_per_word = 8,
> 				.tx_buf = ...
> 
> 			}, {
> 			},
> 		};
> 
> 		st->cnv_cmd2 = ...
> etc
> 
> Advantage is that it is clearly structured data.   Up to you though to
> decide if this is worth doing. I don't care that much!
> 
> 
>> +		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
>> +		xfer[0].bits_per_word = 8;
>> +		xfer[0].tx_buf = &st->cnv_cmd2;
>> +		xfer[0].len = 1;
>> +		xfer[0].cs_change = 1;
>> +		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
>> +		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>> +
>> +		/* Then read the result and exit conversion mode. */
>> +		st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
>> +		xfer[1].bits_per_word = 16;
>> +		xfer[1].tx_buf = &st->cnv_cmd;
>> +		xfer[1].rx_buf = &st->raw_data;
>> +		xfer[1].len = 2;
>> +
>> +		return spi_sync_transfer(st->spi, xfer, 2);
>> +	}
> 
> then an else here to reduce the scope of another xfer structure.

Tempting, but then I risk the complaint of else after return. :-)

I also realized that the second xfer above is the same as the one
below, so could skip the return here and avoid some duplicated code
(just need to add an index variable instead of hard-coding xfer[0]).

> 
>> +
>> +	/*
>> +	 * The conversion has already been done and we just have to read the
>> +	 * result and exit conversion mode.
>> +	 */
>> +	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
>> +	xfer[0].bits_per_word = 16;
>> +	xfer[0].tx_buf = &st->cnv_cmd;
>> +	xfer[0].rx_buf = &st->raw_data;
>> +	xfer[0].len = 2;
>> +
>> +	return spi_sync_transfer(st->spi, xfer, 1);
>> +}


