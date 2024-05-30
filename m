Return-Path: <linux-kernel+bounces-195487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743E8D4D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D621B24139
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4B1DA53;
	Thu, 30 May 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFN6lXNN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B574186E39;
	Thu, 30 May 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078063; cv=none; b=krcZDddMnYU8Y1DoxX3QYSOEwzMtvVf7kjBiEscNipqbc3Au31T7HQyjRTyiPT3WmyTv9rpuBblQUiAeDfvli9l1BzYFkoCefb6r5Q+PJPXxbkZrVXua67LQ6trQWbzaYgD/eC2rUJ4aiLfLBoR4FYe9Flwxx00I4MXq32/7KaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078063; c=relaxed/simple;
	bh=h7hU7qbuwVbk/ZpC7LCL/8LlxomxCnLOqgvlLA9FNQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M39bsiyH8bvOtsMBY0lxUMq+VX/gdLDi96byvCmqR5V5f6wsEn+FIdfK6Az23ncqfjnT9/FajHTKMK1Ce2Hfc6MqDpuadutZ4YUgsW8hlU4xUaLLRxWs6G4AmB/L/5o+BDGu7SoidsQ6BCHWsWTqyY/Wk4emzphW3ta7hZVnY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFN6lXNN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0fso7443585ad.1;
        Thu, 30 May 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717078061; x=1717682861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u4GimzYAy1i6fno73Dy7LKKA9+QvH6ceArd5s19dZ3Q=;
        b=QFN6lXNN8if9zSpTw0wJ7ERDb/f/q2rAxiS13RNNsgHPQsHZRrZ7uZKTVa32xcyzBD
         DwmBsgIHmyRwRY2Ly2r7bbgqMUkGw7x/SySi+kyjT/YUxnkHdIGa94FQJ9o6cKZf3QDa
         +veoutHYK4IdffrKiYIy2n8dF8xAXk69NPR3IW+bkdK0etoKu2aWS5W0k5kamPRat8K6
         ft9H/Gd4ZsvtY9j9XmeJiYNWCLbxwPo3AqgdB+pMqLFr/58Ey7C/p8+7TLbmRJ3bwuG6
         IgIG79JfHn0pfHAPPpcZyxuLP6oVlLDQMVPGejQjKJsmaxXBdPYQAeUPtFe6ZeM0w95c
         0MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078061; x=1717682861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4GimzYAy1i6fno73Dy7LKKA9+QvH6ceArd5s19dZ3Q=;
        b=Zh+OZsUwInSWWHxtdlyiVbiPefS1LjGFD6710gk5pDGEgB8QsKBXL1CBcGhwpwMVMx
         C5dbeBqAbidj3dH2+R6ro8Med7RRFd/nCcj33sNH/WNNHCsTaEq+VOIZvVyX+LQfn1gf
         qZwZwpcHR7+iNv0N7k3pDjxFbu0yGbIP/XUlR7PRVJhBtmVbCWYUbHaMehtFazeDIfj8
         ABoGoOyJ4LYQ82eLzdei7WWO9QKudI3nkJ2wtqpaGQzpwKxuAW1DW5QhAvDsatYAI0Ei
         6qpMNBExra3UiS2X8KZ7DSg5C8k/wzs++iOiz6f5TqG2Edmk50Mw5djOlaVJJYDf+o1v
         ROTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUILjmxMpafWxbn9AH0s/miVk3hEOHc++myGhVfXyEdyuinZJZy9x8EuDXaOxMDm0q8GWQ5ytlfXCqiu1kH65EmzDttqJaCtWTv6v2Z2rskYckdbIquyA/7SDnUeU6vglydOh/17Flskg==
X-Gm-Message-State: AOJu0Yz/XsO/1EsRMqMROswJQe7alAN/X8PvWUuLt6PtEJtY2Q5buFuF
	JsUS4v1M037Hbhq6tVLMb1YA+txKtRCrGMgzB3fn5yPsovOT0ZbD/jP/FQ==
X-Google-Smtp-Source: AGHT+IF+NwkLYoqUUkxUSa66EEz/TnURnDEyqNPbWe0h19CPeb05BMbtjoD0ITlOoaofTJ79xaP7Jg==
X-Received: by 2002:a17:902:e5cf:b0:1f4:a3a1:a7e9 with SMTP id d9443c01a7336-1f619605f60mr26066885ad.24.1717078061343;
        Thu, 30 May 2024 07:07:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9b87b4sm121997815ad.264.2024.05.30.07.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:07:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <468905cc-151a-4513-84a7-712684aaea68@roeck-us.net>
Date: Thu, 30 May 2024 07:07:38 -0700
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
 <6d5c2ee5-6e0e-4d13-a977-493d2ee2c0ed@t-8ch.de>
 <9c7e050b-0e73-4388-bc58-5c4d3ed4f50a@roeck-us.net>
 <1258a064-e23f-4079-b1f5-59017c28a210@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1258a064-e23f-4079-b1f5-59017c28a210@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 06:57, Thomas Weißschuh wrote:
> On 2024-05-30 06:47:17+0000, Guenter Roeck wrote:
>> On 5/30/24 03:51, Thomas Weißschuh wrote:
>>> On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
>>>> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
>>>> sensors. Such sensors are typically found on DDR5 memory modules.
>>>>
>>>> Cc: René Rebe <rene@exactcode.de>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
>>>> (Corsair Venegance DDR5).
>>>>
>>>> René: I included you as MODULE_AUTHOR since the patch is derived from
>>>>         your driver. Please let me know if you prefer not to be listed as
>>>>         author.
>>>>
>>>>    Documentation/hwmon/index.rst   |   1 +
>>>>    Documentation/hwmon/spd5118.rst |  60 ++++
>>>>    drivers/hwmon/Kconfig           |  12 +
>>>>    drivers/hwmon/Makefile          |   1 +
>>>>    drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
>>>>    5 files changed, 556 insertions(+)
>>>>    create mode 100644 Documentation/hwmon/spd5118.rst
>>>>    create mode 100644 drivers/hwmon/spd5118.c
>>>
>>> With the Makefile and detect callback fixed:
>>>
>>> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>>> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> Thanks a lot for the feedback!
>>
>> If it is not too much trouble, could you send me a register dump ?
>> The one I have is from Montage Technology M88SPD5118, and I'd like to get
>> a few more to improve my module test script.
> 
>>From a Kingston KF556S40-32:
> 
> # i2cdump 20 0x50
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 51 18 0a 86 32 03 32 00 00 00 00 07 ff 3c 00 00    Q???2?2....?.<..
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00    ............p?..
> 20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00    P?..............
> 30: 00 f0 01 00 00 00 00 00 00 00 00 00 00 00 00 00    .??.............
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

This is the same SPD hub chip (Montage Technology M88SPD5118)
as used on my Corsair DDRs. Interesting.

Thanks!
Guenter


