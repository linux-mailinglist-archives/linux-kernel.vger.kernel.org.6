Return-Path: <linux-kernel+bounces-319226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EE96F97C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFA31C224A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F16B1D4171;
	Fri,  6 Sep 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U0sDv+Bl"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8F1CFEA7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640937; cv=none; b=h0VwIicUBQCg5mf0U6VSFzfFc9UshXW5Nq8DEwNTkfB5qLLgnDD+2EgbBfJH5jVZG7Wgc3gJTXH99vnF+dYMnsaAghNt0EuMURMO47xUV5jmh+uvPSxA/SJdPOVadULVO50Yt/wKWZgL0OEwUHtfiNbqeh1tLmTkUJQ60tBa4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640937; c=relaxed/simple;
	bh=SLERIPPuqlPcRz7SpVydvsOfSapGckEZ8PoOBgaOu18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G16ewhsHIEefAb97s+9+Ybm01wT6tLB/wiJLxF8b4C+c0GZZePQfcj5Vw09AG2AfqOwf7oi7+7zAfsThEDNpYHkm9RD16nBrEC2ditKjr1JDSIUOrDF7E8VuVTNBGCm0NXRij04ClFXm/GxEBvE/xZnQ5SDHjULN6UA8+87tOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U0sDv+Bl; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5dfaccba946so1385384eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725640934; x=1726245734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpqcN7trnRgHngcOVURxYt9dm6dnWJM7OBEcFnkkzUg=;
        b=U0sDv+BlAnmhtuAp+vT8vvICopJfscGpKOWW7zFOXKnr5z6RFl8+YkQa0qisW1eMbK
         +iOgkWVqXu+A716DF48a/0U7H3/Bd+cgk7wxlVEBwFgmHFoUtXN6jT5zRFqebo0VlI7g
         fEuCnm9da+2jLflFEczgLHAMmy84DXPmY8ZCqu4ooHv2dRTGUX03q4llO6zDNU8eLvu0
         GuW5V83ykaWb97IP71lfLJ393az1KQm1v52/dMELE1EehvFesGUdo9T5c/4O601xGIYD
         MsLZQ3cOH//ED3f5OcL1FKq6GH9+WTndLgb+/SWrInxpPhyUjLefrXA4ETg3IwiwZu0C
         EUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640934; x=1726245734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpqcN7trnRgHngcOVURxYt9dm6dnWJM7OBEcFnkkzUg=;
        b=wcwYeogAd/r3az3l3jLWKk38TTeKlajDFFO1Bu5nYK9u4RB745iS4S7eEwz1+YJGaS
         njWwenQOhvht5s9icdZwt5TKjCalsvscNCIYIDkhdaRAzNLlWy3bkqO+9tqkJc8gRc/a
         TdErb46dLzf4k/DdMve92F8F7BOs/WeAUlBdQ7EO0XZ32ajb3yFj7u/hPcD5ZRnIBykq
         J1HLO9Dpx49UOf4eb1+n0SEsYHtCcf6m1sLvRQb0CadkerMDGPNsVldpscJVrckX6EZ7
         ShW2f/bCZV0LdV6XixyLJcQ0FXcFz/UwJFpaKTktC6ZRMGPd37/P8rVL9sSVxogus2Tb
         kysg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWpqxxvFrVAt7gpvybTdVGCka6/bNB+R+5w5sw3cBN0uKUlGvGxeywamX62CFdvHLUAOun0+LCvBg/4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2hYZ0VUKVP36Uuc/RWUO3fAVupOs9lWAb2P5BrOfORhbdkyn
	j6RiuY/7zDk+MfZuzhyIhvZjwnifDKPHIIOaoYxpjlo3b/64zCPzFuPH8icajlA=
X-Google-Smtp-Source: AGHT+IEcQu0eoB+tXXu3duqiyzHk5VT5eBohbhuzsk6G7mLNTEYwF881Gs0Oi59FI3WM+BGOFwVsZQ==
X-Received: by 2002:a05:6820:1b86:b0:5ce:d2e3:b18 with SMTP id 006d021491bc7-5e1a9d96318mr2981666eaf.8.1725640934310;
        Fri, 06 Sep 2024 09:42:14 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1b7671f79sm51291eaf.31.2024.09.06.09.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 09:42:13 -0700 (PDT)
Message-ID: <9894666e-30bf-42c0-88a0-18ce2a9300a2@baylibre.com>
Date: Fri, 6 Sep 2024 11:42:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
 <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
 <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
 <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
 <de4718f5-a36f-4e5c-b5e1-f1c6e2484420@baylibre.com>
 <bb25003f-3a30-4d73-9b40-447d2d513fb3@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bb25003f-3a30-4d73-9b40-447d2d513fb3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 11:36 AM, Krzysztof Kozlowski wrote:
> On 06/09/2024 16:04, David Lechner wrote:
>> On 9/6/24 8:52 AM, Nuno Sá wrote:
>>> On Fri, 2024-09-06 at 14:13 +0200, Krzysztof Kozlowski wrote:
>>>> On 06/09/2024 13:53, Nuno Sá wrote:
>>>>> On Fri, 2024-09-06 at 11:37 +0200, Krzysztof Kozlowski wrote:
>>>>>> On 06/09/2024 11:11, Angelo Dureghello wrote:
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
>>>>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>>>
>>>>>>>>> Add a new compatible for the ad3552r variant of the generic DAC IP.
>>>>>>>>>
>>>>>>>>> The ad3552r DAC IP variant is very similar to the generic DAC IP,
>>>>>>>>> register map is the same, but some register fields are specific to
>>>>>>>>> this IP, and also, a DDR QSPI bus has been included in the IP.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>>> ---
>>>>>>>>>   Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>>>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>>> index a55e9bfc66d7..c0cccb7a99a4 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>>> @@ -24,6 +24,7 @@ properties:
>>>>>>>>>     compatible:
>>>>>>>>>       enum:
>>>>>>>>>         - adi,axi-dac-9.1.b
>>>>>>>>> +      - adi,axi-dac-ad3552r
>>>>>>>> I am sorry, but what is the product here? It looks like either wrong
>>>>>>>> order or even completely redundant. What is ad3552r?
>>>>>>>>
>>>>>>>> And why versions are mixed with real products but without any
>>>>>>>> compatibility. What does the version express in such case?
>>>>>>>
>>>>>>> dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
>>>>>>> about the version, it still reads as 9.1.b
>>>>>>>
>>>>>>> so i can eventually change it to:
>>>>>>>
>>>>>>> adi,axi-dac-ad3552-9.1.b
>>>>>>>
>>>>>>> Should be more correct.
>>>>>>
>>>>>> No. First ad3552r is the product, so axi-dac is redundant. Second why
>>>>>> adding versions if you have product names? Versioning was allowed
>>>>>> because apparently that's how these are called, but now it turns out it
>>>>>> is not version but names.
>>>>>>
>>>>>
>>>>> Let me try to explain on how this whole thing works...
>>>>>
>>>>> We have a generic FPGA IP called axi-dac (same story is true for the other axi-
>>>>> adc
>>>>> IP) which adds some basic and generic capabilities like DDS (Direct digital
>>>>> synthesis) and the generic one is the compatible existing now. This IP is a so
>>>>> called
>>>>> IIO backend because it then connects to a real converter (in this case DACs)
>>>>> extending it's capabilities and also serving as an interface between another
>>>>> block
>>>>> (typical DMA as this is used for really high speed stuff) and the device. Now,
>>>>> depending on the actual device, we may need to add/modify some features of the IP
>>>>> and
>>>>> this is what's happening for the ad3552r DAC (it's still build on top of the 
>>>>
>>>> What is "ad3552"? DAC right? Then as I said axi-dac is redundant. We do
>>>> not call ti,tmp451 a ti,sensor-tmp451, right?
>>>>
>>>
>>> Yes, I agree the DAC part is redundant. But I think the axi prefix (or suffix) is
>>> meaningful to differentiate it from the bindings for the device itself.
>>>
>> The binding is for this [1] IP core. The documentation calls the core
>> "AXI AD3552R", so I agree that "adi,axi-ad2552r" is the most sensible
>> compatible name.
>>
>> http://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> 
> I don't see any AXI here:
> https://www.analog.com/en/products/ad3552r.html
> Neither here:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> 
> Are these different?


Yes, they are different. AD2553R is the DAC chip itself. But "AXI AD2553R" is an
FPGA IP block designed specifically for use with that chip.


