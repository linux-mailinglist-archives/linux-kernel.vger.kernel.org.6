Return-Path: <linux-kernel+bounces-177948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF768C46A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A6E1C216CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86712E414;
	Mon, 13 May 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="w1FEZJox"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B12940B;
	Mon, 13 May 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623435; cv=none; b=Mq4n/rgF/owARMaz1GsQEbUcXmy6Qybm87+UrL+ccAzTUHcpZV2bGYUn6qEG5NwLmjsNIj5pkixYesAHwzkOh51lXToOhjuGV2oQ9RIpsZOBHBwqdlnb58z5i02R5+m1YrhzjXQ1SJJhfUYasjVWTjpO24qHRrZLNSe/uth05aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623435; c=relaxed/simple;
	bh=xjUBXjbyd0cJtO8foRZNXs5N1w655lJMKfcLTmwAS3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QstDRUfnr6FmYHPDpJE2q8Eo1JkU3xj7mla6KeU+rZQ5HA7PQHVo9i1jc56aou20IZi0BcBniQ3vitjcQ+kw9SrTafwe+wb0R5lTyhvUg7STOxes9bz88jhB98X1a3yMUqA06HNgWAvVAhVWVRjh2xnpDzY9edCK9WUTkPKbu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=w1FEZJox; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DH4Q0m020067;
	Mon, 13 May 2024 20:03:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=9OAfNnJHeMU9nK01d+Hvov9DzgQE0mw8dqPgxIiAhYA=; b=w1
	FEZJoxqP5vEMLrWnmMq92Okt0X3/a9f+l2Ypcztndrd4SWxA2wbrAZypM3i85iU1
	tjusGp0tOUV7kHHYYqZ0+ZNU7m90q4XpRTvEmHO9F4qAdf0QzITMyAi1a8lVTmT1
	DOmUfUg5DkF8HtnPlCyrKZOdDVRkXhRGerD7Ump9yc8ce3CbHwfkdNJeT7p0ehHT
	rURUTUdPSpkA6+zHuoF1lQmiGO7Hq1tEyaGzhudESj0A6g77Du43usoL9cF5SDpf
	5TzG1HhuGbXm5dV8BeEZfr+dZ0hvqa1uBtbVx8voLQ/+JWIKzGS6fY+RVMoy03CK
	tJPjEgb0J6qRSLiHzGXw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2j80nuyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:03:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6B8074002D;
	Mon, 13 May 2024 20:03:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 744B921B534;
	Mon, 13 May 2024 20:02:23 +0200 (CEST)
Received: from [10.48.87.205] (10.48.87.205) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 20:02:22 +0200
Message-ID: <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
Date: Mon, 13 May 2024 20:02:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Conor Dooley <conor@kernel.org>, Marek Vasut <marex@denx.de>
CC: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240513-stabilize-proofread-81f0f9ee38b9@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02

Hi,

On 5/13/24 17:16, Conor Dooley wrote:
> On Mon, May 13, 2024 at 04:34:20PM +0200, Marek Vasut wrote:
>> On 5/13/24 11:56 AM, Patrick Delaunay wrote:
>>> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Replace oneOf/const by enum; solve the V2 issues for dt_binding_check
>>>
>>> Changes in v2:
>>> - update for Rob review, only add compatible for STM32MP13 family
>>>
>>>    .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>> index c9586d277f41..c766f0a15a31 100644
>>> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>>> @@ -11,7 +11,9 @@ maintainers:
>>>    properties:
>>>      compatible:
>>> -    const: st,stm32mp1,pwr-reg
>>> +    enum:
>>> +      - st,stm32mp1,pwr-reg
>>> +      - st,stm32mp13-pwr-reg
>> Should the st,stm32mp1,pwr-reg be treated as fallback compatible for
>> st,stm32mp13-pwr-reg or not ?
>>
>> In other words, should the DT contain:
>> compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";
>> or
>> compatible = "st,stm32mp13-pwr-reg";
>> ? Which one is preferable ?
>>
>> I think the former one, since the MP13 PWR block could also be operated by
>> older MP1(5) PWR block driver(s) without any adverse effects, except the SD
>> IO domain configuration won't be available, right ?
> Aye, the fallback sounds like what should be being used here, especially
> if another user of the DT might not need to implement the extra domain.


Yes it is the the only difference but I think that type of fallback is 
no more recommended for different device and

the PWR device on STM32MP13 and on STM32MP15 are different.


The other user of the non-secure device tree don't use the yet the PWR 
driver for STM32MP13,

so for me the fallback is not needed for non secure world (Linux/U-Boot).


So I prefer to introduce a new compatible in Linux kernel before the 
STM32MP13 PWR node is really used  to avoid ABI break in futur.

PS: I will update the U-Boot PWR driver to avoid issue for boards 
managing PWR in non-secure world (alignment with Linux device tree).

For information: on the STMicroelectronics STM32MP13 reference designs the PWR IP is only managed in secure world by OP-TEE
and the support of SD IO domain on PWR STM32MP13 is mandatory for ultra High Speed support on SD/eMMC devices.


The node is introduced in SoC device tree by [1], copied from first up 
streamed OP-TEE device tree,

[1] commit f798f7079233 ("ARM: dts: stm32: add PWR regulators support on stm32mp131")
     https://lore.kernel.org/linux-arm-kernel/b89d0531-067f-4356-91b0-ed7434cee3d7@foss.st.com/


but unfortunately the OP-TEE binding not acceptable.


For OP-TEE this new feature of PWR is managed with new nodes with compatible "st,stm32mp13-iod"
and a separate driver core/drivers/regulator/stm32mp1_regulator_iod.c

But it is NOT acceptable for Linux binding / driver because the register PWR_CR3 = 0x5000100C
are used in this driver and also in PWR regulator driver core/arch/arm/plat-stm32mp1/drivers/stm32mp1_pwr.c

It is not acceptable because offset 0xC of the register range of pwr_regulators: pwr@50001000
(with reg = <0x50001000 0x10>) so the SD IO domain must be defined in the same node.


For example, when the PWR is managed in secure world, the SCMI regulator are it is used with:

&sdmmc1 {
	pinctrl-names = "default", "opendrain", "sleep";
	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_clk_pins_a>;
	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_clk_pins_a>;
	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
	cd-gpios = <&gpioh 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
	disable-wp;
	st,neg-edge;
	bus-width = <4>;
	vmmc-supply = <&scmi_vdd_sd>;
	vqmmc-supply = <&scmi_sdmmc1_io>;
	sd-uhs-sdr12;
	sd-uhs-sdr25;
	sd-uhs-sdr50;
	sd-uhs-ddr50;
	sd-uhs-sdr104;
	status = "okay";
};


For me the IOD must be export as a regulator of PWR node.

because for hardware point of view sdmmc1_io/sdmmc2_io are at the same level that othe STM32MP13 regulator reg11/reg18/usb33,


So I will align the OP-TEE device tree/ driver if the Linux binding is accepted.


Something like:


		pwr_regulators: pwr@50001000 {
			compatible = "st,stm32mp13,pwr-reg";
			reg = <0x50001000 0x10>;

			reg11: reg11 {
				regulator-name = "reg11";
				regulator-min-microvolt = <1100000>;
				regulator-max-microvolt = <1100000>;
			};

			reg18: reg18 {
				regulator-name = "reg18";
				regulator-min-microvolt = <1800000>;
				regulator-max-microvolt = <1800000>;
			};


			usb33: usb33 {
				regulator-name = "usb33";
				regulator-min-microvolt = <3300000>;
				regulator-max-microvolt = <3300000>;
			};

			sdmmc1_io: sdmmc1_io {
				compatible = "st,stm32mp13-iod";
				regulator-name = "sdmmc1_io";
				regulator-min-microvolt = <1800000>;
				regulator-max-microvolt = <3300000>;
				vddsd1-supply = <&vddsd1>;
				regulator-always-on;
			};

			sdmmc2_io: sdmmc2_io {
				compatible = "st,stm32mp13-iod";
				regulator-name = "sdmmc2_io";
				regulator-min-microvolt = <1800000>;
				regulator-max-microvolt = <3300000>;
				vddsd2-supply = <&vdd>;
				regulator-always-on;
			};
		};


And the sdmmc1_io/sdmmc2_io nodes allow to select the IOD for ultra high speed,

for example with "vqmmc-supply = <&sdmmc1_io>;"


To conclude:

Adding a separate compatible is mandatory for addition of SD IO domain (to manage new sub nodes in yaml),
and the PWR fallback is not needed as PWR not yet used by any board in non secure worl (Linux/U-Boot).

Patrick


