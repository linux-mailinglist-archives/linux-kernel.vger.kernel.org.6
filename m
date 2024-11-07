Return-Path: <linux-kernel+bounces-399791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85B9C043F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BCA2812D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE71DFE2C;
	Thu,  7 Nov 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sNqKVIz1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFE20B203;
	Thu,  7 Nov 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979392; cv=none; b=itReK8ThBBY3PDX70FSOhfOokjq5pqyWrCDrDlYCLgtFSsKluNtW1cQYrewZEKx3wsvTSsuif7iJNEJhyL/+GYh5b+ailEAJoDjya/i42JfCDH3tEEeNIEfpE1Yr5++LcZQ1qAhHNpY+dhVGSiHlSvPoyTF1y1u86TVPuVJ6W5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979392; c=relaxed/simple;
	bh=GF5AHixkReSD2riGo0l+2r0QMuQOilOzP0GE3uMYLrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TsLQdq4ren8921765jSFSHNUzNugEt5yMmblDf4JvuDAK6rgTnqka9/EnpknCMe5f/FXp5H0N9Xo8Nl8t2piwKYDS8PNc9sZbzcmm4daBJ7BJ7GkXe/jvl6YejadfxGfqSquk7vDiweh60E0znPBD7UuE6ET5Zkip3ixZTuNDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sNqKVIz1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7BaNBO055275;
	Thu, 7 Nov 2024 05:36:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730979383;
	bh=9Cj5IJyE4rxnvpPnUVWzeAgGlJZVWNKjg29ev+YTrS4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sNqKVIz1kynTrYCn4I4kYfNdF+KHUn7D5shoJY3gcOTfkv7UpvVyi9E6IsNgMHsqG
	 rHMaevWTfglj6qzCq8rNQ72Q4WzeA0IXCyalp3mcZe2dh/nAksRNQsqsBbQvPzTOBw
	 MRyVH2/F+uwEnSb+ANukU25FTGm+ltWxJKyI8scI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7BaNkZ076465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 05:36:23 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 05:36:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 05:36:23 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7BaISi092269;
	Thu, 7 Nov 2024 05:36:19 -0600
Message-ID: <8156fd61-c476-4b58-b3b2-e8bc4f93035e@ti.com>
Date: Thu, 7 Nov 2024 17:06:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: Krzysztof Kozlowski <krzk@kernel.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <ssantosh@kernel.org>,
        <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241107104557.1442800-1-danishanwar@ti.com>
 <20241107104557.1442800-2-danishanwar@ti.com>
 <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 07/11/24 5:01 pm, Krzysztof Kozlowski wrote:
> On 07/11/2024 11:45, MD Danish Anwar wrote:
>> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG
> 
> Why? We see what you are doing from the diff, no point to repeat it. I
> don't understand why you are doing it.
> 
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index 3cb1471cc6b6..cf4c5884d8be 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -92,6 +92,17 @@ properties:
>>      description: |
>>        This property is as per sci-pm-domain.txt.
>>  
>> +  clocks:
>> +    items:
>> +      - description: ICSSG_CORE Clock
>> +      - description: ICSSG_ICLK Clock
>> +
>> +  assigned-clocks:
>> +    maxItems: 1
>> +
>> +  assigned-clock-parents:
>> +    maxItems: 1
> 
> Why? This is really not needed, so you need to explain why you are doing
> things differently than entire Linux kernel / DT bindings.
> 

I need to add this to the device tree node

+		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
+			 <&k3_clks 81 20>; /* icssg0_iclk */
+		assigned-clocks = <&k3_clks 81 0>;
+		assigned-clock-parents = <&k3_clks 81 2>;

But without the above change in the binding I am getting below errors
while running dtbs check.

/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30000000:
'assigned-clock-parents', 'assigned-clocks' do not match any of the
regexes: '^(pru|rtu|txpru)@[0-9a-f]+$', '^pa-stats@[a-f0-9]+$',
'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$', 'interrupt-controller@[a-f0-9]+$',
'mdio@[a-f0-9]+$', 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$',
'mii-rt@[a-f0-9]+$', 'pinctrl-[0-9]+'
+/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30080000:
'anyOf' conditional failed, one must be fixed:

To fix this warning I added these in the binding and the warnings were
fixed.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish

