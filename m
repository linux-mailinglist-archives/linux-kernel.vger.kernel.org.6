Return-Path: <linux-kernel+bounces-191727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7798D132C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF01C2103C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD120326;
	Tue, 28 May 2024 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WG3/rYO9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85724B2F;
	Tue, 28 May 2024 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868995; cv=none; b=Fbi8cZg+bxMUihe1Zb38EE+luwNYV2duUSfr4WB3eR+t3gcp4ohNHbybAv1z1oTqxMbMXhvHGWy0wdZUxPeTvNWwfMUVy0rcZ9ABGeDx2behhiCRAwRvN2Lcn3JRJHyjf7i935KOaQMEHS5ZBcJzOMZI8OSYrA5JhU2EiJ6dcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868995; c=relaxed/simple;
	bh=6E8ygxk28fpfpdyMx1qm0N0dBYzXvldxCBmRubCxKvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fWzpi8YcVhKTsHFChNwS5vPoxiYWp4qk4KGl84sEFIj6C0ihEfuoeumfr7giBoGQQXjJJtM7IxF87GNmsc588OWQjxNcHWvhUuVlVyNAfehhCZOk3BQEhXpbhe537TUbijcfYFkGi9r41bMETXLMH09mTYRZhkqS0odTFl4B0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WG3/rYO9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S42xRF038303;
	Mon, 27 May 2024 23:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716868979;
	bh=OOaSwuoABAU9LolQqVDEADDj+Ow2WIBhN9tfFpUXSKs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WG3/rYO9uenWkXcFd0itZhbxHI51N1QTczrRTjHq4TKO2XTJVmFY4CDBIkhiHpFvf
	 t7cqVe50wiQNxXKEgwipkJrtWdbK+RvAs2/f/0d87RJvSHeQeRjXTPSNcgEV+MM/7y
	 Xhbqp93QDRmROm5lnbG+myqcblejJ/L64LFFzWf4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S42xeV025912
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 23:02:59 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 23:02:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 23:02:59 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S42s5o066336;
	Mon, 27 May 2024 23:02:55 -0500
Message-ID: <046f78a5-e235-4716-8738-7a529353481a@ti.com>
Date: Tue, 28 May 2024 09:32:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: boot: dts: ti: k3-am68-sk-base-board: Add
 LP8733 and TPS6287 nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20240527124422.3553828-1-n-francis@ti.com>
 <20240527124422.3553828-2-n-francis@ti.com>
 <547196ae-af25-43bb-801c-9a9dbb6ec134@kernel.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <547196ae-af25-43bb-801c-9a9dbb6ec134@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Krzysztof,

On 27/05/24 19:59, Krzysztof Kozlowski wrote:
> On 27/05/2024 14:44, Neha Malcom Francis wrote:
>> Add DTS node for LP87334E PMIC and two TPS6287x high current buck
>> converters.
>>
>> LP87334E is responsible for supplying power to the MCU and MAIN domains
>> as well as to LPDDR4. The two TPS6287x supply power to the MAIN
>> domain for AVS and other core supplies.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Link: https://www.ti.com/lit/pdf/slda060
>> ---
>>   .../boot/dts/ti/k3-am68-sk-base-board.dts     | 77 +++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> index d743f023cdd9..74e59035013c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> @@ -414,6 +414,83 @@ &wkup_uart0 {
>>   	pinctrl-0 = <&wkup_uart0_pins_default>;
>>   };
>>   
>> +&wkup_i2c0 {
>> +	bootph-all;
>> +	status = "okay";
> 
> Please order the properties according to DTS coding style:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	lp8733: pmic@60 {
>> +		compatible = "ti,lp8733";
>> +		reg = <0x60>;
>> +
>> +		buck0-in-supply = <&vsys_3v3>;
>> +		buck1-in-supply = <&vsys_3v3>;
>> +		ldo0-in-supply = <&vsys_3v3>;
>> +		ldo1-in-supply = <&vsys_3v3>;
>> +
>> +		lp8733_regulators: regulators {
>> +			lp8733_buck0_reg: buck0 {
>> +				/* FB_B0 -> LP8733-BUCK1 - VDD_MCU_0V85 */
>> +				regulator-name = "lp8733-buck0";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			lp8733_buck1_reg: buck1 {
>> +				/* FB_B1 -> LP8733-BUCK2 - VDD_DDR_1V1 */
>> +				regulator-name = "lp8733-buck1";
>> +				regulator-min-microvolt = <1100000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +
>> +			lp8733_ldo0_reg: ldo0 {
>> +				/* LDO0 -> LP8733-LDO1 - VDA_DLL_0V8 */
>> +				regulator-name = "lp8733-ldo0";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			lp8733_ldo1_reg: ldo1 {
>> +				/* LDO1 -> LP8733-LDO2 - VDA_LN_1V8 */
>> +				regulator-name = "lp8733-ldo1";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +			};
>> +		};
>> +	};
>> +
>> +	tps62873a: tps62873@40 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>> +		compatible = "ti,tps62873";
>> +		bootph-pre-ram;
>> +		reg = <0x40>;
>> +		regulator-name = "VDD_CPU_AVS";
>> +		regulator-min-microvolt = <600000>;
>> +		regulator-max-microvolt = <900000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	tps62873b: tps62873@43 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks for the review! I have posted v3.

-- 
Thanking You
Neha Malcom Francis

