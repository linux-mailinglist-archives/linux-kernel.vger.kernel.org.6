Return-Path: <linux-kernel+bounces-194218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B48D388F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C862283501
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDF1CA9E;
	Wed, 29 May 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOcvWy8d"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4088D53E;
	Wed, 29 May 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991323; cv=none; b=N4EPTfGtJAYJJXFpp/CdWeTvZ37NXHSCiWygz+hqN/lFJDAF8Hg+/knfHgVk+rxdgvaIFrFDTVj6l/QOEhpgpKoUkkRFGU9F7JOwlYZwIv0jmVHgXfyiWPFyJ1WH1Nz31R9UpEm8IWcYBaJbfFaO7nS1bl2WTbRrsPgUPk8NegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991323; c=relaxed/simple;
	bh=7BvQIjtqhgsfSju2Sv+LCPz/pJQOYXEFYDdtXUzbbxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIzE9lexYhx/DvnghUbm0gv2mSqUDGGZMhmhY2nnIFWXp/iBNJZq4Ij4xt4FGdLtCebUc2wZTu/RBz1swglsGekgl4LdQBjr9TlTogvzWz+mnUDtLRiyMV3SMjS1yrayFqRcLVHEM855qPnVwUrXSJbSiCzdYl+fLCNE+flkklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOcvWy8d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7021ab0d0f5so422235b3a.2;
        Wed, 29 May 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991321; x=1717596121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LVXZeVnLsg0ViktlE8rjdZXCIRUH3zGk7VHAnoHlLq0=;
        b=MOcvWy8dGk6L9ypIKibvbU47w8GV6f2QvPJ4/XSQIdg1Bvl/bWWih3xDvFY9QDB+rk
         7BPNtU+2yoid7j2C6m/jRcbTsz6w22aaWeLqOJXQyV0sxieE7GPJSIzsYSE0o9zQU1uv
         ZoRvFB5++SzRisKpZs+Pi3TpWmpQfi4NP4P0w1jCk3IPAIkFTYFtS1iKm2aRN2pGrHFV
         4t8CWbUzyuafQVjetmlY2L2Qht51p96978Oj/CWZLV8oSLebgTkbBE3zIJdDPe0XhvhA
         vXF75NnxF926VcU51fvJP5+ttN1eA0yE6Bl20kNrsNx473eHU+kaSRvyEErrkqt2G3Zl
         djRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991321; x=1717596121;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVXZeVnLsg0ViktlE8rjdZXCIRUH3zGk7VHAnoHlLq0=;
        b=Q5MP/D/Gd3Ib44hDn9kb+f8dPqos2nHV7Y6KRxTrQB/s29aem4Xcq0wXgqmJNh0Cr7
         eRXQPA51YhrV36Eoh74prSunJ+sHTM4K78J/KOZ3RjdXyH3UKYxMnKSm+ClihPRkKkf6
         I9m0luTT3oE4TheJsv16//5IG5Mwop9AN+whANka81vuGOFfCJIcCmt0pixJ8E6TTWSd
         WJTz5SYjqI0ASfvSifKcUkA6JqXYiSeoIVEGxY7/Dms5OD91aG7uevTtdiSxxUs5jE3P
         A3tl4pne5YO41ODEUrSYVSYWW+gHgWTtkcN4f+aHj+K8AQ7mqJNBh/8ujFMhC7KWUOn0
         /xrA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSVHiqpFY9R/mbsoHIlgUciG6EplHWCCy05y9B8C7q3kurnBnmy5enXzWwzDTNNX/02H4kE36nbQl16jMreSocoQULda29/ehA0fyYrYr7DLGbhKOCVsxH9u9MYiRz36UGhIX/OvVfA==
X-Gm-Message-State: AOJu0Yyt9F0dF1EsZVsIV00fWQHfnapgRoGnbhmXnzQaw5hknF+bhCn2
	somPPtDCMsAAJwNorNNFXWTfUS2ASzHBei2LoqJP9wU90Ox3gnpH
X-Google-Smtp-Source: AGHT+IH/qkoVVkCaMiE9B+4sdDu1fi4o9p4+g7nWxv1Kdcx0Gb/sL2KYxXBASZUegVJfHIWH9jbWjQ==
X-Received: by 2002:a05:6a20:7f8d:b0:1af:e649:6f4 with SMTP id adf61e73a8af0-1b212f874d9mr16544409637.57.1716991320875;
        Wed, 29 May 2024 07:02:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfdf510sm8296052b3a.143.2024.05.29.07.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:01:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76dd5c0e-cc67-4ad1-8733-d8efdb8a172b@roeck-us.net>
Date: Wed, 29 May 2024 07:01:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ti,ina2xx: Add alert-polarity
 property
To: Krzysztof Kozlowski <krzk@kernel.org>, Amna Waseem
 <Amna.Waseem@axis.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>
 <1ae97b90-ff20-4238-abe2-f2e5d87fc344@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1ae97b90-ff20-4238-abe2-f2e5d87fc344@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 00:07, Krzysztof Kozlowski wrote:
> On 29/05/2024 08:07, Amna Waseem wrote:
>> Add a property to the binding to configure the Alert Polarity.
>> Alert pin is asserted based on the value of Alert Polarity bit of
>> Mask/Enable register. It is by default 0 which means Alert pin is
>> configured to be active low. To configure it to active high, set
>> alert-polarity property value to 1.
>>
>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>> ---
>>   Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> index df86c2c92037..a3f0fd71fcc6 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>> @@ -66,6 +66,14 @@ properties:
>>       description: phandle to the regulator that provides the VS supply typically
>>         in range from 2.7 V to 5.5 V.
>>   
>> +  alert-polarity:
> 
> Missing vendor prefix.
> 

Are you sure you want a vendor prefix here ? Reason for asking is that
many hardware monitoring chips have configurable alert or interrupt polarity,
only the name is different. Some examples are the JC42.4 standard ("event
polarity"), adt7410/adt7420 "interrupt polarity", MAX31827 ("alarm polarity"),
or DS1621 ("output polarity"). We even have a vendor property, "adi,alarm-pol",
used for MAX31827.

Secondary problem is that not all chips of the series support this
configuration. INA209 has a configurable "warning polarity", but the
warning pin and the smbus alert pin are two different pins.
INA219 and INA220 do not have alert or interrupt output pins.
Only INA226, INA230, INA231, INA238, and INA260 support configurable
alert polarity.

Thanks,
Guenter

>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Alert polarity bit value of Mask/Enable register. Alert pin is asserted
>> +      based on the value of Alert polarity Bit. Default value is active low.
>> +      0 selects active low, 1 selects active high.
> 
> Just use string, easier to read. But for sure do not introduce different
> values than we already have - GPIO HIGH is 0, not 1.
> 
> 
> 
> Best regards,
> Krzysztof
> 


