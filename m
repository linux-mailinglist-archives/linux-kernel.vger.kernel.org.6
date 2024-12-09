Return-Path: <linux-kernel+bounces-438129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8B9E9D45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E812E166F20
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD5155743;
	Mon,  9 Dec 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0eMW83n5"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA51552E0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766260; cv=none; b=bFXnQfcVVW7YrejLyEK99E5nyKBqIcyjjlBs1LbGwpcvaALeS/CgFePEgLGA9yCLv1eCsYq+v6AbHHljGWKXo1+FCrJ8OwyetBNFLcvfIs46ouD0Y6+grS7qXNBxXq3kLxhmNgXba9VxK2BpWMZ3kc+APkOsaxewbizHU3wg+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766260; c=relaxed/simple;
	bh=T8VsNOEm3fdtOz4g+8Npq3QFd9DXTd9hJ4Mx+0kU1Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK5nQwWLkO0RE42INpUyOIpdffgoj9OPflxaTqWG/+oueE7+ti9DjC3MvWl/CH5Hk8CD/CiW6PGHKdAemc8THSFuPqhVJW8TIGwBscxHicy3kpE8jWyQX2PiUhr91dDtTTW5lJ8xzhCrUhyo8eaB2Er4u/0C5bk1IKWLgJRTjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0eMW83n5; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e0351311eso94689a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733766256; x=1734371056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQaHY150Yps34xQsPyk4V8n2PV48YCsChjwMePfbEZc=;
        b=0eMW83n5rJvm3Z1VPKBQr0LAAEimjThUcIhFCLXzYmgRdNvLfmjCrkiD/xkEybgWLZ
         EBI1dbbFooV6lFkfmj+F/exE60/f2wwlfSf1aiJY2DGHnZ0kNIhIvmHe9XZs66DASfYF
         67twLwgEE2pf1i9ULMP/IaQYLIrwOOfuI0/w8WoBE7cBuFwUDTlM0DF8tc4TeD2pfaZx
         Jlm3ymiPR6CtNqIa5yGHXJI6t8EefPNZsAQ5gg51kmsHcCYJmrt8V0y9NEFRQL9J39Mm
         a/k87wdGm/9Pib0+1l29XsxUwD4KybFXgVpwKDrEGdgZytWnNMNKfc2DH95hBmXP0U8D
         0AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766256; x=1734371056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaHY150Yps34xQsPyk4V8n2PV48YCsChjwMePfbEZc=;
        b=VAV0BVXpQchP0YDoveAAq+KJrgvHtddQG3O9cLrAJEsDDEieGWPzil2mz7LJzggc5g
         9wHnV1tZ6+Ll9k1cGeerA6PAEW8P7dYyDPd3yptMtl+DYBKZ1vVRe579yzH9ZVt1W6Gs
         ibxHvT5uaiUxOfhrtIt53tNqEpO+rE2HPCDg3RSJmGm4LXBH4Zv/e/JqcuRxR+/X9HgK
         vNyHvQLlaN/NxT8z+WdQe1mfp+arkC7SRA3+I2X4RMRmII3IutS5kZ68O38Ajmc9wvvJ
         e6K7NPTDqHavZDdo3nL/IwKw14Y5IhGsgw0Y/Lxmw+FSFL7mlZ+QiY3M5t/s/teBiFSO
         qDFw==
X-Forwarded-Encrypted: i=1; AJvYcCVmN0Gwvd1ZKvPvmLuMp9Tx88Mknnm6YLHiKyVihMIn8Uvdn90vznJlUVG0QHVQXZlF4hc8+eBnS82hFik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUdEem3HE7PmfXtw2pQQB8KxcPo2+iD34U/Ees2lpWyB0DQ2N
	Xr6xfFCF/P+43utolmm3V9H9Xl73yX+awgpNNg9pnHr00L0qDAs0P5i17viRHzg=
X-Gm-Gg: ASbGncueD4o30wFaNb5Em/ugFaRuxM9om/yKypenU+bXDAfS31hzf2JuNnNVni4WqcC
	MHuxVRGzXdJHIlRs6O1oKbl6JOCa5/52YjB85F42B3MzKxbomGmVtS6wit6bsheTIouatEYg9t4
	yO3rucUJC/PpeZtzbjRKNgK3R34DHzoB+VmMEj3tGoanoWUvAHqwzVQwDwdXAd9Eb7rNf7tERlL
	Wv5+fCfzvUBCJDpx90qXTG/wZhx59Q+L8OS2LwbgUFersSDqvrNZhlZNDIg3f2rgRHKmOeylnhV
	qhtJFDbUlv4=
X-Google-Smtp-Source: AGHT+IFb81lytRSGzGy7brox5UjxhmObKKJPioRXNthRoTofZyWXpYB3n+qfmyKwwp6491Ja7RrpNg==
X-Received: by 2002:a05:6808:1883:b0:3ea:57cf:7c26 with SMTP id 5614622812f47-3eb66e12187mr1006950b6e.19.1733766256635;
        Mon, 09 Dec 2024 09:44:16 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb57b69471sm551260b6e.45.2024.12.09.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:44:16 -0800 (PST)
Message-ID: <4be8bebb-7db3-43e5-b00e-95ebf7114d80@baylibre.com>
Date: Mon, 9 Dec 2024 11:44:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-8-antoniu.miclaus@analog.com>
 <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
 <CY4PR03MB3399F17206B01006467B602F9B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB3399F17206B01006467B602F9B3C2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/9/24 8:02 AM, Miclaus, Antoniu wrote:
> 
> 
> --
> Antoniu Miclăuş
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Thursday, December 5, 2024 2:46 AM
>> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
>> robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> pwm@vger.kernel.org
>> Cc: Conor Dooley <conor.dooley@microchip.com>
>> Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
>>
>> [External]
>>
>> On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
>>> Add devicetree bindings for ad485x family.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>> changes in v7:
>>>  - add adc channels support
>>
>> What is the reason for this change? In a previous version of this series,
>> you explained that we didn't want to specify diff-channels in the DT
>> because there was a use case to use channels as both single-ended and
>> differential at runtime. So I am surprised to see this being added now.
>>
> We had a discussion and we decided to go for the dt approach for specifying
> the channels configuration, even though in the first place we wanted to avoid this.
> Overall it makes more sense.

OK, in that case we will also want to make use of the standard "bipolar"
property from adc.yaml as well since the chip differentiates between
unipolar and bipolar inputs.

Also, might want to drop Conor's review tag and give an explanation in
the next revision since adding these channel properties is a bit of
a big change compared to the version he reviewed.

> 
>>> +patternProperties:
>>> +  "^channel(@[0-7])?$":
>>> +    $ref: adc.yaml
>>> +    type: object
>>> +    description: Represents the channels which are connected to the ADC.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number in single-ended mode.
>>> +        minimum: 0
>>> +        maximum: 7
>>> +
>>> +      diff-channels: true
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +    additionalProperties: false
>>> +


