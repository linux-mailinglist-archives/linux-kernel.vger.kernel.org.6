Return-Path: <linux-kernel+bounces-172973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61BA8BF99A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1B283D71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF276037;
	Wed,  8 May 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TVGgilRZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810FBA39;
	Wed,  8 May 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161120; cv=none; b=VyAFCYuL3FeD5rCasFDfYEcY7fbqqCygOj2RXOGkAuZ1KN3Vs1doo2s4EuqBw7PhwO0ayi66Al3lMTt7eunYXDmrLMMYITDQd0bDurzgqFzr3CZUvNWm+LcpAV4ZrdYEpQIKV02OpqoTBRvDLHCLXUB7EXhT88h+6pAg7FnI5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161120; c=relaxed/simple;
	bh=1H9IvDj54BGaod2j76jKgisXrxX1D99LzNnw+l+mblA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eyuUtVHelZ3avxPMihd25W5OlAc+QcRTSZgFNSUBdvDMMmUMlaEuwSmW0WBe0UIkxzyooSFqNj8a+r9A17MO/qDLFhlRU0+tsivxuWCilt7V8HN0m3ssfzfRkuvhX2yZGIh3YJi+HO/0O72MDevpFQ8apGYzvvURZH2RGnp1gok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TVGgilRZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4489cQhv107634;
	Wed, 8 May 2024 04:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715161106;
	bh=6sFj4TRv+mWm2gwnLmvR0xCJWo1wPIZ0KZaV5KYBhUc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TVGgilRZ0WpNmohfsVnM508aVOCLWS2ndjzoQWzkl4/ww5Lk5FKJCbyeUI3+bf+RZ
	 rsGVUALr0ePVuDaROf6f5zn5n9L29YKzsE27vLFoAR1lHohxjBx+G0kn4sGmTYLz4h
	 25BXyXcxDflG8b6O8mXVD0vjOh9ZsfP2cZizEAV0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4489cQM7089838
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 04:38:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 04:38:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 04:38:25 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4489cLFc055890;
	Wed, 8 May 2024 04:38:22 -0500
Message-ID: <10c56e60-9de4-de79-edba-5034ae7438e0@ti.com>
Date: Wed, 8 May 2024 15:08:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j722s: Redefine USB1 node
 description
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-3-r-gunasekaran@ti.com>
 <9c6f8999-715f-42e3-8d13-a5aef074dd5d@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <9c6f8999-715f-42e3-8d13-a5aef074dd5d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/7/24 10:45 PM, Andrew Davis wrote:
> On 4/29/24 7:09 AM, Ravi Gunasekaran wrote:
>> USB1 controller on J722S and AM62P are from different vendors.
>> Redefine the USB1 node description for J722S by deleting the
>> node inherited from AM62P dtsi.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j722s.dtsi | 39 ++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> index beba5a3ea6cc..90725eeb3178 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> @@ -13,6 +13,13 @@
>>     #include "k3-am62p5.dtsi"
>>   +/*
>> + * USB1 controller on AM62P and J722S are of different IP.
>> + * Delete AM62P's USBSS1 node definition and redefine it for J722S.
>> + */
>> +
>> +/delete-node/ &usbss1;
>> +
>>   / {
>>       model = "Texas Instruments K3 J722S SoC";
>>       compatible = "ti,j722s";
>> @@ -120,6 +127,38 @@
>>               status = "disabled"; /* Needs lane config */
>>           };
>>       };
>> +
>> +    usbss1: cdns-usb@f920000 {
> 
> MAIN domain items are defined in -main.dtsi files, for instance the
> USB node you are overriding was defined in k3-am62p-main.dtsi.
> This should go in a file named k3-j722s-main.dtsi.
> 
> Andrew
> 

Ok. I will introduce k3-j722s-main.dtsi newly and define the USB 
and SerDes nodes there. 

[...]

-- 
Regards,
Ravi

