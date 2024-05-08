Return-Path: <linux-kernel+bounces-172976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87128BF9A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D40C1F24B94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78345762DF;
	Wed,  8 May 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gVOfzAbj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798E75811;
	Wed,  8 May 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161189; cv=none; b=k4iY8agMePlD0vL1j1CsfvlvN/vhXH5taTP35Y18VlOaQp73b0snOTkWj8e7GqFIDD2Kci93vLxDo4qa7g0Gz0TImEV3ul50dqGtV7laMyrbZo6sWb0dnVW7oZAP7gbNBSgMAPMW4vKAXihhgMDMTURMYaMHT7QIXt8g5ho5cJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161189; c=relaxed/simple;
	bh=tooO+PnKs4QuJyhK8dQd4N8Ll7R1cRiwaAFITlTvBKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WEBhLYwROuAQQ59/ndJUOQiRevrR8D5oNtswQXbMqIByftKWTJ0BT5tcRcGBOBp6egBCRHNkejPHfIeksxXgXDRTiFguNA7jeiKy/7oI8wtf/YEHi33eRGdz0waQjG0ubADZ5xe96MW7r1MFh8kJFBkWPJ9KvYJM0nn0o1E9Psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gVOfzAbj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4489dg0g108024;
	Wed, 8 May 2024 04:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715161182;
	bh=OUWrbCU48QMw/LpDyFtgC8ZGVV6wJUg+tB4jL7Mcw+o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=gVOfzAbjdBayCgJe2IbJ1igCDAIr/W5yWouQKPc7aMNAW+gsHz3Gcf4ghCxrMUqzD
	 skJzhIUw35PoEbN6BaCFsLY2w9kgPSO7QfKOCyLr7fPdNJAsxl7ekJoBQVHnlP9c4W
	 5WmYqRnUM79VEVCYaZ83AkggB4ctqaRB9HESicL4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4489dgi2031181
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 04:39:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 04:39:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 04:39:42 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4489dcRN036983;
	Wed, 8 May 2024 04:39:39 -0500
Message-ID: <5167d813-d5ff-eb3e-ea6e-68e5a5acf39e@ti.com>
Date: Wed, 8 May 2024 15:09:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
 configuration for EVM
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-4-r-gunasekaran@ti.com>
 <20240507150123.GA471367-robh@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240507150123.GA471367-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/7/24 8:31 PM, Rob Herring wrote:
> On Mon, Apr 29, 2024 at 05:39:32PM +0530, Ravi Gunasekaran wrote:
>> The GPIO expander on the EVM allows the USB selection for Type-C
>> port to either USB0 or USB1 via USB hub. By default, let the Type-C
>> port select USB0 via the GPIO expander port P05.
>>
>> Enable super-speed on USB1 by updating SerDes0 lane configuration.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 58 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-serdes.h      |  7 +++
>>  2 files changed, 65 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index bf3c246d13d1..ddb4f1f0d92d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -9,7 +9,9 @@
>>  /dts-v1/;
>>  
>>  #include <dt-bindings/net/ti-dp83867.h>
>> +#include <dt-bindings/phy/phy.h>
>>  #include "k3-j722s.dtsi"
>> +#include "k3-serdes.h"
>>  
>>  / {
>>  	compatible = "ti,j722s-evm", "ti,j722s";
>> @@ -20,6 +22,8 @@
>>  		serial2 = &main_uart0;
>>  		mmc0 = &sdhci0;
>>  		mmc1 = &sdhci1;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
> 
> Why is this needed? Doesn't look related?

I rechecked, it is not needed, I will remove it in v2.

> 
>>  	};
>>  

[...]

-- 
Regards,
Ravi

