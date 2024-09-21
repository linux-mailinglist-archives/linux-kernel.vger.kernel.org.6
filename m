Return-Path: <linux-kernel+bounces-334896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5602497DE0E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CBE1F21E30
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07BF178364;
	Sat, 21 Sep 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak+w4Rxj"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A9F9E6;
	Sat, 21 Sep 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726938983; cv=none; b=O2ZG3A+a8fg1NrIccgk2UOxMlCTKN0r4YhAQcHBR67XlGg9EMQ9hJwcrMaTk77gtwSrThLVA9MXLiitPXvq2K+f2nLrdyCmJkfeX/enebVMXxndxTFWqoD6W2xWWFeOIGsHP4sH42ZMx57LMTnEfXTKJoU/1DVd2RW3Jc+O10CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726938983; c=relaxed/simple;
	bh=Y5F6rRWS4PLfhF6XLOgP7jjoFrnWv7BQzynsjGpgy9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJv3hhcXPFpQ/vt/RdhmFD1J05JcBo4ruROLjPZqKE0k90CrOFmUltr0LwXfqXDaix9BDfyrLvQcYOkS3GFruT8HIqaD09uDkwaCWZzeUU+EOy11xRWdxw374QeE1pPVI/Qv40x3ukZM8BF2VKdVBMXykpldr310beEa0p0PSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak+w4Rxj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so2131406a91.1;
        Sat, 21 Sep 2024 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726938981; x=1727543781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=C0ri51tdeDwWCEt1qe3ZFNu3stha/MkaOgBdZFlNRIs=;
        b=Ak+w4Rxji9uWHbdzPJdpVPI3uBWI7CaIhgYymKwA32vk58Dgi1yhoNXKULjwuR9IWO
         8awTTdbvmtxl0vYW7eulLkl5QjRX2QNpixPmSPnCGwNGm73NVlt4I788m4VZOnWd+AUC
         6ZMMol0o4yHU43EWYoZBVMG4kv9IfXegRV/7KPIiaAG+AezpXFZkvzN9BGy4K2q4ZBAK
         LmhkkC1yyYNEMjVwjP1bKUZuJbgxZLAEjuGvEMk19XWyqzNl2iDpHV7rZqttJK7Ip2GH
         5hkUbV8gaNvkaXEaoB3PSu8pfK0h9aAaf5mS4p2J0UletRLS7RobRx/ADselr/jr7DvS
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726938981; x=1727543781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0ri51tdeDwWCEt1qe3ZFNu3stha/MkaOgBdZFlNRIs=;
        b=awzVJpOXpgSXi7+qmqe8NWmojp1SxgGyexKyRSW8M0Nm3Rd3F/zbf/s+aHIROemVmK
         nDZP1C4RpIe/KGfW/ftFJ2pIHHPkjqWs4b5ii35l3uTvkLpahgaQKLRFeSO8DAnxVNup
         Pcghj99enILNFViY2ez2050JPG/d59u681nAGG4mS026Z+WWWYvdv2EWk5jneeXovLv4
         Uz+941URPF/weHlR621+WlgJXjSF19aZlMsvx49/iXSZtz94Ddaop/4cEjLHlLL/YbBA
         UV21G9YwKszF1LwUOBGHTCicjHG8Ero8JRmnWktpThyo9LR4dVlFzcHi4LKR2afqF4wt
         +3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUjY3zVpUeRiy95Nz2v6TmaL3cxySLA0G3w+rMtObRBMdskKE5KcMW3dgy8tmFCf5TYOGOWuP2xIVo=@vger.kernel.org, AJvYcCVsFuNatVi1Y8TR9Z/Ia3foyyPbx34vU64jfwG7EHhfWjsac8TKpFVIM+pB9ol9525A8CbkH/v1FpqmGxwG@vger.kernel.org, AJvYcCW3KIEAGPxjH7OI6UsCefJq5XLAF7gFekMOUkn8zOta7sWRxrLiUaMhnrVb3URHACgyAyvQTUBRTJIISCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICgRjoGf/ctLOJD8tUX96ihCxmd8bboRK6gKV+FsNmqQxWZ6A
	qWGUdPEcUdaubyWkhCg8lsTgKTzhxWy0QV+N1B2cwHl3hByXTfI3
X-Google-Smtp-Source: AGHT+IFVJ9J3byhw11fhjbjVkQGZPhsYYoo9ujWuxZAUlDdTeerL/nF9sW2KsWEvu8iWEocc6O7yFg==
X-Received: by 2002:a17:90b:1e4d:b0:2d8:7445:7ab2 with SMTP id 98e67ed59e1d1-2dd7edd8fd3mr8520559a91.20.1726938981090;
        Sat, 21 Sep 2024 10:16:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8197b9sm4228302a91.15.2024.09.21.10.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 10:16:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e85712dd-6655-4dc2-af7d-c74c5072cc8a@roeck-us.net>
Date: Sat, 21 Sep 2024 10:16:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
 <4052294e-7b7f-4238-9b47-92727de4d516@roeck-us.net>
 <1jsettz1hh.fsf@starbuckisacylon.baylibre.com>
 <2f3cec6e-7b05-4510-8c62-244ed114ad17@roeck-us.net>
 <1jo74hymsh.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1jo74hymsh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/24 09:49, Jerome Brunet wrote:
> On Sat 21 Sep 2024 at 08:22, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 9/21/24 04:32, Jerome Brunet wrote:
>>> On Fri 20 Sep 2024 at 14:13, Guenter Roeck <linux@roeck-us.net> wrote:
>> [ ... ]
>>
>>>>>     +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
>>>>> +			    struct regulator_config *config)
>>>>> +{
>>>>> +	struct pmbus_data *data = config->driver_data;
>>>>> +	struct regulation_constraints *constraints = rdev->constraints;
>>>>> +
>>>>> +	if (data->flags & PMBUS_OP_PROTECTED)
>>>>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
>>>>> +
>>>>> +	if (data->flags & PMBUS_VOUT_PROTECTED)
>>>>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
>>>>> +
>>>>
>>>> I am a bit at loss trying to understand why the constraints can't be passed
>>>> with the regulator init_data when registering the regulator. Care to explain ?
>>> Sure it something I found while working the problem out.
>>> Simply put:
>>>    * you should be able to, in theory.
>>>    * currently it would not work
>>>    * when fixed I think it would still be more complex to do so.
>>> ATM, if you pass init_data, it will be ignored on DT platforms in
>>> favor of the internal DT parsing of the regulator framework. The DT
>>> parsing sets REGULATOR_CHANGE_STATUS as long as the always-on prop is
>>> not set ... including for write protected regulator obviously.
>>>
>>
>> If the chip is read-only, I'd argue that the always-on property should
>> be set in devicetree. After all, that is what it is if the chip is
>> in read-only state.
> 
> I'm not touching that. If always-on is set DT, REGULATOR_CHANGE_STATUS
> won't be set. What I'm proposing does not change that.
> 
>> In other words, if always-on is _not_ set in
>> regulator constraints, I'd see that as request to override write-protect
>> in the driver if there is a change request from regulator code.
> 
> That's very much different from what we initially discussed. It can
> certainly be done, what is proposed here already does 90% of the job in
> that direction. However, I'm not sure that is what people intended when
> they did not put anything. A chip that was previously locked, would be
> unlocked following such change. It's an important behaviour change.
> 
>>
>>> This is something that might get fix with this change [1]. Even with that
>>> fixed, passing init_data systematically would be convenient only if you
>>> plan on skipping DT provided constraints (there are lot of those), or
>>> redo the parsing in PMBus.
>>>
>>
>> I disagree. I am perfectly fine with DT overriding constraints provided
>> by the driver. The driver can provide its own constraints, and if dt
>> overrides them, so be it.
> 
> That's not what the regulator framework does. At the moment, it is DT
> and nothing else. After the linked change, it would be DT if no
> init_data is passed - otherwise, the init_data.
> 
> If a something in between, whichever the one you want to give priority
> to, that will have to re-implemented on the caller side.
> This is what I meant by redo the parsing on pmbus side.
> 
>> This is not different to the current code.
>> The driver provides a variety of limits to the regulator core.
>> If dt says "No, I don't believe that the minimum voltage is 1.234V, I
>> insist that it is 0.934V", it is not the driver's fault if setting
>> the voltage to anything below 1.234V fails. I would actually argue
>> that this is intentional, and that the driver should not on its own
>> try to override values provided through devicetree. After all, this
>> is a two-way problem: Devicetree may also limit voltage or current
>> ranges to less than the range reported by the driver.
> 
> It goes way beyond what I'm proposing.
> The only thing done here is something you simply cannot put in DT
> because DT is static. Following init, if the chip write protected,
> REGULATOR_CHANGE_STATUS should not be set, regardless of what is in DT.
> If it is not set, I'm not adding it.
> 
> Also, what I'm proposing does not get in the way of DT, or anything
> else, providing constraints. What I propose allow to make adjustement in
> the HW based on the constraint, if this is what you want to do. It also
> allows to update the constaints based on what the HW actually is.
> If the chip cannot be written, regulator needs to know.
> 
>>
>> Again, if devicetree provides constraints, and those do not include
>> the always-on property, we should see that as request to override any
>> chip write protection in the driver while the command is executed.
> 
> I'm fine adding that. The init callback is also the place to do it.
> As pointed above, this may not be what current user intended. Also,
> implementing that means that, for a chip with multiple pmbus regulators,
> a single always-on missing will unlock the chip. Also pmbus will need to
> adjusted so the hwmon attributes are registered after the regulators, to
> get the permission right.
> 
>> We should not try to override devicetree constraints.
> 
> I don't think I am. I'm just reading the chip state and adjusting the
> constraint. Even after implementing what is suggested above, it will
> still be necessary to readback and adjust the constraint based the
> read protection. Unlock is not guranteed to succeed, the chip may be
> permanently lock. Some provide the option to do that.
> 
>>
>>> Also a callback can be attached to regulator using the pmbus_ops, and
>>> only those. PMBus core just collect regulators provided by the drivers
>>> in pmbus_regulator_register(), there could other type of regulators in
>>> the provided table (something the tps25990 could use). It is difficult
>>> to set/modify the init_data (or the ops) in pmbus_regulator_register()
>>> because of that.
>>>
>>
>> The solution would be to copy the init data before manipulating it.
>> I don't see why that would be a problem. After all, the data is not needed
>> after the call to regulator_register() since the regulator code keeps
>> its own copy.
> 
> The type regulator being registered is not known at this point, unless
> you to use something as weak as comparing the ops pointer to
> pmbus_ops. Without that, I don't really seee how you safely manipulate
> the constraints. If it is not the generic pmbus regulator, the
> constraints should not be touched by pmbus_core.
> 
>>
>>> Using a callback allows to changes almost nothing to what is currently
>>> done, so it is safe and address the problem regardless of the
>>> platform type. I think the solution is fairly simple for both regulator
>>> and pmbus. It could be viewed as just as extending an existing
>>> callback. I chose to replace it make things more clear.
>>>
>>
>> At the same time I see it as unnecessary and possibly even harmful.
>> Maybe we have a different understanding of complexity, but I don't
>> think that copying the init data and attaching constraints to it in
>> the PMBus core would be more complex than introducing a new regulator
>> callback and implementing it.
> 
> There is an infinity of ways to merge the constraints between what
> regulator_register() gets and what the framework will parse DT. It is
> impossible to get right on the regulator side. Regulator is just picking
> one and that's it (always DT at the moment). That's the only sane thing
> the regulator framework can do IMO.
> 
> If you want a merge between runtime based constraints, such as write
> protect, and possibly DT - all that ready before regulator registration
> in init_data, then yes, a lot of the DT parsing will have to redone in
> PMBus before regulator_register is called. It is also something that
> will have to be done only for regulator using the pmbus_ops(). I don't
> really see how to make that happen in pmbus_regulator_register() without
> some sort of callback.
> 

Looks like we'll have to agree to disagree. Let's see what the regulator
maintainer has to say about your callback.

Guenter


