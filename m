Return-Path: <linux-kernel+bounces-281668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA494D9A9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A16B21EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC32C853;
	Sat, 10 Aug 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHRFma8k"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B72868B;
	Sat, 10 Aug 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252476; cv=none; b=JO/RNlrtNh5/OUSPVhKy67eIpBJg7DxU5PluAe6LQo/UYbpG0BNEQ9PUIRxQJpXuIYW6eiwSi5oaPjk1eOCmryWbGc3NpbdYqfdLD+CgELL7R9SwyD5sj3PW6SBhJQny7FzcuUcdPXug0D8ckuPmQTwFcevkXRoo+OsFrcWDFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252476; c=relaxed/simple;
	bh=/lFyaHXhmVtlA53ZPMKyQc3ltk4A5KTcJxdy6fsIVyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrGTDN09sfi4zQ/dDgVEoUm/ow6yn1kERrGEvwhE1LubujknWYPJTETuAt2Cm9GIEPSmk31kByewlGHcPSEvRVx036+oVbGMxyZIW9HV4Hob7ntcXMDMbrrH6DXYkk8QFdd/gdsTY2Sqt8Cg1N4gnmggNb4UGBE3s7R5cZNlgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHRFma8k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab63a388bso115205966b.1;
        Fri, 09 Aug 2024 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723252473; x=1723857273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fymovBfj0fk8NoArlWFNk6IPUdDFlwqTJeOZj3xiBP4=;
        b=VHRFma8k9EtwgncIMvCJv7/42NTT3ZcCq9/vyQ46ccBgGt3G3zUxDvrJVpAh7Z6/cw
         a/GSYHdxSJxuHMT7pCCBAI9cCtCvt6XhnEHOeeR4O4MLxEj+oGFkc3dZNbZGgv052Lr1
         dQ0EWm8CzSuNQMn0PpfNZiIbijvKBw9JQCg6Ov7NOz+sIMVMzz3ugU+4U6/TPUqvS1Pz
         fZ/cicZ37nmqe2nswQ676OlwnxqobgtAMP40Zn2+f5hwefbbuj+HoY+ZIHyib3JRVLZh
         m8BFMEGNHnajES/rlII2OlXfQLpJbgza9wgIbU57omIFRam+SbGwMdJmwyrmadXSiNvA
         lqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252473; x=1723857273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fymovBfj0fk8NoArlWFNk6IPUdDFlwqTJeOZj3xiBP4=;
        b=O696+9+h43XMsKU9RgO/auFWRDgv7IzpXyRlQqZ8VhxEQOLWp8J0/9tXoaPkIl0u25
         LeNpomk5eiBlpTs38aawX/z0d1+rKeautM97KeQUpkJClwV7XTIRv/KZ7SBVlXfOFHdB
         FkT9zDjCoADZ5UVOCtlNf8nL43pxzVVSZoHtujEIpcWw9f/XL2qu1trpgaCpDzv+lFKo
         9Y4mSHhKni+dHJUIWEhUY1swCpkTMT+f75dICBaZJyehVyVWlgQGpazf5aO9rISG4dI+
         eLcnKh9UsQtNIxmzekY181mG+hE2aySKlYa5d+fNVbduBLHetxFcIt8xxmIWZWaVTgeZ
         VYLA==
X-Forwarded-Encrypted: i=1; AJvYcCVM9iDxAgiUt9yTnJzJWq47gt1Qoi+vAWTs1rApSCsmPz6T9KL0xY0ZaHY4SKMT4iGdOmPrhjEYmpf91BSnXsuukbeyr9/BlQ+UsAjmCPKxTpjMqIzQ6v3JsOzf/Twuh8LRLgwLURf7QdI=
X-Gm-Message-State: AOJu0Yy0rjMyj1F/LBK7WJTEQJYA5XYIFBneX1KcsDhHhaDLWQi5YHmm
	mN037vIYbOYYsOIcuvbiL+ESt4OacD3EYCdrSBSh1+WPmH62sanw
X-Google-Smtp-Source: AGHT+IFJckSzaPd2QD1p1fUq0a4MzsHmXzWtUTtdmN1T2d5eNwbw0gofun+j1uozA3eHGpRshVG+sg==
X-Received: by 2002:a05:6402:13d1:b0:5a1:f9bc:7f13 with SMTP id 4fb4d7f45d1cf-5bd0a577dbdmr2700729a12.22.1723252471876;
        Fri, 09 Aug 2024 18:14:31 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a602d02sm204919a12.95.2024.08.09.18.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:14:31 -0700 (PDT)
Message-ID: <39eecb79-0b1a-4a17-865f-dcb60a20a893@gmail.com>
Date: Sat, 10 Aug 2024 03:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
 <4464d0f5-1a40-40b9-8d53-7f0d75b9d062@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <4464d0f5-1a40-40b9-8d53-7f0d75b9d062@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.08.2024 3:04 AM, Maximilian Luz wrote:
> On 8/10/24 1:35 AM, Konrad Dybcio wrote:
>> On 5.08.2024 1:08 AM, Maximilian Luz wrote:
>>> Some of the newer Microsoft Surface devices (such as the Surface Book
>>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>>> Module (the embedded controller on those devices). Add a basic driver
>>> to read out the temperature values of those sensors.
>>>
>>> The EC can have up to 16 thermal sensors connected via a single
>>> sub-device, each providing temperature readings and a label string.
>>>
>>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
>>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>>
>>> ---
>>
>> Gave it a shot on SL7, some names are repeated and one sensor is
>> totally busted
>>
>> /sys/class/hwmon/hwmon66/name:surface_thermal
>> /sys/class/hwmon/hwmon66/temp10_input:32200
>> /sys/class/hwmon/hwmon66/temp10_label:I_RTS2
>> /sys/class/hwmon/hwmon66/temp11_input:31600
>> /sys/class/hwmon/hwmon66/temp11_label:I_RTS3
>> /sys/class/hwmon/hwmon66/temp12_input:38000
>> /sys/class/hwmon/hwmon66/temp12_label:I_RTS4
>> /sys/class/hwmon/hwmon66/temp1_input:43900
>> /sys/class/hwmon/hwmon66/temp1_label:I_RTS1
>> /sys/class/hwmon/hwmon66/temp2_input:44000
>> /sys/class/hwmon/hwmon66/temp2_label:I_RTS2
>> /sys/class/hwmon/hwmon66/temp3_input:47300
>> /sys/class/hwmon/hwmon66/temp3_label:I_RTS3
>> /sys/class/hwmon/hwmon66/temp4_input:-273100
>> /sys/class/hwmon/hwmon66/temp4_label:I_RTS4
>> /sys/class/hwmon/hwmon66/temp5_input:31300
>> /sys/class/hwmon/hwmon66/temp5_label:I_RTS5
>> /sys/class/hwmon/hwmon66/temp9_input:37100
>> /sys/class/hwmon/hwmon66/temp9_label:I_RTS1
> 
> Hmm, on the SPX it looks like this:
> 
> I_RTS1:       +31.9°C
> I_RTS2:       +31.3°C
> I_RTS3:       +31.4°C
> I_RTS4:       +28.3°C
> I_RTS5:       +29.3°C
> I_RTS6:       +29.3°C
> I_RTS7:       +29.3°C
> I_RTS8:       +29.3°C
> VTS1:         +30.2°C
> VTS2:          +0.0°C
> VTS3:          +0.0°C
> VTS4:          +0.0°C
> VTS5:          +0.0°C
> 
> So VTS2-5 seem like they may not actually be connected, but the rest at
> least look somewhat sensible. I'd probably still keep the names as they
> at least might give an indication what the sensors could be for.
> 
> But there's a good chance that we're missing something on how MS
> envisions these sensors to work exactly.

I think the takeaway here is that I'll keep the sensors disabled for
now on SL7 until we have a better idea and not block this driver

Konrad

