Return-Path: <linux-kernel+bounces-411603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BD9CFCAA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 05:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2358B23C20
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0C78C75;
	Sat, 16 Nov 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwUto0Ay"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD474C8F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731731710; cv=none; b=gtgxKxJY0LXcXM7pDH5X5Sl2tXfwoO8gpFYLHlRWcYRhrwurSl2TkL0/1vIf74pcIm3Gvkfd22ICdoa2k70oamNvxkKXIf607GyXOypqGbvam70s1YaqgcNXhOqS9BECrhYUccMJcm1Tg157xKcClWbKv03mrxbtUnxf4QFfCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731731710; c=relaxed/simple;
	bh=hMHfziThdo71sGvCM5pVcU/XJ3kOx7hHNyigbrnJHo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9pDciqzRYB+WD42yJBujBq1hkACkLBcD6J+75LrSb/th5XR08H/x4th4PXcAdAPZsyqjUVjGQne97y6lxL6PYMvqSLBV6Ti5ZV4WX/ZzHIJPqokyN5pzO5Edh+JVdKw2lUCxfHSSx+kEuuDIxIuiT8EO+2vyKaR+a7CuUi+4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwUto0Ay; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2110a622d76so22190035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731731708; x=1732336508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b2h1rIVxofgmngJdiQyg2pumdfLusP39nz1hUTw8Ykc=;
        b=mwUto0Ayo85BUPpi7GfwuSjaQL60rkYUtSrtQ+/K6np8pWkto21LANiAt1gYCiLRAI
         To/JXAun0K/ql5/AhaueK2rETkQBzMF5KIrfO/+rGP9Q7oIRuqYSK9fgznXpqlq25oNf
         i2Q7++K6+QFtZzgYm4UwZevcBzhjmJOJKKpC44vuRknEK6vRULrFPyYUbCPchgK3Ug0Y
         ImFAfg2S2wd0maXSnENw2ooX5UsR0DvZWbrj7bGF6dYcaUHHa0HXopA6zS98NOBmsFZT
         5kkWCRzXyRirm9YTlePXn8f3j/Eb2NLdV1DNBMLgMPyzA6ghzEjLn5eiSt4oVbgMfnfF
         Suhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731731708; x=1732336508;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2h1rIVxofgmngJdiQyg2pumdfLusP39nz1hUTw8Ykc=;
        b=czDjGxt56gMLqSAshpHyu8a9p/3XbP3kw4/pKH27pqMGKcXwYWBVmKNrmC1OSrtmjS
         wELT6ZPVb6PSY65OaxMjpigT4zMYOCvWBQujrrQBB3ZRriJHNnZf2w5EQa9PO1Vaz9EB
         x7YzKZ+BbUTgjm7lF4GymF9+1VPLtiNSh5rUvqzw2m67tDXcYEyWBwk2CBIfRWBJXcPh
         nsoRR65WNd7tXfAlqJy1Q2ED0phohn9MxEAI59vzpRaEijQ5TDHsynNC6wrvuiXI8KP5
         TTPytUflDYQOkfu337oUN6msJqE8VtJRGvLHl721TtR4S414cZsObPrTc/qMxEqF/mk7
         i5Aw==
X-Gm-Message-State: AOJu0YykLBUVsLBoJOx1VhLKwxb3cn2fWYsb0lqWELHA3uHOjpm+2BeW
	fqVgmYFvjqxWttr8OqRMKmHxEIIjheC93OEbpdX7vgfjnRlcPLnWbTjdqw==
X-Google-Smtp-Source: AGHT+IFjAdzxT5yLeBftm9fTLv4v3m9PvcJ30atySp5+UbvDg1aMkGeHuXRbncruL8SBlut7rumztQ==
X-Received: by 2002:a17:902:d2c1:b0:20b:b0ab:4fc3 with SMTP id d9443c01a7336-211d0ecea8bmr62636945ad.49.1731731707852;
        Fri, 15 Nov 2024 20:35:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06ef6b3esm3683118a91.10.2024.11.15.20.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 20:35:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
Date: Fri, 15 Nov 2024 20:35:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regmap I3C support
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
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
In-Reply-To: <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 09:26, Mark Brown wrote:
> On Thu, Nov 14, 2024 at 06:45:52AM -0800, Guenter Roeck wrote:
> 
>> We now use
> 
>> config SENSORS_TMP108
>>          tristate "Texas Instruments TMP108"
>>          depends on I2C
>>          depends on I3C || !I3C
>>          select REGMAP_I2C
>>          select REGMAP_I3C if I3C
> 
>> and in the i3c_probe function
> 
>> #ifdef CONFIG_REGMAP_I3C
>>          regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
>> #else
>>          regmap = ERR_PTR(-ENODEV);
>> #endif
>>          if (IS_ERR(regmap))
> 
>> Clumsy, and not my preferred solution, but it works.
> 
> Right, so the fact that I3C depends on I2C deals with a lot of the
> problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> should be OK and there's not much doing for I2C/SPI.

It looks like we can use

        if (IS_ENABLED(CONFIG_REGMAP_I3C)) {
                regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
                if (IS_ERR(regmap))
                        return dev_err_probe(dev, PTR_ERR(regmap),
                                             "Failed to register i3c regmap\n");
		...
	}

even if a stub function is not available as long as there is an external
declaration.

I don't really like it, but it turns out that this kind of code is already used
elsewhere in the kernel. It looks like dead code elimination can now assumed
to be available when building kernel code. We live and learn.

Guenter


