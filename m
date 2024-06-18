Return-Path: <linux-kernel+bounces-220294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3799690DF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66F12843DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC517E441;
	Tue, 18 Jun 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9L4HoTy"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4B4AEF0;
	Tue, 18 Jun 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750271; cv=none; b=LpF2hJeb1fEIAbnXssligTrb1CEEpqtJkrkRS/gAYgWoGcJHSP43/YnLHgkvUkR2PinM0kq4q5OxKBkpzPknXDCmwDnV6Uu7qMSgHGzi5BisPuM5WDG91ZdKlUunL7zJJeI5wG6ecPeuBxszJXPjxUG2TNiCfTB48tQRK3BHDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750271; c=relaxed/simple;
	bh=2XClNl9CDo2Zp+wBkxZ++h9/zWZYh96n8rWm0wdYmII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtoPa/keVqzumBN50J9vES3Ge+PxiMZWqm7iMVHMMcgtNxrzajTSUpp1s1bA/CmAfU7GI5Q4TIMNyLVobEbXRrp6+In9lUepGtXPnQkpBzMlW527HefVJXjEHhtq7TSpUMB0cjdUqG3R74kD+lVsffhLWHKxoMI/TJNNXa762N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9L4HoTy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so4816928a91.2;
        Tue, 18 Jun 2024 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718750269; x=1719355069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gEjtBtRfbNfeo64VvZZkLZuErmN3FoNBHRTu4rzkAiU=;
        b=S9L4HoTyWVc0kWbHVv62w0BZgGJC1dGs4kLURD9hhZs4SgojS8dMiRVtMva5Q8O+Il
         0e8IXoAk/wKmoAW4KW10qovb/+vhITABXgQ51WrlO29jRJvePitplteE9Wdk/k0KFG0h
         1ORAy+PiR0oVbENHMr8o9BJlJc+SvyrNJLvlCxzR6NKcpdv2/YBSD4rnLVroPMA/ARyy
         DnGpwFAnIv7GesZqzsJOluzlwLksCGYlax9VUDO0N78h0AX3iedpkG2b5yuF7biYUK3b
         XCIY3fBbk0W0MVA1KGZmJ+RGqmUrJnn9e+53vGGqN8fpMenPEUzGtq/WKpAD/gcSn1y9
         anww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718750269; x=1719355069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEjtBtRfbNfeo64VvZZkLZuErmN3FoNBHRTu4rzkAiU=;
        b=Z6A9HaD4zqnaeOXqEIAA4jD1hqE0PFMn2g0tIosfcSCdAMjLD+951EBz4dhjHOh8iz
         THGOUFNAIiK9VxuqijZ9BtwoFLsRJaupxIz6ze9i+bySjwDU0qRErLvYc1BndiGVygc+
         l7jWEoRUgJCUhUv2qOg3IcKATv6QuQWoqqUq8aXpqaGludViL/qgbJ4sHy8L1WV8qJN4
         97ifmWPHojBHe+y7o2zbL/raqxHO/Pv63NzVKvje00FiYKlqhyjXdfB0l4qh2dCNf3J/
         wJ+awc8JY+VI+QP7460lBPw7w6hwjq0xCkOGuRl7Q6T6Q/we4Vc/1D15yl+Z5WzsgRRV
         LT0A==
X-Forwarded-Encrypted: i=1; AJvYcCVAzE5ZoLa2/YIGjNm/5AMnNtKi0TvDIh26h0M0q0bC7vIF8vt9nuj3eCcun8IbB3k/Xx2nl3Yzh3eDvrzjyFt9z7fIh+DE8Mi1GEg=
X-Gm-Message-State: AOJu0YxzB7MwuI9C0lCF/t+pMHA29uJJn9h8PapgTqd8h1MKlC+JiGh/
	jsQHCAzm/UNZUA0QtdF3FpDudhNP97wiWGHRz5auBXmbQ++2TBu5JcW/gg==
X-Google-Smtp-Source: AGHT+IFV3oB2qQfgiQSln2OJiPxk1dPG4DUt/viveS5M1W3rMXst4MA7tnnoa2Qh/7pCsmTd2HMXOQ==
X-Received: by 2002:a17:90b:3715:b0:2c4:c2d3:c061 with SMTP id 98e67ed59e1d1-2c7b5c83582mr1154980a91.18.1718750269056;
        Tue, 18 Jun 2024 15:37:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7603200sm13822459a91.26.2024.06.18.15.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 15:37:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6999770-c308-4ff1-b667-6095c83c55dc@roeck-us.net>
Date: Tue, 18 Jun 2024 15:37:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Armin Wolf <W_Armin@gmx.de>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
 <9440d6f5-3164-40c9-95a1-00403b7f753e@molgen.mpg.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9440d6f5-3164-40c9-95a1-00403b7f753e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Paul,

On 6/18/24 14:45, Paul Menzel wrote:
> Dear Guenter,
> 
> 
> Am 18.06.24 um 23:08 schrieb Guenter Roeck:
> 
>> On 6/18/24 13:37, Paul Menzel wrote:
>> [ ... ]
>>> Unfortunately, it still fails:
>>>
>>>      $ git log --no-decorate --oneline -4
>>>      7ddcff2d44ae3 hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers
>>>      e89136743324f hwmon: (spd5118) Use spd5118 specific read/write operations
>>>      0fcc7279f0cc4 hwmon: (spd5118) Use regmap to implement paging
>>>      801b6aad6fa7a hwmon: (spd5118) Add configuration option for auto-detection
>>>
>>>      $ uname -r
>>>      6.10.0-rc4.mx64.461-00050-g7ddcff2d44ae
>>>      $ sudo bash -c 'echo 56000 > /sys/class/hwmon/hwmon3/temp1_max'
>>>      bash: line 1: echo: write error: No such device or address
>>
>> Now I am really baffled. I don't think we could do anything simpler
>> than that.
>>
>> Please try
>>      sudo i2cset -y -f 0 0x50 0x21 0x06
>>
>> That should update the critical temperature from 85 degrees C
>> to 86 degrees C. If that doesn't work, we'll be really out of luck
>> with that controller (or at least I don't have an idea what else to try).
> 
> Bad news:
> 
>      $ sudo LD_LIBRARY_PATH=~/src/i2c-tools/lib tools/i2cset -y -f 0 0x50 0x21 0x06
>      Error: Write failed
> 

I wonder if there is some write protect active in your system. I don't see anything
in the spd5118 specification, though, or in the i801 datasheet. I really don't know
what else we could try, sorry. Unfortunately I don't have a system with Intel CPU,
much less one with DDR5, so I won't be able to play with this myself and/or
determine if there is something special with your system, or if this is a generic
problem with i801 controllers.

Let's hope that we get some feedback from others.

Thanks,
Guenter


