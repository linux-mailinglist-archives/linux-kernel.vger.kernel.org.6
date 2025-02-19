Return-Path: <linux-kernel+bounces-520910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55463A3B0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3E3AE742
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF01B6D0F;
	Wed, 19 Feb 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4fBGo19"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47E25760;
	Wed, 19 Feb 2025 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943701; cv=none; b=k55Zi/e8S1k95ZmKNNWmGcnCTlByMmTz/RwOyod2r5fT3Lwkav3ShQX4h5ia9mGCJ1G9Lhyf32M4HRwZsrvJ4YBYxlg0/RnY8tC9zZEYv20+P0A7Y1mi6eQV8kzLvgIb7N4Fcw1dhyghA2xHLc7XDMX5mHyYclTmq/Aaqd/6DVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943701; c=relaxed/simple;
	bh=NH/GYPtUq6MwTSuRGjCkV3AXLDR9tKW3R/QsctmHmpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT2L7V7+K/qgDFHAiEvWSKQNpsIoX1fxl8o1zS2QDxwZpJ30ZlqHGXqnHBe7IAv3SZW6cUPNdM6UebdGIbaMhzn0Ar3lYJhZq/zaEBZpAu+2k42z9RXIqFL70vScKUqXJaP6IC4YeTrWPDYCnzg37fsQbAVoM8hSW6A4+sfbB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4fBGo19; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so89594a12.3;
        Tue, 18 Feb 2025 21:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739943698; x=1740548498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRcsV6GoFajL/k7gPCeavo6eC1d5s36mJUqIVFTMKHA=;
        b=K4fBGo19J3m2615iz5O0KwpPwprOacy3H9DSzOdhs9dCcyX4XiIWejH6VcjCEdMxRT
         vpB7QJMWsnC+Sm5KEKoM0EKFB0OpOGUZVVa1LQJGe8Z3YgaUDuIbSP8qcr2KrPSCmMAA
         VSCJOwaBsBx3YYEOvcxXCKuyAKh7phU1e69FxfvCbTL6POkJHmwOWPz4jkPL6vu6EAyw
         zhOlug7ZV9uGiGk52Nf5aGz/MDA2h3pZTApPy27t+6VU8QZ90ZnY/p6G85zeTwyjdol6
         5VWvix3y85W/z4fgAoLt7bCDOribWlNeJoKBU6M+xcwJC1g0B15jnbB1+PB2jiBiycBw
         fCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943698; x=1740548498;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRcsV6GoFajL/k7gPCeavo6eC1d5s36mJUqIVFTMKHA=;
        b=FFEGQ7Xgmw7+pIY67sR+/PP/2aSAc8HmKeEGDt9/qoFfOr2KC6rHIUPfUP2zMl0oPv
         Sj528AsRe1VD++SPv+aHApDlP4VpIDkagqYKXE050GgVwh1SMUyYyiswe8NXhTQIczmp
         kKwNjubVQTAmvYCCqhwHI4QFZyVgWVL3ojtEhEBPSsnSl4jRCtj8h9N/6IcPoP6/bS+4
         QsnOX3QGTFQOtpvn8gBYTo38cqKqgpdNsbykMR9JujUmNeh8BmsgblnoYgu0lAArjU4J
         b6dABPEwcuYD/ugK5eOpUbofdBbXqwugysDy14tYXXIfWH2W8zvMtRMGjt/Lr1alL1N+
         ot+Q==
X-Forwarded-Encrypted: i=1; AJvYcCULnYBKGNjKhz3EMY5aDnWF55A9c0Y/MsyaPTnaTv9blzlzIshCszaT9oGgeCk7COR+UymBArXpDruOtKrl@vger.kernel.org, AJvYcCXigee2wP9xutSNGK/CnF+A8KoVARgh/GihfXxZfvBhDNyjCz9JpqsofTVT+xeKHg4Qid8tnOJcIzEf@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVCl+JapWuL8G3yv6bXWNeyakPdtaEQghHSQd3EoFyI1sBDVB
	aqqphWESdoTOx0EfuZzrDzhsn0H3Q3DVRkv4j9xrSELQTtVzEraA
X-Gm-Gg: ASbGncuYHdMSActuE53da4EjMRFinXVutnUDgz8nXU8mKBUsxlpFKHRX8QKTTkIzhjT
	ZET+nyWxrIn+Nnk1fsLZ1tYa2cn45oDVosf5SnjX2rd0DLIXAQJqGBX0Kxy39CQ/z/kEm3jNg/7
	oLpgBIE0kq/uxsWjqU4SsrJsDL1JpHtEADeWR5aQ3kvQFbKyYiqPTSBNIdhG/3ZCavx4lH5arN8
	bvtWafXdoXnOWF68XwZl7ENd1Eo7jBEDPd2Cch/ngzeUOehQ+gnYibDYI6f1QSRokLR1UV67I/M
	TUE+1CA0od5Hq5KMYaGWIzOor9YDiaBgC1gzPoU23H/6plQtCWRKnkonnMgHTEadgQ==
X-Google-Smtp-Source: AGHT+IE6McCybXsclJruyebbY+EIZW3bx08t3CeM0dcMArcOBNQnZGaXHD1Epi61kkrMMUgHgWugUw==
X-Received: by 2002:a17:907:7b83:b0:ab7:eda3:3612 with SMTP id a640c23a62f3a-abb70de2909mr1830140366b.50.1739943697665;
        Tue, 18 Feb 2025 21:41:37 -0800 (PST)
Received: from [192.168.50.244] (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba9cf8a262sm904238066b.22.2025.02.18.21.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 21:41:37 -0800 (PST)
Message-ID: <d6f8713d-fd7d-4de5-af71-cbb1fbe0f771@gmail.com>
Date: Wed, 19 Feb 2025 06:41:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] mfd: bcm590xx: Add support for BCM59054
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 ~postmarketos/upstreaming@lists.sr.ht, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Stanislav Jakubek <stano.jakubek@gmail.com>,
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
 <173992516047.2065189.12949590674422169603.robh@kernel.org>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <173992516047.2065189.12949590674422169603.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.2025 01:42, Rob Herring (Arm) wrote:
> 
> On Sat, 15 Feb 2025 10:39:35 +0100, Artur Weber wrote:
>> Add support for the BCM59054 MFD to the bcm590xx driver and fix a
>> couple of small bugs in it that also affected the already supported
>> BCM59056.
>>
>> While we're at it - convert the devicetree bindings to YAML format
>> and drop the bcm59056 DTS in favor of describing the PMU in users'
>> DTS files, as is done for most other MFDs.
>>
>> The BCM59054 is fairly similar to the BCM59056, with the primary
>> difference being the different number and layout of regulators.
>> It is primarily used in devices using the BCM21664 and BCM23550
>> chipsets.
>>
>> This patchset has been tested on a Samsung Galaxy Grand Neo
>> (baffinlite rev02; DTS not in mainline yet) with a BCM59054 PMIC.
>> Testing on a BCM59056 would be appreciated.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>> Changes in v4:
>> - Fix yamllint warnings in DT bindings
>> - Address miscelaneous review comments related to DT bindings
>>    - Note that I did not end up moving the regulator refs from
>>      allOf compatible matches; I explained my reasoning in [1].
>>      [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
>> - Add PMU ID/revision parsing to MFD driver
>> - Fix instances of regulator data not matching vendor kernel for
>>    BCM59054
>> - Use different voltage table for BCM59054 VSR reg based on PMU
>>    revision
>> - Link to v3: https://lore.kernel.org/r/20250131-bcm59054-v3-0-bbac52a84787@gmail.com
>>
>> Changes in v3:
>> - Split out regulator DT bindings into separate YAML
>> - Use tables of regulator info instead of get_XXX_register, reg_is_XXX
>>    functions
>> - Drop "regulator: bcm590xx: Add proper handling for PMMODE registers";
>>    it adds unnecessary noise to the series and will be submitted separately
>> - Link to v2: https://lore.kernel.org/r/20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com
>>
>> Changes in v2:
>> - Fixed BCM59054 ID being passed to BCM59056 function in the
>>    regulator driver
>> - Dropped linux-rpi-kernel from the CC list
>> - Link to v1: https://lore.kernel.org/r/20231030-bcm59054-v1-0-3517f980c1e3@gmail.com
>>
>> ---
>> Artur Weber (9):
>>        dt-bindings: mfd: brcm,bcm59056: Convert to YAML
>>        dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
>>        ARM: dts: Drop DTS for BCM59056 PMU
>>        mfd: bcm590xx: Add support for multiple device types + BCM59054 compatible
>>        mfd: bcm590xx: Add PMU ID/revision parsing function
>>        regulator: bcm590xx: Use dev_err_probe for regulator register error
>>        regulator: bcm590xx: Store regulator descriptions in table
>>        regulator: bcm590xx: Rename BCM59056-specific data as such
>>        regulator: bcm590xx: Add support for BCM59054 regulators
>>
>>   .../devicetree/bindings/mfd/brcm,bcm59056.txt      |   39 -
>>   .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     |   76 ++
>>   .../bindings/regulator/brcm,bcm59054.yaml          |   56 +
>>   .../bindings/regulator/brcm,bcm59056.yaml          |   51 +
>>   arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |   68 +-
>>   arch/arm/boot/dts/broadcom/bcm59056.dtsi           |   91 --
>>   drivers/mfd/bcm590xx.c                             |   86 +-
>>   drivers/regulator/bcm590xx-regulator.c             | 1294 ++++++++++++++++----
>>   include/linux/mfd/bcm590xx.h                       |   22 +
>>   9 files changed, 1377 insertions(+), 406 deletions(-)
>> ---
>> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
>> change-id: 20240816-bcm59054-a880695e41e8
>>
>> Best regards,
>> --
>> Artur Weber <aweber.kernel@gmail.com>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/broadcom/' for 20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com:
> 
> arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dtb: mpcore@19000000: $nodename:0: 'mpcore@19000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> 

Looks like a false-positive; this patchset does not modify this DTS at
all.

Best regards
Artur

