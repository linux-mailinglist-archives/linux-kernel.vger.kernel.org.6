Return-Path: <linux-kernel+bounces-306736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8D9642B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4217284519
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B621922FA;
	Thu, 29 Aug 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VL/3cTgy"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17E1922E8;
	Thu, 29 Aug 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929654; cv=none; b=JRW0Dwe8MYn1F/+vArB4pfJC0x9U3YwStzv2+iIK5Gn2ZereJgN0JN1YWoMCTNoiG4Eyw7hPsWcI92HWlt/Qd9KEmMuBTf2rR0REECNilvKCiXstUgdJRvXavsHbPonnWUtOCGV6fMekmJgT7EolnKqmENMZtpd3ROXOCDJM+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929654; c=relaxed/simple;
	bh=A5OFPTbpdEqP2mUYX6FFkePBU9IKDSudOS4uXdE44+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jjl2X4/d40w37h3HSwIUvArVDFvs+f15Q0Z8wAMMIA6th+oYmNzIiViG+Jn6o+jJBMEULnqI/RiFiYYdiRdU9N34zjakcNZFEwwTRwfchvcdUBMTzlHyDAk3oTY/5ejhYIJO5cWXjMaRYU+DsUpeh/LaF7PTMtc6TDKvqR95yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VL/3cTgy; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T8VC3O013994;
	Thu, 29 Aug 2024 13:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Jw191MdcLJDiHz3SnaEKXrLm1BcBizdG8CQxgijglLY=; b=VL/3cTgyTbAiUU9E
	d/pxaR8rJ77F2XQhP+ORaN8RJG1fUzx3CNuEPRnmpXxVp3h8+4UEDzje1YFeGlDQ
	DUMiel3vP9vEp7MYqSmcU1erpERSGsGw2sfsn8gd0kqRcxb4fg70XaJHVb2HbJ7D
	Ckke1PkQze2FyDbXrG8wcHJH/6RpOeAIzHx0pUXTAY6RxUPbVoH0jmjMFUixScOx
	UCKlkS4LxSYnvHGj67f5ZIBCnI+diqMEafJR/kmjs5CWLKS5DXzfnUKbFwwR2NgO
	HE68gZ+FLQdac/vntBD9NIzuhTr6B7jJyOmo6cU6FOgUGfkskAWytnqFPJ7AahkK
	o2Pbxw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41a4y649qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 13:07:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4044B4002D;
	Thu, 29 Aug 2024 13:07:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E71BF25ED6F;
	Thu, 29 Aug 2024 13:07:00 +0200 (CEST)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 29 Aug
 2024 13:07:00 +0200
Message-ID: <005a2f7d-ab46-46c8-a0cc-b343685caf7c@foss.st.com>
Date: Thu, 29 Aug 2024 13:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
To: Conor Dooley <conor@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
 <20240828143452.1407532-2-christian.bruel@foss.st.com>
 <20240828-handsfree-overarch-cd1af26cb0c5@spud>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20240828-handsfree-overarch-cd1af26cb0c5@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01

On 8/28/24 18:11, Conor Dooley wrote:
> On Wed, Aug 28, 2024 at 04:34:48PM +0200, Christian Bruel wrote:
>> Document the bindings for STM32 COMBOPHY interface, used to support
>> the PCIe and USB3 stm32mp25 drivers.
>> Following entries can be used to tune caracterisation parameters
>>   - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
>> to tune the impedance and voltage swing using discrete simulation results
>>   - st,rx-equalizer register to set the internal rx equalizer filter value.
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   .../bindings/phy/st,stm32mp25-combophy.yaml   | 128 ++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>> new file mode 100644
>> index 000000000000..8d4a40b94507
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>> @@ -0,0 +1,128 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/st,stm32mp25-combophy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
>> +
>> +maintainers:
>> +  - Christian Bruel <christian.bruel@foss.st.com>
>> +
>> +description:
>> +  Single lane PHY shared (exclusive) between the USB3 and PCIe controllers.
>> +  Supports 5Gbit/s for USB3 and PCIe gen2 or 2.5Gbit/s for PCIe gen1.
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-combophy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    minItems: 2
>> +    items:
>> +      - description: apb Bus clock mandatory to access registers.
>> +      - description: ker Internal RCC reference clock for USB3 or PCIe
>> +      - description: pad Optional on board clock input for PCIe only. Typically an
>> +                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
>> +                     clock input instead of the ker
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    items:
>> +      - const: apb
>> +      - const: ker
>> +      - const: pad
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: phy
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  wakeup-source: true
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: interrupt used for wakeup
>> +
>> +  access-controllers:
>> +    minItems: 1
>> +    maxItems: 2
> Can you please describe the items here?

I can specialize the description: "Phandle to the rifsc firewall device to check access right."

otherwise described in access-controllers/access-controllers.yaml, see also bindings/bus/st,stm32mp25-rifsc.yaml

>
>> +  st,syscfg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the SYSCON entry required for configuring PCIe
>> +      or USB3.
> Why is a phandle required for this lookup, rather than doing it by
> compatible?

the phandle is used to select the sysconf SoC configuration register 
depending on the PCIe/USB3 mode (selected by xlate function), so it's 
not like a lookup here. This sysconf register is also used for other 
settings such as the PLL, Reference clock selection, ...

>
>> +
>> +  st,ssc-on:
>> +    type: boolean
> flag, not boolean, for presence based stuff. And in the driver,
> s/of_property_read_bool/of_property_present/.

ok

>
>> +    description:
>> +      A boolean property whose presence indicates that the SSC for common clock
>> +      needs to be set.
> And what, may I ask, does "SSC" mean? "Common clock" is also a bit of a
> "linuxism", what does this actually do in the hardware block?

SSC for Spread Spectrum Clocking. It is an hardware setting for the 100Mhz PCIe reference common clock,
I will rephrase the description

>
>> +
>> +  st,rx-equalizer:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 7
>> +    default: 2
>> +    description:
>> +      A 3 bit value to tune the RX fixed equalizer setting for optimal eye compliance
>> +
>> +  st,output-micro-ohms:
>> +    minimum: 3999000
>> +    maximum: 6090000
>> +    default: 4968000
>> +    description:
>> +      A value property to tune the Single Ended Output Impedance, simulations results
>> +      at 25C for a VDDP=0.8V. The hardware accepts discrete values in this range.
>> +
>> +  st,output-vswing-microvolt:
>> +    minimum: 442000
>> +    maximum: 803000
>> +    default: 803000
>> +    description:
>> +      A value property in microvolt to tune the Single Ended Output Voltage Swing to change the
>> +      Vlo, Vhi for a VDDP = 0.8V. The hardware accepts discrete values in this range.
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - reg
>> +  - resets
>> +  - reset-names
>> +  - st,syscfg
> The order here should reflect the ordering in a node, so compatible and
> reg first, rather than sorted alphanumerically.

ok

>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
>> +
>> +    combophy: phy@480c0000 {
> You can drop the label here, it ain't used by anything.

ok

thanks,
Christian

>
> Cheers,
> Conor.
>
>> +        compatible = "st,stm32mp25-combophy";
>> +        reg = <0x480c0000 0x1000>;
>> +        #phy-cells = <1>;
>> +        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
>> +        clock-names = "apb", "ker";
>> +        resets = <&rcc USB3PCIEPHY_R>;
>> +        reset-names = "phy";
>> +        st,syscfg = <&syscfg>;
>> +        access-controllers = <&rifsc 67>;
>> +        power-domains = <&CLUSTER_PD>;
>> +        wakeup-source;
>> +        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
>> +    };
>> +...
>> -- 
>> 2.34.1
>>

