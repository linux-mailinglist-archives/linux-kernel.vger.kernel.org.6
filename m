Return-Path: <linux-kernel+bounces-232251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3991A5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B171C20AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A414EC75;
	Thu, 27 Jun 2024 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORhRzGNi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C984500C;
	Thu, 27 Jun 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489309; cv=none; b=VXOB5MBcgNRkL+3SEJkIoEmwGhiM+4il7nvP1btgkSmIx1ZWzOEa115wJkSr4AIDSLXwzT+NksJ8KGmaxtnACbb/uQ1wJS8dwuWq/To7KvEyh7VKMjzENbcb2pOCzbAHBlhm6jdeoZDdH5XH82DyYoXWnR9VemqysiAUYg7wjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489309; c=relaxed/simple;
	bh=h7Fu0xncdHPfoFsnSwBblMqfbvgXA7ivVnSCW4ievhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9blp7CplADEktHbHYRmaAeZyzpM4/Sfm1eJRx5FI6MPyd9YmiNSs0Rec99MRVIcX52hcgvyUSpypLU6jwivMk9J4B0fKODln5uXoXsZM8GxT67cQ137F4trqkj6Ks0IlVZueHXatrlAszjvVBWcGL1/JpJ2lCfRn8u9uVCEN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORhRzGNi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-584ef6c07c2so821240a12.1;
        Thu, 27 Jun 2024 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719489306; x=1720094106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6KkV+F4kIU0bW6gmxjlssxeZSnVSf59l2WAqPYRLBQ=;
        b=ORhRzGNi8fVCafSWYWshrDJLQNpbH88Qc4nwiqjXvBlP7Lk1vLP38lH/YZuSQrbcHM
         Gld1eI1P9thgaLeTnYSRsCMBzdKM5yYQFJ3yXIPI0WmtRZNka4jDTDgJbSNu3b8O5stV
         C5693irtNarnyYF6VqSOb3mvjt7mCGZQdC7dC0Zk5+DZ6MyLqS1c3jqarxHwzi4Tq3hj
         Rp/xDCujY3dFr6f1tM5I7TtFiy9+PpKQRxZxPrah26WDfopX98BO67DZrNp79WCG/u6f
         oXr2I6+deRxpV/MVcESYdgMnPXhwWQwrfMUHaWb6sHZIwWTPzNSqFzTSeRtaw7Hh5sHr
         1fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489306; x=1720094106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6KkV+F4kIU0bW6gmxjlssxeZSnVSf59l2WAqPYRLBQ=;
        b=U8Ox4iusmQFumpf6Dd0W/GA7/2854LugpobRECNSzjni+cuqCKUgqAod6uFpQCjDDZ
         Wt7ssWDkQsrhaMbBjgV+7imcq8LCTweWNwkioCIwRKZ9G1u/akt3wTq6twb/6L6+X9TN
         mO+H3Syh874o2AlaJ73zR1dkBIMGSe7Ciz/1kE/MAlYeanHy3rH4KgCstwQPs0wkXzn+
         WMW5xH8KWdQdjuc2PXPni27i0FfN7kifMPxEhY4XKixExYjlIkRR0i0S+bdgX6qrO0/P
         ukkOpxH/+lmJ6Bo7fTZV+9y6DGQxQk6B9ugLfB9LuHjtJbFZmd3hV3iJU9Yrs3LGkb93
         6vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwlUK2JJHy6QZP9KZVMQTDzhf9AZ78Fu7F3pQVTsovNjkvPKXK/GiSbvUO9YyX3TqRFh+za+nOc/GqdH4fgCy+Faqb9htEhfQo4vR6
X-Gm-Message-State: AOJu0YyPoIISlpudw6J5zFc7Cq8L8aqLSyYhhBIh12P1es/gIjZw1jNm
	Tq/oLI7nf7KB6VUQq0CoRJEpc46uvTOiySYv82TEBNd94SKkvrE=
X-Google-Smtp-Source: AGHT+IHWnk4OjMl2anVNYk/1eRisoMwR3RkY/QD/8dhORfPg8XmxZYhqSK+1slPIt9ubo8i6ryQ3Pg==
X-Received: by 2002:a17:906:daca:b0:a6f:4287:f196 with SMTP id a640c23a62f3a-a729b7328a1mr163548666b.2.1719489304428;
        Thu, 27 Jun 2024 04:55:04 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:2023:48bf:6b4:88a4? ([2a02:810b:f40:4600:2023:48bf:6b4:88a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca30asm52116966b.205.2024.06.27.04.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 04:55:04 -0700 (PDT)
Message-ID: <ec684a50-2b06-4a83-9ba0-6ae14b48728b@gmail.com>
Date: Thu, 27 Jun 2024 13:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
To: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626201502.1384123-1-jonas@kwiboo.se>
 <20240626201502.1384123-3-jonas@kwiboo.se>
 <7F75D4B7290C2A91+8b029861-21dc-4f52-acbc-89087b4c0f0d@radxa.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <7F75D4B7290C2A91+8b029861-21dc-4f52-acbc-89087b4c0f0d@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.06.24 um 00:29 schrieb FUKAUMI Naoki:
> Hi,
> 
> thank you very much for your effort!
> 
> On 6/27/24 05:14, Jonas Karlman wrote:
>> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
>> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
>> version based on the RK3568 SoC and an industrial version based on the
>> RK3568J SoC.
>>
>> Add initial support for eMMC, SD-card, Ethernet, HDMI, PCIe and USB.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - Use regulator-.* nodename for fixed regulators
>> - Drop rockchip,mic-in-differential prop
>> - Shorten Ethernet phy reset-deassert-us to 50 ms
>> - Fix pcie pinctrl
>> - Add keep-power-in-suspend to sdmmc2
>>
>> Following issue is reported by dtbs_check and is fixed by series at [1]:
>>
>>    pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 
>> 'assigned-clocks', 'clock-names', 'clocks'
>>      do not match any of the regexes: 'pinctrl-[0-9]+'
>>    from schema $id: 
>> http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>
>> [1] 
>> https://lore.kernel.org/all/20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com/
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3568-rock-3b.dts      | 780 ++++++++++++++++++
>>   2 files changed, 781 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile 
>> b/arch/arm64/boot/dts/rockchip/Makefile
>> index 90f5172f37e6..ae0ae02f51e9 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts433.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> new file mode 100644
>> index 000000000000..46c959f1c6ad
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> @@ -0,0 +1,780 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>> +#include "rk3568.dtsi"
>> +
>> +/ {
>> +    model = "Radxa ROCK 3B";
>> +    compatible = "radxa,rock-3b", "rockchip,rk3568";
>> +
>> +    aliases {
>> +        ethernet0 = &gmac0;
>> +        ethernet1 = &gmac1;
>> +        mmc0 = &sdhci;
>> +        mmc1 = &sdmmc0;
>> +        mmc2 = &sdmmc2;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial2:1500000n8";
>> +    };
>> +
>> +    hdmi-con {
>> +        compatible = "hdmi-connector";
>> +        type = "a";
>> +
>> +        port {
>> +            hdmi_con_in: endpoint {
>> +                remote-endpoint = <&hdmi_out_con>;
>> +            };
>> +        };
>> +    };
>> +
>> +    ir-receiver {
>> +        compatible = "gpio-ir-receiver";
>> +        gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&pwm3_ir>;
>> +    };
>> +
>> +    leds {
>> +        compatible = "gpio-leds";
>> +
>> +        led-green {
> 
> led-0 or just led (leds-gpio.yaml)
> 
That's a misinterpretation of the pattern-properties regex: The
"non-preferred" part of the regex does neither have a "^" nor an "$", thus
it allows all nodes names which have "led" somewhere.
> Best regards,
> 
> -- 
> FUKAUMI Naoki


