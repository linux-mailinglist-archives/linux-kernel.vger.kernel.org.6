Return-Path: <linux-kernel+bounces-269370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB48943222
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064A42816EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9331B3749;
	Wed, 31 Jul 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dPqui2rZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E981DDC9;
	Wed, 31 Jul 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436654; cv=none; b=rkL0xU7ynAozi2Imlw4vSykWUu/GqmCMsgz1WjPnCf2MZIQEaMHh0b+iV8UE2eA4oUWDnITpMDO46OqYLFNSEiuRZMCYbshl8YlSpCgjKA/oakUzqdygqR062jfBvGnWnH3ZBUwrM/G3nC5TSYgoi/8x226J43KkQL8Y4zbi9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436654; c=relaxed/simple;
	bh=gWEUBtkFKZ9RYmy9L6XrO/5e+6MR4sPM4fHH7iWE8/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKwXrzLQ6G3dG5eMRQuSmoshsYMcBhWgoMsduUWfUMSrZulADaG8V+aBEETBJEnnsFA3tvls8I9YB2vQPjqrdrN8zAegvGFWU6fc7lJjKlgMfveo/I7iGwyWnM6O56rKMVAf5JTL7LbT5GvuFIGcKpAeXK265BeznOuz2aRtzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dPqui2rZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VEbO72052518;
	Wed, 31 Jul 2024 09:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722436644;
	bh=QpzGqPZNogg7gfb8tMWXYKRLjjvoWBSL6FCUeY/FuoI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dPqui2rZu1RfCO16r3Ige6SnhRZsBQWrEtJInfEB4RrgUUOieoAUWKv0o+o6Mxbv4
	 kZAPzfG4HxvQnDnX0tPUpADZ2qKzppK8afgyXhNZ3MaumwECBMdk4ZTfRymEskgcyE
	 Z7VAg0JRd7/3t7+rHsHLmkJ5WLmgex3YqeGSeU6U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VEbOA6128110
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 09:37:24 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 09:37:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 09:37:24 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VEbNK2065889;
	Wed, 31 Jul 2024 09:37:24 -0500
Message-ID: <087ee9e2-50ec-4791-a534-b3ebbf594fe6@ti.com>
Date: Wed, 31 Jul 2024 09:37:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
 <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
 <20240730123343.mqafgpj4zcnd5vs4@plaything>
 <20240731041916.stcbvkr6ovd7t5vk@uda0497581>
 <20240731110607.7fb42mgcsf2apodv@unshaven>
 <20240731135714.p53lki7mihzxcyk2@uda0497581>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240731135714.p53lki7mihzxcyk2@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/31/24 8:57 AM, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 06:06-20240731, Nishanth Menon wrote:
>> On 09:49-20240731, Manorit Chawdhry wrote:
>>>>> + */
>>>>> +
>>>>> +#include "k3-j784s4.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +	model = "Texas Instruments K3 J742S2 SoC";
>>>>> +	compatible = "ti,j742s2";
>>>>> +
>>>>> +	cpus {
>>>>> +		cpu-map {
>>>>> +			/delete-node/ cluster1;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	/delete-node/ cpu4;
>>>>> +	/delete-node/ cpu5;
>>>>> +	/delete-node/ cpu6;
>>>>> +	/delete-node/ cpu7;
>>>>
>>>> I suggest refactoring by renaming the dtsi files as common and split out
>>>> j784s4 similar to j722s/am62p rather than using /delete-node/
>>>>
>>>
>>> I don't mind the suggestion Nishanth if there is a reason behind it.
>>> Could you tell why we should not be using /delete-node/?
>>>
>>
>> Maintenance, readability and sustenance are the reasons. This is a
>> optimized die. It will end up having it's own changes in property
>> and integration details. While reuse is necessary, modifying the
>> properties with overrides and /delete-nodes/ creates maintenance
>> challenges down the road. We already went down this road with am62p
>> reuse with j722s, and eventually determined split and reuse is the
>> best option. See [1] for additional guidance.
>>
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n189
> 
> Thank you for giving some reasoning, would do the needful!
> 

This refactor will require some interesting naming for the
common SoC files. Based on your name for the EVM, I'm guessing
you will go with

k3-j784s4-common.dtsi

included from the real k3-j784s4.dtsi and the new k3-j742s2.dtsi?

Too bad the Jacinto SoC names don't use a hierarchical naming. :(

J7<family><part><spin><etc>..

Andrew

> Regards,
> Manorit
> 
>>
>> -- 
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 

