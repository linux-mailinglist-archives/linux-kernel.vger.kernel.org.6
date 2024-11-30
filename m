Return-Path: <linux-kernel+bounces-426321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62609DF1B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D3F281012
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA71A073A;
	Sat, 30 Nov 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbLWw5f7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F10146A68;
	Sat, 30 Nov 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980566; cv=none; b=cbOA6NdaaLKh1Hm6c68Sz38k/tYzyUZD8ZQhkudbdWI/9R5gJ26uYJpqQ1DXdAZLSgcjVufJJwGIAIuAlNJ8Dxxx4IE7xGwLKxPP0pE3X3hp8I8WU/3o30KB7ltSlDK/j+Vmqti2xoAA0gTuZleJx4ELj6E5OZcH9oq7CjBL6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980566; c=relaxed/simple;
	bh=nBpdmeqQ1aDgCywTUlFEwV1arUKE3aW/Y5sFimXK0wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2ZiWrKhqGU5IxjMtsHEzvoqFZJfRHPn0Pmj9wCeInyKQI7FebPBX2jFx1QgEgVk3JF7TOyySd/3cLnIVjaVc3+mvlucZB3wygWJtCeSLvjhE2R6zdjxjWFTxOkU2+4FK3wPCHLLFLxnMlxVom5gikpQFkTZqMC8gJz3gI73RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbLWw5f7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720c286bcd6so2307159b3a.3;
        Sat, 30 Nov 2024 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732980564; x=1733585364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/1aGUz/icPzYAAjH2gYaLQH8T/F8G+YovWHSrtFJgoY=;
        b=fbLWw5f77I+er1zIK1lBTjPPDm7qqVq+TqTPXUppOfU1pl6G6oLWZ4a2YcBSjan2I5
         HjWn6Cl8l+ISAENiqOaD0DXX1olDPcEW2fx/rsgxTWft4Ov1HYrQvPHV82e82WUL1usv
         QX4kGEopvEOejfOyj7Q6Sgqjr4E5bVp6Z6e9fpHLj5NKEsOj9OTNmaa5qrjrMSPasbqN
         wpW5Qt9nFTApRJzvI4KEMSmX2wvlIgrI+hZAWImVslUwVv7cMwpbV5JNi6fqoDh6YTg7
         MTnFZ+Q/ePrQwBudvXnYDYjCdpfSkarM6VHz4/rPGfjSqZplPlwS630snobNoX6eAFKY
         +WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732980564; x=1733585364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1aGUz/icPzYAAjH2gYaLQH8T/F8G+YovWHSrtFJgoY=;
        b=DwRQmS/GLqA6TNh+XMpc1Di5Z4CG8dfnnUpaYvGECizeIz6fUb0y1QtuOBUJdOOn6E
         JTkV/O6tH5RauRvFT/nEpq8EQgk4TmqkviqOrns46icvXpXPZlIBXpuRkZR2NKdMID6w
         MJFK1CUt3DW6YIGXwAx6I9qRuVAHNIJxH/lphQH4Ila0LGDjlBr7c+rBMLiEYXg9gSZV
         XQm9Jg1LUz5O3h5hSpcfNa1Wh0Nm+HJidOZhsU0Lb10ozhxV1sLDyUhte9m26ffiKcT5
         HCPqOKYoBVLXM1rIRCjJd4dWVxZp6qjtN3Kp6Ewn/xjXg5wg7tsRo2aI7F2JFfN3M01I
         R6gg==
X-Forwarded-Encrypted: i=1; AJvYcCURcCsLy9eem0cYxGlXXL+6/5BMmd9KOK8qC3P1wXXv6XdfaUWa4VeSQFlP3eNnuWtddmKUYAi9cqo=@vger.kernel.org, AJvYcCX768Rm5z8YWoFJBciyjKkdejOwjSxvlMOPI6g23GCM3jdlkFTJwnA6ddOgVuRhy0xcXn46yCd4xQGmEbVp@vger.kernel.org, AJvYcCXdOJlUgcznafQHPn+rj8dQR7vbP7gksLuyCW3YB6afniLMiHBnIFdC8e6jRzkOkv+TD9k2KVINK/0GyzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOejvPqwUbf63k4XaC6hFF2XVP32tElOYm5hrBsPg3w8RQVq2
	odo9AJu1ZUqDok2NuAuniDEEgCvPDiWG+EEeRG4KmLsbfDy9nQ8azmq+Bw==
X-Gm-Gg: ASbGnctdCrI5Gty2sDRjCVpn5ah0wdmFbOCcEAK4NX2jXncENGWbQFMmXMQwGzvmQZO
	VV054a7ECKrh5HqG3Lb7++BUMyvadj+6B7TBOHunVZbjwEhxKInkmB++bi9kFaNxEz1WuyKdiNC
	eRpo/o4oK2cNzYYq+1k9FhXc81NWXBzy6WhKFdMenf010oiNBsRJfoU3Bh3cOo7JMY2jR4GaZM0
	aclvWLqjySEh/2//kNZv+MCWwOL8TBDCUa6xpxMKVLfeB1jEw0oOHDwx2J91arKib96oaVkFX0k
	itzRmRVtTXiCcXk6WMCs4i8=
X-Google-Smtp-Source: AGHT+IESAnIsKZ1ekp3hBFEffXRNLZDVfi2J/7qu72MN+WAWDZL5FwTrGkP1u6bVVsDWFnioUCOb7g==
X-Received: by 2002:a05:6a00:806:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-72530149e64mr22697731b3a.22.1732980563873;
        Sat, 30 Nov 2024 07:29:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254177d4e4sm5297432b3a.86.2024.11.30.07.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 07:29:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
Date: Sat, 30 Nov 2024 07:29:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Li XingYang <yanhuoguifan@gmail.com>, eugene.shalygin@gmail.com
Cc: corbet@lwn.net, jdelvare@suse.com, linux-doc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241130144733.51627-1-yanhuoguifan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/24 06:47, Li XingYang wrote:
> add asus-ec-sensors on the mainboard TUF GAMING X670E PLUS

as/add/Add/

Same for subject.

> support these sensors:
> SENSOR_TEMP_CPU, SENSOR_TEMP_CPU_PACKAGE, SENSOR_TEMP_MB
> SENSOR_TEMP_VRM, SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT
> and SENSOR_FAN_CPU_OPT
> 

The individual sensors supported by this board are irrelevant for the
patch description.

> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>

Please do not send new revisions of a patch as response of an older
series, and please always provide a change log.

> ---
>   Documentation/hwmon/asus_ec_sensors.rst |  1 +
>   drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index ca38922f4ec5..d049a62719b0 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -17,6 +17,7 @@ Supported boards:
>    * ROG CROSSHAIR VIII IMPACT
>    * ROG CROSSHAIR X670E HERO
>    * ROG CROSSHAIR X670E GENE
> + * TUF GAMING X670E PLUS
>    * ROG MAXIMUS XI HERO
>    * ROG MAXIMUS XI HERO (WI-FI)
>    * ROG STRIX B550-E GAMING

I don't understand how this is "sorted". What is the sorting criteria ?


> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 9555366aeaf0..f02e4f5cc6db 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
>   		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
>   	[ec_sensor_temp_water_out] =
>   		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +	[ec_sensor_fan_cpu_opt] =
> +		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),

This is an unrelated change. It affects other boards of the same family.
It needs to be a separate patch, it needs to be explained, and it needs to
get some confirmation that it works on the other boards of the same series.

Thanks,
Guenter

>   };
>   
>   static const struct ec_sensor_info sensors_family_intel_300[] = {
> @@ -362,6 +364,15 @@ static const struct ec_board_info board_info_crosshair_x670e_gene = {
>   	.family = family_amd_600_series,
>   };
>   
> +static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
> +	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
> +		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
> +		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
> +		SENSOR_FAN_CPU_OPT,
> +	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
> +	.family = family_amd_600_series,
> +};
> +
>   static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
>   	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>   		SENSOR_TEMP_T_SENSOR |
> @@ -512,6 +523,8 @@ static const struct dmi_system_id dmi_table[] = {
>   					&board_info_crosshair_x670e_hero),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
>   					&board_info_crosshair_x670e_gene),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
> +					&board_info_tuf_gaming_x670e_plus),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
>   					&board_info_maximus_xi_hero),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",


