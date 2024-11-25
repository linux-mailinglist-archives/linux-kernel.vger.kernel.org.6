Return-Path: <linux-kernel+bounces-421381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40619D8B06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18F0B2C085
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAF1B4F3A;
	Mon, 25 Nov 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF/7413d"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C32500CB;
	Mon, 25 Nov 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552894; cv=none; b=OM3/U9ZUvlvRzCNe/sZPHJqotzoo6xfd12Xf5a6Y++b0gzoQbANczoWkLeBAMfM3Hc8ofBf/q6030HRu0EAL9lRQAp+xUDWjQYJCA0468bl5nBWpTv2xhC4ftnWvqbMKuF/jw9zRFMuYy/LgD2Ii+hotMJsZCqLjfZhAR81nmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552894; c=relaxed/simple;
	bh=jF/ERztw44bK32OJljuv2VfQwBEi6pkAMaxilDGplUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXZUPkUinwuHtk7+ADq0+tzDor6eCOX3zxngwxQoMHMkJxd2OLutXZq98oW0KLzRz3b4Yyxi815fgk+3HMMSe4jLcIGEmn8UGddT9ZcralgNy9JK0XgdiTYLFe+14Gv9F3tCZ8M3C3B+A/ou5NO5UQhM6zg7a5y430Puyk8bDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF/7413d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-212874cd62cso31892735ad.3;
        Mon, 25 Nov 2024 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732552892; x=1733157692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nBrNYtNQzEwXYNxHWnsi/6PaMJ3GpRjnVgxUp7Rk5OU=;
        b=XF/7413d45l0iT06Zf1zmt1/eCwb60xR3G1Oy6LoaU+dNvvNeSmaJoGR1O1VS+vW8y
         ZHTvwmgu+QUzLHOzYJHSim4e3sMeKB5Dy1FCOylWw77AQ1fhrkWd8Np9zvdDlTBzmI5y
         FZ7beru+aS7IAQIXWSJfLU7dS0HPL11OZZVT7MG76TUYRGG/KzCRE7YClSQEpzjJEwEl
         Xb/uJEDb4GP97oY4NF/ecmHCZ4wc3TwenTTJzGk1sAu6iDfgdDn2aXkqATK3BVTD/H16
         4I0yp3FbFpox/GU93uu/MCVQO/8tSFNXqfXie6Dyh1l3XMIeNeY9//Z+zct4UGxryQT5
         0mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732552892; x=1733157692;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBrNYtNQzEwXYNxHWnsi/6PaMJ3GpRjnVgxUp7Rk5OU=;
        b=KJi9r73AqbZpPPuNjxa1VD/qgTAH91E5WThFzF2CJAIzV46k5eI1rz6+cyPQ72dA2O
         bgdUqmtppmN1P7TNLdnoCSVQJgNtrAywqTA0rlZqV7nngvS45hbrs2lXyT4buassaNfy
         +95pxVAq/M0PYgjXvosx6junRmNDxob8v94UOkTWyvRUJWuJkA2d2+TYd0wU+9guWWGB
         qeCtnm/sfi9jtlCBc20pMpgck3xa9PID1CJcnkXm4TDDIFZoi2mbchrmuqr9f16+z25v
         hX2dAeBCq3QC2l9KeltiVNpYnJ0qJHH8drwzYcoONs/oKHyVJKX9lIl8uiwkSfgq7Lwc
         Z03Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX8pLYQ8pOj3YD0nerd//irw17dYBbZZvppoj3bks9A9x5y7ruNr2rrTqFZ00rHGs80MHkfwtnXpP1u4g=@vger.kernel.org, AJvYcCW4NzG2XgLeLUI7WgT4RxB8gpIFxjf62+ziiFyMa08NZoxXosJ4vyecOX+XLrwnl0MWLalNe1GYYeMDs+QN@vger.kernel.org, AJvYcCXrlmxnIgqhHwhxJr08bpRvPyfolOPEImqwyL+CEHCrx/GdtSUgFq9+xcrNaGghewEs320Yo49PnLfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqB+memF+5GfAs/BRF4NiE4J9hNEU5DgAdqsHEm70y98VJ/rHb
	2r3ImOKQEvvAk2Z4S+XDfo1sroSRMr2C7vgXk/Jera04bFuEHEiq
X-Gm-Gg: ASbGncvJkpye2HpQrUlii8kKt50R0aR+Lnvh15AlykgZHWHjgPwSXjTbZu3kCjIbrrW
	RnrYC/8JS1W4oOMxH/Ef65SqWfeNIgtOvAAPzRi3ioX6pPAsPU2QiIKgwvBoQP5RAINVEat/vtF
	35TyM9xzbwfEd2nziSkjldl9dwHd4EMOlVbssLSqLprqEXfHqRbfIgiN0+tPRlk9otbkT5729dL
	fOW+Rif18dWJY8W7vJISP97qAqtZ3MydNJGJ1vcCT9svg7ZphkxCXwiRVQGkvUswbVDChcvmS+l
	y6FbhklLTAW4iWzqJC66SY4=
X-Google-Smtp-Source: AGHT+IGXVga3kfHh5g4xM/HP5awF9elnHHUod4WhaqtWpvHDg+zRrHgvqc8XQnexAHb8fP1B3xmtTQ==
X-Received: by 2002:a17:902:e885:b0:211:152:e1e6 with SMTP id d9443c01a7336-2129f69f23emr210228605ad.48.1732552891881;
        Mon, 25 Nov 2024 08:41:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbff549sm66965225ad.130.2024.11.25.08.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:41:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eda10481-d1f2-45c4-a5ff-0f26398fe6bf@roeck-us.net>
Date: Mon, 25 Nov 2024 08:41:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add properties for thermal
 sensor cells
To: Krzysztof Kozlowski <krzk@kernel.org>, "Sung-Chi, Li"
 <lschyi@chromium.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@weissschuh.net>, Jean Delvare <jdelvare@suse.com>,
 devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241113024000.3327161-1-lschyi@chromium.org>
 <20241113024000.3327161-2-lschyi@chromium.org>
 <4efe981f-f7ae-41c7-9c12-2aa3a5d2d046@roeck-us.net>
 <eb1c249c-5f42-4878-8934-09d6ea5c43f2@kernel.org>
 <893bbd30-300f-4138-8f68-64573e1f0140@roeck-us.net>
 <61541768-1b32-4473-a569-850323a6c7a1@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <61541768-1b32-4473-a569-850323a6c7a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 07:18, Krzysztof Kozlowski wrote:
> On 25/11/2024 16:13, Guenter Roeck wrote:
>> On 11/25/24 00:52, Krzysztof Kozlowski wrote:
>>> On 13/11/2024 04:05, Guenter Roeck wrote:
>>>> On 11/12/24 18:39, Sung-Chi, Li wrote:
>>>>> The cros_ec supports reading thermal values from thermal sensors
>>>>> connect to it. Add the property '#thermal-sensor-cells' bindings, such
>>>>> that thermal framework can recognize cros_ec as a valid thermal device.
>>>>>
>>>>> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>>     Changes in v2:
>>>>>       - Add changes for DTS binding.
>>>>>     Changes in v3:
>>>>>       - Remove unneeded Change-Id tag in commit message.
>>>>> ---
>>>>
>>>> I can't apply this one (not in hwmon space), so
>>>>
>>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> with the assumption that Lee will pick it up.
>>>
>>> This was merged, while I was AFK, so the ship has sailed, but let me
>>> state here objection for any future discussions:
>>>
>>> NAK, this is not a thermal sensor. The commit msg explains what they
>>> want to achieve, but that's not a valid reason to add property from
>>> different class of devices.
>>>
>>> This is some hardware/temperature monitoring device or power supply, not
>>> part of SoC, not integrated into any SoC thermal zone. Calling it
>>
>> I am confused. We have several thermal sensors registering as thermal
>> zone, and fan controllers registering themselves as thermal cooling devices.
>>
>> Are you saying that this is all not permitted because they are not part
>> of a SoC ?
> 
> 
> These are fine, because they monitor or cool down the SoC.  Sensor can
> be under the die.  Fan for battery or for battery charger also would be
> fine, because it is a real cooling device.  It literally cools.
> 

Sorry, I don't get the distinction since you specifically refer to the SoC.
How about drive temperatures ? RAM temperatures ? Temperatures reported
by networking chips ? Power supply temperatures ? We have all those registering
thermal zones. The ASUS EC controller driver registers thermal zones
for its temperature sensors. Dell and HP drivers do the same.

> But treating battery charger as cooling device is not correct, IMHO.

Confused. The patch you object to isn't introducing a cooling device,
it is introducing #thermal-sensor-cells. The EC reports temperature
sensor results, and the driver wants to register those as thermal zones.
Yes, it may well be that one of those temperature sensors is close to
a battery charger, but I am not even sure if that is really the case.

> Battery charger does not cool anything down and already we have there
> properties for managing thermal and current aspects.
> 
Agreed, but unless I am missing something that isn't done here.

> BTW, if power supply bindings miss some thermal aspects, then let's grow
> the common binding first and agree on common aspects.
> 

I don't even know how the two patches are associated with power supplies
or battery chargers in the first place. All they try to do is to enable
adding the temperature sensor values reported by the EC in Chromebooks
to thermal zones. I don't recall any previous limitations on the ability
to register thermal sensors as thermal zone with the thermal subsystem,
and I am trying to understand what those limitations are.

So far my approach was "ok, someone wants to register a thermal sensor as
thermal zone - fine, let's do that. We have close to 50 thermal sensors on
a variety of devices - including but not limited to disk drives, memory,
Ethernet controllers, Ethernet PHYs, SFPs, RTCs, and ECs - registering
as thermal zones from hardware monitoring drivers. I don't recall anyone
ever saying "no, you can't do that".

I am trying to understand if some of those are inappropriate and, if so,
why that is the case.

Thanks,
Guenter


