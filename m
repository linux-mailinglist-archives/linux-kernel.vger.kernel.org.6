Return-Path: <linux-kernel+bounces-361004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231099A241
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D450B287C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CEE215F78;
	Fri, 11 Oct 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AbondbjL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EF2139A8;
	Fri, 11 Oct 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644671; cv=none; b=Hh9SvHBCrSULs4L8AK0xCjeqiJCBtuvmVU2Mgz1++NVnyJJtwkDJY5FZwPBLk8cNBcCcJ8cxjpP5yPSd+vyli9yy0Km4jvXFjlPbVM5FMLSzSzFMO34bGsmYssPGPP+F3CiFWPkm4qVf2fe/2ExufobJZVlrClQnUvIH+WCEXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644671; c=relaxed/simple;
	bh=WGs0/tOSNlSuoEY9fJmVOdWG/u/3NVWuvmnJAWDQmWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ulj5dwC86JT/ntbP/YW3LVFD67Qada2guX5plidJsVvCjjHbb1p6KUfq2Ps5nhpTkFvtrSFMg1evJf9o4vv8ue0whAWvLpRLp193VHV0x5NRERq9xQnF97xqhjm+TG827xMC31xW9NaDrgAANADfObiEIvokW1j1bcMzzTrDWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AbondbjL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BB4IwE094240;
	Fri, 11 Oct 2024 06:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728644658;
	bh=BLffsH81hrr/JaMi3ai6tb3GZGdxz3TIC973uYDN0Qw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AbondbjLxdv+E0N5kzh0PR5vY5qCfiR9wv5IsbPhTbE64vtmBcDKI2qTjpeO58yKm
	 z9lA6TXUJhr00LPuZbOkwUVOlj7ZGXcjh4RFR9LmikGW3B+pn3qGaQLU8nX1ZQYIfS
	 aZiVk2EZAh4v5t8QGQ/1abDZo6/V1xCEPgBm3TFc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BB4IxD047096
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 06:04:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 06:04:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 06:04:17 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BB4EF7130985;
	Fri, 11 Oct 2024 06:04:14 -0500
Message-ID: <c60d7bf0-b5e0-4957-bd0d-198022da817d@ti.com>
Date: Fri, 11 Oct 2024 16:34:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in cpsw_mac_syscon node
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <srk@ti.com>, <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20241011094814.64447-1-c-vankar@ti.com>
 <7fead0bc-de77-43f1-83c8-ef0a5318cfec@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <7fead0bc-de77-43f1-83c8-ef0a5318cfec@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/10/24 15:24, Siddharth Vadapalli wrote:
> On Fri, Oct 11, 2024 at 03:18:14PM +0530, Chintan Vankar wrote:
>> Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on linux-next tagged next-20241011.
>>
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 44ff67b6bf1e..912425f28052 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
>>   	};
>>   };
>>   
>> +&cpsw_mac_syscon {
>> +	bootph-all;
>> +}
> 
> Semicolon is missing. Please fix this.
> 

Thank You Siddharth for pointing out this. I have posted version 2 at
here:
https://lore.kernel.org/r/20241011110207.600678-1-c-vankar@ti.com/

> Regards,
> Siddharth.

