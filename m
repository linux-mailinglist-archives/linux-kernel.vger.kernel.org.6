Return-Path: <linux-kernel+bounces-210992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5BC904BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E847F1F24D25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4016B729;
	Wed, 12 Jun 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="plq623oi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C0168C32;
	Wed, 12 Jun 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174453; cv=none; b=JDWMk/vjDWn3VdAg6e54TsTqorgn7T/9CGqSYRUlkYI6uO59/Ejf/VWXskWthw30vtGN0RKIRCzHpkOA06EsBEvR1LD9ds2xWjyRDVQ1zg0PQqE1dgv8HKNXuRkOE7Fg/OU6TejJGDvbu5Q7sMbd86SX5p5fjjd8POgG8yJ+p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174453; c=relaxed/simple;
	bh=uIxuLUvTAHQMVTpPyF8FWUcpoQLO6/UN31wQEKZaPds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EJ0C+o1RDhvrZB91Xm8wLwywDVNWMZz05uWUHuLDQASZQYrxZ/Fd1w5pz04bGvzzvX4vzT9Mt9As5RDEFF3TqH11J5REwhEmvsYhmdhvDv3+foaksHrhxXglMbRIQGlFj8hmpovaVpgz0MoBGT9oQyNoNaxIlsuV2fOUS2kc3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=plq623oi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C6eix5003900;
	Wed, 12 Jun 2024 01:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718174444;
	bh=8VMIIXUJyBrpNOdSsPyxLA2sTLO/OtQ6H46C+gZUzac=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=plq623oiKqSqHGS9BT9PygOx1ymGuFNRhflSTH1JCuX3x6ZtFfav6spkdWjEV3eit
	 yfWy68RYRhqIhdjs1K+nXLXwkZ7Hh+8ZKpJv8MiOV4SyfzgiO1avYIINFyH00dKL8y
	 KYPhqioAMw2W4K4lwjhJjDe/GKW6TpFLkPMiXUBk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C6eh8F119407
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 01:40:43 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 01:40:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 01:40:43 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C6eevm085130;
	Wed, 12 Jun 2024 01:40:41 -0500
Message-ID: <d8b802dc-e65c-4b76-bfe0-a5b5c9dad472@ti.com>
Date: Wed, 12 Jun 2024 12:10:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable main_uart5
Content-Language: en-US
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20240528093911.47786-1-b-kapoor@ti.com>
 <27a350e5-b3e0-427d-8897-89e1d34a4c00@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <27a350e5-b3e0-427d-8897-89e1d34a4c00@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all, please ignore this patch as main_uart5 needs to be kept 
reserved. I will send another patch for the same

regards

On 28/05/24 4:38 pm, Bhavya Kapoor wrote:
>
> On 28/05/24 3:09 pm, Bhavya Kapoor wrote:
>> main_uart5 node defined in the SoC dtsi file is incomplete
>> and will not be functional unless it is extended with pinmux
>> information at board integration level.
>>
>> Thus, add pinmux for main_uart5 in the board dts file and
>> enable it to make it functional.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
> Test Logs: 
> https://gist.github.com/a0498981/dc8b0cb670a5726eeb6c10f6de1f468e
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index bf3c246d13d1..e3892a6f2fab 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -18,6 +18,7 @@ / {
>>       aliases {
>>           serial0 = &wkup_uart0;
>>           serial2 = &main_uart0;
>> +        serial3 = &main_uart5;
>>           mmc0 = &sdhci0;
>>           mmc1 = &sdhci1;
>>       };
>> @@ -142,6 +143,14 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)    /* (B22) 
>> UART0_TXD */
>>           bootph-all;
>>       };
>>   +    main_uart5_pins_default: main-uart5-default-pins {
>> +        pinctrl-single,pins = <
>> +            J722S_IOPAD(0x0108, PIN_INPUT, 3)    /* (J27) UART5_RXD */
>> +            J722S_IOPAD(0x010c, PIN_OUTPUT, 3)    /* (H27) UART5_TXD */
>> +        >;
>> +        bootph-all;
>> +    };
>> +
>>       vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>>           pinctrl-single,pins = <
>>               J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) 
>> MMC2_CMD.GPIO0_70 */
>> @@ -240,6 +249,13 @@ &main_uart0 {
>>       bootph-all;
>>   };
>>   +&main_uart5 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&main_uart5_pins_default>;
>> +    status = "okay";
>> +    bootph-all;
>> +};
>> +
>>   &mcu_pmx0 {
>>         wkup_uart0_pins_default: wkup-uart0-default-pins {

