Return-Path: <linux-kernel+bounces-240202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91833926A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36A2B21E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DAD191F91;
	Wed,  3 Jul 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP1O+RU/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E6181CEC;
	Wed,  3 Jul 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042147; cv=none; b=eDRqRYSN3lo7ycTMyBMrU7y1xzX9WOeDTe4AIIMPRLs4AFEtdphVaoKizMMzw9QGSDmVJOor9ix3W3IQQFuyo+apFVsTNHU/NlppCNUoT0/d53Np79PLVFgrbnlFTIVQ8HeKKIBmx69DAv0ATn6H6KDUrjCpZzninddbQdzTIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042147; c=relaxed/simple;
	bh=tR09rMdaXRzSOZJlbbwDCYT3+wz1Ju26+n0RaMRBw0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLPvk6hLjSVUxj+BMuBVe2BsSoFN7puWbKCdsfD8X6zwCZzDTk87P4VvhFSFPc6+bCJmk8WlA0ttdPxlJYZ3HkekxtbFj0qRdRDT/6iXWQ+s/hFhC4+BxHb90CMdP8s4EvNSx9o6B5IrHDHyQNDW+NBPIR2JUIV+TgWsee0Wb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP1O+RU/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a5344ec7so98145ad.1;
        Wed, 03 Jul 2024 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042145; x=1720646945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MQHG/jePXaqUQxyIwx4IFdiaoRRMKbDkq0isirmyfIc=;
        b=lP1O+RU/pD5+9BvtEJTVlO/VUOKLXdhlBndAtFtLG5NZGSnMXN/uC4HZnFp7fiRuL6
         ln1MONaETB7mIQCHatlcYSz6PrSWMRNowT5CsldSOuV0P5ZBJdBD+nCX6bar1Dtprksn
         rgrwhFo7cKjHo8Tj+t0buISxWwcahWqTXLjWWggDTj+bHO10etrI+sg00+L9WxkoPL+x
         2zMXkZ0O0MCQZnPmvvtHe3zVH+EXQ/KK6DOSq8GDxCzHJU9FEsALSS6g1UpGsJ9udR9t
         TxYH6xEew7pJmuccOi6QHXPLyaoKl2rnEfqiok47uXWTWGyKgi0puYxT5D39c6f83FR7
         FnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042145; x=1720646945;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQHG/jePXaqUQxyIwx4IFdiaoRRMKbDkq0isirmyfIc=;
        b=tXnp5ydGX6FNPWWh5PR1ZMm5QzboF4zkrZGUwzR+Lj3vI8RK3HfSqn6hCx9K5OWAqN
         PEEP3EsY+paKPZPPMoqR//eUQrmrVLgwP76LEgRgcpV/wruFf0Et2t7u9JMhCn0CzJbE
         WHrXOX4e4fqGzXgyN5wubFN1WsVgQXXOOwG2YnjCDi5qoK+I/6nK3QUHq5clveFeL8xn
         e+hAlUGormndSxuDDV+FNHXmIyzzef9Z61WfRukW5UiTRtmYMIxOsiNoS4qxnbe20Yw0
         jteXxQGObvle2k6siGOljk2/5icuJxxV5CtGkXcrRFjxTzahR8Kf2OcaqJZi/PEvD8Mv
         MXzg==
X-Forwarded-Encrypted: i=1; AJvYcCXxS0gqrtwg2ziBMZXEf6HVfDCXS+twHf3+tcWiUMgNCdpizpS9hzr4dh9fZ7ZKFK6nNT/XbJ5RPOMOYuBz2fGZnrOji63wZKpZCMo=
X-Gm-Message-State: AOJu0Yzw8tH1YCOC0mVhsu2Cu6BGaxZqXcSx/gAd69OhwNPx+tIUm+Oq
	0FjbB1oJsUbtbnZJDBxqJZwa50Ed0NLmtjVug8D9MeYUK3u7FU2stEtCnQ==
X-Google-Smtp-Source: AGHT+IFExeFjZxBVywRNDCGExJCTAn96L/t6bgM405RZKaBaFgE0upQ/cynVux5Rczsbsz0/YQVKrg==
X-Received: by 2002:a17:902:dad1:b0:1f9:f6c5:b483 with SMTP id d9443c01a7336-1fb1a0d1fedmr43299825ad.27.1720042144893;
        Wed, 03 Jul 2024 14:29:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a3d25f1sm18274265ad.139.2024.07.03.14.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:29:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <38a76df3-61f1-4e40-b318-d2afe3a39445@roeck-us.net>
Date: Wed, 3 Jul 2024 14:29:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] hwmon: (amc6821) Add support for pwm1_mode
 attribute
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-12-linux@roeck-us.net>
 <135535d2-f400-4ca8-8362-526b47ae8362@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <135535d2-f400-4ca8-8362-526b47ae8362@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/24 08:28, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>> AMC6821 supports configuring if a fan is DC or PWM controlled.
>> Add support for the pwm1_mode attribute to make it runtime configurable.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: New patch
>>
>>   Documentation/hwmon/amc6821.rst |  1 +
>>   drivers/hwmon/amc6821.c         | 16 +++++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/hwmon/amc6821.rst b/Documentation/hwmon/amc6821.rst
>> index 96e604c5ea8e..dbd544cd1160 100644
>> --- a/Documentation/hwmon/amc6821.rst
>> +++ b/Documentation/hwmon/amc6821.rst
>> @@ -58,6 +58,7 @@ pwm1_enable        rw    regulator mode, 1=open loop, 2=fan controlled
>>                   remote-sensor temperature,
>>                   4=fan controlled by target rpm set with
>>                   fan1_target attribute.
>> +pwm1_mode        rw    Fan duty control mode (0=DC, 1=PWM)
>>   pwm1_auto_channels_temp ro    1 if pwm_enable==2, 3 if pwm_enable==3
>>   pwm1_auto_point1_pwm    ro    Hardwired to 0, shared for both
>>                   temperature channels.
>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>> index 5a3c089ae06f..98a45fe529e0 100644
>> --- a/drivers/hwmon/amc6821.c
>> +++ b/drivers/hwmon/amc6821.c
>> @@ -317,6 +317,12 @@ static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
>>               break;
>>           }
>>           return 0;
>> +    case hwmon_pwm_mode:
>> +        err = regmap_read(regmap, AMC6821_REG_CONF2, &regval);
>> +        if (err)
>> +            return err;
>> +        *val = !!(regval & AMC6821_CONF2_TACH_MODE);
>> +        return 0;
>>       case hwmon_pwm_auto_channels_temp:
>>           err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
>>           if (err)
>> @@ -372,6 +378,13 @@ static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
>>           return regmap_update_bits(regmap, AMC6821_REG_CONF1,
>>                         AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
>>                         mode);
>> +    case hwmon_pwm_mode:
>> +        if (val < 0 || val > 1)
>> +            return -EINVAL;
>> +        return regmap_update_bits(regmap, AMC6821_REG_CONF1,
> 
> Wrong register here, should be AMC6821_REG_CONF2.
> 

Oops. I had a bug in my test script, and thanks to that it failed to report the problem.

Thanks for noticing!
Guenter


