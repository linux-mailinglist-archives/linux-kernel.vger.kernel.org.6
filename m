Return-Path: <linux-kernel+bounces-178341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBA8C4C27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FDB1C21312
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C11CD2B;
	Tue, 14 May 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D2+u+eYJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30588208C3;
	Tue, 14 May 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715666652; cv=none; b=fowtWwBhWn3vWw/B9jJOZ1cFVkP1t03x0nRnOHsTIpCA/aNYNEK1sA3VM+lPmMDG2GvnFmZZz7AVt6qrqUnpsFAD/YLj9CsSkp+fHUTR2NpfcUXI2tzwSXMKHiJeHEI6xMGZRu6Sj9xXPC/3gQHv/6mmYdesJbhnwKx3G9oIBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715666652; c=relaxed/simple;
	bh=SBj4zRWJ5U7N1De1j6b7/mipglpMDjo74vTCV5thJOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lt3CuTvZZcMW2HIfoUBOgThoVOzWppvy9M4LT+dHWr4go1smBVcqxdGzDvLHvhanGupMGSLe/0ppRrisq2wNx5fbyr9hm/G+S31HXEiSbq8PCag0V1i871WcbuZcu8LlCSwoyCpGMtpjkXWLIXKTpVR6dMVmFwLDR3hXzP9cz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D2+u+eYJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E644ea119127;
	Tue, 14 May 2024 01:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715666644;
	bh=Cwa/dZ8r2Vkm4lraGU0DMeoDj07ahS1Z7Ekt+cihs6E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D2+u+eYJfLbWUXehGC3U9F141+HhsE3antmD5Ma9gxKgQ+zwlufSC2XGghw+TLVEi
	 51hpE+yEGrp2IsbkhDX4P+kQfxe+XFLN+PvvQkyXaBVnLUWau6LfcR0781FRYPsPIh
	 LOG5CKE3rEFxdWtF2OPVOMffo8Shsm8huAxKDxhQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E644cw058612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 01:04:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 01:04:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 01:04:04 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E640F6039958;
	Tue, 14 May 2024 01:04:01 -0500
Message-ID: <bb323edd-ceac-4811-bdea-51cba429659b@ti.com>
Date: Tue, 14 May 2024 11:33:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Suman Anna <s-anna@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240430121915.1561359-1-danishanwar@ti.com>
 <7742b3d6-b513-43f2-803a-dec83eb37116@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <7742b3d6-b513-43f2-803a-dec83eb37116@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Krzysztof,

On 01/05/24 3:58 pm, Krzysztof Kozlowski wrote:
> On 30/04/2024 14:19, MD Danish Anwar wrote:
>> Add documentation for pa-stats node which is syscon regmap for
>> PA_STATS register. This will be used to dump statistics maintained by
>> ICSSG firmware.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml    | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index c402cb2928e8..cb6f41660847 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -278,6 +278,23 @@ patternProperties:
>>  
>>      additionalProperties: false
>>  
>> +  pa-stats@[a-f0-9]+$:
> 
> Missing ^
> 

Sure, I will add that.

>> +    description: |
>> +      PA-STATS sub-module represented as a SysCon.
>> +
>> +    type: object
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: ti,pruss-pa-st
>> +          - const: syscon
>> +
> 
> No resources? So you use it just to instantiate Linux driver? That's not
> the purpose of DT. Just squash it into parent node?
> 

I am trying to module pa-stats as a regmap just like mii-rt and
mii-g-rt. ICSSG has different segments for storing different types of
registers. mii-rt, starting at 0x32000 have registers that stores mainly
TX and RX configurations. mii-g-rt, starting at 0x33000 have registers
that stores hardware statistics counters (TX RX good frame, drop etc).
Similarly pa-stats starting at 0x2c000 have registers that stores some
diagnostic counters which is maintained by firmware. ICSSG firmware
stores statistics other than hadrware statistics like if the packet was
pushed to dma or not. Why was the packet dropped etc. This is very
helpful in debugging failures. Also ICSSG firmware maintains all TSN
related statistics in this memory only, which will be needed to be
dumped from driver once TSN support is enabled (the patches for that are
still under review).

More or less the functionality of pa-stats here is same as mii-rt and
mii-g-rt and that is why I am trying to describe the node in exactly the
same way as the other two nodes.

>> +      reg:
>> +        maxItems: 1
>> +
>> +    additionalProperties: false
> 
> Put it after type:object.
> 

Sure, will move it.

>> +
>>    interrupt-controller@[a-f0-9]+$:
>>      description: |
>>        PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish

