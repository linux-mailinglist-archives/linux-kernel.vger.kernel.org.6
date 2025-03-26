Return-Path: <linux-kernel+bounces-576792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE00FA71488
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E58D3B0BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0D1B4227;
	Wed, 26 Mar 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nGOZiOKk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC308C1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984085; cv=none; b=PXtII99YuX11VJ3WSAXCZMxEMfLvG6vzXIbzt0EoGas1cy57bDrZ16H9RpIIHLF2vL5Cxq1d/YpsAZGz5GRTCEyPPgzNTe3soFZH7RT9ZEYKfUW4anRn9UhuPCKAzCWDBYZpvghxUpgAdxaF9r0ek56z7UBUy8DS5LAmIGBMGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984085; c=relaxed/simple;
	bh=UmsMuhpZlu+Njl9EMinVLEfXAWYFXiGBm7wBgkQV+HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVofjq7Hv62Lb6gqlI9bSo3jh/iXrsnZU8OUq2VOdrvr83G4/5HVJ4z7/AtHFf3m6bcvAImqBAY160ZASmrob7vHoYb2jk1MTEv/QstBhpynVoowOxp7ci9AKVqd3P8T0KeIu+Oz+RYngx1lPo8LYayG3By0UyjmxBk5izUGZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nGOZiOKk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso56857725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742984080; x=1743588880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+DNp9QMgdrRGLxMsL46W/r+9G/+hiEbxecdzU4iISI=;
        b=nGOZiOKkGcDJb357qlVR8SRL0tkKb4UmIAvL9qApqeuGVLuVvjxRqZd1HZ1rgM3ZnA
         0fuV6zqZ5pYYgVh1Bl3OtseXLN/9VYf7gT0JshJY5Av95wWkc6U6kjEXyCgNAey7imyu
         LFOwKBWajFFifWhD4KGG+0FBLzJKcmAeo8EIjav67CxmJh2i7oLAB62oDEztUlzBOO1g
         BOSRJhUmLnz8enKW92n4DwyNKI+0k6JExO4L0DPWO2V56TbNl4PVLPTPTWeKwG8TMETD
         QwthG2pog2DbZGIb6yKZic9VD4RYt5E8BgBfELXYiGaHQ3lUAEpCQWq3nMGe2Qy2awMy
         ZLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984080; x=1743588880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+DNp9QMgdrRGLxMsL46W/r+9G/+hiEbxecdzU4iISI=;
        b=gI8OGvRjJpwD7sooa8/RMxsneDUZysjwY8MJU3qBGTL9NMZkVrYUOIJGwR2A32Opc+
         RiLiFJ7Utc0+No0dV5ZIb/Es5S/xqkE41gd1fQS8pOVcGADUR5tRIsVOX9Frnye+i3dh
         8FlV3jFmYxl1mGlpTsopk3/mxGMI0g6G47di4QnEIrLyAwfLQPSLJpudmE7+igSwMKfn
         YYc8rv2Hlvc+8VZbisR1xxq2YD/Zc71Upwz4RRlnYnCBnYz/B6GpjdGYrhbqvLs6w3eZ
         s/rQBZrOMFH/eH1MeEOedtiCW3heP6tFTnmmwhwLkJsDwTCmbG4dQeEV3a2HdJMiDccB
         8ufw==
X-Forwarded-Encrypted: i=1; AJvYcCWIWLvVw8UQPP8GMFFrzkYcc7Ib/X2ZLPp/gWFrbr6sNqWhQ3DQ8sf6PN5OWe6Lk0x+Dgqv6y8mX71bS/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87OUfg7Y+LYuZ8Kr/SBTJ5jgBe28TWP5T52EGsJadWdEpMaNB
	2HLyXbZNRTMF06CrfgZLgdSX54v86vo7rR5EGBCciMOhqbAIB4mNlcxa0OGprYw=
X-Gm-Gg: ASbGncu7iP+JGVSvfLn54ln8oQNbMMMCjwrJbGzAxjq3Cnrl80DyQRJMP4JTojR66Aj
	xi2HimCGibZflJrXWgmBmUFMNcBtDYHwfjr9rfUBiEBvaE7jfeBFlxkCwzbGp35yO9Hz1q5foim
	UlA4YzeHAXSL7Vqcmx+kUObt2KlQJKQZTDt+09hC1o2BEJHo/L03ZJYQuUTqNhB0b7bwrsUv9J9
	Yk7cmI/oc1oZRBK4o35+LzRN0y9LXf4EItQP5Md5WxlYcMIcCZkNN4736V+69bIGzHPMauX05M2
	IwNhJR14AWT8UBOTCHoUdmvfx5sapsJREufMSPyAEO2HP/lYFw9ahq5Jw5k/N01vIA+t5Rvvlzw
	ksTnSUmyYLcsvM4bH
X-Google-Smtp-Source: AGHT+IHwhUQzzlTOSTisycIZUmQB3vcpLzOCNhJ8f/5tktjjSbuVrOP11IMJCJMu5JzNW6Sn0rBjNw==
X-Received: by 2002:a05:600c:1e07:b0:43c:fdbe:439b with SMTP id 5b1f17b1804b1-43d509e374bmr207124305e9.4.1742984079808;
        Wed, 26 Mar 2025 03:14:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:5ee:79d0:9b00:d804:1c3a:7697? ([2a01:e0a:5ee:79d0:9b00:d804:1c3a:7697])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm176097065e9.35.2025.03.26.03.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:14:39 -0700 (PDT)
Message-ID: <8fde6af6-baaa-4f26-b9c0-a17ebcb67073@baylibre.com>
Date: Wed, 26 Mar 2025 11:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] arm64: dts: mediatek: add mmc2 support for
 mt8365-evk
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, macpaul.Lin@mediatek.com
Cc: vsatoes@baylibre.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250109-mmc2-support-v2-1-5f660c809610@baylibre.com>
 <ecd8a46e-0f87-498e-8a12-fdeae6f5791d@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <ecd8a46e-0f87-498e-8a12-fdeae6f5791d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Angelo,

Thanks for the review :D

I've some comment below:

On 24/03/2025 15:09, AngeloGioacchino Del Regno wrote:
> Il 24/03/25 14:54, Alexandre Mergnat ha scritto:
>> Adds support for the MMC2 interface on the MT8365 EVK board.
>> It introduces a fixed regulator for the MMC2 VDD33 supply and configures
>> the MMC2 node with a 4-bit bus width, high-speed capabilities, UHS
>> modes, and appropriate power supplies. Enabled SDIO IRQ, wakeup source,
>> and kept power during suspend (to save firmware module) for wireless
>> chip functionality.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>> Changes in v2:
>> - Apply alphabetical order to pinctrl property items.
>> - Improve commit message
>> - Link to v1: https://lore.kernel.org/r/20250109-mmc2-support-v1-1-9b9d1b1ae35d@baylibre.com
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 103 +++++++++++++++++++++++++---
>>   1 file changed, 94 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> index 7d90112a7e274..a87f1b3ed6500 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> @@ -53,6 +53,15 @@ memory@40000000 {
>>           reg = <0 0x40000000 0 0xc0000000>;
>>       };
>> +    mmc2_vdd33: mmc2_vdd33-regulator {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "mmc2_vdd33";
> 
> mmc2-vdd33 please

Ok

> 
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        gpio = <&pio 121 0>;
>> +        enable-active-high;
>> +    };
>> +
>>       usb_otg_vbus: regulator-0 {
>>           compatible = "regulator-fixed";
>>           regulator-name = "otg_vbus";

Then, I will change this too.

>> @@ -197,6 +206,28 @@ &mmc1 {
>>       status = "okay";
>>   };
>> +&mmc2 {
>> +    assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
>> +    assigned-clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>;
>> +    bus-width = <4>;
>> +    cap-sd-highspeed;
>> +    cap-sdio-irq;
>> +    hs400-ds-delay = <0x12012>;
>> +    keep-power-in-suspend;
>> +    max-frequency = <200000000>;
>> +    non-removable;
>> +    pinctrl-0 = <&mmc2_default_pins>;
>> +    pinctrl-1 = <&mmc2_uhs_pins>;
>> +    pinctrl-names = "default", "state_uhs";
>> +    sd-uhs-sdr104;
>> +    sd-uhs-sdr25;
>> +    sd-uhs-sdr50;
>> +    vmmc-supply = <&mmc2_vdd33>;
>> +    vqmmc-supply = <&mt6357_vcn18_reg>;
>> +    wakeup-source;
>> +    status = "okay";
>> +};
>> +
>>   &mt6357_pmic {
>>       interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
>>       interrupt-controller;
>> @@ -324,8 +355,8 @@ cmd-dat-pins {
>>                    <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>>                    <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>>                    <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
>> -            input-enable;
>>               bias-pull-up;
>> +            input-enable;
> 
> This is a cleanup and goes to a different commit

Agree

> 
>>           };
>>           rst-pins {
>> @@ -337,8 +368,8 @@ rst-pins {
>>       mmc0_uhs_pins: mmc0-uhs-pins {
>>           clk-pins {
>>               pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
>> -            drive-strength = <MTK_DRIVE_10mA>;
>>               bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +            drive-strength = <MTK_DRIVE_10mA>;
> 
> While at it, in a cleanup commit, if you could also remove those MTK_DRIVE_xxx and
> use just the number that'd be great.

Sure

> 
>>           };
>>           cmd-dat-pins {
>> @@ -351,21 +382,21 @@ cmd-dat-pins {
>>                    <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
>>                    <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
>>                    <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
>> -            input-enable;
>> -            drive-strength = <MTK_DRIVE_10mA>;
>>               bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +            drive-strength = <MTK_DRIVE_10mA>;
>> +            input-enable;
>>           };
>>           ds-pins {
>>               pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
>> -            drive-strength = <MTK_DRIVE_10mA>;
>>               bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +            drive-strength = <MTK_DRIVE_10mA>;
>>           };
>>           rst-pins {
>>               pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
>> -            drive-strength = <MTK_DRIVE_10mA>;
>>               bias-pull-up;
>> +            drive-strength = <MTK_DRIVE_10mA>;
>>           };
>>       };
>> @@ -386,16 +417,16 @@ cmd-dat-pins {
>>                    <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>>                    <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>>                    <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
>> -            input-enable;
>>               bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +            input-enable;
>>           };
>>       };
>>       mmc1_uhs_pins: mmc1-uhs-pins {
>>           clk-pins {
>>               pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
>> -            drive-strength = <8>;
>>               bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +            drive-strength = <8>;
>>           };
>>           cmd-dat-pins {
>> @@ -404,9 +435,63 @@ cmd-dat-pins {
>>                    <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
>>                    <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
>>                    <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
>> -            input-enable;
>> +            bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>               drive-strength = <6>;
>> +            input-enable;
>> +        };
>> +    };
>> +
>> +    mmc2_default_pins: mmc2-default-pins {
>> +        clk-pins {
>> +            pinmux = <MT8365_PIN_81_MSDC2_CLK__FUNC_MSDC2_CLK>;
>> +            bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> +            drive-strength = <4>;
>> +        };
>> +
>> +        cmd-dat-pins {
>> +            pinmux = <MT8365_PIN_82_MSDC2_DAT0__FUNC_MSDC2_DAT0>,
>> +                 <MT8365_PIN_83_MSDC2_DAT1__FUNC_MSDC2_DAT1>,
>> +                 <MT8365_PIN_84_MSDC2_DAT2__FUNC_MSDC2_DAT2>,
>> +                 <MT8365_PIN_85_MSDC2_DAT3__FUNC_MSDC2_DAT3>,
>> +                 <MT8365_PIN_80_MSDC2_CMD__FUNC_MSDC2_CMD>;
>>               bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>> +            drive-strength = <4>;
>> +            input-enable;
>> +        };
>> +
>> +        sys-en-pins {
>> +            pinmux = <MT8365_PIN_120_DMIC1_CLK__FUNC_GPIO120>;
> 
> My schematics say that the DMIC1_CLK pin is PERST_N, DMIC_DAT0 is PWR_EN: what's
> the intention here?!
> 
> In any case, this is not a mmc2 pin, but something else :-)

First of all, name in schematic are wrong, I noticed that when I've port these feature from kernel 
5.15 to 6.6. After digging and talking to MTK, they confirm me that PERST_N is actually an enable 
pin (or power_on).

Secondly, MT7663_PERST_N (MT8365_PIN_120_DMIC1_CLK__FUNC_GPIO120) is part of mmc2 pin since is it 
connected to the MMC2 connector pin number 52.

> 
> Cheers,
> Angelo
> 

-- 
Regards,
Alexandre

