Return-Path: <linux-kernel+bounces-236465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD891E2AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BC81C215AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6416B752;
	Mon,  1 Jul 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StK21unG"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEF1667F6;
	Mon,  1 Jul 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845045; cv=none; b=dsuCEfCTVQzvsyKw7Zn7ZKO8GgRGimR/H5l5Ker1/24JXsijJDE5zFz5VRjv056tIGa1JI7jyEBRWdlG1SnavwgvJwqnZ0qY/Y/ZhLlxp29cprDNk5BKKVKL7se5P/yfE/6yefJWRsmE1nULW6twF1iOPUktRllIP12zROQqrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845045; c=relaxed/simple;
	bh=QJt/g88ILmRPOr0O3qKjmRXRftaMfWYZlfM+9TgSXoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoLv52W/KpNarExpT4xt6cz9sXu0qLgW6W/KWdkfMFIgRlejMQF0PNwwathp8Roz6lKc7zJkIBQJNyB7Fkn00VfbZipKD4DA7jSwSXwRlNxDEpSGhrEMpbMRvowsB26TF2Xc6Ie+9ZveYCLwBxqh1EDYyXFOqPL4zYm5kpZurvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StK21unG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c70c372755so1950741a91.1;
        Mon, 01 Jul 2024 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719845043; x=1720449843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+f3PquVXHV2z7yTB4AWHe6Rt80pHIkayPW4cjA3/coE=;
        b=StK21unGFGV1J4xm4SXq1BzS1URCEi1trTcsFRnQapZluenMH1iF6WPmi0vVnfOR8W
         iHMcI9GaBpOgNkK064SbfXOTU6TPB7abJljPchBODewvedRazmesRg6A6FPCdoRU26zT
         wlODcV3dA23Sw125M27XtJ4N6+5rc93c/P5s3d2Y2ecKhhDAFl5Z2+Fgp8/kp617qkbb
         Gd3POWRkQNZvvn9MGow82xthYurrY665bcGQ5EO71/D7u17kV8ZxwBQ7WrbuNG8wWO4K
         HYF0I779LvZ79Jh9mpm+EquzUHYCygUsLX+Pq9Mzc7LOjCRm2IZuYuOxmdElPZgjAOvJ
         ghcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845043; x=1720449843;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f3PquVXHV2z7yTB4AWHe6Rt80pHIkayPW4cjA3/coE=;
        b=gDG64PphN7LFmdP6SxGaqCUO1q0sqz06PvBrkswQiE58m1MgHnWBODkjRnu1Q3NSZW
         wVKzhzPyCAFqBifowFTcV0mJ74Fnp4q2peN7v7mIDRdrcljxOjK+lSWbjkf4+fMarNcm
         Iz4lHyBpTFKrIp3/4FVdLDUA+pqvw182d5wu87c6CwB2N8ZrTll4e1SLhGpUa6exdGIV
         uq4MjDX9sgnJlrRpKpa0ODUjWNZ3oD3Jgnr00oV/SBfVy0icNkwbel5bCUvHFhReK+xc
         6AXbcMKtGXJt9P8hYCV40p7cLdGE7fso8i4oma274CUkG/oTvCIHzknI3xiR0WZ/+Ms1
         T8QA==
X-Forwarded-Encrypted: i=1; AJvYcCXW90f/cTVhB2OS+wptg+9Gl0D/1wG5CujwKPu7C/1oma2Fp+dchZC9yvUR35utJxgmNt3QryhfKO0Z4tkzsF7oWXkFfhyYaqo+IX8=
X-Gm-Message-State: AOJu0Yyxp1n7n2SSisGazVnm+bHLVKslj/npO08rLRCfGi282HhyE2qB
	1FrDGrJVyQvVkGqj99uEAvsE80npJ1OTRUdbHpA334fohFbPQoMx
X-Google-Smtp-Source: AGHT+IEZccSHoszorYX2PTckFKY8+DsPOg8OCBDmvtYOo3S/w+QUs6Srbne5zCOmkEQLDm4ztzxFWg==
X-Received: by 2002:a17:90a:e009:b0:2c8:f3a5:4ddd with SMTP id 98e67ed59e1d1-2c93d743777mr2786260a91.19.1719845042926;
        Mon, 01 Jul 2024 07:44:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939ccb232sm2495370a91.0.2024.07.01.07.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:44:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7262a592-f344-48b8-801c-e9f6d365eb77@roeck-us.net>
Date: Mon, 1 Jul 2024 07:44:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hwmon: (amc2821) Use BIT() and GENMASK()
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-8-linux@roeck-us.net>
 <339e3355-d6cb-4327-be49-e2721f1a592d@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <339e3355-d6cb-4327-be49-e2721f1a592d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/1/24 04:31, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>> Use BIT() and GENMASK() for bit and mask definitions
>> to help distinguish bit and mask definitions from other
>> defines and to make the code easier to read.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/amc6821.c | 71 +++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 03ce2e3ffd86..042e2044de7b 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -8,6 +8,7 @@
>>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>>    */
>> +#include <linux/bits.h>
>>   #include <linux/err.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/hwmon-sysfs.h>
>> @@ -68,46 +69,46 @@ enum chips { amc6821 };
>>   #define AMC6821_REG_TACH_SETTINGL    0x1e
>>   #define AMC6821_REG_TACH_SETTINGH    0x1f
>> -#define AMC6821_CONF1_START        0x01
>> -#define AMC6821_CONF1_FAN_INT_EN    0x02
>> -#define AMC6821_CONF1_FANIE        0x04
>> -#define AMC6821_CONF1_PWMINV        0x08
>> -#define AMC6821_CONF1_FAN_FAULT_EN    0x10
>> -#define AMC6821_CONF1_FDRC0        0x20
>> -#define AMC6821_CONF1_FDRC1        0x40
>> -#define AMC6821_CONF1_THERMOVIE        0x80
>> +#define AMC6821_CONF1_START        BIT(0)
>> +#define AMC6821_CONF1_FAN_INT_EN    BIT(1)
>> +#define AMC6821_CONF1_FANIE        BIT(2)
>> +#define AMC6821_CONF1_PWMINV        BIT(3)
>> +#define AMC6821_CONF1_FAN_FAULT_EN    BIT(4)
>> +#define AMC6821_CONF1_FDRC0        BIT(5)
>> +#define AMC6821_CONF1_FDRC1        BIT(7)
> 
> Should be BIT(6) here if I'm not mistaken.
> 

Yes, I had fixed that later but accidentally applied the fix to later patch.

Guenter


