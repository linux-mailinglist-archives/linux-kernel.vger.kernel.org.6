Return-Path: <linux-kernel+bounces-195419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A498D4CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16D9B22A66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089E517C235;
	Thu, 30 May 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="furhTOVH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090B17C226;
	Thu, 30 May 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075651; cv=none; b=I9vG+neT4NQ7mhB7hi+S88dhlZxc4hwosTVdBew85eQqrkuacc3fjLSyoP9bt0jxgtbo0oWc4vOyz0hLUQEHOXK49G6iYzgCbkEORQgd71sAbcES9w7xfcZb55MicsObvhEE/2F99W93shKiQCzq6HKSWO+O+5PrwN+8Evyb1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075651; c=relaxed/simple;
	bh=rrt+w8wXyyduGa9fR4MlBB5G6jrF7RONxEymH5GxcOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enlQrC6GfpmVS8BnpewLXFoW7Jm4io1d+ssYK6LNJyvT/aQTTgFC+VqKBPKo4/uzHKwzXJmryUopXREvBOnswAX8nN8dV9ji+kJ4MfUmfIbkGnPpzHw+l1D/pTeyMkyQ9vv+BdjF2MGMqSm54xIR0AbNK5gWUaJYR+I267xBZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=furhTOVH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-701d854b8dfso799722b3a.0;
        Thu, 30 May 2024 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717075649; x=1717680449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Msf4vkwOHBXye+g2w5w4UrIBeB5hpUPmb6Frgmyrx80=;
        b=furhTOVH9s+ZEh4N39wsaiRrNAe7K2gAHA2AlhopeXeIiJYgygWYN28psYu8tCWb41
         Ul7GtV3R5hgqjaIvdcxnZLeOZjlAMDgVjuIrnBxPb07lbNEvnhAoPuUvDk1vlPc57BhO
         IT5f4G5rXmoGvPgAm2Xy1ucVh85BJ0XYry1YUArEr6xpJQvwNStLN4weNhF+6ah/k67A
         Vpd2aA6MxGeAETpq33QisQUrFU+7MuYkuhbS1ly8arTCSwUXgJ/eBcM/hNxDClEqhBk5
         BmTk0Lf9YsLFn9VtPX0N3AnIqBtB5iPbj0h+ghLUFKhUpstEwvdaNXJ4jqqTCplpLTCm
         4dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075649; x=1717680449;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msf4vkwOHBXye+g2w5w4UrIBeB5hpUPmb6Frgmyrx80=;
        b=VbotmIhCgwcScoCfbM7a/+6yUr9G0vVU1jy7nSlmJja7A+w2WLsT41LGej3IUCo9/g
         fs9s2LA+kQ6jtZvPnAuNkMkwUto2rcdJm8TXtVooxX1gpJ5GCT0i/O7OZLrvW1PtZuKo
         wwY0ac9v0MlAJ/4AQwVb8Gzwi+RH96BVoYNXQj2943FCIu/57+umUFEucoq36Vgys+jZ
         zx400dyAmWEHKWUExjbFQOIL5GDFYMPmtYTMk+zhQk2a++eRUnhLVmhrRTTHyi7bdI6B
         QB8opLJdNzR1b/iQbDHR2mxXtjOzJgnyS7KBKTqaNQgIw7pFpAStxx+F3RgReMoaE+of
         Kiow==
X-Forwarded-Encrypted: i=1; AJvYcCViS14bLjaxJ2Ex5MOmkVrbwpzhLFc6qJUREefnqIaKvhWcxV3ek9AX0VzNT2ymYUliF6N0BI/Crex2jzZK0yLhe5ECmK0jvA3stXMehTKERTnGgMewGP8sgpwIFdJW/7+BS1Z1Cix4NA==
X-Gm-Message-State: AOJu0YyaBH97qzeOoOT/XKcdgzPMa1IuxHRD/HTMkAPj+vcH7q9pZtnE
	xUUjMAIGZB5N7rOJZwt11ZLatT3t0WfVd1Z58OrL9eLAcj87qgXU
X-Google-Smtp-Source: AGHT+IHQ+ehEEdr8tjobXDwJVVJ6BIlNnSojda9OXKSvXWRI7ciZdxJqssfVuFRM0n5rYVhzJBak6A==
X-Received: by 2002:a05:6a20:2454:b0:1a9:dd82:a42a with SMTP id adf61e73a8af0-1b2645dddc8mr2242652637.31.1717075648847;
        Thu, 30 May 2024 06:27:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd1d2732sm9929826b3a.170.2024.05.30.06.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:27:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8650e355-8c8f-40d0-bcf0-07875cf75f4d@roeck-us.net>
Date: Thu, 30 May 2024 06:27:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <45396bd5-adb8-485a-98d0-eecfb7439bfa@t-8ch.de>
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
In-Reply-To: <45396bd5-adb8-485a-98d0-eecfb7439bfa@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 02:08, Thomas Weißschuh wrote:
> On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
>> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
>> sensors. Such sensors are typically found on DDR5 memory modules.
>>
>> Cc: René Rebe <rene@exactcode.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
> 
> <snip>
> 
>> +/* Return 0 if detection is successful, -ENODEV otherwise */
>> +static int spd5118_detect(struct i2c_client *client, struct i2c_board_info *info)
>> +{
>> +	struct i2c_adapter *adapter = client->adapter;
>> +	int regval;
>> +
>> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>> +				     I2C_FUNC_SMBUS_WORD_DATA))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
>> +	if (regval != 0x5118)
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
>> +	if (regval < 0 || !spd5118_vendor_valid(regval & 0xff, regval >> 8))
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_CAPABILITY);
>> +	if (regval < 0)
>> +		return -ENODEV;
>> +
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
>> +	if (regval)
>> +		return -ENODEV;
>> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
>> +	if (regval)
>> +		return -ENODEV;
>> +
>> +	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
>> +		return -ENODEV;
> 
> This breaks automatic detection for me.
> 
> I think the test should after the read of SPD5118_REG_CAPABILITY and
> test that register, similar on how it is done in _probe().
> 

Yes, that got messed up when I added reading SPD5118_REG_TEMP_CLR and
SPD5118_REG_ERROR_CLR in the last minute. Thanks!

Thanks,
Guenter


