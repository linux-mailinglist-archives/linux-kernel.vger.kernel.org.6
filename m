Return-Path: <linux-kernel+bounces-196841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BF8D626C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3322228382E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE7158D88;
	Fri, 31 May 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dof9dUSw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED8158D65;
	Fri, 31 May 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160962; cv=none; b=oI+jNEafg8EG2iugHIthtvCeuxlN3TRXdS9xzIKVQIIaYon+PHLAajkAoi/b6jtq5mZs76lKzZNA0ubSF9iK4JMzOQSfBaT6H0fWKB7sEzf7YfcOyKg3eiu3v6n7Y/HYhTRU6XXneTS4wYj+8mHWtuihUlgD6o0fJc6DSIjKXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160962; c=relaxed/simple;
	bh=eqt3kXyBgKx13IlxhyjFv4MvqEMrIyaxkSA4WNsVxGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZCaDpDc4/yR5W8BPNDKFxeDBoxftEDcmCXC0w6y0UgrPvOncRuB+TJPAqk1r6v0h2iyNjpbXRIsMYzmrnESzJ8S5TnphICstP2AFAruVgMgIUPdWZyQHjvbVgWxPbe69gb24Sn03j1VjARRzzxOZ1TpVwpAbW0GtngPphtHKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dof9dUSw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f3469382f2so14982775ad.0;
        Fri, 31 May 2024 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717160960; x=1717765760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tVm235OTCAmN49RKAWjBWC91AtK2vkpMl8EB/K7SIKs=;
        b=dof9dUSweMXdejSM/0y06L6WR4PDMQ4y57ZoB+5HGD64/V0uRHO2RcHOdhgY6b9IV3
         hs3dB5l6prR96TMTjnxQkqO+0upJQSdx2Lx5ji4bQXRxXK9qLX2D3Nz0hh6/b1isbohH
         0GBZPDDyUkzkoWENVvoPUah9YKPBhv3QkMMRwHluDxcSROoCWW/6/Vuijkg1JZ1aS6oM
         5W6MzQ/pmtzZXcVCsixhKbjXstv9GYuSJxkBEWiCRftws/ddCln+3ZGP4csLyTYrJCjr
         gk6HmhDx83iZs2HWVanrRhFPi0aZAGzHEtlEt26rvoHQZsW1HEctqbBjQEbE4EIcXDTc
         TT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717160960; x=1717765760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVm235OTCAmN49RKAWjBWC91AtK2vkpMl8EB/K7SIKs=;
        b=GlgfNA6xSKyAPI2Im8YCmH/+q27FcWQ5IiJWj31BaPYJEJWWcGvDTe+igi/6ZZlQkG
         bkw5zHmjs1o8MYch7RU3nNzHeatr9Toxm6tYm6e3r6sr/ie16Ls/0hdr9CEmIrgaQlqq
         AVM9eh3AS3xlzdGnHAOUR5tI/IkrwgEOaREJO2pPjilxdK4GNN02tPOTZ4FURcFFYEKN
         /LGvj9+qxJ/ZHG1DJn80Aw78d/1j/yhXnmpOIB0vpVsu50q0LehgM+Pg5H1F9IC1z8O7
         uREyAhFhA9Jng94xXquXOr0FTrfGHHK3pqoLPA7/42pNCHfF1eHJdgkeuNKhlrNNcgXX
         itfg==
X-Forwarded-Encrypted: i=1; AJvYcCWtw4iJuB8IKA1mk/+Sl7VyN/TZlu+6GqvsfxW+sh7ebRM8F/3g1EYBYnobCjRr3+JEXwcC6OjJhjfFbf1O0u1M2vHbxqzi+IyvUrX3SFo7ZZcb6iQP2lE5DWBTW70/kpVcqcLEZooM3sQ=
X-Gm-Message-State: AOJu0Yy3hPWs23kJjVALlD8thZf0uz4DCj2DlJ2/msUgfrQUDJSWtA0p
	1oEkSwFaztYrgwp59ZEAUENhsBVI/pYm0TsIPYtKn8hWkk1PcFzH
X-Google-Smtp-Source: AGHT+IFJCQ7OE9r4J7/aU8lfm9w/sKHjDMT7vR28uo5qPn8rwTjtvmUbe/TR1dKCmEV8ILN5Bpu/jA==
X-Received: by 2002:a17:902:f652:b0:1f6:3c4f:2927 with SMTP id d9443c01a7336-1f63c4f2cd7mr17263485ad.38.1717160958551;
        Fri, 31 May 2024 06:09:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323eb910sm15982045ad.199.2024.05.31.06.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 06:09:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f53deeb2-bc08-4363-b8d0-ff3987409ca7@roeck-us.net>
Date: Fri, 31 May 2024 06:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: jedec,spd5118: Add bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
References: <20240530223939.1027659-1-linux@roeck-us.net>
 <20240530223939.1027659-2-linux@roeck-us.net>
 <0ee11044-8dfc-4589-96b5-fa1f906928e5@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0ee11044-8dfc-4589-96b5-fa1f906928e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 01:15, Krzysztof Kozlowski wrote:
> On 31/05/2024 00:39, Guenter Roeck wrote:
>> Add device tree bindings for the SPD hub present in DDR5 modules.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> ...
> 
>> +title: JEDEC JESD300-5B (SPD5118) compatible DDR5 SPD hub
>> +
>> +maintainers:
>> +  - Guenter Roeck <linux@roeck-us.net>
>> +
>> +description: |
>> +  JEDEC JESD300-5B.01 SPD5118 Hub and Serial Presence Detect
>> +  https://www.jedec.org/standards-documents/docs/jesd300-5b01
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      const: jedec,spd5118
> 
> Why do you need the select? This s needed for cases with multiple
> bindings using parts of compatible list. I don't see the case here so far.
> 

Sorry, I am not a devicetree expert, I don't really know what I am doing,
and just copied this from some other binding. I'll try to find a better
example. Actually, I'll just add the binding to trivial devices.

Thanks,
Guenter


