Return-Path: <linux-kernel+bounces-199792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840D8FA5FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AC21C21B65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97C13CF9E;
	Mon,  3 Jun 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At6Gh0lz"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC013D62B;
	Mon,  3 Jun 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454678; cv=none; b=YW5AWozDOPc7EzK7GJ/1WcvO5U55OFi80x3cTon7Bgs7aXpW3EyHw8kZ7Om3WTLevVRqs+zwKaM7kiiYF6+7KEqB2xMehyg8b9JiiaS1oLRs498kCbz3MYNfhw6fz9vfvTpHk6M6CgR4yK/FC+K0MHK63hTGipVBMnjGRYhagyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454678; c=relaxed/simple;
	bh=K/fF6I8MZdCib446ViiMP2IBrSRBDtB529m5Q/j4YFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nR8hpvLxn8gPVRhANnNFiFSOTUfXz5vXdb36PpWOexpuvMEoqNeVbaLJnIlf+tUc9jhQwA4ySFJxZsnE8lCM+FK+tIdZvZm4foPgj5HMQXjcexYimGQNJ8+YlEg/SXIpIOjJ02XT8HIeY+NFZcfsaZ27WvPJ5BPfDWp2uExUeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At6Gh0lz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4603237e0so3202931b3a.0;
        Mon, 03 Jun 2024 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717454676; x=1718059476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b6MFsrdOqti0fLHOpjLFRquYHGOzZCKkTJvH51/EUg8=;
        b=At6Gh0lzQobV9jtbxy2uavJkNRc4STe2Lt7Q/x7chdtFH40584Gn9xnOpPQB1vz1Nx
         YG10vfrBIoCTUrj45ZZmpZ4X/+bLi7+ioGVeIqaPXBKpIarfmDc4pi8E8+6cqtfNLXpN
         QgGtMBUcv4j4ImCJhhOFyfih1URMKa2RZNxKou9sQGWIVIa4JftnlCgWERswYLqEFQcz
         +3sJsxe9UJ8Bwf+P6Q3XqeX+d4MChIDh0x4bXFJj1mm8I5iNFMg0y9y//RJ6dUM2ENiP
         ksfugvTZdsyB2sg7viBV/YOO3XUmuOM3h4W8ZRMLMAirtD9Dx+Nck2dJc5kh0LAeRXjw
         e3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454676; x=1718059476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6MFsrdOqti0fLHOpjLFRquYHGOzZCKkTJvH51/EUg8=;
        b=M2lmjj3XPlUysutisur5yTjzquf1qj8WpW4z5NvwxPeLA5jnvJQEF9MELf86LxXX4b
         9mWNUG7b3ztWPAlYM/aO3ZLks0KIUhNmF8N7AFsXZ1bca+t/xUSOVFjanLlT/34zEpeY
         OaUCDvyRwKLn26Jnd5n7gjktJEIiplA1pfAmFgrvhAtvUYcgbgME9GrU64z8n4H02YlJ
         aNmdcCGJarDkWiky0lUBvuB5E3XrJtaPe0YHR2qCj8sceJ4sTmKyWHIayrj8RAV9+XLv
         th4Ok2/kY0heRCH0yXzjqMlYvkaB8mSikQZYnKPqrZ5r0YuCYMNtup5555w+EO2KbbJs
         nabw==
X-Forwarded-Encrypted: i=1; AJvYcCUYU2i9mPAWca5OvMtSG42WFHNIfpzKFZbpsvuvXH+7WtRnt2dCsOk6npeT11LNdl/qHR8banZLu1E2/T2wbJDrcIlgkPGq1bblR2qQUTYKWTXbdLXVEMM8IJvBoDX4zKFSSNf2z9tYpoumA1TQ/vFOgwAShgGSYlA5Bx4j+Y+Wq/zYIjh7
X-Gm-Message-State: AOJu0Yz7+kt+2kDh+xS/KpIncsXy9iAGXLLlyL0zMNH1OqX3pVv8anPw
	vIFTuT562IdlkzFt5AaJzVmocta9qmkSy2i1FrT08fpEfSIBRFweUgUPdw==
X-Google-Smtp-Source: AGHT+IFEWfmnqW/lKBXXcKRUlmP/KHFs6IAz3nIGtYOHq6iSbp/r+3uFtnxQ/Oe3U4rGxCdKbvAcKQ==
X-Received: by 2002:a05:6a00:b44:b0:6ea:c7bd:90e3 with SMTP id d2e1a72fcca58-7027fc4308amr1276552b3a.14.1717454675830;
        Mon, 03 Jun 2024 15:44:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c262sm5991741b3a.190.2024.06.03.15.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:44:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <588c68da-1129-43e2-89a9-4edbabfd018b@roeck-us.net>
Date: Mon, 3 Jun 2024 15:44:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ti,ina2xx: Add alert-polarity
 property
To: Rob Herring <robh@kernel.org>, Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>
 <20240603154728.GA480397-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240603154728.GA480397-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 08:47, Rob Herring wrote:
> On Wed, May 29, 2024 at 08:07:14AM +0200, Amna Waseem wrote:
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
>> +    description: |
>> +      Alert polarity bit value of Mask/Enable register. Alert pin is asserted
>> +      based on the value of Alert polarity Bit. Default value is active low.
>> +      0 selects active low, 1 selects active high.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
> 
> This is alert as in SMBus Alert? That's handled as an interrupt, but
> this binding has no interrupt property. And the interrupt binding
> provides a way already to specify active trigger state. Why do we need a
> second way to do this?
> 

SMBus alert is a single interrupt/alert line for all chips in a single I2C/SMBus.
it is handled by drivers/i2c/i2c-smbus.c. It can not be handled by an individual
driver since it affects all chips on a single bus. A driver supporting it
is supposed to implement an alert callback in struct i2c_driver.

The signal is supposed to be active-low open collector. Some chips, such as this
series, make it configurable; in this case the alternative is active-high open
collector. Presumably there is some wiring to attach it to the active-low open
collector SMBus interrupt signal.

Having said this, I don't really know what the use case is for this driver.
It doesn't implement an alert callback, and it doesn't implement an interrupt
handler either (after all, it might be conceivable that the alert signal _is_
connected to a dedicated interrupt line). So your question is fair - with neither
SMBus alert nor interrupt support by the driver, the alert signal polarity should
not really matter.

Thanks,
Guenter


