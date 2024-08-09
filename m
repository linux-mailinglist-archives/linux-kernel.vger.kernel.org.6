Return-Path: <linux-kernel+bounces-280438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0B94CA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BF51F2332F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A16D31F;
	Fri,  9 Aug 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="peYTN0NF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943516CD1A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184964; cv=none; b=t5VF/KwjtRuj6oLciMHAB0wz7gVmK73AqrEbGoeURA+djnivSDfzz568VSl1GP/uwIC19+VwNyc2xj6cSsZTGPs9n/HIdsi4QkeENOcYp9zpfrkbrIbjAa0aEAaZ95x6+vRuLWRaldxdoHigONlOE27N2tehC6h1QPrTiqajDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184964; c=relaxed/simple;
	bh=qvpbFtmY/ki2GI1uWwjSh+qxSPj3FgUENtOITCdjfm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO6mXRKnT7ZpPPxwz6h5rNPfY8YzoTShHRzrmUpfCFtvx+CYX+fYovHFOYSo2sURY+M5faIYhVJdfillIGePfdwBtFwCCoxdItY1zXVqhpPy2w0FehVuRMuISIOFMPBRmLyln1BgK/NNjfxNtvREaLIQounzO3S3Qm2zT6mMKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=peYTN0NF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so279887766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723184961; x=1723789761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttC+1PaF0ZwcJ1arsMSLD6uLKFV2ZfWm/Rhj6c+k6zI=;
        b=peYTN0NFhFgf6bfbNbJIuVlBIwJ97uINJSfm8ztLPVzwR5DtKz7M1kEBvyrjwLDE1O
         Rws0gmvFM9VKIjoqWD7sBJnS5yv/ZJmuUcwSwHQpSgljfLaw7GL4K7xo/AsguHgIH7dx
         L8IP+qtxLx7lulEnMDd1ovZNtpkv58eGKNZepjjqEUFOOun2dF/4O5UImFm5RYbatPf9
         kBpLwk8L1HFNdLIK/OoxhZycy6fBeTI0mH2zNlVbNbqaOAau80YlBrhdYu2jMecPPkdT
         7NXobCnIOqn7dU67SrWAFJKCv8rAqLeKyWW9nLjDbuvFFhHBVyionTv7MzjYLWHL5cmi
         F5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723184961; x=1723789761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttC+1PaF0ZwcJ1arsMSLD6uLKFV2ZfWm/Rhj6c+k6zI=;
        b=w91Xz1zoUdWl4EwgLc0+BM+LwhYzcTeSLQgOlpQkEDORIdZ7fza1TJpiAJMB1QBu+t
         QY3RLcFA+5BACVw0hYk6pdBhD9ZjlW0aCPAaCU+xAO5Si3S+tVrkhVb+F+t8w2vItLku
         24Fl72qHcBOFa7zdruXmfIpVODsOprpXp7/xy/qVjkrz3vkh6QGaesD53xw0N8WAWHmx
         K1bL2YVufDwuICDqpSQHje1XupC+nHoYCZo50/cqszdKoz2XYRZ22Fh/A9MFhOjjwzfT
         6eWHu2lbT/8c0xgrxKyRovCxapmu5pcqpAmDYVGU6jpuWkxSVhQqWwc6aX3WECOgQPBS
         AdpA==
X-Forwarded-Encrypted: i=1; AJvYcCVLor8sPu5Y/dhf1n9DHPSroUiYfEAAIY8soW9Bm1FiMb4zyM6cfhb5tDcb7UC8KNhxP4CHYXagUi0fLNm+gqXIVWHWhwmUZlBmlYEl
X-Gm-Message-State: AOJu0YzDuXAt75x0Wma1Moj3bSzRdXduG5l8+WRb+Fx5eVHAShGbwZnJ
	2/wv6bHDkxXtHowhxIh0KxWBP/IBKSU7HJkZXkXBfnLnbqGR+DhcNGa4dNNSQlE=
X-Google-Smtp-Source: AGHT+IHn91yTtxdiFLGjMBp8Q9AOGhfmakKBLnjKcJSGhqNNNr8lDAE3/RoU+AZcnkm3AXka08ZHTA==
X-Received: by 2002:a17:907:7e84:b0:a7a:b18a:6c with SMTP id a640c23a62f3a-a8091f19b40mr357318466b.16.1723184961354;
        Thu, 08 Aug 2024 23:29:21 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c7bfsm810220866b.70.2024.08.08.23.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:29:20 -0700 (PDT)
Message-ID: <026fa7ad-f8d2-49a3-8a1a-0efdae343504@tuxon.dev>
Date: Fri, 9 Aug 2024 09:29:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: Rename node, sub-node, and clean up
 spacing
Content-Language: en-US
To: Andrei.Simion@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240723131228.189308-1-andrei.simion@microchip.com>
 <89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev>
 <4a8c31bf-7524-4f8c-b998-701b721f5001@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <4a8c31bf-7524-4f8c-b998-701b721f5001@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Andrei,

On 08.08.2024 17:25, Andrei.Simion@microchip.com wrote:
>>> diff --git a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
>>> index af70eb8a3a02..60560e4c1696 100644
>>> --- a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
>>> +++ b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
>>> @@ -37,71 +37,71 @@ button {
>>>       leds {
>>>               compatible = "gpio-leds";
>>>
>>> -             power_blue {
>>> +             led-0 {
>>>                       label = "smartgw:power:blue";
>>>                       gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             power_green {
>>> +             led-1 {
>>>                       label = "smartgw:power:green";
>>>                       gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "on";
>>>               };
>>>
>>> -             power_red {
>>> +             led-2 {
>>>                       label = "smartgw:power:red";
>>>                       gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             radio_blue {
>>> +             led-3 {
>>>                       label = "smartgw:radio:blue";
>>>                       gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             radio_green {
>>> +             led-4 {
>>>                       label = "smartgw:radio:green";
>>>                       gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             radio_red {
>>> +             led-5 {
>>>                       label = "smartgw:radio:red";
>>>                       gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             internet_blue {
>>> +             led-6 {
>>>                       label = "smartgw:internet:blue";
>>>                       gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             internet_green {
>>> +             led-7 {
>>>                       label = "smartgw:internet:green";
>>>                       gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             internet_red {
>>> +             led-8 {
>>>                       label = "smartgw:internet:red";
>>>                       gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
>>>                       default-state = "off";
>>>               };
>>>
>>> -             heartbeat {
>>> +             led-9 {
>>>                       label = "smartgw:heartbeat";
>>>                       gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
>>>                       linux,default-trigger = "heartbeat";
>>>               };
>>>
>>> -             pb18 {
>>> +             led-pb18 {
>>>                       status = "disabled";
>>>               };
>>>
>>> -             pd21 {
>>> +             led-pd21 {
>> Why used led-<old-label> for some leds and led-<integer> for other? Valid
>> for other files.
>>
> I could have done either rule led-<old-label> or led-<integer> 
> but we ended up with the old label being quite long.
> So, I use led-<integer> when <old-label> is too long.
> I don't think it was the best rule to rename.
> In your opinion, how would it be correct to rename these subnodes?

Keeping old label is OK. FYI, these particular changes were already
integrated with old labels being kept. See
https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?id=b39c457205d0a3513fed1c3863e7cf9b6d72bf86

Thank you,
Claudiu Beznea


> 
> 
> PS: It is a problem on our side with the mail server. The e-mails may not arrive on the linux-arm-kernel mailing list.
> 
> BR,
> Andrei Simion

