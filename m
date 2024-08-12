Return-Path: <linux-kernel+bounces-283816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B494F8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C042832F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1C8194A68;
	Mon, 12 Aug 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+iENSyK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4103187553;
	Mon, 12 Aug 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497965; cv=none; b=hqU8ae/oKDsuNhrIQr4tYbzjk9bo+FfNJN2oFe5815xW+3j3vXXWnN7WYpVrG5BhEUU3hCz/+pf4c5h486wCoZbQMd7q3vG3VA7sJQVHvaFoXBAlIlhjjqTH39Of/eyyHCMNUCK1EbjaWh4V+fa5+iYAyn80gRd3MyyTLTlklRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497965; c=relaxed/simple;
	bh=wMs2bOYJfqd0y0Ld2lLBq7F+nsDzAKceHbzNk6IdGDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUjRyNYXdL1JUN2GAiPnYlTgbDpO3hb/8IeKiBMaLH+lQrE0rb4+pAr9dTCkRTYWCcd2c+LiomlS5HQ0blz4EVsTNjozPiE/p9rzlIoT9Ad2ye9jxMIe6L3av+KvKiuaFEIEwQAe0D8cxlUVrSLu2TK2F/xf1VvgnilRmDnVap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+iENSyK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fec34f94abso40620355ad.2;
        Mon, 12 Aug 2024 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723497963; x=1724102763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DI60ENYKuc4jq86VizKF8fbWvTHIUGxC9Lcc7S83ceI=;
        b=m+iENSyK1MqgZQwQKV3BHRKXcX30niNY9HxAC0RsbkYMFhHYxO6C0RuDsP6/RBh5FI
         xk1QpnjjV4dOe5SoLh11iftnE5Y2MjO91RhqECM/bYmrK+yspYiD0gUnk6NkbufsY4H8
         tVQZe1hPL6ZL1rcTvZBlZ1rPt6zEmdHjPJXWTxXP8a2MK0HpodDOWSf7OcNCWZeW9mP+
         8HFdg9h9Kd8+MwbqPT97VX42xGq/XAGRMqM/5fq5HP994x2R4oakDuQ+8IV45UAJSF7S
         4/z9wih++QwJPdO0skkLm8zRZW6BnTXfQXjhtWvRqthJ1PdZW+0HRIHjxXKkn+nDmK65
         Z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723497963; x=1724102763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI60ENYKuc4jq86VizKF8fbWvTHIUGxC9Lcc7S83ceI=;
        b=XAANvkxmbqG4hs+aQ/7aZAQsSoeoaA/I2SCVCZ93k6imqFajx4AZFgO9s4dIRZV4jW
         4LWDa0Csxqb5vNKVNEDYaU6D6PFiVYI85BfWJ74ihpEHeSSyGdJ37cMb4Yaw9PCJ7cRt
         /nx2mLjCyEd5CE+laVtQTd2Pv8aATJnSnztfmbQyegCkMSjJmPHYUL5B6GSfN797+0wc
         9Ld2HKTUuJfqHk54QGtxgogWuHr1cozKpyFd2wwZPXcnIzWbDFJa+vnQiLv0AYBjQzQs
         nHc8Ce2XXvDLqEjJa2RMaj8ALd1YDtKZGBxapNFN1KFwKbo1fLjHbQVCTZihzo+QYOkq
         gZwg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPBATg+4Vumfn9PYbOHsewahFNquYUn1dnhQdLKlEPTDWq8zYyHL3VkyaQLlAcoSuhONb9notJYtYy0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWi2aa4dB/NZk6J0/ci+8TcGopXmN/Wg49dzKRGewMuxgcywU
	w1TqSlfxLPmWTc0Fw9ZgpvHaQ1PxhGW5iw+EkHmpJmoJSnAuCpgG
X-Google-Smtp-Source: AGHT+IGqt/fUuxTHAHz0DhX0/bFLqYsrmXEJBrb5UBicd88Omvo8XNzCNnvK8QSix0iXrp1r/3j3LQ==
X-Received: by 2002:a17:902:e5ce:b0:1fb:7b96:8467 with SMTP id d9443c01a7336-201ca1ddc48mr16689245ad.63.1723497962972;
        Mon, 12 Aug 2024 14:26:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd131692sm1317705ad.60.2024.08.12.14.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 14:26:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba54014c-429b-44ed-a887-e25a4bf033c0@roeck-us.net>
Date: Mon, 12 Aug 2024 14:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
 <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
 <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
 <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
 <eefbeda1-8c09-4b57-83dc-30be9966de2b@roeck-us.net>
 <f6034baa-3a1c-4bd3-8cf2-cd197e8a0945@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <f6034baa-3a1c-4bd3-8cf2-cd197e8a0945@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 13:48, Javier Carrasco wrote:
> On 12/08/2024 22:08, Guenter Roeck wrote:
>> On 8/12/24 12:59, Javier Carrasco wrote:
>>> On 12/08/2024 18:49, Guenter Roeck wrote:
>>>> On 8/12/24 08:43, Javier Carrasco wrote:
>>>>> This check is carried out after getting the regulator, and the device
>>>>> can be disabled if an error occurs.
>>>>>
>>>>
>>>> I do not see a possible path for a call to cc2_enable() at this point,
>>>> meaning the regulator won't ever be enabled. Please provide a better
>>>> explanation why this patch would be necessary.
>>>>
>>>> Guenter
>>>>
>>>
>>> Hi Guenter,
>>>
>>> this patch enforces the state where the dedicated regulator is disabled,
>>> no matter what the history of the regulator was. If a previous
>>> regulator_disable() failed, it would still be desirable that the
>>> regulator gets disabled the next time the driver is probed (i.e. a new
>>> attempt to disable it on failure).
>>> cc2_disable() checks first if the regulator is enabled to avoid any
>>> imbalance.
>>>
>>
>> That is very theoretic. Sorry, I am not going to accept this patch.
>>
>> Guenter
>>
> 
> I get your point, but given that this device requires a dedicated
> regulator, I believe it makes sense that it tries to disable it whenever
> possible if it's not going to be used. I think that makes more sense
> that just returning an error value without even making sure that de
> regulator was disabled, doesn't it?
> 

No, it doesn't make any sense whatsoever. What are you planning to do,
clutter the kernel with code to disable regulators if instantiating a device
fails for whatever reason and it turns out that a regulator which should
not have been enabled to start with turns out to be enabled anyway ?

> Of course this is not a killer feature, and I don't want to make you
> waste much time with it. But I think the dedicated regulator should be
> shut down in all error paths, whatever status it had before.
> 

I strongly disagree. This can only mess up the kernel all over the place.
Maybe you can convince other maintainers to accept such code, but please
refrain from doing that in my scope of responsibility. If the regulator
subsystem has the habit of leaving regulators enabled even after they
have been released, that problem should be fixed in the regulator subsystem
and not be worked around in individual drivers.

Guenter


