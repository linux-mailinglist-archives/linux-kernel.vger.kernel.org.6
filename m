Return-Path: <linux-kernel+bounces-278125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB494AC3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6561A1C20F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C784E04;
	Wed,  7 Aug 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wJsu56q/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00043374CC;
	Wed,  7 Aug 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043596; cv=none; b=Ri3+9hjtNgkzycCECnsHG8uiIu03BQVghazNUrCqaU687AuYqJymPW8JF9TfnE6lFn+yxufcsc6gMm9ltGzQdF6a93jzdj4vKPQ3vUFpbU8bG55g42tQBMixwYYSP9tXyBn95ektEiU1tmK7uckQesPSu6bkz48gAS1Wf9LY6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043596; c=relaxed/simple;
	bh=KOo4MZKjhP06xpv399bAglKdEuDUCZzAEeA0jCGjH/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KSO7IILzE+SBLlNdZvLJnxBT7xcOy/WGfadzRfyMWo4/AOy8zm1auw3VXfX2qL8nfYqoG625Ekn3eU5PmLmPWubmZ9Y6CZjWv6kISe+5Ow+S9s4iJOFoYm6XmcEUaD6gJO3+U9THIw2PUjCZpcrHJzU+rmQc1mPUGUII5nVtmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wJsu56q/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477FD8OH044454;
	Wed, 7 Aug 2024 10:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723043588;
	bh=EqiEi6gcJd1o/ec/55Ce7FhYxlxTZS8VSj9smEeEChM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wJsu56q/jWV5lgn3xRn4HuyoYcPNoiRIv5quwtVlZhB60X6zupjGlcAncWadqUPlN
	 RWkJiTerXJfl9jAxe+Jq1Bxtng9da7MmDj9BL3pxUvxZNUF68k5txfoxw76ibhYBLY
	 c9dbb7nWl4o1CNmrpzte+AgpWIiaq6/58iuKKsp0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477FD8ZY068513
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 10:13:08 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 10:13:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 10:13:08 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477FD7Zg066163;
	Wed, 7 Aug 2024 10:13:07 -0500
Message-ID: <65047cc9-011b-46d3-939e-b7733c2f0fe2@ti.com>
Date: Wed, 7 Aug 2024 10:13:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62p: Remove 'reserved' status
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar
	<s-k6@ti.com>,
        Bryan Brattlof <bb@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
 <20240806214605.3379881-4-jm@ti.com>
 <20240807114605.ggieur532eh4usus@diagram>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240807114605.ggieur532eh4usus@diagram>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 8/7/24 6:46 AM, Nishanth Menon wrote:
> On 16:46-20240806, Judith Mendez wrote:
>> From: Santhosh Kumar K <s-k6@ti.com>
>>
>> Remove 'reserved' status for MCU ESM node in AM62P device tree.
> 
> Why?

Main ESM reset is routed to the MCU ESM, hense enable
MCU ESM in DT to be able to reset the CPU.


>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> index e65db6ce02bf6..d913e6319bad8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
>> @@ -27,7 +27,6 @@ mcu_esm: esm@4100000 {
>>   		compatible = "ti,j721e-esm";
>>   		reg = <0x00 0x4100000 0x00 0x1000>;
>>   		ti,esm-pins = <0>, <1>, <2>, <85>;
>> -		status = "reserved";
>>   		bootph-pre-ram;
>>   	};
>>   
>> -- 
>> 2.45.2
>>
> 


