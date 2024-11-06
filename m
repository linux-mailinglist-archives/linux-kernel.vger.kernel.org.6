Return-Path: <linux-kernel+bounces-398441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E479BF155
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520731F220FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01915202620;
	Wed,  6 Nov 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etvhxVQ8"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45301DFE3A;
	Wed,  6 Nov 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906072; cv=none; b=Nv381oZT6mZWZsVrBamdWgqRvMW2B5ld42l422ve5u2O8q/wOda9AdHwuMPPnDBc+iCndUqqcJXu58m6rbk2gafNTys+IwnObCEyhYqbLzvlwdIcnNUCXX2FYxMPYA7QuNkSb7DQd+dqJwUAghSJ7MljOV2e1SmSUDv6r1wVkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906072; c=relaxed/simple;
	bh=NGv1B/mwAPk/2HweJzLRbIjY9w392qR0gTy2WlxKAi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx3GJAUV7OtM/bRcclabW70JB4c4ZMjHspxWZi5Jm7/7+NOHqDIOMvcXNOtd/eUUxwJOVXVP5GuknCv1QzUlXz3adRigudQ7bPyC1dEyrGChKqgxY8n6S6pE2cPWaic4nqwEtFBz56F0uzLD6sd/S9DBQoe3qcPk9P3lI0AUFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etvhxVQ8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so5747918b3a.1;
        Wed, 06 Nov 2024 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906070; x=1731510870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wSli+iwhfT8yqinIJcJu31DmCob3x09oUZ+wA4AxBqE=;
        b=etvhxVQ8zdCR5NOV3Pz0oCSdHB1H5yrju5kjHV7qNw8R6M4MAVq5pUNF0n0kT/1kRV
         iQJskb8vcQk3XZ98/1y4A6ttfsEoa5192WFH8PaIV/Ls0ijIrTC7FA4Q2a94/QeS+qt+
         v5drVnZzT/wy6f4/Ep42LDlQgx2fZpek5gzGDA62t/2attN3wXb+To5Yk3/OnCpN0KY7
         +UPqW4bW7ntSrZk/dOv+hAKHZfZCoRwVHVMTTTJ55unDgF4T1xpIyI5XZj4oewGoqumL
         2cXuaikFE2k65kZNxoHaxTC24b7/srBX6oj9eE3HEt8gQyD3D3MXxRlW7EdwWlUm6ei5
         3ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906070; x=1731510870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSli+iwhfT8yqinIJcJu31DmCob3x09oUZ+wA4AxBqE=;
        b=tZVBATyGsjoqMO/upu/FXiZ9vHXbnji0iNRC/w24R3zHXaYhwqVuDtngfEY+7SRWx8
         TaUB9gLG9PYV/85vuATOQYaPfZsO/vB9FHpLoYKPr7GT3IGKuYND7vVTR6whQZSu5o5I
         XDPcvtCPgxcY9zzczUfwBdTJfvUl3FXO6m9mV4XK9akvexn9zRpKNIynh+2AuyGw2W1P
         jiwFfKZigcIXOIIeOxht+/JV+1/4svji8PGSqe+yK2j6k/Sv9iyp5u904LaTYsJXbKNr
         wnxgsL1wyr3mIfNdIXGC1rlBmQ6bke99yfjM9NqQ3BdQN8HFd30dW9zYtM882qjSbBId
         EQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmEbvymMOmafwHjUtAHoQwyztys6VXF/b7+P1j5QG0ZOXS5WopPhSANO27V158Lf3v4zgGYqt85MykHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSK8KbLOTcw/5Giw3pZrSOziOHvoITFZtHY/AwmDOHP24tOpDo
	KgV3H4WG17PCz1xm5rghZY5S0idB7Bgh3Svl74+8zz+1BYLtY/Xr
X-Google-Smtp-Source: AGHT+IHyA/ssgSuVHN+miXdkYd8JDEo4w8pbCIZayAiuCI285juFyh+jzVI37OW+uIPgPuTk/FuQEg==
X-Received: by 2002:a05:6a00:218a:b0:71d:f15e:d026 with SMTP id d2e1a72fcca58-720c988341dmr28774160b3a.3.1730906064273;
        Wed, 06 Nov 2024 07:14:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8ccfsm12015729b3a.23.2024.11.06.07.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:14:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <761490f4-b0b2-442b-b1b6-ced74e9b6300@roeck-us.net>
Date: Wed, 6 Nov 2024 07:14:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Thomas Richard <thomas.richard@bootlin.com>,
 Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
 <20241104-congatec-board-controller-hwmon-v1-1-871e4cd59d8e@bootlin.com>
 <d699cddc-a8ae-4094-b1b5-7af8cd7e91cd@roeck-us.net>
 <b85a7486-578f-42c9-9ec2-b5befa75d893@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b85a7486-578f-42c9-9ec2-b5befa75d893@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/24 05:46, Thomas Richard wrote:

>>> +
>>> +static struct cgbc_hwmon_sensor *cgbc_hwmon_find_sensor(struct
>>> cgbc_hwmon_data *hwmon,
>>> +                            enum hwmon_sensor_types type, int channel)
>>> +{
>>> +    struct cgbc_hwmon_sensor *sensor = NULL;
>>> +    int i, cnt = 0;
>>> +
>>> +    for (i = 0; i < hwmon->nb_sensors; i++) {
>>> +        if (hwmon->sensors[i].type == type && cnt++ == channel) {
>>
>> Isn't that a bit fragile ? It assumes that the nth reported sensor of a
>> given type
>> reflects a specific named sensor. If that is indeed the case, why bother
>> with
>> all the code in cgbc_hwmon_probe_sensors() ? The index to sensor
>> association
>> should be well defined, and the sensor type plus the channel index
>> should always
>> be a constant.
> 
> I'm not sure to get your comment.
> 
> I cannot assume that the sensor list returned by the Board Controller
> will be the same for all boards.
> I know the MFD driver only supports one board, but I think it's better
> if we can have a generic hwmon driver.
> 
> If I add some debug in cgbc_hwmon_probe_sensors() I can dump the sensor
> list returned by the Board Controller:
> 
> cgbc_hwmon_probe_sensors: index=0 type=1 id=5 label=Chipset Temperature
> cgbc_hwmon_probe_sensors: index=1 type=7 id=0 label=CPU Fan
> cgbc_hwmon_probe_sensors: index=4 type=1 id=3 label=Board Temperature
> cgbc_hwmon_probe_sensors: index=5 type=2 id=1 label=DC Runtime Voltage
> 
> It is the type and the id which give the name of the sensor.
> 
> I don't see how to do it in a different way if I cannot assume that the
> list above is not the same for all boards.
> If I assume that the list returned by the Board Controller is always the
> same for a board (which I not even sure, if for example a fan is
> plugged), I could have a static list for each different boards. But the
> driver will not be generic.
> 
> If I miss something, please let me know.
> 

My thought was to use the sensor ID as channel index. In general it
would be preferable to know that, say, in0 is always the CPU voltage
and that temp1 is always the CPU Temperature.

Guenter


