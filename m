Return-Path: <linux-kernel+bounces-189405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44788CEF88
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612021F214CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FD5A11A;
	Sat, 25 May 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRvepX4V"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC7107A6;
	Sat, 25 May 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648842; cv=none; b=tCSiciPoGMLhZoeNjA/2cStAljMmtRQCMivnEGsWMrLqPk7umV3i5IjC8soniOKe/7J9wOS0d0lA1g2AVZGN4Fvaqv5TUUPgkfV7asyJ+5p6XnZrNdu4wCcdFcEkB9Ikj4JtyRS+Wmuei5q9kUBhNEbwQvncXSYaoMXmtd2epEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648842; c=relaxed/simple;
	bh=pNG0EKZujHbSab+LZ7wdot6YwOcqKmwSGstrSo6J4Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX/lKFtY/Xsp0saBV7Y/ePJsu0I84yeJrvu3J9x1rRglOElzb69ViIi58qbvLVeZdFlpF9ALnJCSZdZc2yF0YVMZlV60yMB9HiT9x/SN99s1+VJ7xR+fB7+5nQMvuGZvu+u9snZkiiN6DgffKL4GwgA6y6jntMko2aJF71uaol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRvepX4V; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f72b8db7deso2048168a34.2;
        Sat, 25 May 2024 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716648840; x=1717253640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xsHI2DBt9hF0EHHm6QZhJ3Qh39tSVl4D2pH3WHTp0qk=;
        b=eRvepX4VdXC9rkFg+ZbyEupn3FJ88qzD/j9+HJjK8mZoTdRUjoJGkbHJ8XVF4EMU8E
         0HwY86Qy8l2hVEwErvNakW27dqFrDpwGKw3Eq2/yOKICZUXr0Jbd5VpUfIlPqwHv5PXr
         iG1qPja1R0UaT4A+7dBlQJgd6Ac4M54KDtn8gS0BYQRNK/LfG4p3IE2QVFBzBQzc+cOV
         29C751rTR9OnCpBVOp6sfePyntNfcAJ5tg/fEbSUW0TWhTJxW6pgSA/PNBkWpLDQxNRF
         +FIgvxK55+u8YHLMQUbhdZ+XtM0SqepQU7arC/RVMQP8VN/Zv2sUBMlSOFBxT9oKsDPg
         qtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716648840; x=1717253640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsHI2DBt9hF0EHHm6QZhJ3Qh39tSVl4D2pH3WHTp0qk=;
        b=lKaDYD6coXEEEZjVJQCRErds/xnd4cSAu3Le35VKDJRCxl+LESp79JCMs9Z4D7RFub
         /z5LrjnjgkwDshO9XQnHQbVG/grA/zVWaWCZg2vFu2/U8u0wWjFXUzmIlFjrnRhpP3JK
         Kcxs9Wcyi+7h3j8F9lSv0vzXANRf0op2ynfP9+JQd6rEpMI1alGDxjpauZ7fMUUJgbAq
         sj7doSGZuDdhQjAq91Cl9r21CJb2UirQJJUMXV+xEvJIsw23YIersZKgV6DGzeS9eDgK
         6CJ5aivf57kT6LShrmUSDiD2Zb0FEOvhSeicoE897OsGPcrvYIQsgKhhdsR/TVOEC1aQ
         VZnw==
X-Forwarded-Encrypted: i=1; AJvYcCXGTGPBi8JCHXVs0vijd0i/cE6l3jC1rbs/tFt1hSyeqtHdznka+mZ/6p0eKARao+pq+nbv8G9BuILYzGCsjxRWTcb1EozgcKmJS/pCxvc00lXnBnNYRNTnYdr3bCpfYvNe66NZIF+POYs7m1JFABnkoRE9ZXFaBJBeYgyytCrpaqRKwGf0
X-Gm-Message-State: AOJu0YyX+N/Xkv6mnYGOruXWRdQ6kUjrDWBYPUMBd+iaBPmYfSgxBgUK
	eiFxGU8uFHD8K1noB6wl7PvsNa2oZeonxWYCnsT8jDK12UAzU9Ir
X-Google-Smtp-Source: AGHT+IGb0zkKEsYhicviLZ9OXSqS4TyEuAcbHOBhBTN5ki5/JD05DS5wWUgN1smNZHBobPNgnuiNdg==
X-Received: by 2002:a05:6870:2f0e:b0:24c:4f1d:d3c4 with SMTP id 586e51a60fabf-24ca1277c00mr5580681fac.20.1716648839998;
        Sat, 25 May 2024 07:53:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe6672sm2543839b3a.154.2024.05.25.07.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 07:53:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <818aacc7-5244-45e1-844d-561e8540cb46@roeck-us.net>
Date: Sat, 25 May 2024 07:53:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: g76x: Add support for g761
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-2-ansuelsmth@gmail.com>
 <22e1daf4-ffce-4fac-be4c-0e7bebd91c88@roeck-us.net>
 <6651f77a.050a0220.9b079.fbf3@mx.google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6651f77a.050a0220.9b079.fbf3@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/24 03:50, Christian Marangi wrote:
> On Sat, May 25, 2024 at 07:32:04AM -0700, Guenter Roeck wrote:
>> On 5/25/24 03:29, Christian Marangi wrote:
>>> Add support for g761 PWM Fan controller. This is an exact copy of g763
>>> with the difference that it does also support an internal clock
>>> oscillators.
>>>
>>> Add required logic to support this additional feature with the property
>>> gmt,internal-clock and reject invalid schema that define both
>>> internal-clock property and external clocks.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    .../devicetree/bindings/hwmon/gmt,g76x.yaml   | 43 +++++++++++++++++--
>>>    1 file changed, 40 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
>>> index bfefe49f54bf..d6e80392d045 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/gmt,g76x.yaml
>>> @@ -4,13 +4,13 @@
>>>    $id: http://devicetree.org/schemas/hwmon/gmt,g76x.yaml#
>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>> -title: GMT G762/G763 PWM Fan controller
>>> +title: GMT G761/G762/G763 PWM Fan controller
>>>    maintainers:
>>>      - Christian Marangi <ansuelsmth@gmail.com>
>>>    description: |
>>> -  GMT G762/G763 PWM Fan controller.
>>> +  GMT G761/G762/G763 PWM Fan controller.
>>>      If an optional property is not set in DT, then current value is kept
>>>      unmodified (e.g. bootloader installed value).
>>> @@ -22,6 +22,7 @@ description: |
>>>    properties:
>>>      compatible:
>>>        enum:
>>> +      - gmt,g761
>>>          - gmt,g762
>>>          - gmt,g763
>>> @@ -48,10 +49,37 @@ properties:
>>>        $ref: /schemas/types.yaml#/definitions/uint32
>>>        enum: [0, 1, 2]
>>> +  gmt,internal-clock:
>>> +    description: Use the Internal clock instead of externally attached one
>>> +      via the CLK pin.
>>> +    type: boolean
>>> +
>>>    required:
>>>      - compatible
>>>      - reg
>>> -  - clocks
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - gmt,g762
>>> +              - gmt,g763
>>> +    then:
>>> +      properties:
>>> +        gmt,internal-clock: false
>>> +
>>> +      required:
>>> +        - clocks
>>
>> Is the new property even necessary ? The absence of an external clock on G761
>> could be used to imply that the internal clock is used.
>>
> 
> Well with how the driver works, if a property is not defined, then the
> value is not set and the one set by the bootloader or from device reset
> is keept.
> 
> This conflicts with the logic of no clock = internal.
> 

Not sure I understand the problem. It would be a simple change in the driver
to add "if the chip is G761 and the clock is not provided in DT, use the
internal clock".

Guenter


