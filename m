Return-Path: <linux-kernel+bounces-279045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EE94B83B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB04F1F2562A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF11891D9;
	Thu,  8 Aug 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O+XXULCd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8371891A8;
	Thu,  8 Aug 2024 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103389; cv=none; b=G/n0S3ivQBVINyRSD2VnA2u3E2/aIusEuC4Q5bZ3j8QV/cbkHTQRbhUEjoqWYKLOsA1NCwglblIhGpYuqx5GRQ95hFfx+EAxGQBfYOctyl1woIrHP6aMZQ+afukjTD8OQthYMjrN3RMIPkY0oPZnVw9WTAjN7IawYkI9qeG5TPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103389; c=relaxed/simple;
	bh=s8fY14FP2au4OI9Pd0PqlNL5+vnBAoXk/GyfNrqMLMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uGcT+VFtidj9e8UBGX2hFXNMRn91IIuG6XI7e4zZ6tOVluFz9SlCCJWyOIvQGDqcCtlJmNE9zrXuPFLzrkU5FFk1NhZORFoak0xPuOgHpZlag0VxxZZtQm8ncZL/wHYL7V56M9gT41J3+pHYfTV5vNxLxfOedpb6H7bAp9spOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O+XXULCd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4787ne2k082898;
	Thu, 8 Aug 2024 02:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723103380;
	bh=xcMuxQlqM4fwgDu27RoNo25IlIqXsjiIwi0e5ZtBcJQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=O+XXULCd6zkUJFNaUIIzuMGQ83eD9QE4j8cpTnbZyiHvIilJbbZZ+yQSrznfyklqC
	 wVoWRQ5AIN30ri2UuzesPRe+u1oCFdUKAmIXAcDIr7y0dpb5yanTbS2iiQJKK6lNcX
	 vdsKZ7Fl2r7se4P0PX7Zj78uXm7eqMdeI/2lX6i8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4787neD5091880
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 02:49:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 02:49:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 02:49:40 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4787naki016627;
	Thu, 8 Aug 2024 02:49:36 -0500
Message-ID: <2279305f-2efa-4320-866a-fc4340d2e70c@ti.com>
Date: Thu, 8 Aug 2024 13:19:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux
 for mmc1
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <m-chawdhry@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <sinthu.raja@ti.com>
References: <20240807101624.2713490-1-b-kapoor@ti.com>
 <8fa39624-9a92-404d-8651-9ade5700a7d3@ti.com>
 <1319a6ac-6784-45d6-8a0e-170e40d3aa18@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <1319a6ac-6784-45d6-8a0e-170e40d3aa18@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya

On 08/08/24 13:08, Bhavya Kapoor wrote:
> Hi Neha,
> 
> On 08/08/24 11:51 am, Neha Malcom Francis wrote:
>> Hi Bhavya
>>
>> On 07/08/24 15:46, Bhavya Kapoor wrote:
>>> mmc1 was not functional since pin mux for clklb was not present.
>>> Thus, add clklb pin mux to get MMC working.
>>>
>>> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK 
>>> base board")
>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>> ---
>>>
>>> rebased to next-20240807
>>>
>>>   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts 
>>> b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>> index 90dbe31c5b81..d5ceab79536c 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>>> @@ -204,6 +204,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
>>>           pinctrl-single,pins = <
>>>               J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
>>>               J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
>>> +            J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
>>>               J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
>>>               J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
>>>               J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
>>
>> How is this different from the P23 pinmux for MMC1_CLK? Could you explain what 
>> CLKLB is, since it doesn't have a ball number I'm finding it difficult to 
>> understand what it is?
>>
> This pin needs to be setup so that MMC_CLK is looped back at pad level for 
> highspeed SDIO operations (has been same across K3 family). MMC0/1 has this pin 
> configured as INPUT by reset default as these have boot media
> 
>   These pinmuxes are derived from pinmux file shared by EVM team during 
> wakeup/board bringup.
> 

Thank you for explaining.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

> Regards
> 

-- 
Thanking You
Neha Malcom Francis

