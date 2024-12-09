Return-Path: <linux-kernel+bounces-437995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EF9E9B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45268165C66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C513C695;
	Mon,  9 Dec 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku6kiRgF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECB1F931
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761118; cv=none; b=YPVRurg9yGWcIvDR1Iz/Rv5xbKsbuLB5QFCsqdkpnY/JjIqi5PYEg8k9i6BQQM/rUO4MfH8vPLIKVj9qFZkXjPiUf+sJNqnHl8tdirk54QowlK6lz6H/B1CqZ3ofW9nCZlnqVqDOoCe9qDdwdKjj7/lO+rqFz4/Cu6emuMdKn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761118; c=relaxed/simple;
	bh=fSNCrWFrXEos4egz/pHomrYC4jn5QtpL5TnMYHGA9Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRmZcVvLb4AhSf3YY+GkINT/9/BXADvr7P+W7F0mvUNYeb1HlQPQICquij+8Es0bywcIetj5XZzP1duAtnTfPk2u+gEVubI2XJn/h3KkIVQNI1QJZNlu/98B6Wl9P2VBX4swRnpu1F24BAfqlxytrcjN9s7QrKq5hjLiaa6wK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku6kiRgF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso13472805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761116; x=1734365916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CNEDZCEDJ89V6GT0W/IdPQ4y91lGhI+LxMiGhcLvg5o=;
        b=ku6kiRgFOmlMX/W7vfgStFcB5baLRb+VxXrGpoJf4se4Q8ZUaDj4Z7pmFZIOVx6q4I
         /ZMxJQYuhvNeQSobq1eB2WsZXifxzyFNgkWt84oTj/P+ktTloLgYracn5+lm1guel+49
         WfEo0IV61K7UJcpDQ5klk6ja+5Lo4hDG6fofqac/xDqITPIimcCG2BFoAU0h6L2ti+qS
         ariFp3Bb0jif3o6aKrC27WizsEoFKpqqQyqSwV77k/COJ/1dUSp1T1TUbl9ALQEvwZSi
         O/IXmTMCiJ3sVp81kl7zpbmVm396rGdTZ06bhxHUr1c64+SuuqLllUJdXDxJyaEviXF2
         sgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761116; x=1734365916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNEDZCEDJ89V6GT0W/IdPQ4y91lGhI+LxMiGhcLvg5o=;
        b=Oem1U1/lFzUC9iJzVAyp8NaACs+Fd24t8pt3YcjlKHzMMPrHdOfLMkLo9L8mjP7/fT
         K9xUP3yxQFjdyeibCXCnIbMjnrCHN2uRAdSpBfAwCY9I+/wUrACQwc18wQOIWDBzpknr
         evPdOeHMHfjYOIVEkzIPNeoBB2nzzMlc7peJ2Dreewalz4b4RMrRpnOeYCuttGyBORFo
         kLGwv4T5DT9VV99zSGEZMh5odtea1MTw/DTUJljQdX6M69f29vCPakbBrA37Nq17ckUx
         lE0NaR+B1VjyF0BwFY6n8GEj4vFkv7l2+rZ0zXD7YM8wa0WqcN72yFpoJodC7ncVK3of
         3tmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNT+k7rsB+lRm2EvgO34kXNmTv/egqdXTNk/pLiXntqbixFVzqqnuwCZyXzI9dZ5gcTj7cjnDoupkKQHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHymZmu0GSV8/eT8pIV3ptryODD8MdGsxW0cvKaFsps0vVRhR
	+t7ukVIK5OZGze6q6tU6uPP8p7MQ1Q4B+iS0GvyOve4rm/rrlNHVtAbVCg==
X-Gm-Gg: ASbGncsEGNhAzettjDTwPrHpccNLI4ehJvKx7IOi6/9sAxD3qRclYF2a5NvalHXXgoo
	25kTzQIYZQLK0qC/BZjh8bAOHy0i4DMJ0wbsqk/8aH+Vx7oIAPVvSAfeNJBbrHsZFE9xpcES2ye
	rFsXyFFK7+ooFFHgcgrijNG2LirMelHnoj26Cwcl6RFav5cv8Yh1QJ7eOS2MRdA5bXDChPV4IBL
	FT6dWSDgtZRWD7OjcZ5uXbJQkBzhy3uDcZXqw6AhNd6vXnLiq7U7B0vaOkQBWN8xbouWFrRWqH1
	mkyFQ5yA5CxjoxQGKNP63KE=
X-Google-Smtp-Source: AGHT+IFv7hFtpOtz+AOqw6x/k7hfoa3fCUhVhTw2JNHH71STFUc4FNRpvBQnPTXqWSmRqD3Ama0NdQ==
X-Received: by 2002:a17:902:d58f:b0:216:46f4:7e30 with SMTP id d9443c01a7336-21646f480e4mr81935225ad.43.1733761115435;
        Mon, 09 Dec 2024 08:18:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd49c44e29sm2150519a12.46.2024.12.09.08.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:18:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
Date: Mon, 9 Dec 2024 08:18:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241204162128.25617-1-dpenkler@gmail.com>
 <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/24 08:01, Geert Uytterhoeven wrote:
> Hi Dave,
> 
> On Wed, Dec 4, 2024 at 5:21 PM Dave Penkler <dpenkler@gmail.com> wrote:
>> These drivers cast resource_type_t to void * causing the build to fail.
>>
>> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
>> int which cannot be cast to a 32 bit pointer.
>>
>> Disable these drivers if X68_PAE is enabled
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
>> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
>> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
>> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
>> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
>> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/staging/gpib/Kconfig
>> +++ b/drivers/staging/gpib/Kconfig
>> @@ -50,6 +50,7 @@ config GPIB_CEC_PCI
>>          tristate "CEC PCI board"
>>          depends on PCI
>>          depends on HAS_IOPORT
>> +       depends on !X86_PAE
> 
> !CONFIG_PHYS_ADDR_T_64BIT, to match the definition of phys_addr_t?
>

That would be wrong. It would disable the code for all 64-bit builds.

The underlying problem is that the code uses a pointer to store the physical
address. That doesn't work if sizeof(pointer) < sizeof(physical address),
which affects systems with X86_PAE enabled. I have not seen the problem
anywhere else.

Guenter


