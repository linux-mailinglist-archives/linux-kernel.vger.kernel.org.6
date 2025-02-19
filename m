Return-Path: <linux-kernel+bounces-521943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D1A3C42E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009B53AA359
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040F1FC0F5;
	Wed, 19 Feb 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOett3/y"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE371EFFAB;
	Wed, 19 Feb 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980328; cv=none; b=rchm5f2SjTEp3K/xw14lydVSfzgDH6nje9uEncV8LtLDD/ke/rnVf/+TL5iGxE/OojUj6oiPy8lD1JpyvOPlqtN4NiH0JSPzSdpkQo0hZWvo+63n7KHwGOlgVZEZXxZdTPFKQ6USrDR9R4zRGa4rSIkh7bcgsl8MEizCIo/VNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980328; c=relaxed/simple;
	bh=LAnsK6LosCmR3Q5sroUbUdru/UW8IBuyDt8wliL0qcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crc8gjqAA5489WTLXBWqQ1dbmo2DH2dFyd5YVRnCP0gFMH1+NUhe5Ote4FMLSvs7B3kQ9dn/D8Plj3YsSeiuETA0ImvhQsx0RNvDxT3+V7a71uWM7Hr0aiUugD5Pa2FUXIMGAgpYerQyN5Gd95lY27Skyy+gqc8RK+TyTKew1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOett3/y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so87753595ad.2;
        Wed, 19 Feb 2025 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739980325; x=1740585125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ILKPl0SNay3a32+/RRSyxh1SJEExDN/cTqsidRAj8PU=;
        b=TOett3/y1sjSnA3CjrvxLtqf6IUdiThvaQCSjO6LRffH0PLBwR+IX3vZ8Xo0KgeQys
         d+D11OXWZSOfLxTQMjke6O/x80a7v/ETVXlS5qg7ZAY9E1Ma491ocBgBY92Ssiah0Ryt
         uzKM9wBWav1QKXtd5+GCMlQ3+3+SSteasfErgwUy2QL5lGGI2rGjlR0ZvQyJRiA9uhHj
         IXWWD/7zNfF3qkLDqUhnxvTprpiJlsvx9nLioMx74hPBbxp31N8JofTlXU8wIzMCGoED
         kqZwkdEFgPDIXtHEV9Cx/qd7YmeayUdc8UbWOsALVEpUP75sKEKgihxu4MuRcPX6ddE8
         kI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739980325; x=1740585125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILKPl0SNay3a32+/RRSyxh1SJEExDN/cTqsidRAj8PU=;
        b=UAHdg9wTuzOTR+FW+43JgJXH0jZ7/cKP2jc7rFn8wYpIKvJY++2FO6+e98W9mIGefv
         OjqPY0LIJCz+ZcLt+dsX80sIlsojGpGv89AN6rTr541P96atiRqpiw8kHY7GDHdLZHk6
         04C+1B2/PSOE0iAAsqOVo+LpPPYMORSN3GkRyY3EXz/WgNvrZkU8aJxFI2iD/QoMpzII
         gZvpLpKwesr8YTU6rvKttu+SNK6XXl6tvWt/pUrnFc/gdCA5SdCE+0JTNNOJUGUfznnl
         sgaLNrxhldXC7AbHsvted9FZYyoFdA10UbN/Unq2b2Qu3jkXTswsf83wlHskLVlDFxvO
         9jmA==
X-Forwarded-Encrypted: i=1; AJvYcCUTkUF1wpQGYgIHGchp8azlvc9F54+QI1GzUY+Ki3zLnEZfPYrZVbJW8RHBvXBQdALQF3FgNlISTfo3w2s6@vger.kernel.org, AJvYcCUqqvJGmhf2qTNh9AoARm4ElwfGTDfQSjONk4aKIW8ma9/882B1+MaJvtwy6isdjwYUlE0cBlqafnY+@vger.kernel.org, AJvYcCVPUrikS7Ft0dMcHfRVaOqNVaroOHNU7Wlv8bx61+qCpbnAxBxEImT7FKi24OqBZVy6KRyYcE03BN5/lcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFa97oXUIf4IKvIEHw794HyL4XVHOGtNxJOSWlC1iXb9u9z3hH
	8/IzWsFhvyOCIEd/DBkFfPF7Vg9S+ER60zaeme8Ma0WDlY08HhYe
X-Gm-Gg: ASbGncs1xyBK1fRVINCbGxF7mhC3PH4huqVnU4rcxEF9Tvtli5BLFHPehaKhiZ32kUz
	iFQiE8lMVqibLK5jPyxUQJyfeN3tyfP31GbXsGTwkJxPaVJWWuGD90TJXULcALzhVmUC92gLWOX
	+BZizSyD8aqpcqwVTUteHMo0hJWEi9hBIEcwjTs7SCdmrsj/A1KerHia9atjgvGjtMcsu+2mUV1
	NjMxaA9o6HBXA2ozaokOtqNEBD33Ky/ZOpZ+k4wbH5365QI5lL3OcG3P9b/yLh/1VGS62Y4uctI
	n4ZvT3E6pHcVcuBnOfpUiuKGRh4UV7UIAsL4vxhwtDf4YIG7pKK3t6Ec49sJnFA4
X-Google-Smtp-Source: AGHT+IGW8+CBVhv4LqCaNkiqyMeXKPeQs7b+MCMYUpO6R3KWdsi8G6YGkHjrQBMgwy6+AQ9im63ntQ==
X-Received: by 2002:a05:6a21:789b:b0:1ee:d2d9:351f with SMTP id adf61e73a8af0-1eed2d93688mr7526340637.42.1739980324740;
        Wed, 19 Feb 2025 07:52:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dee4sm11119348a12.14.2025.02.19.07.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:52:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ae40d143-a5ca-4a38-844f-ca58a06834a5@roeck-us.net>
Date: Wed, 19 Feb 2025 07:52:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: emc2305: Add YAML binding
 documentation for emc2305 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, florin.leotescu@oss.nxp.com,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com, carlos.song@nxp.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 Florin Leotescu <florin.leotescu@nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
 <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
 <fd70f78c-68a5-43ec-9eb2-3f06c5d7a20d@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fd70f78c-68a5-43ec-9eb2-3f06c5d7a20d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 06:01, Krzysztof Kozlowski wrote:
[ ... ]

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - hwmon,emc2301
>> +      - hwmon,emc2302
>> +      - hwmon,emc2303
>> +      - hwmon,emc2305
> 
> Nope.
> 
> Was it ever internally reviewed?
> 
No. I intentionally do not review bindings because I notoriously get it wrong,
and instead rely on DT maintainers.

I agree though that this one is really bad :-(.

Guenter


