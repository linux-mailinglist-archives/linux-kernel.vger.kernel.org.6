Return-Path: <linux-kernel+bounces-249073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46192E5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2621F23299
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145D15B15D;
	Thu, 11 Jul 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWARLQaH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB19158DC8;
	Thu, 11 Jul 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696411; cv=none; b=cOj8ZHVDorGjPcBRoK0maBg56INMHlZ9vIUt0iQGC8Kw4Qixlp//53aewRNr1vB4ELPbpwRBxqm8pAzAIheuc85PKUl3GxnMVRQuH6gQ8UkUFGhP+hysRtYNzE1znQgBX/BqAMYpzZjOQXmeTv5a53XBjKBNQrlhGBZ7EzDEzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696411; c=relaxed/simple;
	bh=PLXOcxFRD0qIU5O+vYHV3zvDkYg2w5mszApf2Om7rm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWzCAjrZcS2GzOvx8e6M1XCkYJvlEv7IVoxUau53D32LMeCQBQTUdehfZM+/FkbnBEJex61/c75gbRJ2jnESQGEaqW1NlE2gi7oZa/OBDYbhLV8dgyozQocuKbt3rKW9pT5Qx2U54yv6biT1TX9Bj6//5fDVDfc4EH1Cz3lA5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWARLQaH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so921312a12.0;
        Thu, 11 Jul 2024 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720696408; x=1721301208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYllvDYy8q+oSmnbTdjDBVB3IGKqLELFE6rlt3KjtiY=;
        b=nWARLQaHndUqg8cF+lQYPqiKiHAwyxcWRcZjCoLa9mbLdEx5760twoZrANcrI4WGi/
         jviErIUnC3cioh5MyXFyyrDpioh/il/3aD8CAQRyCiRvuXTKqo8OH3aWpYN2eaoCg9wc
         nmZRS/HcPOzFht+pM8VEmL7Tnf7nfeELotV/3fVY21HIl9Jmk4fSg5rhrXhVapygDYdF
         U9jPF3NtvBDsS+VI4f+Ujo8GDRY12YnmqZCA2chn0X1VQ8opnTCTDMu9AOeUziY8crIM
         +W2HTyDrBi7PdSxA+NarrxfzKNPJBhq3Zu+gnYRbJMk9dvXkvFW4shN7+OoEbZend6iN
         wong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696408; x=1721301208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYllvDYy8q+oSmnbTdjDBVB3IGKqLELFE6rlt3KjtiY=;
        b=Dth9nKDuD1fJrFQCTA+kzxCn0YOu5C+OR13wh6tYJnrravN+gPZD6IQo+nFSd8yu/d
         Sgc0NvHztC0hwYbAfuy00yzr4CFhz8BsFZBb/OszdhC0uDvv8pZr3ym+Ts/SobOxjBxe
         gIuCH1JSdH+7P4g0RrSoIIlCPmS3mH/hhn+WFXRgCN7SjRs1TS/P8edb/lW6MP5HB9iV
         RIaTcOSJLh8Mgw5ubbS/9EhStHJgDZW28Zraki5Q1pOqKr+tFN+yn/cZwkCYwQPX4PXP
         QWBm9Tpx+lCAIIlIKgQgvnKT62q3aC+OtOxTkMdGCQNM4ucTfJkhbiVZx/dghoDnYRxo
         NhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrWCdMLUwQbPoOwwOTUdcb+BrpCMeVcHFE3/T+9JUm0OIZYA9xfyDmo8g69gZ+8hmLux88pSv6/1tOoWzR9dlZoe8Af5Q1/VxiYZlO92+SeqYRqhWsk4kay3cizji8tvrvofHq6Yq84g==
X-Gm-Message-State: AOJu0Yxmc68DiH6PHjcBCO3MD3GsOQhm+z+sO/goVgpZLsJ0+1Yx2Bct
	A/zWslEdo6mqHziFQI4MU55ajW+g4s07C23iahToWyNuqYl9L3Q=
X-Google-Smtp-Source: AGHT+IGonB+tlK1s3YxPGzmQfLKujuweNBArj336FWhMTOeocRhQSO/drBcmCkcDCewxEfe4XLuMcw==
X-Received: by 2002:a05:6402:1d13:b0:58f:90e0:a1d0 with SMTP id 4fb4d7f45d1cf-594bcab0311mr4576922a12.39.1720696407735;
        Thu, 11 Jul 2024 04:13:27 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:ce43:28ef:7742:f662? ([2a02:810b:f40:4600:ce43:28ef:7742:f662])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc3f338fsm3371627a12.43.2024.07.11.04.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 04:13:27 -0700 (PDT)
Message-ID: <e3410560-6dec-41de-ab14-441dbe8e5bb1@gmail.com>
Date: Thu, 11 Jul 2024 13:13:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4
 node
To: wens@kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240711060939.1128-1-linux.amoon@gmail.com>
 <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.07.24 um 11:17 schrieb Chen-Yu Tsai:
> On Thu, Jul 11, 2024 at 4:44 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Anand,
>>
>> On 2024-07-11 08:09, Anand Moon wrote:
>>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
>>> signals.Each component of PCIe communication have the following control
>>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
>>> high-speed signals and communicate with other PCIe devices.
>>> Used by root complex to endpoint depending on the power state.
>>>
>>> PERST is referred to as a fundamental reset. PERST should be held low
>>> until all the power rails in the system and the reference clock are stable.
>>> A transition from low to high in this signal usually indicates the
>>> beginning of link initialization.
>>>
>>> WAKE signal is an active-low signal that is used to return the PCIe
>>> interface to an active state when in a low-power state.
>>>
>>> CLKREQ signal is also an active-low signal and is used to request the
>>> reference clock.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> V2: Update the commit messge to describe the changs.
>>>      use pinctl group as its pre define in pinctl dtsi
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index 2e7512676b7e..ab3a20986c6a 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -301,7 +301,7 @@ &pcie30phy {
>>>
>>>   &pcie3x4 {
>>>        pinctrl-names = "default";
>>> -     pinctrl-0 = <&pcie3_rst>;
>>> +     pinctrl-0 = <&pcie30x4m1_pins>;
>>
>> Use of the existing pcie30x4m1_pins group may not be fully accurate for
>> the PERST pin. The use of reset-gpios indicate that the PERST pin is
>> used with GPIO function and the driver will implicitly change the
>> function from perstn_m1 to GPIO. So this may not be best representation
>> of the hw, hence my initial suggestion, something like:
>>
>>          pcie30x4_pins: pcie30x4-pins {
>>                  rockchip,pins =
>>                          <4 RK_PB4 4 &pcfg_pull_none>,
>>                          <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>>                          <4 RK_PB5 4 &pcfg_pull_none>;
>>          };
>>
>> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
>> not just pcie3x4.
> 
> Can we consider implementing strict mode in the pinctrl driver so we don't
> have to keep doing this GPIO + pinmux dance?
> 

This is not about drivers, this is DT which is independent from drivers.
Jonas and I had discussion recently on u-boot mailing list with somebody
using Open/FreeBSD about exact that topic. Pinctrl mux settings should be
very explicit, even if it is not required by the linux-driver.

Alex

> ChenYu
> 
> 
>> Regards,
>> Jonas
>>
>>>        reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>>        vpcie3v3-supply = <&vcc3v3_pcie30>;
>>>        status = "okay";
>>> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
>>>        };
>>>
>>>        pcie3 {
>>> -             pcie3_rst: pcie3-rst {
>>> -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>>> -             };
>>> -
>>>                pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>>>                        rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>>>                };
>>>
>>> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
>>
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


