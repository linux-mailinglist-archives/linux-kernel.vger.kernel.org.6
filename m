Return-Path: <linux-kernel+bounces-188736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC108CE618
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3A1C21089
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276021272C7;
	Fri, 24 May 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEPKYJwt"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647D86ADC;
	Fri, 24 May 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556853; cv=none; b=ZNfvMRpFkYgcHrlc3nwkyZeTPLuuf8VkKtbCrMWPSq8fCil8Oy1/QijGXIgkDStrBZFpSPkrmercpD7adslnmoBtC4ySg+TlCh+crxL6vmhLWr8WD44EeeykrUinmY5lFno2UDwnAnTGjtnTeli93dIQqHY2ObucLAEdlWMUOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556853; c=relaxed/simple;
	bh=dusH13FGed/xCq0e/yE1Yz7ndxxN5dgptGHXvcd88x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB1421tYLS5YieoKZ72mFJFxZG0yrNfT4a+BkUrojIEIDMXXZw+w1gfj+eL3+pbfnHSw7hdFA0q1ui2SNmCiyd7fze748XiVzVpEU0x1Y3r7eMlKosJXgyZ9f3tMkYeymgllKzVxDof8+PwfIzNrQa+qlr/6MjPvEQw0xpz3F3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEPKYJwt; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e1b8e3070aso352245939f.3;
        Fri, 24 May 2024 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716556850; x=1717161650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NiJkdpzuiz2YvDCtfW0QgbnVrbOaduXcSiyxb63NU5Y=;
        b=FEPKYJwtfXbHmJnQJLLZZIa3zLBMpqrK1g2t/ZgAxs06wrC/j8fiYDo037Ie+eVZVd
         2BnhMbwRzbE/gsUApeCc1VrY/JDl+qXENBmMVazhTBLtEJpW1msBOKr+J+U8heQ3zv1M
         DyVFNz7dBOIvDMJwgXdzpwpWM70ESEwdv9bN5SvkP/MgYu7Zq+A7kBKpt03AN9VFNorG
         cNwJf6ggE3R+EbdEq7meGvfhlMRAA+jg+33jPMcm4sqf4RZq+BmSBWNceW5zi9cPHr20
         gj+0NpJqlWKiQvPMi4DowpiUxPk7POGhRDTRA/zJCl7XZbIaDA6vDwXlm7tb2P48ZGe4
         qt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556850; x=1717161650;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiJkdpzuiz2YvDCtfW0QgbnVrbOaduXcSiyxb63NU5Y=;
        b=w06t12qnUL9JATJVYOoO8Mo5Gz/eip3eBD1+DP+CgdY/WVAyWVEE6Rk9k2VXZ5WQyg
         Zkf9r3/kEo+cPD1McU9yzpHSrMKdWq24Qw82SAS0kg8vVXH3HA+sUnR1fKJF+8kBVtyw
         HyfKDGbe0ICV3yA88n8g5uFIGh+lCwWMtU5u4h79TY7AynAl7eY4rZKYl5LWJM4A9+Z9
         9xuCkNqHM5n7k1Relgu6TE+lQ+X0J2E4ZC4/6c/F8OS/fGGjHxPnQ3Xw9Y5V+jQHat+q
         dRlJD+PLwUEXb+LGmefsEo6zGrZ4wmZuiPTDDRKyGRlZsPzRWqgGBXNnel+qH67n5DFQ
         5a4A==
X-Forwarded-Encrypted: i=1; AJvYcCVl7SqAqmyJhrW4LZ1STI1TKnwoQoHiS6bPDluzMIT4BKq/UA80/GQa1bGJUK/Hf95YorUVjHoq0ipZWEqXhwYaPWeknWzW+3y9wwVMtASmXLy1Vqw+sUlobBb0ZWNXhV6+vkQmCfQtRZtCk26Xv0E6kPsTq+YUOCGl0qLU+Bfw1NNGTXU=
X-Gm-Message-State: AOJu0Yys0BBzVuNhlFeU7gnKUK4GQR05gVr/lmXsPeNrHaiJyp0pmwy2
	AlQg7YRfBfn21A/A7iinwUuwWUM3p9Tew9w4Wk5VxBqps0zvSsKs68kYjg==
X-Google-Smtp-Source: AGHT+IFz8/TvUM5Di4GCF+AmnBdQr89Jdy/Ro3lkrn+zhhMoPUQmaE/oM7D9cB3wdkHXZDylWANqUA==
X-Received: by 2002:a6b:5806:0:b0:7de:d88f:54a7 with SMTP id ca18e2360f4ac-7e8c636bae1mr261234839f.13.1716556850440;
        Fri, 24 May 2024 06:20:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822073fbffsm1139407a12.2.2024.05.24.06.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 06:20:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5bb5b291-ec6c-4233-b2f2-bf7f1ba74d24@roeck-us.net>
Date: Fri, 24 May 2024 06:20:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: hwmon: max31827: Add PEC support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Radu Sabau <radu.sabau@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240523121057.5689-1-radu.sabau@analog.com>
 <e52a86de-ead6-40d3-b652-461a90bd5942@roeck-us.net>
 <58e17135b41da7eba8afd5d8fb5f25bcaffa7288.camel@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <58e17135b41da7eba8afd5d8fb5f25bcaffa7288.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/24/24 00:00, Nuno Sá wrote:
> On Thu, 2024-05-23 at 07:19 -0700, Guenter Roeck wrote:
>> On Thu, May 23, 2024 at 03:10:56PM +0300, Radu Sabau wrote:
>>> Add support for PEC by attaching PEC attribute to the i2c device.
>>> Add pec_store and pec_show function for accesing the "pec" file.
>>>
>>> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>>> ---
>>
>> Change log missing.
>>
>>>   Documentation/hwmon/max31827.rst | 13 +++++--
>>>   drivers/hwmon/max31827.c         | 64 ++++++++++++++++++++++++++++++++
>>>   2 files changed, 74 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
>>> index 44ab9dc064cb..9c11a9518c67 100644
>>> --- a/Documentation/hwmon/max31827.rst
>>> +++ b/Documentation/hwmon/max31827.rst
>>> @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive temperature
>>> faults must occur
>>>   before overtemperature or undertemperature faults are indicated in the
>>>   corresponding status bits.
>>>   
>>> -Notes
>>> ------
>>> +PEC Support
>>> +-----------
>>> +
>>> +When reading a register value, the PEC byte is computed and sent by the chip.
>>> +
>>> +PEC on word data transaction respresents a signifcant increase in bandwitdh
>>> +usage (+33% for both write and reads) in normal conditions.
>>>   
>>> -PEC is not implemented.
>>> +Since this operation implies there will be an extra delay to each
>>> +transaction, PEC can be disabled or enabled through sysfs.
>>> +Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
>>> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
>>> index f8a13b30f100..e86f8890ee72 100644
>>> --- a/drivers/hwmon/max31827.c
>>> +++ b/drivers/hwmon/max31827.c
>>> @@ -24,6 +24,7 @@
>>>   
>>>   #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>>>   #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
>>> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>>>   #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>>>   #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
>>>   #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
>>> @@ -475,6 +476,54 @@ static ssize_t temp1_resolution_store(struct device *dev,
>>>   
>>>   static DEVICE_ATTR_RW(temp1_resolution);
>>>   
>>> +static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
>>> +			char *buf)
>>> +{
>>> +	struct i2c_client *client = to_i2c_client(dev);
>>> +
>>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags &
>>> I2C_CLIENT_PEC));
>>> +}
>>> +
>>> +static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
>>> +			 const char *buf, size_t count)
>>> +{
>>> +	struct max31827_state *st = dev_get_drvdata(dev);
>>> +	struct i2c_client *client = to_i2c_client(dev);
>>> +	unsigned int val;
>>> +	int err;
>>> +
>>> +	err = kstrtouint(buf, 10, &val);
>>> +	if (err < 0)
>>> +		return err;
>>> +
>>> +	switch (val) {
>>> +	case 0:
>>> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
>>> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
>>> +					 val);
>>
>> While correct, this is misleading. Should write 0.
>>
>>> +		if (err)
>>> +			return err;
>>> +
>>> +		client->flags &= ~I2C_CLIENT_PEC;
>>> +		break;
>>> +	case 1:
>>> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
>>> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
>>> +					 val);
>>
>> This is wrong. s/val/MAX31827_CONFIGURATION_PEC_EN_MASK/
>>
>>
> 
> Then, maybe use regmap_set_bits()...

Good point, and regmap_clear_bits() above.

Guenter

> 
> - Nuno Sá
> 


