Return-Path: <linux-kernel+bounces-431317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADB9E3BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11586281986
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53A1F7084;
	Wed,  4 Dec 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TttPIafL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF626AC1;
	Wed,  4 Dec 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320831; cv=none; b=b8YoOIcRcrYhGzVWVndCDV0S8xkRP9MzFGeyUGmvmQ469Tt9TuF9xGCCeUSX4WbMf5X9lyGufE0SlT7WW/pmr+Oa0U+vu0iNm8AHz3EOyxOAi2aUJeWQkDJa3pk3+oTPdk9vVHHCPydkmL7MeYri/vYFTnhkrj2t0+/A4p8mqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320831; c=relaxed/simple;
	bh=gsTPiMJDr8QYPyf+EUb9OtnxTMogcvtTKWtDJ/rpilk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLmBfsVCDYUmyh/g2bxvXNDxVEfL6VvMe2MvTX6DuZfD/IO2xLex1VOYg9333kuHNFmlk85Xr9WTXyF2kLbDK5u6VEpKmGWo93oSaUID7/sHNbhL4m3aXLhDPgU0WXoHg4uzY6kmDSbzEtKdTDEl5/g0jV1Budf8P4PmLEkLlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TttPIafL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e59746062fso5303096a91.2;
        Wed, 04 Dec 2024 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320828; x=1733925628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=72E/LdpU1yieOJ60RZCltNG5F7eN2ulj4TfpqtHdsuY=;
        b=TttPIafLeoxiGYlIS1wCBCm4Eswro/TtAzSfu+F+mpLyJHEUslJwiS8jj/p5z/I5QU
         INyAasoxHSeC9ENPu4FwLQ9oT9kHSFc5za6Pw5RgZ0tdQY5s0qHABIz1QHp1/jXL4ZCm
         qlHSFWn3CTIUSUT3zHjd9nFGmuoS7KIsWtIx7jOpHiqKHQOxIIFM5PUhQhrJlsj/22ua
         otVq6lNJKGEPRUMP94ePMltGlmlRTI3tXmM7qVeIOx65ndDeDvV4AiKl4qDYKTSPXqBC
         LX8GlVBaFQCvQVN+mEDKX0/A023alEO1dRoXL+VSpx9V/FzR2lfjwZLYHXf2sJODrR95
         OllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320828; x=1733925628;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72E/LdpU1yieOJ60RZCltNG5F7eN2ulj4TfpqtHdsuY=;
        b=vTS1uGBAuu28igHgfL6YXbdI8FjUtINGFpAynjt1UelZEGGiYXdK+GWt9ReCnc4+lM
         yvfpQ/IL/He62HrYto0Jiuf7TK8tDc5MEvHyybj4eInfDsbfHNLJQ4nXp2TjsnQW9KZc
         yycOm8ShnAa01q0FIx8jleAuArlW720dDERpP199bmAynFVEa/3dK4AAP9kTjD9KwGbt
         A7XebcWfCj3UKoMM6ml3fBw9Dn3uKXyqaO4pZkhdyIgRrnDCK1U2e7ImI04BlY1nCe6t
         oQ+++2LlpS024Xsx4zuXNYE4WWYQ3s3oNJ6udFU13GuKY0LZ7D0++LOv3sGuti9m9JEp
         s9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZR37vM3ymOopPWthgk/D0qsL66t2wBOl+ITWPZMgMf0qpEqHJEU4JOqzdxFiLYVZxkQT4s800oLzldvS@vger.kernel.org, AJvYcCURsTEbI5RCmEfISurlIfMTZS4dxb6nHOypX9L9etuepPESR6ww7+Go0scSKBwo0wBB49p1nRKXYfE=@vger.kernel.org, AJvYcCWmrbFDhrO+6c1EYRHBVyL8pkUqcEnQIQsvIP6VLPq6SucJhNPpUMVyWBozPCz3r0COFQZ4n4KOq+zJi64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0N+3F9gYVZACOO4Xp3i5iOQ7ZZRHFn1uzJyxjYgk/Kc9jnY3U
	WBZt/k68RtupI3sdvPDDuPuGH0Qt1c4E949EJz3W1XVoGpu0hPhD
X-Gm-Gg: ASbGncvfx2LbTDq1dSuUZguSfZUwheF4wJVtnXPIyITUFLkDp3jWB2S11nFiJTW2XMl
	LCeUqDe0EpgO2OLn6I6TVRAd0bcI0geXqxH6qjCUwJ1SQTUvk4uv0fIYluRyvA/nLSH9MBV8YQV
	WJpjcD/t+By6jnlxoA7T8T/vbYHwVb2SxOSu7KZx1r2DxhXzPxviFUtqaozLkZjZADAmOvYvbdu
	lWiJRvZpHV6IVUGCuLeVeH2joa4KnVKQa8NlBGgF+CtHZSy9ztndMZJMR/zKBrIu2DT48TQxPEj
	FisDIQXfcKB3O7zkqeh2Ypg=
X-Google-Smtp-Source: AGHT+IGjGZKj2oQHqpUt+k/xZdh0zHdoNYxMZCcEbaEEhZ3tRBt+4ptVnQJJDG5aqZXKJusB+Ev5ew==
X-Received: by 2002:a17:90b:2808:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2ef011e366dmr9374713a91.2.1733320828230;
        Wed, 04 Dec 2024 06:00:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm1548239a91.18.2024.12.04.06.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:00:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76911794-fe8d-411b-bfeb-caa46bc929a6@roeck-us.net>
Date: Wed, 4 Dec 2024 06:00:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Eugene Shalygin <eugene.shalygin@gmail.com>,
 Li XingYang <yanhuoguifan@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
 <20241201034803.584482-3-yanhuoguifan@gmail.com>
 <CAB95QAQ5CS3Xg2xfPgvOP1LjaXxKtUrjCuo4gv2x=h=-40cBwA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAB95QAQ5CS3Xg2xfPgvOP1LjaXxKtUrjCuo4gv2x=h=-40cBwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 03:31, Eugene Shalygin wrote:
> Hi,
> 
> Sorry for the late reply. This patch is OK with me.
> 

A Reviewed-by: tag would have been helpful.

Guenter

> Best regards,
> Eugene
> 
> On Sun, 1 Dec 2024 at 04:48, Li XingYang <yanhuoguifan@gmail.com> wrote:
>>
>> add asus-ec-sensors support on the mainboard TUF GAMING X670E PLUS
>>
>> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
>> ---
>>   Documentation/hwmon/asus_ec_sensors.rst |  1 +
>>   drivers/hwmon/asus-ec-sensors.c         | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
>> index ca38922f4ec5..739636cf7994 100644
>> --- a/Documentation/hwmon/asus_ec_sensors.rst
>> +++ b/Documentation/hwmon/asus_ec_sensors.rst
>> @@ -29,6 +29,7 @@ Supported boards:
>>    * ROG STRIX Z690-A GAMING WIFI D4
>>    * ROG ZENITH II EXTREME
>>    * ROG ZENITH II EXTREME ALPHA
>> + * TUF GAMING X670E PLUS
>>
>>   Authors:
>>       - Eugene Shalygin <eugene.shalygin@gmail.com>
>> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
>> index 381bf117104f..43e54dc513da 100644
>> --- a/drivers/hwmon/asus-ec-sensors.c
>> +++ b/drivers/hwmon/asus-ec-sensors.c
>> @@ -479,6 +479,15 @@ static const struct ec_board_info board_info_zenith_ii_extreme = {
>>          .family = family_amd_500_series,
>>   };
>>
>> +static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
>> +       .sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
>> +               SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
>> +               SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
>> +               SENSOR_FAN_CPU_OPT,
>> +       .mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
>> +       .family = family_amd_600_series,
>> +};
>> +
>>   #define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
>>          {                                                                      \
>>                  .matches = {                                                   \
>> @@ -540,6 +549,8 @@ static const struct dmi_system_id dmi_table[] = {
>>                                          &board_info_zenith_ii_extreme),
>>          DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
>>                                          &board_info_zenith_ii_extreme),
>> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
>> +                                       &board_info_tuf_gaming_x670e_plus),
>>          {},
>>   };
>>
>> --
>> 2.47.1
>>
> 


