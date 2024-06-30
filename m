Return-Path: <linux-kernel+bounces-235111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E368F91D046
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C16281EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C43BB30;
	Sun, 30 Jun 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OM5wFlBR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752112AEF5
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732069; cv=none; b=Djx9jGY1biXBkkWFyGZ1CB0B6RrK3EEbzMkMnvbOTVvvQCpJvXtMOzAKJlB2q44eIM0ka1xEZsL+ipY/qQg9U7ijW0hsHEM8PtxkFU1KGVjCd8QtXKhTYDcWz4fFWpq0biFb6y38dWMuS/LZhwckYezjBZvsn4+8g9wU4OtBdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732069; c=relaxed/simple;
	bh=zP+jxE3Gh/pfhjFXl6jTIUpnww+YDCCSY0/ou0WX1Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4O2PrI3gPkPNyccaLAwc+fn+80qYdOCiAp/NpXuGqhoAzkIPAdQKW4eqSRWx99HL1j5EmlZ0n8Fndi25/v3RnSgR8+6A1KBUqq5g9Sbq3Cv35HTlmHjWSn/jwCaCcb5yWJgYKfxz3R2pCChlUbM47OL5WD2NRp14ho6l6rHml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OM5wFlBR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354b722fe81so1435388f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 00:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719732065; x=1720336865; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxIrL1L6dkYcdkFshMmKKgX5WO92izWELbH6RH4L7V8=;
        b=OM5wFlBRQb1O09z4Qpi5J8s1SCEIkG7+OjOdNcdhxdptQlSHrQiUtlkFRFFV3cCQGE
         +/bHAndSc3StSbuzhydChHkh9RfZ/lq7SNo0MvLDugfhhum1++lbLDf3U60P4Nex1ouL
         +sAMYi2IlUg6FWoVw18PZHOGZK3NnU0I7fRsdIKJtLMg//o5OCkBDx3b6ZJ1ZATAr5O8
         G+nL8Z8KAL6ksxx8VEbEOX9eEAfbIbRq5FH5xuzcoFkBTSMywYkEz1eqMMhL1CQ3hxa/
         QGjwUJWJmXYO2avvCOa0Ya04lbwp01g0mre8cI6VMFpTKhoT9qacurom5zsDEcYHJGQP
         VEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719732065; x=1720336865;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxIrL1L6dkYcdkFshMmKKgX5WO92izWELbH6RH4L7V8=;
        b=S77nP+8Fx7aylNQ/L4J9D1LzdBkHcOSQaghePJPrTSL/yTL/u9JrS0O/usJ4PZ0v16
         gYjrdPfI2Jh9UEr4jFZMkIIL+3jn+8uFheMQ+Pm4xN075NQShHXLzKNFrnuDmVwAk80i
         hYeAn8/h0emaQ2DlKqJBma8EfehxglP4ee+vLeVooqW695ZAL4XlyKCgHkAxk8n0sIxm
         /A6WmGwuePuguNPCJ5LrZ+GowMdEUzoIDRdPi4/sgyqG1QgPs/foJPBH0KJbJmuyNaV0
         R6R9cxT4vK+3uC5q+xP9h1HH07PXbIUvLIX6CwlPu0VidB8jcaA5xl0DT0u8r9+ysFsu
         2TpA==
X-Forwarded-Encrypted: i=1; AJvYcCVCethYuJMwNZCvF0OQeM9BQygf0Uq4kTplCMxLsinqvZIlED/1JF2djDJXxqqsBFV+8v4Ja7j6oy3RBqdC15PE/JVs0VN84JugGKt0
X-Gm-Message-State: AOJu0Yx2EvS6ddbcCUCvgpKox225p8+V3dbK2N61WzAG1t1e2ol2vla0
	/1boxZsVxJc1mJ4Dfu6ZWfod4NnazCB6BmyL+VYyBRSS8yHSMjivwROBSUKGZfs=
X-Google-Smtp-Source: AGHT+IGjjPVzsLMMKXGmALJ6E6SXf2+JbUt31lucblCiZrTTba6Axn63pFlilhVkWVbFmUwGL3yb6A==
X-Received: by 2002:adf:e985:0:b0:360:9a3f:aa7d with SMTP id ffacd0b85a97d-36775698c7amr1669101f8f.1.1719732064483;
        Sun, 30 Jun 2024 00:21:04 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:51e2:ba1a:8ad5:52c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc429sm6693888f8f.68.2024.06.30.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 00:21:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-iio@vger.kernel.org,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
In-Reply-To: <20240629204025.683b1b69@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 29 Jun 2024 20:40:25 +0100")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
	<20240629204025.683b1b69@jic23-huawei>
Date: Sun, 30 Jun 2024 09:21:03 +0200
Message-ID: <1jwmm6hp5s.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat 29 Jun 2024 at 20:40, Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 24 Jun 2024 19:31:03 +0200
> Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>> Add support for the HW found in most Amlogic SoC dedicated to measure
>> system clocks.
>> 
>> This drivers aims to replace the one found in
>> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
>> 
>> * Access to the measurements through the IIO API:
>>   Easier re-use of the results in userspace and other drivers
>> * Controllable scale with raw measurements
>> * Higher precision with processed measurements
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Interesting device and the driver is pretty clean.
>
> Needs a new channel type though as altvoltage is in volts not hz.
>
> Various minor comments inline.
>
> Thanks,

Thanks for the feedback Jonathan.

Just a couple of things,

David expressed concerns with having both IIO_CHAN_INFO_RAW and
IIO_CHAN_INFO_PROCESSED for a channel and we did not reach a conclusion
on this.

My idea here is to:
 * Give full control over the scale to the consumer with
   IIO_CHAN_INFO_RAW
 * Give an easy/convenient way to get an Hz result with
   IIO_CHAN_INFO_PROCESSED. There is a bit more than just 'raw * scale'
   in the implementation of this info to figure out the most appropriate
   scale for the measurement. They idea is also to avoid code
   duplication in consumers.

David is definitely more familiar than me with IIO but we did not really
know how to move forward on this.

Is it OK to have both IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED, or
should I ditch IIO_CHAN_INFO_RAW ?

>
> Jonathan

[...]

>> +	indio_dev->name = "amlogic-clk-msr";
>> +	indio_dev->info = &cmsr_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->num_channels = CLK_MSR_MAX;
>
> Superficially looks like the number of channels depends on the compatible.
> Ideally we shouldn't provide channels to userspace that aren't useful.

Not exactly. All SoCs have 128 inputs, Some may not be connected indeed
but some are, and the name is just not documented (yet).

>
> You could search the name arrays to see how far they go, but that is bit ugly.
> Probably wrap those in a structure with a num_channels parameter as well.
>

I've been doodling with this idea while writing this
driver. Technically, there is no problem.

The legacy driver this one will be replacing used to expose all 128
inputs. I thought it was more important to have continuity with the
legacy driver than filtering out possibly useless channels.

Another benefit of keeping all 128 is that the channel index (both in
sysfs and more crucially in DT) matches the one in the SoC documentation.
That makes things easier.

Would it be acceptable to keep all 128 channels then or do you still
prefer that I filter out the undocumented ones ?

>> +	indio_dev->channels = cmsr_populate_channels(dev, conf);
>> +	if (IS_ERR(indio_dev->channels))
>> +		return PTR_ERR(indio_dev->channels);
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}

Thanks for you help.

-- 
Jerome

