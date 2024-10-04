Return-Path: <linux-kernel+bounces-350267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40A99028A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645E9B23EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AE15990C;
	Fri,  4 Oct 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kKzyTUxo"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB681EB2E;
	Fri,  4 Oct 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042732; cv=none; b=XdLxMweRcpGAR107E/yDrObeRPczs5gxPS5gIGqILvdfTTNdIoJuNOnck2GLrMag7F0woNEdGCiI3xrXVgLyBhsYN0cbhqIIq8yE/UPTD5SmilGpuyzDmsz1T6I3YAbHOY1dokHrgJPPPo2FuzuzoeLtaCh7W1IhWphkdlv06bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042732; c=relaxed/simple;
	bh=hWoHkJL6/ppkfmK4zACz+qW8rTWSguxcAGrIsZm6vvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZOoUshSLhmKIykta9r3nk01jcyZbNemVTihyXRYCUZ16V7ucm42mKbdrxHdKPdjQBO4+kWaLGT6FmwZIXxtoAxoRAVoBDGlEB18pk1D799kctJTiZnJ5yTq4UTqotTyhWHH96rWzScmN22G5iwT1DhG1Y0bvYxIOgh3T5Yfqsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kKzyTUxo; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494Bq1aX007707;
	Fri, 4 Oct 2024 06:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728042721;
	bh=/G0/9klOANiuSTmUlDyon4pqC1c2O+4Sjsu2IjzZKGs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kKzyTUxo1ifyI9fHryy2mVBwAAl+N45eTMR8jBeJ7U2ZwmhMlJTCO+B5FNLftUEwv
	 +f+wg3jUKCAFAql1hRi7A5IbSeQjrY5NROLF6/tbcmqdS41W3doI5vmT6d1I6nF9zk
	 ycn+MPULGv0jroZ2yo9o8JE40XHo59osxwvat4RI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494Bq1OF073816;
	Fri, 4 Oct 2024 06:52:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 06:52:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 06:52:01 -0500
Received: from [128.247.81.173] (ula0226330.dhcp.ti.com [128.247.81.173] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494Bq1o8091091;
	Fri, 4 Oct 2024 06:52:01 -0500
Message-ID: <716e0d28-1735-45ac-9339-cde1cf14a8a1@ti.com>
Date: Fri, 4 Oct 2024 06:52:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] arm64: dts: ti: k3-am625-sk: Add M4F remoteproc
 node
To: Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241003170118.24932-1-afd@ti.com>
 <20241003170118.24932-3-afd@ti.com>
 <20241003210606.2k7wyssklwfziod4@bryanbrattlof.com>
 <20241004112637.nc2qcquiuwdhdrye@thirteen>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241004112637.nc2qcquiuwdhdrye@thirteen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/4/24 6:26 AM, Nishanth Menon wrote:
> On 16:06-20241003, Bryan Brattlof wrote:
>> Hi Andrew!
>>
>> On October  3, 2024 thus sayeth Andrew Davis:
>>> From: Hari Nagalla <hnagalla@ti.com>
>>>
>>> The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
>>> domain. This core can be used by non safety applications as a remote
>>> processor. When used as a remote processor with virtio/rpmessage IPC,
>>> two carveout reserved memory nodes are needed. The first region is used
>>> as a DMA pool for the rproc device, and the second region will furnish
>>> the static carveout regions for the firmware memory.
>>>
>>> The current carveout addresses and sizes are defined statically for
>>> each rproc device. The M4F processor does not have an MMU, and as such
>>> requires the exact memory used by the firmware to be set-aside.
>>>
>>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> index 44ff67b6bf1e4..6957b3e44c82f 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>> @@ -56,6 +56,18 @@ linux,cma {
>>>   			linux,cma-default;
>>>   		};
>>>   
>>> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
>>> +			compatible = "shared-dma-pool";
>>> +			reg = <0x00 0x9cb00000 0x00 0x100000>;
>>> +			no-map;
>>> +		};
>>> +
>>> +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
>>> +			compatible = "shared-dma-pool";
>>> +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
>>> +			no-map;
>>> +		};
>>> +
>>
>> The only issue I have here is this takes away memory from people who do
>> not use these firmware or causes them to work around this patch if they
>> choose to have different carveouts.
> 
> They can define their own overlays.
> 
>>
>> Would an overlay be appropriate for this?
> 
> Why is this any different from existing boards? Are you suggesting a
> change for all existing boards as well?
> 

Yes, I believe that is what is being suggested, and I agree with it.
It would also help with all these non-SK boards we now have, they
would simply apply the same overlay when using the firmware that
requires these carveouts.

I've been thinking on doing that for a while, but I wanted to keep
the same pattern just for this one last series. Then we can attempt
to refactor next.

Andrew

