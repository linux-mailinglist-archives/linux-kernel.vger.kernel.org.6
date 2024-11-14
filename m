Return-Path: <linux-kernel+bounces-409466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FA9C8D09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0008B1F235AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320033D0C5;
	Thu, 14 Nov 2024 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVM0GmkO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFA45C18;
	Thu, 14 Nov 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595209; cv=none; b=QzJYklRSVNMKnzwph/I4kRJplyeUodcH+g40jq1pSXOH+TQRkkIk11NFy8cJNvRU7unblvcu02WxTe/VLgbtrK1thh6jQzP1okSoHvSi9Da7bOZgj0riGMEgNyQtXg5EcFeK6Pkp77u+wupQ1TKC6pDoS1lAZCxNsNkqExiV+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595209; c=relaxed/simple;
	bh=NHjkzyL4pRk1Sm7/sx61gCKUpYAp+AAiTjBhYgaSFMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueMcdfYx7FByyJ9TO6Z2Q8j/bVqio2FXXMNTTSaXfaIVyb0zHTlDUMXzQuSUcRbR0dFpsMxLkZS+b36FalT8WyMHjIlpTENcIYsJK+jjVkwD7k77odFfb21pM5suu5CiC//dUXSiN+8xzt+ic2l4J3UEWm/i4BKJ1W1vyUpao5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVM0GmkO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb47387ceso8471715ad.1;
        Thu, 14 Nov 2024 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731595205; x=1732200005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EEQBOKY/fLey49a3Y4RiOaV4lHERn6mJbyDCb/j5INI=;
        b=OVM0GmkOtDWOVVB4BQ4hYWXeL339vKEzSBRTacfFW6Y+j3x3dmZr5qmklhIfo/sMH4
         +ByymMizsmpzKJD2H6NioSDLixZzpah3RA8RbSb4T2WZHyEa5Ds/hhonmjvsFmpyBW16
         16LcAFTNRfEksPlti/R02kBzUmXGYDZBtWQ/RiOhHDAFYnSeMdGISzyAtTbYZLhHAGR+
         aAF+v1bXaM1d6rtHhJLIAnUrrr91FaaYLH5SmG63SHas84RG3VxbnNoc+ANFT56i0n0C
         jzDslhSUDjRjtLyeK+E2Rd8gEBla4nWxs7wzD9FuX1MH+dQJI484YFAs+VGqXrCz2OwI
         RGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595205; x=1732200005;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEQBOKY/fLey49a3Y4RiOaV4lHERn6mJbyDCb/j5INI=;
        b=ljZMXpbVuHIiUAR3TltTw4G5aXSbixnDUJkzi4NARZCcIUJExqh+9rWokjgRk409qI
         Erq0vLSfkjZIMdEnQe90JnYfsQ2FoiQvgCil+lr1v5OgvzWb6mActzo53O37SNkOUGck
         oBGLioK3bbzqzVy3565PZfAwmVH3QMyuWnYeQyldCms+dyQh5B3rWW0n3B3T0T4V0KCh
         aDLhsIzV4dvgwLjvs3Q4s7MqY/QtM5CKSg7gnFoFDqVnDCSJvaubG4NVWiL95gviDPQO
         jBLPu+Qy/g75AXHczBzlhieuN1snL0EYt3JacZARJ6aYCJ8ATsos0DSjR3wIKCQyC3V1
         YKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK7fLN6d1TNDEEmxk7QGCq9V6Xd5XVIIxZYCkpZ8jQE8RY8uj6P+Kt9IdWrj7Wx3yHz43YwCquCWuNyA==@vger.kernel.org, AJvYcCX6gV6DGDy3S8KdJxGiHKtloOjyNmB080LVOohlkBZKZGtjwfjMnUgGAccQTyZqzXcgFC2JsdUtSIG8FoVq@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFCBM+VgqrAnDJt1OCqaCFDYcZTxUP8oP5/I0/U9m3n0r5228
	4pF8FxEhRF1QZ44z/oXuWgeHv+mN+dTtrdTWhYVq5T1g+exiWQGinW7q1w==
X-Google-Smtp-Source: AGHT+IGRzkoUd3p+Of0wcoaPQUS1eQELyEoVGGv1e6Pd7sy5+qXipDsa5N6TI+PcicK8yLpXV+9R+w==
X-Received: by 2002:a17:902:e801:b0:20c:7181:51cb with SMTP id d9443c01a7336-21183521d55mr293314635ad.18.1731595205225;
        Thu, 14 Nov 2024 06:40:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d1dfa1sm11505795ad.215.2024.11.14.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:40:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a01e398-c8fb-43fd-9b47-7fefb7a692cb@roeck-us.net>
Date: Thu, 14 Nov 2024 06:40:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <041a52c7-ac0b-4a78-8b39-4fc4ac4d2fd2@roeck-us.net>
 <b6ed8499-bf84-486c-be5f-0ef13311eb18@t-8ch.de>
 <3f1914da-4f94-415e-8c46-8731834e51a2@roeck-us.net>
 <c3aaf724-a1d2-438c-851a-dedb0e9a3f34@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c3aaf724-a1d2-438c-851a-dedb0e9a3f34@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/24 23:27, Thomas Weißschuh wrote:
> On 2024-11-13 22:51:37-0800, Guenter Roeck wrote:
>> On 11/13/24 20:40, Thomas Weißschuh wrote:
>>> On 2024-11-12 22:52:36-0800, Guenter Roeck wrote:
>>>> On 11/12/24 20:39, Thomas Weißschuh wrote:
>>>>> Using an #ifdef in a C source files to have different definitions
>>>>> of the same symbol makes the code harder to read and understand.
>>>>> Furthermore it makes it harder to test compilation of the different
>>>>> branches.
>>>>>
>>>>> Replace the ifdeffery with IS_ENABLED() which is just a normal
>>>>> conditional.
>>>>> The resulting binary is still the same as before as the compiler
>>>>> optimizes away all the unused code and definitions.
>>>>>
>>>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>>> ---
>>>>> This confused me a bit while looking at the implementation of
>>>>> HWMON_C_REGISTER_TZ.
>>>>> ---
>>>>>     drivers/hwmon/hwmon.c | 21 ++++++---------------
>>>>>     1 file changed, 6 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>>>> index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
>>>>> --- a/drivers/hwmon/hwmon.c
>>>>> +++ b/drivers/hwmon/hwmon.c
>>>>> @@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
>>>>>     /* Thermal zone handling */
>>>>> -/*
>>>>> - * The complex conditional is necessary to avoid a cyclic dependency
>>>>> - * between hwmon and thermal_sys modules.
>>>>> - */
>>>>> -#ifdef CONFIG_THERMAL_OF
>>>>>     static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>>>>>     {
>>>>>     	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
>>>>> @@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
>>>>>     	void *drvdata = dev_get_drvdata(dev);
>>>>>     	int i;
>>>>> +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>>>>> +		return 0;
>>>>> +
>>>>>     	for (i = 1; info[i]; i++) {
>>>>>     		int j;
>>>>> @@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
>>>>>     	struct hwmon_device *hwdev = to_hwmon_device(dev);
>>>>>     	struct hwmon_thermal_data *tzdata;
>>>>> +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>>>>> +		return;
>>>>> +
>>>>>     	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
>>>>>     		if (tzdata->index == index) {
>>>>>     			thermal_zone_device_update(tzdata->tzd,
>>>>
>>>> There is no dummy function for thermal_zone_device_update().
>>>> I really don't want to trust the compiler/linker to remove that code
>>>> unless someone points me to a document explaining that it is guaranteed
>>>> to not cause any problems.
>>>
>>> I'm fairly sure that a declaration should be enough, and believe
>>> to remember seeing such advise somewhere.
>>> However there is not even a function declaration with !CONFIG_THERMAL.
>>> So I can add an actual stub for it for v2.
>>>
>>> What do you think?
>>>
>> You mean an extern declaration without the actual function ?
> 
> Stub as in empty inline function:
> 
> static inline void thermal_zone_device_update(struct thermal_zone_device *,
>                                               enum thermal_notify_event)
> { }
> 

Sure, that would work, but it would have to be declared in the thermal subsystem.

>> I'd really want to see that documented. It would seem rather unusual.
> 
>>From Documentation/process/coding-style.rst
> 
> 	21) Conditional Compilation
> 	---------------------------
> 
> 	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> 	files; doing so makes code harder to read and logic harder to follow.  Instead,
> 	use such conditionals in a header file defining functions for use in those .c
> 	files, providing no-op stub versions in the #else case, and then call those
> 	functions unconditionally from .c files.  The compiler will avoid generating
> 	any code for the stub calls, producing identical results, but the logic will
> 	remain easy to follow.
> 
> 	[..]
> 
> 	Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> 	symbol into a C boolean expression, and use it in a normal C conditional:
> 
> 	.. code-block:: c
> 
> 		if (IS_ENABLED(CONFIG_SOMETHING)) {
> 			...
> 		}
> 
> 	The compiler will constant-fold the conditional away, and include or exclude
> 	the block of code just as with an #ifdef, so this will not add any runtime
> 	overhead.
> 
> 	[..]
> 
> While this primarily talks about stubs, the fact that
> "the compiler will constant-fold the conditional away" can be understood
> that the linker will never see those function calls and therefore the
> functions don't have to be present during linking.

Yes, I am aware of that. However, that is not a formal language definition.
Yes, in normal builds with a modern compiler it will be optimized away.
However, I don't think that will happen if the kernel is built with -O0.

> So a declaration would be enough. But an actual stub doesn't hurt either.
> 

I disagree. You did not point to a formal language definition saying that dead code
shall be optimized away and that functions called by such dead code don't have
to actually exist.

Do we really have to argue about this ? Please provide examples from elsewhere
in the kernel which implement what you have suggested (not just the use of
IS_ENABLED(), but the call to functions without stub which don't exist
if the code is not enabled), and we can go from there.

Thanks,
Guenter


