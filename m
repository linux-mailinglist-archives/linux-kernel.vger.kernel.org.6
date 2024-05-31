Return-Path: <linux-kernel+bounces-197537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6298D6BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C841C25A44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DB82876;
	Fri, 31 May 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGbZF8e+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238F81AC3;
	Fri, 31 May 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192244; cv=none; b=nEiZVbTnGjWvq8gRDBuVvseXnd8yD3WnVMNj2VXZv4Yqqfzc/ZHMJBaoXPt+H779C8TH7iawAudvUH7J8UHyOvDS7ZnkGYyQ9fjxJdFFbc405Kd2DNDBajU3Tz7UsdgIA3TaBCCxZ60UokrkXw+lLGs2rF2EEiqiK97whBYjkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192244; c=relaxed/simple;
	bh=qVjAzYJmg/3LhPTWuC3MTisC3Itt1jRkl5kv7uiZWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BE6TlWL5oxsY86+OQWSvqXwVCAwtxDh9rdHFcPArGykvkJhq+RxzSmCPUGvKvabP92a+0D3rRzDGxt/EWbCEVtavTXFUv/ukZgBDs2PkVJ6StHx4yBLdB9Lrxk3YqK/B1h0pyWuRrIruU5IW4f/sBL1Y+sTxnsO9TRLmuAEdOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGbZF8e+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70234843a67so2050117b3a.1;
        Fri, 31 May 2024 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717192242; x=1717797042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uCUM0vHfUxs5T4DYnVX7mJ8jYT5mGlx0XKmQiKJa2KM=;
        b=hGbZF8e+Gb9b0G8CfFPCzAJBP/NfxRu9yJ4pRzOXRV5y+EkHoGLekGg+fBM8aW9fIP
         aFUGIC6I+OP4l7heU3yIzh+f0MVwf5VvqjfzvmMvNfm0s3+whhzADJOEHmXTFMMqN8Pd
         bBJFBFyHeZ/LFTT2y3JPFCFSqcSsjTRupHWRJUr9Ym3Tf7qyH8uFjgG+Nhx51QjOyDOb
         XxzasSos5ZlMB6JtbX7pMWQsKygK8fUdaWH8c9Hpkx4qYU1rv7BuJE/+txsD2d2LtWr+
         2rHTVj8PU6cwIS8Q65Oz+/PpDkTLBMDLyE9IzCcSe7T5uJq4rUNIuSBwlUFkdyt6/WmW
         asKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717192242; x=1717797042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCUM0vHfUxs5T4DYnVX7mJ8jYT5mGlx0XKmQiKJa2KM=;
        b=j4C3hAj9kNbqSjv4ges4wW/NsQJf7davRvZIzIVV+Stlo9Rmigqq/HANabQDKnw3fS
         CHd8R8BRZUJLz9CXF5ELawOrJVCe2AU2uzZjcBDYldS2f+j1aI+UbjgIZW0UlXeITWyQ
         n53klqHtgzbur1JaZXuDgJXZIF4H2oW5+OfrAeslg6H/ur9tgReC3c0VzkzKX2cTXb4V
         mj1eqCj33Wk050TyfmPO42TrjMxJk5a4DqLFqL4nMuCeuoFoXoG+95yBSwBXlkXx0zpW
         xhYyYJwkrEo4GIbniBjUuKKtadDZTgZuFb2ax4kMeiPAVYiSR+TEYYrWuS5InDGlOt4L
         eLCg==
X-Forwarded-Encrypted: i=1; AJvYcCUlYN8/V0o2Mhcuig4WCIweaFCCUuNb7+fXIyROOOWN7NXubOokEgL7sUjkKctPvAWUo5DDHUqDHjxGnBAyBWEnCTg1UJmqnEpPlnQ6jElVYS9zLgIKLF+LtLD2RveBntE0M4wx9+o5wA==
X-Gm-Message-State: AOJu0Ywv2QOmLKvOkIqdmVeW+8qniSyNtLUw3PcTggMGHm0O2CcYc4Td
	5N+B4Ej8+QvZDqLegJyv+Gee/iXK+8sEqqMARAXTBkehTDMcp0+VUVhSGg==
X-Google-Smtp-Source: AGHT+IF1BtbVfdSJj8l2TJeUMqufcaXX1W7IzUb+QCCW7bUTMsqSs6z4o5vumicGkTI635u6ANrKWg==
X-Received: by 2002:a05:6a00:22cd:b0:6e5:43b5:953b with SMTP id d2e1a72fcca58-7024780448bmr3629140b3a.14.1717192242241;
        Fri, 31 May 2024 14:50:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b059e0sm1877472b3a.176.2024.05.31.14.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 14:50:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f96cc689-a340-4eec-8187-57e74b20c07c@roeck-us.net>
Date: Fri, 31 May 2024 14:50:40 -0700
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
 <76dd5c0e-cc67-4ad1-8733-d8efdb8a172b@roeck-us.net>
 <3a050921-6bf6-444e-8f61-83fcb6b9f2a5@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3a050921-6bf6-444e-8f61-83fcb6b9f2a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 00:41, Krzysztof Kozlowski wrote:
> On 29/05/2024 16:01, Guenter Roeck wrote:
>> On 5/29/24 00:07, Krzysztof Kozlowski wrote:
>>> On 29/05/2024 08:07, Amna Waseem wrote:
>>>> Add a property to the binding to configure the Alert Polarity.
>>>> Alert pin is asserted based on the value of Alert Polarity bit of
>>>> Mask/Enable register. It is by default 0 which means Alert pin is
>>>> configured to be active low. To configure it to active high, set
>>>> alert-polarity property value to 1.
>>>>
>>>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>>> index df86c2c92037..a3f0fd71fcc6 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>>> @@ -66,6 +66,14 @@ properties:
>>>>        description: phandle to the regulator that provides the VS supply typically
>>>>          in range from 2.7 V to 5.5 V.
>>>>    
>>>> +  alert-polarity:
>>>
>>> Missing vendor prefix.
>>>
>>
>> Are you sure you want a vendor prefix here ? Reason for asking is that
>> many hardware monitoring chips have configurable alert or interrupt polarity,
>> only the name is different. Some examples are the JC42.4 standard ("event
>> polarity"), adt7410/adt7420 "interrupt polarity", MAX31827 ("alarm polarity"),
>> or DS1621 ("output polarity"). We even have a vendor property, "adi,alarm-pol",
>> used for MAX31827.
> 
> Hm, I just checked if this is already existing property, but indeed I
> did not check other variants.
> 
> Indeed it could go to common properties - hwmon-common.yaml. But then
> how about using strings (as I asked before...).
> 

I can't really comment on the strings; that is out of my knowledge zone.
It might make sense to have hwmon-common.yaml, but I think that would
require a some (read: a lot of) work.

Guenter


