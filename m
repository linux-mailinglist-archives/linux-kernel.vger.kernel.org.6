Return-Path: <linux-kernel+bounces-542544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CCA4CAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3298175606
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050322CBE2;
	Mon,  3 Mar 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IP9//ev5"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46448223714;
	Mon,  3 Mar 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026413; cv=none; b=FxCJadQBBMFpsefdIdBi26cDnyBmk3xFi98clh+59/pRLAmCWU3j/wHNW7WJ+rSDpqu/MovJKrk01cu8g9Dl7RSIcgze/rDjb7aSHSCMymG/y9l+OMzFqeSrGnZymkqmh/h7PjX0YO5uVxC2Cl6sdFcE0QHNZgM225zwYXk7JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026413; c=relaxed/simple;
	bh=4RTGKwNcOSDFHQqdse/yG31XBpzBjwL24DNTVvcJeY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XWUjHcb7ZMDUL/QWAd2KHmcWzPiK01E2/e2XsDvH6J2EDoLp77Ue1chvnQDm+hzHZtU+ukokfJxDWFYrDMFmITqozECxvQ2fUz0vdaF1G+VjMrPeifYDbWVhNE/yqmgIs2I4YWh8rOSvAS+ZUdPnnyrzVieWNhNm457xT8aXr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IP9//ev5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523IQfH32746417
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 12:26:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741026401;
	bh=2OXcs9rd6LU272jx0hvJeNCeWilIYJbVsDhfgH7IVNQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IP9//ev56TbGqMZ4D6UhiHjkB3UkqOwXIcxc/Lb7DUN08WlFG0BwY5JDQJ74taTO5
	 PWMmHDzt2InU1W29kibhGNVQfSgkgj6JYZ6bxDb3RDYjmkbf4IBmGSGkAHxio2GU14
	 BLc4drnHFmYwMbJiiapoI3/cLR7vT00hbjKI7tKY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523IQfbc003604
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 12:26:41 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 12:26:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 12:26:41 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523IQbTg121603;
	Mon, 3 Mar 2025 12:26:38 -0600
Message-ID: <13bd564d-84bc-4b97-9591-126eb51772fb@ti.com>
Date: Mon, 3 Mar 2025 23:56:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am68-sk/k3-j721s2-mcu: Add
 bootph-all property to enable Ethernet boot
To: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250302153502.181832-1-c-vankar@ti.com>
 <20250302153502.181832-2-c-vankar@ti.com>
 <6b5839b3-84cb-42ee-8336-81ebf9b2e40d@ti.com>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <6b5839b3-84cb-42ee-8336-81ebf9b2e40d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Vignesh,

On 3/3/2025 1:44 PM, Vignesh Raghavendra wrote:
> 
> 
> On 02/03/25 21:05, Chintan Vankar wrote:
>> Ethernet boot requires CPSW nodes to be present starting from R5 SPL
>> stage. Add bootph-all property to required nodes to enable Ethernet boot
>> on AM68-SK and J721S2-EVM.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v1:
>> https://lore.kernel.org/r/20250106123122.3531845-2-c-vankar@ti.com/
>>
>> Changes from v1 to v2:
>> - No changes.
>>
>>   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 3 +++
>>   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 4 ++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> index 11522b36e0ce..8e9101dd2152 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> @@ -333,6 +333,7 @@ J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
>>   			J721S2_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
>>   			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
>>   		>;
>> +		bootph-all;
>>   	};
>>   
>>   	mcu_mdio_pins_default: mcu-mdio-default-pins {
>> @@ -340,6 +341,7 @@ mcu_mdio_pins_default: mcu-mdio-default-pins {
>>   			J721S2_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
>>   			J721S2_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
>>   		>;
>> +		bootph-all;
>>   	};
>>   
>>   	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
>> @@ -615,6 +617,7 @@ &mcu_cpsw {
>>   &davinci_mdio {
>>   	phy0: ethernet-phy@0 {
>>   		reg = <0>;
>> +		bootph-all;
>>   		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>   		ti,min-output-impedance;
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> index bc31266126d0..29cd4b1ffbbf 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> @@ -154,12 +154,14 @@ mcu_conf: bus@40f00000 {
>>   		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>>   			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>>   			reg = <0x200 0x8>;
>> +			bootph-all;
>>   		};
>>   
>>   		phy_gmii_sel: phy@4040 {
>>   			compatible = "ti,am654-phy-gmii-sel";
>>   			reg = <0x4040 0x4>;
>>   			#phy-cells = <1>;
>> +			bootph-all;
>>   		};
>>   
>>   	};
>> @@ -538,6 +540,7 @@ mcu_cpsw: ethernet@46000000 {
>>   		clocks = <&k3_clks 29 28>;
>>   		clock-names = "fck";
>>   		power-domains = <&k3_pds 29 TI_SCI_PD_EXCLUSIVE>;
>> +		bootph-all;
>>   
> 
> Since a child node has bootph-all, no need to put the same in the parent
> hierarchy.
> 

Thank you for pointing this out, I will remove it from the parent node
and post the next version.

Regards,
Chintan.

>>   		dmas = <&mcu_udmap 0xf000>,
>>   		       <&mcu_udmap 0xf001>,
>> @@ -562,6 +565,7 @@ cpsw_port1: port@1 {
>>   				label = "port1";
>>   				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
>>   				phys = <&phy_gmii_sel 1>;
>> +				bootph-all;
>>   			};
>>   		};
>>   
> 
> 

