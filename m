Return-Path: <linux-kernel+bounces-544081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3CA4DD29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4690D3A6DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D777204594;
	Tue,  4 Mar 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJl37krr"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54B201031;
	Tue,  4 Mar 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089298; cv=none; b=hGAbV5JM0FXrilb9rowWLXteTJftalHAPBKGdNQVaoh3rroM3tLH8Q7O7ktpR+0XTYBxx4rQ43sMMz0BsQMrurYIzOGdMERWlKEaII8o3e+to+9E+zU/L7+VBdoEUgw97VXkNQ30dgN6/RbWyd9jVcca3Qk0EsHeB5IJUZn1xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089298; c=relaxed/simple;
	bh=EQzD1omOm3pwKmNRswisadriqNvQuIW7Gq+mnIrQTA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwQ1ytUbsuTPERFkJHb68WcLPu2JV6Pn2GeON8basqKf8x2bS0NqDGqVZWBA4dd0vEXmS176QRx4Xxfuh/Pm3t0LbRaaMyfcmXfe118sjkFjNZojtQqvz0NSNHeikGKjk7MI4AcnW6/3T3/QTJ8sUn/OZR02N4U7aZNFo3tzx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJl37krr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a7065ff8so56730285ad.0;
        Tue, 04 Mar 2025 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741089295; x=1741694095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F0XpVkzeedW1Nq5ayemT7/ox8DNq+JWUkRZ7WL8wWlc=;
        b=TJl37krrHayFsoGmokNdBbzQ+YsjJ1zphF2OFxWFqigHMvP4MraoiUMmRCky4+ABbf
         cc3aC3NrdJNL2LMuaeSDzzC08hxETIs5vT2IaHse6zoq7ioxsEn+vI41eG5Q05iwXW9J
         3uUYiK1WQSXXxpEz+brMLnHIQeFpAAksMZxzFE/ooWvnxYY88T1DoMtQtDxFhvjGYrNV
         cjP8/xTDuscr5AeNoeW/dFvd66A/uqCXpyfqix65sKysPIQAKF8a0LG0X7TInXGg5szJ
         iIN0mq7Gwy4JdeIWahODpnYDWvue56vZ3bAQXEpxKtKkXfQie1PTiIEYnAMX5Rxld81j
         E1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089295; x=1741694095;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0XpVkzeedW1Nq5ayemT7/ox8DNq+JWUkRZ7WL8wWlc=;
        b=TUysYm1cr5SyE0D0xB0ShhfVyf6G430QRfm26c/Sf/1B08i7ydzZlZWZ5jz7YuUfHp
         MQj8JYZJX/Z6dNHqABSYHx+KaPm8PaGWayZS17NcmdnYzOBPfbf40F1m6sjwP/ZrxZdT
         dGL1I3mwQU4W3v+Z7f3et0YWXKFyv3Ai4W/qDz2gswjybmzG8NgFSUsYdsqFCCU51oSp
         gKvXCs+AikbW68wnnkytpRPItVuyOY/2YbTWKhQBvOE3fAImrnNl4lCff+PntsTIcPkB
         kKX3ueKG4cwe3f42u4YpI9WUataEQHcwCSYsb47ajbxgHpUSOKAwUPUZjc4vgo6k/ChA
         jp6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3Xj43uHzqNGgQB8pIeMkIjG/c1BR/0oHwFDWc/pDT3a1xyJLni5dtHpAI25TBHShXSU2w91z97S579tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxINZ45hTAQXhBzHJ7yFc2lwU06ZjA9kOjuxFs1IGFKZtvEC07
	mEJnClZbQFte4izSbdtP+SD2GNmp0rCYcbEHXneC8979zmIRyA+1
X-Gm-Gg: ASbGnctbVl4rqGsLG1CtOUDY+olNOjZH2lc5L7fYUjdUnLNNoxBVbWHXx/8putBLuam
	G2QcUixtSbQqW/KHr1W1ghlAspMAjGMoF1PAn7v3Pp67SWoz4/9CpjKssaigxP4CyQwmd9pf8pD
	G1DL5rPJhfLqb+ygBphxiH4QQYawbIB9YfIMcYtCgxZ3UXMvam4K+cMX8Hog776+KCmY1cH6fAn
	0hvU/aoX7e53uwYXG414bGHowq8Z8mSv0WdNCpCNT3IAsHiMlzKNokBP7/BpFFzlpPQ6yKsdlKq
	Nsa9I2gEY93bVvEgDIgB0Fcagefl2O+tlKSHtHnMJ6qEdEPIaGT7TuUHl8fvIVIL88plwv39Gj9
	AQRAWgo0LLG79Rb8wuw==
X-Google-Smtp-Source: AGHT+IGjUyHinsp26h918ISYhQUSikLX8b8ReBxUeT62h9WkpjHl/aT+V/7bjuOjQNhz98/I4BQgVg==
X-Received: by 2002:a17:903:41d2:b0:21f:859a:9eab with SMTP id d9443c01a7336-22369258a09mr265334055ad.37.1741089294580;
        Tue, 04 Mar 2025 03:54:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bd2sm93815545ad.111.2025.03.04.03.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:54:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d3e8a814-1dce-4054-87f9-3bd3f7b7c6dc@roeck-us.net>
Date: Tue, 4 Mar 2025 03:54:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
To: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
 <f2b58aab-6664-4968-86d9-1e761a41b065@roeck-us.net>
 <PA4PR04MB7630FFDEE9AF8E1458DBA6B0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <PA4PR04MB7630FFDEE9AF8E1458DBA6B0C5C82@PA4PR04MB7630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 03:33, Maud Spierings | GOcontroll wrote:
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@roeck-us.net>
> Sent: Tuesday, March 4, 2025 12:12 PM
>   
>> On 3/4/25 00:24, Maud Spierings via B4 Relay wrote:
>>> From: Maud Spierings <maudspierings@gocontroll.com>
>>>
>>> Add the min and max temperature attributes as it is trivial for this
>>> driver.
>>>
>>> This can help with detecting implausible readings and indicates to users
>>> which range they can actually measure, so they will not set a trip point
>>> at a temperature higher than max or lower than min.
>>>
>> Unless I misunderstand the driver code, readings outside the table values
>> are never reported. Also, min/max are supposed to be alarm temperatures.
>> The reported values for min/max would be between -55 and +155 degrees C,
>> which does not make sense and has zero value for trip point usage.
> 
> Regarding the driver not reporting values outside the table values:
> 
> That does seem to be true and is good in my opinion, however currently
> 125 can mean 125 or something higher, with an indication of a max
> measurable temperature it can be determined that this is a max value and
> thus might have extra considerations.
> 
> Regarding the meaning of attribues:
> 
> It is difficult that the attributes do not have descriptions in
> include/linux/hwmon.h
> 
> Is there an attribute that should be used to indicate this maximum
> measurable value to userspace? HWMON_T_HIGHEST/LOWEST?
> HWMON_T_RATED_MIN/MAX?
>

There is no attribute providing the temperature (or any other) range
supported by a chip. highest/lowest are highest/lowest measurements, and
the rated attributes are rated min/max values for the system, not for
the chip. This applies to all chips, not just this one. Misusing the
ABI to report "limits supported by the chip" would be inappropriate and
misleading.

> Some extra ramblings:
> 
> I want to have some indication of what the lowest and highest
> temperatures that the sensor can measure are. Imagine I set my trip point
> at 140 degrees, but the sensor can only measure up to 125, I would like
> there to be some feedback that this trip point can never be measured.
> 
That would be a problem which applies to every chip. Unfortunately, it is
all but impossible to try to express that in sysfs attributes. Many chips
have different temperature ratings based on the chip model/variant
(commercial vs. car vs. mil), but the valid range can not be determined
from register values.

The same really applies to this driver: The tables in the driver are for
specific thermistors, but the thermistor will still provide a reading if the
temperature is out of range. It will just be out of spec.

On top of that, thermal limits should be based on board limits, not on chip
limits. A board which supports a temperature up to 140 degrees C but
utilizes a temperature sensor which can only measure up to 125 degrees C
would be a badly designed board. Trying to address that in a driver
would not add any value.

> Some kind of plausibility check may also be interesting. For example I
> have an ntc in an lvds display, if this display is disconnected it shuts
> down because the ADC reads zero, which means temp==temp_max.
> 

The best we could do would be to return -ENODATA for temperature values
if resistor values are out of range.

Guenter


