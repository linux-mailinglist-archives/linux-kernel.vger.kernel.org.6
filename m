Return-Path: <linux-kernel+bounces-570780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9EA6B45E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CB63B735B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9E1C174A;
	Fri, 21 Mar 2025 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwcNpN0T"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757758836;
	Fri, 21 Mar 2025 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538249; cv=none; b=uRiclIjqgiv6Q7exPCe+1O68xmOi29Q9yUOx4V5apJXsjlnHXvn8nzWYxK2RwxWhUc8j6dHTYLcV/ZzfcmKx/KJgAoBvuTmgkNM2gtuJFLN3qZZOjp+bTALWQnQQu00CF80Tx/ZKCdZtfbO/eCI6IBhryTQvAX05Vw0YXFUhruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538249; c=relaxed/simple;
	bh=bIUq2iwWgB0d99tFyh3gAlbjdPYQysH8xMCASpdnNSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhyVugZj7hfgiw5I9zvT6SNBT6vrkNMJIpmJbT9O9ktxMmbH1g4P2Uh4V1qL69SXXbDdaXOEWlElfVb8saC5oPj4pkf2nTkXw6pfdNjrL4VWZri34lbpUuySFd6/BDOloT/p0PpAmhTt2U88PkqSWuZjoSB6y/XMixdJcohUs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwcNpN0T; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30b83290b7bso16618771fa.1;
        Thu, 20 Mar 2025 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742538245; x=1743143045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0dl8uHosWu+q2SYrJt1syTFcZPL2GIziOmTNr53eyU=;
        b=KwcNpN0T5ZFBZw1NqANdNi8qI+yrXvJRilh0I8+YdgZTj54scAoQRcowq66BP8IYv3
         xRE2wEpWqi+KhOVdjxph+eQtLpxZ13vt2iR1MA63/SgkBBJdjO6UiHz0/q+pLpAxsRi7
         d7Eh24HjLJ6WbyM6X3uiku8dnWlrwCd2uzsuyMP6bLJvZioQbp9jMwvPXAZqi2yFnmmY
         nORUevvqpzYI3DXky1Rr6il+J/nHbuqZmupmTRKsvFje3NQkjgYOd7MuHfStdWd8Tt+w
         bEFlOCip2cfHfm+e5ElNEzBuCl7jh/xPj/g23WOP+s1bHfj/3ZTzw06L/sQXa6RyueFc
         cc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538245; x=1743143045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0dl8uHosWu+q2SYrJt1syTFcZPL2GIziOmTNr53eyU=;
        b=nhqxBFzm+YK+Q1UNz8eYAYjYDjh8gICUqz4/8X/5WVH5BqK8JUwH9OT7QMBMpMJBsp
         uaMaralo2sCYx8V3VkEVEiRRFECw1cNHGu9nJ0j0hAgrsd6cI8wndY8fEOKlvq+VZzDW
         JVqsWWKh2U8Q0ni05F5gOohwIzHVneN468Ce1Hl0LvaIkKttcofzcUChzj4zoODcMYbu
         5svKPkODF5ao48DdXu5k+oJtn3rIv/8pXvzXYn2iucC0ru0on1dBDy2a3pjv4Gz2q97D
         LJD8GM9IeDF7F8DSUxLnT2YyI7+LQmilhcRZPXTLFBakeDMG2GaE5Tgc6ZpP8/TVQlkf
         Ls4g==
X-Forwarded-Encrypted: i=1; AJvYcCV8APmn4agjkEbKDqioNqP7Yvao+a45mNk9B1we7iendBXEvddZglAq2KrDwrX8z1CiLbx3uw8T3NFf@vger.kernel.org, AJvYcCWkkcmQXbK99QSLfTYD6gsavVHkDYYuLvSpN1ayTSaJhb8vG4rn7GKEz3yxc0SpypaDuwPZ/fyH+ak9z4Dv@vger.kernel.org
X-Gm-Message-State: AOJu0YySuOSOV9QiPEJ+eOvj6j8DL4aJfXAu/qofLrYBtXTizeHcZ5uf
	xzEKlZMcjGG4RmpLRzrq3W34WFr9hriJeklfMv2KQRBAa2iZ8B6FH/g3Ig==
X-Gm-Gg: ASbGncu5f3TsDAsWYEX5E1EqcyhrPuj2n7WToS9zNpRhnuFDlL7q+XfLeRkRSz56LN6
	mr133wAC/pjzoKdFQYsyTQajP+leXNfpY+huHrkebJZZ6zcMfsHgOK+JgxtLN0VUNDo647hlnV0
	uVN/FsuiuhwVYYMgxTUyY5dhPy7VGyq46O+vWPtYh9ejYNf/cE4UjZJ4o4DQHfnhHn7Y+geThW6
	hIDe4BOV1cM2wYqaIO1DfZ0g4tBKWOIWqgdC5yyR0PVkVV6gu8CRdk1nj7eghwqPxMJrtqejiE/
	j/BV5ugZcXwVuMiUl3qPgcJBlYHrN9ZeK+6iQxQiItLUW9R21AJ+ESX+FKKQM1EEgWNqd6nq7EE
	8W0Sxt3WK+cNVnKz/GI3WUWP5rG0DbP2X6sCV
X-Google-Smtp-Source: AGHT+IGeU/34QUAdzkSDUrhmnru9kJFklwyikOsD7FcErHIRl5nYvsOdBZDC6Nk1lo2RtuwkvoUV4A==
X-Received: by 2002:a05:6512:2303:b0:543:baca:6f1b with SMTP id 2adb3069b0e04-54ad64fbf5dmr755363e87.44.1742538245045;
        Thu, 20 Mar 2025 23:24:05 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbd8dsm105336e87.158.2025.03.20.23.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:24:04 -0700 (PDT)
Message-ID: <e1e83290-64a8-4f06-b00f-d9fa8774a421@gmail.com>
Date: Fri, 21 Mar 2025 08:24:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] mfd: rohm-bd96801: Add chip info
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1741864404.git.mazziesaccount@gmail.com>
 <fd445f9cbbdaa3fd5d7a9e59093f86e5ff7139b1.1741864404.git.mazziesaccount@gmail.com>
 <20250320165220.GB1750245@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250320165220.GB1750245@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 18:52, Lee Jones wrote:
> On Thu, 13 Mar 2025, Matti Vaittinen wrote:
> 
>> Prepare for adding support for BD96802 which is very similar to BD96801.
>> Separate chip specific data into own structure which can be picked to be
>> used by the device-tree.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/mfd/rohm-bd96801.c | 83 ++++++++++++++++++++++++++------------
>>   1 file changed, 57 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
>> index 60ec8db790a7..1232f571e4b1 100644
>> --- a/drivers/mfd/rohm-bd96801.c
>> +++ b/drivers/mfd/rohm-bd96801.c
>> @@ -40,7 +40,21 @@
>>   #include <linux/mfd/rohm-bd96801.h>
>>   #include <linux/mfd/rohm-generic.h>
>>   
>> -static const struct resource regulator_errb_irqs[] = {
>> +struct bd968xx_chip_data {
>> +	const struct resource *errb_irqs;
>> +	const struct resource *intb_irqs;
>> +	int num_errb_irqs;
>> +	int num_intb_irqs;
>> +	const struct regmap_irq_chip *errb_irq_chip;
>> +	const struct regmap_irq_chip *intb_irq_chip;
>> +	const struct regmap_config *regmap_config;
>> +	struct mfd_cell *cells;
> 
> We're not passing MFD data through OF to be fed back through MFD APIs.
> 
> It's generally considered better to device_get_match_data() on an enum,
> then populate MFD cells using that as a differentiator.

Or, at least someone has done this at the beginning and it got copied 
all over the place, right? ;) Sometimes we just need to challenge the 
status quo to develop ;)

I can go back to enum + switch - case in probe, and pick the correct 
data there. Done that before as well. It's just that during my journey 
to some other subsystems, I've realized people can often just skip the 
enum and switch - case, making things a tad simpler :)

Well, not a big deal to me. I suppose it has some value to keep things 
consistent inside a subsystem - and I'm not offering to drop the switch 
cases from all of the drivers :p

TL; DR - Ok.

>    git grep compatible -- drivers/mfd | grep data
> 
>> +	int num_cells;
>> +	int unlock_reg;
>> +	int unlock_val;
>> +};
>> +
>> +static const struct resource bd96801_reg_errb_irqs[] = {
>>   	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "bd96801-otp-err"),
>>   	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "bd96801-dbist-err"),
>>   	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "bd96801-eep-err"),
>> @@ -98,7 +112,7 @@ static const struct resource regulator_errb_irqs[] = {
>>   	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "bd96801-ldo7-shdn-err"),
>>   };
>>   
>> -static const struct resource regulator_intb_irqs[] = {
>> +static const struct resource bd96801_reg_intb_irqs[] = {
>>   	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
>>   
>>   	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
>> @@ -345,18 +359,37 @@ static const struct regmap_config bd96801_regmap_config = {
>>   	.cache_type = REGCACHE_MAPLE,
>>   };
>>   
>> +static const struct bd968xx_chip_data bd96801_chip_data = {
> 
> Just call it 'struct bd968xx' then below instead of cd, use ddata.
> 
>    git grep "cc =" -- drivers/mfd
> 
> VS
> 
>    git grep "ddata =" -- drivers/mfd
> 
> Conforrrrrrmmm ...    =;-)

I've lived through the depression of the early 90's in Finland. Learned 
how to avoid wasting things - especially letters. Wouldn't guess when 
reading my review replies, right?

...Ok.

Thanks for the review :) Much appreciated.

Yours,
	-- Matti

