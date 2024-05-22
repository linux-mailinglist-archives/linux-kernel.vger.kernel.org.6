Return-Path: <linux-kernel+bounces-186567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063318CC5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9BB1F22269
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590A142E9C;
	Wed, 22 May 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NBKw/BeO"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BF76048;
	Wed, 22 May 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399715; cv=none; b=clcpr2Iwa02Qhnpwtw241hxoCrq0hU1OnY5DyNdzd7wDVvP9Fb6b1+E7lKcdv3H3N0GJGG7dfENGM8j50rg+Ug/I1qgngEuLPhH5JvCHRjta5fhe/MRayTIRYZSO8dBSpYfBYOkqIgsQ028+yNdpzWsk7j/qm7KkuLBfa+SVODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399715; c=relaxed/simple;
	bh=uvL6c0sQzUn4EQXHgyUdZShzqtxsUfQBgxL0hnuw5Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M1CXFCILScbl0N7ja4bBkLHJgbMo29S8Z8j6OKH8URbC2BrW2ZuzJHUMzeRzmmDq/TCpC8X3jER0E0OarVulRIMVC2mqpLkEVgCFWRMrIyS0i36fXlV79nvBycjnBJiQNoWbY+lTXNMV5RImtS7Y/K5sQeXtARFUb6Ovj+4m+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NBKw/BeO; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2FBAE120011;
	Wed, 22 May 2024 20:41:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2FBAE120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716399706;
	bh=ORccFiShbmiAytq5SHZC9Z2mGFe7Gewrl8C0g5tV60s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=NBKw/BeORAvdvC8MqaROXAc1l0DIcDjtIVTtItU5G1ZbPpME7C/gZReDQ3QE+Kr3/
	 e22NzJmm1DYClHQ/vpQ/VzP3eFpf/sljJpjf9SNiqW4n/tdBRxvoI2/UoR5V9rXPQw
	 os+0XDe9M2L9Qyh0kxAYS1WICIbiuTjDSzww+FC2oopTeNtt5owTPgSJ0cjwyDvIMm
	 7rpSOvEgbLaLDhjka7BoQB/I3tsj40PfXzaovQxP15PPFadoUfkRtltIXelfyJjJVw
	 wFZ7xJ0N7vIhKf5KzdU2Tcww46u8RkFviq8Ik/t37q/ZbUq2e44jVd0T56tJ9eE5FM
	 CbI9Ylythhw0w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 May 2024 20:41:45 +0300 (MSK)
Received: from [172.28.128.189] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 May 2024 20:41:45 +0300
Message-ID: <edc6241b-195f-4188-b802-24706ebc9541@salutedevices.com>
Date: Wed, 22 May 2024 20:40:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce initial support of Amlogic AC200 board
Content-Language: en-US
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>, Lucas Tanure <tanure@linux.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Dmitry Rokosov
	<ddrokosov@sberdevices.ru>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
 <171638551693.3169786.7201121718393921307.robh@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <171638551693.3169786.7201121718393921307.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185427 [May 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;devicetree.org:7.1.1;salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/22 13:13:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/22 16:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/22 16:29:00 #25238160
X-KSMG-AntiVirus-Status: Clean, skipped

On 5/22/24 16:46, Rob Herring (Arm) wrote:
> 
> On Wed, 22 May 2024 01:21:52 +0300, Jan Dakinevich wrote:
>>  - Make some cosmetics in existing device tree files;
>>
>>  - Add the board.
>>
>> Jan Dakinevich (3):
>>   arch/arm64: dts: ac2xx: make common the sound card
>>   dt-bindings: arm: amlogic: document AC200 support
>>   arch/arm64: dts: ac200: introduce initial support of the board
>>
>>  .../devicetree/bindings/arm/amlogic.yaml      |  1 +
>>  .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
>>  .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
>>  .../boot/dts/amlogic/meson-sm1-ac200.dts      | 22 +++++
>>  .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
>>  .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
>>  .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
>>  .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
>>  8 files changed, 110 insertions(+), 435 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts
>>
>> --
>> 2.34.1
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
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y amlogic/meson-sm1-a95xf3-air-gbit.dtb amlogic/meson-sm1-a95xf3-air.dtb amlogic/meson-sm1-ac200.dtb amlogic/meson-sm1-h96-max.dtb amlogic/meson-sm1-x96-air-gbit.dtb amlogic/meson-sm1-x96-air.dtb' for 20240521222155.28094-1-jan.dakinevich@salutedevices.com:
> 
> arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/clock-controller@0: failed to match any schema with compatible: ['amlogic,sm1-audio-clkc']
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@300: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@340: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@380: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller@3c0: compatible: ['amlogic,sm1-tdmin', 'amlogic,axg-tdmin'] is too long
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: /soc/bus@ff600000/bus@60000/audio-controller@744: failed to match any schema with compatible: ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
> 	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dtb: sound: 'anyOf' conditional failed, one must be fixed:
> 	'clocks' is a required property
> 	'#clock-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
> 
> 
> 
> 
> 

These errors were here before my modifications, and they require extra
efforts to rework generic 'meson-sm1.dtsi' etc. But it is not the goal
of this series. Should I do anything about this right now?

-- 
Best regards
Jan Dakinevich

