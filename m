Return-Path: <linux-kernel+bounces-407291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C999C6B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1291C282363
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCA1F77B9;
	Wed, 13 Nov 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZqmZO5Rs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328B17CA1F;
	Wed, 13 Nov 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489952; cv=none; b=L0gtsgQhe6cywtbtFvfPvbOK5yH3hu/Cq8IO/dNFvPYJm8xObeGYtmydHGzC6MdOIrJ5q8XJO9Uox29/+ZkE1TyywmxZyfJHbgq/L7CqaGtmcN/hnF+WB3AsTFXP/HQHPa8327750U0bniIZH7NuM7NPLh37FiY/axpBkoezFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489952; c=relaxed/simple;
	bh=KvrqYJJC3Sns7wN5xfHc67yfa6zJilW1pZURwkPXoKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=imaLxxMf8Jo/fWcZbLEvsVTNlwJmUUNMe4oZyoHlYcMiTBbXJK+8j4ceL2yFvGvsIinl/ooEVPCfOXEdyxHluudRZlPYcYBzvucGPLIWYyc8IwA0MTzj9NOMWIkkGnNISKn/XeOGG4C/j/JIwtubyjjL3NqI5YsbwkMoJjViJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZqmZO5Rs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AD9PSx2002157;
	Wed, 13 Nov 2024 03:25:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731489928;
	bh=Hp24S5i2Pk28DZAbH97tK+N9cfrs3EfX5xRbl8zmPhU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZqmZO5RsBxvo+4qr2dXzEc+EqGPlLi22GFzvqmn6osDgrAY0crlfj48wX9czk0sDv
	 G0JbqHiSD0copaGVEVzWk8/X/rk2p97KvTf1Mfcx+Jkr+41G8I+v1s3jfHr+Xg5M8q
	 wMRXkuRHlTOihLVH0q9iOKxcuQ192Th5hFWIjbs8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AD9PS9c125462
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Nov 2024 03:25:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Nov 2024 03:25:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Nov 2024 03:25:27 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AD9POIa087478;
	Wed, 13 Nov 2024 03:25:24 -0600
Message-ID: <32200597-9c02-4d43-bf91-3fe0b8ce83bc@ti.com>
Date: Wed, 13 Nov 2024 14:55:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in cpsw_mac_syscon node
To: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC: <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20241011110207.600678-1-c-vankar@ti.com>
 <b2dadb0a-fd85-42fc-b340-6c77fe5ded0a@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <b2dadb0a-fd85-42fc-b340-6c77fe5ded0a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 28/10/24 22:06, Vignesh Raghavendra wrote:
> 
> 
> On 11/10/24 16:32, Chintan Vankar wrote:
>> Add bootph-all property in CPSW MAC's eFuse node cpsw_mac_syscon.
>>
> 
> Why?
> 
> Please make sure commit message is verbose enough to say why the change
> is needed vs what that change is (latter is obvious lookng at the diff)
> 

Sure Vignesh. I will update the commit message accordingly in next
version.

>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on linux-next tagged next-20241011.
>>
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 44ff67b6bf1e..82d34dfb91ed 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -303,6 +303,10 @@ AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0) /* (C5/C6) WKUP_UART0_TXD */
>>   	};
>>   };
>>   
>> +&cpsw_mac_syscon {
>> +	bootph-all;
>> +};
>> +
>>   &wkup_uart0 {
>>   	/* WKUP UART0 is used by DM firmware */
>>   	bootph-pre-ram;
> 

