Return-Path: <linux-kernel+bounces-253157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68626931D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73C3B21C30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A671428F3;
	Mon, 15 Jul 2024 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbYtuD2S"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08F22626;
	Mon, 15 Jul 2024 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085616; cv=none; b=nAv8cRbH3V+V+Z3jZOKfeF25zMPwh3I76/XkHycASx0kqYwetzK+aBcMbApiMxK9eRqb9ue10LoIzZ9cioBPv8zbMQy6c+kDRBV6sYmT7Bx37pfbaEyxTJTkO6mgKdOcGn6cW9niwpM2YgK5mYzo3Fmqt3DTuoe5YbOZvZNpmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085616; c=relaxed/simple;
	bh=nhK2Yad54ZlvwP5DC02a+I5+/dyDshFWXCqZz8vfAD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qAsgCnKNQr3j0MH2hCoZIDvt9v+43K5trGimHVTKfQgdg1dRsLetxCN2chiSn3XDgv9UVS4UTLU/k4PmOIkWVs1RP3MHceaJ7ISe4+Sx0NaeklqLDJFadXw01bUU6fbrQszsX5a6ZCsw5k21jOkKQcXgGy6Dl7fWshPC8zh6O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbYtuD2S; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44c21981043so27843481cf.2;
        Mon, 15 Jul 2024 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721085613; x=1721690413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yAJAzVQ7ZcHR6l5gG6x8XCpX0hw5/mOe41AhupQI8UA=;
        b=MbYtuD2S5fkjrPY4RB4TkieunC+cTDgn57X2ARGHkpdmTVczEHGN+P8CeQPcE64obR
         IC5Sib8YZQ2ubx+7qwB6rLRJEcgFnLzJ6G2HMVqCs9NO7rJU0PXB4+QnE5wUu7acIFy5
         yhMj+7Yyfh+kq3qRo2X8prrbADxwYKJKFh5QgpQSljcfhZKmX5pCv+rWWi/FdGERag5y
         F3xUh+tEChqW/8/5LkZ33p9Ve74/BH4EYy6HgIcUs1caTP4UttZ5ruGr1LjskbK1FblV
         P8ZGXO3iworoLhyLD5oqTGIPr+fCUp2tiIj6FfyCwLwTZAByjJlwfDJhHjoOTQUfIU7o
         bPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721085613; x=1721690413;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAJAzVQ7ZcHR6l5gG6x8XCpX0hw5/mOe41AhupQI8UA=;
        b=A/hMI7A+lSd1H/8mJulhVw/0P6ORBCsQvQkYRJ9ibE6dtA8PxszKdcCcrQKVo6V0XX
         19eOsR2EBknyb95HyKNyE+dOmZ/9JRvsdCk41/KFHXC5G7m6LzIQSjQ8znm0NhWkEaIb
         GXpv5fBoW5/Vj/7IlaeoLg30SffIdfbxGKR/mSDgWcynNAKFgKkEmN7EoEn3e0h5ZBeE
         tLOGdRIHLRNKzdU8n67AdCsjjpkCBHnmHBwI8ZXA5wZ+P9m+QufXV9lLZ31f4bCVkxMp
         TvDsdC8nRRZ45yUvldNRptwtHIXq2hmngLvU1RAAqQMqjEzaLu9iX4P840zAo1GQD6GR
         w3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX82o/gRdk7E+4ITDvOTHNAgg1mExiWttE79MlviwIeczdJNX0D6yMobQRkP4Kxosq9ECddtFLWbN/HxGujxpKzyz9h9AgJfKCzTw+P9Zk8HuoE5fYG3NDT3GQ9YMhHripyzOih676m6g==
X-Gm-Message-State: AOJu0YzrwrnogBHULgovdNYEmwImymoBKrUBkUMueGc2l33xAgfCV0bN
	DC6rwvkxSBn3ddn9Yz20vJMvYbPds9NFldl3N6Qk3H/C1TQ3ZKRQ
X-Google-Smtp-Source: AGHT+IGkI0cSILOcOIYtx2CQNViNkXxGhAcs8z1IsWICF/vqYiK7pxF9mm5kvPacJ6/rgtXI+wAKrg==
X-Received: by 2002:a05:622a:4f:b0:447:db4f:9f00 with SMTP id d75a77b69052e-44f7ac6eadamr9752631cf.32.1721085613446;
        Mon, 15 Jul 2024 16:20:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44f5b83d990sm29329161cf.80.2024.07.15.16.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 16:20:12 -0700 (PDT)
Message-ID: <d1e402f0-49dd-4b83-8cf6-e2b15e9f7300@gmail.com>
Date: Mon, 15 Jul 2024 16:20:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
To: Florian Fainelli <f.fainelli@gmail.com>, Florian Klink
 <flokli@flokli.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
References: <20240715230311.685641-1-flokli@flokli.de>
 <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <f178aa92-d91c-406d-9fea-1021bfb99f55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/24 16:19, Florian Fainelli wrote:
> +Stefan,

With the correct email this time...

> 
> On 7/15/24 16:03, Florian Klink wrote:
>> HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.
>>
>> This fixes HDMI hotplug/output detection.
>>
>> See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf
>>
>> Signed-off-by: Florian Klink <flokli@flokli.de>
> 
> Assuming Stefan is OK wit the change, I will apply this along with a:
> 
> Fixes: a54fe8a6cf66 ("ARM: dts: add Raspberry Pi Compute Module 3 and IO 
> board")
> 
>> ---
>>   arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts 
>> b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> index 72d26d130efa..85f54fa595aa 100644
>> --- a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> +++ b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
>> @@ -77,7 +77,7 @@ &gpio {
>>   };
>>   &hdmi {
>> -    hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
>> +    hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
>>       power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
>>       status = "okay";
>>   };
> 

-- 
Florian


