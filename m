Return-Path: <linux-kernel+bounces-304585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258E962226
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84D2866A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290C15B103;
	Wed, 28 Aug 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4ltcx8IF"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991515B99E;
	Wed, 28 Aug 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833066; cv=none; b=aR/d5JU+yJg0MXlHkugLC93JnBoTlc/UIYmW2aNAmgx+Knv3r3d1CKRXfjAi4JJJzYzn51WC7EW0rWcQ3+T8KCvYkKu5Uo5hDeF0D+Z3RMpkLXTK5f+gMVMVRHnUC4De/WYho33hwI/BXqWxGbtURJ8OUYdZJoMFqz1lGNaQ2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833066; c=relaxed/simple;
	bh=aUsYex0y6W1cxIZTyRhUVzw5iSPy6giVddYTLSpD4aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eidJp+U1oZ6egosWkb+HIakKW2I1zCASD471a73i/lOt0fCPZLMQAmXVbJbUxEfA+EHYvHbAgyndxqcTTDc6/N8kz36ED2E51rcxfjIhdZs9ZtF6CBjxVI/p2y5TjuO4bg18r6VKBaSWUJ0SgRkhFaJv1R4VXvi5yifJOYLSdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4ltcx8IF; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47S82eok005368;
	Wed, 28 Aug 2024 10:17:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rtTPWUUqmUCKTWA2bIbkcbnHPVzdag4uOv6xbrxbM/Q=; b=4ltcx8IFlq1GmsIH
	YJqbNeMq6yNy4535SLpzIMWNRzPGq2N/cRqQMgyRZnS8aksWtHisZAQxBNcg2vVc
	Uow8+yyxRSO0mhrLnXdnW36xQhqsuoj42DwGqi7h/qCzYha5VFA0gctxC3lqFce6
	8iE2ZItcVPULNaeyk9zXU0rlBeULb9Jg7vYQGMOIb9EAFLc02vRsq/Uq6N8fC22E
	8Q/Y4PCeY38VAN63cTj36E1ruXlJjBGPT+G5LwI7TQmEbQEWqvAVxp1bbccCr9eA
	WSydbQob8C50ontxXBsFdvVX8gMrlIum+AMoD2hGql/7T/1bSbSuOzeS0fQr32N0
	w78Emw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419wyvgks5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 10:17:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8266340044;
	Wed, 28 Aug 2024 10:17:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BAF324C42E;
	Wed, 28 Aug 2024 10:16:22 +0200 (CEST)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 28 Aug
 2024 10:16:21 +0200
Message-ID: <90ae7f29-19f8-4046-9b27-31739244e045@foss.st.com>
Date: Wed, 28 Aug 2024 10:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20240827122459.1102889-1-christian.bruel@foss.st.com>
 <20240827122459.1102889-2-christian.bruel@foss.st.com>
 <5f29a065-269d-4e72-81b8-30d247994fbd@kernel.org>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <5f29a065-269d-4e72-81b8-30d247994fbd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01


On 8/27/24 15:23, Krzysztof Kozlowski wrote:
> On 27/08/2024 14:24, Christian Bruel wrote:
>> Document the bindings for STM32 COMBOPHY interface, used to support
>> the PCIe and USB3 stm32mp25 drivers.
>> Following entries can be used to tune caracterisation parameters
>>   - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
>> to tune the impedance and voltage swing using discrete simulation results
>>   - st,rx-equalizer register to set the internal rx equalizer filter value.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> v1? Or v3?


sorry, forgot to update Subject: it is v3, will resend a v4 with your 
further comments

Regards

Christian

>
>> ---
>>   .../bindings/phy/st,stm32-combophy.yaml       | 144 ++++++++++++++++++
>>   1 file changed, 144 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
>> new file mode 100644
>> index 000000000000..c33a843b83a3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> Filename matching compatible.

ok

>
>> @@ -0,0 +1,144 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/st,stm32-combophy.yaml#
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
>> +    description: |
>> +      The cells contain the following arguments.
>> +
>> +      - description: The PHY type
> That's some sort of mess. Is it schema within description or schema? Why
> two descriptions?

yes, indeed

>> +          enum:
>> +            - PHY_TYPE_USB3
>> +            - PHY_TYPE_PCIE
>> +
> ...
>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - st,syscfg
>> +  - '#phy-cells'
>> +  - resets
>> +  - reset-names
>> +  - clocks
>> +  - clock-names
>> +
>> +allOf:
>> +  - if:
>> +      required:
>> +        - wakeup-source
>> +    then:
>> +      anyOf:
>> +        - required: [interrupts]
>> +        - required: [interrupts-extended]
>> +
> I do not see any improvements.
>
> The tag you received was CONDITIONAL. If you do not apply the comments,
> you cannot just apply the tag.

my mistake again.


> Best regards,
> Krzysztof
>

