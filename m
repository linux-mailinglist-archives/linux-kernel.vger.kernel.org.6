Return-Path: <linux-kernel+bounces-330522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E07E979F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43592285F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB315350B;
	Mon, 16 Sep 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sg6MUeb9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAA14F11E;
	Mon, 16 Sep 2024 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483503; cv=none; b=NItH/cFoUncj84dqP0YBCoKq4rYBKS/Dn+cfYGFe7NFgjpjrI9ltHxSGTeB02DDdXifz+jRHpYZBWTSi4CnvI6OKKb7aBMaDt79GOA6zaAcBWx4LMsJO5ID+j6NxgvjKS37h+b/IDzmW1wcnP73Ln4xQx5pAtXVmZpeDnHMTRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483503; c=relaxed/simple;
	bh=o59dL819fJ6zGURqdBqB42E/6GtUK2dTZjXgsYOPuRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i8YinulRLjyjy3g/Dut+6oMgn1/t4MwfVtWYA17wXsfubvD0FvY4C8/+P1HBmdwJm4F8TBqvVmEfFaJ4c0HaFPC3ecNFKuoHE4GcoB+MabV6iv3tija4BnHhbEUpBqlFEUoWdXaFFFUZeJq3spNySpY31sjyvxFku2AzU6ucxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sg6MUeb9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48GAimRJ034340;
	Mon, 16 Sep 2024 05:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726483488;
	bh=c41oU7Ad79H3UL8ipktVy6gBiXbYWMNfsad8ymFmWB4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sg6MUeb9qAyMtkogW1W2XJe83R8KoJ2LuesEjH/JX4M1UCyWS5mhhKaIwi8EaPVTQ
	 3y65i61ssLNO6vhrUaLZ9pXQSnw7cVdt6S4SFyiii6gYgU2bDTxgPOOHiGEQnaTzuY
	 o1r9FgipN0LqgwXwuv6SEIXg1SzDVodPBZHM+hbg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48GAimCe028539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Sep 2024 05:44:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 05:44:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 05:44:48 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48GAih9M129669;
	Mon, 16 Sep 2024 05:44:44 -0500
Message-ID: <9aedf384-207a-4eb7-a371-70bbe76ab5af@ti.com>
Date: Mon, 16 Sep 2024 16:14:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 regulators as bootph-all
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
        Enric Balletbo <eballetb@redhat.com>, Udit Kumar
	<u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com>
 <20240911-j784s4-tps6594-bootph-v2-1-a83526264ab1@redhat.com>
 <c4ace228-ea32-4760-b6af-f7555b68063a@ti.com>
 <zlgo4e5qwg352tsadvw43oj7vlekefuqe66ckokyo6aba47z6o@2wwbyrfjkstz>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <zlgo4e5qwg352tsadvw43oj7vlekefuqe66ckokyo6aba47z6o@2wwbyrfjkstz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 14/09/24 00:27, Andrew Halaney wrote:
> On Fri, Sep 13, 2024 at 04:27:47PM GMT, Beleswar Prasad Padhi wrote:
>> Hi Andrew,
>>
>> On 11/09/24 22:49, Andrew Halaney wrote:
>>> In order for the MCU domain to access this PMIC, a regulator
>>> needs to be marked appropriately otherwise it is not seen by SPL and
>>> therefore not configured.
>>>
>>> This is necessary if the MCU domain is to program the TPS6594 MCU ESM
>>> state machine, which is required to wire up the watchdog in a manner
>>> that will reset the board.
>>>
>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> index 6695ebbcb4d0..6ed628c2884e 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> @@ -663,6 +663,7 @@ tps659413: pmic@48 {
>>>    		regulators {
>>>    			bucka12: buck12 {
>>> +				bootph-all;
>>>    				regulator-name = "vdd_ddr_1v1";
>>>    				regulator-min-microvolt = <1100000>;
>>>    				regulator-max-microvolt = <1100000>;
>>
>> In my opinion, bootph-all property should come after other standard
>> properties like regulator-name etc., as it is least important to Linux. Same
>> comment for other nodes wherever applicable. What is your opinion?
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n130
> I think that does align better with the dts-coding-style doc!
>
> Looking at the tree though, the standard currently in the TI folder
> is to put it first. In my opinion if changing the ordering is desired
> it should be done in one fell swoop (outside this series). I'd do


There is a series[0] under review which takes care of this bootph- 
addition and order correction. In that series, looks like bootph- is 
placed at the end of the list of all standard properties. So, it is 
better if we align these patches to follow the same.

[0]: 
https://lore.kernel.org/all/20240814-b4-upstream-bootph-all-v4-2-f2b462000f25@ti.com/


Thanks,
Beleswar

> it one big patch, but I'm curious if that's decided the way forward what
> the TI maintainers would like to see. I can send that patch if desired.
>
> For now I think sticking with the current practice in this series
> makes sense until that fell swoop happens.
>
> Please let me know if you feel strongly otherwise.
>
> Thanks,
> Andrew
>

