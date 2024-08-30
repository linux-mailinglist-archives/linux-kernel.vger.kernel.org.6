Return-Path: <linux-kernel+bounces-308811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A7966212
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEC7280AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A817BB0C;
	Fri, 30 Aug 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XvVM3Cf3"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B519995B;
	Fri, 30 Aug 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022473; cv=none; b=OxEeUsBDhR8oaEOt+X0jjf7GZO5pMe2409bbNlq8U4wJ5U28nzhCoGR1jasK1HNbqTcVIjmb8ZskAjDOZRd1NiCTqJ2p46mSxc/19gKc87JJ1jQ3QwP+A15dlHyLFgnVmUzx+JRbaSkZBAXJayJUbGdu0s8qWHSpKhFSJ81AJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022473; c=relaxed/simple;
	bh=puOrTcPQKUcghpGgZDavlc5G7R7Fx/f1UUt1PYOaMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lcHpdSJjj2z7M75IPNZkv44srg50vJ8sljeIw6LJKiOO62WV/yRQ9LzE5m5Xt+ZsxzEXkPzN86NWBL2vRrQcoiRnESQCbZ/iSdr0yx2pCIsn8SFXpNoxDLkizhkL4wGKUrB/hXCOMOFqCgsdF07UGoKN3MvLSzJ21wn+IpJJXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XvVM3Cf3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U9mcvg031627;
	Fri, 30 Aug 2024 14:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4uZ4dJscv0h077nNmSbVtKRKNbSXKqTdy9AY3iKyYOk=; b=XvVM3Cf3beE9mLtv
	K+oTaMCd+TsqkvVctBnxeep5PWpu0qme14Qc/h03KFQoAfjrr34RJMETAMhq5+fX
	cKOUX1IoZ5J73sxy4POCe6tfpa/c1ERq+D5rMa4NNMNbRDdh0VBSuajrqMdpetj4
	jx1Rdi7M5YRVpd++AuwTUz5N/f0vuKTKbHftxSYbwPzYPWJqdcQbgXkFb5PdLgoo
	4cM7D3gCnfUDA7LnAHN5vlykofScmOHN5vIIktw2oo+DJL4QHzz9NJNnJyIfroBG
	SKq4NqzCOBYc66r+jU1TYkrd3y+yD3BI1IYXndkTwBMWRY1GcV+Fc8Py122bJPX2
	IWjc5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419putmpp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 14:54:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 94E2F40044;
	Fri, 30 Aug 2024 14:54:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60D5B2656DE;
	Fri, 30 Aug 2024 14:53:16 +0200 (CEST)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 14:53:15 +0200
Message-ID: <777a92d9-ed52-4fa1-b235-e3a4a6321634@foss.st.com>
Date: Fri, 30 Aug 2024 14:53:15 +0200
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
 <005a2f7d-ab46-46c8-a0cc-b343685caf7c@foss.st.com>
 <20240829-manifesto-tray-65443d6e7e6e@spud>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20240829-manifesto-tray-65443d6e7e6e@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_07,2024-08-30_01,2024-05-17_01


On 8/29/24 18:44, Conor Dooley wrote:
> On Thu, Aug 29, 2024 at 01:06:53PM +0200, Christian Bruel wrote:
>> On 8/28/24 18:11, Conor Dooley wrote:
>>> On Wed, Aug 28, 2024 at 04:34:48PM +0200, Christian Bruel wrote:
>>>> Document the bindings for STM32 COMBOPHY interface, used to support
>>>> the PCIe and USB3 stm32mp25 drivers.
>>>> Following entries can be used to tune caracterisation parameters
>>>>    - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
>>>> to tune the impedance and voltage swing using discrete simulation results
>>>>    - st,rx-equalizer register to set the internal rx equalizer filter value.
>>>>
>>>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>>>> ---
>>>>    .../bindings/phy/st,stm32mp25-combophy.yaml   | 128 ++++++++++++++++++
>>>>    1 file changed, 128 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>>>> new file mode 100644
>>>> index 000000000000..8d4a40b94507
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>>>> @@ -0,0 +1,128 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/phy/st,stm32mp25-combophy.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
>>>> +
>>>> +maintainers:
>>>> +  - Christian Bruel <christian.bruel@foss.st.com>
>>>> +
>>>> +description:
>>>> +  Single lane PHY shared (exclusive) between the USB3 and PCIe controllers.
>>>> +  Supports 5Gbit/s for USB3 and PCIe gen2 or 2.5Gbit/s for PCIe gen1.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: st,stm32mp25-combophy
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#phy-cells":
>>>> +    const: 1
>>>> +
>>>> +  clocks:
>>>> +    minItems: 2
>>>> +    items:
>>>> +      - description: apb Bus clock mandatory to access registers.
>>>> +      - description: ker Internal RCC reference clock for USB3 or PCIe
>>>> +      - description: pad Optional on board clock input for PCIe only. Typically an
>>>> +                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
>>>> +                     clock input instead of the ker
>>>> +
>>>> +  clock-names:
>>>> +    minItems: 2
>>>> +    items:
>>>> +      - const: apb
>>>> +      - const: ker
>>>> +      - const: pad
>>>> +
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  reset-names:
>>>> +    const: phy
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  wakeup-source: true
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +    description: interrupt used for wakeup
>>>> +
>>>> +  access-controllers:
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>> Can you please describe the items here?
>> I can specialize the description: "Phandle to the rifsc firewall device to check access right."
> Right, but there are potentially two access controllers here. You need
> to describe which is which, so that people can hook them up in the
> correct order. In what case are there two? Your dts patch only has one.

(sorry, resent in plain test)

yes, we don't have more than 1 controller in the current setup,

I'll use maxItems: 1

>> otherwise described in access-controllers/access-controllers.yaml, see also bindings/bus/st,stm32mp25-rifsc.yaml
>>
>>>> +  st,syscfg:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: Phandle to the SYSCON entry required for configuring PCIe
>>>> +      or USB3.
>>> Why is a phandle required for this lookup, rather than doing it by
>>> compatible?
>> the phandle is used to select the sysconf SoC configuration register
>> depending on the PCIe/USB3 mode (selected by xlate function), so it's not
>> like a lookup here.
> If "syscon_regmap_lookup_by_phandle()" is not a lookup, then I do not
> know what is. An example justification for it would be that there are
> multiple combophys on the same soc, each using a different sysconf
> region. Your dts suggests that is not the case though, since you have
> st,syscfg = <&syscfg>; in it, rather than st,syscfg = <&syscfg0>;.

I didn't get your suggestion earlier to use "syscon_regmap_lookup_by_compatible()".

We have several other syscon in the other. That's why we choose a direct syscfg phandle

>
>> This sysconf register is also used for other settings
>> such as the PLL, Reference clock selection, ...
>>
>>>> +
>>>> +  st,ssc-on:
>>>> +    type: boolean
>>> flag, not boolean, for presence based stuff. And in the driver,
>>> s/of_property_read_bool/of_property_present/.
>> ok
>>
>>>> +    description:
>>>> +      A boolean property whose presence indicates that the SSC for common clock
>>>> +      needs to be set.
>>> And what, may I ask, does "SSC" mean? "Common clock" is also a bit of a
>>> "linuxism", what does this actually do in the hardware block?
>> SSC for Spread Spectrum Clocking. It is an hardware setting for the 100Mhz PCIe reference common clock,
> Ah, so not really a "common clock" linuxism at all.
>
>> I will rephrase the description
> How is someone supposed to decide between on and off? Is it always on
> for PCIe, or only on in some configurations? Or maybe only (or always?) on
> if the pad clock is provided?

SSC is off by default and available for the PCIe pad clock. it must be defined for USB3

thanks

Christian

>
> Cheers,
> Conor.

