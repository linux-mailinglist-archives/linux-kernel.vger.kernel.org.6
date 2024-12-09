Return-Path: <linux-kernel+bounces-438020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E5C9E9BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD08918857B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E413D520;
	Mon,  9 Dec 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpL5e91q"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A387BA3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762154; cv=none; b=EEQ/77XsOzq26zPIV0uVohW38ha8f417jB66YnAWTV2afLWRHoG2kMBKBekhsF1omNF4MSB4US33Gfd0Us+UfDPpNB5zl3Xf0V72Xfk9WgS+H/8ucUFHW3rw2E3k1SsvRgq8Z0aj/Kjq1yA5DPm36byilHOibvVN8ec7qAlDlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762154; c=relaxed/simple;
	bh=NhxF+okDJajDLMdR8AxwdmDd1vO3lqeLb5pDI1pE6pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtZfU63/ArhuLpS3Wj/snyPP9aHw+yCXoBW/8ZXsu6NhzYQjGb5zeBZNA3QKrpmG1wFCyWaqwO11d8X+W53Dr3JwgK8jFuf6VJ/ZtoaztdfZybxlo0yvEoSJrIP9Z5lEhkaPgOo7nw9Dp6WGp9EmI1tc2Zcfz4q+BXOJTrHypvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpL5e91q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644e6140cso13334765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733762152; x=1734366952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5en3TXnHvPZeZRfF0MQab9m3SG+CXpNk9+5CBNpxusU=;
        b=MpL5e91qlVQIUXVa2uGnyIWaD55QUbMBqHcT/PUWebrSNTM1HPnWKk/sOPf6WNUzW6
         cyZAI33Apc62ThjAoZnZW76pQNwo61RA/bR3PI4QOOS1VXfaipSj3XRi+vdIbk3CeH1q
         sU/e7LutNf8uH28gg5Svr4RnDHUl9Pu1J2jaBWmsUiV4fEyupKvJmWFiI4uVqCuhTIis
         9EhEKEAzHCTsxwVZ/r5er+kPmTKtkxLtBrfYzUuunvifcYIdIEq7AgjWQTfoGnXVXTaI
         /Ss0wzdcwJ8PStAN/QZpBBxyrQUv+PC0xmLTIY6x32A2Z/sma5UwjBS7ijGbVbD/TWnP
         IQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733762152; x=1734366952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5en3TXnHvPZeZRfF0MQab9m3SG+CXpNk9+5CBNpxusU=;
        b=BY4Ef9uZuWTb3FHQK8H7hPo3RsAp73ZV/UF5zAyFtC3Sftbs7KV7axar6wG9zYBvVw
         YqGkxnF09BXG2dpFsq6KlyS9ohkUfbQ0tnEI5/JZIJ2qg3EnbxNMmOYhLj8LNKzw5bt+
         fvH0GDI0GrQkuzsl/QwcA1/McWp9LjBoDjmNq6IoBoCdkdYl7XB+mX60nnwQXkITO1Rn
         r+xtV/alzmDq3ByXXYH2vmoDfcS9+dWskjhY2+dL9W/vgjy61Jx8kpWhEHMuK3Z+zc7P
         4pQT1J+cl5JuV/7dQLdCcvBFxj6dLsKaSksIykQfPrbesQvweZqUjQea1VGUn/l3KBV3
         RgDg==
X-Forwarded-Encrypted: i=1; AJvYcCWgoA14R8tvDpsB6ynWo/2mm/0PzzGoHL+uBGWJgQ3SPi9LZO/2fS/eXESnVIodkaRetUkBXg2j4QCKyqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/H0qub0tUALrQ/o+yeO6wc1jbrKcmfHh15zxZrgeWJj/5S2y
	Kh2Dt2mMTqd3XfET27LJ81HEmcMopafdRbQMylwEu5dUz//XP0xP
X-Gm-Gg: ASbGnct2kATJU1xkcuoicWLpPqH2mK8GDw3MquZpvzpyVdakIEIs/HvMslE38+RGrkH
	ueaVil6J29YIDP+QZRUN4cPrsm0sDMmcTTlyq+nSoYfUC6f573AJ6yxTAGweoB/2eSB7/f1ygqG
	8zMCkPb2b1Ey1GQw3A/3evyNCdumOuX7T5GrzJfRDAvwQEggRpzL3MN22ApdmY7UpGDDddBNYaz
	OvLoeOhJ4O5vBgy8OSTcJ0FdY6v18aj3D+KDikZDqNqUpXsBmDTlqSkJvahg8gAAz0vLPRVmXZq
	G3Eqli5zKrc+WW1WFoCXV1w=
X-Google-Smtp-Source: AGHT+IH7T5xg09G4nsUqTIaMfMXbM5iVvJtlDat4DXzffhQMf2FW9J1E/EhqC1k43SSfHYj6CSNKsA==
X-Received: by 2002:a17:903:2443:b0:216:643a:535a with SMTP id d9443c01a7336-21669fefe5dmr14639815ad.20.1733762151784;
        Mon, 09 Dec 2024 08:35:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21613889367sm59052835ad.51.2024.12.09.08.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:35:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df869e76-4862-46cb-8b12-c346687cfad3@roeck-us.net>
Date: Mon, 9 Dec 2024 08:35:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241204162128.25617-1-dpenkler@gmail.com>
 <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
 <CAMuHMdVsmNqZhqxPu1iMkZUqyGUQqyY1ae01JAkE1-AQbiu5mw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVsmNqZhqxPu1iMkZUqyGUQqyY1ae01JAkE1-AQbiu5mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/24 08:27, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Dec 9, 2024 at 5:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 12/9/24 08:01, Geert Uytterhoeven wrote:
>>> On Wed, Dec 4, 2024 at 5:21 PM Dave Penkler <dpenkler@gmail.com> wrote:
>>>> These drivers cast resource_type_t to void * causing the build to fail.
>>>>
>>>> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
>>>> int which cannot be cast to a 32 bit pointer.
>>>>
>>>> Disable these drivers if X68_PAE is enabled
>>>>
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
>>>> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
>>>> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
>>>> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
>>>> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
>>>> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/staging/gpib/Kconfig
>>>> +++ b/drivers/staging/gpib/Kconfig
>>>> @@ -50,6 +50,7 @@ config GPIB_CEC_PCI
>>>>           tristate "CEC PCI board"
>>>>           depends on PCI
>>>>           depends on HAS_IOPORT
>>>> +       depends on !X86_PAE
>>>
>>> !CONFIG_PHYS_ADDR_T_64BIT, to match the definition of phys_addr_t?
>>
>> That would be wrong. It would disable the code for all 64-bit builds.
> 
> Oops...
> 
>      depends on 64BIT || !PHYS_ADDR_T_64BIT
> 

Yes, that should work.

> Assuming the driver actually works on 64-bit?

No idea.

> Perhaps people keep an old i386 to control their GPIB gear?
> 

The code does not depend on x86, so presumably it could be any kind of CPU
as long as it supports PCI.

Guenter


