Return-Path: <linux-kernel+bounces-233364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56391B618
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B3EB219A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7C3B79C;
	Fri, 28 Jun 2024 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tFXLRQtF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB228DBC;
	Fri, 28 Jun 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552420; cv=none; b=Z30K1cdG9s0hHrfzQziM4/vpZLMcN/aHIfGvkagMnvFQiNdEkqj0JUWdXk/aB9I0W0MnrihGrxM6YRijBDski2R8dR8KXLqpMUsga6I5hcReYHAFzZ3sj9GRAQ616sOizhv/s8/eATfGHs+VICuwWm+2tqR+wwiJztVvM+FMYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552420; c=relaxed/simple;
	bh=pRoWdeF2jbNMhJS63roev+S/A0niexAnRVPWPO3ytFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YIAmGpNv/K+Xd7XromsGt9QgV1VTqLQw/cVo0+5iHiQpGBSyX7XVESbsAdhNyhW4B6em8wA+GXdSnuTn+345YIsaomXiMcEe+x7V24qL+V6OFc5Qr0Y66RAtO7oAtJH+32ksL2qwgVtItKqhyNNdtur/W3BwXPe8QVgPdrSZwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tFXLRQtF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S5QjEe108323;
	Fri, 28 Jun 2024 00:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719552405;
	bh=N+rs/klw1odJBrrkwhC/JdAMA5IUto2q00ck0VuZHuM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tFXLRQtFnAwM0p+XmGqNO5v1q4VCEXu3dOq8yRXfLiI5it+ykxoAPR+LZaZK9pPVg
	 g3tZs+f8HePUDYg97B/rP7oj54gJwqNbJry3Xn35BhP0+6vkZRs9/XpiD/KNgO+jdN
	 AouvbRkLsb2N/lRo3RtZYK4uFxGBdx7dnPIXaVjY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S5Qjvw006714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 00:26:45 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 00:26:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 00:26:45 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S5QeGU082044;
	Fri, 28 Jun 2024 00:26:41 -0500
Message-ID: <cca91f88-d7cd-42e3-a4f3-065d536e623b@ti.com>
Date: Fri, 28 Jun 2024 10:56:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
To: Nishanth Menon <nm@ti.com>
CC: Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240625153319.795665-1-danishanwar@ti.com>
 <20240625153319.795665-3-danishanwar@ti.com>
 <20240627144538.mp7n2l7kupi7gt4l@straddle>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240627144538.mp7n2l7kupi7gt4l@straddle>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 27/06/24 8:15 pm, Nishanth Menon wrote:
> On 21:03-20240625, MD Danish Anwar wrote:
>> Add documentation for pa-stats node which is syscon regmap for
>> PA_STATS registers. This will be used to dump statistics maintained by
>> ICSSG firmware.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index c402cb2928e8..3cb1471cc6b6 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -278,6 +278,26 @@ patternProperties:
>>  
>>      additionalProperties: false
>>  
>> +  ^pa-stats@[a-f0-9]+$:
>> +    description: |
>> +      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
>> +      registers where different statistics related to ICSSG, are dumped by
>> +      ICSSG firmware. This syscon sub-module will help the device to
>> +      access/read/write those statistics.
>> +
>> +    type: object
>> +
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: ti,pruss-pa-st
>> +          - const: syscon
>> +
>> +      reg:
>> +        maxItems: 1
>> +
> 
> Is this a patch in a driver series? I do not see the driver part..

No Nishant, this is not a part of driver series. This binding patch is
related to [1] which is merged to net-next. The regmap will not be used
by drivers/soc/ti driver instead once both binding are in, the driver
changes will be needed in drivers/net/ethernet/ti/icssg/icssg_prueth.c
as there is no driver changes needed in drivers/soc/ti, I posted this
patch as stand alone. Considering this binding and [1] they both go to
different tree, I decided to get the bindings in first and in next
kernel cycle when they both are part of mainline linux, I can post the
driver changes.

> if this is a memory map, why doesn't bus model work?
> 

I am just trying to maintain consistency here. pa-stats sub-module is
similar to mii-g-rt and mii-rt. I am adding pa-stats in the same way as
mii-g-rt and mii-rt.

All these three modules are eventually mapping a memory region so that
the icssg driver can use them and read / configure registers.

> 
>>    interrupt-controller@[a-f0-9]+$:
>>      description: |
>>        PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
>> -- 
>> 2.34.1
>>
> 

[1] https://lore.kernel.org/all/20240529115225.630535-1-danishanwar@ti.com/

-- 
Thanks and Regards,
Danish

