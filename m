Return-Path: <linux-kernel+bounces-324186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C1974915
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AAAB2490A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ADA4D8BC;
	Wed, 11 Sep 2024 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lk+VxBPW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA402C182;
	Wed, 11 Sep 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028708; cv=none; b=joFqQekh/8dIuF/o8kzCi/2eqHwPoMlCJcnkUkCy3RAhcnOiNgIAD++JEVneo3Q26/ZQxgZqrsC3A+qP91zqWQqp+yZqAZf7x5Zrw3MbYn3rtvL2RdyZOjPFhP3DBpOVOx6FvMBchrmytvxIKUqV0mkVeQxeU9LHqjMQtpc7UgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028708; c=relaxed/simple;
	bh=7VLTBjpky6igUftxdBDkTN5vDdOqTSmgO+QqBQQEono=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZWldtbOk+06zK2pDyslkhQL1cuIGXdJU12/k0pQDEAu4hvEE4uZfvYyMAX8tvKbXiXXVJyuvHlJZrzxkLiLiNQ7lri8hdusRBgHvPq7sA+KgaZLO1Rzs2hBUSBrs8mEBEYgtMGRyBQkWH8iMAYMG1VpeISfguMWbOcHf/HKaG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lk+VxBPW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B4Ohkt050176;
	Tue, 10 Sep 2024 23:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726028683;
	bh=qeo883kIG8MfQ5Wpr0jRy26jAgX7sEL8Vri37fZJQUQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lk+VxBPWJzqaQKHo4LGlazNuzQDd4fNjBMPzffdzCuiARfmVutJbuUsYOAoi3xDAi
	 pKU8moXmdJcUE+XI3MFG3ugijCnlJAFKlYiDdmgF15UFLjEHLtllWagUcqNaaYYxrr
	 0NbuWjt/6fU/SI8ZPpdU+UA9Xd2dMkoXDkVdfZnQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48B4Oh1v045219
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Sep 2024 23:24:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 23:24:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 23:24:42 -0500
Received: from [172.24.19.92] (lt5cd2489kgj.dhcp.ti.com [172.24.19.92])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B4OcGA043330;
	Tue, 10 Sep 2024 23:24:38 -0500
Message-ID: <2f36c165-1ec5-4af9-a2aa-9484a38d87d3@ti.com>
Date: Wed, 11 Sep 2024 09:54:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 and children as bootph-all
To: Andrew Halaney <ahalaney@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Keerthy
	<j-keerthy@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Eric Chanudet
	<echanude@redhat.com>,
        Enric Balletbo <eballetb@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
 <20240906-j784s4-tps6594-bootph-v1-1-c5b58d43bf04@redhat.com>
 <bd188c0d-9fa1-4350-8787-36af319c7930@ti.com>
 <4h4wm5jja4wadh6bmbouuxjvoai6cokqqgxsl4kmhurvqnd7tu@y65y5pakijpq>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <4h4wm5jja4wadh6bmbouuxjvoai6cokqqgxsl4kmhurvqnd7tu@y65y5pakijpq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 9/10/2024 10:50 PM, Andrew Halaney wrote:
> On Sat, Sep 07, 2024 at 11:04:50AM GMT, Kumar, Udit wrote:
>> Thanks for your patch Andrew
>>
>>
>> On 9/7/2024 2:51 AM, Andrew Halaney wrote:
>>> In order for the MCU domain to access this PMIC and its children in
>>> u-boot SPL, the nodes need to be marked appropriately otherwise they
>>> are not seen by SPL.
>>>
>>> This is necessary if the MCU domain is to program the TPS6594 MCU ESM
>>> state machine, which is required to wire up the watchdog in a manner
>>> that will reset the board.
>>>
>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> index 6695ebbcb4d0..044a428136df 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> @@ -642,6 +642,7 @@ eeprom@50 {
>>>    	};
>>>    	tps659413: pmic@48 {
>>> +		bootph-all;
>>>    		compatible = "ti,tps6594-q1";
>>>    		reg = <0x48>;
>>>    		system-power-controller;
>>> @@ -662,7 +663,10 @@ tps659413: pmic@48 {
>>>    		ldo4-supply = <&vsys_3v3>;
>>>    		regulators {
>>> +			bootph-all;
>>> +
>>>    			bucka12: buck12 {
>>> +				bootph-all;
>>
>> Add bootph in on regulator node should be enough,
>>
>> As I see SPL/u-boot does not need all nodes.
> Ahhh, I finally see now, all parents of a bootph-* node get that
> property. Makes sense.
>
> Would you rather see it in the regulators node, or all of the actual
> regulators (bucka12, buacka3... etc)?
>
> The former is all that's *needed* to get the PMIC ESM probing and
> programmed. The latter makes sense to me if we want to actual use the
> regulators in the future in that context... Doing just *one* of the
> regulators seems odd to me though, someone may want a different one,
> so if we describe one to SPL we may as well describe all.
>
> What are your thoughts?


For now, adding boothph for bucka12 regulator is enough

but other nodes may be needed in future so i suggest to keep in

all regulators nodes ( bucka12, buacka3... etc)


>

