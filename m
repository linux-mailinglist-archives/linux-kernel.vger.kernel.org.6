Return-Path: <linux-kernel+bounces-256495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6C934F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D412843C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A821428F3;
	Thu, 18 Jul 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkPeXBOg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B51422DF;
	Thu, 18 Jul 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313825; cv=none; b=keozD1JcVUOs63rGVKj+th3PZtMkR+oway9vUuyKDXgViunp8jPH8Q0ZvNVKTEi6Vh45k94pyVCoVgBKws39zVtQ9IG3QfUVkrvc7/SCz154VW3me0xsB4rTlICpm/3XlUnZgaDZ+xCOU3HSfCxVAZLuhj+L0xjq94PMN5WUTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313825; c=relaxed/simple;
	bh=OjQgauz04F4WunXRmrsbPayIHPqJFg4YUDuvNFk7Ffs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENdRnPE5WENPbnw4R+aU3DiUmeojc60eH+8yaBAiD/F/XwUpO/k91Z9N5IMZEEVtxPYdjDT/qPaI39NnhE8vNiNMuJPA377RuAnve8T5BjVRLO7omqggodocJrEjTtg7qeajp2KIurMluMV9w9Uq4qCDQb7zZezog5cpLedzjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkPeXBOg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc491f9b55so9387455ad.3;
        Thu, 18 Jul 2024 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721313823; x=1721918623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GjzDXW3kZEtp2A38sgHNE5zWtis9wGhFy94Ua8OQG2A=;
        b=CkPeXBOgaUly20/IuL5Ile8oi5DAb/QQrM8sbiC6Zn3vXhQJ5AXrNGx5/vENL8+SYD
         abnhGQSsXjoyjETmw7dleg+nbWPFiYAWbzVa4+ULyhZROcx9vwmfjuTt3xTGTiuHU4yJ
         KzXr9dxKQBJsOLPKUIVcVumS4Hk+kLOBSq8WeQvcI2c13YPN+ZuHx/qkIQTTaPi4lDaK
         l1u5ZPJMBaInPwFQTOkahoUJMc3GeOmvadSdMuVJ/I3NZ6tG4hpsx16Kcrb8RvzdwUdY
         7vLW499wl4fGEC0pglWSHn4rRdRfUbBoBc6IejqiPuGz0EDFnOzNpen1fzVw8XXjzhb7
         CWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313823; x=1721918623;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjzDXW3kZEtp2A38sgHNE5zWtis9wGhFy94Ua8OQG2A=;
        b=Au2qj5xjUiFrMLHso9S3HQhny9PqP5VSWVlL/txtdv5Nq5szwGsop36/uY4Sy5Nkvc
         CnQSlKvMmVIhvktu/rNJxZB5DiOjG3DPfbIaOab6znTQY2cRs9d3O0nABBvhbBLUk9UZ
         C0m99bnDLirlplXrFCet9ysPTz6VuLkcP3+zFJLKygR3LDXuEvXoXPLfgDwH99qsk58m
         mXB2x/zEOEdGb0vzHMAbKb5Bv3jJ8ta8Dt2PfnsL2lKxOjAokH3UTiM6H21gaRc+03PM
         adkX4tql3iZ8Be8CGTCDfR94YOEbpMLdWUmsOYKcAhfcLF+kxxhxJW1Kj85c0wS4HxIW
         FSug==
X-Forwarded-Encrypted: i=1; AJvYcCUMwAplD6MGY+vDRuzT2kqxHofdEBqvSbVeaPTRUjkiJogdxWutAKJvkqYp8ORALICoMPGisVyfmNOeiyRKX9cOi7mzPp0tfPDsm7j0i5a9hy6L5WWyO0ozWFnywAmPjgB2eUmxw8UzRlI=
X-Gm-Message-State: AOJu0Ywdc0e5A3IK5b6WZ4E5lOsy1exGsaGuC0AoFuciTUjujj7/WIXj
	bIlFAj6B41a3Mimy11rmaZkwgRxXM1+DUSbqa/+oRqdY+lGr8Au3iN+PPg==
X-Google-Smtp-Source: AGHT+IHkOMkQflcxukK6aR5K5SFfZyuXmlEZmL3zApxMXLXSoL2Y+fzDQAYihadONLIYmpALwua5eA==
X-Received: by 2002:a17:902:e5d0:b0:1fb:4bd2:d076 with SMTP id d9443c01a7336-1fc4e14f94fmr42001395ad.27.1721313822552;
        Thu, 18 Jul 2024 07:43:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc274f8sm94248455ad.171.2024.07.18.07.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:43:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8aa17f38-a6f6-4ba9-b38c-767ed39c1c92@roeck-us.net>
Date: Thu, 18 Jul 2024 07:43:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hwmon/misc: amd-sbi: Move core sbrmi from hwmon to
 misc
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
 <20240717081027.2079549-2-akshay.gupta@amd.com>
 <6e8245d5-8c39-491e-9fd0-1be88be7b00a@roeck-us.net>
 <e0bb9cea-fe65-f421-ecae-a0f6326c6417@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e0bb9cea-fe65-f421-ecae-a0f6326c6417@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/18/24 03:21, Gupta, Akshay wrote:
> 
> On 7/17/2024 9:56 PM, Guenter Roeck wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 7/17/24 01:10, Akshay Gupta wrote:
>>> This is done to support other functionality provided by the SBRMI, which
>>> does not fit in the hwmon subsystem.
>>>
>>> - Move the SBRMI core functionality and I2C device probing part to misc.
>>> - Move hwmon device sensor to misc as only power is reported through
>>>    hwmon sensor.
>>>
>>
>> I fail to see the logic here. Why would the supported sensor types
>> be a reason or an argument for moving the hwmon code out of hwmon ?
>>
>> Guenter
>>
> After we move the probe of i2c device to misc, we were using platform_device_register_data()
> 
> API to probe the hwmon sensor. Greg did not like this idea of probing, previously I have explored mfd cells
> 

Yes, if there is a new restriction in the use of platform devices
(outside mfd), this should be documented.

Guenter


