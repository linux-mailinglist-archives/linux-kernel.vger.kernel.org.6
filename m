Return-Path: <linux-kernel+bounces-286551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AF951C64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691CA1C2301A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1D1B150A;
	Wed, 14 Aug 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r4G1ysX5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580BC148;
	Wed, 14 Aug 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643969; cv=none; b=uezaDpObS+RrPYAIHfm9eS7XXcrrVp62I3RJdP5biyCz5c3UloLyu1VOXpgzLR2iRor1jAvCi30r7daac/bBtsWKHFYvnxbH4uH90UMWas6tdotlyCFCmfhHgar2RnNPM3Ue0U1/zVdAZ75O/CDdlko5V8TFUg9U5doACwO+m2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643969; c=relaxed/simple;
	bh=eresiUV05oJ03ZxQXDx5eDB//C8s/+2nKuI+JT5al7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQAnDfKLW4R0apYKmmdHhx7EjNH6lPc+UGr0799KZa1Tsrtgd1YQP1KEeF4pV7OWLhQy72Ulkgcu+sjxAtYr2t3CElCtCdEtpY3YAAw/9hbxgKYeU83tYyvCsEzd7h/PlhsIDI8fV0WsBoe6wRMMkWDZD6L/nO5GYtdOQglxzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r4G1ysX5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EDxF0E066840;
	Wed, 14 Aug 2024 08:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723643955;
	bh=7lNRzDbzANYCfAVIqAPp0GsNMJXVw4S+liQhK+NUegg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=r4G1ysX5KcCPD5uLqF6fMTCxIdgjEID182QLKd22TBcK1gpXPUTRUEC8/9tGw5YiA
	 D7qChHO0Vs8TGAdAnY27/nGGZ/+l0AQ+neeFixyRFse0tXyNzpN5TUI63uZpiMG12M
	 WwpPNEoJLjlTX4+MVS9sJB1LMYtkzC2vYuVumNas=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EDxFKg012112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 08:59:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 08:59:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 08:59:15 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EDxFe8102447;
	Wed, 14 Aug 2024 08:59:15 -0500
Message-ID: <6134b3c1-f7ea-4cca-8777-56e5705aadf6@ti.com>
Date: Wed, 14 Aug 2024 08:59:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add and fix ESM nodes
To: Jan Kiszka <jan.kiszka@siemens.com>, <devicetree@vger.kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>
References: <20240813230312.3289428-1-jm@ti.com>
 <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jan,

On 8/13/24 11:04 PM, Jan Kiszka wrote:
> On 14.08.24 01:03, Judith Mendez wrote:
>> The following patch adds ESM nodes and fixes ESM source
>> interrupts for Sitara K3 platforms. Currently watchdog cannot
>> reset the CPU because of misconfiguration or missing ESM node
>> in DT.
>>
>> ESM node was added for am62ax and am65x. For am62px ESM source
>> interrupts are fixed. Comments were also added for clarity on what
>> source interrupts are routed to ESM based on device TRM.
>>
>> ESM nodes like MCU ESM for am65x are added for device completion,
>> currently, some ESM0 events are not routed to MCU ESM, so watchdog
>> cannot reset the CPU using the current implementation.
> 
> Yes, that's why there is https://github.com/siemens/k3-rti-wdt and
> probably similar bits in other R5 firmware. I was always told that is
> the only way to reset the /system/ (CPU alone would not help). That
> information is still correct?

If you look at 9.4.14 MCU_ESM0 Interrupt Map, ESM0_ESM_INT_CFG_LVL_0,
ESM0_ESM_INT_HI_LVL_0, and ESM0_ESM_INT_LOW_LVL_0 are not routed to
MCU_ESM0. So the current implementation to route events from ESM0 to
MCU_ESM0 to reset the CPU will not work for AM65x, this is the
implementation on other K3 Sitara platforms and how watchdog can reset
the cpu.

I did find MAIN_ESM_ERROR_INT which should be SOC_SAFETY_ERRORn, look
at Figure 12-3690. Perhaps the ESMs could be configured to use
SOC_SAFETY_ERRORn instead, not sure.

The above should apply to both SR1 and SR2 devices according to the TRM.

~ Judith

> 
> Jan
> 
>>
>> Changes since v1:
>> - Remove watchdog patch
>> - Add am64x patch 5/6
>> - Add am65x patch 6/6
>> - Add missing bootph flag
>>
>> Judith Mendez (5):
>>    arm64: dts: ti: k3-am62a: Add ESM nodes
>>    arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
>>    arm64: dts: ti: k3-am62: Add comments to ESM nodes
>>    arm64: dts: ti: k3-am64: Add more ESM interrupt sources
>>    arm64: dts: ti: k3-am65: Add ESM nodes
>>
>> Santhosh Kumar K (1):
>>    arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
>>
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
>>   arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                | 1 +
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 8 ++++++++
>>   arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi               | 8 ++++++++
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 4 ++--
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 ++-
>>   arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                | 3 ++-
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi               | 8 ++++++++
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                | 8 ++++++++
>>   10 files changed, 42 insertions(+), 5 deletions(-)
>>
>>
>> base-commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d
> 


