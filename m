Return-Path: <linux-kernel+bounces-550249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37323A55D25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D031894339
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320B1519BC;
	Fri,  7 Mar 2025 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFnlFWQ0"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8547F4A;
	Fri,  7 Mar 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311322; cv=none; b=pTQD4fBcnvEk0eZn4V6ol/O/bSG5iEhK6j0+N282wHmC4fr7xMwi/f+v1tN4stg7u8dfQbiKvNSbaU+bwJ69yd/DyG3GQgrzMfmNK/t2MpB2tFOHNh9kv7iEoGeqgOCkSHtmpmFFT5VkRJLwdkGbFNVtK4I6rbZqzdFyqqvBa9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311322; c=relaxed/simple;
	bh=iwmBdA0oZSZkpdZGUsHAyC8ykDesg/5Gu2d76aTgTys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J7TSQl9ZtAyRRjeCyPXPamTFnzTdPC+wC6ZKnC/fT+uD30t1mV9TDNzR1h3Ebc2NlD2MJrgbmtNhMm5QMDGVptAtDo1jTq7c13X+dNcMJ+1YHHBBjP94e/kiXrp9pKVDcblhDYCMZjhmY1zpIk6j7OSZWDCrmqvlJfX8laQwCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MFnlFWQ0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5271Z5dF3909116
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 19:35:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741311305;
	bh=65QJNz0IzEjYe1Hc+vKnbWORuc7bbdrHpqTtP+HxPT0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MFnlFWQ0d9WQ8c6y4bWgCqFMkZgjxxAjPOKp0+4ijcT+nxIDfuohEFS4Trpdfok5j
	 BlR8nqgIMgVYqnMqZGvdWBsw4BBgRacxKwwkX13ktHH5j6CHx49WEa5sdWupBd5ZEg
	 7w4z9GESzo+uoouisHcCJjQp27+at/chphB9b2Bk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5271Z58X030946
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 19:35:05 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Mar 2025 19:35:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Mar 2025 19:35:04 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5271Z44t096721;
	Thu, 6 Mar 2025 19:35:04 -0600
Message-ID: <db72b7f7-0771-442c-91bf-507a3e08cfdc@ti.com>
Date: Thu, 6 Mar 2025 19:35:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] arm64: dts: ti: k3-am62p5-sk: Enable IPC with
 remote processors
To: Devarsh Thakkar <devarsht@ti.com>, Andrew Davis <afd@ti.com>,
        Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hari Nagalla
	<hnagalla@ti.com>,
        Soumya <s-tripathy@ti.com>,
        "'Krishnamoorthy, Venkatesan'"
	<v-krishnamoorthy@ti.com>,
        "Khasim, Syed Mohammed" <khasim@ti.com>,
        "Bajjuri,
 Praneeth" <praneeth@ti.com>
References: <20250210221530.1234009-1-jm@ti.com>
 <20250210221530.1234009-7-jm@ti.com>
 <04e77daf-e775-44fa-82bf-8b6ebf73bcef@ti.com>
 <787f9d24-25bc-4171-bd8a-88fe9cef694d@ti.com>
 <64fa3794-e36b-2f77-ff8e-3c2ede3c3927@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <64fa3794-e36b-2f77-ff8e-3c2ede3c3927@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Devarsh,

On 2/27/25 6:05 AM, Devarsh Thakkar wrote:
> Hi Judith,
> 
> Thanks for the patch.
> 
> On 18/02/25 23:21, Judith Mendez wrote:
>> Hi Andrew,
>>
>>
>> On 2/18/25 10:38 AM, Andrew Davis wrote:
>>> On 2/10/25 4:15 PM, Judith Mendez wrote:
>>>> From: Devarsh Thakkar <devarsht@ti.com>
>>>>
>>>> For each remote proc, reserve memory for IPC and bind the mailbox
>>>> assignments. Two memory regions are reserved for each remote processor.
>>>> The first region of 1MB of memory is used for Vring shared buffers
>>>> and the second region is used as external memory to the remote processor
>>>> for the resource table and for tracebuffer allocations.
>>>>
>>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>> Changes since v4:
>>>> - Drop SRAM node for am62px MCU R5fSS0 core0
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 50 ++++++++++++++++++++++---
>>>>    1 file changed, 44 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> index ad71d2f27f538..9609727d042d3 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>>>> @@ -48,6 +48,30 @@ reserved-memory {
>>>>            #size-cells = <2>;
>>>>            ranges;
>>>> +        mcu_r5fss0_core0_dma_memory_region:
>>>> mcu-r5fss-dma-memory-region@9b800000 {
>>>> +            compatible = "shared-dma-pool";
>>>> +            reg = <0x00 0x9b800000 0x00 0x100000>;
>>>> +            no-map;
>>>> +        };
>>>> +
> 
> I believe you are testing these carveouts against the default firmwares
> shipped with AM62P SDK (compiled from meta-arago), With the same firmwares,
> each remote core also does inter-processor communication with each other
> (RTOS<->RTOS) on bootup, so you need to reserve the regions for the same too
> as done here [1].

This is how I originally had the patch Devarsh, if you see earlier
review, we removed the SRAM nodes and the rtos-to-rtos memory carveouts.


> 
>>>> +        mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
>>>> +            compatible = "shared-dma-pool";
>>>> +            reg = <0x00 0x9b900000 0x00 0xf00000>;
>>>> +            no-map;
>>>> +        };
>>>> +
>>>> +        wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
>>>> +            compatible = "shared-dma-pool";
>>>> +            reg = <0x00 0x9c800000 0x00 0x100000>;
>>>> +            no-map;
>>>> +        };
>>>> +
>>>> +        wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
>>>> +            compatible = "shared-dma-pool";
>>>> +            reg = <0x00 0x9c900000 0x00 0x1e00000>;
>>>
>>> 0x1e00000?
>>>
>>> Yes I know you didn't add this and are just coping it from below, but it
>>> is still an issue. I see the same problem for the next patch, the R5F memory
>>> size is 0xc00000??
>>>
>>> Every remote core gets 15MB (0xf00000), this has been true for all K3, and
>>> all cores, DSP, R5F, M4, etc.. You even do it correct for the MCU R5F above,
>>> but the WKUP R5F on AM62P and AM62 are just randomly given 30M and 12MB?
>>
>> Not sure why FW requires 30MB here, I have reached out to FW team to
>> investigate this, will respond back here soon.
>>
> 
> You will need an alignment with the firmware team to make sure that it doesn't
> break with the default firmwares shipped with the AM62Px SDK. Also just FYI,
> this will leave a gap of 14 MiB between the wakeup R5 and the next component
> i.e. ATF, ideally we should have avoided this gap but seems like ATF nodes are
> already upstream [2], so probably can't do much, nevertheless I hope that 14
> MiB will be claimed/used by Linux in some manner.

I did a sanity boot test with the default firmwares shipped for am62px
SDK, no error with am62px boot so far. Changes are: removed SRAM node, 
reduced wkup r5 memory carveout, no rtos-to-rtos memory carveout).

But I realize this is not a complete test. I believe there may be
potentially memory corruption with these changes if all implemented.

Andrew, I am not sure we are going in a good direction here, unless we
have a different reduced/fixed FW in the am62px SDK, we may have memory
corruption issues on our hands.

~ Judith


> 
> Soumya,
> Please provide an ACK for this, if the DM R5 firmware is exceeding 15 MiB,
> then you will need to update your linker scripts and regenerate the ipc echo
> test firmwares to make sure the wakeup R5 code/data does not exceed to what is
> being proposed here (15 MiB).
> 
> [1]:
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts?h=11.00.05#n72
> 
> [2]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts?h=next-20250227#n51
> 
> Regards
> Devarsh


