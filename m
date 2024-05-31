Return-Path: <linux-kernel+bounces-196867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10C8D62B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8E81C26D37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88216C684;
	Fri, 31 May 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKpxzXfr"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C250158DC3;
	Fri, 31 May 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161285; cv=none; b=DS8hXub/knNuCKtYlCJYRJAXocIEMLYHMBykAFrku1yNF18D5QpA/BVzRmh9k82FbKNy7spDF3FVKl40BGf7nMcZ3EsN1BAZRKgH5CztYR+trkSTgr7zuDF4hi35ZnymK/XBctnW5TAIYD0gquxsAX27g6MMIa80tZ81Lu5hXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161285; c=relaxed/simple;
	bh=hSLR8RN4cHIEq3Bcq8FJ9t06SjPzC0wwlwlRfQUAI00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9HLZd276KCwm3r5W3gQ8LiJ7sJsByGXkCEyXJITztr/FcQ2rVWLBQm5i7LE8lWZzsgZ6pHyzNo+5Osd1VDjYHj3VaxVaJNQjy7q6U2xsB1ye6OWcNvZkfuK3dpE6yaSU74ehT7uQU25IfDHOpnIq4qv5a7B7W6GCpkx4Toiuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKpxzXfr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7022c8418d9so1866762b3a.1;
        Fri, 31 May 2024 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717161283; x=1717766083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GRY6PDVueSm4bc28YBtX7UzkBLyneNGih9AMbKWTyAw=;
        b=QKpxzXfr60lnZZyXUMO17pLJGXjrB3UsY2S7dNAjzcrbppOYf4dWexPfEOjJeMmhqU
         d53pKcTXHJRo1+MCzGeC/bCfHGct/TifCjdlaLYpNYkTMvk9ZlpIrQetajmpoKqFpGoi
         AukLLgtxK1mCzStHjONem/e08Ya6GeSY44YYQVqbZ9uRBBFK5L5yWL4nippfb+A5z6c0
         8KSconHhWrIqeGOZx+cMDuLbxjyDXCW4+INA+VdB+HoSCHxYpvCCZOtTlFkShAz5qiYj
         eVOgHekm/WyDaAwZQrg2CltIi0otRVEemTW1WYR7U4iZOit14fHQ4ypHvkagx976ERf8
         a2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717161283; x=1717766083;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRY6PDVueSm4bc28YBtX7UzkBLyneNGih9AMbKWTyAw=;
        b=qU0mB7Z7dw9XkYtsJab+g9t/qBf7Nh0r6YMLPH22QBQqeDUPMf76UO5AmPAXpb1mxt
         oHrToQhkfT1mzEDHVXFSarotNtYREi4l0YoGgTcJu4edAw7Rcu9pSzpEKboCDSEC6Bf2
         9yVwPgAJpYmP0CTBSzaEDY9b/Hjk2MyVZRFSnxAgLnDiJctc3hdKemml6H8PjLvYjHYO
         aVTF9brnrJtbMx3JbqtmK2U/iuS6sKE4/gcIGU+52RPp9E4vPL1RGm09T6CrWtt2B4yC
         sbouX25tHePVXYpc+e9k4E5LAC/+ELE0gYNXLbmf485LlheKWu1n4vmDhptdh8aAxV0c
         eO0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8aDD4M3+V4u320p7+A62tLfPDUcmTxfoGcSUNgoOwaFAzEyfigvGBDUKZsjZ7WeB9U7nZ35Nm7gYmOY/EPqBSFqkPqtRVCQXsyp77gINn2l7Ct+m+AtdrmbWzkxVPTYtNPIXzvwSgLms7KYbnJmnlpyMwiUBEh9SjR4/Okgvt9mCU2NJF
X-Gm-Message-State: AOJu0YzE34FXxGGeMsUFQb+K1d9xPXZsO8gTFecFikt24PZDUCY+azEt
	+ORN3OjACSDHN9/grgQd9jGtcCS9mPyVpf/3ejZ7l26Ts3Pqcz62
X-Google-Smtp-Source: AGHT+IEvS7K/3YZX6M7zUKSA+YAdWbF6S+Ctb4rYjul7heDSrPdwNAVLnMVx//yz1f65vREYlCqIHQ==
X-Received: by 2002:a05:6a00:230a:b0:702:28b9:5922 with SMTP id d2e1a72fcca58-702478c5f1bmr1828710b3a.26.1717161283272;
        Fri, 31 May 2024 06:14:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b10374sm1349508b3a.183.2024.05.31.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:14:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea135424-841c-4a5a-b881-a3295d87b64a@roeck-us.net>
Date: Fri, 31 May 2024 06:14:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
 <20240531093154.rna2vwbfx7csu2sj@ninjato>
 <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
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
In-Reply-To: <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René,

On 5/31/24 03:01, René Rebe wrote:
> Hi,
> 
> On May 31, 2024, at 11:31, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
>>
>> Hi all,
>>
>>>> Wolfgang seems to think it's important:
>>
>> Wolfram, please.
>>
>>>> https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxllsdxsz@wxzynz7llasr/
>>>>
>>>
>>> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
>>> think this is needed ? Note that I am not opposed to adding spd
>>> eeprom support, but I'd like to know why I am doing it before
>>> I spend time on it.
>>
>> A working eeprom driver is needed to get 'decode-dimms' from the
>> i2c-tools package working. Jean reported that EEPROM access for DDR5 is
>> different from DDR4, so it needs a separate driver. And
>> i2c_register_spd() then needs to be updated to use the new driver for
>> DDR5.
> 
> Well my original downstream driver already had eeprom access:
> 
> 	https://svn.exactcode.de/t2/trunk/package/kernel/linux/spd-5118.patch
> 

Yes, but you didn't send it upstream, so I took it, fixed a couple of bugs,
dropped eeprom support since that is secondary for my use case as well as the
out-of-tree parity code, and submitted it. I'd be more than happy to let you
take over if you like.

Thanks,
Guenter


