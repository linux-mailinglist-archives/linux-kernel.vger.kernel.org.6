Return-Path: <linux-kernel+bounces-425281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C009DBFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCB1643A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C746615853A;
	Fri, 29 Nov 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TCbAFh52"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F72184F;
	Fri, 29 Nov 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732866232; cv=none; b=Lq2mxPxUuclaAJtIt2/u6C0dvcFHCsLrAXyCY+KSL/RvskfHBB5rOerx0wfkfCd3A9NvDoa7GhVUVzlHYyXaw/BZ+YQNOgsDmQDfFRcHhgd/JhOKn5THo6mK7KdazJ9GCOhkPvp1u9rrg+hs6AhG87mOTgBI7BK/yTDWrG5tdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732866232; c=relaxed/simple;
	bh=nWl+SBjBL88FkNXWPG3di7uq91tabKWoZ5Xj+VHBPJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O0Y4n3X0qe7rxmToc8fW+fZkLC1GCX8GtoFDWD1pzwBeuFl0t+eWM6yCp1T7ezL/p0Jphh7ieqEyEwU9L1XNdrFKJIub7AXa9XY/3QiEWv2Tn8sAzOXqB01S0su9O227gVQUlsBMJD5AZ7zZml8VKZZmwhKYTRY0RRyD1Tlhw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TCbAFh52; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AT7hgCU1176583
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Nov 2024 01:43:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732866222;
	bh=i+VOgi3ShpiE5xL6iV8G4IpokAHnM4RxqSBIORD7UlE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TCbAFh52ZPDdKt0DRL0h/9PORAW74zfPh/rT3k9kdcZoEU2mirDUbn+LSaWwcmNoD
	 wrVWx6A9gjAcyanFN9JofzNCmQM/j8DMc9h//gvtRPOMoUxasB7NLZXNxD7y0P91wh
	 SBN1JJmcvEK7xfQPB8euAZY9NnVUt8/wYZk3zr4E=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AT7hg0l041410;
	Fri, 29 Nov 2024 01:43:42 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 01:43:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 01:43:41 -0600
Received: from [10.24.69.37] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AT7hcmc098842;
	Fri, 29 Nov 2024 01:43:39 -0600
Message-ID: <837d329b-bcdd-4c3b-b508-e916b110ce25@ti.com>
Date: Fri, 29 Nov 2024 13:13:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: bist: Add BIST dt-binding for TI
 K3 devices
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20241128140825.263216-1-n-francis@ti.com>
 <20241128140825.263216-2-n-francis@ti.com>
 <ho7ktcnbtl7mvamfthqho23co2fc4z7bgjha7pu4wivxm6ndhu@tfbpveonhckz>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <ho7ktcnbtl7mvamfthqho23co2fc4z7bgjha7pu4wivxm6ndhu@tfbpveonhckz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 29/11/24 12:50, Krzysztof Kozlowski wrote:
> On Thu, Nov 28, 2024 at 07:38:24PM +0530, Neha Malcom Francis wrote:
>> Document the binding for TI K3 BIST (Built-In Self Test) block.
>>
> 
> A nit, subject: drop second/last, redundant "dt-binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   .../bindings/misc/ti,j784s4-bist.yaml         | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
> 
> soc directory, not misc.
> 
>>
>> diff --git a/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
>> new file mode 100644
>> index 000000000000..bd1b42734b3d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Texas Instruments Incorporated
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/ti,j784s4-bist.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 BIST
>> +
>> +maintainers:
>> +  - Neha Malcom Francis <n-francis@ti.com>
>> +
>> +description:
>> +  The BIST (Built-In Self Test) module is an IP block present in K3 devices
>> +  that support triggering of BIST tests, both PBIST (Memory BIST) and LBIST
>> +  (Logic BIST) on a core. Both tests are destructive in nature. At boot, BIST
>> +  is executed by hardware for the MCU domain automatically as part of HW POST.
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,j784s4-bist
>> +
>> +  reg:
>> +    minItems: 2
> 
> Drop minItems
> 
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: cfg
>> +      - const: ctrl_mmr
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  ti,bist-instance:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      the BIST instance in the SoC represented as an integer
> 
> No instance indices are allowed. Drop.
> 

Question on this, this is not a property that is driven by software but rather 
indicates which register sequences have to be picked up for triggering this test 
from this instance. So I don't see how I can workaround this without getting 
this number. Or maybe call it ID rather than instance?

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - ti,bist-instance
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        bist@33c0000 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Come with something, don't just use device name.
> 
>> +            compatible = "ti,j784s4-bist";
>> +            reg = <0x00 0x033c0000 0x00 0x400>,
>> +            <0x00 0x0010c1a0 0x00 0x01c>;
> 
> Misaligned code.
> 
> Best regards,
> Krzysztof
> 

For the rest of the comments, got it! thanks for the review!

-- 
Thanking You
Neha Malcom Francis

