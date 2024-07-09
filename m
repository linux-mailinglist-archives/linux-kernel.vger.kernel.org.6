Return-Path: <linux-kernel+bounces-245069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555792ADE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C161C218D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0739FD9;
	Tue,  9 Jul 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUPmVD5X"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC013D966;
	Tue,  9 Jul 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489339; cv=none; b=Bqw6ROaNVlGceS/HIOMc1EsS/rv1LBoB34hL1HJUiso+PlNr1FBtBY+1fweBge3A7e855rxaOKwnI/UOKxStScwXFaE8QtHDDe6fOu7vU+IKjahXZIakvCQcHxUtHskPRmGJAODMy4xR7d7mJ/cbL2eMkHugiPn3ugG9uLPLAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489339; c=relaxed/simple;
	bh=iLDEgsZEuGirQQVwHzZSmfqPlOaPKhWq15eL5/i+Fcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooIZ/DQ711E9G8pApAWQmZgn9MhOUSrwM39+wr28ORQZ8zBGKCnWRHv6G0L3TN/vqFkAaPdltVhAJs+kClRZVkc6OUO4hVvWGxNaL82sHvGFf/eGmQpA0vLpXvWTXl8RugCgBXejypgPdrZX3t9B50xBrwkzsYkTsiT9jhOGjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUPmVD5X; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-376069031c7so17924305ab.0;
        Mon, 08 Jul 2024 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720489337; x=1721094137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=efZGwFEn680Tz97EnfQTVaTzk6j1FWkM3gtbIw3HXUY=;
        b=fUPmVD5XvZhZgq8tL7TQh1JX6U6OAnbaAnC1UBMcFu3JURvQJ6G4MgB1POoRWyA0Qz
         hbZEMDZY0RES6BS8HvTpR7pC2Vv6pezI67vfIO3sNuMbey/KgCiNvRFtURWHNqyn3wx8
         pudCE+OwxFH9w+lyTuxCTr1AQzCsVg6sDgxxEQoKqIUoCvT/lh2p8+IzP+smkFCr2mvj
         eF2yEUtsiyI2ykLod0S9cnnr4Ak7kC+dj5Bxv8VB0rQmfZn/X5hA0L3siLoSVVLzh8ON
         pR8etb/EWc+nN+25nc/XPcuW46sqQRf8quBk/k166KkKfu/+rGR23xVlocM4VrVz5IOb
         0q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720489337; x=1721094137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efZGwFEn680Tz97EnfQTVaTzk6j1FWkM3gtbIw3HXUY=;
        b=QJAXokjNNTeoFfz9nKAHs3OmEDxpDEDAT7LQHr7JVjOVZXJv/Bh7C+W1BK60xGQ3qT
         CZWCiN7x70UUY2vZ18qqyGqzXSE3yWjGu/rVgaarIxmz7KFe/cBuZBVlLXd6C4QSjPL/
         8HrVQx7z+7gXtaBFXOd9ht4h6AZRPmhaJDiQgR5xDBFyX/DqoKlUnAbn/+vPByMdJu88
         jLUr73WPQJ7yXjZLQ2Ln6+4shwfKZ4BPfWNPvJRmX0jwOsGlwMv4b3x/VO0hJ4BEHV18
         jdA/dSoteOzKFhBCL2GKKn5Ad6202S1S7W/I3fUqsYio9IIATqih76Ar9d2jrkA8UDRu
         JS+w==
X-Forwarded-Encrypted: i=1; AJvYcCVUtq7J2UYN/xxETioknUehIMvWgkf7rYup0hdmMkRt3whMH/AgQvWam2ULO2oQE6JfRFH4nF/nIjWTF7Pd6fUewxw/t2OX+3LZYKr4607x1YpJUfvloHPS1nsIfgJXvx+eUQvYz7TmJDtDMvgFx/SUX5faizBt6dsy8wVVxATyEAQUqA==
X-Gm-Message-State: AOJu0YwNV4Ip8+xoMOXqTO0bdEwUpQivMhkz5gIY/Uneu5oqnL8eJ9e+
	wH7ZMbKrzV/4KxohF6RrHD/cWeFOgmBadQoaKkgcyQGjxwcpbyoj
X-Google-Smtp-Source: AGHT+IG8eUAcS4B1l5l4JiSl/3TaEIecY5XR5AN4tDAQCt2iZtbcK0ZRlYGtkKblTEEVqV94WD505g==
X-Received: by 2002:a05:6e02:214f:b0:382:b446:e139 with SMTP id e9e14a558f8ab-38a5740178fmr14071885ab.11.1720489337076;
        Mon, 08 Jul 2024 18:42:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389abb6sm569002b3a.18.2024.07.08.18.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 18:42:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b12fc4a5-1b12-4d59-bf21-edd583a81b4d@roeck-us.net>
Date: Mon, 8 Jul 2024 18:42:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicorn_wang@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953230DCEDD7DF01134A8A9BBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822676C9CF9443B9A3CB657FEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB495309AA07F1B77D4DA1EF6BBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <IA1PR20MB495309AA07F1B77D4DA1EF6BBBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 15:15, Inochi Amaoto wrote:
> On Mon, Jul 08, 2024 at 03:11:37PM GMT, Chen Wang wrote:
>>
>> On 2024/7/8 8:53, Inochi Amaoto wrote:
>>> On Mon, Jul 08, 2024 at 08:25:55AM GMT, Chen Wang wrote:
>>>> On 2024/7/3 10:30, Inochi Amaoto wrote:
>>>>> SG2042 use an external MCU to provide basic hardware information
>>>>> and thermal sensors.
>>>>>
>>>>> Add driver support for the onboard MCU of SG2042.
>>>>>
>>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>>> ---
>>>>>     Documentation/hwmon/index.rst |   1 +
>>>>>     Documentation/hwmon/sgmcu.rst |  44 +++
>>>>>     drivers/hwmon/Kconfig         |  11 +
>>>>>     drivers/hwmon/Makefile        |   1 +
>>>>>     drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
>>>>>     5 files changed, 642 insertions(+)
>>>>>     create mode 100644 Documentation/hwmon/sgmcu.rst
>>>>>     create mode 100644 drivers/hwmon/sgmcu.c
>>>>>
>>>>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>>>>> index 03d313af469a..189626b3a055 100644
>>>>> --- a/Documentation/hwmon/index.rst
>>>>> +++ b/Documentation/hwmon/index.rst
>>>>> @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
>>>>>        sch5636
>>>>>        scpi-hwmon
>>>>>        sfctemp
>>>>> +   sgmcu
>>>> This driver is for sg2042 only, right? "sgmcu" looks be general for all
>>>> sophgo products.
>>> Yes, according to sophgo, it use this mechanism for multiple products,
>>> so I switch to a general name.
>>
>> But multiple != ALL.
>>
>> [......]
>>
>>
> 
> We can add new driver when there is new mechanism.

Now you are contradicting yourself. Either sgmcu is the catch-all
driver, or it isn't. How are you going to call that new driver ? sgmcuv2 ?
Are we going to have sgmcuv[2-N] over time ?

All we know so far is that the driver and the mcu support sg2042. That is how the
driver should be named. It is easier to add support a new device with a different
name to the existing driver than to add a new driver if the name of an existing driver
is too generic.

Ultimately this is similar to wildcards in a file name, which are strongly discouraged.
One of the worst examples is drivers/hwmon/ina2xx.c, which does _not_ support all chips
from ina200 to ina299. Please don't let us go there.

An opposite example is the lm90 driver, which has not problem supporting more than 40
different chips with different names because they are all similar. The driver can be named
sg2042 and support as many similar variants if that mcu as feasible. It should not be named
sgmcu because we can not make the assumption that it will support all mcu variants from
sophgo.

Guenter


