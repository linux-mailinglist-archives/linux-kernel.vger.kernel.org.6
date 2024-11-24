Return-Path: <linux-kernel+bounces-419408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAD9D6D89
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B3DB2121B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDA186E27;
	Sun, 24 Nov 2024 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPOeQKcV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11413FC7;
	Sun, 24 Nov 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732443725; cv=none; b=XcwAeo/Sn2tpFv+NpBfUXW+ojuhIT5iW3ivmTsmy78CoAvtf8XRyrs+t2sxSdxL5JN5FQbiNki2QU1mrtADzyO12mRV6Px15qZzJWabSr2XrgaKFBvyOoCSbSIcueHDg8faNntwdpUtT4wBy5e98cMYJwtCX6a3RZYww0KwQyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732443725; c=relaxed/simple;
	bh=9oCTn0OuRR2ZYCAbf59HtSXH94Vj+xyQ4b0OVmshtos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYvHjf4r8lpfITcfjhWfBvD+3KcnFBovlD9ZsVkMYnlEM0iTmEb7CxG6fe5K3/VltustqO/Hi6bqf7cDj2z/qVCMKmktKvD5D9O1XeQCt9OcZPirhfg2BYmQXS+Fhhkape7T+k2smnhljlnOh1jySomafuuaCOIBFO3fUjFvmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPOeQKcV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so31649915e9.0;
        Sun, 24 Nov 2024 02:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732443722; x=1733048522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EARY631trTP8bPGVF4+FUq8WRYwqoko+NV4e4AJDVS4=;
        b=WPOeQKcVMVs9ZJNj58IfPhbI1qO42/tVKegUoSOZ2LcQcxZB/cros5LxCchboD9jZp
         Wj7LV8uRjOLon5WLtKZijkaT4W9pkufJ0H6iaPVO7l9ZrgBr1uJ4QSHT7P/dbvwz4wCe
         2NbhK1v6YAMvmoZdP9TKJZ0zB16fIlymzFRUGO7QDvzIr0EZCssV3ZUjZLNPqjSbkZAx
         C/etrZUSz2yL/s6W8BBUfnP2meZEMWe4JrNzhIbCh6cfDesTNwT/MdqwozQGYYKoGMLx
         lgs2U+bycDshaGv3QmsM/jY2YRmmvk0opOWdHioIGzX++ch1V0vcqLsLJ67C9d/A0Tk3
         cSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732443722; x=1733048522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EARY631trTP8bPGVF4+FUq8WRYwqoko+NV4e4AJDVS4=;
        b=BjbNgxnvUdcyBxz7nFiRygNo2y6Xa7VD53+5POUcbO1WxJnbzHwqzAMGdaP4m3nd1J
         bYJDR909GlMR/GvG2awVLpm4cRR+eHpmo6ulC3PWBo1S6KMU6ItsbEOAjf8R0D7G80Uc
         v+dkqqEjuqg/AwLruoEfqqb3HwnyiCbq0NlMvaEXjp7li0cP13YFn/r7xmubSYK2aKgK
         1JuodCJIzhtJlrfv4yNLhm83gkK9ayFkixm5tAfQ817mjBcNJyPidtZJoWkdMyPxDNSl
         gayO46QuHcmHQihhWR3vJlAqHwdM6ErrzTkNPzpRAXHL64PwBcr8zYdZlaHIsbXtFxWW
         5ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9kCnKimMF1PgoR6BaNxj22XAk1kqVvkroB443AIpOKrbEbgPdQR/gt4lpd+QUF7coJNIdm2wk/sc@vger.kernel.org, AJvYcCW+3A86580nhUl0OxY7S/J3CplxdtzpOm41HcjTyfKDaZhi7b7t3w6DOBKKoSAC1ibqF+7N6YBOuqIH4URu@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdL0yB97St0HqYXKcWrJz39KnKwsHkNk/9a893qQOwjzSxIT1
	j4xFAGEmO3uwd1huevbxDDKk6GgV+Sfdd5v1bytzCtWG3QORFOZI
X-Gm-Gg: ASbGncv7FjYAEdp7DguflGN/tDenGSwnLRmNZS0nom/qK7TSajtNxomC9zK3087LwUs
	jFd8XyR6Zz0tAF5ypMivoE3W6wgr8HYaIt6L0utSUwjWbVLSBk9/U9hG0w5f1PphgorfHxH1lGL
	QYBvQ/EuVhINQvKQXU5fLiK9I016gPFnlLghaKo1LsiwLFYZKs5UiDmQmo+N6AgzwW9dQ+4gWhP
	XCVHbjff6iuRmWeEYaKKyZRYGGoEqj5CIS9IuFgmau17hKSCY1jZmZ+p3GC9CKiCrNsLo5CO8k7
	REA1aUqxvDnk8FFEZVJ6kIdWVlyK1Q==
X-Google-Smtp-Source: AGHT+IF90ZCmjQclncaeSHdtxHJLKaUTR0zA5IJT87d4aV/v6gyuaYoZ5id52sQMUI8wUQFT+DWspA==
X-Received: by 2002:a05:600c:4712:b0:432:7c08:d0ff with SMTP id 5b1f17b1804b1-433ce48ee2amr67395605e9.23.1732443721726;
        Sun, 24 Nov 2024 02:22:01 -0800 (PST)
Received: from [192.168.2.120] (cst-prg-110-166.cust.vodafone.cz. [46.135.110.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f2e1b3bsm1036125e9.25.2024.11.24.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 02:22:00 -0800 (PST)
Message-ID: <c8f40177-1d81-4c8e-8319-e78623cded42@gmail.com>
Date: Sun, 24 Nov 2024 11:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] w1: ds2482: Add regulator support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
 <20241122-ds2482-add-reg-v2-1-a5a03ee74da7@gmail.com>
 <2ff7omfp752zdtzozcle5jn7nsyonsbqgjefrx5t4lncoer5bw@wb76uxg26ugg>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <2ff7omfp752zdtzozcle5jn7nsyonsbqgjefrx5t4lncoer5bw@wb76uxg26ugg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> On Fri, Nov 22, 2024 at 09:53:57AM +0100, Kryštof Černý wrote:
>> Adds a support for attaching a supply regulator.
>>
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
>> ---
>>   drivers/w1/masters/ds2482.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
>> index a2ecbb863c57f38bffc8e3cd463db1940e603179..3fb35e92fc1587dc4e609c0061fa5057e0027a80 100644
>> --- a/drivers/w1/masters/ds2482.c
>> +++ b/drivers/w1/masters/ds2482.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/i2c.h>
>>   #include <linux/delay.h>
>> +#include <linux/regulator/consumer.h>
>>   
>>   #include <linux/w1.h>
>>   
>> @@ -117,6 +118,9 @@ struct ds2482_data {
>>   	u8			channel;
>>   	u8			read_prt;	/* see DS2482_PTR_CODE_xxx */
>>   	u8			reg_config;
>> +
>> +	/* reference to the optional regulator */
> 
> Drop comment, obvious.

I will drop all the other comments, as they seem to have the same level
of "obviousness" as this one to me.


> 
>> +	struct regulator *vcc_reg;
> 
> Missing indentation after type - see earlier lines.

struct will be removed with switching to devm_regulator_get_enable().

> 
>>   };
>>   
>>   
>> @@ -445,6 +449,7 @@ static int ds2482_probe(struct i2c_client *client)
>>   	int err = -ENODEV;
>>   	int temp1;
>>   	int idx;
>> +	int ret;
>>   
>>   	if (!i2c_check_functionality(client->adapter,
>>   				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>> @@ -457,6 +462,18 @@ static int ds2482_probe(struct i2c_client *client)
>>   		goto exit;
>>   	}
>>   
>> +	/* Get the vcc regulator */
>> +	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
>> +	if (IS_ERR(data->vcc_reg))
>> +		return PTR_ERR(data->vcc_reg);
>> +
>> +	/* Enable the vcc regulator */
>> +	ret = regulator_enable(data->vcc_reg);
> 
> You wanted devm_regulator_get_enable().
> 
> ... but your comment also suggests devm_regulator_get_enable_optional().
> 

This is a good point, my implementation is based on observation of a few 
other drivers and it's not needed in this case. This will reduce the 
amount of changes.

I think my wording was not correct. By optionally I meant that most 
hardware designs do not use a separate power supply regulator, so they 
do not need to specify one, but the device needs power to function.
My current view is that it should not be optional after all, so I would 
go with devm_regulator_get_enable(). Could you please tell me your view 
on this?

> 
> Best regards,
> Krzysztof
> 

Thank you very much for the review,
Kryštof Černý

