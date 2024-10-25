Return-Path: <linux-kernel+bounces-382156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7419B0A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C51C28555B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7C1F76A9;
	Fri, 25 Oct 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o9TCbAy4"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6C189F2F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874526; cv=none; b=mCMtayTkJ5z1GtsYJmRW2KP9sEvPLvhJerzfXREbUBpGsGzvuNwhWuBLDmw5iS2Rz4rbsmbtWBfz+9pxUI2LAlQ7EFzPgt1EcxVXd8M4ooyeTIJhbO5uWCnu+5/W8bAh+yb83dEVvBG3k/+E95z4o38g6xs6EqgFlR6sgWG9YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874526; c=relaxed/simple;
	bh=bZQFxBqJCoUYz3PAAj5GVi9qI9j8Xi0ZuxSzi6a7CW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx7vTOc/bP/3CCjJEPcvwrl2qj3ZgHMWXsKZ4Xd+E+Lif+rRayvM2G1bc4OJnbV1AgqeuqlVTbIIJQ0ouni1eVfTN3QFGh7SyMjOLn+RnigpJLLKw7uxN39ytzGVubfhYF4ZPsEfh0VBfPxz7ZUC9HGJJpWkArypJDy2QagtMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o9TCbAy4; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7180a5ba498so1164864a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729874522; x=1730479322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/dAgQT3sLw1VNMbjsWYUyTB0NwG7xZCYWQp+yMNAOY=;
        b=o9TCbAy4gVQDsKpp9/3FxpxwQkpHP72l8Q+Q5LeAL2Y5CoLV2dZqeZrsaGX4MIeee8
         c4CHv+RmrUPCxLtkYMXciqm3XHkKjLCF0xhdkWByQ5/S4BFKEIQDHpX0MXOXomxcC2K+
         w1mEBKxsimRMpTpfN1oj9S9cyWahFCwWfhJYyd8+5zMWtTfu+QHB8paIDYovAg7XLzje
         Toq17mAeV1/TqCt7CpK5aDI4d4TWTWt0IwmovwQbRqYypyFEnUsQ8lPGUpp5dy8GUyqN
         LPQ/yxovQ1CyOA0Qft5CyGwBgpRrxAeF/bqLHNJHz7LXcQRWuQvKIZUPmYrqTpTkTIgN
         IKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874522; x=1730479322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/dAgQT3sLw1VNMbjsWYUyTB0NwG7xZCYWQp+yMNAOY=;
        b=ayPT0VEXIUxFt8JwQvVNc9lYRarQM9HI8CjLFpArvau4JQHHVFZdnb+DLBog6BHphb
         Gzct1Hc7ou1WyEI1HFUyjogLuZlqu877SHxtXsJCZma+5XsPkE+lg8VHe03I1wDTyId2
         cgPNjtfwbqEJfYzdeaqXh/mAhtzrRzR3uifz3z5iZFS+m4abupP8DmligIOrCWVsBeiJ
         LpO7WZ/2oZ+zGQkyr54HTEtfg/jJFDEpmfrhJnBCJolwdh2JcsiRYn/GXWz11tOcJbR7
         3PVqxHacXfvTM08GDDGShs9in+8prbL8wmoalIzfWOERXN9R2zo7rftffjAfGjIPayAn
         Pcnw==
X-Forwarded-Encrypted: i=1; AJvYcCXsFVC97h/B/au08LfkyZfW/RQIw9Sbarf1WVZWIDScq3kGzw5jkRPdiWm6IEDklKCxk0wFTaWkVcs2Slk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnzYZOO27zMwM2+VFULKM/IW32N5Ma9KRjtp6gw+yNmp9wASx
	Z3B3n99QVIjJlx8RRvIfYhnKuzk8wNC1DLqdzGS0l7pD/WSEpJg+oXfNwsR6SJU=
X-Google-Smtp-Source: AGHT+IGKHLpFac6i1JEpDgdAb/A8ZfR5LsdyJcTXFPCsZHKM/f3VteH3iR8BhJBy3Pr1CfWqY2TOaQ==
X-Received: by 2002:a05:6830:2105:b0:715:4cb1:4409 with SMTP id 46e09a7af769-7186829a661mr214665a34.31.1729874522247;
        Fri, 25 Oct 2024 09:42:02 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718618c561esm283564a34.67.2024.10.25.09.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:42:01 -0700 (PDT)
Message-ID: <87614827-aec3-49cb-898b-f0f85e7efd81@baylibre.com>
Date: Fri, 25 Oct 2024 11:42:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-11-f8125b99f5a1@baylibre.com>
 <1f4156e8c6c4da09fc5d72661d1e002ae6ee4f31.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1f4156e8c6c4da09fc5d72661d1e002ae6ee4f31.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/25/24 8:24 AM, Nuno Sá wrote:
> I still need to look better at this but I do have one though already :)
> 
> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
>> cases where the DMA channel is managed by the caller rather than being
>> requested and released by the iio_dmaengine module.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v4 changes:
>> * This replaces "iio: buffer-dmaengine: generalize requesting DMA channel"
>> ---

...

>> @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>>  		iio_buffer_to_dmaengine_buffer(buffer);
>>  
>>  	iio_dma_buffer_exit(&dmaengine_buffer->queue);
>> -	dma_release_channel(dmaengine_buffer->chan);
>> -
>>  	iio_buffer_put(buffer);
>> +
>> +	if (dmaengine_buffer->owns_chan)
>> +		dma_release_channel(dmaengine_buffer->chan);
> 
> Not sure if I agree much with this owns_chan flag. The way I see it, we should always
> handover the lifetime of the DMA channel to the IIO DMA framework. Note that even the
> device you pass in for both requesting the channel of the spi_offload  and for
> setting up the DMA buffer is the same (and i suspect it will always be) so I would
> not go with the trouble. And with this assumption we could simplify a bit more the
> spi implementation.

I tried something like this in v3 but Jonathan didn't seem to like it.

https://lore.kernel.org/all/20240727144303.4a8604cb@jic23-huawei/

> 
> And not even related but I even suspect the current implementation could be
> problematic. Basically I'm suspecting that the lifetime of the DMA channel should be
> attached to the lifetime of the iio_buffer. IOW, we should only release the channel
> in iio_dmaengine_buffer_release() - in which case the current implementation with the
> spi_offload would also be buggy.

The buffer can outlive the iio device driver that created the buffer?

> 
> But bah, the second point is completely theoretical and likely very hard to reproduce
> in real life (if reproducible at all - for now it's only something I suspect)
> 
> - Nuno Sá 
> 
> 


