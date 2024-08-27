Return-Path: <linux-kernel+bounces-302556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44848960037
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33071F23190
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01F45028;
	Tue, 27 Aug 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U09XgPgp"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90917736;
	Tue, 27 Aug 2024 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731921; cv=none; b=oMWPz6udCEgN87C+m5EejEZuWD0OSSBsNXJ9AE/diBFm5vyABqErnd2MYExb2beFyUWk9AZUNA6KeZzdAgoizs0O8t8kH9J/fQkRKiNYQBA0IZqs0VjrhNIWnvXscj18MkuzD/AE7TLj8/O1D2KUimNvGKh2M99ka3s4Bcd3VNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731921; c=relaxed/simple;
	bh=R7+rr4IFOkDDC68258FOanKKCM+e0YIAKpgqz276MEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YSEdKGqWFUWMj+NuzcXm8/b/n4iYOMAdHo3fx9AwI7ZnVew9NNSpzzQsPra6pmcKh0D6R5uGbLWOncyaLBqH7ln8HnQ5pb7zgg9qz2rGmiFDCSY9fB7RYkMl9QAnLSbJJip6UwMJYSBqxv01uaRUxclYAvXyuOWIoBx0ddzsxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U09XgPgp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R4BmrC092175;
	Mon, 26 Aug 2024 23:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724731908;
	bh=KavFqkvjazdMpxeCK83iCyZmnAnVP4EjnBVrA+hIfak=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=U09XgPgpREG2XfEAbonaqnFZ2khDIHSFW/KU48pCPgKVEe9uTl2eg10qaPHIHXCi/
	 bGMee7XxhQzgx0NquTmxc86Q0PrwPQ9ZnN15sXjeTWe7NkSXb3ScgEib4nZWZhoflV
	 xaHl8UzPSuMbC1KRL2Q0Ijsd/MOh+TD1mG8yqahw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R4BmoT107182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 23:11:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 23:11:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 23:11:48 -0500
Received: from [172.24.19.209] (lt5cd2489kgj.dhcp.ti.com [172.24.19.209])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R4Bi5h122509;
	Mon, 26 Aug 2024 23:11:44 -0500
Message-ID: <616bfcfa-ca5a-43c8-b778-cfe654923da1@ti.com>
Date: Tue, 27 Aug 2024 09:41:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
To: Eric Chanudet <echanude@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, J Keerthi
	<j-keerthy@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney
	<ahalaney@redhat.com>,
        <u-kumar1@ti.com>
References: <20240805174330.2132717-2-echanude@redhat.com>
 <wiyw7h7hkc7u2brehi6zgxykesajtqmwwajo7tpwwvayjtcykw@w7rcmojs62vi>
 <f42f092f-2199-4cbd-8cad-96ccf4f100d0@ti.com>
 <xlmi5cm4lcnohz3glzzxqtffrbletvsos2i2l2ytr55yjnwl33@fae24t7xvzj7>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <xlmi5cm4lcnohz3glzzxqtffrbletvsos2i2l2ytr55yjnwl33@fae24t7xvzj7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Eric

On 8/27/2024 3:50 AM, Eric Chanudet wrote:
> On Mon, Aug 26, 2024 at 11:53:56PM GMT, Kumar, Udit wrote:
>> Hello Eric
>>
>> On 8/21/2024 3:31 AM, Eric Chanudet wrote:
>>> On Mon, Aug 05, 2024 at 01:42:51PM GMT, Eric Chanudet wrote:
>>>> ---
>>>> I could not get the watchdog to do more than reporting 0x32 in
>>>> RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
>>>> interrupt (0x5) didn't trigger a reset either when the window expired.
>>> Re-testing using u-boot from the BSP (2023.04) has the board reset as
>>> expected when the watchdog expires and WDIOC_GETTIMELEFT report the time
>>> left coherently with this patch until that happens.
>>>
>>> I initially had a u-boot with a DT lacking:
>>> 	"mcu_esm: esm@40800000"
>>> and I could reproduce the board not resetting by commenting in its
>>> description:
>>> 	"ti,esm-pins = <95>;"
>>>
>>> I don't understand why that is on the other hand. The TRM says ESM0
>>> ERR_O drives the SOC_SAFETY_ERRORn pin, which goes to the PMIC GPIO3 on
>>> the schematic _and_ to MCU_ESM0 as an error input event. The tps6594-esm
>>> module is probing successfully and it sets both ESM_SOC_EN|ESM_SOC_ENDRV
>>> and ESM_SOC_START, so I would expect the PMIC to reset the board without
>>> MCU_ESM0 being described or configured by u-boot.
>> AFAIK, Keerthy correct me. GPIO-7 of PMIC should reset the boards.
> That is what I'm seeing too, MCU_ESM0 is able to reset the board.
>
>> If you see figure 5-27 of TRM then SOC_SAFETY_ERRORn goes to GPIO-3 of
>> PMIC (schematic)
>>
>> Same time this is cascaded to MCU-ESM and WKUP-ESM to generate
>> MCU_SAFETY_ERRORn (from Wkup_ESM)
>>
>> and MCU_SAFETY_ERRORn is connected to GPIO-7.
> Agreed (Figure 5-25, in TRM "SPRUJ52" for J784S4).
>
>> Unlike other device J721E (for reference)
>>
>> SOC_SAFETY_ERRORn is generated by Main ESM and MCU_SAFETY_ERRORn can be
>> generated by WKUP_ESM and main_ESM.
>>
>> Please look at schematic of J721E SOM [0], both SOC_SAFETY_ERRZ and
>> MCU_SAFETY_ERRZ both are connected to GPIO-7 of PMIC.
>>
>> So on this device and board, only main ESM configuration is working for us.
>>
>> [0] https://www.ti.com/tool/J721EXSOMXEVM#tech-docs
> Sure, but I am using J784S4[1] and the schematic of that board
> (PROC141E4(001)_SCH) shows SOC_SAFETY_ERRZ going to PMIC GPIO3.
>
> So when u-boot _does not_ configure MCU_ESM0 chaining through pin95, I
> would still expect the board to reboot, because ESM0 raised
> SOC_SAFETY_ERRORn on TPS6594 GPIO3 which should reset the board. Yet
> that does not seem to happen.

I think, we are saying same thing .

Reset is happening with GPIO-7 pin of PMIC not with GPIO-3 PIN.


> [1] https://www.ti.com/tool/J784S4XEVM#tech-docs
>
> On Mon, Aug 26, 2024 at 11:48:34AM GMT, Andrew Halaney wrote:
>> rti0 ---> ESM0 pin 688 --SOC_SAFETY_ERRORn--> TPS6594 GPIO3
>> 				|
>> 				|
>> 				--> MCU_ESM0 pin 95 --> WKUP_ESM0 pin 63 --MCU_SAFETY_ERRORn--> TPS6584 GPIO7
> Using Andrew's drawing as it matches my understanding as well. So the
> PMIC should reset the board even if MCU_ESM0 isn't configured with pin95
> to chain SOC_SAFETY_ERRORn.
>
> Am I misunderstanding this?


I am not PMIC expert,

but based upon my results on other SOC/EVM. SOC_SAFETY_ERRORn signal can 
reset the board, if this is connected with GPIO-7 pin of PMIC.


>
> As well, since it is mentioned in Andrew's reply:
>
> On Mon, Aug 26, 2024 at 11:48:34AM GMT, Andrew Halaney wrote:
>> did you ensure that ESM0 was programmed in this test? Right now if
>> you're using upstream u-boot and upstream linux, nobody seems to be
>> configured by default to do that
> I am using the BSP u-boot (2023.04-f9b966c674) for this test, which has
> CONFIG_ESM_K3=y and esm@700000's description with pin688.
>
> Best,
>

